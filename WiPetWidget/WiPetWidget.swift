import SwiftUI
import WidgetKit
import WiPetCore

struct WiPetWidgetEntry: TimelineEntry {
    let date: Date
    let observation: WidgetPetObservation
}

struct WiPetWidgetProvider: TimelineProvider {
    private let widgetObservationFactory = WiPetWidgetObservationFactory()

    func placeholder(in context: Context) -> WiPetWidgetEntry {
        placeholderObservationEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (WiPetWidgetEntry) -> Void) {
        completion(snapshotObservationEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WiPetWidgetEntry>) -> Void) {
        completion(currentObservationTimeline())
    }

    private func placeholderObservationEntry() -> WiPetWidgetEntry {
        currentObservationEntry()
    }

    private func snapshotObservationEntry() -> WiPetWidgetEntry {
        currentObservationEntry()
    }

    private func currentObservationTimeline() -> Timeline<WiPetWidgetEntry> {
        let currentObservationEntry = currentObservationEntry()
        return Timeline(entries: [currentObservationEntry], policy: .after(nextObservationRefreshDate()))
    }

    private func currentObservationEntry() -> WiPetWidgetEntry {
        WiPetWidgetEntry(date: Date(), observation: widgetObservationFactory.currentObservation())
    }

    private func nextObservationRefreshDate() -> Date {
        Date().addingTimeInterval(observationRefreshInterval)
    }

    private var observationRefreshInterval: TimeInterval {
        60 * 30
    }
}

struct WiPetWidgetObservationFactory {
    func currentObservation() -> WidgetPetObservation {
        observation(from: currentHandoffSourceResult())
    }

    func currentHandoffSourceResult() -> WidgetPetObservationPayloadSourceResult {
        WidgetPetObservationHandoffReader.currentObservation(
            from: currentAppGroupObservationSourceResult().data
        )
    }

    private func currentAppGroupObservationSourceResult() -> WidgetCurrentObservationDataSourceResult {
        WidgetCurrentObservationDataProvider.currentObservationSourceResult(
            from: UserDefaults(suiteName: WidgetSharedDataKeys.appGroupIdentifier),
            fallbackData: temporaryAppGroupFallbackData()
        )
    }

    private func temporaryAppGroupFallbackData() -> Data? {
        try? temporaryAppGroupFallbackPayload().encodeJSON()
    }

    private func temporaryAppGroupFallbackPayload() -> WidgetPetObservationTransferPayload {
        WidgetPetObservationTransferPayload(observation: WiPetWidgetLumaFixture.observation)
    }

    func observation(from handoffSourceResult: WidgetPetObservationPayloadSourceResult) -> WidgetPetObservation {
        guard !handoffSourceResult.requiresFallbackObservation else {
            return WiPetWidgetLumaFixture.observation
        }

        return handoffSourceResult.payload?.observation ?? WiPetWidgetLumaFixture.observation
    }
}

struct WiPetWidgetEntryView: View {
    let entry: WiPetWidgetEntry

    var body: some View {
        WiPetWidgetObservationContentView(
            observation: entry.observation,
            lineageCueDisplayMode: .compactWhenDiscoveryFits(
                maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
            )
        )
        .padding(16)
        .containerBackground(for: .widget) {
            LinearGradient.wiPetWidgetObservationBackground
        }
    }
}

@main
struct WiPetWidget: Widget {
    let kind = WidgetSharedDataKeys.widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WiPetWidgetProvider()) { entry in
            WiPetWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("WiPet")
        .description("A quiet window into your current WiPet.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WiPetWidget()
} timeline: {
    WiPetWidgetPreviewFixtures.runtimeCurrentObservationEntry
}

#Preview("App-written Handoff Luma Small", as: .systemSmall) {
    WiPetWidget()
} timeline: {
    WiPetWidgetPreviewFixtures.appWrittenLumaHandoffEntry
}

#Preview("Fallback Luma Small", as: .systemSmall) {
    WiPetWidget()
} timeline: {
    WiPetWidgetPreviewFixtures.fallbackLumaEntry
}

#Preview("App-written Handoff Luma Medium", as: .systemMedium) {
    WiPetWidget()
} timeline: {
    WiPetWidgetPreviewFixtures.appWrittenLumaHandoffEntry
}

#Preview("Fallback Luma Medium", as: .systemMedium) {
    WiPetWidget()
} timeline: {
    WiPetWidgetPreviewFixtures.fallbackLumaEntry
}

private enum WiPetWidgetPreviewFixtures {
    static var runtimeCurrentObservationEntry: WiPetWidgetEntry {
        entry(observation: WiPetWidgetObservationFactory().currentObservation())
    }

    static var appWrittenLumaHandoffEntry: WiPetWidgetEntry {
        entry(observation: appWrittenLumaHandoffObservation)
    }

    static var fallbackLumaEntry: WiPetWidgetEntry {
        entry(observation: fallbackLumaObservation)
    }

    private static var appWrittenLumaHandoffObservation: WidgetPetObservation {
        observationFromHandoffPayloadData(try? appWrittenLumaHandoffPayload.encodeJSON())
    }

    private static var appWrittenLumaHandoffPayload: WidgetPetObservationTransferPayload {
        WidgetPetObservationTransferPayload(observation: WiPetWidgetLumaFixture.observation)
    }

    private static var fallbackLumaObservation: WidgetPetObservation {
        WiPetWidgetObservationFactory().observation(from: .missing)
    }

    private static func entry(observation: WidgetPetObservation) -> WiPetWidgetEntry {
        WiPetWidgetEntry(date: Date(), observation: observation)
    }

    private static func observationFromHandoffPayloadData(_ data: Data?) -> WidgetPetObservation {
        let handoffSourceResult = WidgetPetObservationHandoffReader.currentObservation(from: data)
        return WiPetWidgetObservationFactory().observation(from: handoffSourceResult)
    }
}

private enum WiPetWidgetLumaFixture {
    static var observation: WidgetPetObservation {
        var creature = Creature(
            name: "Luma",
            species: .lunarian,
            genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
            growthStage: .juvenile,
            generation: 3
        )
        creature.recordDiscovery(
            title: "The floating tail shimmer resembles the first ancestor.",
            kind: .inheritedResemblance,
            stage: .juvenile
        )
        return WidgetPetObservation(creature: creature, mood: "Dreamy", ageLabel: "12 days")
    }
}
