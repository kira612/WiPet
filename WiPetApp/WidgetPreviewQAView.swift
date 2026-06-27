import SwiftUI
import WiPetCore

struct WidgetPreviewQAView: View {
    private let longObservation: WidgetPetObservation
    private let shortObservation: WidgetPetObservation
    private let ordinaryObservation: WidgetPetObservation
    private let growthAdvancementObservation: WidgetPetObservation
    private let readiness: WidgetPreviewQAReadiness

    init(
        longObservation: WidgetPetObservation = WidgetPreviewQAView.longAncestorObservation,
        shortObservation: WidgetPetObservation = WidgetPreviewQAView.shortAncestorObservation,
        ordinaryObservation: WidgetPetObservation = WidgetPreviewQAView.ordinaryDiscoveryObservation,
        growthAdvancementObservation: WidgetPetObservation = WidgetPreviewQAView.growthAdvancementObservation
    ) {
        self.longObservation = longObservation
        self.shortObservation = shortObservation
        self.ordinaryObservation = ordinaryObservation
        self.growthAdvancementObservation = growthAdvancementObservation
        self.readiness = WidgetPreviewQAReadiness(
            longMemoryCueLine: longObservation.text.memoryCueLine,
            shortMemoryCueLine: shortObservation.text.memoryCueLine,
            ordinaryMemoryCueLine: ordinaryObservation.text.memoryCueLine,
            growthAdvancementMemoryCueLine: growthAdvancementObservation.text.memoryCueLine,
            longObservationWindowLabel: longObservation.text.observationWindowAccessibilityLabel(
                displayedLineageCueLine: longObservation.text.lineageCueCompactLineWhenDiscoveryFits(
                    maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
                )
            ),
            shortObservationWindowLabel: shortObservation.text.observationWindowAccessibilityLabel(
                displayedLineageCueLine: shortObservation.text.lineageCueCompactLineWhenDiscoveryFits(
                    maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
                )
            ),
            ordinaryObservationWindowLabel: ordinaryObservation.text.observationWindowAccessibilityLabel(
                displayedLineageCueLine: ordinaryObservation.text.lineageCueCompactLineWhenDiscoveryFits(
                    maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
                )
            ),
            growthAdvancementObservationWindowLabel: growthAdvancementObservation.text.observationWindowAccessibilityLabel(
                displayedLineageCueLine: growthAdvancementObservation.text.lineageCueCompactLineWhenDiscoveryFits(
                    maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
                )
            ),
            longSelectiveCueState: WidgetPreviewQAReadiness.selectiveCueState(
                for: longObservation.text
            ),
            shortSelectiveCueState: WidgetPreviewQAReadiness.selectiveCueState(
                for: shortObservation.text
            ),
            ordinarySelectiveCueState: WidgetPreviewQAReadiness.selectiveCueState(
                for: ordinaryObservation.text
            ),
            growthAdvancementSelectiveCueState: WidgetPreviewQAReadiness.selectiveCueState(
                for: growthAdvancementObservation.text
            ),
            loadedSourceState: WidgetPetObservationPayloadSourceResult
                .loaded(WidgetPetObservationTransferPayload(observation: shortObservation))
                .qaReadinessSourceState,
            fallbackSourceState: WidgetPetObservationPayloadSourceResult
                .missing
                .qaReadinessSourceState
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Widget QA")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(red: 0.15, green: 0.17, blue: 0.20))

                fixtureSection(
                    title: "Long ancestor memory",
                    observation: longObservation
                )

                fixtureSection(
                    title: "Short ancestor memory",
                    observation: shortObservation
                )

                fixtureSection(
                    title: "Ordinary discovery",
                    observation: ordinaryObservation
                )

                fixtureSection(
                    title: "Growth advancement",
                    observation: growthAdvancementObservation
                )
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.97, green: 0.94, blue: 0.88),
                    Color(red: 0.86, green: 0.92, blue: 0.91),
                    Color(red: 0.80, green: 0.82, blue: 0.91)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .accessibilityIdentifier(readiness.readinessSummary)
    }

    private func fixtureSection(
        title: String,
        observation: WidgetPetObservation
    ) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.29, green: 0.34, blue: 0.40))

            widgetComparisonGroup(title: "Current", observation: observation, lineageCueDisplayMode: .hidden)
            widgetComparisonGroup(title: "Full lineage cue", observation: observation, lineageCueDisplayMode: .full)
            widgetComparisonGroup(title: "Compact lineage cue", observation: observation, lineageCueDisplayMode: .compact)
            widgetComparisonGroup(
                title: "Selective compact cue",
                observation: observation,
                lineageCueDisplayMode: .compactWhenDiscoveryFits(
                    maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
                )
            )
        }
    }

    private func widgetComparisonGroup(
        title: String,
        observation: WidgetPetObservation,
        lineageCueDisplayMode: WiPetWidgetLineageCueDisplayMode
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

            widgetPreview(
                label: "Small",
                observation: observation,
                width: 158,
                height: 158,
                lineageCueDisplayMode: lineageCueDisplayMode
            )
            widgetPreview(
                label: "Medium",
                observation: observation,
                width: 338,
                height: 158,
                lineageCueDisplayMode: lineageCueDisplayMode
            )
        }
    }

    private func widgetPreview(
        label: String,
        observation: WidgetPetObservation,
        width: CGFloat,
        height: CGFloat,
        lineageCueDisplayMode: WiPetWidgetLineageCueDisplayMode
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

            WiPetWidgetObservationContentView(
                observation: observation,
                lineageCueDisplayMode: lineageCueDisplayMode
            )
                .padding(16)
                .frame(width: width, height: height)
                .background(LinearGradient.wiPetWidgetObservationBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(.white.opacity(0.64), lineWidth: 1)
                }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label) Widget QA preview, \(observation.text.memoryCueLine)")
    }

    private static var longAncestorObservation: WidgetPetObservation {
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
            stage: .juvenile,
            relatedAncestorID: UUID(uuidString: "45B571D6-32AD-4C02-A58D-79941AE5E7DA")!
        )
        return WidgetPetObservation(creature: creature, mood: "Dreamy", ageLabel: "12 days")
    }

    private static var shortAncestorObservation: WidgetPetObservation {
        var creature = Creature(
            name: "Luma",
            species: .lunarian,
            genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
            growthStage: .juvenile,
            generation: 3
        )
        creature.recordDiscovery(
            title: "Tail echoes Nana.",
            kind: .inheritedResemblance,
            stage: .juvenile,
            relatedAncestorID: UUID(uuidString: "EF548B96-3D37-4E15-A2E5-D839101C99CF")!
        )
        return WidgetPetObservation(creature: creature, mood: "Dreamy", ageLabel: "12 days")
    }

    private static var ordinaryDiscoveryObservation: WidgetPetObservation {
        var creature = Creature(
            name: "Miri",
            species: .sylphian,
            genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian, wing: .fairy)),
            growthStage: .baby,
            generation: 1
        )
        creature.recordDiscovery(
            title: "Miri learned a soft hover.",
            kind: .growth,
            stage: .baby
        )
        return WidgetPetObservation(creature: creature, mood: "Gently floating", ageLabel: "Tiny days")
    }

    private static var growthAdvancementObservation: WidgetPetObservation {
        WidgetPetObservation(creature: PreviewFixtures.grownLuma, mood: "Quietly changed", ageLabel: "13 days")
    }
}

struct WidgetPreviewQAReadiness: Equatable {
    let hasSmallFrame: Bool
    let hasMediumFrame: Bool
    let hasLongAncestorFixture: Bool
    let hasShortAncestorFixture: Bool
    let hasOrdinaryDiscoveryFixture: Bool
    let hasGrowthAdvancementFixture: Bool
    let longMemoryCueLine: String
    let shortMemoryCueLine: String
    let ordinaryMemoryCueLine: String
    let growthAdvancementMemoryCueLine: String
    let longObservationWindowLabel: String
    let shortObservationWindowLabel: String
    let ordinaryObservationWindowLabel: String
    let growthAdvancementObservationWindowLabel: String
    let longSelectiveCueState: String
    let shortSelectiveCueState: String
    let ordinarySelectiveCueState: String
    let growthAdvancementSelectiveCueState: String
    let loadedSourceState: String
    let fallbackSourceState: String

    init(
        hasSmallFrame: Bool = true,
        hasMediumFrame: Bool = true,
        hasLongAncestorFixture: Bool = true,
        hasShortAncestorFixture: Bool = true,
        hasOrdinaryDiscoveryFixture: Bool = true,
        hasGrowthAdvancementFixture: Bool = true,
        longMemoryCueLine: String,
        shortMemoryCueLine: String,
        ordinaryMemoryCueLine: String,
        growthAdvancementMemoryCueLine: String,
        longObservationWindowLabel: String,
        shortObservationWindowLabel: String,
        ordinaryObservationWindowLabel: String,
        growthAdvancementObservationWindowLabel: String,
        longSelectiveCueState: String,
        shortSelectiveCueState: String,
        ordinarySelectiveCueState: String,
        growthAdvancementSelectiveCueState: String,
        loadedSourceState: String,
        fallbackSourceState: String
    ) {
        self.hasSmallFrame = hasSmallFrame
        self.hasMediumFrame = hasMediumFrame
        self.hasLongAncestorFixture = hasLongAncestorFixture
        self.hasShortAncestorFixture = hasShortAncestorFixture
        self.hasOrdinaryDiscoveryFixture = hasOrdinaryDiscoveryFixture
        self.hasGrowthAdvancementFixture = hasGrowthAdvancementFixture
        self.longMemoryCueLine = longMemoryCueLine
        self.shortMemoryCueLine = shortMemoryCueLine
        self.ordinaryMemoryCueLine = ordinaryMemoryCueLine
        self.growthAdvancementMemoryCueLine = growthAdvancementMemoryCueLine
        self.longObservationWindowLabel = longObservationWindowLabel
        self.shortObservationWindowLabel = shortObservationWindowLabel
        self.ordinaryObservationWindowLabel = ordinaryObservationWindowLabel
        self.growthAdvancementObservationWindowLabel = growthAdvancementObservationWindowLabel
        self.longSelectiveCueState = longSelectiveCueState
        self.shortSelectiveCueState = shortSelectiveCueState
        self.ordinarySelectiveCueState = ordinarySelectiveCueState
        self.growthAdvancementSelectiveCueState = growthAdvancementSelectiveCueState
        self.loadedSourceState = loadedSourceState
        self.fallbackSourceState = fallbackSourceState
    }

    static func selectiveCueState(for text: WidgetPetSnapshotText) -> String {
        text.lineageCueCompactLineWhenDiscoveryFits(
            maxDiscoveryCharacters: WiPetWidgetLineageCueDisplayMode.selectiveCompactMaxDiscoveryCharacters
        ) ?? "hidden"
    }

    var readinessSummary: String {
        "widgetPreviewQAReady:\(hasReadySummary),smallFrame:\(hasSmallFrame),mediumFrame:\(hasMediumFrame),longAncestorFixture:\(hasLongAncestorFixture),shortAncestorFixture:\(hasShortAncestorFixture),ordinaryDiscoveryFixture:\(hasOrdinaryDiscoveryFixture),growthAdvancementFixture:\(hasGrowthAdvancementFixture),longMemoryCueLine:\(longMemoryCueLine),shortMemoryCueLine:\(shortMemoryCueLine),ordinaryMemoryCueLine:\(ordinaryMemoryCueLine),growthAdvancementMemoryCueLine:\(growthAdvancementMemoryCueLine),longObservationWindowLabel:\(longObservationWindowLabel),shortObservationWindowLabel:\(shortObservationWindowLabel),ordinaryObservationWindowLabel:\(ordinaryObservationWindowLabel),growthAdvancementObservationWindowLabel:\(growthAdvancementObservationWindowLabel),longSelectiveCue:\(longSelectiveCueState),shortSelectiveCue:\(shortSelectiveCueState),ordinarySelectiveCue:\(ordinarySelectiveCueState),growthAdvancementSelectiveCue:\(growthAdvancementSelectiveCueState),loadedSource:\(loadedSourceState),fallbackSource:\(fallbackSourceState)"
    }

    var hasReadySummary: Bool {
        hasSmallFrame
            && hasMediumFrame
            && hasLongAncestorFixture
            && hasShortAncestorFixture
            && hasOrdinaryDiscoveryFixture
            && hasGrowthAdvancementFixture
            && !longMemoryCueLine.isEmpty
            && !shortMemoryCueLine.isEmpty
            && !ordinaryMemoryCueLine.isEmpty
            && growthAdvancementMemoryCueLine == "Adult growth memory"
            && longObservationWindowLabel.contains("Luma - Lunarian - Gen 3")
            && longObservationWindowLabel.contains("The floating tail shimmer resembles the first ancestor.")
            && !longObservationWindowLabel.contains("Family line")
            && shortObservationWindowLabel.contains("Tail echoes Nana.")
            && shortObservationWindowLabel.contains("Family line")
            && ordinaryObservationWindowLabel.contains("Miri - Sylphian - Gen 1")
            && growthAdvancementObservationWindowLabel.contains("Luma - Lunarian - Gen 3")
            && longSelectiveCueState == "hidden"
            && shortSelectiveCueState == "Family line"
            && ordinarySelectiveCueState == "hidden"
            && growthAdvancementSelectiveCueState == "hidden"
            && loadedSourceState == "loaded"
            && fallbackSourceState == "fallbackRequired"
    }
}

#Preview {
    WidgetPreviewQAView()
}
