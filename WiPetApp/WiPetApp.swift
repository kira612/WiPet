import SpriteKit
import SwiftUI
import WiPetCore

@main
struct WiPetApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("--wipet-widget-qa-preview") {
                WidgetPreviewQAView()
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home") {
                ObservationHomeView(creature: PreviewFixtures.luma, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home-mira") {
                ObservationHomeView(creature: PreviewFixtures.mira, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home-ori") {
                ObservationHomeView(creature: PreviewFixtures.deerAncestorEcho, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home-axolotl") {
                ObservationHomeView(creature: PreviewFixtures.axolotlFriend, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home-selection-mira-observed") {
                ObservationHomeView(
                    creature: PreviewFixtures.luma,
                    observationSelectionOptions: [
                        ObservationHomeSelectionOption(id: "luma", creature: PreviewFixtures.luma, roleLabel: "current"),
                        ObservationHomeSelectionOption(id: "mira", creature: PreviewFixtures.mira, roleLabel: "sibling"),
                        ObservationHomeSelectionOption(id: "ori", creature: PreviewFixtures.deerAncestorEcho, roleLabel: "ancestor")
                    ],
                    selectedObservationID: "mira",
                    acknowledgeSelectedObservationMoment: true,
                    snapshotHostMode: true
                )
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-observation-home-selection-mira") {
                ObservationHomeView(
                    creature: PreviewFixtures.luma,
                    observationSelectionOptions: [
                        ObservationHomeSelectionOption(id: "luma", creature: PreviewFixtures.luma, roleLabel: "current"),
                        ObservationHomeSelectionOption(id: "mira", creature: PreviewFixtures.mira, roleLabel: "sibling"),
                        ObservationHomeSelectionOption(id: "ori", creature: PreviewFixtures.deerAncestorEcho, roleLabel: "ancestor")
                    ],
                    selectedObservationID: "mira",
                    snapshotHostMode: true
                )
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-genome-variation") {
                GenomeVariationQAView(snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-lineage-family") {
                LineageFamilyQAView(snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-genome-variation-preview") {
                GenomeVariationQAView()
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-lineage-family-preview") {
                LineageFamilyQAView()
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-growth-ceremony-preview") {
                ObservationHomeView(creature: PreviewFixtures.luma, previewGrowthCeremony: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-growth-ceremony-acknowledged-preview") {
                ObservationHomeView(
                    creature: PreviewFixtures.luma,
                    previewGrowthCeremony: true,
                    previewGrowthCeremonyAcknowledged: true
                )
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-growth-ceremony-horn-bud-preview") {
                ObservationHomeView(creature: PreviewFixtures.hornBudLuma, previewGrowthCeremony: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-growth-ceremony-crescent-horn-preview") {
                ObservationHomeView(creature: PreviewFixtures.crescentHornLuma, previewGrowthCeremony: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-growth-ceremony-crescent-horn-acknowledged-preview") {
                ObservationHomeView(
                    creature: PreviewFixtures.crescentHornLuma,
                    previewGrowthCeremony: true,
                    previewGrowthCeremonyAcknowledged: true
                )
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-horn-bud") {
                ObservationHomeView(creature: PreviewFixtures.hornBudLuma, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-snapshot-host-crescent-horn-bud") {
                ObservationHomeView(creature: PreviewFixtures.crescentHornLuma, snapshotHostMode: true)
            } else if ProcessInfo.processInfo.arguments.contains("--wipet-lineage-memory-sheet-preview") {
                ObservationHomeView(
                    creature: PreviewFixtures.luma,
                    previewLineageMemorySheet: true,
                    snapshotHostMode: true
                )
            } else {
                ObservationHomeView(creature: PreviewFixtures.luma)
            }
        }
    }
}

struct LineageFamilyQAView: View {
    var snapshotHostMode = false

    private let ancestorLabel = "firstAncestor"
    private let baselineID = UUID(uuidString: "C1CC1B89-7F0D-4D80-A6D5-FD73C58CC7D1")!
    private let siblingID = UUID(uuidString: "4F37B6C5-0605-4391-82BE-65F4B6B47835")!
    private let baseline = PreviewFixtures.luma
    private let sibling = PreviewFixtures.mira

    private var ancestorCopy: LineageFamilyNodeCopy {
        LineageFamilyNodeCopy(
            internalLabel: ancestorLabel,
            displayName: "Ori",
            roleLine: "Ori is remembered through a soft deer-face echo."
        )
    }

    private var familyPreview: LineageFamilyPreview {
        LineageFamilyPreview(
            ancestorLabel: ancestorLabel,
            ancestorDisplayName: ancestorCopy.displayName,
            memberNames: [baseline.name, sibling.name],
            memories: [baseline, sibling].compactMap(lineageVisibleCueMemory)
        )
    }

    private var ancestorEchoSurface: LineageAncestorEchoSurfaceCopy {
        LineageAncestorEchoSurfaceCopy(
            nodeCopy: ancestorCopy,
            familyPreview: familyPreview,
            cueLine: "Luma and Mira keep a quiet trace of Ori."
        )
    }

    private var ancestorNamingPolicy: LineageAncestorNamingPolicy {
        LineageAncestorNamingPolicy(nodeCopy: ancestorCopy)
    }

    private var snapshotHostCandidateSummary: String {
        RendererMetadataSummary.snapshotHostCandidateSummary(
            surfaceID: "lineageFamilyQA",
            viewTarget: "LineageFamilyQAView",
            snapshotTestingAvailable: true,
            manualVisualQAPassing: true,
            stableSurface: true,
            referenceImageRecorded: false,
            appTargetHostAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private var snapshotHostCandidateReadinessSummary: String {
        RendererMetadataSummary.snapshotHostCandidateReadinessSummary(
            isReady: RendererMetadataSummary.hasSnapshotHostCandidateFields(
                surfaceID: "lineageFamilyQA",
                viewTarget: "LineageFamilyQAView",
                snapshotTestingAvailable: true,
                manualVisualQAPassing: true,
                stableSurface: true,
                referenceImageRecorded: false,
                appTargetHostAdded: false,
                visibleTechnicalMetadata: false,
                appBehaviorChanged: false
            )
        )
    }

    private var snapshotHostEntrySummary: String {
        RendererMetadataSummary.snapshotHostEntrySummary(
            surfaceID: "lineageFamilyQA",
            viewTarget: "LineageFamilyQAView",
            launchArgument: "--wipet-snapshot-host-lineage-family",
            candidateReady: RendererMetadataSummary.hasSnapshotHostCandidateFields(
                surfaceID: "lineageFamilyQA",
                viewTarget: "LineageFamilyQAView",
                snapshotTestingAvailable: true,
                manualVisualQAPassing: true,
                stableSurface: true,
                referenceImageRecorded: false,
                appTargetHostAdded: false,
                visibleTechnicalMetadata: false,
                appBehaviorChanged: false
            ),
            appTargetHostAdded: true,
            referenceImageRecorded: false,
            snapshotAssertionAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private var surfacePlacement: LineageFamilySurfacePlacement {
        LineageFamilySurfacePlacement()
    }

    private var entryPointCopy: LineageFamilyEntryPointCopy {
        LineageFamilyEntryPointCopy(placement: surfacePlacement)
    }

    private var parentGenomes: [LineageParentGenome] {
        [
            LineageParentGenome(id: baselineID, genome: baseline.genome),
            LineageParentGenome(id: siblingID, genome: sibling.genome)
        ]
    }

    private var childGeneration: Int {
        max(baseline.generation, sibling.generation) + 1
    }

    private var childDraftPreview: LineageGenomePreview? {
        LineageGenomePreviewPlanner.preview(
            parents: parentGenomes,
            generation: childGeneration
        )
    }

    private var readOnlyPreviewSurfaceText: LineageReadOnlyPreviewSurfaceText? {
        LineageReadOnlyPreviewSurfaceText.preview(
            parents: parentGenomes,
            generation: childGeneration,
            inheritedParentDisplayName: baseline.name,
            variationAncestorDisplayName: sibling.name
        )
    }

    private var childDraftFamilyNode: LineageFamilyChildDraftNode? {
        childDraftPreview.map { preview in
            LineageFamilyChildDraftNode(
                acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
                    acknowledgement: LineageChildDraftAcknowledgementPreview(
                        memoryReference: LineageChildDraftMemoryReference(preview: preview)
                    )
                )
            )
        }
    }

    private var familyTreeTeaserSurface: LineageFamilyTreeTeaserSurfaceCopy {
        LineageFamilyTreeTeaserSurfaceCopy(
            entryPoint: entryPointCopy,
            childDraftNode: childDraftFamilyNode
        )
    }

    private var familyBranchPreview: LineageFamilyBranchPreview? {
        childDraftFamilyNode.map {
            LineageFamilyBranchPreview(
                ancestorNode: ancestorCopy,
                familyPreview: familyPreview,
                childDraftNode: $0
            )
        }
    }

    private var lineageBranchCaptionText: LineageBranchCaptionText? {
        guard let familyBranchPreview, let readOnlyPreviewSurfaceText else {
            return nil
        }

        let caption = LineageBranchCaptionText(
            branchPreview: familyBranchPreview,
            previewText: readOnlyPreviewSurfaceText
        )

        return caption.hasRequiredFields ? caption : nil
    }

    private var ancestorPortraitMemoryCard: LineageAncestorPortraitMemoryCardCopy? {
        guard let facePreview = LineageGenomePreviewPlanner.preview(
            parents: parentGenomes,
            generation: childGeneration,
            matchingMutationTraits: [.face],
            maxAttempts: 128
        ) else {
            return nil
        }

        let familyEchoCopy = LineageGenomeVariationFamilyEchoCopy(
            memoryReference: LineageChildDraftMemoryReference(preview: facePreview),
            inheritedParentDisplayName: sibling.name,
            variationAncestorDisplayName: ancestorCopy.displayName,
            inheritedCue: "fairy winglets",
            changedCue: "soft deer-face echo"
        )

        return LineageAncestorPortraitMemoryCardCopy(familyEchoCopy: familyEchoCopy)
    }

    private var draftMemoryCeremonyEvidence: LineageDraftMemoryCeremonyEvidence? {
        childDraftPreview.map {
            LineageDraftMemoryCeremonyEvidence(
                memoryReference: LineageChildDraftMemoryReference(preview: $0)
            )
        }
    }

    private var draftMemoryEvidenceReviewSurface: LineageDraftMemoryEvidenceReviewSurfaceCopy? {
        draftMemoryCeremonyEvidence.map {
            LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: $0)
        }
    }

    private var draftMemoryAcknowledgementReviewSurface: LineageDraftMemoryAcknowledgementReviewSurfaceCopy? {
        guard let draftMemoryEvidenceReviewSurface, let childDraftFamilyNode else {
            return nil
        }

        return LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
            evidenceReview: draftMemoryEvidenceReviewSurface,
            acknowledgementSurface: childDraftFamilyNode.acknowledgementSurface
        )
    }

    private var draftMemoryExplicitIntentGate: LineageDraftMemoryExplicitIntentGate? {
        draftMemoryAcknowledgementReviewSurface.map {
            LineageDraftMemoryExplicitIntentGate(acknowledgementReview: $0)
        }
    }

    private var draftMemoryPersistenceBoundary: LineageDraftMemoryPersistenceBoundary? {
        childDraftFamilyNode.map {
            LineageDraftMemoryPersistenceBoundary(childDraftNode: $0)
        }
    }

    private var draftMemoryPersistenceDryRunAdapter: LineageDraftMemoryPersistenceDryRunAdapter? {
        guard let draftMemoryPersistenceBoundary, let draftMemoryExplicitIntentGate else {
            return nil
        }

        return LineageDraftMemoryPersistenceDryRunAdapter(
            boundary: draftMemoryPersistenceBoundary,
            intentGate: draftMemoryExplicitIntentGate
        )
    }

    private var draftMemoryConfirmationCeremony: LineageDraftMemoryConfirmationCeremony? {
        guard let draftMemoryAcknowledgementReviewSurface,
              let draftMemoryExplicitIntentGate,
              let draftMemoryPersistenceDryRunAdapter
        else {
            return nil
        }

        return LineageDraftMemoryConfirmationCeremony(
            acknowledgementReview: draftMemoryAcknowledgementReviewSurface,
            intentGate: draftMemoryExplicitIntentGate,
            dryRunAdapter: draftMemoryPersistenceDryRunAdapter
        )
    }

    private var graphLayoutAdoptionGate: LineageFamilyGraphLayoutAdoptionGate {
        LineageFamilyGraphLayoutAdoptionGate(
            generationDepth: familyBranchPreview?.generationDepth ?? 2,
            visibleNodeCount: familyBranchPreview?.visibleNodeCount ?? 3,
            visibleEdgeCount: familyBranchPreview?.visibleEdgeCount ?? 2
        )
    }

    private var graphLayoutLibraryReview: LineageFamilyGraphLayoutLibraryReview {
        LineageFamilyGraphLayoutLibraryReview(gate: graphLayoutAdoptionGate)
    }

    private var snapshotTestingProposalSummary: String {
        RendererMetadataSummary.snapshotTestingDependencyProposalSummary(
            stableSurfaceCount: 2,
            surfaceIDs: ["lineageFamilyQA", "genomeVariationQA"],
            manualVisualQAPassing: true,
            dependencyAdded: false,
            appBehaviorChanged: false
        )
    }

    private var snapshotTestingProposalReadinessSummary: String {
        RendererMetadataSummary.snapshotTestingDependencyProposalReadinessSummary(
            isReady: RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
                stableSurfaceCount: 2,
                surfaceIDs: ["lineageFamilyQA", "genomeVariationQA"],
                manualVisualQAPassing: true,
                dependencyAdded: false,
                appBehaviorChanged: false
            )
        )
    }

    private var familyMemoryContinuityLine: String {
        "Luma's family memories can stay with the grown shape."
    }

    private var familyMemoryContinuitySummary: String {
        "lineageFamilyMemoryContinuity=source:growthCeremony,line:Luma family memories can stay with the grown shape,readOnly:true,navigation:false,persistence:false,breeding:false,optimization:false,widget:false,playerFacing:false"
    }

    private var familyMemoryContinuityReadinessSummary: String {
        "lineageFamilyMemoryContinuityReady:true"
    }

    var body: some View {
        GeometryReader { proxy in
            let isCompact = proxy.size.width < 390

            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.97, green: 0.94, blue: 0.88),
                        Color(red: 0.87, green: 0.93, blue: 0.90),
                        Color(red: 0.80, green: 0.82, blue: 0.91)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: isCompact ? 14 : 18) {
                        Text("Lineage Echo")
                            .font(.system(size: isCompact ? 34 : 40, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 0.15, green: 0.17, blue: 0.20))

                        Text("Family portrait QA")
                            .font(.system(.subheadline, design: .rounded, weight: .medium))
                            .foregroundStyle(Color(red: 0.35, green: 0.38, blue: 0.42))

                        ancestorHeader(isCompact: isCompact)

                        HStack(spacing: isCompact ? 10 : 14) {
                            portraitCard(
                                creature: baseline,
                                label: "Luma",
                                isCompact: isCompact
                            )

                            portraitCard(
                                creature: sibling,
                                label: "Mira",
                                isCompact: isCompact
                            )
                        }

                        Text(familyPreview.familyLine)
                            .font(.system(.callout, design: .rounded, weight: .medium))
                            .foregroundStyle(Color(red: 0.25, green: 0.30, blue: 0.36))
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("lineageFamilyPreviewFamilyLine")

                        Text(familyMemoryContinuityLine)
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 0.39, green: 0.42, blue: 0.48))
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("lineageFamilyMemoryContinuityLine")

                        ancestorEchoSurfaceView(isCompact: isCompact)

                        if let ancestorPortraitMemoryCard {
                            ancestorPortraitMemoryCardView(ancestorPortraitMemoryCard, isCompact: isCompact)
                        }

                        familyTreeTeaser(isCompact: isCompact)

                        if let familyBranchPreview {
                            familyBranchPreviewSurface(familyBranchPreview, isCompact: isCompact)
                        }

                        if let draftMemoryEvidenceReviewSurface {
                            evidenceReviewSurface(draftMemoryEvidenceReviewSurface, isCompact: isCompact)
                        }

                        if let draftMemoryAcknowledgementReviewSurface {
                            acknowledgementReviewSurface(draftMemoryAcknowledgementReviewSurface, isCompact: isCompact)
                        }

                        if let draftMemoryExplicitIntentGate {
                            explicitIntentGateSurface(draftMemoryExplicitIntentGate, isCompact: isCompact)
                        }

                        if let draftMemoryConfirmationCeremony {
                            confirmationCeremonySurface(draftMemoryConfirmationCeremony, isCompact: isCompact)
                        }

                        hiddenReviewMetadata
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 34)
                    .padding(.bottom, 24)
                }
            }
        }
        .accessibilityElement(children: .contain)
    }

    private var hiddenReviewMetadata: some View {
        Group {
            Text(familyPreview.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyPreviewSummary")

            Text(familyPreview.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyPreviewReadinessSummary")

            Text(ancestorCopy.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyNodeCopySummary")

            Text(ancestorNamingPolicy.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageAncestorNamingPolicySummary")

            Text(ancestorNamingPolicy.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageAncestorNamingPolicyReadinessSummary")

            Text(ancestorEchoSurface.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageAncestorEchoSurfaceSummary")

            Text(ancestorEchoSurface.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageAncestorEchoSurfaceReadinessSummary")

            if let ancestorPortraitMemoryCard {
                Text(ancestorPortraitMemoryCard.summary)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .accessibilityIdentifier("lineageAncestorPortraitMemoryCardSummary")

                Text(ancestorPortraitMemoryCard.readinessSummary)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .accessibilityIdentifier("lineageAncestorPortraitMemoryCardReadinessSummary")
            }

            Text(snapshotHostCandidateSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageSnapshotHostCandidateSummary")

            Text(snapshotHostCandidateReadinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageSnapshotHostCandidateReadinessSummary")

            if snapshotHostMode {
                Text(snapshotHostEntrySummary)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .accessibilityIdentifier("lineageSnapshotHostEntrySummary")
            }

            Text(surfacePlacement.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilySurfacePlacementSummary")

            Text(surfacePlacement.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilySurfacePlacementReadinessSummary")

            Text(entryPointCopy.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyEntryPointSummary")

            Text(entryPointCopy.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyEntryPointReadinessSummary")

            Text(childDraftFamilyNode?.summary ?? "lineageFamilyChildDraftNode:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyChildDraftNodeSummary")

            Text(childDraftFamilyNode?.readinessSummary ?? "lineageFamilyChildDraftNodeReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyChildDraftNodeReadinessSummary")

            Text(familyTreeTeaserSurface.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyTreeTeaserSurfaceSummary")

            Text(familyTreeTeaserSurface.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyTreeTeaserSurfaceReadinessSummary")

            Text(familyBranchPreview?.summary ?? "lineageFamilyBranchPreview:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyBranchPreviewSummary")

            Text(familyBranchPreview?.readinessSummary ?? "lineageFamilyBranchPreviewReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyBranchPreviewReadinessSummary")

            Text(readOnlyPreviewSurfaceText?.summary ?? "lineageReadOnlyPreviewSurfaceText:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageReadOnlyPreviewSurfaceTextSummary")

            Text(readOnlyPreviewSurfaceText?.readinessSummary ?? "lineageReadOnlyPreviewSurfaceTextReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageReadOnlyPreviewSurfaceTextReadinessSummary")

            Text(readOnlyPreviewSurfaceText?.snapshotText ?? "lineageReadOnlyPreviewSurfaceTextSnapshot:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageReadOnlyPreviewSurfaceTextSnapshot")

            Text(lineageBranchCaptionText?.summary ?? "lineageBranchCaptionText:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageBranchCaptionTextSummary")

            Text(lineageBranchCaptionText?.readinessSummary ?? "lineageBranchCaptionTextReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageBranchCaptionTextReadinessSummary")

            Text(lineageBranchCaptionText?.snapshotText ?? "lineageBranchCaptionTextSnapshot:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageBranchCaptionTextSnapshot")

            Text(familyMemoryContinuitySummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyMemoryContinuitySummary")

            Text(familyMemoryContinuityReadinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyMemoryContinuityReadinessSummary")

            Text(draftMemoryCeremonyEvidence?.summary ?? "lineageDraftMemoryCeremonyEvidence:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryCeremonyEvidenceSummary")

            Text(draftMemoryCeremonyEvidence?.readinessSummary ?? "lineageDraftMemoryCeremonyEvidenceReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryCeremonyEvidenceReadinessSummary")

            Text(draftMemoryEvidenceReviewSurface?.summary ?? "lineageDraftMemoryEvidenceReview:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryEvidenceReviewSurfaceSummary")

            Text(draftMemoryEvidenceReviewSurface?.readinessSummary ?? "lineageDraftMemoryEvidenceReviewReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryEvidenceReviewSurfaceReadinessSummary")

            Text(draftMemoryAcknowledgementReviewSurface?.summary ?? "lineageDraftMemoryAcknowledgementReview:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryAcknowledgementReviewSurfaceSummary")

            Text(draftMemoryAcknowledgementReviewSurface?.readinessSummary ?? "lineageDraftMemoryAcknowledgementReviewReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryAcknowledgementReviewSurfaceReadinessSummary")

            Text(draftMemoryExplicitIntentGate?.summary ?? "lineageDraftMemoryExplicitIntentGate:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryExplicitIntentGateSummary")

            Text(draftMemoryExplicitIntentGate?.readinessSummary ?? "lineageDraftMemoryExplicitIntentGateReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryExplicitIntentGateReadinessSummary")

            Text(draftMemoryPersistenceBoundary?.summary ?? "lineageDraftMemoryPersistence:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryPersistenceBoundarySummary")

            Text(draftMemoryPersistenceBoundary?.readinessSummary ?? "lineageDraftMemoryPersistenceReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryPersistenceBoundaryReadinessSummary")

            Text(draftMemoryPersistenceDryRunAdapter?.summary ?? "lineageDraftMemoryPersistenceDryRun:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryPersistenceDryRunAdapterSummary")

            Text(draftMemoryPersistenceDryRunAdapter?.readinessSummary ?? "lineageDraftMemoryPersistenceDryRunReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryPersistenceDryRunAdapterReadinessSummary")

            Text(draftMemoryConfirmationCeremony?.summary ?? "lineageDraftMemoryConfirmationCeremony:none")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryConfirmationCeremonySummary")

            Text(draftMemoryConfirmationCeremony?.readinessSummary ?? "lineageDraftMemoryConfirmationCeremonyReady:false")
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageDraftMemoryConfirmationCeremonyReadinessSummary")

            Text(graphLayoutAdoptionGate.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyGraphLayoutAdoptionSummary")

            Text(graphLayoutAdoptionGate.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyGraphLayoutAdoptionReadinessSummary")

            Text(graphLayoutLibraryReview.summary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyGraphLayoutLibraryReviewSummary")

            Text(graphLayoutLibraryReview.readinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("lineageFamilyGraphLayoutLibraryReviewReadinessSummary")

            Text(snapshotTestingProposalSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("snapshotTestingDependencyProposalSummary")

            Text(snapshotTestingProposalReadinessSummary)
                .frame(width: 1, height: 1)
                .opacity(0.01)
                .accessibilityIdentifier("snapshotTestingDependencyProposalReadinessSummary")
        }
    }

    private func familyBranchPreviewSurface(
        _ branch: LineageFamilyBranchPreview,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 4 : 5) {
            Text("Branch preview")
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.50))

            Text(branch.branchLine)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.30))
                .fixedSize(horizontal: false, vertical: true)

            Text(branch.statusLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.46, green: 0.49, blue: 0.54))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 8 : 9)
        .background(.white.opacity(0.26), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.48), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageFamilyBranchPreviewSurface")
    }

    private func evidenceReviewSurface(
        _ surface: LineageDraftMemoryEvidenceReviewSurfaceCopy,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 5 : 6) {
            Text(surface.title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.50))

            Text(surface.traitLine)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.20, green: 0.23, blue: 0.28))
                .fixedSize(horizontal: false, vertical: true)

            Text(surface.ancestorLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.38, green: 0.42, blue: 0.48))
                .fixedSize(horizontal: false, vertical: true)

            Text(surface.contextLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.46, green: 0.49, blue: 0.54))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 8 : 9)
        .background(.white.opacity(0.28), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.50), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageDraftMemoryEvidenceReviewSurface")
    }

    private func acknowledgementReviewSurface(
        _ surface: LineageDraftMemoryAcknowledgementReviewSurfaceCopy,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 4 : 5) {
            Text(surface.title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.44, green: 0.46, blue: 0.51))

            Text(surface.reviewLine)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.23, green: 0.26, blue: 0.31))
                .fixedSize(horizontal: false, vertical: true)

            Text(surface.waitingLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.47, green: 0.49, blue: 0.55))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 7 : 8)
        .background(.white.opacity(0.24), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.46), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageDraftMemoryAcknowledgementReviewSurface")
    }

    private func explicitIntentGateSurface(
        _ gate: LineageDraftMemoryExplicitIntentGate,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 3 : 4) {
            Text(gate.title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.45, green: 0.47, blue: 0.52))

            Text(gate.intentLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.35, green: 0.38, blue: 0.44))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 6 : 7)
        .background(.white.opacity(0.20), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.42), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageDraftMemoryExplicitIntentGateSurface")
    }

    private func confirmationCeremonySurface(
        _ ceremony: LineageDraftMemoryConfirmationCeremony,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 4 : 5) {
            Text(ceremony.title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.42, green: 0.43, blue: 0.49))

            Text(ceremony.ancestorLine)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.30))
                .fixedSize(horizontal: false, vertical: true)

            Text(ceremony.safetyLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.45, green: 0.48, blue: 0.54))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 7 : 8)
        .background(.white.opacity(0.22), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.44), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageDraftMemoryConfirmationCeremonySurface")
    }

    private func familyTreeTeaser(isCompact: Bool) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.white.opacity(0.64))
                .frame(width: isCompact ? 30 : 34, height: isCompact ? 30 : 34)
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.86), lineWidth: 1)
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(familyTreeTeaserSurface.title)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(red: 0.18, green: 0.20, blue: 0.24))
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)

                Text(familyTreeTeaserSurface.subtitleLine)
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 0.35, green: 0.39, blue: 0.45))
                    .fixedSize(horizontal: false, vertical: true)

                Text(familyTreeTeaserSurface.statusLine)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 0.48, green: 0.50, blue: 0.55))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.white.opacity(0.32), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.56), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageFamilyTreeTeaserSurface")
    }

    private func ancestorEchoSurfaceView(isCompact: Bool) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 4 : 5) {
            Text(ancestorEchoSurface.title)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.50))

            Text(ancestorEchoSurface.cueLine)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.30))
                .fixedSize(horizontal: false, vertical: true)

            Text(ancestorEchoSurface.statusLine)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.46, green: 0.49, blue: 0.54))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 8 : 9)
        .background(.white.opacity(0.28), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.50), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageAncestorEchoSurface")
    }

    private func ancestorPortraitMemoryCardView(
        _ card: LineageAncestorPortraitMemoryCardCopy,
        isCompact: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: isCompact ? 7 : 8) {
            HStack(alignment: .center, spacing: 10) {
                Circle()
                    .fill(Color.white.opacity(0.72))
                    .frame(width: isCompact ? 32 : 36, height: isCompact ? 32 : 36)
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.86), lineWidth: 1)
                    }
                    .overlay {
                        Text(String(card.familyEchoCopy.variationAncestorDisplayName.prefix(1)))
                            .font(.system(size: isCompact ? 14 : 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 0.33, green: 0.37, blue: 0.42))
                    }
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 3) {
                    Text(card.title)
                        .font(.system(.caption, design: .rounded, weight: .semibold))
                        .textCase(.uppercase)
                        .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.50))

                    Text(card.ancestorPortraitLabel)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.30))
                }

                Spacer(minLength: 0)
            }

            Text(card.inheritedCueLine)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.36, green: 0.40, blue: 0.46))
                .fixedSize(horizontal: false, vertical: true)

            Text(card.changedCueLine)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.36, green: 0.40, blue: 0.46))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, isCompact ? 9 : 10)
        .background(.white.opacity(0.30), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.52), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageAncestorPortraitMemoryCard")
    }

    private func ancestorHeader(isCompact: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Remembered ancestor")
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.45, green: 0.49, blue: 0.54))

            HStack(spacing: 10) {
                Circle()
                    .fill(Color.white.opacity(0.76))
                    .frame(width: isCompact ? 34 : 38, height: isCompact ? 34 : 38)
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.9), lineWidth: 1)
                    }

                Text(ancestorCopy.displayName)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(red: 0.18, green: 0.20, blue: 0.24))

                Spacer(minLength: 0)
            }

            Text(ancestorCopy.roleLine)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.38, green: 0.42, blue: 0.48))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .background(.white.opacity(0.34), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.56), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageFamilyPreviewAncestor")
    }

    private func portraitCard(
        creature: Creature,
        label: String,
        isCompact: Bool
    ) -> some View {
        let memory = lineageVisibleCueMemory(for: creature)
        let profile = CreatureRenderProfile(creature: creature)
        let memoryLine = memory.map(ancestorCopy.memoryLine(for:)) ?? "No ancestor echo yet."

        return VStack(spacing: 8) {
            SpriteView(
                scene: CreatureScene(creature: creature),
                options: [.allowsTransparency]
            )
            .frame(height: isCompact ? 204 : 240)
            .accessibilityLabel("\(creature.name)'s family portrait")

            Text(label)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

            Text(memoryLine)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.39, green: 0.43, blue: 0.49))
                .lineLimit(2)
                .minimumScaleFactor(0.82)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, isCompact ? 8 : 10)
        .padding(.vertical, 12)
        .background(.white.opacity(0.44), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.62), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("lineageFamilyPreview\(creature.name)Portrait")
        .accessibilityLabel("\(creature.name), \(profile.genomeVisualVariationSummary), \(memory?.summary ?? "lineageVisibleCue:none")")
    }

    private func lineageVisibleCueMemory(for creature: Creature) -> LineageVisibleCueMemory? {
        let profile = CreatureRenderProfile(creature: creature)
        let genomeCue = GenomeVisibleCueMemory(
            traitID: "tail",
            displayName: profile.silhouetteCue.tail == "fishFin" ? "Fish tail" : "Floating tail",
            visibleCue: profile.silhouetteCue.tail,
            genomeSummary: profile.genomeVisualVariationSummary
        )

        return genomeCue.lineageMemory(
            discovery: creature.discoveredTraits.last,
            ancestorLabel: ancestorLabel
        )
    }
}

struct GenomeVariationQAView: View {
    private let snapshotHostMode: Bool
    private let baselineID = UUID(uuidString: "C1CC1B89-7F0D-4D80-A6D5-FD73C58CC7D1")!
    private let siblingID = UUID(uuidString: "4F37B6C5-0605-4391-82BE-65F4B6B47835")!
    private let deerAncestorID = UUID(uuidString: "45B571D6-32AD-4C02-A58D-79941AE5E7DA")!
    private let baseline = PreviewFixtures.luma
    private let sibling = PreviewFixtures.mira
    private let deerAncestor = PreviewFixtures.deerAncestorEcho
    private let dragonTailProbe = Creature(
        name: "Drakelet",
        species: .aquarian,
        genome: Genome(morph: MorphGenes(face: .dragon, body: .aquarian, wing: .dragon, tail: .dragon)),
        growthStage: .juvenile,
        generation: 2
    )

    init(snapshotHostMode: Bool = false) {
        self.snapshotHostMode = snapshotHostMode
    }

    private var parentGenomes: [LineageParentGenome] {
        [
            LineageParentGenome(id: baselineID, genome: baseline.genome),
            LineageParentGenome(id: siblingID, genome: sibling.genome),
            LineageParentGenome(id: deerAncestorID, genome: deerAncestor.genome)
        ]
    }

    private var childGeneration: Int {
        max(baseline.generation, sibling.generation) + 1
    }

    private var childPreview: LineageGenomePreview? {
        deerAncestorFacePreview ?? LineageGenomePreviewPlanner.preview(
            parents: parentGenomes,
            generation: childGeneration
        )
    }

    private var deerAncestorFacePreview: LineageGenomePreview? {
        LineageGenomePreviewPlanner.preview(
            parents: parentGenomes,
            generation: childGeneration,
            matchingMutationTraits: [.face],
            preferredVariationParentID: deerAncestorID,
            saltPrefix: "WiPetGenomeVariationDeerEcho",
            maxAttempts: 128
        )
    }

    private var childDraftCreature: Creature? {
        childPreview.map { preview in
            Creature(
                name: "Child draft",
                species: .lunarian,
                genome: preview.genome,
                growthStage: .juvenile,
                generation: childGeneration,
                parentIDs: [baselineID, siblingID],
                discoveredTraits: [
                    DiscoveryEvent(
                        title: "Ori's soft deer face glimmers through the child draft.",
                        kind: .inheritedResemblance,
                        stage: .juvenile,
                        relatedAncestorID: deerAncestorID
                    )
                ]
            )
        }
    }

    private var childDraftInheritedVisualCuePolicy: LineageChildDraftInheritedVisualCuePolicy? {
        guard let childPreview else {
            return nil
        }

        return LineageChildDraftInheritedVisualCuePolicy(
            memoryReference: LineageChildDraftMemoryReference(preview: childPreview),
            inheritedWing: sibling.genome.morph.wing,
            inheritedTail: sibling.genome.morph.tail,
            inheritedFromLabel: "Mira"
        )
    }

    private var childDraftRenderCreature: Creature? {
        childDraftCreature.map { draft in
            let renderGenome = childDraftInheritedVisualCuePolicy?
                .renderGenome(for: draft.genome) ?? draft.genome

            return Creature(
                id: draft.id,
                name: draft.name,
                species: draft.species,
                genome: renderGenome,
                growthStage: draft.growthStage,
                generation: draft.generation,
                parentIDs: draft.parentIDs,
                discoveredTraits: draft.discoveredTraits
            )
        }
    }

    var body: some View {
        GeometryReader { proxy in
            let isCompact = proxy.size.width < 390

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

                VStack(alignment: .leading, spacing: isCompact ? 16 : 20) {
                    Text("Genome Variation")
                        .font(.system(size: isCompact ? 34 : 40, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.15, green: 0.17, blue: 0.20))

                    Text("Sibling portrait QA")
                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.35, green: 0.38, blue: 0.42))

                    HStack(spacing: isCompact ? 10 : 14) {
                        portraitCard(
                            creature: baseline,
                            label: "Luma baseline",
                            identifier: "genomeVariationBaselinePortrait",
                            isCompact: isCompact
                        )

                        portraitCard(
                            creature: sibling,
                            label: "Mira sibling",
                            identifier: "genomeVariationSiblingPortrait",
                            isCompact: isCompact
                        )
                    }

                    childDraftCard(isCompact: isCompact)

                    Text(genomeVariationFamilyEchoLine)
                        .font(.system(.callout, design: .rounded, weight: .medium))
                        .foregroundStyle(Color(red: 0.25, green: 0.30, blue: 0.36))
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityIdentifier("genomeVariationTraitSummary")

                    Text(genomeVariationFamilyEchoCopySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageGenomeVariationFamilyEchoCopySummary")

                    Text(genomeVariationFamilyEchoCopyReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageGenomeVariationFamilyEchoCopyReadinessSummary")

                    Text(ancestorPortraitCueLine)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationAncestorPortraitCueLine")

                    Text(genomeVariationBaselineFaceAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineFaceAccentSummary")

                    Text(genomeVariationBaselineFaceAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineFaceAccentReadinessSummary")

                    Text(genomeVariationSiblingFaceAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingFaceAccentSummary")

                    Text(genomeVariationSiblingFaceAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingFaceAccentReadinessSummary")

                    Text(genomeVariationSiblingBodyAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodyAccentSummary")

                    Text(genomeVariationSiblingBodyAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodyAccentReadinessSummary")

                    Text(genomeVariationSiblingWingAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingWingAccentSummary")

                    Text(genomeVariationSiblingWingAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingWingAccentReadinessSummary")

                    Text(genomeVariationBaselineBodyAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineBodyAccentSummary")

                    Text(genomeVariationBaselineBodyAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineBodyAccentReadinessSummary")

                    Text(genomeVariationBaselineBodySilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineBodySilhouetteAccessorySummary")

                    Text(genomeVariationBaselineBodySilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineBodySilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationBaselineTailSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineTailSilhouetteAccessorySummary")

                    Text(genomeVariationBaselineTailSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationBaselineTailSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationSiblingFaceSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingFaceSilhouetteAccessorySummary")

                    Text(genomeVariationSiblingFaceSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingFaceSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationSiblingBodySilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodySilhouetteAccessorySummary")

                    Text(genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationSiblingWingSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingWingSilhouetteAccessorySummary")

                    Text(genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationSiblingTailSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingTailSilhouetteAccessorySummary")

                    Text(genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationDragonTailSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationDragonTailSilhouetteAccessorySummary")

                    Text(genomeVariationDragonTailSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationDragonTailSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationAncestorBodySilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationAncestorBodySilhouetteAccessorySummary")

                    Text(genomeVariationAncestorBodySilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationAncestorBodySilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationAncestorTailSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationAncestorTailSilhouetteAccessorySummary")

                    Text(genomeVariationAncestorTailSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationAncestorTailSilhouetteAccessoryReadinessSummary")

                    Text(genomeVariationSilhouetteCueSetAcceptanceSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSilhouetteCueSetAcceptanceSummary")

                    Text(genomeVariationSilhouetteCueSetAcceptanceReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSilhouetteCueSetAcceptanceReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceCoverageSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceCoverageSummary")

                    Text(CreatureRenderProfile.fixedPartHornBaseReferenceEvidenceHandoffSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartHornBaseReferenceEvidenceHandoffSummary")

                    Text(CreatureRenderProfile.fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartVocabularyBridgeSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartVocabularyBridgeSummary")

                    Text(CreatureRenderProfile.fixedPart2DRecipeBridgeSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPart2DRecipeBridgeSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryRecipeBridgeSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryRecipeBridgeSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryRecipeBridgeReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryRecipeBridgeReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceAnnotationSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceAnnotationSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceAnnotationReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceAnnotationReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceSheetPreflightSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceSheetPreflightSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceSheetPreflightReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceSheetPreflightReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceSheetPanelNotesSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceSheetPanelNotesSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryManualReviewChecklistSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryManualReviewChecklistSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryManualReviewChecklistReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryManualReviewChecklistReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReviewEvidenceHandoffSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReviewEvidenceHandoffSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryReviewEvidenceHandoffReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryReviewEvidenceHandoffReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryArtifactCandidateRecordSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryArtifactCandidateRecordSummary")

                    Text(CreatureRenderProfile.fixedPartAccessoryArtifactCandidateRecordReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAccessoryArtifactCandidateRecordReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartAssetSocketMappingSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAssetSocketMappingSummary")

                    Text(CreatureRenderProfile.fixedPartAssetSocketMappingReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartAssetSocketMappingReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartUpperBodyProportionHandoffSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartUpperBodyProportionHandoffSummary")

                    Text(CreatureRenderProfile.fixedPartUpperBodyProportionHandoffReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartUpperBodyProportionHandoffReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartTailFloatingHandoffSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartTailFloatingHandoffSummary")

                    Text(CreatureRenderProfile.fixedPartTailFloatingHandoffReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartTailFloatingHandoffReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartLineageCueReferenceAnnotationSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartLineageCueReferenceAnnotationSummary")

                    Text(CreatureRenderProfile.fixedPartLineageCueReferenceAnnotationReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartLineageCueReferenceAnnotationReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartChildDraftLineageCueReferenceSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartChildDraftLineageCueReferenceSummary")

                    Text(CreatureRenderProfile.fixedPartChildDraftLineageCueReferenceReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartChildDraftLineageCueReferenceReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartChildDraftLineageCueAcceptanceGateSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartChildDraftLineageCueAcceptanceGateSummary")

                    Text(CreatureRenderProfile.fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartLineageCueSetReferenceSheetSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartLineageCueSetReferenceSheetSummary")

                    Text(CreatureRenderProfile.fixedPartLineageCueSetReferenceSheetReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartLineageCueSetReferenceSheetReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetPanelLayoutSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetPanelLayoutSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetPanelLayoutReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetPanelLayoutReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetAcceptanceGateSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetAcceptanceGateSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetAcceptanceGateReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetAcceptanceGateReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetArtifactNamingSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetArtifactNamingSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetArtifactNamingReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetArtifactNamingReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetManualReviewChecklistSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetManualReviewChecklistSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetManualReviewChecklistReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetManualReviewChecklistReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetManualReviewResultStateSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetManualReviewResultStateSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetManualReviewResultStateReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetManualReviewResultStateReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetReviewEvidenceFieldsSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetReviewEvidenceFieldsSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetPNGCandidatePreflightSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetPNGCandidatePreflightSummary")

                    Text(CreatureRenderProfile.fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary")

                    Text(CreatureRenderProfile.fixedPart3DManifestSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPart3DManifestSummary")

                    Text(CreatureRenderProfile.fixedPart3DManifestReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPart3DManifestReadinessSummary")

                    Text(CreatureRenderProfile.fixedPart3DReferenceAcceptanceGateSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPart3DReferenceAcceptanceGateSummary")

                    Text(CreatureRenderProfile.fixedPart3DReferenceAcceptanceGateReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPart3DReferenceAcceptanceGateReadinessSummary")

                    Text(CreatureRenderProfile.commonPetRigSocketMapSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("commonPetRigSocketMapSummary")

                    Text(CreatureRenderProfile.commonPetRigSocketMapReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("commonPetRigSocketMapReadinessSummary")

                    Text(CreatureRenderProfile.commonPetRigAssetValidationPreflightSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("commonPetRigAssetValidationPreflightSummary")

                    Text(CreatureRenderProfile.commonPetRigAssetValidationPreflightReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("commonPetRigAssetValidationPreflightReadinessSummary")

                    Text(genomeVariationPartFamilySelectionSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationPartFamilySelectionSummary")

                    Text(fixedPartShapeRecipeCoverageSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartShapeRecipeCoverageSummary")

                    Text(fixedPartShapeRecipeCoverageReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartShapeRecipeCoverageReadinessSummary")

                    Text(fixedPartDetailRecipeCoverageSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartDetailRecipeCoverageSummary")

                    Text(fixedPartDetailRecipeCoverageReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("fixedPartDetailRecipeCoverageReadinessSummary")
                        .overlay {
                            VStack(spacing: 0) {
                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(glowAmbientRecipeCoverageSummary)
                                    .accessibilityIdentifier("glowAmbientRecipeCoverageSummary")

                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(glowAmbientRecipeCoverageReadinessSummary)
                                    .accessibilityIdentifier("glowAmbientRecipeCoverageReadinessSummary")

                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(patternRecipeCoverageSummary)
                                    .accessibilityIdentifier("patternRecipeCoverageSummary")

                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(patternRecipeCoverageReadinessSummary)
                                    .accessibilityIdentifier("patternRecipeCoverageReadinessSummary")

                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(coreImagePatternGenerationPreflightSummary)
                                    .accessibilityIdentifier("coreImagePatternGenerationPreflightSummary")

                                Text("")
                                    .frame(width: 1, height: 1)
                                    .opacity(0.01)
                                    .accessibilityLabel(coreImagePatternGenerationPreflightReadinessSummary)
                                    .accessibilityIdentifier("coreImagePatternGenerationPreflightReadinessSummary")
                            }
                        }

                    Text(genomeVisibleCueMemorySummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVisibleCueMemorySummary")

                    Text(lineageVisibleCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageVisibleCueSummary")

                    Text(lineageVisibleCueObservationCopySummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageVisibleCueObservationCopySummary")

                    Text(spriteKitMotionGeneCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitMotionGeneCueSummary")

                    Text(spriteKitMotionGeneCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitMotionGeneCueReadinessSummary")

                    Text(personalityBlinkCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityBlinkCueSummary")

                    Text(personalityBlinkCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityBlinkCueReadinessSummary")

                    Text(personalitySleepinessIdleCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalitySleepinessIdleCueSummary")

                    Text(personalitySleepinessIdleCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalitySleepinessIdleCueReadinessSummary")

                    Text(spriteKitGrowthHornBudCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthHornBudCueSummary")

                    Text(spriteKitGrowthHornBudCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthHornBudCueReadinessSummary")

                    Text(spriteKitGrowthTailTipCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthTailTipCueSummary")

                    Text(spriteKitGrowthTailTipCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthTailTipCueReadinessSummary")

                    Text(lineageGenomePreviewSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageGenomePreviewSummary")

                    Text(lineageGenomePreviewRenderSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageGenomePreviewRenderSummary")

                    Text(lineageMutationDistributionSampleSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageMutationDistributionSampleSummary")

                    Text(lineageMutationAffectionProfileSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageMutationAffectionProfileSummary")

                    Text(lineageMutationAffectionProfileReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageMutationAffectionProfileReadinessSummary")

                    Text(lineageChildDraftMemorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftMemorySummary")

                    Text(lineageChildDraftSilhouetteCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftSilhouetteCueSummary")

                    Text(lineageChildDraftFaceAccentSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftFaceAccentSummary")

                    Text(lineageChildDraftFaceAccentReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftFaceAccentReadinessSummary")

                    Text(lineageChildDraftFaceSilhouetteAccessorySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftFaceSilhouetteAccessorySummary")

                    Text(lineageChildDraftFaceSilhouetteAccessoryReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftFaceSilhouetteAccessoryReadinessSummary")

                    Text(lineageChildDraftInheritedFaceEchoSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedFaceEchoSummary")

                    Text(lineageChildDraftInheritedFaceEchoReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedFaceEchoReadinessSummary")

                    Text(lineageChildDraftAcknowledgementSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftAcknowledgementSummary")

                    Text(lineageChildDraftAcknowledgementSurfaceSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftAcknowledgementSurfaceSummary")

                    Text(spriteKitPatternMarkingCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitPatternMarkingCueSummary")

                    Text(spriteKitBodyProportionCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitBodyProportionCueSummary")

                    Text(spriteKitBodyProportionCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitBodyProportionCueReadinessSummary")

                    Text(CreatureRenderProfile(creature: baseline).spriteKitGrowthStageCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthStageCueSummary")

                    Text(CreatureRenderProfile(creature: baseline).spriteKitGrowthStageCueReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGrowthStageCueReadinessSummary")

                    Text(spriteKitBodyProportionCueSummary(for: sibling))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodyProportionCueSummary")

                    Text(spriteKitBodyProportionCueReadinessSummary(for: sibling))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("genomeVariationSiblingBodyProportionCueReadinessSummary")

                    Text(personalityEyeCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeCueSummary")

                    Text(personalityEyeCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeCueReadinessSummary")

                    Text(personalityEyeGazeCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeGazeCueSummary")

                    Text(personalityEyeGazeCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeGazeCueReadinessSummary")

                    Text(personalityEyeDetailSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeDetailSummary")

                    Text(personalityEyeDetailReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityEyeDetailReadinessSummary")

                    Text(personalityCheekWarmthCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityCheekWarmthCueSummary")

                    Text(personalityCheekWarmthCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityCheekWarmthCueReadinessSummary")

                    Text(personalityMouthCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityMouthCueSummary")

                    Text(personalityMouthCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityMouthCueReadinessSummary")

                    Text(personalityPostureCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityPostureCueSummary")

                    Text(personalityPostureCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityPostureCueReadinessSummary")

                    Text(spriteKitGlowAuraCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGlowAuraCueSummary")

                    Text(spriteKitGlowAuraCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitGlowAuraCueReadinessSummary")

                    Text(personalityMysticismAuraCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityMysticismAuraCueSummary")

                    Text(personalityMysticismAuraCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("personalityMysticismAuraCueReadinessSummary")

                    Text(spriteKitAncestralGlintCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitAncestralGlintCueSummary")

                    Text(spriteKitAncestralGlintCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitAncestralGlintCueReadinessSummary")

                    Text(lineageChildDraftAncestralGlintCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftAncestralGlintCueSummary")

                    Text(spriteKitFaceLineageEchoCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitFaceLineageEchoCueSummary")

                    Text(spriteKitFaceLineageEchoCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitFaceLineageEchoCueReadinessSummary")

                    Text(lineageChildDraftFaceLineageEchoCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftFaceLineageEchoCueSummary")

                    Text(lineageChildDraftWingLineageEchoCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftWingLineageEchoCueSummary")

                    Text(lineageChildDraftWingLineageEchoCueReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftWingLineageEchoCueReadinessSummary")

                    Text(lineageChildDraftInheritedWingletVisualSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedWingletVisualSummary")

                    Text(lineageChildDraftInheritedWingletVisualReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedWingletVisualReadinessSummary")

                    Text(lineageChildDraftInheritedTailFinVisualSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedTailFinVisualSummary")

                    Text(lineageChildDraftInheritedTailFinVisualReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedTailFinVisualReadinessSummary")

                    Text(lineageChildDraftInheritedVisualCuePolicySummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedVisualCuePolicySummary")

                    Text(lineageChildDraftInheritedVisualCuePolicyReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftInheritedVisualCuePolicyReadinessSummary")

                    Text(spriteKitLineageMemoryThreadSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitLineageMemoryThreadSummary")

                    Text(spriteKitLineageMemoryThreadReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitLineageMemoryThreadReadinessSummary")

                    Text(lineageChildDraftLineageMemoryThreadSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftLineageMemoryThreadSummary")

                    Text(spriteKitTailLineageEchoCueSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitTailLineageEchoCueSummary")

                    Text(spriteKitTailLineageEchoCueReadinessSummary(for: baseline))
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("spriteKitTailLineageEchoCueReadinessSummary")

                    Text(lineageChildDraftTailLineageEchoCueSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftTailLineageEchoCueSummary")

                    Text(lineageChildDraftLineageCueSetSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftLineageCueSetSummary")

                    Text(lineageChildDraftLineageCueSetReadinessSummary)
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                        .accessibilityIdentifier("lineageChildDraftLineageCueSetReadinessSummary")

                    if snapshotHostMode {
                        Text(snapshotHostEntrySummary)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .accessibilityIdentifier("snapshotHostEntrySummary")

                        Text(snapshotImageCandidateSummary)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .accessibilityIdentifier("snapshotImageCandidateSummary")

                        Text(snapshotImageCandidateReadinessSummary)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .accessibilityIdentifier("snapshotImageCandidateReadinessSummary")

                        Text(snapshotAppTargetEntrySummary)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .accessibilityIdentifier("snapshotAppTargetEntrySummary")

                        Text(snapshotAppTargetEntryReadinessSummary)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .accessibilityIdentifier("snapshotAppTargetEntryReadinessSummary")
                    }

                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 22)
                .padding(.top, 34)
                .padding(.bottom, 24)
            }
        }
        .accessibilityElement(children: .contain)
    }

    private var lineageGenomePreviewSummary: String {
        childPreview?.summary ?? "lineageGenomePreview:none"
    }

    private var lineageGenomePreviewRenderSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).genomeVisualVariationSummary }
            ?? "lineageGenomePreviewRender:none"
    }

    private var lineageMutationDistributionSampleSummary: String {
        LineageMutationPlanner.distributionSample(
            parentIDs: parentGenomes.map(\.id),
            generationRange: childGeneration ..< childGeneration + 4,
            salt: "WiPetGenomeVariationDeerEcho"
        )?.summary ?? "lineageMutationDistributionSample:none"
    }

    private var lineageMutationAffectionProfileSummary: String {
        LineageMutationPlanner.affectionProfile(
            parentIDs: parentGenomes.map(\.id),
            generation: childGeneration,
            salt: "WiPetGenomeVariationDeerEcho"
        )?.summary ?? "lineageMutationAffectionProfile:none"
    }

    private var lineageMutationAffectionProfileReadinessSummary: String {
        LineageMutationPlanner.affectionProfile(
            parentIDs: parentGenomes.map(\.id),
            generation: childGeneration,
            salt: "WiPetGenomeVariationDeerEcho"
        )?.readinessSummary ?? "lineageMutationAffectionProfileReady:false"
    }

    private var childDraftFamilyEchoLine: String {
        guard childDraftCreature?.genome.morph.face == .deer,
              childPreview?.variationParentID == deerAncestorID
        else {
            return "Mostly family-like, with one gentle planned difference."
        }

        return "Mostly family-like, with Ori's soft deer-face echo."
    }

    private var ancestorPortraitCueLine: String {
        "soft deer face"
    }

    private var genomeVariationFamilyEchoCopy: LineageGenomeVariationFamilyEchoCopy? {
        childPreview.map { preview in
            LineageGenomeVariationFamilyEchoCopy(
                memoryReference: LineageChildDraftMemoryReference(preview: preview),
                inheritedParentDisplayName: "Mira",
                variationAncestorDisplayName: "Ori",
                inheritedCue: inheritedVisibleCueName(for: sibling),
                changedCue: childChangedCueName
            )
        }
    }

    private var genomeVariationFamilyEchoLine: String {
        genomeVariationFamilyEchoCopy?.visibleLine
            ?? "The family resemblance stays soft: Mira carries a visible family cue, and the child draft may show Ori's echo."
    }

    private var genomeVariationFamilyEchoCopySummary: String {
        genomeVariationFamilyEchoCopy?.summary
            ?? "lineageGenomeVariationFamilyEchoCopy:none"
    }

    private var genomeVariationFamilyEchoCopyReadinessSummary: String {
        genomeVariationFamilyEchoCopy?.readinessSummary
            ?? "lineageGenomeVariationFamilyEchoCopyReady:false"
    }

    private var genomeVariationBaselineFaceAccentSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitFaceCueAccentSummary
    }

    private var genomeVariationBaselineFaceAccentReadinessSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitFaceCueAccentReadinessSummary
    }

    private var genomeVariationSiblingFaceAccentSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitFaceCueAccentSummary
    }

    private var genomeVariationSiblingFaceAccentReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitFaceCueAccentReadinessSummary
    }

    private var genomeVariationSiblingBodyAccentSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitBodyCueAccentSummary
    }

    private var genomeVariationSiblingBodyAccentReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitBodyCueAccentReadinessSummary
    }

    private var genomeVariationSiblingWingAccentSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitWingCueAccentSummary
    }

    private var genomeVariationSiblingWingAccentReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitWingCueAccentReadinessSummary
    }

    private var genomeVariationBaselineBodyAccentSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitBodyCueAccentSummary
    }

    private var genomeVariationBaselineBodyAccentReadinessSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitBodyCueAccentReadinessSummary
    }

    private var genomeVariationBaselineBodySilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitBodySilhouetteAccessoryCueSummary
    }

    private var genomeVariationBaselineBodySilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitBodySilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationBaselineTailSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitTailSilhouetteAccessoryCueSummary
    }

    private var genomeVariationBaselineTailSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: baseline).spriteKitTailSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationSiblingBodySilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitBodySilhouetteAccessoryCueSummary
    }

    private var genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitBodySilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationSiblingFaceSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitFaceSilhouetteAccessoryCueSummary
    }

    private var genomeVariationSiblingFaceSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitFaceSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationSiblingWingSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitWingSilhouetteAccessoryCueSummary
    }

    private var genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitWingSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationSiblingTailSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitTailSilhouetteAccessoryCueSummary
    }

    private var genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: sibling).spriteKitTailSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationDragonTailSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: dragonTailProbe).spriteKitTailSilhouetteAccessoryCueSummary
    }

    private var genomeVariationDragonTailSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: dragonTailProbe).spriteKitTailSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationAncestorBodySilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: deerAncestor).spriteKitBodySilhouetteAccessoryCueSummary
    }

    private var genomeVariationAncestorBodySilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: deerAncestor).spriteKitBodySilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationAncestorTailSilhouetteAccessorySummary: String {
        CreatureRenderProfile(creature: deerAncestor).spriteKitTailSilhouetteAccessoryCueSummary
    }

    private var genomeVariationAncestorTailSilhouetteAccessoryReadinessSummary: String {
        CreatureRenderProfile(creature: deerAncestor).spriteKitTailSilhouetteAccessoryCueReadinessSummary
    }

    private var genomeVariationSilhouetteCueSetAcceptanceSummary: String {
        RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceSummary(
            surfaceID: "genomeVariationQA",
            faceReadiness: lineageChildDraftFaceSilhouetteAccessoryReadinessSummary,
            bodyReadiness: genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary,
            wingReadiness: genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary,
            tailReadiness: genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary,
            manualVisualQAPassing: true,
            snapshotReferenceRecorded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false,
            assetOutputs: "none"
        )
    }

    private var genomeVariationSilhouetteCueSetAcceptanceReadinessSummary: String {
        RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceReadinessSummary(
            isReady: RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
                surfaceID: "genomeVariationQA",
                faceReadiness: lineageChildDraftFaceSilhouetteAccessoryReadinessSummary,
                bodyReadiness: genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary,
                wingReadiness: genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary,
                tailReadiness: genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary,
                manualVisualQAPassing: true,
                snapshotReferenceRecorded: false,
                visibleTechnicalMetadata: false,
                appBehaviorChanged: false,
                assetOutputs: "none"
            )
        )
    }

    private var childChangedCueName: String {
        guard childDraftCreature?.genome.morph.face == .deer,
              childPreview?.variationParentID == deerAncestorID
        else {
            return "gentle \(childPreview?.changedTraitID ?? "family") cue"
        }

        return "soft deer-face echo"
    }

    private var genomeVariationPartFamilySelectionSummary: String {
        let baselineSummary = partFamilySelectionSummary(for: baseline)
        let siblingSummary = partFamilySelectionSummary(for: sibling)
        let childSummary = childDraftRenderCreature
            .map(partFamilySelectionSummary(for:))
            ?? "child:none"
        let ancestorSummary = partFamilySelectionSummary(for: deerAncestor)
        return "genomeVariationPartFamilies=baseline{\(baselineSummary)}|sibling{\(siblingSummary)}|child{\(childSummary)}|ancestor{\(ancestorSummary)}"
    }

    private var fixedPartShapeRecipeCoverageSummary: String {
        let baselineSummary = shapeRecipeCoverageSummary(for: baseline)
        let siblingSummary = shapeRecipeCoverageSummary(for: sibling)
        let childSummary = childDraftRenderCreature
            .map(shapeRecipeCoverageSummary(for:))
            ?? "child:none"
        let ancestorSummary = shapeRecipeCoverageSummary(for: deerAncestor)
        return "fixedPartShapeRecipeCoverage=baseline{\(baselineSummary)}|sibling{\(siblingSummary)}|child{\(childSummary)}|ancestor{\(ancestorSummary)}"
    }

    private var fixedPartShapeRecipeCoverageReadinessSummary: String {
        let isReady = [baseline, sibling]
            .map { shapeRecipeCoverageReady(for: $0) }
            .allSatisfy { $0 }
            && childDraftRenderCreature.map(shapeRecipeCoverageReady(for:)) == true
            && shapeRecipeCoverageReady(for: deerAncestor)
        return "fixedPartShapeRecipeCoverageReady:\(isReady)"
    }

    private var fixedPartDetailRecipeCoverageSummary: String {
        let baselineSummary = detailRecipeCoverageSummary(for: baseline)
        let siblingSummary = detailRecipeCoverageSummary(for: sibling)
        let childSummary = childDraftRenderCreature
            .map(detailRecipeCoverageSummary(for:))
            ?? "child:none"
        let ancestorSummary = detailRecipeCoverageSummary(for: deerAncestor)
        return "fixedPartDetailRecipeCoverage=baseline{\(baselineSummary)}|sibling{\(siblingSummary)}|child{\(childSummary)}|ancestor{\(ancestorSummary)}"
    }

    private var fixedPartDetailRecipeCoverageReadinessSummary: String {
        let isReady = [baseline, sibling]
            .map { detailRecipeCoverageReady(for: $0) }
            .allSatisfy { $0 }
            && childDraftRenderCreature.map(detailRecipeCoverageReady(for:)) == true
            && detailRecipeCoverageReady(for: deerAncestor)
        return "fixedPartDetailRecipeCoverageReady:\(isReady)"
    }

    private var glowAmbientRecipeCoverageSummary: String {
        let baselineSummary = glowAmbientRecipeCoverageSummary(for: baseline)
        let siblingSummary = glowAmbientRecipeCoverageSummary(for: sibling)
        let childSummary = childDraftRenderCreature
            .map(glowAmbientRecipeCoverageSummary(for:))
            ?? "child:none"
        return "glowAmbientRecipeCoverage=baseline{\(baselineSummary)}|sibling{\(siblingSummary)}|child{\(childSummary)}"
    }

    private var glowAmbientRecipeCoverageReadinessSummary: String {
        let isReady = [baseline, sibling]
            .map { glowAmbientRecipeCoverageReady(for: $0) }
            .allSatisfy { $0 }
            && childDraftRenderCreature.map(glowAmbientRecipeCoverageReady(for:)) == true
        return "glowAmbientRecipeCoverageReady:\(isReady)"
    }

    private var patternRecipeCoverageSummary: String {
        let baselineSummary = patternRecipeCoverageSummary(for: baseline)
        let siblingSummary = patternRecipeCoverageSummary(for: sibling)
        let childSummary = childDraftRenderCreature
            .map(patternRecipeCoverageSummary(for:))
            ?? "child:none"
        return "patternRecipeCoverage=baseline{\(baselineSummary)}|sibling{\(siblingSummary)}|child{\(childSummary)}"
    }

    private var patternRecipeCoverageReadinessSummary: String {
        let isReady = [baseline, sibling]
            .map { patternRecipeCoverageReady(for: $0) }
            .allSatisfy { $0 }
            && childDraftRenderCreature.map(patternRecipeCoverageReady(for:)) == true
        return "patternRecipeCoverageReady:\(isReady)"
    }

    private var coreImagePatternGenerationPreflightSummary: String {
        RendererMetadataSummary.coreImagePatternGenerationPreflightSummary(
            surface: "GenomeVariation",
            candidate: "CoreImage",
            generatedInputs: ["mask", "glow", "noise", "cppnPrecursor"],
            handmadeVocabularyAccepted: coreImagePatternHandmadeVocabularyAccepted,
            snapshotBaselineAccepted: true,
            preservesHandmadeSilhouette: true,
            externalDependencyRequired: false,
            packageEdited: false,
            projectEdited: false,
            rendererChanged: false,
            assetOutputs: "none"
        )
    }

    private var coreImagePatternGenerationPreflightReadinessSummary: String {
        RendererMetadataSummary.coreImagePatternGenerationPreflightReadinessSummary(
            isReady: RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
                surface: "GenomeVariation",
                candidate: "CoreImage",
                generatedInputs: ["mask", "glow", "noise", "cppnPrecursor"],
                handmadeVocabularyAccepted: coreImagePatternHandmadeVocabularyAccepted,
                snapshotBaselineAccepted: true,
                preservesHandmadeSilhouette: true,
                externalDependencyRequired: false,
                packageEdited: false,
                projectEdited: false,
                rendererChanged: false,
                assetOutputs: "none",
                summary: coreImagePatternGenerationPreflightSummary
            )
        )
    }

    private var coreImagePatternHandmadeVocabularyAccepted: Bool {
        [baseline, sibling]
            .map { patternRecipeCoverageReady(for: $0) && glowAmbientRecipeCoverageReady(for: $0) }
            .allSatisfy { $0 }
            && childDraftRenderCreature.map {
                patternRecipeCoverageReady(for: $0) && glowAmbientRecipeCoverageReady(for: $0)
            } == true
            && CreatureRenderProfile(creature: baseline).hasSpriteKitPatternMarkingCueMetadata
            && CreatureRenderProfile(creature: baseline).hasSpriteKitGlowAuraCueMetadata
    }

    private var snapshotHostEntrySummary: String {
        RendererMetadataSummary.snapshotHostEntrySummary(
            surfaceID: "genomeVariationQA",
            viewTarget: "GenomeVariationQAView",
            launchArgument: "--wipet-snapshot-host-genome-variation",
            candidateReady: snapshotHostCandidateReady,
            appTargetHostAdded: true,
            referenceImageRecorded: false,
            snapshotAssertionAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private var snapshotHostCandidateReady: Bool {
        RendererMetadataSummary.hasSnapshotHostCandidateFields(
            surfaceID: "genomeVariationQA",
            viewTarget: "GenomeVariationQAView",
            snapshotTestingAvailable: true,
            manualVisualQAPassing: true,
            stableSurface: true,
            referenceImageRecorded: false,
            appTargetHostAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private var snapshotHostEntryReady: Bool {
        RendererMetadataSummary.hasSnapshotHostEntryFields(
            surfaceID: "genomeVariationQA",
            viewTarget: "GenomeVariationQAView",
            launchArgument: "--wipet-snapshot-host-genome-variation",
            candidateReady: snapshotHostCandidateReady,
            appTargetHostAdded: true,
            referenceImageRecorded: false,
            snapshotAssertionAdded: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false
        )
    }

    private var snapshotImageCandidateSummary: String {
        RendererMetadataSummary.snapshotImageCandidateSummary(
            surfaceID: "genomeVariationQA",
            viewTarget: "GenomeVariationQAView",
            launchArgument: "--wipet-snapshot-host-genome-variation",
            hostEntryReady: snapshotHostEntryReady,
            manualVisualQAPassing: true,
            referenceImageRecorded: false,
            imageSnapshotAssertionAdded: false,
            appTestTargetAdded: false,
            xcodeProjectEdited: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false,
            widgetBehaviorChanged: false
        )
    }

    private var snapshotImageCandidateReadinessSummary: String {
        RendererMetadataSummary.snapshotImageCandidateReadinessSummary(
            isReady: RendererMetadataSummary.hasSnapshotImageCandidateReadinessFields(
                surfaceID: "genomeVariationQA",
                viewTarget: "GenomeVariationQAView",
                launchArgument: "--wipet-snapshot-host-genome-variation",
                hostEntryReady: snapshotHostEntryReady,
                manualVisualQAPassing: true,
                referenceImageRecorded: false,
                imageSnapshotAssertionAdded: false,
                appTestTargetAdded: false,
                xcodeProjectEdited: false,
                visibleTechnicalMetadata: false,
                appBehaviorChanged: false,
                widgetBehaviorChanged: false
            )
        )
    }

    private var snapshotImageCandidateReady: Bool {
        RendererMetadataSummary.hasSnapshotImageCandidateReadinessFields(
            surfaceID: "genomeVariationQA",
            viewTarget: "GenomeVariationQAView",
            launchArgument: "--wipet-snapshot-host-genome-variation",
            hostEntryReady: snapshotHostEntryReady,
            manualVisualQAPassing: true,
            referenceImageRecorded: false,
            imageSnapshotAssertionAdded: false,
            appTestTargetAdded: false,
            xcodeProjectEdited: false,
            visibleTechnicalMetadata: false,
            appBehaviorChanged: false,
            widgetBehaviorChanged: false
        )
    }

    private var snapshotAppTargetEntrySummary: String {
        RendererMetadataSummary.snapshotAppTargetEntrySummary(
            surfaceID: "genomeVariationQA",
            targetName: "WiPetSnapshotTests",
            existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
            snapshotImageCandidateReady: snapshotImageCandidateReady,
            snapshotTestingPackageAvailable: true,
            xctestHarnessAdded: true,
            appTestTargetAdded: true,
            xcodeProjectEdited: true,
            referenceImageRecorded: false,
            imageSnapshotAssertionAdded: false,
            rendererChanged: false,
            appBehaviorChanged: false,
            widgetBehaviorChanged: false
        )
    }

    private var snapshotAppTargetEntryReadinessSummary: String {
        RendererMetadataSummary.snapshotAppTargetEntryReadinessSummary(
            isReady: RendererMetadataSummary.hasSnapshotAppTargetEntryFields(
                surfaceID: "genomeVariationQA",
                targetName: "WiPetSnapshotTests",
                existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
                snapshotImageCandidateReady: snapshotImageCandidateReady,
                snapshotTestingPackageAvailable: true,
                xctestHarnessAdded: true,
                appTestTargetAdded: true,
                xcodeProjectEdited: true,
                referenceImageRecorded: false,
                imageSnapshotAssertionAdded: false,
                rendererChanged: false,
                appBehaviorChanged: false,
                widgetBehaviorChanged: false
            )
        )
    }

    private var lineageChildDraftMemorySummary: String {
        childPreview
            .map { LineageChildDraftMemoryReference(preview: $0).summary }
            ?? "lineageChildDraftMemory:none"
    }

    private var lineageChildDraftSilhouetteCueSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitSilhouetteCueSummary }
            ?? "lineageChildDraftSilhouetteCue:none"
    }

    private var lineageChildDraftFaceAccentSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitFaceCueAccentSummary }
            ?? "lineageChildDraftFaceAccent:none"
    }

    private var lineageChildDraftFaceAccentReadinessSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitFaceCueAccentReadinessSummary }
            ?? "spriteKitFaceCueAccentReady:false"
    }

    private var lineageChildDraftFaceSilhouetteAccessorySummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitFaceSilhouetteAccessoryCueSummary }
            ?? "spriteKitFaceSilhouetteAccessory:none"
    }

    private var lineageChildDraftFaceSilhouetteAccessoryReadinessSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitFaceSilhouetteAccessoryCueReadinessSummary }
            ?? "spriteKitFaceSilhouetteAccessoryReady:false"
    }

    private var lineageChildDraftInheritedFaceEcho: LineageChildDraftInheritedFaceEcho? {
        guard let childPreview, let childDraftRenderCreature else {
            return nil
        }

        let profile = CreatureRenderProfile(creature: childDraftRenderCreature)
        return LineageChildDraftInheritedFaceEcho(
            memoryReference: LineageChildDraftMemoryReference(preview: childPreview),
            ancestorLabel: "Ori",
            faceCue: profile.silhouetteCue.face,
            accentCue: profile.faceAccent.accent,
            accentDotCount: profile.faceAccent.dotCount
        )
    }

    private var lineageChildDraftInheritedFaceEchoSummary: String {
        lineageChildDraftInheritedFaceEcho?.summary
            ?? "lineageChildDraftInheritedFaceEcho:none"
    }

    private var lineageChildDraftInheritedFaceEchoReadinessSummary: String {
        lineageChildDraftInheritedFaceEcho?.readinessSummary
            ?? "lineageChildDraftInheritedFaceEchoReady:false"
    }

    private var lineageChildDraftAncestralGlintCueSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitAncestralGlintCueSummary }
            ?? "lineageChildDraftAncestralGlintCue:none"
    }

    private var lineageChildDraftFaceLineageEchoCueSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitFaceLineageEchoCueSummary }
            ?? "lineageChildDraftFaceLineageEchoCue:none"
    }

    private var lineageChildDraftWingLineageEchoCueSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitWingLineageEchoCueSummary }
            ?? "lineageChildDraftWingLineageEchoCue:none"
    }

    private var lineageChildDraftWingLineageEchoCueReadinessSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitWingLineageEchoCueReadinessSummary }
            ?? "spriteKitWingLineageEchoCueReady:false"
    }

    private var lineageChildDraftInheritedWingletVisualSummary: String {
        guard let childDraftCreature, let childDraftRenderCreature else {
            return "lineageChildDraftInheritedWingletVisual:none"
        }

        let baseProfile = CreatureRenderProfile(creature: childDraftCreature)
        let renderProfile = CreatureRenderProfile(creature: childDraftRenderCreature)
        return "lineageChildDraftInheritedWingletVisual=source:genomeVariationQA,baseWing:\(baseProfile.silhouetteCue.wing),renderWing:\(renderProfile.silhouetteCue.wing),accessory:\(renderProfile.wingSilhouetteAccessory.accessoryCue),inheritedFrom:Mira,previewOnly:true,persistence:false,widget:false,breeding:false,controls:false,assetOutputs:none"
    }

    private var lineageChildDraftInheritedWingletVisualReadinessSummary: String {
        guard let childDraftCreature, let childDraftRenderCreature else {
            return "lineageChildDraftInheritedWingletVisualReady:false"
        }

        let baseProfile = CreatureRenderProfile(creature: childDraftCreature)
        let renderProfile = CreatureRenderProfile(creature: childDraftRenderCreature)
        let isReady = baseProfile.silhouetteCue.wing == "none"
            && renderProfile.silhouetteCue.wing == "leafPair"
            && renderProfile.wingSilhouetteAccessory.accessoryCue == "softWingTipPearl"
            && renderProfile.wingLineageEcho.isActive
            && lineageChildDraftInheritedWingletVisualSummary.contains("previewOnly:true")
            && lineageChildDraftInheritedWingletVisualSummary.contains("persistence:false")

        return "lineageChildDraftInheritedWingletVisualReady:\(isReady)"
    }

    private var lineageChildDraftInheritedTailFinVisualSummary: String {
        guard let childDraftCreature, let childDraftRenderCreature else {
            return "lineageChildDraftInheritedTailFinVisual:none"
        }

        let baseProfile = CreatureRenderProfile(creature: childDraftCreature)
        let renderProfile = CreatureRenderProfile(creature: childDraftRenderCreature)
        return "lineageChildDraftInheritedTailFinVisual=source:genomeVariationQA,baseTail:\(baseProfile.silhouetteCue.tail),renderTail:\(renderProfile.silhouetteCue.tail),accessory:\(renderProfile.tailSilhouetteAccessory.accessoryCue),inheritedFrom:Mira,previewOnly:true,persistence:false,widget:false,breeding:false,controls:false,assetOutputs:none"
    }

    private var lineageChildDraftInheritedTailFinVisualReadinessSummary: String {
        guard let childDraftCreature, let childDraftRenderCreature else {
            return "lineageChildDraftInheritedTailFinVisualReady:false"
        }

        let baseProfile = CreatureRenderProfile(creature: childDraftCreature)
        let renderProfile = CreatureRenderProfile(creature: childDraftRenderCreature)
        let isReady = baseProfile.silhouetteCue.tail == "floatingRibbon"
            && renderProfile.silhouetteCue.tail == "fishFin"
            && renderProfile.tailSilhouetteAccessory.accessoryCue == "softForkFin"
            && lineageChildDraftInheritedTailFinVisualSummary.contains("previewOnly:true")
            && lineageChildDraftInheritedTailFinVisualSummary.contains("persistence:false")

        return "lineageChildDraftInheritedTailFinVisualReady:\(isReady)"
    }

    private var lineageChildDraftInheritedVisualCuePolicySummary: String {
        childDraftInheritedVisualCuePolicy?.summary
            ?? "lineageChildDraftInheritedVisualCuePolicy:none"
    }

    private var lineageChildDraftInheritedVisualCuePolicyReadinessSummary: String {
        childDraftInheritedVisualCuePolicy?.readinessSummary
            ?? "lineageChildDraftInheritedVisualCuePolicyReady:false"
    }

    private var lineageChildDraftLineageMemoryThreadSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitLineageMemoryThreadSummary }
            ?? "lineageChildDraftLineageMemoryThread:none"
    }

    private var lineageChildDraftTailLineageEchoCueSummary: String {
        childDraftRenderCreature
            .map { CreatureRenderProfile(creature: $0).spriteKitTailLineageEchoCueSummary }
            ?? "lineageChildDraftTailLineageEchoCue:none"
    }

    private var lineageChildDraftLineageCueSetSummary: String {
        guard let childDraftRenderCreature else {
            return "spriteKitChildDraftLineageCueSet:none"
        }

        let profile = CreatureRenderProfile(creature: childDraftRenderCreature)
        return RendererMetadataSummary.spriteKitChildDraftLineageCueSetSummary(
            surface: "genomeVariationChildDraft",
            source: "genomeVariationQA",
            faceCue: profile.silhouetteCue.face,
            faceAccent: profile.faceAccent.accent,
            wingCue: profile.silhouetteCue.wing,
            wingAccessory: profile.wingSilhouetteAccessory.accessoryCue,
            bodyCue: profile.ancestralGlint.cueLabel,
            tailCue: profile.silhouette.tailLineageEcho.cueLabel,
            threadCue: profile.lineageMemoryThread.cueLabel,
            ancestryLinked: profile.ancestralGlint.isActive
                && profile.silhouette.tailLineageEcho.isActive
                && profile.lineageMemoryThread.isActive,
            activeCueCount: [
                profile.faceAccent.accent != "none",
                profile.wingSilhouetteAccessory.accessoryCue != "none",
                profile.ancestralGlint.isActive,
                profile.silhouette.tailLineageEcho.isActive,
                profile.lineageMemoryThread.isActive
            ].filter { $0 }.count,
            visibleInDraftPortrait: true,
            allowsPersistenceWrite: false,
            allowsBreedingControls: false,
            controlsEnabled: false,
            assetOutputs: "none"
        )
    }

    private var lineageChildDraftLineageCueSetReadinessSummary: String {
        guard let childDraftRenderCreature else {
            return "spriteKitChildDraftLineageCueSetReady:false"
        }

        let profile = CreatureRenderProfile(creature: childDraftRenderCreature)
        let ancestryLinked = profile.ancestralGlint.isActive
            && profile.silhouette.tailLineageEcho.isActive
            && profile.lineageMemoryThread.isActive
        let activeCueCount = [
            profile.faceAccent.accent != "none",
            profile.wingSilhouetteAccessory.accessoryCue != "none",
            profile.ancestralGlint.isActive,
            profile.silhouette.tailLineageEcho.isActive,
            profile.lineageMemoryThread.isActive
        ].filter { $0 }.count
        let isReady = RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
            surface: "genomeVariationChildDraft",
            source: "genomeVariationQA",
            faceCue: profile.silhouetteCue.face,
            faceAccent: profile.faceAccent.accent,
            wingCue: profile.silhouetteCue.wing,
            wingAccessory: profile.wingSilhouetteAccessory.accessoryCue,
            bodyCue: profile.ancestralGlint.cueLabel,
            tailCue: profile.silhouette.tailLineageEcho.cueLabel,
            threadCue: profile.lineageMemoryThread.cueLabel,
            ancestryLinked: ancestryLinked,
            activeCueCount: activeCueCount,
            visibleInDraftPortrait: true,
            allowsPersistenceWrite: false,
            allowsBreedingControls: false,
            controlsEnabled: false,
            assetOutputs: "none",
            summary: lineageChildDraftLineageCueSetSummary
        )

        return RendererMetadataSummary.spriteKitChildDraftLineageCueSetReadinessSummary(isReady: isReady)
    }

    private var lineageChildDraftAcknowledgementSummary: String {
        childPreview
            .map {
                LineageChildDraftAcknowledgementPreview(
                    memoryReference: LineageChildDraftMemoryReference(preview: $0)
                ).summary
            }
            ?? "lineageChildDraftAcknowledgement:none"
    }

    private var lineageChildDraftAcknowledgementSurfaceCopy: LineageChildDraftAcknowledgementSurfaceCopy? {
        childPreview.map { preview in
            LineageChildDraftAcknowledgementSurfaceCopy(
                acknowledgement: LineageChildDraftAcknowledgementPreview(
                    memoryReference: LineageChildDraftMemoryReference(preview: preview)
                )
            )
        }
    }

    private var lineageChildDraftAcknowledgementSurfaceSummary: String {
        lineageChildDraftAcknowledgementSurfaceCopy?.summary
            ?? "lineageChildDraftAcknowledgementSurface:none"
    }

    private func genomeVisibleCueMemorySummary(for creature: Creature) -> String {
        genomeVisibleCueMemory(for: creature)?.summary ?? "genomeVisibleCueMemory:none"
    }

    private func lineageVisibleCueSummary(for creature: Creature) -> String {
        lineageVisibleCueMemory(for: creature)?.summary ?? "lineageVisibleCue:none"
    }

    private func lineageVisibleCueObservationCopySummary(for creature: Creature) -> String {
        guard let memory = lineageVisibleCueMemory(for: creature) else {
            return "lineageVisibleCueObservation:none"
        }

        return LineageVisibleCueObservationCopy(memory: memory).summary
    }

    private func spriteKitMotionGeneCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitMotionGeneCueSummary
    }

    private func spriteKitMotionGeneCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitMotionGeneCueReadinessSummary
    }

    private func personalityBlinkCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityBlinkCueSummary
    }

    private func personalityBlinkCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityBlinkCueReadinessSummary
    }

    private func personalitySleepinessIdleCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalitySleepinessIdleCueSummary
    }

    private func personalitySleepinessIdleCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalitySleepinessIdleCueReadinessSummary
    }

    private func spriteKitPatternMarkingCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitPatternMarkingCueSummary
    }

    private func spriteKitBodyProportionCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitBodyProportionCueSummary
    }

    private func spriteKitBodyProportionCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitBodyProportionCueReadinessSummary
    }

    private func spriteKitGrowthHornBudCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthHornBudCueSummary
    }

    private func spriteKitGrowthHornBudCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthHornBudCueReadinessSummary
    }

    private func spriteKitGrowthTailTipCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthTailTipCueSummary
    }

    private func spriteKitGrowthTailTipCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitGrowthTailTipCueReadinessSummary
    }

    private func personalityEyeCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityEyeCueSummary
    }

    private func personalityEyeCueReadinessSummary(for creature: Creature) -> String {
        let profile = CreatureRenderProfile(creature: creature)
        let isReady = RendererMetadataSummary.hasPersonalityEyeCueFields(
            openness: profile.expression.opennessLabel,
            softness: profile.expression.softnessLabel,
            sparkle: profile.expression.sparkleLabel,
            summary: profile.personalityEyeCueSummary
        )
        return RendererMetadataSummary.personalityEyeCueReadinessSummary(isReady: isReady)
    }

    private func personalityEyeGazeCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityEyeGazeCueSummary
    }

    private func personalityEyeGazeCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityEyeGazeCueReadinessSummary
    }

    private func personalityEyeDetailSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityEyeDetailSummary
    }

    private func personalityEyeDetailReadinessSummary(for creature: Creature) -> String {
        let profile = CreatureRenderProfile(creature: creature)
        let isReady = RendererMetadataSummary.hasPersonalityEyeDetailFields(
            catchlightStyle: profile.expression.catchlightStyleLabel,
            catchlightPlacement: profile.expression.catchlightPlacementLabel,
            assetOutputs: "none",
            summary: profile.personalityEyeDetailSummary
        )
        return RendererMetadataSummary.personalityEyeDetailReadinessSummary(isReady: isReady)
    }

    private func personalityCheekWarmthCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityCheekWarmthCueSummary
    }

    private func personalityCheekWarmthCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityCheekWarmthCueReadinessSummary
    }

    private func personalityMouthCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityMouthCueSummary
    }

    private func personalityMouthCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityMouthCueReadinessSummary
    }

    private func personalityPostureCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityPostureCueSummary
    }

    private func personalityPostureCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityPostureCueReadinessSummary
    }

    private func spriteKitGlowAuraCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitGlowAuraCueSummary
    }

    private func spriteKitGlowAuraCueReadinessSummary(for creature: Creature) -> String {
        RendererMetadataSummary.spriteKitGlowAuraCueReadinessSummary(
            isReady: CreatureRenderProfile(creature: creature).hasSpriteKitGlowAuraCueMetadata
        )
    }

    private func personalityMysticismAuraCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityMysticismAuraCueSummary
    }

    private func personalityMysticismAuraCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).personalityMysticismAuraCueReadinessSummary
    }

    private func spriteKitAncestralGlintCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitAncestralGlintCueSummary
    }

    private func spriteKitAncestralGlintCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitAncestralGlintCueReadinessSummary
    }

    private func spriteKitFaceLineageEchoCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitFaceLineageEchoCueSummary
    }

    private func spriteKitFaceLineageEchoCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitFaceLineageEchoCueReadinessSummary
    }

    private func spriteKitLineageMemoryThreadSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitLineageMemoryThreadSummary
    }

    private func spriteKitLineageMemoryThreadReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitLineageMemoryThreadReadinessSummary
    }

    private func spriteKitTailLineageEchoCueSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitTailLineageEchoCueSummary
    }

    private func spriteKitTailLineageEchoCueReadinessSummary(for creature: Creature) -> String {
        CreatureRenderProfile(creature: creature).spriteKitTailLineageEchoCueReadinessSummary
    }

    private func partFamilySelectionSummary(for creature: Creature) -> String {
        CreaturePartFamilySelection(
            profile: CreatureRenderProfile(creature: creature)
        ).summary
    }

    private func shapeRecipeCoverageSummary(for creature: Creature) -> String {
        let assembler = PartAssembler(profile: CreatureRenderProfile(creature: creature))
        let plan = assembler.assemblyPlan(
            leftEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18)),
            rightEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
        )
        return plan.shapeRecipeValidationSummary(in: .currentLuma)
    }

    private func shapeRecipeCoverageReady(for creature: Creature) -> Bool {
        let assembler = PartAssembler(profile: CreatureRenderProfile(creature: creature))
        let plan = assembler.assemblyPlan(
            leftEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18)),
            rightEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
        )
        return plan.hasCatalogShapeRecipeCoverage(in: .currentLuma)
    }

    private func detailRecipeCoverageSummary(for creature: Creature) -> String {
        let assembler = PartAssembler(profile: CreatureRenderProfile(creature: creature))
        let plan = assembler.assemblyPlan(
            leftEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18)),
            rightEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
        )
        return plan.detailRecipeValidationSummary(in: .currentLuma)
    }

    private func detailRecipeCoverageReady(for creature: Creature) -> Bool {
        let assembler = PartAssembler(profile: CreatureRenderProfile(creature: creature))
        let plan = assembler.assemblyPlan(
            leftEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18)),
            rightEye: SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
        )
        return plan.hasCatalogDetailRecipeCoverage(in: .currentLuma)
    }

    private func glowAmbientRecipeCoverageSummary(for creature: Creature) -> String {
        CreatureAssemblyPlan.glowAmbientRecipeValidationSummary(
            for: CreatureRenderProfile(creature: creature),
            in: .currentLuma
        )
    }

    private func glowAmbientRecipeCoverageReady(for creature: Creature) -> Bool {
        CreatureAssemblyPlan.hasGlowAmbientRecipeCoverage(
            for: CreatureRenderProfile(creature: creature),
            in: .currentLuma
        )
    }

    private func patternRecipeCoverageSummary(for creature: Creature) -> String {
        CreatureAssemblyPlan.patternRecipeValidationSummary(
            for: CreatureRenderProfile(creature: creature),
            in: .currentLuma
        )
    }

    private func patternRecipeCoverageReady(for creature: Creature) -> Bool {
        CreatureAssemblyPlan.hasPatternRecipeCoverage(
            for: CreatureRenderProfile(creature: creature),
            in: .currentLuma
        )
    }

    private func inheritedVisibleCueName(for creature: Creature) -> String {
        if let wing = creature.genome.morph.wing {
            switch wing {
            case .fairy:
                return "soft fairy winglets"
            case .dragon:
                return "wide dragon winglets"
            case .crystal:
                return "small crystal winglets"
            case .jellyfish:
                return "bell-soft winglets"
            case .lunar:
                return "moonlit winglets"
            case .plant:
                return "sprout-leaf winglets"
            }
        }

        if let tail = creature.genome.morph.tail {
            switch tail {
            case .dragon:
                return "long drake tail"
            case .fish:
                return "fish-tail curve"
            case .crystal:
                return "gem tail"
            case .floating:
                return "floating tail"
            case .plant:
                return "leaf-sprout tail"
            }
        }

        switch creature.genome.morph.face {
        case .round:
            return "soft round face"
        case .fairy:
            return "small fairy face"
        case .dragon:
            return "broad dragon face"
        case .axolotl:
            return "wide axolotl face"
        case .crystal:
            return "faceted face"
        case .deer:
            return "soft deer face"
        case .feline:
            return "soft feline face"
        case .lunar:
            return "soft crescent face"
        }
    }

    private func lineageVisibleCueMemory(for creature: Creature) -> LineageVisibleCueMemory? {
        genomeVisibleCueMemory(for: creature)?.lineageMemory(
            discovery: creature.discoveredTraits.last,
            ancestorLabel: "firstAncestor"
        )
    }

    private func genomeVisibleCueMemory(for creature: Creature) -> GenomeVisibleCueMemory? {
        let profile = CreatureRenderProfile(creature: creature)
        return GenomeVisibleCueMemory(
            traitID: "tail",
            displayName: "Floating tail",
            visibleCue: profile.silhouetteCue.tail,
            genomeSummary: profile.genomeVisualVariationSummary
        )
    }

    @ViewBuilder
    private func childDraftCard(isCompact: Bool) -> some View {
        if let childDraftRenderCreature, let childPreview {
            let profile = CreatureRenderProfile(creature: childDraftRenderCreature)
            let acknowledgementSurface = lineageChildDraftAcknowledgementSurfaceCopy
            let inheritedFaceEchoSummary = lineageChildDraftInheritedFaceEchoSummary

            HStack(spacing: 12) {
                SpriteView(
                    scene: CreatureScene(creature: childDraftRenderCreature),
                    options: [.allowsTransparency]
                )
                .frame(width: isCompact ? 132 : 154, height: isCompact ? 132 : 148)
                .accessibilityLabel("QA child draft genome-driven portrait")

                VStack(alignment: .leading, spacing: 6) {
                    Text("Draft")
                        .font(.system(.caption, design: .rounded, weight: .semibold))
                        .textCase(.uppercase)
                        .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

                    Text(childDraftFamilyEchoLine)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.25, green: 0.30, blue: 0.36))
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Cue: \(childPreview.changedTraitID)")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.42, green: 0.46, blue: 0.52))
                        .lineLimit(1)
                        .minimumScaleFactor(0.78)

                    if let acknowledgementSurface {
                        Text(acknowledgementSurface.promptLine)
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 0.24, green: 0.31, blue: 0.38))
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("lineageChildDraftAcknowledgementPrompt")

                        Text(acknowledgementSurface.waitingLine)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 0.45, green: 0.48, blue: 0.53))
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("lineageChildDraftAcknowledgementWaitingLine")
                    }
                }

                VStack(spacing: 4) {
                    SpriteView(
                        scene: CreatureScene(creature: deerAncestor),
                        options: [.allowsTransparency]
                    )
                    .frame(width: isCompact ? 58 : 66, height: isCompact ? 58 : 66)
                    .accessibilityLabel("Ori's plant ancestor portrait")

                    Text("Ori")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))
                        .lineLimit(1)

                    Text(ancestorPortraitCueLine)
                        .font(.system(size: 9, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 0.42, green: 0.46, blue: 0.52))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.82)
                }
                .frame(width: isCompact ? 64 : 72)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("genomeVariationAncestorPlantPortrait")
                .accessibilityLabel("Ori ancestor, \(ancestorPortraitCueLine), \(CreatureRenderProfile(creature: deerAncestor).genomeVisualVariationSummary)")

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.white.opacity(0.42), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.white.opacity(0.62), lineWidth: 1)
            }
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("genomeVariationChildDraftPortrait")
            .accessibilityLabel("Child draft, \(profile.genomeVisualVariationSummary), \(childPreview.summary), \(inheritedFaceEchoSummary)")
        }
    }

    private func portraitCard(
        creature: Creature,
        label: String,
        identifier: String,
        isCompact: Bool
    ) -> some View {
        let profile = CreatureRenderProfile(creature: creature)
        let variationSummary = profile.genomeVisualVariationSummary
        let expressionSummary = profile.personalityEyeCueSummary
        let eyeDetailSummary = profile.personalityEyeDetailSummary
        let glowAuraSummary = profile.spriteKitGlowAuraCueSummary
        let patternMarkingSummary = profile.spriteKitPatternMarkingCueSummary
        let silhouetteCueSummary = profile.spriteKitSilhouetteCueSummary
        let wingAccentSummary = profile.spriteKitWingCueAccentSummary
        let bodyAccentSummary = profile.spriteKitBodyCueAccentSummary
        let faceAccentSummary = profile.spriteKitFaceCueAccentSummary
        let motionSummary = profile.spriteKitMotionGeneCueSummary

        return VStack(spacing: 10) {
            SpriteView(
                scene: CreatureScene(creature: creature),
                options: [.allowsTransparency]
            )
            .frame(height: isCompact ? 230 : 270)
            .accessibilityLabel("\(creature.name)'s genome-driven portrait")

            Text(label)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, isCompact ? 8 : 10)
        .padding(.vertical, 12)
        .background(.white.opacity(0.46), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.white.opacity(0.62), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(identifier)
        .accessibilityLabel("\(label), \(creature.name), \(variationSummary), \(expressionSummary), \(eyeDetailSummary), \(glowAuraSummary), \(patternMarkingSummary), \(silhouetteCueSummary), \(wingAccentSummary), \(bodyAccentSummary), \(faceAccentSummary), \(motionSummary)")
    }
}
