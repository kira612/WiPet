import Foundation
import WidgetKit
import WiPetCore

enum WidgetCurrentObservationHandoffResult: Equatable {
    case published(reloadedWidgetKind: String)
    case failedToWrite

    var readinessSummary: String {
        switch self {
        case let .published(reloadedWidgetKind):
            "widgetHandoffPublished:true,reloadedWidgetKind:\(reloadedWidgetKind)"
        case .failedToWrite:
            "widgetHandoffPublished:false,reloadedWidgetKind:none"
        }
    }

    var hasReadySummary: Bool {
        let summary = readinessSummary
        return !summary.isEmpty
            && summary.contains("widgetHandoffPublished:")
            && summary.contains("reloadedWidgetKind:")
    }
}

struct WidgetCurrentObservationHandoffCoordinator {
    var sharedDefaults: () -> UserDefaults?
    var reloadWidgetTimelines: (String) -> Void

    init(
        sharedDefaults: @escaping () -> UserDefaults? = {
            UserDefaults(suiteName: WidgetSharedDataKeys.appGroupIdentifier)
        },
        reloadWidgetTimelines: @escaping (String) -> Void = { widgetKind in
            WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
        }
    ) {
        self.sharedDefaults = sharedDefaults
        self.reloadWidgetTimelines = reloadWidgetTimelines
    }

    @discardableResult
    func publishCurrentObservation(for creature: Creature) -> WidgetCurrentObservationHandoffResult {
        let observation = WidgetPetObservation(
            creature: creature,
            mood: "Dreamy",
            ageLabel: "12 days"
        )
        let result = WidgetCurrentObservationDataWriter.writeCurrentObservation(
            observation,
            to: sharedDefaults()
        )

        if result == .written {
            let widgetKind = WidgetSharedDataKeys.widgetKind
            reloadWidgetTimelines(widgetKind)
            return .published(reloadedWidgetKind: widgetKind)
        }

        return .failedToWrite
    }
}
