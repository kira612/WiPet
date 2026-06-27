import SpriteKit
import SwiftUI
import WiPetCore

struct ObservationHomeSelectionOption: Equatable {
    var id: String
    var creature: Creature
    var roleLabel: String
}

struct ObservationHomeView: View {
    @State private var observationState: ObservationHomeState
    @State private var selectedLineageMemorySheet: LineageMemorySheetDestination?
    private let snapshotHostMode: Bool
    private let previewLineageMemorySheet: Bool
    private let widgetHandoffCoordinator = WidgetCurrentObservationHandoffCoordinator()

    init(
        creature: Creature,
        previewGrowthCeremony: Bool = false,
        previewGrowthCeremonyAcknowledged: Bool = false,
        previewLineageMemorySheet: Bool = false,
        observationSelectionOptions: [ObservationHomeSelectionOption] = [],
        selectedObservationID: String? = nil,
        acknowledgeSelectedObservationMoment: Bool = false,
        snapshotHostMode: Bool = false
    ) {
        var observationState = ObservationHomeState(
            creature: creature,
            observationSelectionOptions: observationSelectionOptions,
            selectedObservationID: selectedObservationID,
            shouldPublishWidgetHandoff: !snapshotHostMode
        )
        if previewGrowthCeremony {
            observationState.previewGrowthCeremony()
            if previewGrowthCeremonyAcknowledged {
                observationState.noteGrowthCeremonyObservation()
            }
        }
        if acknowledgeSelectedObservationMoment {
            observationState.noteSelectedObservationMoment()
        }
        self.snapshotHostMode = snapshotHostMode
        self.previewLineageMemorySheet = previewLineageMemorySheet
        _observationState = State(initialValue: observationState)
    }

    private var creature: Creature {
        observationState.creature
    }

    private var portraitCreature: Creature {
        observationState.portraitCreature
    }

    private var observationFocusDiscovery: DiscoveryEvent? {
        creature.preferredDailyObservationDiscovery
    }

    var body: some View {
        GeometryReader { proxy in
            let isCompactHeight = proxy.size.height < 740

            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.97, green: 0.94, blue: 0.88),
                        Color(red: 0.85, green: 0.92, blue: 0.91),
                        Color(red: 0.79, green: 0.81, blue: 0.90)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: isCompactHeight ? 14 : 22) {
                    header(titleSize: isCompactHeight ? 38 : 46)

                    Spacer(minLength: 4)

                    creaturePortrait(height: portraitHeight(isCompactHeight: isCompactHeight))
                    portraitCueLine(isCompact: isCompactHeight)

                    if let growthCeremonyTeaserViewModel = observationState.growthCeremonyTeaserViewModel {
                        growthCeremonyTeaserBand(
                            viewModel: growthCeremonyTeaserViewModel,
                            isCompact: isCompactHeight
                        )
                    }

                    Spacer(minLength: 4)

                    discoveryPanel(isCompact: isCompactHeight)
                }
                .padding(.horizontal, 24)
                .padding(.top, isCompactHeight ? 8 : 18)
                .padding(.bottom, isCompactHeight ? 18 : 28)
            }
        }
        .onAppear {
            publishCurrentObservationIfNeeded()
            presentLineageMemorySheetIfNeeded()
        }
        .sheet(item: $selectedLineageMemorySheet) { destination in
            LineageObservationMemorySheetView(copy: destination.copy)
                .presentationDetents([.large])
        }
        .overlay(alignment: .topLeading) {
            observationHomeStateReadinessProbe
            growthCeremonyPreviewAccessibilityProbe
            growthLineageCueBridgeProbe
            growthDiscoveryLogHandoffProbe
            lineageFamilyEntryMemoryProbe
            lineageObservationMemoryTeaserProbe
            lineageObservationMemorySheetProbe
            lineageObservationFamilyTreeEntryProbe
            spriteKitGrowthStageCueProbe
            spriteKitFaceLineageEchoCueProbe
            spriteKitTailLineageEchoCueProbe
            spriteKitLineageVisualEchoPairProbe
            spriteKitLineageMemoryThreadProbe
            spriteKitLineageCueSetProbe
            growthAcknowledgementGateProbe
            growthAcknowledgementSurfaceProbe
            growthConfirmationSurfaceProbe
            growthAcknowledgementIntentProbe
            growthPersistenceBoundaryProbe
            growthWidgetHandoffPreflightProbe
            growthPreviewPortraitCueProbe
            growthBeforeAfterPortraitSurfaceProbe
            growthBeforeAfterStageCuePairProbe
            growthHornBudCeremonyPreviewProbe
            spriteKitGrowthHornBudCueProbe
            growthHornBudDetailRecipeCoverageProbe
            growthObservationAcknowledgementProbe
            growthNoticedMemoryLineProbe
            growthBodyAccentNoticedMemoryCatalogProbe
            growthNoticedMemoryPriorityProbe
            growthLineageAffectionCopyProbe
            growthInheritedVisualMemoryBridgeProbe
            growthInheritedVisualPromotionGateProbe
            growthFamilyMemoryLineProbe
            observationCueLineReadabilityProbe
            appHostVisualQARecoveryStateProbe
            observationSelectionProbe
            snapshotHostEntryProbe
        }
    }

    private func portraitHeight(isCompactHeight: Bool) -> CGFloat {
        guard isCompactHeight else {
            return 330
        }

        return observationState.hasNotedGrowthCeremonyObservation ? 238 : 276
    }

    @ViewBuilder
    private var observationHomeStateReadinessProbe: some View {
        Text("Observation home state")
            .font(.caption2)
            .frame(width: 1, height: 1)
            .opacity(0.01)
            .accessibilityIdentifier(observationState.readinessSummary)
            .accessibilityLabel(observationState.readinessSummary)
    }

    @ViewBuilder
    private var growthCeremonyPreviewAccessibilityProbe: some View {
        if let label = observationState.growthCeremonyPreviewAccessibilityLabel {
            Text(label)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthCeremonyPreviewAccessibilityLabel")
                .accessibilityLabel(label)
        }
    }

    @ViewBuilder
    private var growthLineageCueBridgeProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthLineageCueBridgeSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthLineageCueBridgeSummary")
                .accessibilityLabel(observationState.growthLineageCueBridgeSummary)
        }
    }

    @ViewBuilder
    private var growthDiscoveryLogHandoffProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthDiscoveryLogHandoffSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthDiscoveryLogHandoffSummary")
                .accessibilityLabel(observationState.growthDiscoveryLogHandoffSummary)
        }
    }

    @ViewBuilder
    private var lineageFamilyEntryMemoryProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.lineageFamilyEntryMemorySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyEntryMemorySummary")
                .accessibilityLabel(observationState.lineageFamilyEntryMemorySummary)
        }
    }

    @ViewBuilder
    private var lineageObservationMemoryTeaserProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.lineageObservationMemoryTeaserSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationMemoryTeaserSummary")
                .accessibilityLabel(observationState.lineageObservationMemoryTeaserSummary)

            Text(observationState.lineageObservationMemoryTeaserReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationMemoryTeaserReadinessSummary")
                .accessibilityLabel(observationState.lineageObservationMemoryTeaserReadinessSummary)
        }
    }

    @ViewBuilder
    private var lineageObservationMemorySheetProbe: some View {
        if observationState.lineageObservationMemorySheetCopy != nil {
            Text(observationState.lineageObservationMemorySheetSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationMemorySheetSummary")
                .accessibilityLabel(observationState.lineageObservationMemorySheetSummary)

            Text(observationState.lineageObservationMemorySheetReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationMemorySheetReadinessSummary")
                .accessibilityLabel(observationState.lineageObservationMemorySheetReadinessSummary)
        }
    }

    @ViewBuilder
    private var lineageObservationFamilyTreeEntryProbe: some View {
        if observationState.lineageObservationFamilyTreeEntryCopy != nil {
            Text(observationState.lineageObservationFamilyTreeEntrySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationFamilyTreeEntrySummary")
                .accessibilityLabel(observationState.lineageObservationFamilyTreeEntrySummary)

            Text(observationState.lineageObservationFamilyTreeEntryReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageObservationFamilyTreeEntryReadinessSummary")
                .accessibilityLabel(observationState.lineageObservationFamilyTreeEntryReadinessSummary)
        }
    }

    @ViewBuilder
    private var spriteKitGrowthStageCueProbe: some View {
        Text(observationState.spriteKitGrowthStageCueSummary)
            .font(.caption2)
            .frame(width: 1, height: 1)
            .opacity(0.01)
            .accessibilityIdentifier("spriteKitGrowthStageCueSummary")
            .accessibilityLabel(observationState.spriteKitGrowthStageCueSummary)

        Text(observationState.spriteKitGrowthStageCueReadinessSummary)
            .font(.caption2)
            .frame(width: 1, height: 1)
            .opacity(0.01)
            .accessibilityIdentifier("spriteKitGrowthStageCueReadinessSummary")
            .accessibilityLabel(observationState.spriteKitGrowthStageCueReadinessSummary)
    }

    @ViewBuilder
    private var spriteKitFaceLineageEchoCueProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.spriteKitFaceLineageEchoCueSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitFaceLineageEchoCueSummary")
                .accessibilityLabel(observationState.spriteKitFaceLineageEchoCueSummary)

            Text(observationState.spriteKitFaceLineageEchoCueReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitFaceLineageEchoCueReadinessSummary")
                .accessibilityLabel(observationState.spriteKitFaceLineageEchoCueReadinessSummary)
        }
    }

    @ViewBuilder
    private var spriteKitTailLineageEchoCueProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.spriteKitTailLineageEchoCueSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitTailLineageEchoCueSummary")
                .accessibilityLabel(observationState.spriteKitTailLineageEchoCueSummary)

            Text(observationState.spriteKitTailLineageEchoCueReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitTailLineageEchoCueReadinessSummary")
                .accessibilityLabel(observationState.spriteKitTailLineageEchoCueReadinessSummary)
        }
    }

    @ViewBuilder
    private var spriteKitLineageVisualEchoPairProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.spriteKitLineageVisualEchoPairSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageVisualEchoPairSummary")
                .accessibilityLabel(observationState.spriteKitLineageVisualEchoPairSummary)

            Text(observationState.spriteKitLineageVisualEchoPairReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageVisualEchoPairReadinessSummary")
                .accessibilityLabel(observationState.spriteKitLineageVisualEchoPairReadinessSummary)
        }
    }

    @ViewBuilder
    private var spriteKitLineageMemoryThreadProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.spriteKitLineageMemoryThreadSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageMemoryThreadSummary")
                .accessibilityLabel(observationState.spriteKitLineageMemoryThreadSummary)

            Text(observationState.spriteKitLineageMemoryThreadReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageMemoryThreadReadinessSummary")
                .accessibilityLabel(observationState.spriteKitLineageMemoryThreadReadinessSummary)
        }
    }

    @ViewBuilder
    private var spriteKitLineageCueSetProbe: some View {
        if observationState.lineageObservationMemoryTeaserCopy != nil {
            Text(observationState.spriteKitLineageCueSetSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageCueSetSummary")
                .accessibilityLabel(observationState.spriteKitLineageCueSetSummary)

            Text(observationState.spriteKitLineageCueSetReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("spriteKitLineageCueSetReadinessSummary")
                .accessibilityLabel(observationState.spriteKitLineageCueSetReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthAcknowledgementGateProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthAcknowledgementGateSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthAcknowledgementGateSummary")
                .accessibilityLabel(observationState.growthAcknowledgementGateSummary)
        }
    }

    @ViewBuilder
    private var growthAcknowledgementSurfaceProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthAcknowledgementSurfaceSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthAcknowledgementSurfaceSummary")
                .accessibilityLabel(observationState.growthAcknowledgementSurfaceSummary)
        }
    }

    @ViewBuilder
    private var growthConfirmationSurfaceProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthConfirmationSurfaceSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthConfirmationSurfaceSummary")
                .accessibilityLabel(observationState.growthConfirmationSurfaceSummary)
        }
    }

    @ViewBuilder
    private var growthAcknowledgementIntentProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthAcknowledgementIntentSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthAcknowledgementIntentSummary")
                .accessibilityLabel(observationState.growthAcknowledgementIntentSummary)
        }
    }

    @ViewBuilder
    private var growthPersistenceBoundaryProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthPersistenceBoundarySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthPersistenceBoundarySummary")
                .accessibilityLabel(observationState.growthPersistenceBoundarySummary)
        }
    }

    @ViewBuilder
    private var growthWidgetHandoffPreflightProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthWidgetHandoffPreflightSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthWidgetHandoffPreflightSummary")
                .accessibilityLabel(observationState.growthWidgetHandoffPreflightSummary)

            Text(observationState.growthWidgetHandoffPreflightReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthWidgetHandoffPreflightReadinessSummary")
                .accessibilityLabel(observationState.growthWidgetHandoffPreflightReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthPreviewPortraitCueProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthPreviewPortraitCueSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthPreviewPortraitCueSummary")
                .accessibilityLabel(observationState.growthPreviewPortraitCueSummary)
        }
    }

    @ViewBuilder
    private var growthBeforeAfterPortraitSurfaceProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthBeforeAfterPortraitSurfaceSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthBeforeAfterPortraitSurfaceSummary")
                .accessibilityLabel(observationState.growthBeforeAfterPortraitSurfaceSummary)
        }
    }

    @ViewBuilder
    private var growthBeforeAfterStageCuePairProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthBeforeAfterStageCuePairSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthBeforeAfterStageCuePairSummary")
                .accessibilityLabel(observationState.growthBeforeAfterStageCuePairSummary)

            Text(observationState.growthBeforeAfterStageCuePairReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthBeforeAfterStageCuePairReadinessSummary")
                .accessibilityLabel(observationState.growthBeforeAfterStageCuePairReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthHornBudCeremonyPreviewProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthHornBudCeremonyPreviewSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthHornBudCeremonyPreviewSummary")
                .accessibilityLabel(observationState.growthHornBudCeremonyPreviewSummary)

            Text(observationState.growthHornBudCeremonyPreviewReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthHornBudCeremonyPreviewReadinessSummary")
                .accessibilityLabel(observationState.growthHornBudCeremonyPreviewReadinessSummary)
        }
    }

    private var spriteKitGrowthHornBudCueProbe: some View {
        let profile = CreatureRenderProfile(creature: portraitCreature)
        return VStack(spacing: 0) {
            Text(profile.spriteKitGrowthHornBudCueSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationSpriteKitGrowthHornBudCueSummary")
                .accessibilityLabel(profile.spriteKitGrowthHornBudCueSummary)

            Text(profile.spriteKitGrowthHornBudCueReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationSpriteKitGrowthHornBudCueReadinessSummary")
                .accessibilityLabel(profile.spriteKitGrowthHornBudCueReadinessSummary)
        }
    }

    private var growthHornBudDetailRecipeCoverageProbe: some View {
        let profile = CreatureRenderProfile(creature: portraitCreature)
        let summary = CreatureAssemblyPlan.growthHornBudDetailRecipeValidationSummary(
            for: profile,
            in: .currentLuma
        )
        let readiness = CreatureAssemblyPlan.hasGrowthHornBudDetailRecipeCoverage(
            for: profile,
            in: .currentLuma
        )
        let readinessSummary = "growthHornBudDetailRecipeCoverageReady:\(readiness)"
        return VStack(spacing: 0) {
            Text(verbatim: summary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationGrowthHornBudDetailRecipeCoverageSummary")
                .accessibilityLabel(summary)

            Text(verbatim: readinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationGrowthHornBudDetailRecipeCoverageReadinessSummary")
                .accessibilityLabel(readinessSummary)
        }
    }

    @ViewBuilder
    private var growthObservationAcknowledgementProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthObservationAcknowledgementSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthObservationAcknowledgementSummary")
                .accessibilityLabel(observationState.growthObservationAcknowledgementSummary)
        }
    }

    @ViewBuilder
    private var growthNoticedMemoryLineProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthNoticedMemoryLineSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthNoticedMemoryLineSummary")
                .accessibilityLabel(observationState.growthNoticedMemoryLineSummary)

            Text(observationState.growthNoticedMemoryLineReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthNoticedMemoryLineReadinessSummary")
                .accessibilityLabel(observationState.growthNoticedMemoryLineReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthBodyAccentNoticedMemoryCatalogProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthBodyAccentNoticedMemoryCatalogSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthBodyAccentNoticedMemoryCatalogSummary")
                .accessibilityLabel(observationState.growthBodyAccentNoticedMemoryCatalogSummary)

            Text(observationState.growthBodyAccentNoticedMemoryCatalogReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthBodyAccentNoticedMemoryCatalogReadinessSummary")
                .accessibilityLabel(observationState.growthBodyAccentNoticedMemoryCatalogReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthNoticedMemoryPriorityProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthNoticedMemoryPrioritySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthNoticedMemoryPrioritySummary")
                .accessibilityLabel(observationState.growthNoticedMemoryPrioritySummary)

            Text(observationState.growthNoticedMemoryPriorityReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthNoticedMemoryPriorityReadinessSummary")
                .accessibilityLabel(observationState.growthNoticedMemoryPriorityReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthLineageAffectionCopyProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthLineageAffectionCopySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthLineageAffectionCopySummary")
                .accessibilityLabel(observationState.growthLineageAffectionCopySummary)

            Text(observationState.growthLineageAffectionCopyReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthLineageAffectionCopyReadinessSummary")
                .accessibilityLabel(observationState.growthLineageAffectionCopyReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthInheritedVisualMemoryBridgeProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthInheritedVisualMemoryBridgeSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualMemoryBridgeSummary")
                .accessibilityLabel(observationState.growthInheritedVisualMemoryBridgeSummary)

            Text(observationState.growthInheritedVisualMemoryBridgeReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualMemoryBridgeReadinessSummary")
                .accessibilityLabel(observationState.growthInheritedVisualMemoryBridgeReadinessSummary)

            if let line = observationState.growthInheritedVisualMemoryLine {
                Text(line)
                    .font(.caption2)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .accessibilityIdentifier("growthInheritedVisualMemoryLine")
                    .accessibilityLabel(line)
            }
        }
    }

    @ViewBuilder
    private var growthInheritedVisualPromotionGateProbe: some View {
        if observationState.growthCeremonyPreview != nil {
            Text(observationState.growthInheritedVisualVisiblePromotionGateSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualVisiblePromotionGateSummary")
                .accessibilityLabel(observationState.growthInheritedVisualVisiblePromotionGateSummary)

            Text(observationState.growthInheritedVisualVisiblePromotionGateReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualVisiblePromotionGateReadinessSummary")
                .accessibilityLabel(observationState.growthInheritedVisualVisiblePromotionGateReadinessSummary)

            Text(observationState.growthInheritedVisualPromotionDeferralSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualPromotionDeferralSummary")
                .accessibilityLabel(observationState.growthInheritedVisualPromotionDeferralSummary)

            Text(observationState.growthInheritedVisualPromotionDeferralReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthInheritedVisualPromotionDeferralReadinessSummary")
                .accessibilityLabel(observationState.growthInheritedVisualPromotionDeferralReadinessSummary)
        }
    }

    @ViewBuilder
    private var growthFamilyMemoryLineProbe: some View {
        if let line = observationState.growthCeremonyTeaserViewModel?.familyMemoryLine {
            Text(line)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("growthFamilyMemoryAccessibilityLine")
                .accessibilityLabel(line)
        }
    }

    @ViewBuilder
    private var observationCueLineReadabilityProbe: some View {
        if snapshotHostMode {
            Text(observationCueLineReadabilityPreflightSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationCueLineReadabilityPreflightSummary")
                .accessibilityLabel(observationCueLineReadabilityPreflightSummary)

            Text(observationCueLineReadabilityPreflightReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationCueLineReadabilityPreflightReadinessSummary")
                .accessibilityLabel(observationCueLineReadabilityPreflightReadinessSummary)
        }
    }

    @ViewBuilder
    private var appHostVisualQARecoveryStateProbe: some View {
        if snapshotHostMode {
            Text(appHostVisualQARecoveryStateSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("appHostVisualQARecoveryStateSummary")
                .accessibilityLabel(appHostVisualQARecoveryStateSummary)

            Text(appHostVisualQARecoveryStateReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("appHostVisualQARecoveryStateReadinessSummary")
                .accessibilityLabel(appHostVisualQARecoveryStateReadinessSummary)
        }
    }

    @ViewBuilder
    private var snapshotHostEntryProbe: some View {
        if snapshotHostMode {
            Text(snapshotHostEntrySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("snapshotHostEntrySummary")
                .accessibilityLabel(snapshotHostEntrySummary)
        }
    }

    @ViewBuilder
    private var observationSelectionProbe: some View {
        if snapshotHostMode {
            Text(observationState.observationSelectionSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionSummary")
                .accessibilityLabel(observationState.observationSelectionSummary)

            Text(observationState.observationSelectionReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionReadinessSummary")
                .accessibilityLabel(observationState.observationSelectionReadinessSummary)

            Text(observationState.observationSelectionHandoffPolicySummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionHandoffPolicySummary")
                .accessibilityLabel(observationState.observationSelectionHandoffPolicySummary)

            Text(observationState.observationSelectionHandoffPolicyReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionHandoffPolicyReadinessSummary")
                .accessibilityLabel(observationState.observationSelectionHandoffPolicyReadinessSummary)

            Text(observationState.observationSelectionMomentSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionMomentSummary")
                .accessibilityLabel(observationState.observationSelectionMomentSummary)

            Text(observationState.observationSelectionMomentReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionMomentReadinessSummary")
                .accessibilityLabel(observationState.observationSelectionMomentReadinessSummary)

            Text(observationState.observationSelectionWidgetPayloadContractSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionWidgetPayloadContractSummary")
                .accessibilityLabel(observationState.observationSelectionWidgetPayloadContractSummary)

            Text(observationState.observationSelectionWidgetPayloadContractReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionWidgetPayloadContractReadinessSummary")
                .accessibilityLabel(observationState.observationSelectionWidgetPayloadContractReadinessSummary)

            Text(observationState.observationSelectionWidgetPublishPreflightSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionWidgetPublishPreflightSummary")
                .accessibilityLabel(observationState.observationSelectionWidgetPublishPreflightSummary)

            Text(observationState.observationSelectionWidgetPublishPreflightReadinessSummary)
                .font(.caption2)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("observationHomeSelectionWidgetPublishPreflightReadinessSummary")
                .accessibilityLabel(observationState.observationSelectionWidgetPublishPreflightReadinessSummary)
        }
    }

    private var snapshotHostEntrySummary: String {
        RendererMetadataSummary.snapshotHostEntrySummary(
            surfaceID: "observationHome",
            viewTarget: "ObservationHomeView",
            launchArgument: "--wipet-snapshot-host-observation-home",
            candidateReady: true,
            appTargetHostAdded: true,
            referenceImageRecorded: false,
            snapshotAssertionAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private func publishCurrentObservationIfNeeded() {
        guard observationState.shouldPublishWidgetHandoff else {
            return
        }

        widgetHandoffCoordinator.publishCurrentObservation(for: creature)
        observationState.markWidgetHandoffPublished()
    }

    private func presentLineageMemorySheetIfNeeded() {
        guard previewLineageMemorySheet,
              selectedLineageMemorySheet == nil,
              let sheetCopy = observationState.lineageObservationMemorySheetCopy
        else {
            return
        }

        selectedLineageMemorySheet = LineageMemorySheetDestination(copy: sheetCopy)
    }

    private func header(titleSize: CGFloat) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 7) {
                Text(creature.name)
                    .font(.system(size: titleSize, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.15, green: 0.17, blue: 0.20))

                Text("\(creature.growthStage.displayName)  |  Generation \(creature.generation)")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundStyle(Color(red: 0.35, green: 0.38, blue: 0.42))
            }

            Spacer()

            stageBadge
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(creature.name), \(creature.growthStage.displayName), generation \(creature.generation)")
    }

    private var stageBadge: some View {
        Text(creature.species.displayName)
            .font(.system(.footnote, design: .rounded, weight: .semibold))
            .foregroundStyle(Color(red: 0.17, green: 0.23, blue: 0.27))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.white.opacity(0.54), in: Capsule())
    }

    @ViewBuilder
    private func creaturePortrait(height: CGFloat) -> some View {
        let scale = min(1, height / 330)

        SpriteView(
            scene: CreatureScene(creature: portraitCreature),
            options: [.allowsTransparency]
        )
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .scaleEffect(scale)
        .accessibilityElement(children: .ignore)
        .accessibilityIdentifier("observationHomeCreaturePortrait")
        .accessibilityLabel(portraitAccessibilityLabel(for: portraitCreature))
    }

    private func portraitCueLine(isCompact: Bool) -> some View {
        Text(portraitVisibleCueLine(for: portraitCreature))
            .font(.system(isCompact ? .caption2 : .caption, design: .rounded, weight: .semibold))
            .foregroundStyle(Color(red: 0.31, green: 0.37, blue: 0.45))
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .minimumScaleFactor(0.78)
            .allowsTightening(true)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 12)
            .padding(.vertical, isCompact ? 5 : 7)
            .background(.white.opacity(0.36), in: Capsule())
            .accessibilityIdentifier("observationHomeCreatureCueLine")
            .accessibilityLabel(portraitVisibleCueLine(for: portraitCreature))
    }

    private func portraitAccessibilityLabel(for creature: Creature) -> String {
        let profile = CreatureRenderProfile(creature: creature)
        let cue = profile.silhouetteCue
        var parts = [
            "\(creature.name)'s portrait",
            "\(ObservationCreatureCueCatalog.face(cue.face)) face",
            "\(ObservationCreatureCueCatalog.body(cue.body)) body",
            ObservationCreatureCueCatalog.wing(cue.wing),
            "\(ObservationCreatureCueCatalog.tail(cue.tail)) tail",
            "\(creature.growthStage.displayName) stage"
        ]

        if profile.faceLineageEcho.isActive
            || profile.wingLineageEcho.isActive
            || profile.ancestralGlint.isActive
            || profile.silhouette.tailLineageEcho.isActive
        {
            parts.append("family echo: \(portraitLineageCueList(for: profile))")
        }

        return parts.joined(separator: ", ")
    }

    private func portraitLineageCueList(for profile: CreatureRenderProfile) -> String {
        let cues = [
            profile.faceLineageEcho.isActive ? profile.faceLineageEcho.cueLabel : nil,
            profile.wingLineageEcho.isActive ? profile.wingLineageEcho.cueLabel : nil,
            profile.ancestralGlint.isActive ? profile.ancestralGlint.cueLabel : nil,
            profile.silhouette.tailLineageEcho.isActive ? profile.silhouette.tailLineageEcho.cueLabel : nil
        ]
            .compactMap { $0 }
            .map(ObservationCreatureCueCatalog.lineage)

        switch cues.count {
        case 0:
            return ObservationCreatureCueCatalog.lineage("none")
        case 1:
            return cues[0]
        case 2:
            return "\(cues[0]) and \(cues[1])"
        default:
            return "\(cues.dropLast().joined(separator: ", ")), and \(cues[cues.count - 1])"
        }
    }

    private func portraitVisibleCueLine(for creature: Creature) -> String {
        let profile = CreatureRenderProfile(creature: creature)
        let cue = profile.silhouetteCue
        var parts = [
            "\(ObservationCreatureCueCatalog.sentenceStartFace(cue.face)) face",
            "\(ObservationCreatureCueCatalog.body(cue.body)) body"
        ]

        if cue.wing != "none" {
            parts.append(ObservationCreatureCueCatalog.wing(cue.wing))
        }

        if cue.tail != "none" {
            parts.append("\(ObservationCreatureCueCatalog.tail(cue.tail)) tail")
        }

        parts.append(ObservationCreatureCueCatalog.eyeGlint(
            style: profile.expression.catchlightStyleLabel,
            placement: profile.expression.catchlightPlacementLabel
        ))

        if profile.faceLineageEcho.isActive {
            parts.append("forehead memory")
        } else if profile.ancestralGlint.isActive || profile.silhouette.tailLineageEcho.isActive {
            parts.append("family echo")
        }

        return parts.joined(separator: "  |  ")
    }

    private var observationCueLineReadabilityPreflightSummary: String {
        let line = portraitVisibleCueLine(for: portraitCreature)
        let segments = observationCueLineSegments(for: line)
        return RendererMetadataSummary.observationCueLineReadabilityPreflightSummary(
            surfaceID: "observationHome",
            segmentCount: segments.count,
            maxSegments: 6,
            characterCount: line.count,
            maxCharacters: 128,
            includesEyeGlint: segments.contains { $0.contains("eye glint") },
            includesMemoryCue: segments.contains { $0.contains("memory") || $0 == "family echo" },
            lineLimit: 3,
            minimumScaleFactor: "0.78",
            appHostVisualQAPending: true,
            visibleCopyChanged: false,
            assetOutputs: "none"
        )
    }

    private var observationCueLineReadabilityPreflightReadinessSummary: String {
        let line = portraitVisibleCueLine(for: portraitCreature)
        let segments = observationCueLineSegments(for: line)
        let isReady = RendererMetadataSummary.hasObservationCueLineReadabilityPreflightFields(
            surfaceID: "observationHome",
            segmentCount: segments.count,
            maxSegments: 6,
            characterCount: line.count,
            maxCharacters: 128,
            includesEyeGlint: segments.contains { $0.contains("eye glint") },
            includesMemoryCue: segments.contains { $0.contains("memory") || $0 == "family echo" },
            lineLimit: 3,
            minimumScaleFactor: "0.78",
            appHostVisualQAPending: true,
            visibleCopyChanged: false,
            assetOutputs: "none",
            summary: observationCueLineReadabilityPreflightSummary
        )
        return RendererMetadataSummary.observationCueLineReadabilityPreflightReadinessSummary(isReady: isReady)
    }

    private var appHostVisualQARecoveryStateSummary: String {
        RendererMetadataSummary.appHostVisualQARecoveryStateSummary(
            surfaceID: "observationHome",
            externalXcodeReady: true,
            externalArtifactsReady: true,
            dryRunResolved: true,
            simulatorID: "D1C8187C-29D0-4145-94C7-6F887207A27F",
            targetedBuildCompleted: false,
            buildSilentStopped: true,
            watchdogTimedOut: true,
            timeoutSeconds: 180,
            sourceControlWorkersActive: false,
            visibleChangesAllowed: false,
            assetOutputs: "none"
        )
    }

    private var appHostVisualQARecoveryStateReadinessSummary: String {
        let isReady = RendererMetadataSummary.hasAppHostVisualQARecoveryStateFields(
            surfaceID: "observationHome",
            externalXcodeReady: true,
            externalArtifactsReady: true,
            dryRunResolved: true,
            simulatorID: "D1C8187C-29D0-4145-94C7-6F887207A27F",
            targetedBuildCompleted: false,
            buildSilentStopped: true,
            watchdogTimedOut: true,
            timeoutSeconds: 180,
            sourceControlWorkersActive: false,
            visibleChangesAllowed: false,
            assetOutputs: "none",
            summary: appHostVisualQARecoveryStateSummary
        )
        return RendererMetadataSummary.appHostVisualQARecoveryStateReadinessSummary(isReady: isReady)
    }

    private func observationCueLineSegments(for line: String) -> [String] {
        line.components(separatedBy: "  |  ")
    }
}

private enum ObservationCreatureCueCatalog {
    static func sentenceStartFace(_ cue: String) -> String {
        let value = face(cue)
        guard let first = value.first else {
            return value
        }

        return first.uppercased() + value.dropFirst()
    }

    static func face(_ cue: String) -> String {
        switch cue {
        case "softRound": "soft round"
        case "smallFairy": "small fairy"
        case "broadDragon": "broad dragon"
        case "wideAxolotl": "wide axolotl"
        case "faceted": "faceted"
        case "softDeer": "soft deer"
        case "softFeline": "soft feline"
        case "softCrescent": "soft crescent"
        default: cue
        }
    }

    static func body(_ cue: String) -> String {
        switch cue {
        case "waterDrop": "water drop"
        case "seedPetal": "seed petal"
        case "pebbleGem": "pebble gem"
        case "moonOval": "moon oval"
        case "leafBelly": "leaf belly"
        default: cue
        }
    }

    static func wing(_ cue: String) -> String {
        switch cue {
        case "leafPair": "leaf-pair winglets"
        case "wideSail": "wide sail winglets"
        case "gemPair": "gem-pair winglets"
        case "softBell": "soft bell winglets"
        case "softLunar": "soft lunar winglets"
        case "sproutLeaf": "sprout-leaf winglets"
        case "none": "no visible winglets"
        default: "\(cue) winglets"
        }
    }

    static func tail(_ cue: String) -> String {
        switch cue {
        case "longDrake": "long drake"
        case "fishFin": "fish fin"
        case "gemTail": "gem"
        case "floatingRibbon": "floating ribbon"
        case "leafSprout": "leaf sprout"
        case "none": "no visible"
        default: cue
        }
    }

    static func eyeGlint(style: String, placement: String) -> String {
        if style == "brightTinyGlint" {
            return "bright eye glint"
        }

        if style == "softLowGlint" {
            return "shy eye glint"
        }

        if placement == "upperCurious" {
            return "curious eye glint"
        }

        return "warm eye glint"
    }

    static func lineage(_ cue: String) -> String {
        switch cue {
        case "softForeheadMemoryDots": "soft forehead memory dots"
        case "softWingMemoryTips": "soft wing memory tips"
        case "softAncestralGlint": "soft ancestral glint"
        case "softTailMemoryDots": "soft tail memory dots"
        case "none": "no lineage cue"
        default: cue
        }
    }
}

extension ObservationHomeView {
    private func growthCeremonyTeaserBand(
        viewModel: GrowthCeremonyTeaserViewModel,
        isCompact: Bool
    ) -> some View {
        let hasLongComparisonLine = viewModel.comparisonLine.count > 46
        let condensesAcknowledgedMemory = viewModel.noticedMemoryLine != nil
            && (isCompact || hasLongComparisonLine)

        return HStack(alignment: .top, spacing: 10) {
            Image(systemName: "sparkles")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.34, green: 0.42, blue: 0.58))
                .frame(width: 20, height: 20)

            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.eyebrow)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundStyle(Color(red: 0.38, green: 0.43, blue: 0.48))

                Text(viewModel.title)
                    .font(.system(isCompact ? .footnote : .subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(red: 0.16, green: 0.18, blue: 0.21))
                    .fixedSize(horizontal: false, vertical: true)

                if let lineageLine = viewModel.lineageLine {
                    Text(lineageLine)
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.30, green: 0.36, blue: 0.47))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Text(viewModel.comparisonLine)
                    .font(.system(.caption2, design: .rounded, weight: .medium))
                    .foregroundStyle(Color(red: 0.33, green: 0.38, blue: 0.47))
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("growthBeforeAfterComparisonVisibleLine")

                if let affectionLine = viewModel.affectionLine, !condensesAcknowledgedMemory {
                    Text(affectionLine)
                        .font(.system(.caption2, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.29, green: 0.35, blue: 0.45))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("growthLineageAffectionVisibleLine")
                }

                if let continuityLine = viewModel.continuityLine, !condensesAcknowledgedMemory {
                    Text(continuityLine)
                        .font(.system(.caption2, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.31, green: 0.36, blue: 0.45))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("growthContinuityVisibleLine")
                }

                if let acknowledgementLine = viewModel.acknowledgementLine, !condensesAcknowledgedMemory {
                    Text(acknowledgementLine)
                        .font(.system(.caption2, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.35, green: 0.39, blue: 0.48))
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let confirmationLine = viewModel.confirmationLine, !condensesAcknowledgedMemory {
                    Text(confirmationLine)
                        .font(.system(.caption2, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.33, green: 0.38, blue: 0.47))
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let noticedMemoryLine = viewModel.noticedMemoryLine {
                    growthNoticedMemoryLineView(noticedMemoryLine)
                }

                if observationState.growthCeremonyPreview != nil {
                    growthBeforeAfterPortraitSurface(isCompact: isCompact)
                    growthObservationAcknowledgementButton(isCompact: isCompact)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, isCompact ? 13 : 15)
        .padding(.vertical, isCompact ? 11 : 13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.45), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.58), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("growthCeremonyTeaserBand")
        .accessibilityLabel(viewModel.accessibilityLabel)
    }

    private func growthNoticedMemoryLineView(_ line: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 5) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.34, green: 0.43, blue: 0.55).opacity(0.82))
                .accessibilityHidden(true)

            Text(line)
                .font(.system(.caption2, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.27, green: 0.34, blue: 0.44))
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityIdentifier("growthNoticedMemoryVisibleLine")
        }
        .accessibilityElement(children: .contain)
    }

    private func growthBeforeAfterPortraitSurface(isCompact: Bool) -> some View {
        HStack(alignment: .center, spacing: isCompact ? 6 : 8) {
            growthPreviewMiniPortrait(
                creature: creature,
                label: creature.growthStage.displayName,
                isCompact: isCompact,
                identifier: "growthBeforePortrait"
            )

            Image(systemName: "arrow.right")
                .font(.system(size: isCompact ? 10 : 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.36, green: 0.42, blue: 0.52).opacity(0.78))
                .frame(width: 13, height: 13)
                .accessibilityHidden(true)

            growthPreviewMiniPortrait(
                creature: portraitCreature,
                label: portraitCreature.growthStage.displayName,
                isCompact: isCompact,
                identifier: "growthAfterPortrait"
            )
        }
        .padding(.top, 3)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("growthBeforeAfterPortraitSurface")
        .accessibilityLabel(observationState.growthBeforeAfterPortraitSurfaceSummary)
    }

    private func growthObservationAcknowledgementButton(isCompact: Bool) -> some View {
        Button {
            observationState.noteGrowthCeremonyObservation()
        } label: {
            Label(
                observationState.hasNotedGrowthCeremonyObservation ? "Noticed" : "Notice together",
                systemImage: observationState.hasNotedGrowthCeremonyObservation ? "checkmark.circle.fill" : "circle"
            )
            .font(.system(size: isCompact ? 10 : 11, weight: .semibold, design: .rounded))
            .foregroundStyle(Color(red: 0.25, green: 0.32, blue: 0.42))
            .lineLimit(1)
            .minimumScaleFactor(0.85)
            .padding(.horizontal, 9)
            .padding(.vertical, 6)
            .background(.white.opacity(0.34), in: Capsule())
            .overlay {
                Capsule()
                    .stroke(.white.opacity(0.48), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("growthObservationAcknowledgementButton")
        .accessibilityLabel(observationState.growthObservationAcknowledgementSummary)
    }

    private func growthPreviewMiniPortrait(
        creature: Creature,
        label: String,
        isCompact: Bool,
        identifier: String
    ) -> some View {
        VStack(spacing: 3) {
            SpriteView(
                scene: CreatureScene(creature: creature),
                options: [.allowsTransparency]
            )
            .frame(width: isCompact ? 54 : 62, height: isCompact ? 42 : 48)
            .accessibilityHidden(true)

            Text(label)
                .font(.system(size: 9, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.30, green: 0.36, blue: 0.47))
                .lineLimit(1)
                .minimumScaleFactor(0.82)
        }
        .frame(width: isCompact ? 62 : 70)
        .padding(.vertical, 5)
        .background(.white.opacity(0.34), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.46), lineWidth: 1)
        }
        .accessibilityIdentifier(identifier)
        .accessibilityLabel("\(label) portrait")
    }

    private func discoveryPanel(isCompact: Bool) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("Observation focus")
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.38, green: 0.43, blue: 0.48))

            Text(observationFocusDiscovery?.title ?? "\(creature.name) is resting quietly.")
                .font(.system(isCompact ? .body : .title3, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.16, green: 0.18, blue: 0.21))
                .fixedSize(horizontal: false, vertical: true)

            if let observationFocusDiscovery {
                VStack(alignment: .leading, spacing: 7) {
                    Label(observationFocusDiscovery.dailyChangeCueLabel, systemImage: "sparkle.magnifyingglass")

                    if let lineageCueLabel = observationFocusDiscovery.lineageCueLabel {
                        Label(lineageCueLabel, systemImage: "link")
                    }
                }
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.29, green: 0.36, blue: 0.47))
            }

            if let lineageTeaser = observationState.lineageObservationMemoryTeaserCopy {
                lineageObservationMemoryTeaser(lineageTeaser, isCompact: isCompact)
            }
        }
        .padding(isCompact ? 14 : 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.58), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.72), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
    }

    private func lineageObservationMemoryTeaser(
        _ teaser: LineageObservationMemoryTeaserCopy,
        isCompact: Bool
    ) -> some View {
        Button {
            if let sheetCopy = observationState.lineageObservationMemorySheetCopy {
                selectedLineageMemorySheet = LineageMemorySheetDestination(copy: sheetCopy)
            }
        } label: {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "link")
                    .font(.system(size: isCompact ? 10 : 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.38, green: 0.43, blue: 0.52))
                    .frame(width: 14, height: 14)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 3) {
                    Text(teaser.title)
                        .font(.system(size: isCompact ? 11 : 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.29, green: 0.34, blue: 0.42))
                        .lineLimit(1)
                        .minimumScaleFactor(0.88)

                    Text(teaser.memoryLine)
                        .font(.system(size: isCompact ? 11 : 12, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.31, blue: 0.39))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(teaser.statusLine)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.43, green: 0.47, blue: 0.54))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(teaser.entryLine)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.36, green: 0.42, blue: 0.50))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("lineageObservationMemoryTeaserEntryLine")
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.system(size: isCompact ? 9 : 10, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.43, green: 0.47, blue: 0.54).opacity(0.72))
                    .padding(.top, 2)
                    .accessibilityHidden(true)
            }
        }
        .padding(.top, 2)
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageObservationMemoryTeaser")
        .accessibilityLabel("\(teaser.title), \(teaser.memoryLine), \(teaser.statusLine), \(teaser.entryLine)")
    }
}

private struct LineageMemorySheetDestination: Identifiable, Equatable {
    let copy: LineageObservationMemorySheetCopy

    var id: String {
        copy.summary
    }
}

private struct LineageObservationMemorySheetView: View {
    @Environment(\.dismiss) private var dismiss
    let copy: LineageObservationMemorySheetCopy

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.97, green: 0.94, blue: 0.88),
                    Color(red: 0.86, green: 0.92, blue: 0.91),
                    Color(red: 0.80, green: 0.82, blue: 0.91)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(copy.title)
                            .font(.system(.title2, design: .rounded, weight: .semibold))
                            .foregroundStyle(Color(red: 0.16, green: 0.18, blue: 0.21))
                            .fixedSize(horizontal: false, vertical: true)

                        Text(copy.teaser.entryPoint.title)
                            .font(.system(.caption, design: .rounded, weight: .semibold))
                            .textCase(.uppercase)
                            .foregroundStyle(Color(red: 0.38, green: 0.43, blue: 0.48))
                    }

                    Spacer(minLength: 12)

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.24, green: 0.29, blue: 0.36))
                            .frame(width: 34, height: 34)
                            .background(.white.opacity(0.42), in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("lineageObservationMemorySheetCloseButton")
                    .accessibilityLabel("Close family memory")
                }

                VStack(alignment: .leading, spacing: 12) {
                    Label(copy.ancestorLine, systemImage: "leaf")
                    Label(copy.memoryLine, systemImage: "link")
                    Label(copy.householdLine, systemImage: "house")
                        .accessibilityIdentifier("lineageObservationMemorySheetHouseholdLine")
                    Label(copy.statusLine, systemImage: "lock")
                }
                .font(.system(.body, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.25, green: 0.31, blue: 0.39))
                .fixedSize(horizontal: false, vertical: true)

                familyTreeEntrySection(copy.familyTreeEntryCopy)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 24)
            .padding(.top, 36)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("lineageObservationMemorySheet")
        .accessibilityLabel("\(copy.title), \(copy.ancestorLine), \(copy.memoryLine), \(copy.householdLine), \(copy.statusLine)")
    }

    private func familyTreeEntrySection(_ entry: LineageObservationFamilyTreeEntryCopy) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(spacing: 8) {
                Image(systemName: "point.3.connected.trianglepath.dotted")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.35, green: 0.40, blue: 0.50))
                    .frame(width: 18, height: 18)
                    .accessibilityHidden(true)

                Text(entry.title)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(red: 0.18, green: 0.22, blue: 0.29))
            }

            Text(entry.ancestorLine)
                .font(.system(.callout, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.24, green: 0.30, blue: 0.38))
                .fixedSize(horizontal: false, vertical: true)

            Text(entry.memoryLine)
                .font(.system(.callout, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.25, green: 0.31, blue: 0.39))
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityIdentifier("lineageObservationFamilyTreeEntryMemoryLine")

            Text(entry.branchLine)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.33, green: 0.39, blue: 0.50))
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityIdentifier("lineageObservationFamilyTreeEntryBranchLine")

            Text(entry.generationLine)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.36, green: 0.42, blue: 0.52))
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityIdentifier("lineageObservationFamilyTreeEntryGenerationLine")

            Text(entry.statusLine)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.42, green: 0.47, blue: 0.55))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .background(.white.opacity(0.30), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.40), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageObservationFamilyTreeEntry")
        .accessibilityLabel("\(entry.title), \(entry.ancestorLine), \(entry.memoryLine), \(entry.branchLine), \(entry.generationLine), \(entry.statusLine)")
    }
}

private extension Species {
    var displayName: String {
        switch self {
        case .aquarian: "Aquarian"
        case .sylphian: "Sylphian"
        case .crystalian: "Crystalian"
        case .lunarian: "Lunarian"
        case .verdant: "Verdant"
        }
    }
}

private extension GrowthStage {
    var displayName: String {
        switch self {
        case .egg: "Egg"
        case .baby: "Baby"
        case .juvenile: "Juvenile"
        case .adult: "Adult"
        case .elder: "Elder"
        }
    }
}

#Preview {
    ObservationHomeView(creature: PreviewFixtures.luma)
}

struct ObservationHomeState: Equatable {
    private var fallbackCreature: Creature
    private(set) var observationSelectionOptions: [ObservationHomeSelectionOption]
    private(set) var selectedObservationID: String?
    private(set) var growthCeremonyPreview: GrowthCeremonyPlan?
    private(set) var shouldPublishWidgetHandoff: Bool
    private(set) var hasNotedGrowthCeremonyObservation: Bool
    private(set) var hasAcknowledgedObservationMoment: Bool

    init(
        creature: Creature,
        observationSelectionOptions: [ObservationHomeSelectionOption] = [],
        selectedObservationID: String? = nil,
        growthCeremonyPreview: GrowthCeremonyPlan? = nil,
        shouldPublishWidgetHandoff: Bool = true,
        hasNotedGrowthCeremonyObservation: Bool = false,
        hasAcknowledgedObservationMoment: Bool = false
    ) {
        self.fallbackCreature = creature
        self.observationSelectionOptions = observationSelectionOptions
        self.selectedObservationID = selectedObservationID
        self.growthCeremonyPreview = growthCeremonyPreview
        self.shouldPublishWidgetHandoff = shouldPublishWidgetHandoff
        self.hasNotedGrowthCeremonyObservation = hasNotedGrowthCeremonyObservation
        self.hasAcknowledgedObservationMoment = hasAcknowledgedObservationMoment
    }

    var creature: Creature {
        guard let selectedObservationID,
              let selectedOption = observationSelectionOptions.first(where: { $0.id == selectedObservationID })
        else {
            return fallbackCreature
        }

        return selectedOption.creature
    }

    var observationSelectionSummary: String {
        let selectedID = selectedObservationID ?? "fallback"
        let candidateIDs = observationSelectionOptions.map(\.id).joined(separator: "+")
        let roles = observationSelectionOptions.map(\.roleLabel).joined(separator: "+")
        let selectedName = creature.name
        return "observationHomeSelection=selected:\(selectedID),selectedName:\(selectedName),candidates:\(candidateIDs.isEmpty ? "none" : candidateIDs),roles:\(roles.isEmpty ? "none" : roles),mutation:false,persistence:false,widget:\(shouldPublishWidgetHandoff),normalEntry:false"
    }

    var observationSelectionReadinessSummary: String {
        let hasUniqueCandidates = Set(observationSelectionOptions.map(\.id)).count == observationSelectionOptions.count
        let selectedExists = selectedObservationID.map { selectedID in
            observationSelectionOptions.contains(where: { $0.id == selectedID })
        } ?? true
        let isReady = hasUniqueCandidates && selectedExists
        return "observationHomeSelectionReady:\(isReady),selectedExists:\(selectedExists),uniqueCandidates:\(hasUniqueCandidates)"
    }

    var observationSelectionHandoffPolicySummary: String {
        let selectedID = selectedObservationID ?? "fallback"
        let hasLocalSelection = selectedObservationID != nil
        let publishOnSelection = false
        let publishAfterObservationMoment = hasLocalSelection
        return "observationSelectionHandoffPolicy=selected:\(selectedID),publishOnSelection:\(publishOnSelection),publishAfterObservationMoment:\(publishAfterObservationMoment),snapshotHostPublish:\(shouldPublishWidgetHandoff),persistence:false,widgetPayloadSchemaChanged:false"
    }

    var observationSelectionHandoffPolicyReadinessSummary: String {
        let hasLocalSelection = selectedObservationID != nil
        let selectedExists = selectedObservationID.map { selectedID in
            observationSelectionOptions.contains(where: { $0.id == selectedID })
        } ?? true
        let isReady = hasLocalSelection && selectedExists && !shouldPublishWidgetHandoff
        return "observationSelectionHandoffPolicyReady:\(isReady),selectedExists:\(selectedExists),publishOnSelection:false,publishAfterObservationMoment:\(hasLocalSelection)"
    }

    var observationSelectionMomentSummary: String {
        let selectedID = selectedObservationID ?? "fallback"
        let selectedExists = selectedObservationID.map { selectedID in
            observationSelectionOptions.contains(where: { $0.id == selectedID })
        } ?? false
        let publishReady = hasAcknowledgedObservationMoment && selectedExists && !shouldPublishWidgetHandoff
        return "observationSelectionMoment=selected:\(selectedID),acknowledged:\(hasAcknowledgedObservationMoment),selectedExists:\(selectedExists),publishReady:\(publishReady),publishOnSelection:false,widgetPublished:false,persistence:false,mutation:false"
    }

    var observationSelectionMomentReadinessSummary: String {
        let selectedExists = selectedObservationID.map { selectedID in
            observationSelectionOptions.contains(where: { $0.id == selectedID })
        } ?? false
        let isReady = hasAcknowledgedObservationMoment && selectedExists && !shouldPublishWidgetHandoff
        return "observationSelectionMomentReady:\(isReady),acknowledged:\(hasAcknowledgedObservationMoment),selectedExists:\(selectedExists),widgetPublished:false,persistence:false"
    }

    var observationSelectionWidgetPayloadContractSummary: String {
        guard hasAcknowledgedObservationMoment,
              let payload = observationSelectionWidgetPayloadContractPreview
        else {
            return "observationSelectionWidgetPayloadContract=selected:\(selectedObservationID ?? "fallback"),acknowledged:\(hasAcknowledgedObservationMoment),ready:false,schema:none,key:\(WidgetSharedDataKeys.currentObservationJSON),widgetKind:\(WidgetSharedDataKeys.widgetKind),write:false,reload:false,persistence:false"
        }

        return "observationSelectionWidgetPayloadContract=selected:\(selectedObservationID ?? "fallback"),acknowledged:true,ready:true,schema:\(payload.schemaVersion),key:\(WidgetSharedDataKeys.currentObservationJSON),widgetKind:\(WidgetSharedDataKeys.widgetKind),name:\(payload.name),species:\(payload.speciesName),stage:\(payload.growthStageName),generation:\(payload.generation),mood:\(payload.mood),age:\(payload.ageLabel),discovery:\(payload.latestDiscoveryText),memoryCue:\(payload.latestDiscoveryMemoryCueLabel ?? "none"),lineageCue:\(payload.latestDiscoveryLineageCueLabel ?? "none"),write:false,reload:false,persistence:false"
    }

    var observationSelectionWidgetPayloadContractReadinessSummary: String {
        let payload = observationSelectionWidgetPayloadContractPreview
        let isReady = hasAcknowledgedObservationMoment
            && payload?.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion
            && !shouldPublishWidgetHandoff
        return "observationSelectionWidgetPayloadContractReady:\(isReady),schema:\(payload?.schemaVersion ?? 0),expectedSchema:\(WidgetPetObservationTransferPayload.currentSchemaVersion),key:\(WidgetSharedDataKeys.currentObservationJSON),widgetKind:\(WidgetSharedDataKeys.widgetKind),write:false,reload:false"
    }

    var observationSelectionWidgetPublishPreflightSummary: String {
        let payload = observationSelectionWidgetPayloadContractPreview
        let payloadReady = hasAcknowledgedObservationMoment
            && payload?.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion
        let finalGuardReady = payloadReady && !shouldPublishWidgetHandoff
        let expectedResult = WidgetCurrentObservationHandoffResult.published(
            reloadedWidgetKind: WidgetSharedDataKeys.widgetKind
        )
        return "observationSelectionWidgetPublishPreflight=selected:\(selectedObservationID ?? "fallback"),acknowledged:\(hasAcknowledgedObservationMoment),payloadReady:\(payloadReady),finalGuardReady:\(finalGuardReady),expectedResult:\(expectedResult.readinessSummary),resultSummaryReady:\(expectedResult.hasReadySummary),wouldWrite:\(finalGuardReady),wouldReload:\(finalGuardReady),write:false,reload:false,snapshotHostPublish:\(shouldPublishWidgetHandoff),persistence:false,normalEntry:false"
    }

    var observationSelectionWidgetPublishPreflightReadinessSummary: String {
        let payload = observationSelectionWidgetPayloadContractPreview
        let expectedResult = WidgetCurrentObservationHandoffResult.published(
            reloadedWidgetKind: WidgetSharedDataKeys.widgetKind
        )
        let isReady = hasAcknowledgedObservationMoment
            && payload?.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion
            && expectedResult.hasReadySummary
            && !shouldPublishWidgetHandoff
        return "observationSelectionWidgetPublishPreflightReady:\(isReady),expectedResultReady:\(expectedResult.hasReadySummary),schema:\(payload?.schemaVersion ?? 0),expectedSchema:\(WidgetPetObservationTransferPayload.currentSchemaVersion),wouldWrite:\(isReady),wouldReload:\(isReady),write:false,reload:false"
    }

    @discardableResult
    mutating func previewGrowthCeremony() -> GrowthCeremonyPlan? {
        let preview = creature.growthCeremonyPlan
        growthCeremonyPreview = preview
        shouldPublishWidgetHandoff = false
        return preview
    }

    mutating func markWidgetHandoffPublished() {
        shouldPublishWidgetHandoff = false
    }

    mutating func noteSelectedObservationMoment() {
        guard let selectedObservationID,
              observationSelectionOptions.contains(where: { $0.id == selectedObservationID })
        else {
            return
        }

        hasAcknowledgedObservationMoment = true
    }

    mutating func noteGrowthCeremonyObservation() {
        guard growthCeremonyPreview != nil else {
            return
        }

        hasNotedGrowthCeremonyObservation = true
    }

    var growthCeremonyPreviewTitle: String {
        growthCeremonyPreview?.previewTitle ?? "none"
    }

    var growthCeremonyTeaserViewModel: GrowthCeremonyTeaserViewModel? {
        growthCeremonyPreview.map { preview in
            GrowthCeremonyTeaserViewModel(
                preview: preview,
                lineageTeaserCopy: growthCeremonyLineageTeaserCopy,
                lineageAffectionCopy: growthLineageAffectionCopy,
                continuityLineCopy: growthContinuityLineCopy,
                acknowledgementSurfaceCopy: growthAcknowledgementSurfaceCopy,
                confirmationSurfaceCopy: growthConfirmationSurfaceCopy,
                noticedMemoryLineCopy: growthNoticedMemoryLineCopy,
                noticedMemoryCatalogEntry: growthNoticedMemoryCatalogEntry
            )
        }
    }

    var growthCeremonyTeaserReadinessSummary: String {
        growthCeremonyTeaserViewModel?.readinessSummary ?? "growthCeremonyTeaserReady:false,title:none"
    }

    var growthCeremonyTraitRevealSummary: String {
        growthCeremonyPreview?.traitReveal.summary ?? "growthTraitReveal:none"
    }

    var growthCeremonyConfirmationGateSummary: String {
        growthCeremonyPreview?.confirmationGate.summary ?? "growthConfirmationGate:none"
    }

    var growthCeremonyBeforeAfterObservationSummary: String {
        growthCeremonyPreview?.beforeAfterObservation.summary ?? "growthBeforeAfterObservation:none"
    }

    var growthCeremonyMutationProofSummary: String {
        growthCeremonyPreview?.mutationProof.summary ?? "growthMutationProof:none"
    }

    var growthLineageCueBridgeSummary: String {
        growthLineageCueBridge?.summary ?? "growthLineageCueBridge:none"
    }

    var growthCeremonyLineageTeaserSummary: String {
        growthCeremonyLineageTeaserCopy?.summary ?? "growthLineageTeaser:none"
    }

    var growthDiscoveryLogHandoffSummary: String {
        growthDiscoveryLogHandoffPreview?.summary ?? "growthDiscoveryLogHandoff:none"
    }

    var lineageFamilyEntryMemorySummary: String {
        lineageFamilyEntryMemoryBridge?.summary ?? "lineageFamilyEntryMemory:none"
    }

    var lineageObservationMemoryTeaserSummary: String {
        lineageObservationMemoryTeaserCopy?.summary ?? "lineageObservationMemoryTeaser:none"
    }

    var lineageObservationMemoryTeaserReadinessSummary: String {
        lineageObservationMemoryTeaserCopy?.readinessSummary ?? "lineageObservationMemoryTeaserReady:false"
    }

    var lineageObservationMemorySheetSummary: String {
        lineageObservationMemorySheetCopy?.summary ?? "lineageObservationMemorySheet:none"
    }

    var lineageObservationMemorySheetReadinessSummary: String {
        lineageObservationMemorySheetCopy?.readinessSummary ?? "lineageObservationMemorySheetReady:false"
    }

    var lineageObservationFamilyTreeEntryCopy: LineageObservationFamilyTreeEntryCopy? {
        lineageObservationMemorySheetCopy?.familyTreeEntryCopy
    }

    var lineageObservationFamilyTreeEntrySummary: String {
        lineageObservationFamilyTreeEntryCopy?.summary ?? "lineageObservationFamilyTreeEntry:none"
    }

    var lineageObservationFamilyTreeEntryReadinessSummary: String {
        lineageObservationFamilyTreeEntryCopy?.readinessSummary ?? "lineageObservationFamilyTreeEntryReady:false"
    }

    var spriteKitGrowthStageCueSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthStageCueSummary
    }

    var spriteKitGrowthStageCueReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthStageCueReadinessSummary
    }

    var spriteKitTailLineageEchoCueSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitTailLineageEchoCueSummary
    }

    var spriteKitFaceLineageEchoCueSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitFaceLineageEchoCueSummary
    }

    var spriteKitFaceLineageEchoCueReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitFaceLineageEchoCueReadinessSummary
    }

    var spriteKitTailLineageEchoCueReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitTailLineageEchoCueReadinessSummary
    }

    var spriteKitLineageVisualEchoPairSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageVisualEchoPairSummary
    }

    var spriteKitLineageVisualEchoPairReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageVisualEchoPairReadinessSummary
    }

    var spriteKitLineageMemoryThreadSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageMemoryThreadSummary
    }

    var spriteKitLineageMemoryThreadReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageMemoryThreadReadinessSummary
    }

    var spriteKitLineageCueSetSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageCueSetSummary
    }

    var spriteKitLineageCueSetReadinessSummary: String {
        CreatureRenderProfile(creature: creature).spriteKitLineageCueSetReadinessSummary
    }

    var growthAcknowledgementGateSummary: String {
        growthAcknowledgementGatePreview?.summary ?? "growthAcknowledgementGate:none"
    }

    var growthAcknowledgementSurfaceSummary: String {
        growthAcknowledgementSurfaceCopy?.summary ?? "growthAcknowledgementSurface:none"
    }

    var growthConfirmationSurfaceSummary: String {
        growthConfirmationSurfaceCopy?.summary ?? "growthConfirmationSurface:none"
    }

    var growthAcknowledgementIntentSummary: String {
        growthAcknowledgementIntentContract?.summary ?? "growthAcknowledgementIntent:none"
    }

    var growthObservationAcknowledgementSummary: String {
        growthObservationAcknowledgementInteraction?.summary ?? "growthObservationAcknowledgement:none"
    }

    var growthNoticedMemoryLineSummary: String {
        growthNoticedMemoryLineCopy?.summary ?? "growthNoticedMemoryLine:none"
    }

    var growthNoticedMemoryLineReadinessSummary: String {
        growthNoticedMemoryLineCopy?.readinessSummary ?? "growthNoticedMemoryLineReady:false"
    }

    var growthBodyAccentNoticedMemoryCatalogSummary: String {
        growthBodyAccentNoticedMemoryCatalogEntry?.summary ?? "growthBodyAccentNoticedMemoryCatalog:none"
    }

    var growthBodyAccentNoticedMemoryCatalogReadinessSummary: String {
        growthBodyAccentNoticedMemoryCatalogEntry?.readinessSummary ?? "growthBodyAccentNoticedMemoryCatalogReady:false"
    }

    var growthNoticedMemoryPrioritySummary: String {
        let candidates = growthNoticedMemoryCatalogEntries
        let selectedCue = candidates.first?.cueID ?? "none"
        let orderedCues = candidates.map(\.cueID).joined(separator: "+")
        return "growthNoticedMemoryPriority=selected:\(selectedCue),candidates:\(orderedCues.isEmpty ? "none" : orderedCues),previewOnly:true,visibleCopyChanged:false,write:false,mutation:false,widget:false,discovery:false"
    }

    var growthNoticedMemoryPriorityReadinessSummary: String {
        let candidates = growthNoticedMemoryCatalogEntries
        let isReady = !candidates.isEmpty && candidates.allSatisfy(\.hasRequiredFields)
        return "growthNoticedMemoryPriorityReady:\(isReady)"
    }

    var growthPersistenceBoundarySummary: String {
        growthPersistenceBoundaryContract?.summary ?? "growthPersistenceBoundary:none"
    }

    var growthWidgetHandoffPreflightSummary: String {
        growthWidgetHandoffPreflightContract?.summary ?? "growthWidgetHandoffPreflight:none"
    }

    var growthWidgetHandoffPreflightReadinessSummary: String {
        growthWidgetHandoffPreflightContract?.readinessSummary ?? "growthWidgetHandoffPreflightReady:false"
    }

    var growthLineageAffectionCopySummary: String {
        growthLineageAffectionCopy?.summary ?? "growthLineageAffectionCopy:none"
    }

    var growthLineageAffectionCopyReadinessSummary: String {
        growthLineageAffectionCopy?.readinessSummary ?? "growthLineageAffectionCopyReady:false"
    }

    var growthInheritedVisualMemoryBridgeSummary: String {
        growthInheritedVisualMemoryBridge?.summary ?? "growthInheritedVisualMemoryBridge:none"
    }

    var growthInheritedVisualMemoryBridgeReadinessSummary: String {
        growthInheritedVisualMemoryBridge?.readinessSummary ?? "growthInheritedVisualMemoryBridgeReady:false"
    }

    var growthInheritedVisualMemoryLine: String? {
        growthInheritedVisualMemoryBridge?.memoryLine
    }

    var growthInheritedVisualVisiblePromotionGateSummary: String {
        growthInheritedVisualVisiblePromotionGate?.summary
            ?? "growthInheritedVisualVisiblePromotionGate:none"
    }

    var growthInheritedVisualVisiblePromotionGateReadinessSummary: String {
        growthInheritedVisualVisiblePromotionGate?.readinessSummary
            ?? "growthInheritedVisualVisiblePromotionGateReady:false"
    }

    var growthInheritedVisualPromotionDeferralSummary: String {
        growthInheritedVisualPromotionDeferral?.summary
            ?? "growthInheritedVisualPromotionDeferral:none"
    }

    var growthInheritedVisualPromotionDeferralReadinessSummary: String {
        growthInheritedVisualPromotionDeferral?.readinessSummary
            ?? "growthInheritedVisualPromotionDeferralReady:false"
    }

    var portraitCreature: Creature {
        guard let growthCeremonyPreview else {
            return creature
        }

        var previewCreature = creature
        previewCreature.growthStage = growthCeremonyPreview.nextStage
        return previewCreature
    }

    var growthPreviewPortraitCueSummary: String {
        guard growthCeremonyPreview != nil else {
            return "growthPreviewPortraitCue:none"
        }

        return CreatureRenderProfile(creature: portraitCreature).spriteKitGrowthStageCueSummary
    }

    var growthBeforeAfterPortraitSurfaceSummary: String {
        guard let growthCeremonyPreview else {
            return "growthBeforeAfterPortraitSurface:none"
        }

        let currentCue = CreatureRenderProfile(creature: creature).growthStageCue.scaleLabel
        let nextCue = CreatureRenderProfile(creature: portraitCreature).growthStageCue.scaleLabel

        return RendererMetadataSummary.growthBeforeAfterPortraitSurfaceSummary(
            currentStage: growthCeremonyPreview.currentStage.displayName.lowercased(),
            nextStage: growthCeremonyPreview.nextStage.displayName.lowercased(),
            currentCue: currentCue,
            nextCue: nextCue,
            allowsMutation: false,
            widgetHandoffAllowed: shouldPublishWidgetHandoff,
            assetOutputs: "none"
        )
    }

    var growthBeforeAfterStageCuePairSummary: String {
        guard growthCeremonyPreview != nil else {
            return "growthBeforeAfterStageCuePair:none"
        }

        let currentCue = CreatureRenderProfile(creature: creature).growthStageCue
        let nextCue = CreatureRenderProfile(creature: portraitCreature).growthStageCue

        return RendererMetadataSummary.growthBeforeAfterStageCuePairSummary(
            currentStage: currentCue.stageLabel,
            currentScale: currentCue.scaleLabel,
            currentPosture: currentCue.postureLabel,
            nextStage: nextCue.stageLabel,
            nextScale: nextCue.scaleLabel,
            nextPosture: nextCue.postureLabel,
            previewOnly: true,
            allowsMutation: false,
            assetOutputs: "none"
        )
    }

    var growthBeforeAfterStageCuePairReadinessSummary: String {
        guard growthCeremonyPreview != nil else {
            return "growthBeforeAfterStageCuePairReady:false"
        }

        let currentCue = CreatureRenderProfile(creature: creature).growthStageCue
        let nextCue = CreatureRenderProfile(creature: portraitCreature).growthStageCue
        let isReady = RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
            currentStage: currentCue.stageLabel,
            currentScale: currentCue.scaleLabel,
            currentPosture: currentCue.postureLabel,
            nextStage: nextCue.stageLabel,
            nextScale: nextCue.scaleLabel,
            nextPosture: nextCue.postureLabel,
            previewOnly: true,
            allowsMutation: false,
            assetOutputs: "none",
            summary: growthBeforeAfterStageCuePairSummary
        )

        return RendererMetadataSummary.growthBeforeAfterStageCuePairReadinessSummary(isReady: isReady)
    }

    var growthHornBudCeremonyPreviewSummary: String {
        guard growthCeremonyPreview != nil else {
            return "growthHornBudCeremonyPreview:none"
        }

        let currentBud = CreatureRenderProfile(creature: creature).growthHornBudCue.budLabel
        let nextBud = CreatureRenderProfile(creature: portraitCreature).growthHornBudCue.budLabel

        return RendererMetadataSummary.growthHornBudCeremonyPreviewSummary(
            currentBud: currentBud,
            nextBud: nextBud,
            visibleInCeremony: false,
            allowsMutation: false,
            widgetHandoffAllowed: shouldPublishWidgetHandoff,
            appendsDiscovery: false,
            assetOutputs: "none"
        )
    }

    var growthHornBudCeremonyPreviewReadinessSummary: String {
        guard growthCeremonyPreview != nil else {
            return "growthHornBudCeremonyPreviewReady:false"
        }

        let currentBud = CreatureRenderProfile(creature: creature).growthHornBudCue.budLabel
        let nextBud = CreatureRenderProfile(creature: portraitCreature).growthHornBudCue.budLabel
        let isReady = RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
            currentBud: currentBud,
            nextBud: nextBud,
            visibleInCeremony: false,
            allowsMutation: false,
            widgetHandoffAllowed: shouldPublishWidgetHandoff,
            appendsDiscovery: false,
            assetOutputs: "none",
            summary: growthHornBudCeremonyPreviewSummary
        )

        return RendererMetadataSummary.growthHornBudCeremonyPreviewReadinessSummary(isReady: isReady)
    }

    private var observationSelectionWidgetPayloadContractPreview: WidgetPetObservationTransferPayload? {
        guard hasAcknowledgedObservationMoment,
              selectedObservationID != nil
        else {
            return nil
        }

        return WidgetPetObservationTransferPayload(
            observation: WidgetPetObservation(
                creature: creature,
                mood: "Dreamy",
                ageLabel: "12 days"
            )
        )
    }

    private var growthLineageCueBridge: GrowthCeremonyLineageCueBridge? {
        guard let growthCeremonyPreview,
              let lineageCopy = lineageVisibleCueObservationCopy
        else {
            return nil
        }

        return GrowthCeremonyLineageCueBridge(
            traitReveal: growthCeremonyPreview.traitReveal,
            lineageCopy: lineageCopy
        )
    }

    private var growthCeremonyLineageTeaserCopy: GrowthCeremonyLineageTeaserCopy? {
        guard let growthCeremonyPreview,
              let growthLineageCueBridge
        else {
            return nil
        }

        return GrowthCeremonyLineageTeaserCopy(
            previewTitle: growthCeremonyPreview.previewTitle,
            bridge: growthLineageCueBridge
        )
    }

    private var growthDiscoveryLogHandoffPreview: GrowthCeremonyDiscoveryLogHandoffPreview? {
        guard let growthCeremonyPreview else {
            return nil
        }

        return GrowthCeremonyDiscoveryLogHandoffPreview(
            plan: growthCeremonyPreview,
            lineageTeaserCopy: growthCeremonyLineageTeaserCopy
        )
    }

    private var lineageFamilyEntryMemoryBridge: LineageFamilyEntryMemoryBridge? {
        guard let growthDiscoveryLogHandoffPreview else {
            return nil
        }

        return LineageFamilyEntryMemoryBridge(discoveryHandoff: growthDiscoveryLogHandoffPreview)
    }

    var lineageObservationMemoryTeaserCopy: LineageObservationMemoryTeaserCopy? {
        guard let lineageVisibleCueObservationCopy else {
            return nil
        }

        return LineageObservationMemoryTeaserCopy(lineageCopy: lineageVisibleCueObservationCopy)
    }

    var lineageObservationMemorySheetCopy: LineageObservationMemorySheetCopy? {
        guard let lineageObservationMemoryTeaserCopy else {
            return nil
        }

        return LineageObservationMemorySheetCopy(teaser: lineageObservationMemoryTeaserCopy)
    }

    private var growthAcknowledgementGatePreview: GrowthCeremonyPlayerAcknowledgementGatePreview? {
        guard let growthCeremonyPreview,
              let growthDiscoveryLogHandoffPreview
        else {
            return nil
        }

        return GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: growthDiscoveryLogHandoffPreview,
            mutationProof: growthCeremonyPreview.mutationProof,
            isPlayerAcknowledged: hasNotedGrowthCeremonyObservation
        )
    }

    private var growthAcknowledgementSurfaceCopy: GrowthCeremonyAcknowledgementSurfaceCopy? {
        guard let growthAcknowledgementGatePreview else {
            return nil
        }

        return GrowthCeremonyAcknowledgementSurfaceCopy(gate: growthAcknowledgementGatePreview)
    }

    private var growthConfirmationSurfaceCopy: GrowthCeremonyConfirmationSurfaceCopy? {
        guard let growthCeremonyPreview,
              let growthAcknowledgementSurfaceCopy,
              let growthDiscoveryLogHandoffPreview
        else {
            return nil
        }

        return GrowthCeremonyConfirmationSurfaceCopy(
            observation: growthCeremonyPreview.beforeAfterObservation,
            acknowledgementSurface: growthAcknowledgementSurfaceCopy,
            discoveryHandoff: growthDiscoveryLogHandoffPreview
        )
    }

    private var growthAcknowledgementIntentContract: GrowthCeremonyAcknowledgementIntentContract? {
        guard let growthConfirmationSurfaceCopy else {
            return nil
        }

        return GrowthCeremonyAcknowledgementIntentContract(
            confirmationSurface: growthConfirmationSurfaceCopy
        )
    }

    private var growthContinuityLineCopy: GrowthCeremonyContinuityLineCopy? {
        guard let growthCeremonyPreview else {
            return nil
        }

        return GrowthCeremonyContinuityLineCopy(plan: growthCeremonyPreview)
    }

    private var growthObservationAcknowledgementInteraction: GrowthCeremonyObservationAcknowledgementInteraction? {
        guard let growthCeremonyPreview else {
            return nil
        }

        return GrowthCeremonyObservationAcknowledgementInteraction(
            observation: growthCeremonyPreview.beforeAfterObservation,
            hasNotedObservation: hasNotedGrowthCeremonyObservation
        )
    }

    private var growthNoticedMemoryLineCopy: GrowthCeremonyNoticedMemoryLineCopy? {
        guard let growthDiscoveryLogHandoffPreview else {
            return nil
        }

        return GrowthCeremonyNoticedMemoryLineCopy(
            discoveryHandoff: growthDiscoveryLogHandoffPreview,
            isPlayerAcknowledged: hasNotedGrowthCeremonyObservation,
            memoryLine: growthNoticedMemoryCatalogEntry?.memoryLine
        )
    }

    private var growthNoticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry? {
        growthNoticedMemoryCatalogEntries.first
    }

    private var growthNoticedMemoryCatalogEntries: [GrowthCeremonyNoticedMemoryCatalogEntry] {
        [
            growthHornBudNoticedMemoryCatalogEntry,
            growthTailTipNoticedMemoryCatalogEntry,
            growthBodyAccentNoticedMemoryCatalogEntry
        ].compactMap { $0 }
    }

    private var growthHornBudNoticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry? {
        let cue = CreatureRenderProfile(creature: portraitCreature).growthHornBudCue
        guard cue.visibleInPortrait else {
            return nil
        }

        return GrowthCeremonyNoticedMemoryCatalog.entry(for: cue.budLabel)
    }

    private var growthTailTipNoticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry? {
        let cue = CreatureRenderProfile(creature: portraitCreature).growthTailTipCue
        guard cue.visibleInPortrait else {
            return nil
        }

        return GrowthCeremonyNoticedMemoryCatalog.entry(for: cue.cueLabel)
    }

    private var growthBodyAccentNoticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry? {
        let bodyAccent = CreatureRenderProfile(creature: portraitCreature).bodyAccent
        return GrowthCeremonyNoticedMemoryCatalog.entry(for: bodyAccent.accent)
    }

    private var growthPersistenceBoundaryContract: GrowthCeremonyPersistenceBoundaryContract? {
        guard let growthAcknowledgementIntentContract else {
            return nil
        }

        return GrowthCeremonyPersistenceBoundaryContract(
            acknowledgementIntent: growthAcknowledgementIntentContract
        )
    }

    private var growthWidgetHandoffPreflightContract: GrowthCeremonyWidgetHandoffPreflightContract? {
        guard let growthCeremonyPreview,
              let growthPersistenceBoundaryContract
        else {
            return nil
        }

        return GrowthCeremonyWidgetHandoffPreflightContract(
            plan: growthCeremonyPreview,
            persistenceBoundary: growthPersistenceBoundaryContract
        )
    }

    private var growthLineageAffectionCopy: GrowthCeremonyLineageAffectionCopy? {
        guard let growthCeremonyPreview else {
            return nil
        }

        return GrowthCeremonyLineageAffectionCopy.preview(
            plan: growthCeremonyPreview,
            parentIDs: creature.parentIDs,
            generation: creature.generation
        )
    }

    private var growthInheritedVisualMemoryBridge: GrowthCeremonyInheritedVisualMemoryBridge? {
        guard let growthCeremonyPreview,
              let growthInheritedVisualPolicy
        else {
            return nil
        }

        return GrowthCeremonyInheritedVisualMemoryBridge(
            plan: growthCeremonyPreview,
            visualPolicy: growthInheritedVisualPolicy
        )
    }

    private var growthInheritedVisualVisiblePromotionGate: GrowthCeremonyInheritedVisualVisiblePromotionGate? {
        guard let growthInheritedVisualMemoryBridge else {
            return nil
        }

        return GrowthCeremonyInheritedVisualVisiblePromotionGate(
            bridge: growthInheritedVisualMemoryBridge
        )
    }

    private var growthInheritedVisualPromotionDeferral: GrowthCeremonyInheritedVisualPromotionDeferralEvidence? {
        guard let growthInheritedVisualMemoryBridge else {
            return nil
        }

        let gate = GrowthCeremonyInheritedVisualVisiblePromotionGate(
            bridge: growthInheritedVisualMemoryBridge,
            manualCopyReviewed: true
        )
        return GrowthCeremonyInheritedVisualPromotionDeferralEvidence(gate: gate)
    }

    private var growthInheritedVisualPolicy: LineageChildDraftInheritedVisualCuePolicy? {
        guard growthCeremonyPreview != nil,
              creature.genome.morph.wing != nil || creature.genome.morph.tail != nil
        else {
            return nil
        }

        let inheritedTraitID = creature.genome.morph.tail == nil
            ? LineageMutationTrait.wing.rawValue
            : LineageMutationTrait.tail.rawValue
        let plan = LineageMutationPlan(
            source: "GrowthCeremonyPreview",
            seed: 1,
            generation: creature.generation + 1,
            inheritedTraitID: inheritedTraitID,
            mutationTraitID: growthCeremonyPreview?.traitReveal.traitID ?? "growth",
            ancestralResemblance: 0.82,
            mutationAmount: 0.12,
            resemblanceLabel: "familyMemory",
            mutationLabel: "quietGrowth",
            affinityLine: "Growth preview keeps a quiet inherited visual memory."
        )
        let preview = LineageGenomePreview(
            plan: plan,
            genome: creature.genome,
            inheritedParentID: creature.parentIDs.first ?? PreviewFixtures.firstAncestorID,
            variationParentID: creature.id,
            changedTraitID: inheritedTraitID,
            affinityLine: plan.affinityLine
        )

        return LineageChildDraftInheritedVisualCuePolicy(
            memoryReference: LineageChildDraftMemoryReference(preview: preview),
            inheritedWing: creature.genome.morph.wing,
            inheritedTail: creature.genome.morph.tail,
            sourceLabel: "observationHomeGrowthCeremony",
            inheritedFromLabel: inheritedVisualAncestorLabel
        )
    }

    private var inheritedVisualAncestorLabel: String {
        guard creature.discoveredTraits.contains(where: { $0.kind == .inheritedResemblance }) else {
            return "family"
        }

        return "firstAncestor"
    }

    private var lineageVisibleCueObservationCopy: LineageVisibleCueObservationCopy? {
        let profile = CreatureRenderProfile(creature: creature)
        guard let memory = LineageVisibleCueMemory(
            discovery: creature.discoveredTraits.last,
            traitID: "tail",
            displayName: "Floating tail",
            visibleCue: profile.silhouetteCue.tail,
            ancestorLabel: "firstAncestor"
        ) else {
            return nil
        }

        return LineageVisibleCueObservationCopy(memory: memory)
    }

    var growthCeremonyPreviewAccessibilityLabel: String? {
        guard let growthCeremonyPreview else {
            return nil
        }

        let familyMemoryLine = growthCeremonyTeaserViewModel?.familyMemoryLine ?? "growthFamilyMemoryLine:none"
        return "Growth ceremony preview: \(growthCeremonyPreview.previewTitle), \(growthCeremonyPreview.traitReveal.summary), \(growthCeremonyPreview.confirmationGate.summary), \(growthCeremonyPreview.beforeAfterObservation.summary), \(growthCeremonyPreview.mutationProof.summary), \(growthLineageCueBridgeSummary), \(growthCeremonyLineageTeaserSummary), \(growthDiscoveryLogHandoffSummary), \(lineageFamilyEntryMemorySummary), \(growthAcknowledgementGateSummary), \(growthAcknowledgementSurfaceSummary), \(growthConfirmationSurfaceSummary), \(growthAcknowledgementIntentSummary), \(growthObservationAcknowledgementSummary), \(growthNoticedMemoryLineSummary), \(growthNoticedMemoryLineReadinessSummary), \(growthBodyAccentNoticedMemoryCatalogSummary), \(growthBodyAccentNoticedMemoryCatalogReadinessSummary), \(growthNoticedMemoryPrioritySummary), \(growthNoticedMemoryPriorityReadinessSummary), \(growthHornBudCeremonyPreviewSummary), \(growthHornBudCeremonyPreviewReadinessSummary), \(growthPersistenceBoundarySummary), \(growthWidgetHandoffPreflightSummary), \(growthWidgetHandoffPreflightReadinessSummary), \(growthLineageAffectionCopySummary), \(growthLineageAffectionCopyReadinessSummary), \(growthInheritedVisualMemoryBridgeSummary), \(growthInheritedVisualMemoryBridgeReadinessSummary), \(growthInheritedVisualVisiblePromotionGateSummary), \(growthInheritedVisualVisiblePromotionGateReadinessSummary), \(growthInheritedVisualPromotionDeferralSummary), \(growthInheritedVisualPromotionDeferralReadinessSummary), \(growthInheritedVisualMemoryLine ?? "growthInheritedVisualMemoryLine:none"), \(familyMemoryLine)"
    }

    var readinessSummary: String {
        let previewState = growthCeremonyPreview == nil ? "none" : "prepared"
        return "observationHomeStateReady:true,growthCeremonyPreview:\(previewState),growthCeremonyPreviewTitle:\(growthCeremonyPreviewTitle),\(growthCeremonyTeaserReadinessSummary),\(growthCeremonyTraitRevealSummary),\(growthCeremonyConfirmationGateSummary),\(growthCeremonyBeforeAfterObservationSummary),\(growthCeremonyMutationProofSummary),\(growthLineageCueBridgeSummary),\(growthCeremonyLineageTeaserSummary),\(growthDiscoveryLogHandoffSummary),\(lineageFamilyEntryMemorySummary),\(lineageObservationMemoryTeaserSummary),\(lineageObservationMemoryTeaserReadinessSummary),\(lineageObservationMemorySheetSummary),\(lineageObservationMemorySheetReadinessSummary),\(lineageObservationFamilyTreeEntrySummary),\(lineageObservationFamilyTreeEntryReadinessSummary),\(spriteKitGrowthStageCueSummary),\(spriteKitGrowthStageCueReadinessSummary),\(spriteKitFaceLineageEchoCueSummary),\(spriteKitFaceLineageEchoCueReadinessSummary),\(spriteKitTailLineageEchoCueSummary),\(spriteKitTailLineageEchoCueReadinessSummary),\(spriteKitLineageVisualEchoPairSummary),\(spriteKitLineageVisualEchoPairReadinessSummary),\(spriteKitLineageMemoryThreadSummary),\(spriteKitLineageMemoryThreadReadinessSummary),\(spriteKitLineageCueSetSummary),\(spriteKitLineageCueSetReadinessSummary),\(growthAcknowledgementGateSummary),\(growthAcknowledgementSurfaceSummary),\(growthConfirmationSurfaceSummary),\(growthAcknowledgementIntentSummary),\(growthObservationAcknowledgementSummary),\(growthNoticedMemoryLineSummary),\(growthNoticedMemoryLineReadinessSummary),\(growthBodyAccentNoticedMemoryCatalogSummary),\(growthBodyAccentNoticedMemoryCatalogReadinessSummary),\(growthNoticedMemoryPrioritySummary),\(growthNoticedMemoryPriorityReadinessSummary),\(growthBeforeAfterStageCuePairSummary),\(growthBeforeAfterStageCuePairReadinessSummary),\(growthHornBudCeremonyPreviewSummary),\(growthHornBudCeremonyPreviewReadinessSummary),\(growthPersistenceBoundarySummary),\(growthWidgetHandoffPreflightSummary),\(growthWidgetHandoffPreflightReadinessSummary),\(growthLineageAffectionCopySummary),\(growthLineageAffectionCopyReadinessSummary),\(growthInheritedVisualMemoryBridgeSummary),\(growthInheritedVisualMemoryBridgeReadinessSummary),\(growthInheritedVisualVisiblePromotionGateSummary),\(growthInheritedVisualVisiblePromotionGateReadinessSummary),\(growthInheritedVisualPromotionDeferralSummary),\(growthInheritedVisualPromotionDeferralReadinessSummary),widgetHandoffAllowed:\(shouldPublishWidgetHandoff)"
    }
}

struct GrowthCeremonyTeaserViewModel: Equatable {
    let eyebrow: String
    let title: String
    let lineageLine: String?
    let comparisonLine: String
    let affectionLine: String?
    let continuityLine: String?
    let familyMemoryLine: String?
    let acknowledgementLine: String?
    let confirmationLine: String?
    let noticedMemoryLine: String?
    let accessibilityLabel: String
    let readinessSummary: String

    init(
        preview: GrowthCeremonyPlan,
        lineageTeaserCopy: GrowthCeremonyLineageTeaserCopy? = nil,
        lineageAffectionCopy: GrowthCeremonyLineageAffectionCopy? = nil,
        continuityLineCopy: GrowthCeremonyContinuityLineCopy? = nil,
        acknowledgementSurfaceCopy: GrowthCeremonyAcknowledgementSurfaceCopy? = nil,
        confirmationSurfaceCopy: GrowthCeremonyConfirmationSurfaceCopy? = nil,
        noticedMemoryLineCopy: GrowthCeremonyNoticedMemoryLineCopy? = nil,
        noticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry? = nil,
        eyebrow: String = "A quiet change is near"
    ) {
        self.eyebrow = eyebrow
        title = preview.previewTitle
        lineageLine = lineageTeaserCopy?.lineageLine
        comparisonLine = Self.comparisonLine(
            defaultLine: preview.beforeAfterObservation.comparisonLine,
            noticedMemoryCatalogEntry: noticedMemoryCatalogEntry
        )
        affectionLine = lineageAffectionCopy?.affectionLine
        continuityLine = continuityLineCopy?.continuityLine
        familyMemoryLine = Self.familyMemoryLine(
            preview: preview,
            lineageAffectionCopy: lineageAffectionCopy
        )
        acknowledgementLine = acknowledgementSurfaceCopy?.promptLine
        confirmationLine = confirmationSurfaceCopy?.safetyLine
        noticedMemoryLine = noticedMemoryLineCopy?.shouldDisplay == true ? noticedMemoryLineCopy?.memoryLine : nil
        accessibilityLabel = [
            lineageTeaserCopy?.accessibilityLabel,
            comparisonLine,
            lineageAffectionCopy?.affectionLine,
            continuityLineCopy?.continuityLine,
            familyMemoryLine,
            noticedMemoryLine
        ]
        .compactMap { $0 }
        .joined(separator: ", ")
        .nilIfEmpty
            ?? "Growth ceremony preview, \(preview.previewTitle)"
        readinessSummary = [
            "growthCeremonyTeaserReady:true,title:\(preview.previewTitle)",
            "comparison:\(!comparisonLine.isEmpty)",
            lineageTeaserCopy?.readinessSummary,
            lineageTeaserCopy?.summary,
            lineageAffectionCopy?.readinessSummary,
            lineageAffectionCopy?.summary,
            continuityLineCopy?.readinessSummary,
            continuityLineCopy?.summary,
            "growthFamilyMemoryLineReady:\(familyMemoryLine != nil)",
            acknowledgementSurfaceCopy?.readinessSummary,
            acknowledgementSurfaceCopy?.summary,
            confirmationSurfaceCopy?.readinessSummary,
            confirmationSurfaceCopy?.summary,
            noticedMemoryLineCopy?.readinessSummary,
            noticedMemoryLineCopy?.summary
        ]
        .compactMap { $0 }
        .joined(separator: ",")
    }

    private static func comparisonLine(
        defaultLine: String,
        noticedMemoryCatalogEntry: GrowthCeremonyNoticedMemoryCatalogEntry?
    ) -> String {
        switch noticedMemoryCatalogEntry?.cueID {
        case "softCrescentBud":
            "Watch the soft crescent buds before deciding together."
        default:
            defaultLine
        }
    }

    private static func familyMemoryLine(
        preview: GrowthCeremonyPlan,
        lineageAffectionCopy: GrowthCeremonyLineageAffectionCopy?
    ) -> String? {
        guard lineageAffectionCopy != nil else {
            return nil
        }

        return "\(preview.creatureName)'s family memories can stay with the grown shape."
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
