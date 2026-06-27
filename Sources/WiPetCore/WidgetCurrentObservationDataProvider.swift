import Foundation

public enum WidgetCurrentObservationDataSourceResult: Equatable, Sendable {
    case shared(Data)
    case fallback(Data?)

    public var data: Data? {
        switch self {
        case let .shared(data):
            data
        case let .fallback(data):
            data
        }
    }

    public var usesFallbackData: Bool {
        switch self {
        case .shared:
            false
        case .fallback:
            true
        }
    }
}

public enum WidgetCurrentObservationDataProvider {
    public static func currentObservationSourceResult(
        from defaults: UserDefaults?,
        fallbackData: Data?
    ) -> WidgetCurrentObservationDataSourceResult {
        currentObservationSourceResult(
            sharedData: defaults?.data(forKey: WidgetSharedDataKeys.currentObservationJSON),
            fallbackData: fallbackData
        )
    }

    public static func currentObservationSourceResult(
        sharedData: Data?,
        fallbackData: Data?
    ) -> WidgetCurrentObservationDataSourceResult {
        guard
            let sharedData,
            WidgetPetObservationHandoffReader.currentObservation(from: sharedData).payload != nil
        else {
            return .fallback(fallbackData)
        }

        return .shared(sharedData)
    }

    public static func currentObservationData(
        from defaults: UserDefaults?,
        fallbackData: Data?
    ) -> Data? {
        currentObservationSourceResult(
            from: defaults,
            fallbackData: fallbackData
        ).data
    }

    public static func currentObservationData(
        sharedData: Data?,
        fallbackData: Data?
    ) -> Data? {
        currentObservationSourceResult(
            sharedData: sharedData,
            fallbackData: fallbackData
        ).data
    }
}
