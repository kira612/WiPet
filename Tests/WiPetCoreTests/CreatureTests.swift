import Testing
import Foundation
import SnapshotTesting
@testable import WiPetCore

private func lineagePreviewParentA() -> LineageParentGenome {
    LineageParentGenome(
        id: UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!,
        genome: Genome(
            morph: MorphGenes(face: .crystal, body: .lunarian, wing: .crystal, tail: .floating),
            motion: MotionGenes(
                blink: ScalarGene(0.42),
                float: ScalarGene(0.72),
                tailMotion: ScalarGene(0.58),
                wingMotion: ScalarGene(0.36)
            ),
            pattern: PatternGenes(
                contrast: ScalarGene(0.44),
                glow: ScalarGene(0.76)
            )
        )
    )
}

private func lineagePreviewParentB() -> LineageParentGenome {
    LineageParentGenome(
        id: UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!,
        genome: Genome(
            morph: MorphGenes(face: .fairy, body: .sylphian, wing: .fairy, tail: .fish),
            motion: MotionGenes(
                blink: ScalarGene(0.64),
                float: ScalarGene(0.82),
                tailMotion: ScalarGene(0.38),
                wingMotion: ScalarGene(0.72)
            ),
            pattern: PatternGenes(
                contrast: ScalarGene(0.62),
                glow: ScalarGene(0.48)
            )
        )
    )
}

private func growthCeremonyInheritedVisualBridgeFixture() throws -> GrowthCeremonyInheritedVisualMemoryBridge {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let policy = LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedWing: .fairy,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira"
    )

    return GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy
    )
}

private func lineageFamilyQALumaParent() -> LineageParentGenome {
    LineageParentGenome(
        id: UUID(uuidString: "C1CC1B89-7F0D-4D80-A6D5-FD73C58CC7D1")!,
        genome: Genome(
            morph: MorphGenes(
                face: .crystal,
                body: .lunarian,
                tail: .floating
            ),
            growth: GrowthGenes(
                tailGrowth: ScalarGene(0.62),
                glowGrowth: ScalarGene(0.78)
            ),
            motion: MotionGenes(
                blink: ScalarGene(0.42),
                float: ScalarGene(0.72),
                tailMotion: ScalarGene(0.58)
            ),
            personality: PersonalityGenes(
                curiosity: ScalarGene(0.66),
                sociality: ScalarGene(0.54),
                timidity: ScalarGene(0.38),
                energy: ScalarGene(0.46),
                sleepiness: ScalarGene(0.57),
                mysticism: ScalarGene(0.81)
            ),
            pattern: PatternGenes(
                contrast: ScalarGene(0.44),
                glow: ScalarGene(0.76)
            )
        )
    )
}

private func lineageFamilyQAMiraParent() -> LineageParentGenome {
    LineageParentGenome(
        id: UUID(uuidString: "4F37B6C5-0605-4391-82BE-65F4B6B47835")!,
        genome: Genome(
            morph: MorphGenes(
                face: .fairy,
                body: .sylphian,
                wing: .fairy,
                tail: .fish
            ),
            growth: GrowthGenes(
                wingGrowth: ScalarGene(0.68),
                tailGrowth: ScalarGene(0.34),
                glowGrowth: ScalarGene(0.42)
            ),
            motion: MotionGenes(
                blink: ScalarGene(0.64),
                float: ScalarGene(0.82),
                tailMotion: ScalarGene(0.38),
                wingMotion: ScalarGene(0.72)
            ),
            personality: PersonalityGenes(
                curiosity: ScalarGene(0.74),
                sociality: ScalarGene(0.69),
                timidity: ScalarGene(0.41),
                energy: ScalarGene(0.62),
                sleepiness: ScalarGene(0.36),
                mysticism: ScalarGene(0.58)
            ),
            pattern: PatternGenes(
                contrast: ScalarGene(0.62),
                glow: ScalarGene(0.48)
            )
        )
    )
}

private func lineagePreview(
    parents: [LineageParentGenome],
    generation: Int,
    matchingMutationTraitIDs: Set<String>
) -> LineageGenomePreview? {
    for index in 0 ..< 64 {
        let salt = "WiPetLineageMutationV1-test-\(index)"
        if let preview = LineageGenomePreviewPlanner.preview(
            parents: parents,
            generation: generation,
            salt: salt
        ), matchingMutationTraitIDs.contains(preview.changedTraitID) {
            return preview
        }
    }

    return nil
}

private func assertLineagePreview(
    preview: LineageGenomePreview,
    inheritedGenome: Genome,
    variationGenome: Genome
) {
    switch LineageMutationTrait(rawValue: preview.changedTraitID) {
    case .face:
        #expect(preview.genome.morph.face == variationGenome.morph.face)
        #expect(preview.genome.morph.body == inheritedGenome.morph.body)
        #expect(preview.genome.morph.wing == inheritedGenome.morph.wing)
        #expect(preview.genome.morph.tail == inheritedGenome.morph.tail)
        #expect(preview.genome.pattern == inheritedGenome.pattern)
        #expect(preview.genome.motion == inheritedGenome.motion)
    case .body:
        #expect(preview.genome.morph.face == inheritedGenome.morph.face)
        #expect(preview.genome.morph.body == variationGenome.morph.body)
        #expect(preview.genome.morph.wing == inheritedGenome.morph.wing)
        #expect(preview.genome.morph.tail == inheritedGenome.morph.tail)
        #expect(preview.genome.pattern == inheritedGenome.pattern)
        #expect(preview.genome.motion == inheritedGenome.motion)
    case .wing:
        #expect(preview.genome.morph.face == inheritedGenome.morph.face)
        #expect(preview.genome.morph.body == inheritedGenome.morph.body)
        #expect(preview.genome.morph.wing == variationGenome.morph.wing)
        #expect(preview.genome.morph.tail == inheritedGenome.morph.tail)
        #expect(preview.genome.pattern == inheritedGenome.pattern)
        #expect(preview.genome.motion == inheritedGenome.motion)
    case .tail:
        #expect(preview.genome.morph.face == inheritedGenome.morph.face)
        #expect(preview.genome.morph.body == inheritedGenome.morph.body)
        #expect(preview.genome.morph.wing == inheritedGenome.morph.wing)
        #expect(preview.genome.morph.tail == variationGenome.morph.tail)
        #expect(preview.genome.pattern == inheritedGenome.pattern)
        #expect(preview.genome.motion == inheritedGenome.motion)
    case .glow:
        #expect(preview.genome.morph == inheritedGenome.morph)
        #expect(preview.genome.motion == inheritedGenome.motion)
        #expect(preview.genome.pattern.contrast == inheritedGenome.pattern.contrast)
        #expect(preview.genome.pattern.glow.value >= inheritedGenome.pattern.glow.value)
        #expect(preview.genome.pattern.glow.value <= 1)
    case .motion:
        #expect(preview.genome.morph == inheritedGenome.morph)
        #expect(preview.genome.pattern == inheritedGenome.pattern)
        #expect(preview.genome.motion.blink == inheritedGenome.motion.blink)
        #expect(preview.genome.motion.float.value >= inheritedGenome.motion.float.value)
        #expect(preview.genome.motion.tailMotion.value >= inheritedGenome.motion.tailMotion.value)
        #expect(preview.genome.motion.wingMotion.value >= inheritedGenome.motion.wingMotion.value)
        #expect(preview.genome.motion.float.value <= 1)
        #expect(preview.genome.motion.tailMotion.value <= 1)
        #expect(preview.genome.motion.wingMotion.value <= 1)
    case nil:
        Issue.record("Unknown mutation trait \(preview.changedTraitID)")
    }
}

private func lineageFamilyQAReviewStackSnapshotText() throws -> String {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineageFamilyQALumaParent(), lineageFamilyQAMiraParent()],
        generation: 4
    ))
    let memoryReference = LineageChildDraftMemoryReference(preview: preview)
    let childDraftNode = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: memoryReference
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(memoryReference: memoryReference)
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: childDraftNode.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview
    )
    let boundary = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: childDraftNode
    )
    let dryRunAdapter = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate
    )
    let confirmationCeremony = LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter
    )

    return [
        "LineageFamilyQAReviewStack",
        evidenceReview.summary,
        acknowledgementReview.summary,
        intentGate.summary,
        boundary.summary,
        dryRunAdapter.summary,
        confirmationCeremony.summary
    ].joined(separator: "\n") + "\n"
}

private func observationHomeFamilyEchoSnapshotText() throws -> String {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)
    let sheet = LineageObservationMemorySheetCopy(teaser: teaser)
    let familyTreeEntry = sheet.familyTreeEntryCopy
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branchPreview = LineageFamilyBranchPreview(
        ancestorNode: LineageFamilyNodeCopy(
            internalLabel: "firstAncestor",
            displayName: "Ori",
            roleLine: "Ori is remembered through a soft deer-face echo."
        ),
        familyPreview: LineageFamilyPreview(
            ancestorLabel: "firstAncestor",
            ancestorDisplayName: "Ori",
            memberNames: ["Luma", "Mira"],
            memories: [memory]
        ),
        childDraftNode: childDraft
    )
    let previewText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let facePreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let familyEchoCopy = LineageGenomeVariationFamilyEchoCopy(
        memoryReference: LineageChildDraftMemoryReference(preview: facePreview),
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    )
    let ancestorMemoryCard = LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEchoCopy
    )
    let branchCaption = LineageBranchCaptionText(
        branchPreview: branchPreview,
        previewText: previewText
    )
    let branchBridge = LineageObservationBranchCaptionBridge(
        observationEntry: familyTreeEntry,
        branchCaption: branchCaption
    )
    let assertionSummary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    return [
        "ObservationHomeFamilyEcho",
        "Observation focus",
        "A quiet lunar glow deepened around the tail.",
        "Juvenile glow deepened",
        teaser.title,
        teaser.memoryLine,
        teaser.statusLine,
        teaser.entryLine,
        sheet.householdLine,
        sheet.summary,
        sheet.readinessSummary,
        familyTreeEntry.branchLine,
        familyTreeEntry.generationLine,
        familyTreeEntry.summary,
        familyTreeEntry.readinessSummary,
        ancestorMemoryCard.title,
        ancestorMemoryCard.ancestorPortraitLabel,
        ancestorMemoryCard.inheritedCueLine,
        ancestorMemoryCard.changedCueLine,
        ancestorMemoryCard.safetyLine,
        ancestorMemoryCard.summary,
        ancestorMemoryCard.readinessSummary,
        branchBridge.summary,
        branchBridge.readinessSummary,
        teaser.summary,
        teaser.readinessSummary,
        assertionSummary
    ].joined(separator: "\n") + "\n"
}

private func genomeVariationSilhouetteCueSetSnapshotText() -> String {
    let cueSetSummary = RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceSummary(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    )
    let cueSetReadiness = RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceReadinessSummary(isReady: true)
    let assertionSummary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "genomeVariationQA",
        assertionKind: "textLines",
        referenceName: "genome-variation-silhouette-cue-set",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    return [
        "GenomeVariationSilhouetteCueSet",
        "childDraftFace:spriteKitFaceSilhouetteAccessoryReady:true",
        "miraBody:spriteKitBodySilhouetteAccessoryReady:true",
        "miraWing:spriteKitWingSilhouetteAccessoryReady:true",
        "miraTail:spriteKitTailSilhouetteAccessoryReady:true",
        cueSetSummary,
        cueSetReadiness,
        assertionSummary
    ].joined(separator: "\n") + "\n"
}

private func growthCeremonyPreviewContractSnapshotText() throws -> String {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        generation: 3,
        parentIDs: [parentA, parentB]
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let bridge = GrowthCeremonyLineageCueBridge(
        traitReveal: plan.traitReveal,
        lineageCopy: lineageCopy
    )
    let teaser = GrowthCeremonyLineageTeaserCopy(
        previewTitle: plan.previewTitle,
        bridge: bridge
    )
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        lineageTeaserCopy: teaser
    )
    let noticedMemoryLine = GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true
    )
    let acknowledgementGate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: handoff,
        mutationProof: plan.mutationProof
    )
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: acknowledgementGate
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let acknowledgementIntent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )
    let observationAcknowledgement = GrowthCeremonyObservationAcknowledgementInteraction(
        observation: plan.beforeAfterObservation
    )
    let persistenceBoundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: acknowledgementIntent
    )
    let widgetPreflight = GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: persistenceBoundary
    )
    let profile = LineageMutationAffectionProfile(plan: LineageMutationPlan(
        seed: 92,
        generation: creature.generation,
        inheritedTraitID: "tail",
        mutationTraitID: "body",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: "Mostly echoes tail, with a gentleVariation in body."
    ))
    let affectionCopy = GrowthCeremonyLineageAffectionCopy(
        plan: plan,
        profile: profile
    )
    let assertionSummary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "growth-ceremony-preview-contract",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    return [
        "GrowthCeremonyPreviewContract",
        plan.readinessSummary,
        plan.traitReveal.summary,
        plan.beforeAfterObservation.summary,
        bridge.summary,
        bridge.readinessSummary,
        teaser.summary,
        teaser.readinessSummary,
        handoff.summary,
        handoff.readinessSummary,
        noticedMemoryLine.summary,
        noticedMemoryLine.readinessSummary,
        acknowledgementGate.summary,
        acknowledgementGate.readinessSummary,
        acknowledgementSurface.summary,
        acknowledgementSurface.readinessSummary,
        confirmationSurface.summary,
        confirmationSurface.readinessSummary,
        acknowledgementIntent.summary,
        acknowledgementIntent.readinessSummary,
        observationAcknowledgement.summary,
        observationAcknowledgement.readinessSummary,
        persistenceBoundary.summary,
        persistenceBoundary.readinessSummary,
        widgetPreflight.summary,
        widgetPreflight.readinessSummary,
        affectionCopy.summary,
        affectionCopy.readinessSummary,
        "creatureStageAfterPreview:\(creature.growthStage)",
        "discoveryCountAfterPreview:\(creature.discoveredTraits.count)",
        assertionSummary
    ].joined(separator: "\n") + "\n"
}

@Test func creatureKeepsLineageIdentityCompact() {
    let parentA = UUID()
    let parentB = UUID()
    let extraParent = UUID()
    let creature = Creature(
        name: "Mina",
        species: .aquarian,
        genome: Genome(morph: MorphGenes(face: .round, body: .aquarian, tail: .fish)),
        generation: 3,
        parentIDs: [parentA, parentB, extraParent]
    )

    #expect(creature.name == "Mina")
    #expect(creature.generation == 3)
    #expect(creature.parentIDs == [parentA, parentB])
}

@Test func creatureGenerationNeverFallsBelowOne() {
    let creature = Creature(
        name: "Seed",
        species: .verdant,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .verdant)),
        generation: -4
    )

    #expect(creature.generation == 1)
}

@Test func lineageMutationPlannerUsesGameplayKitDeterministically() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let plan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let repeatedPlan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let reversedParentPlan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentB, parentA],
        generation: 3
    ))

    #expect(plan == repeatedPlan)
    #expect(plan == reversedParentPlan)
    #expect(plan.source == "GameplayKit")
    #expect(plan.generation == 3)
    #expect(LineageMutationTrait.allCases.map(\.rawValue).contains(plan.inheritedTraitID))
    #expect(LineageMutationTrait.allCases.map(\.rawValue).contains(plan.mutationTraitID))
    #expect(plan.inheritedTraitID != plan.mutationTraitID)
    #expect((0.72 ... 0.92).contains(plan.ancestralResemblance))
    #expect((0.06 ... 0.18).contains(plan.mutationAmount))
    #expect(plan.affinityLine == "Mostly echoes \(plan.inheritedTraitID), with a \(plan.mutationLabel) in \(plan.mutationTraitID).")
    #expect(plan.readinessSummary == "lineageMutationPlanReady:true")
    #expect(plan.summary == "lineageMutationPlan=source:GameplayKit,seed:\(plan.seed),generation:3,inherit:\(plan.inheritedTraitID),mutation:\(plan.mutationTraitID),resemblance:\(String(format: "%.2f", plan.ancestralResemblance)),amount:\(String(format: "%.2f", plan.mutationAmount))")
}

@Test func lineageMutationPlannerNeedsParentIDs() {
    #expect(LineageMutationPlanner.plan(parentIDs: [], generation: 3) == nil)
}

@Test func lineageMutationPlannerClampsGenerationAndChangesByGeneration() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let generationOne = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: -4
    ))
    let generationThree = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))

    #expect(generationOne.generation == 1)
    #expect(generationOne.seed != generationThree.seed)
    #expect(generationOne.summary.contains("generation:1"))
    #expect(generationThree.summary.contains("generation:3"))
}

@Test func lineageMutationPlanReadinessRequiresFields() {
    let ready = LineageMutationPlan(
        seed: 42,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: "Mostly echoes tail, with a gentleVariation in glow."
    )
    let incomplete = LineageMutationPlan(
        seed: 0,
        generation: 3,
        inheritedTraitID: "",
        mutationTraitID: "glow",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: ""
    )

    #expect(ready.hasRequiredFields)
    #expect(ready.readinessSummary == "lineageMutationPlanReady:true")
    #expect(!incomplete.hasRequiredFields)
    #expect(incomplete.readinessSummary == "lineageMutationPlanReady:false")
}

@Test func lineageMutationPlanAffectionWeightKeepsAncestryAheadOfVariation() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let plan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let weakPlan = LineageMutationPlan(
        source: "Manual",
        seed: 42,
        generation: 3,
        inheritedTraitID: "face",
        mutationTraitID: "body",
        ancestralResemblance: 0.56,
        mutationAmount: 0.18,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: "Manual random plan."
    )

    #expect(plan.keepsAncestralResemblance())
    #expect(plan.resemblanceAdvantage >= 0.50)
    #expect(!weakPlan.keepsAncestralResemblance())
    #expect(weakPlan.resemblanceAdvantage < 0.50)
}

@Test func lineageMutationDistributionSampleAuditsGameplayKitAcrossGenerations() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let sample = try #require(LineageMutationPlanner.distributionSample(
        parentIDs: [parentA, parentB],
        generationRange: 1 ..< 5
    ))
    let repeatedSample = try #require(LineageMutationPlanner.distributionSample(
        parentIDs: [parentA, parentB],
        generationRange: 1 ..< 5
    ))
    let reversedParentSample = try #require(LineageMutationPlanner.distributionSample(
        parentIDs: [parentB, parentA],
        generationRange: 1 ..< 5
    ))

    #expect(sample == repeatedSample)
    #expect(sample == reversedParentSample)
    #expect(sample.sampleCount == 4)
    #expect(sample.generationSpanLabel == "1-4")
    #expect(sample.allUseGameplayKit)
    #expect(sample.allHaveRequiredFields)
    #expect(sample.allResemblanceBeatsMutation)
    #expect(sample.allStayGentle)
    #expect(sample.hasTraitCoverage)
    #expect(sample.hasRequiredFields)
    #expect(sample.readinessSummary == "lineageMutationDistributionSampleReady:true")
    #expect(sample.summary.contains("lineageMutationDistributionSample=source:GameplayKit,count:4,generations:1-4"))
    #expect(sample.summary.contains("resemblanceBeatsMutation:true,gentle:true"))
}

@Test func lineageMutationDistributionSampleRejectsMissingParentsEmptyRangeAndWeakManualPlans() {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let weakManualPlan = LineageMutationPlan(
        source: "Manual",
        seed: 42,
        generation: 3,
        inheritedTraitID: "face",
        mutationTraitID: "body",
        ancestralResemblance: 0.55,
        mutationAmount: 0.50,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: "Manual random plan."
    )
    let weakSample = LineageMutationDistributionSample(plans: [weakManualPlan])

    #expect(LineageMutationPlanner.distributionSample(
        parentIDs: [],
        generationRange: 1 ..< 5
    ) == nil)
    #expect(LineageMutationPlanner.distributionSample(
        parentIDs: [parentA, parentB],
        generationRange: 3 ..< 3
    ) == nil)
    #expect(!weakSample.allUseGameplayKit)
    #expect(!weakSample.allResemblanceBeatsMutation)
    #expect(!weakSample.allStayGentle)
    #expect(!weakSample.hasRequiredFields)
    #expect(weakSample.summary == "lineageMutationDistributionSample=source:mixed,count:1,generations:3-3,traits:body,minResemblance:0.55,maxMutation:0.50,resemblanceBeatsMutation:false,gentle:false")
    #expect(weakSample.readinessSummary == "lineageMutationDistributionSampleReady:false")
}

@Test func lineageRandomnessLibraryAdoptionGateKeepsGameplayKitAffectionScoped() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let plan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let repeatedPlan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let reversedParentPlan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentB, parentA],
        generation: 3
    ))
    let gate = LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: repeatedPlan,
        parentOrderStablePlan: reversedParentPlan
    )

    #expect(gate.usesGameplayKit)
    #expect(gate.deterministicReplay)
    #expect(gate.parentOrderStable)
    #expect(gate.resemblanceBeatsMutation)
    #expect(gate.hasRequiredFields)
    #expect(gate.summary == "lineageRandomnessLibraryAdoption=source:GameplayKit,deterministic:true,parentOrderStable:true,coreOnly:true,playerFacingRandomness:false,persistence:false,externalDependency:false,resemblanceBeatsMutation:true")
    #expect(gate.readinessSummary == "lineageRandomnessLibraryAdoptionReady:true")
}

@Test func lineageMutationPlannerBuildsGameplayKitAdoptionGate() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let gate = try #require(LineageMutationPlanner.libraryAdoptionGate(
        parentIDs: [parentA, parentB],
        generation: 3
    ))

    #expect(gate.hasRequiredFields)
    #expect(gate.usesGameplayKit)
    #expect(gate.deterministicReplay)
    #expect(gate.parentOrderStable)
    #expect(gate.resemblanceBeatsMutation)
    #expect(gate.summary == "lineageRandomnessLibraryAdoption=source:GameplayKit,deterministic:true,parentOrderStable:true,coreOnly:true,playerFacingRandomness:false,persistence:false,externalDependency:false,resemblanceBeatsMutation:true")
    #expect(gate.readinessSummary == "lineageRandomnessLibraryAdoptionReady:true")
}

@Test func lineageMutationPlannerAdoptionGateNeedsParents() {
    #expect(LineageMutationPlanner.libraryAdoptionGate(parentIDs: [], generation: 3) == nil)
}

@Test func lineageRandomnessLibraryAdoptionGateRejectsUnscopedRandomness() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let plan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))

    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: plan,
        parentOrderStablePlan: plan,
        coreOnlyScope: false
    ).hasRequiredFields)
    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: plan,
        parentOrderStablePlan: plan,
        allowsPlayerFacingRandomness: true
    ).hasRequiredFields)
    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: plan,
        parentOrderStablePlan: plan,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: plan,
        parentOrderStablePlan: plan,
        externalDependencyRequired: true
    ).hasRequiredFields)
    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: plan,
        repeatedPlan: plan,
        parentOrderStablePlan: LineageMutationPlan(
            source: "Manual",
            seed: 99,
            generation: 3,
            inheritedTraitID: "face",
            mutationTraitID: "body",
            ancestralResemblance: 0.60,
            mutationAmount: 0.55,
            resemblanceLabel: "softFamilyEcho",
            mutationLabel: "noticeableButSoft",
            affinityLine: "Manual random plan."
        )
    ).hasRequiredFields)
    let weakResemblancePlan = LineageMutationPlan(
        seed: 42,
        generation: 3,
        inheritedTraitID: "face",
        mutationTraitID: "body",
        ancestralResemblance: 0.56,
        mutationAmount: 0.18,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: "Mostly echoes face, with a noticeableButSoft in body."
    )
    #expect(!LineageRandomnessLibraryAdoptionGate(
        plan: weakResemblancePlan,
        repeatedPlan: weakResemblancePlan,
        parentOrderStablePlan: weakResemblancePlan
    ).hasRequiredFields)
}

@Test func lineageMutationPlanningProofJoinsGameplayKitSafetyContracts() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let proof = try #require(LineageMutationPlanner.planningProof(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let repeatedProof = try #require(LineageMutationPlanner.planningProof(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let reversedParentProof = try #require(LineageMutationPlanner.planningProof(
        parentIDs: [parentB, parentA],
        generation: 3
    ))

    #expect(proof == repeatedProof)
    #expect(proof == reversedParentProof)
    #expect(proof.usesGameplayKit)
    #expect(proof.deterministicReplay)
    #expect(proof.keepsAffectionSafe)
    #expect(proof.keepsGentleDistribution)
    #expect(proof.hasRequiredFields)
    #expect(proof.distributionSample.sampleCount == 4)
    #expect(!proof.affectionProfile.summary.contains("seed"))
    #expect(proof.affectionProfile.summary.contains("rawRandomness:false"))
    #expect(proof.summary == "lineageMutationPlanningProof=source:GameplayKit,deterministic:true,sample:4,affectionSafe:true,gentle:true,coreOnly:true,playerFacingRandomness:false,persistence:false,externalDependency:false")
    #expect(proof.readinessSummary == "lineageMutationPlanningProofReady:true")
}

@Test func lineageMutationPlanningProofNeedsParentsAndRejectsUnsafeFlags() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let adoptionGate = try #require(LineageMutationPlanner.libraryAdoptionGate(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let affectionProfile = try #require(LineageMutationPlanner.affectionProfile(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let distributionSample = try #require(LineageMutationPlanner.distributionSample(
        parentIDs: [parentA, parentB],
        generationRange: 3 ..< 7
    ))

    #expect(LineageMutationPlanner.planningProof(parentIDs: [], generation: 3) == nil)
    #expect(LineageMutationPlanner.planningProof(
        parentIDs: [parentA, parentB],
        generation: 3,
        sampleGenerationRange: 3 ..< 3
    ) == nil)
    #expect(!LineageMutationPlanningProof(
        adoptionGate: adoptionGate,
        affectionProfile: affectionProfile,
        distributionSample: distributionSample,
        coreOnlyScope: false
    ).hasRequiredFields)
    #expect(!LineageMutationPlanningProof(
        adoptionGate: adoptionGate,
        affectionProfile: affectionProfile,
        distributionSample: distributionSample,
        allowsPlayerFacingRandomness: true
    ).hasRequiredFields)
    #expect(!LineageMutationPlanningProof(
        adoptionGate: adoptionGate,
        affectionProfile: affectionProfile,
        distributionSample: distributionSample,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageMutationPlanningProof(
        adoptionGate: adoptionGate,
        affectionProfile: affectionProfile,
        distributionSample: distributionSample,
        externalDependencyRequired: true
    ).hasRequiredFields)
}

@Test func lineageMutationAffectionProfileKeepsGameplayKitPlanAttachmentSafe() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let plan = try #require(LineageMutationPlanner.plan(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let profile = LineageMutationAffectionProfile(plan: plan)

    #expect(profile.hasRequiredFields)
    #expect(profile.usesGameplayKit)
    #expect(profile.resemblanceBeatsMutation)
    #expect(profile.inheritedLine == "Mostly echoes \(plan.inheritedTraitID).")
    #expect(profile.variationLine == "A \(plan.mutationLabel) may appear in \(plan.mutationTraitID).")
    #expect(profile.safetyLine == "Family resemblance stays stronger than the surprise.")
    #expect(profile.hidesSeedDetails)
    #expect(!profile.exposesRawRandomness)
    #expect(!profile.allowsPersistenceWrite)
    #expect(!profile.playerFacing)
    #expect(profile.summary == "lineageMutationAffectionProfile=source:GameplayKit,inherit:\(plan.inheritedTraitID),mutation:\(plan.mutationTraitID),hidesSeed:true,rawRandomness:false,persistence:false,playerFacing:false,resemblanceBeatsMutation:true")
    #expect(profile.readinessSummary == "lineageMutationAffectionProfileReady:true")
}

@Test func lineageMutationAffectionProfileRejectsRandomnessLeakage() {
    let readyPlan = LineageMutationPlan(
        seed: 42,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: "Mostly echoes tail, with a gentleVariation in glow."
    )
    let manualPlan = LineageMutationPlan(
        source: "Manual",
        seed: 42,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: "Manual random plan."
    )
    let weakPlan = LineageMutationPlan(
        seed: 43,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.56,
        mutationAmount: 0.18,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: "Mostly echoes tail, with a noticeableButSoft in glow."
    )

    #expect(!LineageMutationAffectionProfile(
        plan: manualPlan
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: weakPlan
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        inheritedLine: ""
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        variationLine: ""
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        hidesSeedDetails: false
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        exposesRawRandomness: true
    ).hasRequiredFields)
    #expect(!LineageMutationAffectionProfile(
        plan: readyPlan,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(LineageMutationAffectionProfile(
        plan: readyPlan,
        playerFacing: true
    ).readinessSummary == "lineageMutationAffectionProfileReady:false")
}

@Test func lineageMutationPlannerAffectionProfileHidesSeedDetails() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!

    let profile = try #require(LineageMutationPlanner.affectionProfile(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let repeatedProfile = try #require(LineageMutationPlanner.affectionProfile(
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let reversedParentProfile = try #require(LineageMutationPlanner.affectionProfile(
        parentIDs: [parentB, parentA],
        generation: 3
    ))

    #expect(profile == repeatedProfile)
    #expect(profile == reversedParentProfile)
    #expect(profile.hasRequiredFields)
    #expect(profile.usesGameplayKit)
    #expect(profile.hidesSeedDetails)
    #expect(!profile.exposesRawRandomness)
    #expect(!profile.allowsPersistenceWrite)
    #expect(!profile.playerFacing)
    #expect(profile.summary.contains("source:GameplayKit"))
    #expect(!profile.summary.contains("seed"))
    #expect(!profile.summary.contains("random"))
    #expect(profile.readinessSummary == "lineageMutationAffectionProfileReady:true")
}

@Test func lineageMutationPlannerAffectionProfileNeedsParents() {
    #expect(LineageMutationPlanner.affectionProfile(parentIDs: [], generation: 3) == nil)
}

@Test func growthCeremonyLineageAffectionCopyConsumesSeedHiddenProfile() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))
    let profile = try #require(LineageMutationPlanner.affectionProfile(
        parentIDs: [parentA, parentB],
        generation: 3
    ))

    let copy = GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: profile
    )

    #expect(copy.hasRequiredFields)
    #expect(copy.title == "Family echo")
    #expect(copy.inheritedLine == profile.inheritedLine)
    #expect(copy.variationLine == profile.variationLine)
    #expect(copy.safetyLine == profile.safetyLine)
    #expect(copy.affectionLine.hasPrefix("A familiar "))
    #expect(copy.affectionLine.contains(" echo stays close while a soft "))
    #expect(copy.affectionLine.hasSuffix(" difference waits."))
    #expect(!copy.affectionLine.lowercased().contains("random"))
    #expect(!copy.affectionLine.lowercased().contains("seed"))
    #expect(!copy.exposesSeedDetails)
    #expect(!copy.exposesRawRandomness)
    #expect(!copy.allowsMutation)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.publishesWidgetHandoff)
    #expect(copy.playerFacing)
    #expect(copy.summary == "growthLineageAffectionCopy=title:Family echo,inherit:\(profile.plan.inheritedTraitID),variation:\(profile.plan.mutationTraitID),seedHidden:true,rawRandomness:false,mutation:false,persistence:false,widget:false,playerFacing:true")
    #expect(!copy.summary.contains("seed:"))
    #expect(copy.readinessSummary == "growthLineageAffectionCopyReady:true")
}

@Test func growthCeremonyLineageAffectionCopyRejectsUnsafeCopy() throws {
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))
    let readyPlan = LineageMutationPlan(
        seed: 42,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.84,
        mutationAmount: 0.12,
        resemblanceLabel: "strongAncestorEcho",
        mutationLabel: "gentleVariation",
        affinityLine: "Mostly echoes tail, with a gentleVariation in glow."
    )
    let readyProfile = LineageMutationAffectionProfile(plan: readyPlan)
    let weakProfile = LineageMutationAffectionProfile(plan: LineageMutationPlan(
        seed: 43,
        generation: 3,
        inheritedTraitID: "tail",
        mutationTraitID: "glow",
        ancestralResemblance: 0.56,
        mutationAmount: 0.18,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: "Mostly echoes tail, with a noticeableButSoft in glow."
    ))

    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: weakProfile
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        title: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        inheritedLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        variationLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        affectionLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        exposesSeedDetails: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        exposesRawRandomness: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        allowsMutation: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(GrowthCeremonyLineageAffectionCopy(
        plan: ceremony,
        profile: readyProfile,
        playerFacing: false
    ).readinessSummary == "growthLineageAffectionCopyReady:false")
}

@Test func growthCeremonyContinuityLineCopyKeepsGrownFormAttachedToSamePet() {
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))

    let copy = GrowthCeremonyContinuityLineCopy(plan: ceremony)

    #expect(copy.hasRequiredFields)
    #expect(copy.continuityLine == "Adult Luma can still feel like the same Luma.")
    #expect(copy.continuityLine.contains("Luma"))
    #expect(copy.continuityLine.contains("Adult"))
    #expect(copy.previewOnly)
    #expect(!copy.allowsMutation)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.publishesWidgetHandoff)
    #expect(!copy.appendsDiscovery)
    #expect(copy.playerFacing)
    #expect(copy.summary == "growthContinuityLine=stage:adult,creature:Luma,lineReady:true,previewOnly:true,mutation:false,persistence:false,widget:false,discovery:false,playerFacing:true")
    #expect(copy.readinessSummary == "growthContinuityLineReady:true")
}

@Test func growthCeremonyContinuityLineCopyRejectsUnsafeOrDetachedLines() {
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))

    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, continuityLine: "").hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, continuityLine: "Adult form can still feel close.").hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, continuityLine: "Luma can still feel close.").hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, previewOnly: false).hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, allowsMutation: true).hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, appendsDiscovery: true).hasRequiredFields)
    #expect(!GrowthCeremonyContinuityLineCopy(plan: ceremony, playerFacing: false).hasRequiredFields)
    #expect(GrowthCeremonyContinuityLineCopy(
        plan: ceremony,
        continuityLine: "",
        allowsMutation: true
    ).readinessSummary == "growthContinuityLineReady:false")
}

@Test func growthCeremonyLineageAffectionCopyPreviewFactoryUsesGameplayKitProfileSafely() throws {
    let parentA = UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!
    let parentB = UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))

    let copy = try #require(GrowthCeremonyLineageAffectionCopy.preview(
        plan: ceremony,
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let repeatedCopy = try #require(GrowthCeremonyLineageAffectionCopy.preview(
        plan: ceremony,
        parentIDs: [parentA, parentB],
        generation: 3
    ))
    let reversedParentCopy = try #require(GrowthCeremonyLineageAffectionCopy.preview(
        plan: ceremony,
        parentIDs: [parentB, parentA],
        generation: 3
    ))

    #expect(copy == repeatedCopy)
    #expect(copy == reversedParentCopy)
    #expect(copy.hasRequiredFields)
    #expect(copy.profile.usesGameplayKit)
    #expect(copy.profile.hidesSeedDetails)
    #expect(!copy.affectionLine.lowercased().contains("seed"))
    #expect(!copy.affectionLine.lowercased().contains("random"))
    #expect(!copy.summary.contains("seed:"))
    #expect(!copy.exposesSeedDetails)
    #expect(!copy.exposesRawRandomness)
    #expect(!copy.allowsMutation)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.publishesWidgetHandoff)
    #expect(copy.playerFacing)
    #expect(copy.readinessSummary == "growthLineageAffectionCopyReady:true")
}

@Test func growthCeremonyLineageAffectionCopyPreviewFactoryNeedsParents() {
    let ceremony = GrowthCeremonyPlan(preview: GrowthMomentPreview(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult
    ))

    #expect(GrowthCeremonyLineageAffectionCopy.preview(
        plan: ceremony,
        parentIDs: [],
        generation: 3
    ) == nil)
}

@Test func lineageGenomePreviewUsesMutationPlanDeterministically() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let repeatedPreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let reversedPreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentB, parentA],
        generation: 4
    ))

    #expect(preview == repeatedPreview)
    #expect(preview == reversedPreview)
    #expect(preview.plan.generation == 4)
    #expect(preview.changedTraitID == preview.plan.mutationTraitID)
    #expect(preview.readinessSummary == "lineageGenomePreviewReady:true")
    #expect(preview.summary == "lineageGenomePreview=source:\(preview.plan.source),seed:\(preview.plan.seed),inheritParent:\(preview.inheritedParentID.uuidString),variationParent:\(preview.variationParentID.uuidString),changed:\(preview.changedTraitID),\(preview.plan.summary)")
    #expect(preview.affinityLine == "Mostly inherits from \(preview.inheritedParentID.uuidString), with \(preview.plan.mutationLabel) in \(preview.plan.mutationTraitID).")
}

@Test func lineageGenomePreviewLibraryAdoptionGateKeepsGameplayKitFamilyScoped() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let gate = LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: [parentA.id, parentB.id]
    )

    #expect(gate.usesGameplayKit)
    #expect(gate.changedTraitMatchesPlan)
    #expect(gate.parentsStayInFamily)
    #expect(gate.resemblanceBeatsMutation)
    #expect(gate.hasRequiredFields)
    #expect(gate.summary == "lineageGenomePreviewLibraryAdoption=source:GameplayKit,changedMatchesPlan:true,parentsInFamily:true,resemblanceBeatsMutation:true,coreOnly:true,playerFacingRandomness:false,persistence:false,breeding:false,externalDependency:false")
    #expect(gate.readinessSummary == "lineageGenomePreviewLibraryAdoptionReady:true")
}

@Test func lineageGenomePreviewPlannerBuildsGameplayKitPreviewAdoptionGate() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let gate = try #require(LineageGenomePreviewPlanner.libraryAdoptionGate(
        parents: [parentA, parentB],
        generation: 4
    ))
    let repeatedGate = try #require(LineageGenomePreviewPlanner.libraryAdoptionGate(
        parents: [parentA, parentB],
        generation: 4
    ))
    let reversedParentGate = try #require(LineageGenomePreviewPlanner.libraryAdoptionGate(
        parents: [parentB, parentA],
        generation: 4
    ))

    #expect(gate == repeatedGate)
    #expect(gate == reversedParentGate)
    #expect(gate.hasRequiredFields)
    #expect(gate.usesGameplayKit)
    #expect(gate.changedTraitMatchesPlan)
    #expect(gate.parentsStayInFamily)
    #expect(gate.resemblanceBeatsMutation)
    #expect(!gate.allowsPlayerFacingRandomness)
    #expect(!gate.allowsPersistenceWrite)
    #expect(!gate.allowsBreedingControls)
    #expect(!gate.externalDependencyRequired)
    #expect(gate.summary == "lineageGenomePreviewLibraryAdoption=source:GameplayKit,changedMatchesPlan:true,parentsInFamily:true,resemblanceBeatsMutation:true,coreOnly:true,playerFacingRandomness:false,persistence:false,breeding:false,externalDependency:false")
    #expect(gate.readinessSummary == "lineageGenomePreviewLibraryAdoptionReady:true")
}

@Test func lineageGenomePreviewPlannerAdoptionGateNeedsParents() {
    #expect(LineageGenomePreviewPlanner.libraryAdoptionGate(parents: [], generation: 4) == nil)
}

@Test func lineageReadOnlyPreviewCopyConsumesAffectionSafePreviewGate() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let gate = try #require(LineageGenomePreviewPlanner.libraryAdoptionGate(
        parents: [parentA, parentB],
        generation: 4
    ))

    let copy = LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    )

    #expect(copy.hasRequiredFields)
    #expect(copy.gate.hasRequiredFields)
    #expect(copy.gate.resemblanceBeatsMutation)
    #expect(copy.title == "Family preview")
    #expect(copy.inheritedLine == "This draft stays closest to Luma.")
    #expect(copy.variationLine == "Mira may lend a \(gate.preview.plan.mutationLabel) \(gate.preview.changedTraitID) cue.")
    #expect(copy.safetyLine == "Family resemblance stays stronger than the surprise.")
    #expect(!copy.inheritedLine.lowercased().contains("seed"))
    #expect(!copy.variationLine.lowercased().contains("random"))
    #expect(!copy.summary.contains("seed:"))
    #expect(!copy.exposesSeedDetails)
    #expect(!copy.exposesRawRandomness)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.allowsBreedingControls)
    #expect(!copy.publishesWidgetHandoff)
    #expect(!copy.playerFacing)
    #expect(copy.summary == "lineageReadOnlyPreviewCopy=title:Family preview,changed:\(gate.preview.changedTraitID),resemblanceBeatsMutation:true,seedHidden:true,rawRandomness:false,persistence:false,breeding:false,widget:false,playerFacing:false")
    #expect(copy.readinessSummary == "lineageReadOnlyPreviewCopyReady:true")
}

@Test func lineageReadOnlyPreviewCopyRejectsUnsafeSurfaceFlags() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let gate = try #require(LineageGenomePreviewPlanner.libraryAdoptionGate(
        parents: [parentA, parentB],
        generation: 4
    ))

    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        title: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        inheritedLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        variationLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        exposesSeedDetails: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        exposesRawRandomness: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(LineageReadOnlyPreviewCopy(
        gate: gate,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira",
        playerFacing: true
    ).readinessSummary == "lineageReadOnlyPreviewCopyReady:false")
}

@Test func lineageReadOnlyPreviewCopyFactoryUsesAffectionSafePreviewGate() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let copy = try #require(LineageReadOnlyPreviewCopy.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let repeatedCopy = try #require(LineageReadOnlyPreviewCopy.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let reversedParentCopy = try #require(LineageReadOnlyPreviewCopy.preview(
        parents: [parentB, parentA],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    #expect(copy == repeatedCopy)
    #expect(copy == reversedParentCopy)
    #expect(copy.hasRequiredFields)
    #expect(copy.gate.hasRequiredFields)
    #expect(copy.gate.usesGameplayKit)
    #expect(copy.gate.resemblanceBeatsMutation)
    #expect(copy.inheritedLine == "This draft stays closest to Luma.")
    #expect(copy.variationLine == "Mira may lend a \(copy.gate.preview.plan.mutationLabel) \(copy.gate.preview.changedTraitID) cue.")
    #expect(!copy.inheritedLine.lowercased().contains("seed"))
    #expect(!copy.variationLine.lowercased().contains("random"))
    #expect(!copy.summary.contains("seed:"))
    #expect(!copy.exposesSeedDetails)
    #expect(!copy.exposesRawRandomness)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.allowsBreedingControls)
    #expect(!copy.publishesWidgetHandoff)
    #expect(!copy.playerFacing)
    #expect(copy.readinessSummary == "lineageReadOnlyPreviewCopyReady:true")
}

@Test func lineageReadOnlyPreviewCopyFactoryNeedsParents() {
    #expect(LineageReadOnlyPreviewCopy.preview(
        parents: [],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ) == nil)
}

@Test func lineageReadOnlyPreviewSurfaceWrapsSafeCopyWithoutControls() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let copy = try #require(LineageReadOnlyPreviewCopy.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    let surface = LineageReadOnlyPreviewSurface(copy: copy)

    #expect(surface.hasRequiredFields)
    #expect(surface.copy.hasRequiredFields)
    #expect(surface.title == "Family preview")
    #expect(surface.subtitle == "A quiet look at what this line may remember.")
    #expect(surface.inheritedLine == copy.inheritedLine)
    #expect(surface.variationLine == copy.variationLine)
    #expect(surface.safetyLine == copy.safetyLine)
    #expect(!surface.allowsPersistenceWrite)
    #expect(!surface.allowsBreedingControls)
    #expect(!surface.allowsGraphNavigation)
    #expect(!surface.allowsOptimizationControls)
    #expect(!surface.publishesWidgetHandoff)
    #expect(!surface.playerFacing)
    #expect(surface.summary == "lineageReadOnlyPreviewSurface=title:Family preview,changed:\(copy.gate.preview.changedTraitID),readOnly:true,graph:false,optimization:false,widget:false,playerFacing:false")
    #expect(surface.readinessSummary == "lineageReadOnlyPreviewSurfaceReady:true")
}

@Test func lineageReadOnlyPreviewSurfaceRejectsManagementControls() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let copy = try #require(LineageReadOnlyPreviewCopy.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        subtitle: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        inheritedLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        variationLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        allowsGraphNavigation: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(!LineageReadOnlyPreviewSurface(
        copy: copy,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(LineageReadOnlyPreviewSurface(
        copy: copy,
        playerFacing: true
    ).readinessSummary == "lineageReadOnlyPreviewSurfaceReady:false")
}

@Test func lineageReadOnlyPreviewSurfaceFactoryUsesSafeCopy() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let surface = try #require(LineageReadOnlyPreviewSurface.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let repeatedSurface = try #require(LineageReadOnlyPreviewSurface.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let reversedParentSurface = try #require(LineageReadOnlyPreviewSurface.preview(
        parents: [parentB, parentA],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    #expect(surface == repeatedSurface)
    #expect(surface == reversedParentSurface)
    #expect(surface.hasRequiredFields)
    #expect(surface.copy.hasRequiredFields)
    #expect(surface.copy.gate.usesGameplayKit)
    #expect(surface.copy.gate.resemblanceBeatsMutation)
    #expect(surface.title == "Family preview")
    #expect(surface.subtitle == "A quiet look at what this line may remember.")
    #expect(!surface.inheritedLine.lowercased().contains("seed"))
    #expect(!surface.variationLine.lowercased().contains("random"))
    #expect(!surface.allowsPersistenceWrite)
    #expect(!surface.allowsBreedingControls)
    #expect(!surface.allowsGraphNavigation)
    #expect(!surface.allowsOptimizationControls)
    #expect(!surface.publishesWidgetHandoff)
    #expect(!surface.playerFacing)
    #expect(surface.readinessSummary == "lineageReadOnlyPreviewSurfaceReady:true")
}

@Test func lineageReadOnlyPreviewSurfaceFactoryNeedsParents() {
    #expect(LineageReadOnlyPreviewSurface.preview(
        parents: [],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ) == nil)
}

@Test func lineageReadOnlyPreviewSurfaceTextKeepsStableQuietLines() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let surface = try #require(LineageReadOnlyPreviewSurface.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    let text = try #require(LineageReadOnlyPreviewSurfaceText(surface: surface))

    #expect(text.hasRequiredFields)
    #expect(text.titleLine == "Family preview")
    #expect(text.subtitleLine == "A quiet look at what this line may remember.")
    #expect(text.inheritedLine == surface.inheritedLine)
    #expect(text.variationLine == surface.variationLine)
    #expect(text.safetyLine == surface.safetyLine)
    #expect(text.lines == [
        "Family preview",
        "A quiet look at what this line may remember.",
        surface.inheritedLine,
        surface.variationLine,
        surface.safetyLine
    ])
    #expect(text.snapshotText == text.lines.joined(separator: "\n"))
    #expect(!text.containsHiddenRandomDetails)
    #expect(!text.snapshotText.lowercased().contains("seed"))
    #expect(!text.snapshotText.lowercased().contains("random"))
    #expect(text.summary == "lineageReadOnlyPreviewSurfaceText=lines:5,changed:\(surface.copy.gate.preview.changedTraitID),readOnly:true,hiddenRandomDetails:false")
    #expect(text.readinessSummary == "lineageReadOnlyPreviewSurfaceTextReady:true")
}

@Test func lineageReadOnlyPreviewSurfaceTextRejectsUnsafeSurface() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let surface = try #require(LineageReadOnlyPreviewSurface.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let unsafeSurface = LineageReadOnlyPreviewSurface(
        copy: surface.copy,
        allowsGraphNavigation: true
    )

    #expect(LineageReadOnlyPreviewSurfaceText(surface: unsafeSurface) == nil)
}

@Test func lineageReadOnlyPreviewSurfaceTextFactoryBuildsStableLines() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let text = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let repeatedText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [parentA, parentB],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let reversedParentText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [parentB, parentA],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    #expect(text == repeatedText)
    #expect(text == reversedParentText)
    #expect(text.hasRequiredFields)
    #expect(text.surface.hasRequiredFields)
    #expect(text.surface.copy.gate.usesGameplayKit)
    #expect(text.surface.copy.gate.resemblanceBeatsMutation)
    #expect(text.lines.count == 5)
    #expect(text.lines.first == "Family preview")
    #expect(text.snapshotText == text.lines.joined(separator: "\n"))
    #expect(!text.containsHiddenRandomDetails)
    #expect(!text.snapshotText.lowercased().contains("seed"))
    #expect(!text.snapshotText.lowercased().contains("random"))
    #expect(text.readinessSummary == "lineageReadOnlyPreviewSurfaceTextReady:true")
}

@Test func lineageReadOnlyPreviewSurfaceTextFactoryNeedsParents() {
    #expect(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ) == nil)
}

@Test func lineageGenomePreviewLibraryAdoptionGateRejectsUnscopedPreviewRandomness() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let manualPlan = LineageMutationPlan(
        source: "Manual",
        seed: preview.plan.seed,
        generation: preview.plan.generation,
        inheritedTraitID: preview.plan.inheritedTraitID,
        mutationTraitID: preview.plan.mutationTraitID,
        ancestralResemblance: preview.plan.ancestralResemblance,
        mutationAmount: preview.plan.mutationAmount,
        resemblanceLabel: preview.plan.resemblanceLabel,
        mutationLabel: preview.plan.mutationLabel,
        affinityLine: preview.plan.affinityLine
    )
    let manualPreview = LineageGenomePreview(
        plan: manualPlan,
        genome: preview.genome,
        inheritedParentID: preview.inheritedParentID,
        variationParentID: preview.variationParentID,
        changedTraitID: preview.changedTraitID,
        affinityLine: preview.affinityLine
    )
    let mismatchedPreview = LineageGenomePreview(
        plan: preview.plan,
        genome: preview.genome,
        inheritedParentID: preview.inheritedParentID,
        variationParentID: preview.variationParentID,
        changedTraitID: "unexpectedTrait",
        affinityLine: preview.affinityLine
    )
    let weakPlan = LineageMutationPlan(
        source: "GameplayKit",
        seed: preview.plan.seed,
        generation: preview.plan.generation,
        inheritedTraitID: preview.plan.inheritedTraitID,
        mutationTraitID: preview.plan.mutationTraitID,
        ancestralResemblance: 0.58,
        mutationAmount: 0.20,
        resemblanceLabel: "softFamilyEcho",
        mutationLabel: "noticeableButSoft",
        affinityLine: preview.plan.affinityLine
    )
    let weakPreview = LineageGenomePreview(
        plan: weakPlan,
        genome: preview.genome,
        inheritedParentID: preview.inheritedParentID,
        variationParentID: preview.variationParentID,
        changedTraitID: weakPlan.mutationTraitID,
        affinityLine: preview.affinityLine
    )
    let parentIDs = [parentA.id, parentB.id]

    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: manualPreview,
        parentIDs: parentIDs
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: mismatchedPreview,
        parentIDs: parentIDs
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: weakPreview,
        parentIDs: parentIDs
    ).resemblanceBeatsMutation)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: weakPreview,
        parentIDs: parentIDs
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: [parentA.id]
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: parentIDs,
        coreOnlyScope: false
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: parentIDs,
        allowsPlayerFacingRandomness: true
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: parentIDs,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: parentIDs,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: parentIDs,
        externalDependencyRequired: true
    ).hasRequiredFields)
    #expect(LineageGenomePreviewLibraryAdoptionGate(
        preview: preview,
        parentIDs: [],
        allowsPlayerFacingRandomness: true
    ).readinessSummary == "lineageGenomePreviewLibraryAdoptionReady:false")
}

@Test func lineageGenomePreviewSearchFindsPreferredMutationTraitAndParentDeterministically() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4,
        matchingMutationTraits: [.face],
        preferredVariationParentID: parentB.id,
        saltPrefix: "WiPetLineagePreviewSearchTest",
        maxAttempts: 128
    ))
    let repeatedPreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4,
        matchingMutationTraits: [.face],
        preferredVariationParentID: parentB.id,
        saltPrefix: "WiPetLineagePreviewSearchTest",
        maxAttempts: 128
    ))
    let reversedParentPreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentB, parentA],
        generation: 4,
        matchingMutationTraits: [.face],
        preferredVariationParentID: parentB.id,
        saltPrefix: "WiPetLineagePreviewSearchTest",
        maxAttempts: 128
    ))

    #expect(preview == repeatedPreview)
    #expect(preview == reversedParentPreview)
    #expect(preview.changedTraitID == LineageMutationTrait.face.rawValue)
    #expect(preview.variationParentID == parentB.id)
    #expect(preview.genome.morph.face == parentB.genome.morph.face)
    #expect(preview.hasRequiredFields)
}

@Test func lineageGenomePreviewSearchRejectsEmptyTraitsAttemptsAndImpossibleParent() {
    let parentA = lineagePreviewParentA()
    let missingParentID = UUID(uuidString: "1C3B1250-E4AA-46AB-9C46-80767F02D12F")!

    #expect(LineageGenomePreviewPlanner.preview(
        parents: [parentA],
        generation: 4,
        matchingMutationTraits: [],
        maxAttempts: 128
    ) == nil)
    #expect(LineageGenomePreviewPlanner.preview(
        parents: [parentA],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 0
    ) == nil)
    #expect(LineageGenomePreviewPlanner.preview(
        parents: [parentA],
        generation: 4,
        matchingMutationTraits: [.face],
        preferredVariationParentID: missingParentID,
        maxAttempts: 128
    ) == nil)
}

@Test func lineageGenomePreviewNeedsParents() {
    #expect(LineageGenomePreviewPlanner.preview(parents: [], generation: 4) == nil)
}

@Test func lineageGenomePreviewDoesNotMutateParentGenomes() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let originalParentA = parentA
    let originalParentB = parentB

    _ = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))

    #expect(parentA == originalParentA)
    #expect(parentB == originalParentB)
}

@Test func lineageChildDraftMemoryReferenceKeepsPreviewMemoryOnly() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)

    #expect(reference.hasRequiredFields)
    #expect(reference.memorySource == "genomeVariationQA")
    #expect(!reference.allowsPersistenceWrite)
    #expect(!reference.allowsBreedingControls)
    #expect(!reference.playerFacing)
    #expect(reference.readinessSummary == "lineageChildDraftMemoryReady:true")
    #expect(reference.summary == "lineageChildDraftMemory=source:genomeVariationQA,generation:4,changed:\(preview.changedTraitID),inheritParent:\(preview.inheritedParentID.uuidString),variationParent:\(preview.variationParentID.uuidString),persistence:false,breeding:false,playerFacing:false")
}

@Test func lineageChildDraftMemoryReferenceRejectsWritesBreedingAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))

    #expect(!LineageChildDraftMemoryReference(
        preview: preview,
        memorySource: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftMemoryReference(
        preview: preview,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftMemoryReference(
        preview: preview,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftMemoryReference(
        preview: preview,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageChildDraftInheritedFaceEchoNamesVisibleReadOnlyFaceMemory() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)
    let echo = LineageChildDraftInheritedFaceEcho(
        memoryReference: reference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        accentDotCount: 4
    )

    #expect(echo.hasRequiredFields)
    #expect(echo.isFaceEcho)
    #expect(echo.accentDotCount == 4)
    #expect(echo.visibleInDraftPortrait)
    #expect(!echo.allowsPersistenceWrite)
    #expect(!echo.allowsBreedingControls)
    #expect(!echo.playerFacing)
    #expect(echo.summary == "lineageChildDraftInheritedFaceEcho=source:genomeVariationQA,changed:face,ancestor:Ori,face:softDeer,accent:forestDots,dots:4,visible:true,persistence:false,breeding:false,playerFacing:false")
    #expect(echo.readinessSummary == "lineageChildDraftInheritedFaceEchoReady:true")
}

@Test func lineageChildDraftInheritedFaceEchoRejectsMissingNonFaceAndWriteState() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let facePreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let bodyPreview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4,
        matchingMutationTraits: [.body],
        maxAttempts: 128
    ))
    let faceReference = LineageChildDraftMemoryReference(preview: facePreview)
    let bodyReference = LineageChildDraftMemoryReference(preview: bodyPreview)

    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "",
        faceCue: "softDeer",
        accentCue: "forestDots"
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "",
        accentCue: "forestDots"
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        visibleInDraftPortrait: false
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: bodyReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots"
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        accentDotCount: 6
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedFaceEcho(
        memoryReference: faceReference,
        ancestorLabel: "Ori",
        faceCue: "softDeer",
        accentCue: "forestDots",
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageChildDraftInheritedVisualCuePolicyRendersWingAndTailWithoutMutatingDraft() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)
    let policy = LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedWing: .fairy,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira"
    )
    let draftGenome = preview.genome
    let renderGenome = policy.renderGenome(for: draftGenome)

    #expect(policy.hasRequiredFields)
    #expect(policy.hasInheritedVisualCue)
    #expect(policy.previewOnly)
    #expect(!policy.allowsPersistenceWrite)
    #expect(!policy.publishesWidgetHandoff)
    #expect(!policy.allowsBreedingControls)
    #expect(!policy.exposesPlayerControls)
    #expect(!policy.outputsGeneratedAssets)
    #expect(!policy.playerFacing)
    #expect(draftGenome == preview.genome)
    #expect(renderGenome.morph.wing == .fairy)
    #expect(renderGenome.morph.tail == .fish)
    #expect(policy.summary == "lineageChildDraftInheritedVisualCuePolicy=source:genomeVariationQA,changed:\(preview.changedTraitID),wing:fairy,tail:fish,inheritedFrom:Mira,previewOnly:true,persistence:false,widget:false,breeding:false,controls:false,assetOutputs:none,playerFacing:false")
    #expect(policy.readinessSummary == "lineageChildDraftInheritedVisualCuePolicyReady:true")
}

@Test func lineageChildDraftInheritedVisualCuePolicyRejectsWritesControlsAndEmptyCue() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)

    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedFromLabel: "Mira"
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedWing: .fairy,
        inheritedFromLabel: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        previewOnly: false
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        exposesPlayerControls: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        outputsGeneratedAssets: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: reference,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira",
        playerFacing: true
    ).hasRequiredFields)
}

@Test func growthCeremonyInheritedVisualMemoryBridgeKeepsPolicyPreviewOnly() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let policy = LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedWing: .fairy,
        inheritedTail: .fish,
        inheritedFromLabel: "Mira"
    )
    let bridge = GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy
    )

    #expect(bridge.hasRequiredFields)
    #expect(bridge.memoryLine == "Luma's growth preview can remember Mira's fairy wing and fish tail.")
    #expect(bridge.previewOnly)
    #expect(!bridge.allowsMutation)
    #expect(!bridge.allowsPersistenceWrite)
    #expect(!bridge.publishesWidgetHandoff)
    #expect(!bridge.appendsDiscovery)
    #expect(!bridge.playerFacing)
    #expect(bridge.summary == "growthInheritedVisualMemoryBridge=source:genomeVariationQA,creature:Luma,ancestor:Mira,wing:fairy,tail:fish,previewOnly:true,mutation:false,persistence:false,widget:false,discovery:false,playerFacing:false")
    #expect(bridge.readinessSummary == "growthInheritedVisualMemoryBridgeReady:true")
}

@Test func growthCeremonyInheritedVisualMemoryBridgeRejectsWritesAndWeakMemoryLines() throws {
    let plan = GrowthCeremonyPlan(
        preview: GrowthMomentPreview(
            creatureName: "Luma",
            currentStage: .juvenile,
            nextStage: .adult
        )
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let policy = LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedTail: .fish,
        inheritedFromLabel: "Mira"
    )
    let emptyCuePolicy = LineageChildDraftInheritedVisualCuePolicy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedFromLabel: "Mira"
    )

    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: emptyCuePolicy
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        memoryLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        memoryLine: "A fish tail can stay close."
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        previewOnly: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        allowsMutation: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        appendsDiscovery: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualMemoryBridge(
        plan: plan,
        visualPolicy: policy,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func growthCeremonyInheritedVisualVisiblePromotionGateWaitsForVisualEvidence() throws {
    let bridge = try growthCeremonyInheritedVisualBridgeFixture()
    let hiddenGate = GrowthCeremonyInheritedVisualVisiblePromotionGate(bridge: bridge)
    let acceptedGate = GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true,
        appHostVisualQAReviewed: true,
        snapshotReferenceReviewed: true,
        ceremonyLayoutHasRoom: true
    )

    #expect(hiddenGate.hasRequiredFields)
    #expect(!hiddenGate.canPromoteVisibleLine)
    #expect(hiddenGate.summary == "growthInheritedVisualVisiblePromotionGate=bridgeReady:true,copyReview:false,appHostVisualQA:false,snapshotReview:false,layoutRoom:false,quietTone:true,promote:false,mutation:false,persistence:false,widget:false,discovery:false,playerFacing:false")
    #expect(hiddenGate.readinessSummary == "growthInheritedVisualVisiblePromotionGateReady:true")
    #expect(acceptedGate.hasRequiredFields)
    #expect(acceptedGate.canPromoteVisibleLine)
    #expect(acceptedGate.summary.contains("promote:true"))
}

@Test func growthCeremonyInheritedVisualVisiblePromotionGateRejectsCrowdingAndSideEffects() throws {
    let bridge = try growthCeremonyInheritedVisualBridgeFixture()
    let reviewedButCrowded = GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true,
        appHostVisualQAReviewed: true,
        snapshotReferenceReviewed: true,
        ceremonyLayoutHasRoom: false
    )

    #expect(reviewedButCrowded.hasRequiredFields)
    #expect(!reviewedButCrowded.canPromoteVisibleLine)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true,
        appHostVisualQAReviewed: true,
        snapshotReferenceReviewed: true,
        ceremonyLayoutHasRoom: true,
        preservesQuietTone: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        allowsMutation: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        appendsDiscovery: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func growthCeremonyInheritedVisualPromotionDeferralKeepsReviewedCopyHiddenUntilAppHostQA() throws {
    let bridge = try growthCeremonyInheritedVisualBridgeFixture()
    let gate = GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true
    )
    let deferral = GrowthCeremonyInheritedVisualPromotionDeferralEvidence(gate: gate)

    #expect(gate.hasRequiredFields)
    #expect(!gate.canPromoteVisibleLine)
    #expect(deferral.hasRequiredFields)
    #expect(!deferral.allowsMutation)
    #expect(!deferral.allowsPersistenceWrite)
    #expect(!deferral.publishesWidgetHandoff)
    #expect(!deferral.appendsDiscovery)
    #expect(!deferral.playerFacing)
    #expect(deferral.summary == "growthInheritedVisualPromotionDeferral=gateReady:true,copyReview:true,appHostVisualQA:false,snapshotReview:false,layoutRoom:false,reason:appHostVisualQAPending,defers:true,mutation:false,persistence:false,widget:false,discovery:false,playerFacing:false")
    #expect(deferral.readinessSummary == "growthInheritedVisualPromotionDeferralReady:true")
}

@Test func growthCeremonyInheritedVisualPromotionDeferralRejectsPromotionReadinessAndSideEffects() throws {
    let bridge = try growthCeremonyInheritedVisualBridgeFixture()
    let deferredGate = GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true
    )
    let acceptedGate = GrowthCeremonyInheritedVisualVisiblePromotionGate(
        bridge: bridge,
        manualCopyReviewed: true,
        appHostVisualQAReviewed: true,
        snapshotReferenceReviewed: true,
        ceremonyLayoutHasRoom: true
    )

    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: GrowthCeremonyInheritedVisualVisiblePromotionGate(bridge: bridge)
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: GrowthCeremonyInheritedVisualVisiblePromotionGate(
            bridge: bridge,
            manualCopyReviewed: true,
            appHostVisualQAReviewed: true
        )
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(gate: acceptedGate).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        deferralReason: "manualReviewPending"
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        allowsMutation: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        appendsDiscovery: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyInheritedVisualPromotionDeferralEvidence(
        gate: deferredGate,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageGenomeVariationFamilyEchoCopyNamesInheritedCueWithoutRandomLanguage() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let copy = LineageGenomeVariationFamilyEchoCopy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    )

    #expect(copy.hasRequiredFields)
    #expect(copy.visibleLine == "Mira keeps fairy winglets in the family, while Ori's soft deer-face echo may softly appear in the child draft.")
    #expect(!copy.exposesSeedDetails)
    #expect(!copy.allowsPersistenceWrite)
    #expect(!copy.allowsBreedingControls)
    #expect(!copy.playerFacing)
    #expect(copy.summary == "lineageGenomeVariationFamilyEchoCopy=source:genomeVariationQA,generation:4,changed:face,inheritedParent:Mira,variationAncestor:Ori,inheritedCue:fairy winglets,changedCue:soft deer-face echo,seed:false,persistence:false,breeding:false,playerFacing:false")
    #expect(copy.readinessSummary == "lineageGenomeVariationFamilyEchoCopyReady:true")
}

@Test func lineageGenomeVariationFamilyEchoCopyRejectsMissingCopyRandomnessWritesAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)

    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "",
        changedCue: "soft deer-face echo"
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: ""
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo",
        visibleLine: ""
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo",
        exposesSeedDetails: true
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo",
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo",
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: reference,
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo",
        playerFacing: true
    ).hasRequiredFields)
    #expect(!LineageGenomeVariationFamilyEchoCopy(
        memoryReference: LineageChildDraftMemoryReference(
            preview: preview,
            memorySource: ""
        ),
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    ).hasRequiredFields)
}

@Test func lineageAncestorPortraitMemoryCardNamesReadOnlyFamilyMemory() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let familyEcho = LineageGenomeVariationFamilyEchoCopy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    )
    let card = LineageAncestorPortraitMemoryCardCopy(familyEchoCopy: familyEcho)

    #expect(card.hasRequiredFields)
    #expect(card.title == "Ancestor memory")
    #expect(card.ancestorPortraitLabel == "Ori portrait")
    #expect(card.inheritedCueLine == "Mira keeps fairy winglets close.")
    #expect(card.changedCueLine == "Ori's soft deer-face echo is remembered here.")
    #expect(card.safetyLine == "This card only remembers the family echo.")
    #expect(!card.containsHiddenRandomDetails)
    #expect(!card.allowsPersistenceWrite)
    #expect(!card.allowsBreedingControls)
    #expect(!card.allowsOptimizationControls)
    #expect(!card.publishesWidgetHandoff)
    #expect(!card.playerFacing)
    #expect(card.summary == "lineageAncestorPortraitMemoryCard=ancestor:Ori,portrait:Ori portrait,changed:face,inheritedCue:fairy winglets,changedCue:soft deer-face echo,readOnly:true,seed:false,persistence:false,breeding:false,optimization:false,widget:false,playerFacing:false")
    #expect(card.readinessSummary == "lineageAncestorPortraitMemoryCardReady:true")
}

@Test func lineageAncestorPortraitMemoryCardRejectsHiddenRandomnessWritesControlsAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        matchingMutationTraits: [.face],
        maxAttempts: 128
    ))
    let familyEcho = LineageGenomeVariationFamilyEchoCopy(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        inheritedParentDisplayName: "Mira",
        variationAncestorDisplayName: "Ori",
        inheritedCue: "fairy winglets",
        changedCue: "soft deer-face echo"
    )

    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        ancestorPortraitLabel: ""
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        inheritedCueLine: "seed 42"
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        changedCueLine: "random mutation"
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: familyEcho,
        playerFacing: true
    ).hasRequiredFields)
    #expect(!LineageAncestorPortraitMemoryCardCopy(
        familyEchoCopy: LineageGenomeVariationFamilyEchoCopy(
            memoryReference: LineageChildDraftMemoryReference(preview: preview),
            inheritedParentDisplayName: "Mira",
            variationAncestorDisplayName: "Ori",
            inheritedCue: "fairy winglets",
            changedCue: "soft deer-face echo",
            exposesSeedDetails: true
        )
    ).hasRequiredFields)
}

@Test func lineageChildDraftAcknowledgementPreviewKeepsDraftReadOnly() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)
    let acknowledgement = LineageChildDraftAcknowledgementPreview(memoryReference: reference)

    #expect(acknowledgement.hasRequiredFields)
    #expect(acknowledgement.acknowledgementLine == "Notice the family echo before this draft becomes a memory.")
    #expect(!acknowledgement.isAcknowledged)
    #expect(!acknowledgement.allowsCommit)
    #expect(!acknowledgement.allowsPersistenceWrite)
    #expect(!acknowledgement.allowsBreedingControls)
    #expect(!acknowledgement.playerFacing)
    #expect(acknowledgement.readinessSummary == "lineageChildDraftAcknowledgementReady:true")
    #expect(acknowledgement.summary == "lineageChildDraftAcknowledgement=source:genomeVariationQA,generation:4,changed:\(preview.changedTraitID),acknowledged:false,allowsCommit:false,persistence:false,breeding:false,playerFacing:false")
}

@Test func lineageChildDraftAcknowledgementPreviewRejectsCommitWritesBreedingAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)

    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: reference,
        acknowledgementLine: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: reference,
        isAcknowledged: true,
        allowsPersistenceWrite: true,
        playerFacing: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: reference,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: reference,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: reference,
        playerFacing: true
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementPreview(
        memoryReference: LineageChildDraftMemoryReference(
            preview: preview,
            memorySource: ""
        )
    ).hasRequiredFields)
}

@Test func lineageChildDraftAcknowledgementSurfaceCopyNamesReadOnlyFamilyEcho() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let acknowledgement = LineageChildDraftAcknowledgementPreview(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let surface = LineageChildDraftAcknowledgementSurfaceCopy(acknowledgement: acknowledgement)

    #expect(surface.acknowledgement == acknowledgement)
    #expect(surface.promptLine == "Notice the family echo before this draft becomes a memory.")
    #expect(surface.waitingLine == "This family echo will wait until the moment is ready.")
    #expect(surface.hasRequiredFields)
    #expect(surface.summary == "lineageChildDraftAcknowledgementSurface=acknowledged:false,allowsCommit:false,promptReady:true,waitingReady:true")
    #expect(surface.readinessSummary == "lineageChildDraftAcknowledgementSurfaceReady:true")
}

@Test func lineageChildDraftAcknowledgementSurfaceCopyRejectsMissingCopyAndFutureCommitState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let acknowledgement = LineageChildDraftAcknowledgementPreview(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let futureCommitAcknowledgement = LineageChildDraftAcknowledgementPreview(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        isAcknowledged: true,
        allowsPersistenceWrite: true,
        playerFacing: true
    )

    #expect(!LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: acknowledgement,
        promptLine: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: acknowledgement,
        waitingLine: ""
    ).hasRequiredFields)
    #expect(!LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: futureCommitAcknowledgement
    ).hasRequiredFields)
}

@Test func lineageGenomePreviewChangesOnlyPlannedTraitFromInheritedParent() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [parentA, parentB],
        generation: 4
    ))
    let inheritedParent = try #require([parentA, parentB].first { $0.id == preview.inheritedParentID })
    let variationParent = try #require([parentA, parentB].first { $0.id == preview.variationParentID })

    assertLineagePreview(
        preview: preview,
        inheritedGenome: inheritedParent.genome,
        variationGenome: variationParent.genome
    )
}

@Test func lineageGenomePreviewClampsScalarVariation() throws {
    let parent = LineageParentGenome(
        id: UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!,
        genome: Genome(
            morph: MorphGenes(face: .round, body: .aquarian, wing: .fairy, tail: .fish),
            motion: MotionGenes(
                blink: ScalarGene(0.5),
                float: ScalarGene(0.98),
                tailMotion: ScalarGene(0.99),
                wingMotion: ScalarGene(1)
            ),
            pattern: PatternGenes(
                contrast: ScalarGene(0.5),
                glow: ScalarGene(0.98)
            )
        )
    )

    let preview = try #require(lineagePreview(
        parents: [parent],
        generation: 7,
        matchingMutationTraitIDs: ["glow", "motion"]
    ))

    #expect(preview.genome.pattern.glow.value <= 1)
    #expect(preview.genome.motion.float.value <= 1)
    #expect(preview.genome.motion.tailMotion.value <= 1)
    #expect(preview.genome.motion.wingMotion.value <= 1)
}

@Test func lineageGenomePreviewComparisonIsDeterministicAndParentOrderStable() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()

    let comparison = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentA, parentB],
        generation: 5
    ))
    let repeatedComparison = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentA, parentB],
        generation: 5
    ))
    let reversedComparison = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentB, parentA],
        generation: 5
    ))

    #expect(comparison == repeatedComparison)
    #expect(comparison == reversedComparison)
    #expect(comparison.sharedParentIDs == [parentA.id, parentB.id].sorted { $0.uuidString < $1.uuidString })
    #expect(comparison.first.changedTraitID == comparison.first.plan.mutationTraitID)
    #expect(comparison.second.changedTraitID == comparison.second.plan.mutationTraitID)
    #expect(comparison.readinessSummary == "lineageGenomePreviewComparisonReady:true")
    #expect(comparison.summary == "lineageGenomePreviewComparison=first:\(comparison.first.changedTraitID),second:\(comparison.second.changedTraitID),shared:\(comparison.sharedChangedTraitIDs.isEmpty ? "none" : comparison.sharedChangedTraitIDs.joined(separator: "+")),distinct:\(comparison.distinctChangedTraitIDs.isEmpty ? "none" : comparison.distinctChangedTraitIDs.joined(separator: "+")),parents:2")
}

@Test func lineageGenomePreviewComparisonNeedsParents() {
    #expect(LineageGenomePreviewComparisonPlanner.comparison(parents: [], generation: 5) == nil)
}

@Test func lineageGenomePreviewComparisonNamesSharedOrDistinctTraits() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let comparison = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentA, parentB],
        generation: 5
    ))

    if comparison.first.changedTraitID == comparison.second.changedTraitID {
        #expect(comparison.sharedChangedTraitIDs == [comparison.first.changedTraitID])
        #expect(comparison.distinctChangedTraitIDs.isEmpty)
        #expect(comparison.familyLine == "Both previews come from the same family, with the same gentle difference.")
    } else {
        #expect(comparison.sharedChangedTraitIDs.isEmpty)
        #expect(comparison.distinctChangedTraitIDs == [comparison.first.changedTraitID, comparison.second.changedTraitID].sorted())
        #expect(comparison.familyLine == "Both previews come from the same family, with different gentle differences.")
    }
}

@Test func lineageGenomePreviewComparisonDoesNotMutateParents() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let originalParentA = parentA
    let originalParentB = parentB

    _ = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentA, parentB],
        generation: 5
    ))

    #expect(parentA == originalParentA)
    #expect(parentB == originalParentB)
}

@Test func lineageGenomePreviewComparisonReadinessRequiresFamilyContext() throws {
    let parentA = lineagePreviewParentA()
    let parentB = lineagePreviewParentB()
    let comparison = try #require(LineageGenomePreviewComparisonPlanner.comparison(
        parents: [parentA, parentB],
        generation: 5
    ))
    let incompleteComparison = LineageGenomePreviewComparison(
        first: comparison.first,
        second: comparison.second,
        sharedParentIDs: [],
        sharedChangedTraitIDs: comparison.sharedChangedTraitIDs,
        distinctChangedTraitIDs: comparison.distinctChangedTraitIDs,
        familyLine: ""
    )

    #expect(comparison.hasRequiredFields)
    #expect(!incompleteComparison.hasRequiredFields)
    #expect(incompleteComparison.readinessSummary == "lineageGenomePreviewComparisonReady:false")
}

@Test func growthStagesStayInLifecycleOrder() {
    #expect(GrowthStage.egg < .baby)
    #expect(GrowthStage.baby < .juvenile)
    #expect(GrowthStage.juvenile < .adult)
    #expect(GrowthStage.adult < .elder)
}

@Test func growthStagesNameNextLifecycleStep() {
    #expect(GrowthStage.egg.nextStage == .baby)
    #expect(GrowthStage.baby.nextStage == .juvenile)
    #expect(GrowthStage.juvenile.nextStage == .adult)
    #expect(GrowthStage.adult.nextStage == .elder)
    #expect(GrowthStage.elder.nextStage == nil)
}

@Test func creatureNamesNextGrowthStageFromCurrentStage() {
    let juvenile = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let elder = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .elder
    )

    #expect(juvenile.nextGrowthStage == .adult)
    #expect(elder.nextGrowthStage == nil)
}

@Test func creaturePreviewsNextGrowthMomentWithoutMutating() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )

    let preview = try #require(creature.nextGrowthMomentPreview)

    #expect(preview.creatureName == "Luma")
    #expect(preview.currentStage == .juvenile)
    #expect(preview.nextStage == .adult)
    #expect(preview.title == "Luma is ready to grow into Adult.")
    #expect(preview.discoveryTitle == "Luma grew into Adult.")
    #expect(creature.growthStage == .juvenile)
}

@Test func creatureGrowthMomentPreviewIsNilForElder() {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .elder
    )

    #expect(creature.nextGrowthMomentPreview == nil)
}

@Test func creatureGrowthCeremonyPlanNamesPlayerFacingRequirements() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )

    let plan = try #require(creature.growthCeremonyPlan)

    #expect(plan.creatureName == "Luma")
    #expect(plan.currentStage == .juvenile)
    #expect(plan.nextStage == .adult)
    #expect(plan.previewTitle == "Luma is ready to grow into Adult.")
    #expect(plan.discoveryTitle == "Luma grew into Adult.")
    #expect(plan.requirements == [
        .playerAcknowledgement,
        .beforeAfterObservation,
        .discoveryLogHandoff,
        .widgetHandoff,
        .persistenceBeforeMutation
    ])
    #expect(plan.hasPlayerFacingRequirements)
    #expect(plan.traitReveal.traitID == "tailGlow")
    #expect(plan.traitReveal.displayName == "Tail glow")
    #expect(plan.traitReveal.currentCue == "small lunar shimmer")
    #expect(plan.traitReveal.nextCue == "deeper tail glow")
    #expect(plan.traitReveal.ceremonyLine == "The tail glow is deepening into an adult shimmer.")
    #expect(plan.traitReveal.summary == "growthTraitReveal=trait:tailGlow,from:small lunar shimmer,to:deeper tail glow")
    #expect(plan.traitReveal.readinessSummary == "growthTraitRevealReady:true")
    #expect(plan.confirmationGate.traitID == "tailGlow")
    #expect(plan.confirmationGate.requiredSteps == plan.requirements)
    #expect(!plan.confirmationGate.allowsMutation)
    #expect(plan.confirmationGate.readinessSummary == "growthConfirmationGateReady:true")
    #expect(plan.confirmationGate.summary == "growthConfirmationGate=ready:true,allowsMutation:false,required:playerAcknowledgement+beforeAfterObservation+discoveryLogHandoff+widgetHandoff+persistenceBeforeMutation,trait:tailGlow")
    #expect(plan.beforeAfterObservation.currentLine == "Luma now carries a small lunar shimmer.")
    #expect(plan.beforeAfterObservation.nextLine == "Adult Luma may show a deeper tail glow.")
    #expect(plan.beforeAfterObservation.comparisonLine == "Watch the tail glow before deciding together.")
    #expect(plan.beforeAfterObservation.readinessSummary == "growthBeforeAfterObservationReady:true")
    #expect(plan.beforeAfterObservation.summary == "growthBeforeAfterObservation=current:Luma now carries a small lunar shimmer.,next:Adult Luma may show a deeper tail glow.")
    #expect(plan.mutationProof.traitID == "tailGlow")
    #expect(plan.mutationProof.requiredEvidence == [
        .playerAcknowledgementRecorded,
        .beforeAfterObservationReviewed,
        .discoveryLogPrepared,
        .widgetHandoffPrepared,
        .persistenceWritePrepared
    ])
    #expect(plan.mutationProof.satisfiedEvidence.isEmpty)
    #expect(!plan.mutationProof.isSatisfied)
    #expect(plan.mutationProof.readinessSummary == "growthMutationProofReady:true")
    #expect(plan.mutationProof.summary == "growthMutationProof=ready:true,satisfied:false,required:playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared,satisfiedEvidence:none,trait:tailGlow")
    #expect(
        plan.readinessSummary == "growthCeremonyReady:true,requirements:playerAcknowledgement+beforeAfterObservation+discoveryLogHandoff+widgetHandoff+persistenceBeforeMutation,growthTraitRevealReady:true,growthTraitReveal=trait:tailGlow,from:small lunar shimmer,to:deeper tail glow,growthConfirmationGateReady:true,growthConfirmationGate=ready:true,allowsMutation:false,required:playerAcknowledgement+beforeAfterObservation+discoveryLogHandoff+widgetHandoff+persistenceBeforeMutation,trait:tailGlow,growthBeforeAfterObservationReady:true,growthBeforeAfterObservation=current:Luma now carries a small lunar shimmer.,next:Adult Luma may show a deeper tail glow.,growthMutationProofReady:true,growthMutationProof=ready:true,satisfied:false,required:playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared,satisfiedEvidence:none,trait:tailGlow"
    )
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyTraitRevealNamesLifecycleVisualCue() {
    #expect(GrowthCeremonyTraitReveal(currentStage: .egg, nextStage: .baby).summary == "growthTraitReveal=trait:bodyWarmth,from:quiet shell,to:soft body warmth")
    #expect(GrowthCeremonyTraitReveal(currentStage: .baby, nextStage: .juvenile).summary == "growthTraitReveal=trait:eyeExpression,from:sleepy gaze,to:curious gaze")
    #expect(GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult).summary == "growthTraitReveal=trait:tailGlow,from:small lunar shimmer,to:deeper tail glow")
    #expect(GrowthCeremonyTraitReveal(currentStage: .adult, nextStage: .elder).summary == "growthTraitReveal=trait:ancestralGlow,from:bright adult glow,to:gentle ancestral glow")
}

@Test func growthCeremonyTraitRevealReadinessRequiresAllFields() {
    let readyReveal = GrowthCeremonyTraitReveal(
        traitID: "tailGlow",
        displayName: "Tail glow",
        currentCue: "small lunar shimmer",
        nextCue: "deeper tail glow",
        ceremonyLine: "The tail glow is deepening."
    )
    let incompleteReveal = GrowthCeremonyTraitReveal(
        traitID: "tailGlow",
        displayName: "",
        currentCue: "small lunar shimmer",
        nextCue: "deeper tail glow",
        ceremonyLine: "The tail glow is deepening."
    )

    #expect(readyReveal.hasRequiredFields)
    #expect(readyReveal.readinessSummary == "growthTraitRevealReady:true")
    #expect(!incompleteReveal.hasRequiredFields)
    #expect(incompleteReveal.readinessSummary == "growthTraitRevealReady:false")
}

@Test func growthCeremonyConfirmationGateBlocksMutationUntilFutureConfirmation() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let gate = GrowthCeremonyConfirmationGate(
        requirements: GrowthCeremonyRequirement.playerFacingRequirements,
        traitReveal: reveal
    )

    #expect(gate.hasRequiredFields)
    #expect(!gate.allowsMutation)
    #expect(gate.requiredStepsSummary == "playerAcknowledgement+beforeAfterObservation+discoveryLogHandoff+widgetHandoff+persistenceBeforeMutation")
    #expect(gate.readinessSummary == "growthConfirmationGateReady:true")
    #expect(gate.summary == "growthConfirmationGate=ready:true,allowsMutation:false,required:playerAcknowledgement+beforeAfterObservation+discoveryLogHandoff+widgetHandoff+persistenceBeforeMutation,trait:tailGlow")
}

@Test func growthCeremonyConfirmationGateReadinessRequiresAllPlayerFacingSteps() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let incompleteGate = GrowthCeremonyConfirmationGate(
        requirements: [
            .playerAcknowledgement,
            .beforeAfterObservation
        ],
        traitReveal: reveal
    )

    #expect(!incompleteGate.hasRequiredFields)
    #expect(!incompleteGate.allowsMutation)
    #expect(incompleteGate.readinessSummary == "growthConfirmationGateReady:false")
    #expect(incompleteGate.summary == "growthConfirmationGate=ready:false,allowsMutation:false,required:playerAcknowledgement+beforeAfterObservation,trait:tailGlow")
}

@Test func growthCeremonyMutationProofNamesRequiredEvidenceBeforeMutation() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let proof = GrowthCeremonyMutationProof(traitReveal: reveal)

    #expect(proof.traitID == "tailGlow")
    #expect(proof.requiredEvidence == GrowthCeremonyMutationProofEvidence.requiredEvidence)
    #expect(proof.satisfiedEvidence.isEmpty)
    #expect(proof.hasRequiredFields)
    #expect(!proof.isSatisfied)
    #expect(proof.requiredEvidenceSummary == "playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared")
    #expect(proof.satisfiedEvidenceSummary == "none")
    #expect(proof.readinessSummary == "growthMutationProofReady:true")
    #expect(proof.summary == "growthMutationProof=ready:true,satisfied:false,required:playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared,satisfiedEvidence:none,trait:tailGlow")
}

@Test func growthCeremonyMutationProofRequiresAllEvidenceToBeSatisfied() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let partialProof = GrowthCeremonyMutationProof(
        traitReveal: reveal,
        satisfiedEvidence: [
            .playerAcknowledgementRecorded,
            .beforeAfterObservationReviewed,
            .discoveryLogPrepared
        ]
    )
    let satisfiedProof = GrowthCeremonyMutationProof(
        traitReveal: reveal,
        satisfiedEvidence: GrowthCeremonyMutationProofEvidence.requiredEvidence
    )

    #expect(!partialProof.isSatisfied)
    #expect(partialProof.satisfiedEvidenceSummary == "playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared")
    #expect(satisfiedProof.isSatisfied)
    #expect(satisfiedProof.summary == "growthMutationProof=ready:true,satisfied:true,required:playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared,satisfiedEvidence:playerAcknowledgementRecorded+beforeAfterObservationReviewed+discoveryLogPrepared+widgetHandoffPrepared+persistenceWritePrepared,trait:tailGlow")
}

@Test func growthCeremonyMutationProofReadinessRequiresTraitAndChecklist() {
    let incompleteProof = GrowthCeremonyMutationProof(
        requiredEvidence: [
            .playerAcknowledgementRecorded,
            .beforeAfterObservationReviewed
        ],
        traitID: ""
    )

    #expect(!incompleteProof.hasRequiredFields)
    #expect(!incompleteProof.isSatisfied)
    #expect(incompleteProof.readinessSummary == "growthMutationProofReady:false")
    #expect(incompleteProof.summary == "growthMutationProof=ready:false,satisfied:false,required:playerAcknowledgementRecorded+beforeAfterObservationReviewed,satisfiedEvidence:none,trait:")
}

@Test func growthCeremonyBeforeAfterObservationNamesCurrentAndNextLines() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let observation = GrowthCeremonyBeforeAfterObservation(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult,
        traitReveal: reveal
    )

    #expect(observation.currentLine == "Luma now carries a small lunar shimmer.")
    #expect(observation.nextLine == "Adult Luma may show a deeper tail glow.")
    #expect(observation.comparisonLine == "Watch the tail glow before deciding together.")
    #expect(observation.hasRequiredFields)
    #expect(observation.readinessSummary == "growthBeforeAfterObservationReady:true")
    #expect(observation.summary == "growthBeforeAfterObservation=current:Luma now carries a small lunar shimmer.,next:Adult Luma may show a deeper tail glow.")
}

@Test func growthCeremonyBeforeAfterObservationReadinessRequiresAllLines() {
    let incompleteObservation = GrowthCeremonyBeforeAfterObservation(
        currentLine: "Luma now carries a small lunar shimmer.",
        nextLine: "",
        comparisonLine: "Watch the tail glow before deciding together."
    )

    #expect(!incompleteObservation.hasRequiredFields)
    #expect(incompleteObservation.readinessSummary == "growthBeforeAfterObservationReady:false")
}

@Test func growthCeremonyObservationAcknowledgementInteractionStaysPreviewOnly() {
    let observation = GrowthCeremonyBeforeAfterObservation(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult,
        traitReveal: GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    )
    let interaction = GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        hasNotedObservation: true
    )

    #expect(interaction.observation == observation)
    #expect(interaction.hasNotedObservation)
    #expect(interaction.noteLine == "I noticed this change")
    #expect(interaction.waitingLine == "This only marks the preview as noticed.")
    #expect(interaction.previewOnly)
    #expect(!interaction.enabledInNormalUI)
    #expect(!interaction.allowsMutation)
    #expect(!interaction.allowsPersistenceWrite)
    #expect(!interaction.publishesWidgetHandoff)
    #expect(!interaction.appendsDiscovery)
    #expect(interaction.hasRequiredFields)
    #expect(interaction.summary == "growthObservationAcknowledgement=noted:true,previewOnly:true,normalUI:false,mutation:false,persistence:false,widget:false,discovery:false")
    #expect(interaction.readinessSummary == "growthObservationAcknowledgementReady:true")
}

@Test func growthCeremonyObservationAcknowledgementInteractionRejectsWritesAndNormalUI() {
    let observation = GrowthCeremonyBeforeAfterObservation(
        creatureName: "Luma",
        currentStage: .juvenile,
        nextStage: .adult,
        traitReveal: GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    )
    let incompleteObservation = GrowthCeremonyBeforeAfterObservation(
        currentLine: "",
        nextLine: "Adult Luma may show a deeper tail glow.",
        comparisonLine: "Watch the tail glow before deciding together."
    )

    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: incompleteObservation
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        noteLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        waitingLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        previewOnly: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        enabledInNormalUI: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        allowsMutation: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        appendsDiscovery: true
    ).hasRequiredFields)
    #expect(GrowthCeremonyObservationAcknowledgementInteraction(
        observation: observation,
        allowsMutation: true
    ).readinessSummary == "growthObservationAcknowledgementReady:false")
}

@Test func growthCeremonyLineageCueBridgeConnectsTraitRevealToAncestorCueWithoutMutation() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let bridge = GrowthCeremonyLineageCueBridge(
        traitReveal: reveal,
        lineageCopy: lineageCopy
    )

    #expect(bridge.traitReveal == reveal)
    #expect(bridge.lineageCopy == lineageCopy)
    #expect(bridge.ceremonyLine == "Notice the tail glow beside floating tail.")
    #expect(!bridge.allowsMutation)
    #expect(bridge.hasRequiredFields)
    #expect(bridge.summary == "growthLineageCueBridge=trait:tailGlow,cue:floatingRibbon,ancestor:firstAncestor,allowsMutation:false")
    #expect(bridge.readinessSummary == "growthLineageCueBridgeReady:true")
}

@Test func growthCeremonyLineageCueBridgeReadinessRequiresTraitRevealAndLineageCopy() {
    let readyReveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let incompleteReveal = GrowthCeremonyTraitReveal(
        traitID: "",
        displayName: "Tail glow",
        currentCue: "small lunar shimmer",
        nextCue: "deeper tail glow",
        ceremonyLine: "The tail glow is deepening into an adult shimmer."
    )
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let incompleteMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let readyBridge = GrowthCeremonyLineageCueBridge(
        traitReveal: readyReveal,
        lineageCopy: LineageVisibleCueObservationCopy(memory: readyMemory)
    )
    let incompleteRevealBridge = GrowthCeremonyLineageCueBridge(
        traitReveal: incompleteReveal,
        lineageCopy: LineageVisibleCueObservationCopy(memory: readyMemory)
    )
    let incompleteLineageBridge = GrowthCeremonyLineageCueBridge(
        traitReveal: readyReveal,
        lineageCopy: LineageVisibleCueObservationCopy(memory: incompleteMemory)
    )

    #expect(readyBridge.hasRequiredFields)
    #expect(!incompleteRevealBridge.hasRequiredFields)
    #expect(!incompleteLineageBridge.hasRequiredFields)
    #expect(readyBridge.readinessSummary == "growthLineageCueBridgeReady:true")
    #expect(incompleteRevealBridge.readinessSummary == "growthLineageCueBridgeReady:false")
    #expect(incompleteLineageBridge.readinessSummary == "growthLineageCueBridgeReady:false")
}

@Test func growthCeremonyLineageTeaserCopyUsesLineageObservationWithoutMutation() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let bridge = GrowthCeremonyLineageCueBridge(
        traitReveal: reveal,
        lineageCopy: lineageCopy
    )
    let teaser = GrowthCeremonyLineageTeaserCopy(
        previewTitle: "Luma is ready to grow into Adult.",
        bridge: bridge
    )

    #expect(teaser.eyebrow == "A quiet change is near")
    #expect(teaser.title == "Luma is ready to grow into Adult.")
    #expect(teaser.lineageLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(teaser.accessibilityLabel == "A quiet change is near, Luma is ready to grow into Adult., Floating tail carries a quiet echo of first ancestor.")
    #expect(!teaser.bridge.allowsMutation)
    #expect(teaser.hasRequiredFields)
    #expect(teaser.summary == "growthLineageTeaser=trait:tailGlow,cue:floatingRibbon,ancestor:firstAncestor,playerFacing:false")
    #expect(teaser.readinessSummary == "growthLineageTeaserReady:true")
}

@Test func growthCeremonyLineageTeaserCopyReadinessRequiresCopyAndMutationBlock() {
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let mutationBridge = GrowthCeremonyLineageCueBridge(
        traitReveal: reveal,
        lineageCopy: lineageCopy,
        allowsMutation: true
    )
    let missingLine = GrowthCeremonyLineageTeaserCopy(
        previewTitle: "Luma is ready to grow into Adult.",
        bridge: GrowthCeremonyLineageCueBridge(
            traitReveal: reveal,
            lineageCopy: lineageCopy
        ),
        lineageLine: ""
    )
    let mutationAllowed = GrowthCeremonyLineageTeaserCopy(
        previewTitle: "Luma is ready to grow into Adult.",
        bridge: mutationBridge
    )

    #expect(!missingLine.hasRequiredFields)
    #expect(!mutationAllowed.hasRequiredFields)
    #expect(missingLine.readinessSummary == "growthLineageTeaserReady:false")
    #expect(mutationAllowed.readinessSummary == "growthLineageTeaserReady:false")
}

@Test func growthCeremonyDiscoveryLogHandoffPreviewPreparesMemoryWithoutWriting() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let reveal = GrowthCeremonyTraitReveal(currentStage: .juvenile, nextStage: .adult)
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let bridge = GrowthCeremonyLineageCueBridge(
        traitReveal: reveal,
        lineageCopy: LineageVisibleCueObservationCopy(memory: memory)
    )
    let lineageTeaser = GrowthCeremonyLineageTeaserCopy(
        previewTitle: plan.previewTitle,
        bridge: bridge
    )
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        lineageTeaserCopy: lineageTeaser
    )

    #expect(handoff.discoveryTitle == "Luma grew into Adult.")
    #expect(handoff.stage == .adult)
    #expect(handoff.kind == .growth)
    #expect(handoff.memoryLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(handoff.includesLineageEcho)
    #expect(!handoff.allowsWrite)
    #expect(handoff.hasRequiredFields)
    #expect(handoff.summary == "growthDiscoveryLogHandoff=title:Luma grew into Adult.,stage:adult,kind:growth,lineage:true,allowsWrite:false")
    #expect(handoff.readinessSummary == "growthDiscoveryLogHandoffReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyDiscoveryLogHandoffPreviewFallsBackToTraitLineWithoutLineage() throws {
    let creature = Creature(
        name: "Mira",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian, wing: .fairy, tail: .fish)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let writableHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        allowsWrite: true
    )

    #expect(handoff.memoryLine == "The tail glow is deepening into an adult shimmer.")
    #expect(!handoff.includesLineageEcho)
    #expect(!handoff.allowsWrite)
    #expect(handoff.hasRequiredFields)
    #expect(handoff.summary == "growthDiscoveryLogHandoff=title:Mira grew into Adult.,stage:adult,kind:growth,lineage:false,allowsWrite:false")
    #expect(!writableHandoff.hasRequiredFields)
    #expect(writableHandoff.readinessSummary == "growthDiscoveryLogHandoffReady:false")
}

@Test func growthCeremonyNoticedMemoryLineAppearsOnlyAfterSafeAcknowledgement() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let pendingLine = GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: false
    )
    let noticedLine = GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true
    )

    #expect(!pendingLine.hasRequiredFields)
    #expect(!pendingLine.shouldDisplay)
    #expect(pendingLine.readinessSummary == "growthNoticedMemoryLineReady:false")
    #expect(noticedLine.memoryLine == "This noticed change will wait as a quiet memory.")
    #expect(noticedLine.previewOnly)
    #expect(!noticedLine.allowsWrite)
    #expect(!noticedLine.mutatesCreature)
    #expect(!noticedLine.publishesWidgetHandoff)
    #expect(!noticedLine.appendsDiscovery)
    #expect(noticedLine.hasRequiredFields)
    #expect(noticedLine.shouldDisplay)
    #expect(noticedLine.summary == "growthNoticedMemoryLine=acknowledged:true,display:true,previewOnly:true,write:false,mutation:false,widget:false,discovery:false")
    #expect(noticedLine.readinessSummary == "growthNoticedMemoryLineReady:true")
}

@Test func growthCeremonyNoticedMemoryLineRejectsWritesAndSideEffects() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let writableHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        allowsWrite: true
    )

    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        memoryLine: ""
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        previewOnly: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        allowsWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: writableHandoff,
        isPlayerAcknowledged: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        mutatesCreature: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: handoff,
        isPlayerAcknowledged: true,
        appendsDiscovery: true
    ).hasRequiredFields)
    #expect(GrowthCeremonyNoticedMemoryLineCopy(
        discoveryHandoff: writableHandoff,
        isPlayerAcknowledged: true
    ).summary == "growthNoticedMemoryLine=acknowledged:true,display:false,previewOnly:true,write:true,mutation:false,widget:false,discovery:false")
}

@Test func growthCeremonyNoticedMemoryCatalogNamesKnownGrowthCues() throws {
    let hornEntry = try #require(GrowthCeremonyNoticedMemoryCatalog.entry(for: "tinyRoundedBud"))
    let crescentHornEntry = try #require(GrowthCeremonyNoticedMemoryCatalog.entry(for: "softCrescentBud"))
    let tailEntry = try #require(GrowthCeremonyNoticedMemoryCatalog.entry(for: "softTailTipGlint"))
    let bodyEntry = try #require(GrowthCeremonyNoticedMemoryCatalog.entry(for: "crescentBelly"))

    #expect(hornEntry.cueID == "tinyRoundedBud")
    #expect(hornEntry.traitID == "hornGrowth")
    #expect(hornEntry.memoryLine == "The tiny rounded bud can wait here as a quiet growth memory.")
    #expect(hornEntry.hasRequiredFields)
    #expect(hornEntry.summary == "growthNoticedMemoryCatalog=cue:tinyRoundedBud,trait:hornGrowth,previewOnly:true,write:false,mutation:false,widget:false,discovery:false")
    #expect(hornEntry.readinessSummary == "growthNoticedMemoryCatalogReady:true")
    #expect(crescentHornEntry.cueID == "softCrescentBud")
    #expect(crescentHornEntry.traitID == "hornGrowth")
    #expect(crescentHornEntry.memoryLine == "The soft crescent buds can wait here as a quiet growth memory.")
    #expect(crescentHornEntry.hasRequiredFields)
    #expect(crescentHornEntry.summary == "growthNoticedMemoryCatalog=cue:softCrescentBud,trait:hornGrowth,previewOnly:true,write:false,mutation:false,widget:false,discovery:false")
    #expect(crescentHornEntry.readinessSummary == "growthNoticedMemoryCatalogReady:true")
    #expect(tailEntry.cueID == "softTailTipGlint")
    #expect(tailEntry.traitID == "tailGrowth")
    #expect(tailEntry.memoryLine == "Soft tail-tip glow will wait here as a quiet memory.")
    #expect(tailEntry.hasRequiredFields)
    #expect(tailEntry.summary == "growthNoticedMemoryCatalog=cue:softTailTipGlint,trait:tailGrowth,previewOnly:true,write:false,mutation:false,widget:false,discovery:false")
    #expect(tailEntry.readinessSummary == "growthNoticedMemoryCatalogReady:true")
    #expect(bodyEntry.cueID == "crescentBelly")
    #expect(bodyEntry.traitID == "bodyAccent")
    #expect(bodyEntry.memoryLine == "The soft moon-belly mark can wait here as a quiet memory.")
    #expect(bodyEntry.hasRequiredFields)
    #expect(bodyEntry.summary == "growthNoticedMemoryCatalog=cue:crescentBelly,trait:bodyAccent,previewOnly:true,write:false,mutation:false,widget:false,discovery:false")
    #expect(bodyEntry.readinessSummary == "growthNoticedMemoryCatalogReady:true")
}

@Test func growthCeremonyNoticedMemoryCatalogRejectsUnknownOrSideEffectfulEntries() {
    let emptyCopyEntry = GrowthCeremonyNoticedMemoryCatalogEntry(
        cueID: "softTailTipGlint",
        traitID: "tailGrowth",
        memoryLine: ""
    )
    let sideEffectfulEntry = GrowthCeremonyNoticedMemoryCatalogEntry(
        cueID: "softTailTipGlint",
        traitID: "tailGrowth",
        memoryLine: "Soft tail-tip glow will wait here as a quiet memory.",
        allowsWrite: true,
        mutatesCreature: true,
        publishesWidgetHandoff: true,
        appendsDiscovery: true
    )

    #expect(GrowthCeremonyNoticedMemoryCatalog.entry(for: "dormantBud") == nil)
    #expect(GrowthCeremonyNoticedMemoryCatalog.entry(for: "") == nil)
    #expect(!emptyCopyEntry.hasRequiredFields)
    #expect(emptyCopyEntry.readinessSummary == "growthNoticedMemoryCatalogReady:false")
    #expect(!sideEffectfulEntry.hasRequiredFields)
    #expect(sideEffectfulEntry.summary == "growthNoticedMemoryCatalog=cue:softTailTipGlint,trait:tailGrowth,previewOnly:true,write:true,mutation:true,widget:true,discovery:true")
}

@Test func growthCeremonyPlayerAcknowledgementGatePreviewBlocksCommitUntilAcknowledgedAndProofSatisfied() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let gate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: handoff,
        mutationProof: plan.mutationProof
    )

    #expect(gate.acknowledgementLine == "Notice the change together before it becomes a memory.")
    #expect(!gate.isPlayerAcknowledged)
    #expect(gate.discoveryHandoff == handoff)
    #expect(gate.mutationProof == plan.mutationProof)
    #expect(!gate.allowsCommit)
    #expect(gate.hasRequiredFields)
    #expect(gate.summary == "growthAcknowledgementGate=acknowledged:false,handoffReady:true,proofSatisfied:false,allowsCommit:false")
    #expect(gate.readinessSummary == "growthAcknowledgementGateReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyPlayerAcknowledgementGatePreviewAllowsCommitOnlyWhenAllFutureEvidenceIsSatisfied() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let writableHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        allowsWrite: true
    )
    let satisfiedProof = GrowthCeremonyMutationProof(
        traitReveal: plan.traitReveal,
        satisfiedEvidence: GrowthCeremonyMutationProofEvidence.requiredEvidence
    )
    let futureCommitGate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: writableHandoff,
        mutationProof: satisfiedProof,
        isPlayerAcknowledged: true
    )
    let missingLineGate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan),
        mutationProof: plan.mutationProof,
        acknowledgementLine: ""
    )

    #expect(futureCommitGate.allowsCommit)
    #expect(!futureCommitGate.hasRequiredFields)
    #expect(futureCommitGate.summary == "growthAcknowledgementGate=acknowledged:true,handoffReady:false,proofSatisfied:true,allowsCommit:true")
    #expect(!missingLineGate.hasRequiredFields)
    #expect(missingLineGate.readinessSummary == "growthAcknowledgementGateReady:false")
}

@Test func growthCeremonyAcknowledgementSurfaceCopyNamesPreviewOnlyPrompt() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let gate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: handoff,
        mutationProof: plan.mutationProof
    )
    let surface = GrowthCeremonyAcknowledgementSurfaceCopy(gate: gate)

    #expect(surface.gate == gate)
    #expect(surface.promptLine == "Notice the change together before it becomes a memory.")
    #expect(surface.commitStateLine == "This memory will wait until the moment is noticed.")
    #expect(surface.hasRequiredFields)
    #expect(surface.summary == "growthAcknowledgementSurface=acknowledged:false,allowsCommit:false,promptReady:true")
    #expect(surface.readinessSummary == "growthAcknowledgementSurfaceReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyAcknowledgementSurfaceCopyReadinessBlocksCommitStateAndMissingPrompt() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let futureGate = GrowthCeremonyPlayerAcknowledgementGatePreview(
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview(
            plan: plan,
            allowsWrite: true
        ),
        mutationProof: GrowthCeremonyMutationProof(
            traitReveal: plan.traitReveal,
            satisfiedEvidence: GrowthCeremonyMutationProofEvidence.requiredEvidence
        ),
        isPlayerAcknowledged: true
    )
    let commitSurface = GrowthCeremonyAcknowledgementSurfaceCopy(gate: futureGate)
    let missingPrompt = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan),
            mutationProof: plan.mutationProof
        ),
        promptLine: ""
    )

    #expect(futureGate.allowsCommit)
    #expect(!commitSurface.hasRequiredFields)
    #expect(commitSurface.readinessSummary == "growthAcknowledgementSurfaceReady:false")
    #expect(!missingPrompt.hasRequiredFields)
    #expect(missingPrompt.summary == "growthAcknowledgementSurface=acknowledged:false,allowsCommit:false,promptReady:false")
}

@Test func growthCeremonyConfirmationSurfaceCopyNamesPreviewReviewWithoutWriting() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let surface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )

    #expect(surface.title == "Ceremony preview")
    #expect(surface.confirmationLine == "Watch the tail glow before deciding together.")
    #expect(surface.safetyLine == "This memory will wait until the moment is noticed.")
    #expect(surface.hasRequiredFields)
    #expect(surface.summary == "growthConfirmationSurface=title:Ceremony preview,observationReady:true,acknowledgementReady:true,handoffWrite:false,allowsCommit:false")
    #expect(surface.readinessSummary == "growthConfirmationSurfaceReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyConfirmationSurfaceCopyRejectsCommitOrWriteState() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let writableHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        allowsWrite: true
    )
    let committingSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: writableHandoff,
            mutationProof: GrowthCeremonyMutationProof(
                traitReveal: plan.traitReveal,
                satisfiedEvidence: GrowthCeremonyMutationProofEvidence.requiredEvidence
            ),
            isPlayerAcknowledged: true
        )
    )
    let surface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: committingSurface,
        discoveryHandoff: writableHandoff
    )
    let missingLine = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: GrowthCeremonyAcknowledgementSurfaceCopy(
            gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
                discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan),
                mutationProof: plan.mutationProof
            )
        ),
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan),
        confirmationLine: ""
    )

    #expect(writableHandoff.allowsWrite)
    #expect(committingSurface.gate.allowsCommit)
    #expect(!surface.hasRequiredFields)
    #expect(surface.readinessSummary == "growthConfirmationSurfaceReady:false")
    #expect(!missingLine.hasRequiredFields)
}

@Test func growthCeremonyAcknowledgementIntentContractStaysPreviewOnlyAndNonWriting() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let intent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )

    #expect(intent.intentLabel == "I noticed this change")
    #expect(intent.disabledReason == "Growth will wait until memory and Widget handoff are prepared.")
    #expect(intent.previewOnly)
    #expect(!intent.enabledInNormalUI)
    #expect(!intent.allowsMutation)
    #expect(!intent.allowsPersistenceWrite)
    #expect(!intent.publishesWidgetHandoff)
    #expect(intent.hasRequiredFields)
    #expect(intent.summary == "growthAcknowledgementIntent=intent:I noticed this change,previewOnly:true,normalUI:false,mutation:false,persistence:false,widget:false")
    #expect(intent.readinessSummary == "growthAcknowledgementIntentReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyAcknowledgementIntentContractRejectsEnabledOrWritingState() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let enabledIntent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface,
        enabledInNormalUI: true
    )
    let writingIntent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface,
        allowsMutation: true,
        allowsPersistenceWrite: true,
        publishesWidgetHandoff: true
    )
    let missingLabel = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface,
        intentLabel: ""
    )

    #expect(!enabledIntent.hasRequiredFields)
    #expect(enabledIntent.readinessSummary == "growthAcknowledgementIntentReady:false")
    #expect(!writingIntent.hasRequiredFields)
    #expect(!missingLabel.hasRequiredFields)
}

@Test func growthCeremonyPersistenceBoundaryContractNamesSafeDryRunTargets() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let intent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )
    let boundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent
    )

    #expect(boundary.targetsSwiftData)
    #expect(boundary.targetsAppGroup)
    #expect(boundary.dryRunOnly)
    #expect(!boundary.performsPersistenceWrite)
    #expect(!boundary.mutatesCreature)
    #expect(!boundary.appendsDiscovery)
    #expect(!boundary.publishesWidgetHandoff)
    #expect(boundary.isSafeDryRun)
    #expect(boundary.hasRequiredFields)
    #expect(boundary.summary == "growthPersistenceBoundary=swiftData:true,appGroup:true,dryRun:true,write:false,mutatesCreature:false,discovery:false,widget:false,safe:true")
    #expect(boundary.readinessSummary == "growthPersistenceBoundaryReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyPersistenceBoundaryContractRejectsWritesAndMissingTargets() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let intent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )
    let missingSwiftData = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent,
        targetsSwiftData: false
    )
    let writingBoundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent,
        performsPersistenceWrite: true,
        mutatesCreature: true,
        appendsDiscovery: true,
        publishesWidgetHandoff: true
    )
    let noDryRun = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent,
        dryRunOnly: false
    )

    #expect(!missingSwiftData.hasRequiredFields)
    #expect(!writingBoundary.isSafeDryRun)
    #expect(!writingBoundary.hasRequiredFields)
    #expect(writingBoundary.readinessSummary == "growthPersistenceBoundaryReady:false")
    #expect(!noDryRun.isSafeDryRun)
    #expect(!noDryRun.hasRequiredFields)
}

@Test func growthCeremonyWidgetHandoffPreflightNamesPreparedDryRunPayloadBoundary() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let intent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )
    let boundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent
    )
    let preflight = GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary
    )

    #expect(plan.requirements.contains(.widgetHandoff))
    #expect(preflight.payloadSchemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion)
    #expect(preflight.appGroupPayloadKey == WidgetSharedDataKeys.currentObservationJSON)
    #expect(preflight.widgetKind == WidgetSharedDataKeys.widgetKind)
    #expect(preflight.payloadPrepared)
    #expect(preflight.previewOnly)
    #expect(!preflight.performsAppGroupWrite)
    #expect(!preflight.reloadsWidgetTimeline)
    #expect(!preflight.publishesWidgetHandoff)
    #expect(preflight.hasRequiredFields)
    #expect(preflight.summary == "growthWidgetHandoffPreflight=schema:1,key:widget.currentObservation.json,widgetKind:WiPetWidget,payloadPrepared:true,previewOnly:true,write:false,reload:false,publish:false,persistenceBoundary:true,ready:true")
    #expect(preflight.readinessSummary == "growthWidgetHandoffPreflightReady:true")
    #expect(creature.growthStage == .juvenile)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func growthCeremonyWidgetHandoffPreflightRejectsMissingPreparationAndPublishSideEffects() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let acknowledgementSurface = GrowthCeremonyAcknowledgementSurfaceCopy(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview(
            discoveryHandoff: handoff,
            mutationProof: plan.mutationProof
        )
    )
    let confirmationSurface = GrowthCeremonyConfirmationSurfaceCopy(
        observation: plan.beforeAfterObservation,
        acknowledgementSurface: acknowledgementSurface,
        discoveryHandoff: handoff
    )
    let intent = GrowthCeremonyAcknowledgementIntentContract(
        confirmationSurface: confirmationSurface
    )
    let boundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent
    )
    let unsafeBoundary = GrowthCeremonyPersistenceBoundaryContract(
        acknowledgementIntent: intent,
        performsPersistenceWrite: true
    )
    let missingWidgetRequirementPlan = GrowthCeremonyPlan(
        preview: GrowthMomentPreview(
            creatureName: plan.creatureName,
            currentStage: plan.currentStage,
            nextStage: plan.nextStage
        ),
        requirements: [.playerAcknowledgement, .beforeAfterObservation, .discoveryLogHandoff, .persistenceBeforeMutation]
    )

    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: missingWidgetRequirementPlan,
        persistenceBoundary: boundary
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: unsafeBoundary
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        payloadSchemaVersion: 0
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        appGroupPayloadKey: "wrong.key"
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        widgetKind: "OtherWidget"
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        payloadPrepared: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        previewOnly: false
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        performsAppGroupWrite: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        reloadsWidgetTimeline: true
    ).hasRequiredFields)
    #expect(!GrowthCeremonyWidgetHandoffPreflightContract(
        plan: plan,
        persistenceBoundary: boundary,
        publishesWidgetHandoff: true
    ).hasRequiredFields)
}

@Test func genomeVisibleCueMemoryCreatesLineageMemoryFromInheritedDiscovery() throws {
    let ancestorID = UUID(uuidString: "00000000-0000-0000-0000-000000000301")!
    let discovery = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: ancestorID
    )
    let genomeCue = GenomeVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        genomeSummary: "genomeVariation=face:crystal,body:lunarian,wing:none,tail:floating,visibleTraitCount:3"
    )

    let lineageMemory = try #require(genomeCue.lineageMemory(
        discovery: discovery,
        ancestorLabel: "firstAncestor"
    ))

    #expect(genomeCue.source == "SpriteKit")
    #expect(!genomeCue.playerFacing)
    #expect(genomeCue.hasRequiredFields)
    #expect(genomeCue.summary == "genomeVisibleCueMemory=source:SpriteKit,trait:tail,cue:floatingRibbon,display:Floating tail,playerFacing:false")
    #expect(genomeCue.readinessSummary == "genomeVisibleCueMemoryReady:true")
    #expect(lineageMemory.summary == "lineageVisibleCue=trait:tail,cue:floatingRibbon,ancestor:firstAncestor")
    #expect(lineageMemory.memoryLine == "Floating tail echoes firstAncestor.")
}

@Test func genomeVisibleCueMemoryRequiresInheritedDiscoveryBeforeLineageMemory() {
    let growthDiscovery = DiscoveryEvent(
        title: "Luma grew into Juvenile.",
        kind: .growth,
        stage: .juvenile
    )
    let missingGenomeSummary = GenomeVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        genomeSummary: ""
    )
    let readyGenomeCue = GenomeVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        genomeSummary: "genomeVariation=face:crystal,body:lunarian,wing:none,tail:floating,visibleTraitCount:3"
    )

    #expect(!missingGenomeSummary.hasRequiredFields)
    #expect(missingGenomeSummary.readinessSummary == "genomeVisibleCueMemoryReady:false")
    #expect(missingGenomeSummary.lineageMemory(discovery: growthDiscovery) == nil)
    #expect(readyGenomeCue.lineageMemory(discovery: growthDiscovery) == nil)
    #expect(readyGenomeCue.lineageMemory(discovery: nil) == nil)
}

@Test func spriteKitRecognizabilityCueCandidateGateKeepsNextBodyTailCueProposalOnly() {
    let gate = SpriteKitRecognizabilityCueCandidateGate()

    #expect(gate.targetsRecognizableBodyWingOrTail)
    #expect(!gate.canImplementVisibleCue)
    #expect(gate.hasRequiredFields)
    #expect(gate.summary == "spriteKitRecognizabilityCueCandidate=source:genomeVariationQA,targets:body+tail,purpose:atAGlanceFamilyRecognition,vocabulary:existingHandmadeSpriteKitParts,manualArtReview:false,appHostVisualQA:false,visiblePixels:false,labelOnly:false,copyOnly:false,lineageMarkOnly:false,clutter:low,persistence:false,widget:false,generatedAssets:false,assetOutputs:none,playerFacing:false,implement:false")
    #expect(gate.readinessSummary == "spriteKitRecognizabilityCueCandidateReady:true")
}

@Test func spriteKitRecognizabilityCueCandidateGateRejectsLabelsMarksClutterAndSideEffects() {
    #expect(!SpriteKitRecognizabilityCueCandidateGate(targetTraitIDs: ["face"]).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(targetTraitIDs: ["lineage"]).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(targetTraitIDs: ["wing"]).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(cuePurpose: "extraDecoration").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(visualVocabulary: "generatedTexture").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(manualArtReviewReady: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(appHostVisualQAReady: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(usesExistingHandmadeVocabulary: false).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(changesVisiblePixels: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(labelOnlyChange: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(copyOnlyChange: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(lineageMarkOnlyChange: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(clutterRisk: "high").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueCandidateGate(playerFacing: true).hasRequiredFields)

    let acceptedFutureGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )

    #expect(acceptedFutureGate.canImplementVisibleCue)
    #expect(!acceptedFutureGate.hasRequiredFields)
    #expect(acceptedFutureGate.readinessSummary == "spriteKitRecognizabilityCueCandidateReady:false")
}

@Test func spriteKitRecognizabilityCueSelectionReviewChoosesFishTailAsProposalOnly() {
    let review = SpriteKitRecognizabilityCueSelectionReview()

    #expect(review.hasRequiredFields)
    #expect(!review.canProceedToVisibleImplementation)
    #expect(review.summary == "spriteKitRecognizabilityCueSelection=gateReady:true,trait:tail,cue:fishFin+softForkFin,family:Tail.fish,reason:softFishTailSilhouetteReadsAtAGlance,rejected:labelOnly+copyOnly+lineageMarkOnly,proposalOnly:true,visiblePixels:false,handmade:true,appHostVisualQA:false,manualArtReview:false,generatedAssets:false,assetOutputs:none,playerFacing:false,proceed:false")
    #expect(review.readinessSummary == "spriteKitRecognizabilityCueSelectionReady:true")
}

@Test func spriteKitRecognizabilityCueSelectionReviewRejectsUnsafeOrUnreviewedChoices() {
    #expect(!SpriteKitRecognizabilityCueSelectionReview(gate: SpriteKitRecognizabilityCueCandidateGate(targetTraitIDs: ["face"])).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(selectedTraitID: "body").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(selectedCueID: "labelOnlyCue").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(selectedPartFamily: "Tail.dragon").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(affectionReason: "extraDecoration").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(rejectedAlternatives: ["labelOnly", "copyOnly"]).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(proposalOnly: false).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(changesVisiblePixels: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(usesExistingHandmadeVocabulary: false).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(appHostVisualQAReady: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(manualArtReviewReady: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitRecognizabilityCueSelectionReview(playerFacing: true).hasRequiredFields)

    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )

    #expect(acceptedReview.canProceedToVisibleImplementation)
    #expect(!acceptedReview.hasRequiredFields)
    #expect(acceptedReview.readinessSummary == "spriteKitRecognizabilityCueSelectionReady:false")
}

@Test func spriteKitFishTailArtReviewChecklistKeepsSelectedCueOpenForReview() {
    let checklist = SpriteKitFishTailArtReviewChecklist()

    #expect(checklist.hasChecklistItems)
    #expect(checklist.hasRequiredFields)
    #expect(!checklist.canAuthorizeVisibleImplementation)
    #expect(checklist.summary == "spriteKitFishTailArtReview=selectionReady:true,items:softForkShape+secondarySilhouette+atAGlanceTailReadability+cuteMotionRoom+noSharpFin+noRarityStatFraming+noLineageMarkOnly,manualArtReview:false,appHostVisualQA:false,snapshotReview:false,visiblePixels:false,sharpFin:false,rarityStat:false,lineageMarkOnly:false,generatedAssets:false,assetOutputs:none,playerFacing:false,authorize:false")
    #expect(checklist.readinessSummary == "spriteKitFishTailArtReviewReady:true")
}

@Test func spriteKitFishTailArtReviewChecklistRejectsMissingCriteriaAndUnsafeAuthorization() {
    #expect(!SpriteKitFishTailArtReviewChecklist(selectionReview: SpriteKitRecognizabilityCueSelectionReview(selectedTraitID: "body")).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(checklistItems: ["softForkShape"]).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(manualArtReviewReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(appHostVisualQAReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(snapshotReviewReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(changesVisiblePixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(allowsSharpFin: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(allowsRarityOrStatFraming: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(allowsLineageMarkOnlyCue: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailArtReviewChecklist(playerFacing: true).hasRequiredFields)

    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )

    #expect(acceptedChecklist.canAuthorizeVisibleImplementation)
    #expect(!acceptedChecklist.hasRequiredFields)
    #expect(acceptedChecklist.readinessSummary == "spriteKitFishTailArtReviewReady:false")
}

@Test func spriteKitFishTailImplementationPreflightStaysClosedUntilQAAndReviewRecover() {
    let preflight = SpriteKitFishTailImplementationPreflight()

    #expect(preflight.hasRequiredFields)
    #expect(!preflight.canOpenImplementation)
    #expect(preflight.summary == "spriteKitFishTailImplementationPreflight=artReviewReady:true,dataReady:false,appHostVisualQA:false,manualArtReview:false,snapshotReview:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,open:false")
    #expect(preflight.readinessSummary == "spriteKitFishTailImplementationPreflightReady:true")
}

@Test func spriteKitFishTailImplementationPreflightRejectsPrematurePixelAndSideEffectChanges() {
    #expect(!SpriteKitFishTailImplementationPreflight(artReviewChecklist: SpriteKitFishTailArtReviewChecklist(checklistItems: ["softForkShape"])).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(dataVolumeReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(appHostVisualQAReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(manualArtReviewAccepted: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(snapshotReviewAccepted: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationPreflight(playerFacing: true).hasRequiredFields)

    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )

    #expect(openPreflight.canOpenImplementation)
    #expect(!openPreflight.hasRequiredFields)
    #expect(openPreflight.readinessSummary == "spriteKitFishTailImplementationPreflightReady:false")
}

@Test func spriteKitFishTailVisibleWorkResumeBridgeKeepsPartialStorageRecoveryBlocked() {
    let bridge = SpriteKitFishTailVisibleWorkResumeBridge()

    #expect(bridge.hasRequiredFields)
    #expect(!bridge.canResumeVisibleWork)
    #expect(bridge.summary == "spriteKitFishTailVisibleWorkResumeBridge=preflightReady:true,storageGateReady:true,storageCanResume:false,appHostResume:false,manualArtReview:false,snapshotReview:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,resume:false")
    #expect(bridge.readinessSummary == "spriteKitFishTailVisibleWorkResumeBridgeReady:true")
}

@Test func spriteKitFishTailVisibleWorkResumeBridgeRequiresStorageAppHostReviewAndNoSideEffects() {
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(implementationPreflight: SpriteKitFishTailImplementationPreflight(dataVolumeReady: true)).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(xctestDevicesStorageGateReady: false).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(xctestDevicesStorageCanResume: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(appHostVisualQAResumeReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(manualArtReviewAccepted: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(snapshotReviewAccepted: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailVisibleWorkResumeBridge(playerFacing: true).hasRequiredFields)

    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )

    #expect(openBridge.canResumeVisibleWork)
    #expect(!openBridge.hasRequiredFields)
    #expect(openBridge.readinessSummary == "spriteKitFishTailVisibleWorkResumeBridgeReady:false")
}

@Test func spriteKitFishTailPixelHandoffGateKeepsRecipeReadyButPixelsClosed() {
    let gate = SpriteKitFishTailPixelHandoffGate()

    #expect(gate.hasRequiredFields)
    #expect(!gate.canHandoffToPixels)
    #expect(gate.summary == "spriteKitFishTailPixelHandoffGate=bridgeReady:true,recipeIntent:true,partAssembler:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,handoff:false")
    #expect(gate.readinessSummary == "spriteKitFishTailPixelHandoffGateReady:true")
}

@Test func spriteKitFishTailPixelHandoffQALabelStaysHiddenWhilePixelsAreClosed() {
    let label = SpriteKitFishTailPixelHandoffQALabel()

    #expect(label.hasRequiredFields)
    #expect(!label.canConfirmPixelHandoff)
    #expect(label.summary == "spriteKitFishTailPixelHandoffQALabel=gateReady:true,label:spriteKitFishTailPixelHandoffGate,hiddenQA:true,playerLabel:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,confirm:false")
    #expect(label.readinessSummary == "spriteKitFishTailPixelHandoffQALabelReady:true")
}

@Test func spriteKitFishTailPixelHandoffQALabelRejectsPlayerFacingLabelsAndSideEffects() {
    #expect(!SpriteKitFishTailPixelHandoffQALabel(hiddenLabel: "").hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(hiddenQAMetadataReady: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(exposesPlayerFacingLabel: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffQALabel(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailPixelHandoffQALabelCanConfirmFutureOpenHiddenHandoff() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let label = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)

    #expect(label.canConfirmPixelHandoff)
    #expect(!label.hasRequiredFields)
    #expect(label.readinessSummary == "spriteKitFishTailPixelHandoffQALabelReady:false")
}

@Test func spriteKitFishTailPartAssemblerEditPlanNamesOnlyFutureTailEdit() {
    let plan = SpriteKitFishTailPartAssemblerEditPlan()

    #expect(plan.hasRequiredFields)
    #expect(!plan.canBeginPixelEdit)
    #expect(plan.summary == "spriteKitFishTailPartAssemblerEditPlan=qaReady:true,file:PartAssembler.swift,layer:tail,base:fishTaper,accessory:softForkFin,placement:tailTip,hiddenLabel:spriteKitFishTailPixelHandoffGate,motionRoom:true,partAssembler:false,renderProfile:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,begin:false")
    #expect(plan.readinessSummary == "spriteKitFishTailPartAssemblerEditPlanReady:true")
}

@Test func spriteKitFishTailPartAssemblerEditPlanRejectsBroadOrSideEffectEdits() {
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(targetFile: "CreatureNode.swift").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(targetLayer: "body").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(baseRecipe: "ribbon").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(accessoryRecipe: "sharpForkFin").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(placement: "tailRoot").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(hiddenQALabel: "visibleFishTailLabel").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(keepsMotionRoom: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(touchesPartAssembler: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(touchesRenderProfile: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailPartAssemblerEditPlan(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailPartAssemblerEditPlanCanBeginFutureOpenPixelEditOnly() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let plan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )

    #expect(plan.canBeginPixelEdit)
    #expect(!plan.hasRequiredFields)
    #expect(plan.readinessSummary == "spriteKitFishTailPartAssemblerEditPlanReady:false")
}

@Test func spriteKitFishTailGeometryRecipeKeepsSoftPixelRecipeClosed() {
    let recipe = SpriteKitFishTailGeometryRecipe()

    #expect(recipe.hasRequiredFields)
    #expect(recipe.hasSoftProportions)
    #expect(!recipe.canApplyToPartAssembler)
    #expect(recipe.summary == "spriteKitFishTailGeometryRecipe=planReady:true,length:28.0,rootWidth:16.0,tipWidth:9.0,forkSpread:12.0,forkDepth:6.0,cornerRadius:5.0,softProportions:true,roundedTip:true,shallowFork:true,motionRoom:true,generatedPath:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,apply:false")
    #expect(recipe.readinessSummary == "spriteKitFishTailGeometryRecipeReady:true")
}

@Test func spriteKitFishTailGeometryRecipeRejectsSharpGeneratedOrSideEffectGeometry() {
    #expect(!SpriteKitFishTailGeometryRecipe(tailLength: 40).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(rootWidth: 10).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(tipWidth: 14).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(forkSpread: 20).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(forkDepth: 12).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(cornerRadius: 1).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(keepsRoundedTip: false).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(keepsShallowFork: false).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(keepsMotionRoom: false).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(generatedPath: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailGeometryRecipe(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailGeometryRecipeCanApplyOnlyWithFutureOpenEditPlan() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let recipe = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )

    #expect(recipe.canApplyToPartAssembler)
    #expect(!recipe.hasRequiredFields)
    #expect(recipe.readinessSummary == "spriteKitFishTailGeometryRecipeReady:false")
}

@Test func spriteKitFishTailMotionRoomRecipeKeepsExistingTailSwayReadyButClosed() {
    let recipe = SpriteKitFishTailMotionRoomRecipe()

    #expect(recipe.hasRequiredFields)
    #expect(recipe.hasGentleMotionRange)
    #expect(!recipe.canApplyWithVisibleFishTail)
    #expect(recipe.summary == "spriteKitFishTailMotionRoomRecipe=geometryReady:true,tailMotionRange:0.35-0.75,swayDegrees:8.0,swayDuration:1.6,anchor:tailRoot,gentleRange:true,existingTiming:true,tailRootStable:true,physics:false,animationTiming:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,apply:false")
    #expect(recipe.readinessSummary == "spriteKitFishTailMotionRoomRecipeReady:true")
}

@Test func spriteKitFishTailMotionRoomRecipeRejectsCrampedOrBroadMotionChanges() {
    #expect(!SpriteKitFishTailMotionRoomRecipe(tailMotionGeneMinimum: 0.1).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(tailMotionGeneMaximum: 0.95).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(tailMotionGeneMinimum: 0.8, tailMotionGeneMaximum: 0.7).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(swayDegrees: 14).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(swayDuration: 0.8).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(anchor: "tailTip").hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(keepsExistingSKActionTiming: false).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(keepsTailRootStable: false).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(allowsPhysicsSimulation: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(changesAnimationTiming: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailMotionRoomRecipe(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailMotionRoomRecipeCanApplyOnlyWithFutureVisibleFishTail() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openGeometry = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )
    let recipe = SpriteKitFishTailMotionRoomRecipe(
        geometryRecipe: openGeometry,
        updatesSpriteKitPixels: true
    )

    #expect(recipe.canApplyWithVisibleFishTail)
    #expect(!recipe.hasRequiredFields)
    #expect(recipe.readinessSummary == "spriteKitFishTailMotionRoomRecipeReady:false")
}

@Test func spriteKitFishTailPathPointRecipeNamesSoftClosedPointOrder() {
    let recipe = SpriteKitFishTailPathPointRecipe()

    #expect(recipe.hasRequiredFields)
    #expect(recipe.hasSoftPointOrder)
    #expect(!recipe.canDrawVisiblePath)
    #expect(recipe.pointsSummary == "0,0>0,8>28,6>22,0>28,-6>0,-8")
    #expect(recipe.summary == "spriteKitFishTailPathPointRecipe=motionReady:true,order:tailRoot>rootUpper>forkUpper>forkNotch>forkLower>rootLower,points:0,0>0,8>28,6>22,0>28,-6>0,-8,roundedCurves:true,closed:true,shallowFork:true,softOrder:true,generatedPath:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,draw:false")
    #expect(recipe.readinessSummary == "spriteKitFishTailPathPointRecipeReady:true")
}

@Test func spriteKitFishTailPathPointRecipeRejectsSharpGeneratedOrSideEffectPaths() {
    #expect(!SpriteKitFishTailPathPointRecipe(pointOrder: ["tailRoot", "forkUpper", "forkLower"]).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(tailRoot: "1,0").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(rootUpper: "0,12").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(forkUpper: "34,10").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(forkNotch: "28,0").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(forkLower: "34,-10").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(rootLower: "0,-12").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(usesRoundedQuadraticCurves: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(closesPath: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(keepsShallowForkNotch: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(generatedPath: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailPathPointRecipe(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailPathPointRecipeCanDrawOnlyWithFutureVisibleMotion() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openGeometry = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )
    let openMotion = SpriteKitFishTailMotionRoomRecipe(
        geometryRecipe: openGeometry,
        updatesSpriteKitPixels: true
    )
    let recipe = SpriteKitFishTailPathPointRecipe(
        motionRoomRecipe: openMotion,
        updatesSpriteKitPixels: true
    )

    #expect(recipe.canDrawVisiblePath)
    #expect(!recipe.hasRequiredFields)
    #expect(recipe.readinessSummary == "spriteKitFishTailPathPointRecipeReady:false")
}

@Test func spriteKitFishTailStyleRecipeKeepsSoftExistingTailPaletteClosed() {
    let recipe = SpriteKitFishTailStyleRecipe()

    #expect(recipe.hasRequiredFields)
    #expect(recipe.hasSoftStyle)
    #expect(!recipe.canStyleVisiblePath)
    #expect(recipe.styleSummary == "tailFill@0.78|tailSoftRim@0.42|line:1.2|layer:tail")
    #expect(recipe.summary == "spriteKitFishTailStyleRecipe=pathReady:true,style:tailFill@0.78|tailSoftRim@0.42|line:1.2|layer:tail,existingPalette:true,secondarySilhouette:true,softStyle:true,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,styleVisible:false")
    #expect(recipe.readinessSummary == "spriteKitFishTailStyleRecipeReady:true")
}

@Test func spriteKitFishTailStyleRecipeRejectsLoudOrSideEffectStyles() {
    #expect(!SpriteKitFishTailStyleRecipe(fillStyle: "newFishTailFill").hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(strokeStyle: "hardRim").hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(fillAlpha: 0.5).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(fillAlpha: 0.95).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(strokeAlpha: 0.1).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(strokeAlpha: 0.7).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(lineWidth: 0.4).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(lineWidth: 2.2).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(zLayer: "accessory").hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(usesExistingTailPalette: false).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(keepsSecondarySilhouette: false).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailStyleRecipe(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailStyleRecipeCanStyleOnlyWithFutureVisiblePath() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openGeometry = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )
    let openMotion = SpriteKitFishTailMotionRoomRecipe(
        geometryRecipe: openGeometry,
        updatesSpriteKitPixels: true
    )
    let openPath = SpriteKitFishTailPathPointRecipe(
        motionRoomRecipe: openMotion,
        updatesSpriteKitPixels: true
    )
    let recipe = SpriteKitFishTailStyleRecipe(
        pathPointRecipe: openPath,
        updatesSpriteKitPixels: true
    )

    #expect(recipe.canStyleVisiblePath)
    #expect(!recipe.hasRequiredFields)
    #expect(recipe.readinessSummary == "spriteKitFishTailStyleRecipeReady:false")
}

@Test func spriteKitFishTailImplementationBundleComposesClosedHandoff() {
    let bundle = SpriteKitFishTailImplementationBundle()

    #expect(bundle.hasRequiredFields)
    #expect(bundle.hasNarrowTarget)
    #expect(!bundle.canOpenVisibleImplementation)
    #expect(bundle.handoffSummary == "PartAssembler.swift|SpriteKit|fishTailOnly")
    #expect(bundle.summary == "spriteKitFishTailImplementationBundle=styleReady:true,handoff:PartAssembler.swift|SpriteKit|fishTailOnly,manualArtReview:true,appHostVisualQA:true,singlePartAssemblerEdit:true,narrowTarget:true,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,openVisibleImplementation:false")
    #expect(bundle.readinessSummary == "spriteKitFishTailImplementationBundleReady:true")
}

@Test func spriteKitFishTailImplementationBundleRejectsBroadOrSideEffectHandoffs() {
    #expect(!SpriteKitFishTailImplementationBundle(targetFile: "CreatureNode.swift").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(renderer: "SceneKit").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(changeScope: "allTails").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(requiresManualArtReview: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(requiresAppHostVisualQA: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(keepsSinglePartAssemblerEdit: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundle(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailImplementationBundleOpensOnlyWithFutureVisibleStyle() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openGeometry = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )
    let openMotion = SpriteKitFishTailMotionRoomRecipe(
        geometryRecipe: openGeometry,
        updatesSpriteKitPixels: true
    )
    let openPath = SpriteKitFishTailPathPointRecipe(
        motionRoomRecipe: openMotion,
        updatesSpriteKitPixels: true
    )
    let openStyle = SpriteKitFishTailStyleRecipe(
        pathPointRecipe: openPath,
        updatesSpriteKitPixels: true
    )
    let bundle = SpriteKitFishTailImplementationBundle(
        styleRecipe: openStyle,
        updatesSpriteKitPixels: true
    )

    #expect(bundle.canOpenVisibleImplementation)
    #expect(!bundle.hasRequiredFields)
    #expect(bundle.readinessSummary == "spriteKitFishTailImplementationBundleReady:false")
}

@Test func spriteKitFishTailImplementationBundleQALabelStaysHiddenAndClosed() {
    let label = SpriteKitFishTailImplementationBundleQALabel()

    #expect(label.hasRequiredFields)
    #expect(label.hasHiddenQAContract)
    #expect(!label.canConfirmVisibleImplementation)
    #expect(label.summary == "spriteKitFishTailImplementationBundleQALabel=label:spriteKitFishTailImplementationBundle,bundleReady:true,hiddenMetadata:true,playerLabel:false,hiddenContract:true,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,confirmVisible:false")
    #expect(label.readinessSummary == "spriteKitFishTailImplementationBundleQALabelReady:true")
}

@Test func spriteKitFishTailImplementationBundleQALabelRejectsPlayerFacingOrSideEffects() {
    #expect(!SpriteKitFishTailImplementationBundleQALabel(hiddenLabel: "").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(hiddenLabel: "fishTailReady").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(hiddenQAMetadataReady: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(exposesPlayerFacingLabel: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQALabel(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailImplementationBundleQALabelConfirmsOnlyFutureVisibleBundle() {
    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openLabel = SpriteKitFishTailPixelHandoffQALabel(handoffGate: openGate)
    let openPlan = SpriteKitFishTailPartAssemblerEditPlan(
        qaLabel: openLabel,
        touchesPartAssembler: true,
        updatesSpriteKitPixels: true
    )
    let openGeometry = SpriteKitFishTailGeometryRecipe(
        editPlan: openPlan,
        updatesSpriteKitPixels: true
    )
    let openMotion = SpriteKitFishTailMotionRoomRecipe(
        geometryRecipe: openGeometry,
        updatesSpriteKitPixels: true
    )
    let openPath = SpriteKitFishTailPathPointRecipe(
        motionRoomRecipe: openMotion,
        updatesSpriteKitPixels: true
    )
    let openStyle = SpriteKitFishTailStyleRecipe(
        pathPointRecipe: openPath,
        updatesSpriteKitPixels: true
    )
    let openBundle = SpriteKitFishTailImplementationBundle(
        styleRecipe: openStyle,
        updatesSpriteKitPixels: true
    )
    let label = SpriteKitFishTailImplementationBundleQALabel(
        bundle: openBundle,
        updatesSpriteKitPixels: true
    )

    #expect(label.canConfirmVisibleImplementation)
    #expect(!label.hasRequiredFields)
    #expect(label.readinessSummary == "spriteKitFishTailImplementationBundleQALabelReady:false")
}

@Test func spriteKitFishTailImplementationBundleQASurfaceGateStaysClosedUntilAppHostResumes() {
    let gate = SpriteKitFishTailImplementationBundleQASurfaceGate()

    #expect(gate.hasRequiredFields)
    #expect(gate.hasQASurfaceTarget)
    #expect(!gate.canExposeHiddenLabelInQAHost)
    #expect(gate.summary == "spriteKitFishTailImplementationBundleQASurfaceGate=labelReady:true,host:GenomeVariationQAView,identifier:spriteKitFishTailImplementationBundle,requiresAppHostResume:true,appHostResume:false,qaHiddenLabels:false,snapshotReference:false,surfaceTarget:true,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,expose:false")
    #expect(gate.readinessSummary == "spriteKitFishTailImplementationBundleQASurfaceGateReady:true")
}

@Test func spriteKitFishTailImplementationBundleQASurfaceGateRejectsWrongSurfaceOrSideEffects() {
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(qaHostName: "ObservationHomeView").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(hiddenAccessibilityIdentifier: "fishTailReady").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(requiresAppHostVisualQAResume: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(appHostVisualQAResumeReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(updatesQAHostHiddenLabels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(updatesSnapshotReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfaceGate(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailImplementationBundleQASurfaceGateOpensOnlyForFutureHiddenQASurface() {
    let gate = SpriteKitFishTailImplementationBundleQASurfaceGate(
        appHostVisualQAResumeReady: true,
        updatesQAHostHiddenLabels: true,
        updatesSnapshotReference: true
    )

    #expect(gate.canExposeHiddenLabelInQAHost)
    #expect(!gate.hasRequiredFields)
    #expect(gate.readinessSummary == "spriteKitFishTailImplementationBundleQASurfaceGateReady:false")
}

@Test func spriteKitFishTailImplementationBundleQASurfacePatchPlanStaysUnapplied() {
    let plan = SpriteKitFishTailImplementationBundleQASurfacePatchPlan()

    #expect(plan.hasRequiredFields)
    #expect(plan.hasPatchTarget)
    #expect(!plan.canApplyHiddenQASurfacePatch)
    #expect(plan.summary == "spriteKitFishTailImplementationBundleQASurfacePatchPlan=gateReady:true,target:GenomeVariationQAView.swift,identifier:spriteKitFishTailImplementationBundle,snapshot:SnapshotHostGenomeVariationTests.lines,hiddenOnly:true,patchTarget:true,qaHostFile:false,snapshotReference:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,apply:false")
    #expect(plan.readinessSummary == "spriteKitFishTailImplementationBundleQASurfacePatchPlanReady:true")
}

@Test func spriteKitFishTailImplementationBundleQASurfacePatchPlanRejectsBroadOrSideEffectPatch() {
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(targetFile: "ObservationHomeView.swift").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(hiddenLabelIdentifier: "fishTailReady").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(semanticSnapshotReference: "ObservationHome.lines").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(keepsHiddenOnly: false).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(updatesQAHostFile: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(updatesSnapshotReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationBundleQASurfacePatchPlan(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailImplementationBundleQASurfacePatchPlanAppliesOnlyWithFutureOpenGate() {
    let openGate = SpriteKitFishTailImplementationBundleQASurfaceGate(
        appHostVisualQAResumeReady: true,
        updatesQAHostHiddenLabels: true,
        updatesSnapshotReference: true
    )
    let plan = SpriteKitFishTailImplementationBundleQASurfacePatchPlan(
        surfaceGate: openGate,
        updatesQAHostFile: true,
        updatesSnapshotReference: true
    )

    #expect(plan.canApplyHiddenQASurfacePatch)
    #expect(!plan.hasRequiredFields)
    #expect(plan.readinessSummary == "spriteKitFishTailImplementationBundleQASurfacePatchPlanReady:false")
}

@Test func spriteKitFishTailImplementationReadinessLedgerSummarizesCurrentBlockedState() {
    let ledger = SpriteKitFishTailImplementationReadinessLedger()

    #expect(ledger.hasRequiredFields)
    #expect(ledger.readyMilestones == ["bundle", "hiddenLabel", "qaSurfaceGate", "qaSurfacePatchPlan"])
    #expect(ledger.blockedMilestones == ["appHostVisualQA", "hiddenQASurfaceExposure", "qaSurfacePatch", "visibleFishTailPixels"])
    #expect(ledger.nextSafeAction == "waitForAppHostVisualQAResume")
    #expect(ledger.summary == "spriteKitFishTailImplementationReadinessLedger=ready:bundle+hiddenLabel+qaSurfaceGate+qaSurfacePatchPlan,blocked:appHostVisualQA+hiddenQASurfaceExposure+qaSurfacePatch+visibleFishTailPixels,next:waitForAppHostVisualQAResume,appHostResume:false,visiblePixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false")
    #expect(ledger.readinessSummary == "spriteKitFishTailImplementationReadinessLedgerReady:true")
}

@Test func spriteKitFishTailImplementationReadinessLedgerRejectsSideEffectsAndVisiblePixels() {
    #expect(!SpriteKitFishTailImplementationReadinessLedger(appHostVisualQAResumeReady: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(visiblePixelsApplied: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailImplementationReadinessLedger(playerFacing: true).hasRequiredFields)
}

@Test func spriteKitFishTailImplementationReadinessLedgerNamesFutureHiddenQASurfaceAction() {
    let ledger = SpriteKitFishTailImplementationReadinessLedger(appHostVisualQAResumeReady: true)

    #expect(ledger.nextSafeAction == "exposeHiddenQASurface")
    #expect(!ledger.hasRequiredFields)
    #expect(ledger.readinessSummary == "spriteKitFishTailImplementationReadinessLedgerReady:false")
}

@Test func spriteKitVisibleQAEnvironmentLedgerBlocksVisiblePixelsUntilXcodebuildQuiet() {
    let ledger = SpriteKitVisibleQAEnvironmentLedger()

    #expect(ledger.hasRequiredFields)
    #expect(!ledger.canRunVisualQA)
    #expect(ledger.nextSafeAction == "waitForXcodebuildQuiet")
    #expect(ledger.summary == "spriteKitVisibleQAEnvironmentLedger=fishTailNext:waitForAppHostVisualQAResume,storage:true,sourceControlQuiet:true,xcodebuildQuiet:false,appHostResume:false,developerPath:true,xcodebuild:true,simctl:true,simulatorLaunch:false,hiddenQASurface:false,spriteKitPixels:false,imageReference:false,persistence:false,widget:false,packageProject:false,generatedAssets:false,assetOutputs:none,playerFacing:false,next:waitForXcodebuildQuiet,runVisualQA:false")
    #expect(ledger.readinessSummary == "spriteKitVisibleQAEnvironmentLedgerReady:true")
}

@Test func spriteKitVisibleQAEnvironmentLedgerRejectsPrematureSurfacePixelsAndSideEffects() {
    #expect(!SpriteKitVisibleQAEnvironmentLedger(storageResumeReady: false).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(sourceControlProcessesQuiet: false).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(xcodebuildProcessesQuiet: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(appHostVisualQAResumeReady: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(xcodeDeveloperPathResolved: false).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(xcodebuildAvailable: false).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(simctlAvailable: false).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(simulatorLaunchAvailable: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(updatesHiddenQASurface: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(playerFacing: true).hasRequiredFields)
    #expect(!SpriteKitVisibleQAEnvironmentLedger(
        implementationReadinessLedger: SpriteKitFishTailImplementationReadinessLedger(appHostVisualQAResumeReady: true)
    ).hasRequiredFields)
}

@Test func spriteKitVisibleQAEnvironmentLedgerNamesFutureHiddenQASurfaceVisualQA() {
    let ledger = SpriteKitVisibleQAEnvironmentLedger(
        implementationReadinessLedger: SpriteKitFishTailImplementationReadinessLedger(appHostVisualQAResumeReady: true),
        xcodebuildProcessesQuiet: true,
        appHostVisualQAResumeReady: true,
        simulatorLaunchAvailable: true
    )

    #expect(ledger.canRunVisualQA)
    #expect(ledger.nextSafeAction == "runHiddenQASurfaceVisualQA")
    #expect(!ledger.hasRequiredFields)
    #expect(ledger.readinessSummary == "spriteKitVisibleQAEnvironmentLedgerReady:false")
}

@Test func spriteKitFishTailPixelHandoffGateRequiresOpenBridgeRecipeAndNoSideEffects() {
    #expect(!SpriteKitFishTailPixelHandoffGate(visibleWorkBridge: SpriteKitFishTailVisibleWorkResumeBridge(xctestDevicesStorageCanResume: true)).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(recipeIntentReady: false).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(usesPartAssembler: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(updatesSpriteKitPixels: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(updatesImageReference: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(allowsPersistenceWrite: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(publishesWidgetHandoff: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(changesPackageOrProject: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(generatedAssets: true).hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(assetOutputs: "png").hasRequiredFields)
    #expect(!SpriteKitFishTailPixelHandoffGate(playerFacing: true).hasRequiredFields)

    let acceptedGate = SpriteKitRecognizabilityCueCandidateGate(
        targetTraitIDs: ["body", "tail"],
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        changesVisiblePixels: true
    )
    let acceptedReview = SpriteKitRecognizabilityCueSelectionReview(
        gate: acceptedGate,
        proposalOnly: false,
        changesVisiblePixels: true,
        appHostVisualQAReady: true,
        manualArtReviewReady: true
    )
    let acceptedChecklist = SpriteKitFishTailArtReviewChecklist(
        selectionReview: acceptedReview,
        manualArtReviewReady: true,
        appHostVisualQAReady: true,
        snapshotReviewReady: true,
        changesVisiblePixels: true
    )
    let openPreflight = SpriteKitFishTailImplementationPreflight(
        artReviewChecklist: acceptedChecklist,
        dataVolumeReady: true,
        appHostVisualQAReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openBridge = SpriteKitFishTailVisibleWorkResumeBridge(
        implementationPreflight: openPreflight,
        xctestDevicesStorageCanResume: true,
        appHostVisualQAResumeReady: true,
        manualArtReviewAccepted: true,
        snapshotReviewAccepted: true,
        updatesSpriteKitPixels: true
    )
    let openGate = SpriteKitFishTailPixelHandoffGate(
        visibleWorkBridge: openBridge,
        usesPartAssembler: true,
        updatesSpriteKitPixels: true
    )

    #expect(openGate.canHandoffToPixels)
    #expect(!openGate.hasRequiredFields)
    #expect(openGate.readinessSummary == "spriteKitFishTailPixelHandoffGateReady:false")
}

@Test func creatureGrowthCeremonyPlanIsNilForElder() {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .elder
    )

    #expect(creature.growthCeremonyPlan == nil)
}

@Test func creatureAdvanceGrowthStageRecordsGrowthDiscovery() throws {
    var creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )

    let advancedPreview = creature.advanceGrowthStage()
    let preview = try #require(advancedPreview)
    let discovery = try #require(creature.discoveredTraits.last)

    #expect(preview.currentStage == .juvenile)
    #expect(preview.nextStage == .adult)
    #expect(preview.discoveryTitle == "Luma grew into Adult.")
    #expect(creature.growthStage == .adult)
    #expect(discovery.title == "Luma grew into Adult.")
    #expect(discovery.kind == .growth)
    #expect(discovery.stage == .adult)
    #expect(discovery.relatedAncestorID == nil)
    #expect(creature.latestGrowthChangeDiscovery == discovery)
}

@Test func creatureAdvanceGrowthStageDoesNothingForElder() {
    var creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .elder
    )

    let preview = creature.advanceGrowthStage()

    #expect(preview == nil)
    #expect(creature.growthStage == .elder)
    #expect(creature.discoveredTraits.isEmpty)
}

@Test func scalarGenesClampToExpressiveRange() {
    #expect(ScalarGene(-0.4).value == 0)
    #expect(ScalarGene(0.7).value == 0.7)
    #expect(ScalarGene(1.6).value == 1)
}

@Test func discoveryCanRememberAncestorResemblance() {
    let ancestorID = UUID()
    let event = DiscoveryEvent(
        title: "Grandparent's floating tail shimmer appeared",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: ancestorID
    )

    #expect(event.kind == .inheritedResemblance)
    #expect(event.stage == .juvenile)
    #expect(event.relatedAncestorID == ancestorID)
}

@Test func discoveryMemoryCueLabelCombinesGrowthStageAndKind() {
    let inheritedMemory = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile
    )
    let glowMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .adult
    )

    #expect(inheritedMemory.memoryCueLabel == "Juvenile inherited memory")
    #expect(glowMemory.memoryCueLabel == "Adult glow memory")
}

@Test func discoveryDailyChangeCueLabelKeepsObservationFocusedOnChange() {
    let growthMemory = DiscoveryEvent(
        title: "Miri learned a soft hover.",
        kind: .growth,
        stage: .baby
    )
    let partMemory = DiscoveryEvent(
        title: "A tiny horn bud appeared.",
        kind: .newPart,
        stage: .juvenile
    )
    let glowMemory = DiscoveryEvent(
        title: "The tail glow deepened.",
        kind: .glow,
        stage: .adult
    )
    let patternMemory = DiscoveryEvent(
        title: "Moon flecks shifted along the back.",
        kind: .pattern,
        stage: .elder
    )
    let inheritedMemory = DiscoveryEvent(
        title: "Tail movement resembles first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile
    )

    #expect(growthMemory.dailyChangeCueLabel == "Baby change noticed")
    #expect(partMemory.dailyChangeCueLabel == "Juvenile new shape noticed")
    #expect(glowMemory.dailyChangeCueLabel == "Adult glow deepened")
    #expect(patternMemory.dailyChangeCueLabel == "Elder pattern shifted")
    #expect(inheritedMemory.dailyChangeCueLabel == "Juvenile family resemblance")
}

@Test func discoveryGrowthChangeMomentExcludesLineageMemory() {
    let growthMemory = DiscoveryEvent(
        title: "Miri learned a soft hover.",
        kind: .growth,
        stage: .baby
    )
    let partMemory = DiscoveryEvent(
        title: "A tiny horn bud appeared.",
        kind: .newPart,
        stage: .juvenile
    )
    let glowMemory = DiscoveryEvent(
        title: "The tail glow deepened.",
        kind: .glow,
        stage: .adult
    )
    let patternMemory = DiscoveryEvent(
        title: "Moon flecks shifted along the back.",
        kind: .pattern,
        stage: .elder
    )
    let lineageMemory = DiscoveryEvent(
        title: "Tail movement resembles first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )

    #expect(growthMemory.isGrowthChangeMoment)
    #expect(partMemory.isGrowthChangeMoment)
    #expect(glowMemory.isGrowthChangeMoment)
    #expect(patternMemory.isGrowthChangeMoment)
    #expect(!lineageMemory.isGrowthChangeMoment)
}

@Test func creatureLatestGrowthChangeDiscoverySkipsNewerLineageMemory() {
    let growthMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .juvenile
    )
    let lineageMemory = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        discoveredTraits: [
            growthMemory,
            lineageMemory
        ]
    )

    #expect(creature.latestGrowthChangeDiscovery == growthMemory)
}

@Test func creatureLatestGrowthChangeDiscoveryReturnsNewestGrowthMoment() {
    let earlyGrowthMemory = DiscoveryEvent(
        title: "Miri learned a soft hover.",
        kind: .growth,
        stage: .baby
    )
    let lineageMemory = DiscoveryEvent(
        title: "Tail movement resembles first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let laterPatternMemory = DiscoveryEvent(
        title: "Moon flecks shifted along the back.",
        kind: .pattern,
        stage: .juvenile
    )
    let creature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .juvenile,
        discoveredTraits: [
            earlyGrowthMemory,
            lineageMemory,
            laterPatternMemory
        ]
    )

    #expect(creature.latestGrowthChangeDiscovery == laterPatternMemory)
}

@Test func creatureLatestGrowthChangeDiscoveryIsNilWithoutGrowthMoments() {
    let lineageMemory = DiscoveryEvent(
        title: "Tail movement resembles first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let lineageOnlyCreature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        discoveredTraits: [lineageMemory]
    )
    let quietCreature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .baby
    )

    #expect(lineageOnlyCreature.latestGrowthChangeDiscovery == nil)
    #expect(quietCreature.latestGrowthChangeDiscovery == nil)
}

@Test func creaturePreferredDailyObservationDiscoveryPrefersGrowthOverNewerLineage() {
    let growthMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .juvenile
    )
    let lineageMemory = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        discoveredTraits: [
            growthMemory,
            lineageMemory
        ]
    )

    #expect(creature.preferredDailyObservationDiscovery == growthMemory)
    #expect(creature.discoveredTraits.last == lineageMemory)
}

@Test func creaturePreferredDailyObservationDiscoveryFallsBackToLineageOnlyMemory() {
    let lineageMemory = DiscoveryEvent(
        title: "Tail movement resembles first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        discoveredTraits: [lineageMemory]
    )

    #expect(creature.preferredDailyObservationDiscovery == lineageMemory)
}

@Test func creaturePreferredDailyObservationDiscoveryIsNilWithoutDiscoveries() {
    let creature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .baby
    )

    #expect(creature.preferredDailyObservationDiscovery == nil)
}

@Test func discoveryLineageCueOnlyAppearsForAncestorLinkedInheritance() {
    let inheritedWithAncestor = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let inheritedWithoutAncestor = DiscoveryEvent(
        title: "A familiar tail shimmer appeared.",
        kind: .inheritedResemblance,
        stage: .juvenile
    )
    let glowMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )

    #expect(inheritedWithAncestor.lineageCueLabel == "Echoes an ancestor")
    #expect(inheritedWithoutAncestor.lineageCueLabel == nil)
    #expect(glowMemory.lineageCueLabel == nil)
}

@Test func lineageVisibleCueMemoryNamesAncestorLinkedVisibleCue() {
    let memory = LineageVisibleCueMemory(
        discovery: DiscoveryEvent(
            title: "The floating tail shimmer resembles the first ancestor.",
            kind: .inheritedResemblance,
            stage: .juvenile,
            relatedAncestorID: UUID()
        ),
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor"
    )

    #expect(memory?.traitID == "tail")
    #expect(memory?.displayName == "Floating tail")
    #expect(memory?.visibleCue == "floatingRibbon")
    #expect(memory?.ancestorLabel == "firstAncestor")
    #expect(memory?.memoryLine == "Floating tail echoes firstAncestor.")
    #expect(memory?.summary == "lineageVisibleCue=trait:tail,cue:floatingRibbon,ancestor:firstAncestor")
    #expect(memory?.readinessSummary == "lineageVisibleCueReady:true")
}

@Test func lineageVisibleCueMemoryRequiresAncestorLinkedInheritance() {
    let unlinkedInheritance = LineageVisibleCueMemory(
        discovery: DiscoveryEvent(
            title: "A familiar shimmer appeared.",
            kind: .inheritedResemblance,
            stage: .juvenile
        ),
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon"
    )
    let ordinaryGlow = LineageVisibleCueMemory(
        discovery: DiscoveryEvent(
            title: "A quiet lunar glow deepened around the tail.",
            kind: .glow,
            stage: .juvenile,
            relatedAncestorID: UUID()
        ),
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon"
    )

    #expect(unlinkedInheritance == nil)
    #expect(ordinaryGlow == nil)
}

@Test func lineageVisibleCueMemoryReadinessRequiresAllFields() {
    let ready = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let missingCue = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )

    #expect(ready.hasRequiredFields)
    #expect(!missingCue.hasRequiredFields)
    #expect(ready.readinessSummary == "lineageVisibleCueReady:true")
    #expect(missingCue.readinessSummary == "lineageVisibleCueReady:false")
}

@Test func lineageVisibleCueObservationCopyBuildsQuietAncestorPhrase() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let copy = LineageVisibleCueObservationCopy(memory: memory)

    #expect(copy.memory == memory)
    #expect(copy.ancestorContext == "ancestorEcho")
    #expect(copy.observationLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(!copy.playerFacing)
    #expect(copy.summary == "lineageVisibleCueObservation=trait:tail,cue:floatingRibbon,ancestor:firstAncestor,context:ancestorEcho,playerFacing:false")
    #expect(copy.readinessSummary == "lineageVisibleCueObservationReady:true")
}

@Test func lineageVisibleCueObservationCopyReadinessRequiresMemoryAndContext() {
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let missingCueMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let ready = LineageVisibleCueObservationCopy(memory: readyMemory)
    let missingContext = LineageVisibleCueObservationCopy(
        memory: readyMemory,
        ancestorContext: ""
    )
    let missingMemoryCue = LineageVisibleCueObservationCopy(memory: missingCueMemory)

    #expect(ready.hasRequiredFields)
    #expect(!missingContext.hasRequiredFields)
    #expect(!missingMemoryCue.hasRequiredFields)
    #expect(ready.readinessSummary == "lineageVisibleCueObservationReady:true")
    #expect(missingContext.readinessSummary == "lineageVisibleCueObservationReady:false")
    #expect(missingMemoryCue.readinessSummary == "lineageVisibleCueObservationReady:false")
}

@Test func lineageFamilyPreviewNamesSharedAncestorWithoutPlayerFacingCommitment() {
    let lumaMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let miraMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Fish tail",
        visibleCue: "fishFin",
        ancestorLabel: "firstAncestor",
        memoryLine: "Fish tail echoes firstAncestor."
    )

    let preview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        memberNames: ["Luma", "Mira"],
        memories: [lumaMemory, miraMemory]
    )

    #expect(preview.hasRequiredFields)
    #expect(!preview.playerFacing)
    #expect(preview.ancestorDisplayName == "First ancestor")
    #expect(preview.familyLine == "Luma and Mira carry a quiet echo of first ancestor.")
    #expect(preview.summary == "lineageFamilyPreview=ancestor:firstAncestor,ancestorDisplay:First ancestor,members:Luma+Mira,memories:2,playerFacing:false")
    #expect(preview.readinessSummary == "lineageFamilyPreviewReady:true")
}

@Test func lineageFamilyNodeCopySeparatesInternalLabelFromDisplayCopy() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let copy = LineageFamilyNodeCopy(internalLabel: "firstAncestor")
    let uuidDisplay = LineageFamilyNodeCopy(
        internalLabel: "ancestor",
        displayName: "00000000-0000-0000-0000-000000000301"
    )
    let playerFacingCopy = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        playerFacing: true
    )

    #expect(copy.hasRequiredFields)
    #expect(copy.displayName == "First ancestor")
    #expect(copy.roleLine == "First ancestor is remembered through a soft family echo.")
    #expect(copy.memoryLine(for: memory) == "Floating tail echoes first ancestor.")
    #expect(copy.summary == "lineageFamilyNodeCopy=internal:firstAncestor,display:First ancestor,playerFacing:false")
    #expect(copy.readinessSummary == "lineageFamilyNodeCopyReady:true")
    #expect(!uuidDisplay.hasRequiredFields)
    #expect(!playerFacingCopy.hasRequiredFields)
}

@Test func lineageAncestorNamingPolicyDistinguishesGenericAndProperNames() {
    let genericNode = LineageFamilyNodeCopy(internalLabel: "firstAncestor")
    let properNode = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let genericPolicy = LineageAncestorNamingPolicy(nodeCopy: genericNode)
    let properPolicy = LineageAncestorNamingPolicy(nodeCopy: properNode)

    #expect(genericPolicy.hasRequiredFields)
    #expect(genericPolicy.namingState == "genericDisplayLabel")
    #expect(genericPolicy.summary == "lineageAncestorNamingPolicy=internal:firstAncestor,display:First ancestor,state:genericDisplayLabel,source:lineageMemory,autoProperName:false,playerRename:false,persistence:false,breeding:false,optimization:false,playerFacing:false")
    #expect(genericPolicy.readinessSummary == "lineageAncestorNamingPolicyReady:true")

    #expect(properPolicy.hasRequiredFields)
    #expect(properPolicy.namingState == "properName")
    #expect(properPolicy.summary == "lineageAncestorNamingPolicy=internal:firstAncestor,display:Ori,state:properName,source:lineageMemory,autoProperName:false,playerRename:false,persistence:false,breeding:false,optimization:false,playerFacing:false")
    #expect(properPolicy.readinessSummary == "lineageAncestorNamingPolicyReady:true")
}

@Test func lineageAncestorNamingPolicyRejectsGeneratedRenameWriteAndControlStates() {
    let node = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let missingSource = LineageAncestorNamingPolicy(nodeCopy: node, source: "")
    let autoProperName = LineageAncestorNamingPolicy(nodeCopy: node, allowsAutoProperName: true)
    let playerRename = LineageAncestorNamingPolicy(nodeCopy: node, allowsPlayerRename: true)
    let persistence = LineageAncestorNamingPolicy(nodeCopy: node, allowsPersistenceWrite: true)
    let breeding = LineageAncestorNamingPolicy(nodeCopy: node, allowsBreedingControls: true)
    let optimization = LineageAncestorNamingPolicy(nodeCopy: node, allowsOptimizationControls: true)
    let playerFacing = LineageAncestorNamingPolicy(nodeCopy: node, playerFacing: true)
    let invalidNode = LineageAncestorNamingPolicy(
        nodeCopy: LineageFamilyNodeCopy(internalLabel: "", displayName: "Ori")
    )

    #expect(!missingSource.hasRequiredFields)
    #expect(!autoProperName.hasRequiredFields)
    #expect(!playerRename.hasRequiredFields)
    #expect(!persistence.hasRequiredFields)
    #expect(!breeding.hasRequiredFields)
    #expect(!optimization.hasRequiredFields)
    #expect(!playerFacing.hasRequiredFields)
    #expect(!invalidNode.hasRequiredFields)
    #expect(playerFacing.readinessSummary == "lineageAncestorNamingPolicyReady:false")
}

@Test func lineageFamilyPreviewRequiresTwoMembersAndReadyMemories() {
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let missingCueMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let oneMember = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        memberNames: ["Luma"],
        memories: [readyMemory]
    )
    let incompleteMemory = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        memberNames: ["Luma", "Mira"],
        memories: [missingCueMemory]
    )
    let playerFacingPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        memberNames: ["Luma", "Mira"],
        memories: [readyMemory],
        playerFacing: true
    )

    #expect(!oneMember.hasRequiredFields)
    #expect(!incompleteMemory.hasRequiredFields)
    #expect(!playerFacingPreview.hasRequiredFields)
    #expect(oneMember.readinessSummary == "lineageFamilyPreviewReady:false")
}

@Test func lineageAncestorEchoSurfaceCopyNamesAncestorWithoutControls() {
    let lumaMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let miraMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Fish tail",
        visibleCue: "fishFin",
        ancestorLabel: "firstAncestor",
        memoryLine: "Fish tail echoes firstAncestor."
    )
    let nodeCopy = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let preview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [lumaMemory, miraMemory]
    )
    let surface = LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview
    )

    #expect(surface.hasRequiredFields)
    #expect(surface.title == "Ori's echo")
    #expect(surface.cueLine == "Luma and Mira carry a quiet echo of ori.")
    #expect(surface.statusLine == "2 quiet memories are gathered here.")
    #expect(surface.allowsObservation)
    #expect(!surface.allowsBreedingControls)
    #expect(!surface.allowsOptimizationControls)
    #expect(!surface.playerFacing)
    #expect(surface.summary == "lineageAncestorEchoSurface=ancestor:firstAncestor,display:Ori,memories:2,observation:true,breeding:false,optimization:false,playerFacing:false")
    #expect(surface.readinessSummary == "lineageAncestorEchoSurfaceReady:true")
}

@Test func lineageAncestorEchoSurfaceCopyRejectsMismatchedMissingAndControlStates() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let nodeCopy = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let preview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let mismatchedPreview = LineageFamilyPreview(
        ancestorLabel: "otherAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let wrongDisplayPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "First ancestor",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )

    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: mismatchedPreview
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: wrongDisplayPreview
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        cueLine: ""
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        allowsObservation: false
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(LineageAncestorEchoSurfaceCopy(
        nodeCopy: nodeCopy,
        familyPreview: preview,
        playerFacing: true
    ).readinessSummary == "lineageAncestorEchoSurfaceReady:false")
}

@Test func lineageFamilySurfacePlacementKeepsFamilyTreeObservationalAndReadOnly() {
    let placement = LineageFamilySurfacePlacement()

    #expect(placement.hasRequiredFields)
    #expect(placement.surfaceName == "Family tree")
    #expect(placement.hostArea == "Observation")
    #expect(placement.entryTone == "observational")
    #expect(placement.allowsObservation)
    #expect(!placement.allowsBreedingControls)
    #expect(!placement.allowsOptimizationControls)
    #expect(!placement.playerFacing)
    #expect(placement.summary == "lineageFamilySurfacePlacement=surface:Family tree,host:Observation,tone:observational,observation:true,breeding:false,optimization:false,playerFacing:false")
    #expect(placement.readinessSummary == "lineageFamilySurfacePlacementReady:true")
}

@Test func lineageFamilySurfacePlacementRejectsControlOrPlayerFacingState() {
    let breedingControls = LineageFamilySurfacePlacement(allowsBreedingControls: true)
    let optimizationControls = LineageFamilySurfacePlacement(allowsOptimizationControls: true)
    let playerFacing = LineageFamilySurfacePlacement(playerFacing: true)
    let wrongTone = LineageFamilySurfacePlacement(entryTone: "management")

    #expect(!breedingControls.hasRequiredFields)
    #expect(!optimizationControls.hasRequiredFields)
    #expect(!playerFacing.hasRequiredFields)
    #expect(!wrongTone.hasRequiredFields)
    #expect(wrongTone.readinessSummary == "lineageFamilySurfacePlacementReady:false")
}

@Test func lineageFamilyEntryPointCopyIntroducesTreeFromObservationMemory() {
    let entry = LineageFamilyEntryPointCopy()

    #expect(entry.hasRequiredFields)
    #expect(entry.placement.surfaceName == "Family tree")
    #expect(entry.source == "observationMemory")
    #expect(entry.title == "Family tree")
    #expect(entry.promptLine == "When a family echo appears in Observation, keep it here as a quiet memory.")
    #expect(!entry.playerFacing)
    #expect(entry.summary == "lineageFamilyEntryPoint=source:observationMemory,title:Family tree,host:Observation,playerFacing:false")
    #expect(entry.readinessSummary == "lineageFamilyEntryPointReady:true")
}

@Test func lineageFamilyEntryPointCopyRejectsMenuBreedingOrPlayerFacingState() {
    let menuEntry = LineageFamilyEntryPointCopy(source: "menu")
    let breedingPlacement = LineageFamilySurfacePlacement(allowsBreedingControls: true)
    let breedingEntry = LineageFamilyEntryPointCopy(placement: breedingPlacement)
    let visibleEntry = LineageFamilyEntryPointCopy(playerFacing: true)

    #expect(!menuEntry.hasRequiredFields)
    #expect(!breedingEntry.hasRequiredFields)
    #expect(!visibleEntry.hasRequiredFields)
    #expect(menuEntry.readinessSummary == "lineageFamilyEntryPointReady:false")
}

@Test func lineageObservationMemoryTeaserCopyShowsPlayerFacingReadOnlyFamilyEcho() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)

    #expect(teaser.hasRequiredFields)
    #expect(teaser.entryPoint.title == "Family tree")
    #expect(teaser.title == "Family echo")
    #expect(teaser.memoryLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(teaser.statusLine == "The family tree is only remembering this for now.")
    #expect(teaser.entryLine == "First ancestor is remembered in this branch.")
    #expect(!teaser.allowsNavigation)
    #expect(!teaser.allowsPersistenceWrite)
    #expect(!teaser.allowsBreedingControls)
    #expect(!teaser.allowsOptimizationControls)
    #expect(teaser.playerFacing)
    #expect(teaser.summary == "lineageObservationMemoryTeaser=entry:Family tree,trait:tail,cue:floatingRibbon,entryLine:true,navigation:false,persistence:false,breeding:false,optimization:false,playerFacing:true")
    #expect(teaser.readinessSummary == "lineageObservationMemoryTeaserReady:true")
}

@Test func lineageObservationMemoryTeaserCopyRejectsMissingCopyAndControls() {
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let missingCueMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let readyCopy = LineageVisibleCueObservationCopy(memory: readyMemory)
    let incompleteCopy = LineageVisibleCueObservationCopy(memory: missingCueMemory)

    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: incompleteCopy
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        entryPoint: LineageFamilyEntryPointCopy(source: "menu"),
        lineageCopy: readyCopy
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        memoryLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        entryLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        allowsNavigation: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(LineageObservationMemoryTeaserCopy(
        lineageCopy: readyCopy,
        playerFacing: false
    ).readinessSummary == "lineageObservationMemoryTeaserReady:false")
}

@Test func lineageObservationMemorySheetCopyOpensReadOnlyFamilyMemory() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)
    let sheet = LineageObservationMemorySheetCopy(teaser: teaser)

    #expect(sheet.hasRequiredFields)
    #expect(sheet.teaser == teaser)
    #expect(sheet.title == "Family memory")
    #expect(sheet.ancestorLine == "Remembering First ancestor through floating tail.")
    #expect(sheet.memoryLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(sheet.householdLine == "This echo now belongs to this family's quiet line.")
    #expect(sheet.statusLine == "This memory is only being kept for now.")
    #expect(sheet.opensReadOnlySurface)
    #expect(!sheet.allowsGraphNavigation)
    #expect(!sheet.allowsPersistenceWrite)
    #expect(!sheet.allowsBreedingControls)
    #expect(!sheet.allowsOptimizationControls)
    #expect(sheet.playerFacing)
    #expect(sheet.summary == "lineageObservationMemorySheet=entry:Family tree,trait:tail,ancestor:firstAncestor,householdLine:true,readOnly:true,graphNavigation:false,persistence:false,breeding:false,optimization:false,playerFacing:true")
    #expect(sheet.readinessSummary == "lineageObservationMemorySheetReady:true")
}

@Test func lineageObservationMemorySheetCopyRejectsMissingCopyAndControls() {
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let missingCueMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let readyCopy = LineageVisibleCueObservationCopy(memory: readyMemory)
    let readyTeaser = LineageObservationMemoryTeaserCopy(lineageCopy: readyCopy)
    let incompleteTeaser = LineageObservationMemoryTeaserCopy(
        lineageCopy: LineageVisibleCueObservationCopy(memory: missingCueMemory)
    )

    #expect(!LineageObservationMemorySheetCopy(
        teaser: incompleteTeaser
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        ancestorLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        memoryLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        householdLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        opensReadOnlySurface: false
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        allowsGraphNavigation: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        playerFacing: false
    ).readinessSummary == "lineageObservationMemorySheetReady:false")
}

@Test func lineageObservationFamilyTreeEntryCopyAddsReadOnlySheetEntry() {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)
    let sheet = LineageObservationMemorySheetCopy(teaser: teaser)
    let entry = LineageObservationFamilyTreeEntryCopy(sheet: sheet)

    #expect(entry.hasRequiredFields)
    #expect(entry.sheet == sheet)
    #expect(sheet.familyTreeEntryCopy == entry)
    #expect(entry.title == "Family tree")
    #expect(entry.ancestorLine == "First ancestor begins this remembered line.")
    #expect(entry.memoryLine == "Floating tail carries a quiet echo of first ancestor.")
    #expect(entry.branchLine == "First ancestor -> floating tail echo")
    #expect(entry.generationLine == "First ancestor is the first memory this line knows.")
    #expect(entry.statusLine == "The tree is only holding this memory for now.")
    #expect(entry.opensReadOnlySurface)
    #expect(!entry.allowsGraphNavigation)
    #expect(!entry.allowsPersistenceWrite)
    #expect(!entry.allowsBreedingControls)
    #expect(!entry.allowsOptimizationControls)
    #expect(entry.playerFacing)
    #expect(entry.summary == "lineageObservationFamilyTreeEntry=title:Family tree,ancestor:firstAncestor,branchLine:true,generationLine:true,readOnly:true,graphNavigation:false,persistence:false,breeding:false,optimization:false,playerFacing:true")
    #expect(entry.readinessSummary == "lineageObservationFamilyTreeEntryReady:true")
}

@Test func lineageObservationFamilyTreeEntryCopyRejectsIncompleteSheetAndControls() {
    let readyMemory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes firstAncestor."
    )
    let readyTeaser = LineageObservationMemoryTeaserCopy(
        lineageCopy: LineageVisibleCueObservationCopy(memory: readyMemory)
    )
    let readySheet = LineageObservationMemorySheetCopy(teaser: readyTeaser)
    let incompleteSheet = LineageObservationMemorySheetCopy(
        teaser: readyTeaser,
        memoryLine: ""
    )

    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: incompleteSheet
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        ancestorLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        memoryLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        branchLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        generationLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        opensReadOnlySurface: false
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        allowsGraphNavigation: true
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(LineageObservationFamilyTreeEntryCopy(
        sheet: readySheet,
        playerFacing: false
    ).readinessSummary == "lineageObservationFamilyTreeEntryReady:false")
}

@Test func lineageFamilyChildDraftNodeKeepsDraftReadOnlyForFutureTree() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )
    let node = LineageFamilyChildDraftNode(acknowledgementSurface: acknowledgementSurface)

    #expect(node.hasRequiredFields)
    #expect(node.nodeCopy.internalLabel == "childDraft")
    #expect(node.nodeCopy.displayName == "Draft memory")
    #expect(node.nodeRole == "draftMemoryCandidate")
    #expect(node.acknowledgementSurface == acknowledgementSurface)
    #expect(!node.allowsPersistenceWrite)
    #expect(!node.allowsBreedingControls)
    #expect(!node.allowsOptimizationControls)
    #expect(!node.playerFacing)
    #expect(node.summary == "lineageFamilyChildDraftNode=display:Draft memory,role:draftMemoryCandidate,generation:4,changed:\(preview.changedTraitID),persistence:false,breeding:false,optimization:false,playerFacing:false")
    #expect(node.readinessSummary == "lineageFamilyChildDraftNodeReady:true")
}

@Test func lineageFamilyChildDraftNodeRejectsWritesControlsPlayerFacingAndIncompleteAcknowledgement() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )
    let incompleteAcknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        ),
        promptLine: ""
    )

    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: acknowledgementSurface,
        nodeRole: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: incompleteAcknowledgementSurface
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: acknowledgementSurface,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: acknowledgementSurface,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: acknowledgementSurface,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        acknowledgementSurface: acknowledgementSurface,
        playerFacing: true
    ).hasRequiredFields)
    #expect(!LineageFamilyChildDraftNode(
        nodeCopy: LineageFamilyNodeCopy(internalLabel: ""),
        acknowledgementSurface: acknowledgementSurface
    ).hasRequiredFields)
}

@Test func lineageFamilyTreeTeaserSurfaceCopyNamesReadOnlyFamilyTreePromise() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraftNode = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let teaser = LineageFamilyTreeTeaserSurfaceCopy(childDraftNode: childDraftNode)

    #expect(teaser.hasRequiredFields)
    #expect(teaser.entryPoint.title == "Family tree")
    #expect(teaser.childDraftNode == childDraftNode)
    #expect(teaser.title == "Family tree")
    #expect(teaser.subtitleLine == "A quiet place for family echoes to gather.")
    #expect(teaser.statusLine == "Draft memory is quietly waiting in this branch.")
    #expect(!teaser.allowsNavigation)
    #expect(!teaser.allowsPersistenceWrite)
    #expect(!teaser.allowsBreedingControls)
    #expect(!teaser.allowsOptimizationControls)
    #expect(!teaser.playerFacing)
    #expect(teaser.summary == "lineageFamilyTreeTeaser=title:Family tree,childDraft:ready,navigation:false,persistence:false,breeding:false,optimization:false,playerFacing:false")
    #expect(teaser.readinessSummary == "lineageFamilyTreeTeaserReady:true")
}

@Test func lineageFamilyTreeTeaserSurfaceCopyRejectsNavigationWritesControlsAndIncompleteDraft() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraftNode = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let incompleteChildDraftNode = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            ),
            waitingLine: ""
        )
    )

    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        subtitleLine: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        entryPoint: LineageFamilyEntryPointCopy(source: "menu"),
        childDraftNode: childDraftNode
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: incompleteChildDraftNode
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        allowsNavigation: true
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyTreeTeaserSurfaceCopy(
        childDraftNode: childDraftNode,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageFamilyBranchPreviewNamesThreeGenerationReadOnlyBranch() throws {
    let ancestor = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let familyPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branch = LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft
    )

    #expect(branch.hasRequiredFields)
    #expect(branch.generationDepth == 3)
    #expect(branch.visibleNodeCount == 4)
    #expect(branch.visibleEdgeCount == 3)
    #expect(branch.branchLine == "Ori begins this line; Luma and Mira carry it toward a draft memory.")
    #expect(branch.statusLine == "This branch is only being observed; no family record is written yet.")
    #expect(!branch.allowsNavigation)
    #expect(!branch.allowsPersistenceWrite)
    #expect(!branch.allowsBreedingControls)
    #expect(!branch.allowsOptimizationControls)
    #expect(!branch.playerFacing)
    #expect(branch.summary == "lineageFamilyBranchPreview=ancestor:Ori,members:Luma+Mira,draft:Draft memory,generations:3,nodes:4,edges:3,navigation:false,persistence:false,breeding:false,optimization:false,playerFacing:false")
    #expect(branch.readinessSummary == "lineageFamilyBranchPreviewReady:true")
}

@Test func lineageFamilyBranchPreviewRejectsUnsafeOrIncompleteBranchState() throws {
    let ancestor = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let familyPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )

    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        generationDepth: 2
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        branchLine: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        statusLine: ""
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: LineageFamilyPreview(
            ancestorLabel: "firstAncestor",
            ancestorDisplayName: "First ancestor",
            memberNames: ["Luma", "Mira"],
            memories: [memory]
        ),
        childDraftNode: childDraft
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        allowsNavigation: true
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        allowsBreedingControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        allowsOptimizationControls: true
    ).hasRequiredFields)
    #expect(!LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageBranchCaptionTextConnectsAncestorMembersAndDraftMemory() throws {
    let ancestor = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let familyPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branch = LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft
    )
    let previewText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let caption = LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText
    )

    #expect(caption.hasRequiredFields)
    #expect(caption.captionLine == "Ori's line holds Luma and Mira close while Draft memory waits as a quiet memory.")
    #expect(caption.safetyLine == "Family resemblance stays stronger than the surprise.")
    #expect(caption.lines == [
        "Ori's line holds Luma and Mira close while Draft memory waits as a quiet memory.",
        "Family resemblance stays stronger than the surprise."
    ])
    #expect(caption.snapshotText == caption.lines.joined(separator: "\n"))
    #expect(!caption.containsHiddenRandomDetails)
    #expect(caption.summary == "lineageBranchCaptionText=ancestor:Ori,members:Luma+Mira,draft:Draft memory,lines:2,readOnly:true,hiddenRandomDetails:false")
    #expect(caption.readinessSummary == "lineageBranchCaptionTextReady:true")
}

@Test func lineageBranchCaptionTextRejectsUnsafeBranchAndHiddenRandomDetails() throws {
    let ancestor = LineageFamilyNodeCopy(
        internalLabel: "firstAncestor",
        displayName: "Ori",
        roleLine: "Ori is remembered through a soft deer-face echo."
    )
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let familyPreview = LineageFamilyPreview(
        ancestorLabel: "firstAncestor",
        ancestorDisplayName: "Ori",
        memberNames: ["Luma", "Mira"],
        memories: [memory]
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branch = LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft
    )
    let unsafeBranch = LineageFamilyBranchPreview(
        ancestorNode: ancestor,
        familyPreview: familyPreview,
        childDraftNode: childDraft,
        allowsNavigation: true
    )
    let previewText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))

    #expect(!LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText,
        captionLine: "Ori's line holds Luma close while Draft memory waits."
    ).hasRequiredFields)
    #expect(!LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText,
        captionLine: "Ori's random seed holds Luma and Mira close while Draft memory waits."
    ).hasRequiredFields)
    #expect(!LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText,
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!LineageBranchCaptionText(
        branchPreview: unsafeBranch,
        previewText: previewText
    ).hasRequiredFields)
}

@Test func lineageObservationBranchCaptionBridgeKeepsObservationAndBranchCopyAligned() throws {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)
    let sheet = LineageObservationMemorySheetCopy(teaser: teaser)
    let entry = LineageObservationFamilyTreeEntryCopy(sheet: sheet)
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branch = LineageFamilyBranchPreview(
        ancestorNode: LineageFamilyNodeCopy(
            internalLabel: "firstAncestor",
            displayName: "Ori",
            roleLine: "Ori is remembered through a soft deer-face echo."
        ),
        familyPreview: LineageFamilyPreview(
            ancestorLabel: "firstAncestor",
            ancestorDisplayName: "Ori",
            memberNames: ["Luma", "Mira"],
            memories: [memory]
        ),
        childDraftNode: childDraft
    )
    let previewText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let caption = LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText
    )
    let bridge = LineageObservationBranchCaptionBridge(
        observationEntry: entry,
        branchCaption: caption
    )

    #expect(bridge.hasRequiredFields)
    #expect(bridge.observationIsReadOnly)
    #expect(bridge.branchCaptionIsReadOnly)
    #expect(bridge.sharesFamilyLineLanguage)
    #expect(!bridge.containsHiddenRandomDetails)
    #expect(bridge.bridgeLine == "Observation keeps the first branch gentle before the family tree becomes a place to visit.")
    #expect(bridge.summary == "lineageObservationBranchCaptionBridge=observationAncestor:firstAncestor,branchAncestor:Ori,observationReadOnly:true,branchReadOnly:true,sharedFamilyLine:true,hiddenRandomDetails:false")
    #expect(bridge.readinessSummary == "lineageObservationBranchCaptionBridgeReady:true")
}

@Test func lineageObservationBranchCaptionBridgeRejectsUnsafeOrTechnicalLanguage() throws {
    let memory = LineageVisibleCueMemory(
        traitID: "tail",
        displayName: "Floating tail",
        visibleCue: "floatingRibbon",
        ancestorLabel: "firstAncestor",
        memoryLine: "Floating tail echoes Ori."
    )
    let lineageCopy = LineageVisibleCueObservationCopy(memory: memory)
    let teaser = LineageObservationMemoryTeaserCopy(lineageCopy: lineageCopy)
    let sheet = LineageObservationMemorySheetCopy(teaser: teaser)
    let entry = LineageObservationFamilyTreeEntryCopy(sheet: sheet)
    let unsafeEntry = LineageObservationFamilyTreeEntryCopy(
        sheet: sheet,
        allowsGraphNavigation: true
    )
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let childDraft = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let branch = LineageFamilyBranchPreview(
        ancestorNode: LineageFamilyNodeCopy(
            internalLabel: "firstAncestor",
            displayName: "Ori",
            roleLine: "Ori is remembered through a soft deer-face echo."
        ),
        familyPreview: LineageFamilyPreview(
            ancestorLabel: "firstAncestor",
            ancestorDisplayName: "Ori",
            memberNames: ["Luma", "Mira"],
            memories: [memory]
        ),
        childDraftNode: childDraft
    )
    let previewText = try #require(LineageReadOnlyPreviewSurfaceText.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4,
        inheritedParentDisplayName: "Luma",
        variationAncestorDisplayName: "Mira"
    ))
    let caption = LineageBranchCaptionText(
        branchPreview: branch,
        previewText: previewText
    )

    #expect(!LineageObservationBranchCaptionBridge(
        observationEntry: unsafeEntry,
        branchCaption: caption
    ).hasRequiredFields)
    #expect(!LineageObservationBranchCaptionBridge(
        observationEntry: entry,
        branchCaption: caption,
        bridgeLine: "Observation keeps a seed random branch line."
    ).hasRequiredFields)
    #expect(!LineageObservationBranchCaptionBridge(
        observationEntry: entry,
        branchCaption: caption,
        bridgeLine: "Observation keeps this note gentle."
    ).hasRequiredFields)
    #expect(!LineageObservationBranchCaptionBridge(
        observationEntry: entry,
        branchCaption: caption,
        bridgeLine: ""
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryPersistenceBoundaryKeepsCurrentDraftBlockedFromWrites() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let boundary = LineageDraftMemoryPersistenceBoundary(childDraftNode: node)

    #expect(boundary.hasRequiredFields)
    #expect(!boundary.hasCeremonyAcknowledgement)
    #expect(!boundary.hasDiscoveryEvidence)
    #expect(!boundary.allowsSwiftDataWrite)
    #expect(!boundary.allowsAppGroupWrite)
    #expect(!boundary.createsChildRecord)
    #expect(!boundary.allowsFuturePersistence)
    #expect(!boundary.playerFacing)
    #expect(boundary.summary == "lineageDraftMemoryPersistence=changed:\(preview.changedTraitID),ceremony:false,evidence:false,swiftData:false,appGroup:false,createsChild:false,futureWrite:false,playerFacing:false")
    #expect(boundary.readinessSummary == "lineageDraftMemoryPersistenceReady:true")
}

@Test func lineageDraftMemoryCeremonyEvidenceNamesMinimumObservationProof() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )

    #expect(evidence.hasRequiredFields)
    #expect(evidence.hasObservedTraitChange)
    #expect(evidence.hasAncestorResemblanceCopy)
    #expect(evidence.hasObservationContext)
    #expect(!evidence.writesDiscoveryLog)
    #expect(!evidence.createsChildRecord)
    #expect(!evidence.playerFacing)
    #expect(evidence.summary == "lineageDraftMemoryCeremonyEvidence=changed:\(preview.changedTraitID),trait:true,ancestor:true,observation:true,discoveryWrite:false,createsChild:false,ready:true,playerFacing:false")
    #expect(evidence.readinessSummary == "lineageDraftMemoryCeremonyEvidenceReady:true")
}

@Test func lineageDraftMemoryCeremonyEvidenceRejectsMissingProofWritesAndChildCreation() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let reference = LineageChildDraftMemoryReference(preview: preview)

    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        hasObservedTraitChange: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        hasAncestorResemblanceCopy: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        hasObservationContext: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        writesDiscoveryLog: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryCeremonyEvidence(
        memoryReference: reference,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryEvidenceReviewSurfaceCopyNamesReadOnlyObservationEvidence() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let surface = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)

    #expect(surface.hasRequiredFields)
    #expect(surface.title == "Evidence review")
    #expect(surface.traitLine == "Observed \(preview.changedTraitID) change.")
    #expect(surface.ancestorLine == "Ancestor resemblance has been noticed.")
    #expect(surface.contextLine == "Keep this as an Observation memory candidate.")
    #expect(!surface.allowsPersistenceWrite)
    #expect(!surface.writesDiscoveryLog)
    #expect(!surface.createsChildRecord)
    #expect(!surface.playerFacing)
    #expect(surface.summary == "lineageDraftMemoryEvidenceReview=changed:\(preview.changedTraitID),title:Evidence review,traitReady:true,ancestorReady:true,contextReady:true,persistence:false,discoveryWrite:false,createsChild:false,playerFacing:false")
    #expect(surface.readinessSummary == "lineageDraftMemoryEvidenceReviewReady:true")
}

@Test func lineageDraftMemoryEvidenceReviewSurfaceCopyRejectsMissingCopyWritesAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )

    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        traitLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        ancestorLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        contextLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        writesDiscoveryLog: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryEvidenceReviewSurfaceCopy(
        evidence: evidence,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryAcknowledgementReviewSurfaceCopyNamesReadOnlyWaitingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )
    let surface = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface
    )

    #expect(surface.hasRequiredFields)
    #expect(surface.title == "Acknowledgement review")
    #expect(surface.reviewLine == "Notice the family echo before this draft becomes a memory.")
    #expect(surface.waitingLine == "This family echo will wait until the moment is ready.")
    #expect(!surface.allowsCommit)
    #expect(!surface.allowsPersistenceWrite)
    #expect(!surface.writesDiscoveryLog)
    #expect(!surface.createsChildRecord)
    #expect(!surface.playerFacing)
    #expect(surface.summary == "lineageDraftMemoryAcknowledgementReview=changed:\(preview.changedTraitID),title:Acknowledgement review,reviewReady:true,waitingReady:true,commit:false,persistence:false,discoveryWrite:false,createsChild:false,playerFacing:false")
    #expect(surface.readinessSummary == "lineageDraftMemoryAcknowledgementReviewReady:true")
}

@Test func lineageDraftMemoryAcknowledgementReviewSurfaceCopyRejectsMissingCopyCommitWritesAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )

    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        reviewLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        waitingLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        allowsCommit: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        writesDiscoveryLog: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryExplicitIntentGateKeepsFutureIntentNonMutating() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface
    )
    let gate = LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    let futureIntentGate = LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        hasExplicitIntent: true
    )

    #expect(gate.hasRequiredFields)
    #expect(gate.title == "Intent gate")
    #expect(gate.intentLine == "Explicit acknowledgement can be reviewed later.")
    #expect(!gate.hasExplicitIntent)
    #expect(!gate.allowsCommit)
    #expect(!gate.allowsPersistenceWrite)
    #expect(!gate.writesDiscoveryLog)
    #expect(!gate.createsChildRecord)
    #expect(!gate.playerFacing)
    #expect(gate.summary == "lineageDraftMemoryExplicitIntentGate=changed:\(preview.changedTraitID),title:Intent gate,intent:false,commit:false,persistence:false,discoveryWrite:false,createsChild:false,playerFacing:false")
    #expect(gate.readinessSummary == "lineageDraftMemoryExplicitIntentGateReady:true")
    #expect(futureIntentGate.hasRequiredFields)
    #expect(futureIntentGate.hasExplicitIntent)
    #expect(!futureIntentGate.allowsCommit)
    #expect(futureIntentGate.summary == "lineageDraftMemoryExplicitIntentGate=changed:\(preview.changedTraitID),title:Intent gate,intent:true,commit:false,persistence:false,discoveryWrite:false,createsChild:false,playerFacing:false")
}

@Test func lineageDraftMemoryExplicitIntentGateRejectsMissingCopyCommitWritesAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementSurface = LineageChildDraftAcknowledgementSurfaceCopy(
        acknowledgement: LineageChildDraftAcknowledgementPreview(
            memoryReference: LineageChildDraftMemoryReference(preview: preview)
        )
    )
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: acknowledgementSurface
    )

    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        intentLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        allowsCommit: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        writesDiscoveryLog: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryPersistenceDryRunAdapterKeepsCurrentQAWriteBlocked() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: node.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    let boundary = LineageDraftMemoryPersistenceBoundary(childDraftNode: node)
    let adapter = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate
    )

    #expect(adapter.hasRequiredFields)
    #expect(adapter.isSafeDryRun)
    #expect(!adapter.isReadyForFuturePersistence)
    #expect(!adapter.intentGate.hasExplicitIntent)
    #expect(!adapter.boundary.allowsFuturePersistence)
    #expect(adapter.targetsSwiftData)
    #expect(adapter.targetsAppGroup)
    #expect(adapter.dryRunOnly)
    #expect(!adapter.performsWrite)
    #expect(!adapter.createsChildRecord)
    #expect(!adapter.playerFacing)
    #expect(adapter.summary == "lineageDraftMemoryPersistenceDryRun=changed:\(preview.changedTraitID),safe:true,futureReady:false,intent:false,swiftData:true,appGroup:true,dryRun:true,write:false,createsChild:false,playerFacing:false")
    #expect(adapter.readinessSummary == "lineageDraftMemoryPersistenceDryRunReady:true")
}

@Test func lineageDraftMemoryPersistenceDryRunAdapterAllowsFutureReadinessOnlyWithIntentAndBoundary() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: node.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(
        acknowledgementReview: acknowledgementReview,
        hasExplicitIntent: true
    )
    let boundary = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        ceremonyEvidence: evidence,
        hasCeremonyAcknowledgement: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true
    )
    let adapter = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate
    )
    let missingIntent = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    )
    let missingBoundary = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: LineageDraftMemoryPersistenceBoundary(childDraftNode: node),
        intentGate: intentGate
    )

    #expect(adapter.hasRequiredFields)
    #expect(adapter.isSafeDryRun)
    #expect(adapter.isReadyForFuturePersistence)
    #expect(adapter.summary == "lineageDraftMemoryPersistenceDryRun=changed:\(preview.changedTraitID),safe:true,futureReady:true,intent:true,swiftData:true,appGroup:true,dryRun:true,write:false,createsChild:false,playerFacing:false")
    #expect(!missingIntent.isReadyForFuturePersistence)
    #expect(!missingBoundary.isReadyForFuturePersistence)
}

@Test func lineageDraftMemoryPersistenceDryRunAdapterRejectsWritesChildCreationAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: node.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    let boundary = LineageDraftMemoryPersistenceBoundary(childDraftNode: node)

    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        targetsSwiftData: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        targetsAppGroup: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        dryRunOnly: false
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        performsWrite: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageDraftMemoryConfirmationCeremonyKeepsPreviewReadOnly() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: node.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    let boundary = LineageDraftMemoryPersistenceBoundary(childDraftNode: node)
    let dryRunAdapter = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate
    )
    let ceremony = LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter
    )

    #expect(ceremony.hasRequiredFields)
    #expect(ceremony.title == "Confirmation ceremony")
    #expect(ceremony.ancestorLine == "Mostly family-like, with a gentle \(preview.changedTraitID) echo.")
    #expect(ceremony.safetyLine == "This draft stays read-only until a future ceremony confirms it.")
    #expect(!ceremony.allowsCommit)
    #expect(!ceremony.allowsPersistenceWrite)
    #expect(!ceremony.writesDiscoveryLog)
    #expect(!ceremony.createsChildRecord)
    #expect(!ceremony.playerFacing)
    #expect(ceremony.summary == "lineageDraftMemoryConfirmationCeremony=changed:\(preview.changedTraitID),title:Confirmation ceremony,acknowledgement:true,intent:true,dryRun:true,commit:false,persistence:false,discoveryWrite:false,createsChild:false,playerFacing:false")
    #expect(ceremony.readinessSummary == "lineageDraftMemoryConfirmationCeremonyReady:true")
}

@Test func lineageDraftMemoryConfirmationCeremonyRejectsMissingCopyWritesAndPlayerFacingState() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let evidenceReview = LineageDraftMemoryEvidenceReviewSurfaceCopy(evidence: evidence)
    let acknowledgementReview = LineageDraftMemoryAcknowledgementReviewSurfaceCopy(
        evidenceReview: evidenceReview,
        acknowledgementSurface: node.acknowledgementSurface
    )
    let intentGate = LineageDraftMemoryExplicitIntentGate(acknowledgementReview: acknowledgementReview)
    let boundary = LineageDraftMemoryPersistenceBoundary(childDraftNode: node)
    let dryRunAdapter = LineageDraftMemoryPersistenceDryRunAdapter(
        boundary: boundary,
        intentGate: intentGate
    )

    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        title: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        ancestorLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        safetyLine: ""
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        allowsCommit: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        allowsPersistenceWrite: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        writesDiscoveryLog: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        createsChildRecord: true
    ).hasRequiredFields)
    #expect(!LineageDraftMemoryConfirmationCeremony(
        acknowledgementReview: acknowledgementReview,
        intentGate: intentGate,
        dryRunAdapter: dryRunAdapter,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageFamilyQAReviewStackMatchesSnapshot() throws {
    assertSnapshot(
        of: try lineageFamilyQAReviewStackSnapshotText(),
        as: .lines,
        named: "lineage-family-qa-review-stack"
    )
}

@Test func observationHomeFamilyEchoCopyMatchesSnapshotReference() throws {
    assertSnapshot(
        of: try observationHomeFamilyEchoSnapshotText(),
        as: .lines,
        named: "observation-home-family-echo"
    )
}

@Test func genomeVariationSilhouetteCueSetMatchesSnapshotReference() {
    assertSnapshot(
        of: genomeVariationSilhouetteCueSetSnapshotText(),
        as: .lines,
        named: "genome-variation-silhouette-cue-set"
    )
}

@Test func growthCeremonyPreviewContractMatchesSnapshotReference() throws {
    assertSnapshot(
        of: try growthCeremonyPreviewContractSnapshotText(),
        as: .lines,
        named: "growth-ceremony-preview-contract"
    )
}

@Test func lineageDraftMemoryPersistenceBoundaryAllowsFutureWriteOnlyWithCeremonyAndEvidence() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let futureBoundary = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        hasCeremonyAcknowledgement: true,
        hasDiscoveryEvidence: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true
    )
    let missingEvidence = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        hasCeremonyAcknowledgement: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true
    )
    let childRecord = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        hasCeremonyAcknowledgement: true,
        hasDiscoveryEvidence: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true,
        createsChildRecord: true
    )
    let playerFacing = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        hasCeremonyAcknowledgement: true,
        hasDiscoveryEvidence: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true,
        playerFacing: true
    )

    #expect(futureBoundary.hasRequiredFields)
    #expect(futureBoundary.allowsFuturePersistence)
    #expect(futureBoundary.summary == "lineageDraftMemoryPersistence=changed:\(preview.changedTraitID),ceremony:true,evidence:true,swiftData:true,appGroup:true,createsChild:false,futureWrite:true,playerFacing:false")
    #expect(!missingEvidence.allowsFuturePersistence)
    #expect(!childRecord.hasRequiredFields)
    #expect(!childRecord.allowsFuturePersistence)
    #expect(!playerFacing.hasRequiredFields)
    #expect(!playerFacing.allowsFuturePersistence)
}

@Test func lineageDraftMemoryPersistenceBoundaryCanUnlockThroughCeremonyEvidenceChecklist() throws {
    let preview = try #require(LineageGenomePreviewPlanner.preview(
        parents: [lineagePreviewParentA(), lineagePreviewParentB()],
        generation: 4
    ))
    let node = LineageFamilyChildDraftNode(
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy(
            acknowledgement: LineageChildDraftAcknowledgementPreview(
                memoryReference: LineageChildDraftMemoryReference(preview: preview)
            )
        )
    )
    let evidence = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview)
    )
    let boundary = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        ceremonyEvidence: evidence,
        hasCeremonyAcknowledgement: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true
    )
    let missingObservation = LineageDraftMemoryCeremonyEvidence(
        memoryReference: LineageChildDraftMemoryReference(preview: preview),
        hasObservationContext: false
    )
    let blockedBoundary = LineageDraftMemoryPersistenceBoundary(
        childDraftNode: node,
        ceremonyEvidence: missingObservation,
        hasCeremonyAcknowledgement: true,
        allowsSwiftDataWrite: true,
        allowsAppGroupWrite: true
    )

    #expect(boundary.hasDiscoveryEvidence)
    #expect(boundary.allowsFuturePersistence)
    #expect(boundary.summary == "lineageDraftMemoryPersistence=changed:\(preview.changedTraitID),ceremony:true,evidence:true,swiftData:true,appGroup:true,createsChild:false,futureWrite:true,playerFacing:false")
    #expect(!blockedBoundary.hasDiscoveryEvidence)
    #expect(!blockedBoundary.allowsFuturePersistence)
}

@Test func lineageFamilyGraphLayoutAdoptionGateKeepsCurrentQABelowDependencyThreshold() {
    let gate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 2,
        visibleNodeCount: 3,
        visibleEdgeCount: 2
    )

    #expect(gate.hasRequiredFields)
    #expect(!gate.requiresDeterministicLayout)
    #expect(!gate.manualLayoutInsufficient)
    #expect(!gate.shouldAdoptGraphLayoutHelper)
    #expect(!gate.playerFacing)
    #expect(gate.summary == "lineageFamilyGraphLayoutAdoption=generations:2,nodes:3,edges:2,deterministic:false,manualInsufficient:false,adopt:false,playerFacing:false")
    #expect(gate.readinessSummary == "lineageFamilyGraphLayoutAdoptionReady:true")
}

@Test func lineageFamilyGraphLayoutAdoptionGateRecommendsHelperOnlyAfterTreeComplexityThreshold() {
    let futureGate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 5,
        visibleEdgeCount: 4,
        requiresDeterministicLayout: true,
        manualLayoutInsufficient: true
    )
    let missingDeterminism = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 5,
        visibleEdgeCount: 4,
        manualLayoutInsufficient: true
    )
    let manualStillWorks = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 5,
        visibleEdgeCount: 4,
        requiresDeterministicLayout: true
    )
    let playerFacingGate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 5,
        visibleEdgeCount: 4,
        requiresDeterministicLayout: true,
        manualLayoutInsufficient: true,
        playerFacing: true
    )
    let invalidEdgeCount = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 3,
        visibleEdgeCount: 3,
        requiresDeterministicLayout: true,
        manualLayoutInsufficient: true
    )

    #expect(futureGate.hasRequiredFields)
    #expect(futureGate.shouldAdoptGraphLayoutHelper)
    #expect(futureGate.summary == "lineageFamilyGraphLayoutAdoption=generations:3,nodes:5,edges:4,deterministic:true,manualInsufficient:true,adopt:true,playerFacing:false")
    #expect(!missingDeterminism.shouldAdoptGraphLayoutHelper)
    #expect(!manualStillWorks.shouldAdoptGraphLayoutHelper)
    #expect(!playerFacingGate.hasRequiredFields)
    #expect(!playerFacingGate.shouldAdoptGraphLayoutHelper)
    #expect(!invalidEdgeCount.hasRequiredFields)
}

@Test func lineageFamilyGraphLayoutLibraryReviewDefersSwiftCollectionsForCurrentBranch() {
    let gate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 4,
        visibleEdgeCount: 3
    )
    let review = LineageFamilyGraphLayoutLibraryReview(gate: gate)

    #expect(review.hasRequiredFields)
    #expect(review.candidateLibrary == "SwiftAlgorithmsCollections")
    #expect(review.candidatePurpose == "branchTraversalAndOrdering")
    #expect(review.manualLayoutStillPreferred)
    #expect(!review.dependencyAdded)
    #expect(!review.packageChanged)
    #expect(!review.appBehaviorChanged)
    #expect(!review.playerFacing)
    #expect(review.summary == "lineageFamilyGraphLayoutLibraryReview=candidate:SwiftAlgorithmsCollections,purpose:branchTraversalAndOrdering,manualPreferred:true,adoptGate:false,dependencyAdded:false,packageChanged:false,appBehaviorChanged:false,playerFacing:false")
    #expect(review.readinessSummary == "lineageFamilyGraphLayoutLibraryReviewReady:true")
}

@Test func lineageFamilyGraphLayoutLibraryReviewRejectsPrematureOrAdoptableDependencyState() {
    let currentGate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 4,
        visibleEdgeCount: 3
    )
    let futureGate = LineageFamilyGraphLayoutAdoptionGate(
        generationDepth: 3,
        visibleNodeCount: 5,
        visibleEdgeCount: 4,
        requiresDeterministicLayout: true,
        manualLayoutInsufficient: true
    )

    #expect(!LineageFamilyGraphLayoutLibraryReview(gate: futureGate).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        candidateLibrary: "GraphLayoutKit"
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        candidatePurpose: "automaticDrawing"
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        manualLayoutStillPreferred: false
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        dependencyAdded: true
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        packageChanged: true
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        appBehaviorChanged: true
    ).hasRequiredFields)
    #expect(!LineageFamilyGraphLayoutLibraryReview(
        gate: currentGate,
        playerFacing: true
    ).hasRequiredFields)
}

@Test func lineageFamilyEntryMemoryBridgeConnectsFamilyEntryToLineageDiscoveryHandoff() throws {
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let handoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        plan: plan,
        lineageTeaserCopy: GrowthCeremonyLineageTeaserCopy(
            previewTitle: plan.previewTitle,
            bridge: GrowthCeremonyLineageCueBridge(
                traitReveal: plan.traitReveal,
                lineageCopy: LineageVisibleCueObservationCopy(
                    memory: LineageVisibleCueMemory(
                        traitID: "tail",
                        displayName: "Floating tail",
                        visibleCue: "floatingRibbon",
                        ancestorLabel: "firstAncestor",
                        memoryLine: "Floating tail echoes firstAncestor."
                    )
                )
            )
        )
    )
    let bridge = LineageFamilyEntryMemoryBridge(discoveryHandoff: handoff)

    #expect(bridge.hasRequiredFields)
    #expect(bridge.entryPoint.title == "Family tree")
    #expect(bridge.discoveryHandoff.includesLineageEcho)
    #expect(!bridge.discoveryHandoff.allowsWrite)
    #expect(!bridge.playerFacing)
    #expect(bridge.summary == "lineageFamilyEntryMemory=entry:Family tree,source:observationMemory,discovery:Luma grew into Adult.,lineage:true,allowsWrite:false,playerFacing:false")
    #expect(bridge.readinessSummary == "lineageFamilyEntryMemoryReady:true")
}

@Test func lineageFamilyEntryMemoryBridgeRequiresLineageAndPreviewOnlyHandoff() throws {
    let creature = Creature(
        name: "Mira",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian, wing: .fairy, tail: .fish)),
        growthStage: .juvenile
    )
    let plan = try #require(creature.growthCeremonyPlan)
    let ordinaryHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(plan: plan)
    let writableHandoff = GrowthCeremonyDiscoveryLogHandoffPreview(
        discoveryTitle: "Mira grew into Adult.",
        stage: .adult,
        kind: .growth,
        memoryLine: "A soft family echo was noticed.",
        includesLineageEcho: true,
        allowsWrite: true
    )
    let visibleBridge = LineageFamilyEntryMemoryBridge(
        discoveryHandoff: writableHandoff,
        playerFacing: true
    )

    #expect(!LineageFamilyEntryMemoryBridge(discoveryHandoff: ordinaryHandoff).hasRequiredFields)
    #expect(!LineageFamilyEntryMemoryBridge(discoveryHandoff: writableHandoff).hasRequiredFields)
    #expect(!visibleBridge.hasRequiredFields)
    #expect(visibleBridge.readinessSummary == "lineageFamilyEntryMemoryReady:false")
}

@Test func creatureRecordsDiscoveryMemoriesInOrder() {
    let ancestorID = UUID()
    var creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile
    )

    creature.recordDiscovery(
        title: "Soft lunar glow deepened",
        kind: .glow,
        stage: .juvenile
    )
    creature.recordDiscovery(
        title: "Tail movement resembles first ancestor",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: ancestorID
    )

    #expect(creature.discoveredTraits.map(\.kind) == [.glow, .inheritedResemblance])
    #expect(creature.discoveredTraits.last?.relatedAncestorID == ancestorID)
}

@Test func rendererMetadataSummaryCombinesCatalogStateAndValidationCoverage() {
    let summary = RendererMetadataSummary.combine(
        catalogMetadataSummary: "catalogBacked:true",
        assemblyPlanCatalogValidationSummary: "catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(summary == "catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true")
}

@Test func rendererMetadataReadinessRequiresAllFields() {
    #expect(RendererMetadataSummary.hasPopulatedFields(
        catalogMetadataSummary: "catalogBacked:true",
        assemblyPlanCatalogValidationSummary: "catalogCoverage=family:true,layer:true,socket:true",
        rendererMetadataSummary: "catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasPopulatedFields(
        catalogMetadataSummary: "catalogBacked:true",
        assemblyPlanCatalogValidationSummary: "",
        rendererMetadataSummary: "catalogBacked:true,"
    ))
}

@Test func rendererMetadataReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.readinessSummary(isReady: true) == "rendererMetadataReady:true")
    #expect(RendererMetadataSummary.readinessSummary(isReady: false) == "rendererMetadataReady:false")
}

@Test func rendererGenomeVariationSummaryReportsMorphBasesAndVisibleTraitCount() {
    let summary = RendererMetadataSummary.genomeVisualVariationSummary(
        face: "crystal",
        body: "lunarian",
        wing: "none",
        tail: "floating",
        visibleTraitCount: 3
    )

    #expect(summary == "genomeVariation=face:crystal,body:lunarian,wing:none,tail:floating,visibleTraitCount:3")
}

@Test func rendererGenomeVariationSummaryCountsOptionalWingAndTailWhenPresent() {
    let summary = RendererMetadataSummary.genomeVisualVariationSummary(
        face: "feline",
        body: "sylphian",
        wing: "fairy",
        tail: "fish",
        visibleTraitCount: 4
    )

    #expect(summary == "genomeVariation=face:feline,body:sylphian,wing:fairy,tail:fish,visibleTraitCount:4")
}

@Test func rendererGenomeVariationSummaryCountsOnlyMandatoryBasesWhenOptionalsAreAbsent() {
    let summary = RendererMetadataSummary.genomeVisualVariationSummary(
        face: "round",
        body: "verdant",
        wing: "none",
        tail: "none",
        visibleTraitCount: 2
    )

    #expect(summary == "genomeVariation=face:round,body:verdant,wing:none,tail:none,visibleTraitCount:2")
}

@Test func rendererGenomeVariationMetadataReadinessRequiresSummaryAndTraitCount() {
    #expect(RendererMetadataSummary.hasGenomeVisualVariationFields(
        face: "fairy",
        body: "sylphian",
        wing: "fairy",
        tail: "fish",
        visibleTraitCount: 4,
        summary: "genomeVariation=face:fairy,body:sylphian,wing:fairy,tail:fish,visibleTraitCount:4"
    ))

    #expect(!RendererMetadataSummary.hasGenomeVisualVariationFields(
        face: "fairy",
        body: "sylphian",
        wing: "fairy",
        tail: "fish",
        visibleTraitCount: 0,
        summary: "genomeVariation=face:fairy,body:sylphian,wing:fairy,tail:fish,visibleTraitCount:0"
    ))

    #expect(RendererMetadataSummary.genomeVisualVariationReadinessSummary(isReady: true) == "genomeVisualVariationMetadataReady:true")
    #expect(RendererMetadataSummary.genomeVisualVariationReadinessSummary(isReady: false) == "genomeVisualVariationMetadataReady:false")
}

@Test func rendererPersonalityEyeCueSummaryReportsExpressionLabels() {
    let summary = RendererMetadataSummary.personalityEyeCueSummary(
        openness: "open",
        softness: "gentle",
        sparkle: "warm"
    )

    #expect(summary == "personalityEyeCue=openness:open,softness:gentle,sparkle:warm")
}

@Test func rendererPersonalityEyeCueMetadataReadinessRequiresAllLabels() {
    #expect(RendererMetadataSummary.hasPersonalityEyeCueFields(
        openness: "wide",
        softness: "steady",
        sparkle: "bright",
        summary: "personalityEyeCue=openness:wide,softness:steady,sparkle:bright"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityEyeCueFields(
        openness: "",
        softness: "steady",
        sparkle: "bright",
        summary: "personalityEyeCue=openness:,softness:steady,sparkle:bright"
    ))

    #expect(RendererMetadataSummary.personalityEyeCueReadinessSummary(isReady: true) == "personalityEyeCueMetadataReady:true")
    #expect(RendererMetadataSummary.personalityEyeCueReadinessSummary(isReady: false) == "personalityEyeCueMetadataReady:false")
}

@Test func rendererPersonalityEyeGazeCueSummaryReportsGazeLabel() {
    let summary = RendererMetadataSummary.personalityEyeGazeCueSummary(
        gaze: "attentiveRightGaze",
        assetOutputs: "none"
    )

    #expect(summary == "personalityEyeGazeCue=gaze:attentiveRightGaze,assetOutputs:none")
}

@Test func rendererPersonalityEyeGazeCueReadinessRequiresGazeFields() {
    #expect(RendererMetadataSummary.hasPersonalityEyeGazeCueFields(
        gaze: "curiousRightGaze",
        assetOutputs: "none",
        summary: "personalityEyeGazeCue=gaze:curiousRightGaze,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityEyeGazeCueFields(
        gaze: "",
        assetOutputs: "none",
        summary: "personalityEyeGazeCue=gaze:,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityEyeGazeCueFields(
        gaze: "curiousRightGaze",
        assetOutputs: "texture",
        summary: "personalityEyeGazeCue=gaze:curiousRightGaze,assetOutputs:texture"
    ))

    #expect(RendererMetadataSummary.personalityEyeGazeCueReadinessSummary(isReady: true) == "personalityEyeGazeCueReady:true")
    #expect(RendererMetadataSummary.personalityEyeGazeCueReadinessSummary(isReady: false) == "personalityEyeGazeCueReady:false")
}

@Test func rendererPersonalityBlinkCueSummaryReportsBlinkLabels() {
    let summary = RendererMetadataSummary.personalityBlinkCueSummary(
        style: "softQuickBlink",
        depth: "softClose",
        hold: "shortHold",
        assetOutputs: "none"
    )

    #expect(summary == "personalityBlinkCue=style:softQuickBlink,depth:softClose,hold:shortHold,assetOutputs:none")
}

@Test func rendererPersonalityBlinkCueReadinessRequiresBlinkFields() {
    #expect(RendererMetadataSummary.hasPersonalityBlinkCueFields(
        style: "brightQuickBlink",
        depth: "lightClose",
        hold: "quickHold",
        assetOutputs: "none",
        summary: "personalityBlinkCue=style:brightQuickBlink,depth:lightClose,hold:quickHold,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityBlinkCueFields(
        style: "",
        depth: "lightClose",
        hold: "quickHold",
        assetOutputs: "none",
        summary: "personalityBlinkCue=style:,depth:lightClose,hold:quickHold,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityBlinkCueFields(
        style: "brightQuickBlink",
        depth: "lightClose",
        hold: "quickHold",
        assetOutputs: "timeline",
        summary: "personalityBlinkCue=style:brightQuickBlink,depth:lightClose,hold:quickHold,assetOutputs:timeline"
    ))

    #expect(RendererMetadataSummary.personalityBlinkCueReadinessSummary(isReady: true) == "personalityBlinkCueReady:true")
    #expect(RendererMetadataSummary.personalityBlinkCueReadinessSummary(isReady: false) == "personalityBlinkCueReady:false")
}

@Test func rendererPersonalitySleepinessIdleCueSummaryReportsRestLabels() {
    let summary = RendererMetadataSummary.personalitySleepinessIdleCueSummary(
        style: "drowsyRest",
        breath: "softBreath",
        pace: "slowPace",
        assetOutputs: "none"
    )

    #expect(summary == "personalitySleepinessIdleCue=style:drowsyRest,breath:softBreath,pace:slowPace,assetOutputs:none")
}

@Test func rendererPersonalitySleepinessIdleCueReadinessRequiresRestFields() {
    #expect(RendererMetadataSummary.hasPersonalitySleepinessIdleCueFields(
        style: "drowsyRest",
        breath: "softBreath",
        pace: "slowPace",
        assetOutputs: "none",
        summary: "personalitySleepinessIdleCue=style:drowsyRest,breath:softBreath,pace:slowPace,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalitySleepinessIdleCueFields(
        style: "",
        breath: "softBreath",
        pace: "slowPace",
        assetOutputs: "none",
        summary: "personalitySleepinessIdleCue=style:,breath:softBreath,pace:slowPace,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalitySleepinessIdleCueFields(
        style: "drowsyRest",
        breath: "softBreath",
        pace: "slowPace",
        assetOutputs: "timeline",
        summary: "personalitySleepinessIdleCue=style:drowsyRest,breath:softBreath,pace:slowPace,assetOutputs:timeline"
    ))

    #expect(RendererMetadataSummary.personalitySleepinessIdleCueReadinessSummary(isReady: true) == "personalitySleepinessIdleCueReady:true")
    #expect(RendererMetadataSummary.personalitySleepinessIdleCueReadinessSummary(isReady: false) == "personalitySleepinessIdleCueReady:false")
}

@Test func rendererPersonalityEyeDetailSummaryReportsCatchlightStyle() {
    let summary = RendererMetadataSummary.personalityEyeDetailSummary(
        catchlightStyle: "brightTinyGlint",
        catchlightPlacement: "upperCurious",
        assetOutputs: "none"
    )

    #expect(summary == "personalityEyeDetail=catchlight:brightTinyGlint,placement:upperCurious,assetOutputs:none")
}

@Test func rendererPersonalityEyeDetailReadinessRequiresCatchlightFields() {
    #expect(RendererMetadataSummary.hasPersonalityEyeDetailFields(
        catchlightStyle: "softLowGlint",
        catchlightPlacement: "lowerLeft",
        assetOutputs: "none",
        summary: "personalityEyeDetail=catchlight:softLowGlint,placement:lowerLeft,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityEyeDetailFields(
        catchlightStyle: "",
        catchlightPlacement: "upperLeft",
        assetOutputs: "none",
        summary: "personalityEyeDetail=catchlight:,placement:upperLeft,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.personalityEyeDetailReadinessSummary(isReady: true) == "personalityEyeDetailReady:true")
    #expect(RendererMetadataSummary.personalityEyeDetailReadinessSummary(isReady: false) == "personalityEyeDetailReady:false")
}

@Test func rendererPersonalityCheekWarmthCueSummaryReportsWarmthLabels() {
    let summary = RendererMetadataSummary.personalityCheekWarmthCueSummary(
        warmth: "softWarmth",
        placement: "softCheeks",
        assetOutputs: "none"
    )

    #expect(summary == "personalityCheekWarmthCue=warmth:softWarmth,placement:softCheeks,assetOutputs:none")
}

@Test func rendererPersonalityCheekWarmthCueReadinessRequiresWarmthFields() {
    #expect(RendererMetadataSummary.hasPersonalityCheekWarmthCueFields(
        warmth: "friendlyWarmth",
        placement: "openCheeks",
        assetOutputs: "none",
        summary: "personalityCheekWarmthCue=warmth:friendlyWarmth,placement:openCheeks,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityCheekWarmthCueFields(
        warmth: "",
        placement: "openCheeks",
        assetOutputs: "none",
        summary: "personalityCheekWarmthCue=warmth:,placement:openCheeks,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityCheekWarmthCueFields(
        warmth: "friendlyWarmth",
        placement: "openCheeks",
        assetOutputs: "texture",
        summary: "personalityCheekWarmthCue=warmth:friendlyWarmth,placement:openCheeks,assetOutputs:texture"
    ))

    #expect(RendererMetadataSummary.personalityCheekWarmthCueReadinessSummary(isReady: true) == "personalityCheekWarmthCueReady:true")
    #expect(RendererMetadataSummary.personalityCheekWarmthCueReadinessSummary(isReady: false) == "personalityCheekWarmthCueReady:false")
}

@Test func rendererPersonalityMouthCueSummaryReportsMouthLabels() {
    let summary = RendererMetadataSummary.personalityMouthCueSummary(
        style: "softGreetingMouth",
        energy: "settledEnergy",
        width: "softWidth",
        assetOutputs: "none"
    )

    #expect(summary == "personalityMouthCue=style:softGreetingMouth,energy:settledEnergy,width:softWidth,assetOutputs:none")
}

@Test func rendererPersonalityMouthCueReadinessRequiresMouthFields() {
    #expect(RendererMetadataSummary.hasPersonalityMouthCueFields(
        style: "softGreetingMouth",
        energy: "settledEnergy",
        width: "softWidth",
        assetOutputs: "none",
        summary: "personalityMouthCue=style:softGreetingMouth,energy:settledEnergy,width:softWidth,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityMouthCueFields(
        style: "",
        energy: "settledEnergy",
        width: "softWidth",
        assetOutputs: "none",
        summary: "personalityMouthCue=style:,energy:settledEnergy,width:softWidth,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityMouthCueFields(
        style: "softGreetingMouth",
        energy: "settledEnergy",
        width: "softWidth",
        assetOutputs: "curveAsset",
        summary: "personalityMouthCue=style:softGreetingMouth,energy:settledEnergy,width:softWidth,assetOutputs:curveAsset"
    ))

    #expect(RendererMetadataSummary.personalityMouthCueReadinessSummary(isReady: true) == "personalityMouthCueReady:true")
    #expect(RendererMetadataSummary.personalityMouthCueReadinessSummary(isReady: false) == "personalityMouthCueReady:false")
}

@Test func rendererPersonalityPostureCueSummaryReportsAttentionLabels() {
    let summary = RendererMetadataSummary.personalityPostureCueSummary(
        attention: "attentiveLean",
        timidity: "steadyPresence",
        lean: "rightListeningLean",
        assetOutputs: "none"
    )

    #expect(summary == "personalityPostureCue=attention:attentiveLean,timidity:steadyPresence,lean:rightListeningLean,assetOutputs:none")
}

@Test func rendererPersonalityPostureCueReadinessRequiresPostureFields() {
    #expect(RendererMetadataSummary.hasPersonalityPostureCueFields(
        attention: "attentiveLean",
        timidity: "steadyPresence",
        lean: "rightListeningLean",
        assetOutputs: "none",
        summary: "personalityPostureCue=attention:attentiveLean,timidity:steadyPresence,lean:rightListeningLean,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityPostureCueFields(
        attention: "",
        timidity: "steadyPresence",
        lean: "rightListeningLean",
        assetOutputs: "none",
        summary: "personalityPostureCue=attention:,timidity:steadyPresence,lean:rightListeningLean,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityPostureCueFields(
        attention: "attentiveLean",
        timidity: "steadyPresence",
        lean: "rightListeningLean",
        assetOutputs: "poseAsset",
        summary: "personalityPostureCue=attention:attentiveLean,timidity:steadyPresence,lean:rightListeningLean,assetOutputs:poseAsset"
    ))

    #expect(RendererMetadataSummary.personalityPostureCueReadinessSummary(isReady: true) == "personalityPostureCueReady:true")
    #expect(RendererMetadataSummary.personalityPostureCueReadinessSummary(isReady: false) == "personalityPostureCueReady:false")
}

@Test func rendererSpriteKitGlowAuraCueSummaryReportsGlowLabels() {
    let summary = RendererMetadataSummary.spriteKitGlowAuraCueSummary(
        glow: "deep",
        aura: "ancestralHalo",
        pulse: "brightPulse",
        motes: "wideOrbitMotes",
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitGlowAuraCue=glow:deep,aura:ancestralHalo,pulse:brightPulse,motes:wideOrbitMotes,assetOutputs:none")
}

@Test func rendererSpriteKitGlowAuraCueReadinessRequiresAllLabels() {
    #expect(RendererMetadataSummary.hasSpriteKitGlowAuraCueFields(
        glow: "soft",
        aura: "quietHalo",
        pulse: "breathingPulse",
        motes: "softOrbitMotes",
        assetOutputs: "none",
        summary: "spriteKitGlowAuraCue=glow:soft,aura:quietHalo,pulse:breathingPulse,motes:softOrbitMotes,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitGlowAuraCueFields(
        glow: "soft",
        aura: "",
        pulse: "breathingPulse",
        motes: "softOrbitMotes",
        assetOutputs: "none",
        summary: "spriteKitGlowAuraCue=glow:soft,aura:,pulse:breathingPulse,motes:softOrbitMotes,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitGlowAuraCueFields(
        glow: "soft",
        aura: "quietHalo",
        pulse: "breathingPulse",
        motes: "",
        assetOutputs: "none",
        summary: "spriteKitGlowAuraCue=glow:soft,aura:quietHalo,pulse:breathingPulse,motes:,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitGlowAuraCueReadinessSummary(isReady: true) == "spriteKitGlowAuraCueReady:true")
    #expect(RendererMetadataSummary.spriteKitGlowAuraCueReadinessSummary(isReady: false) == "spriteKitGlowAuraCueReady:false")
}

@Test func rendererPersonalityMysticismAuraCueSummaryReportsAuraLabels() {
    let summary = RendererMetadataSummary.personalityMysticismAuraCueSummary(
        mysticism: "moonlitAura",
        halo: "deepMysticHalo",
        assetOutputs: "none"
    )

    #expect(summary == "personalityMysticismAuraCue=mysticism:moonlitAura,halo:deepMysticHalo,assetOutputs:none")
}

@Test func rendererPersonalityMysticismAuraCueReadinessRequiresAuraFields() {
    #expect(RendererMetadataSummary.hasPersonalityMysticismAuraCueFields(
        mysticism: "moonlitAura",
        halo: "deepMysticHalo",
        assetOutputs: "none",
        summary: "personalityMysticismAuraCue=mysticism:moonlitAura,halo:deepMysticHalo,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityMysticismAuraCueFields(
        mysticism: "",
        halo: "deepMysticHalo",
        assetOutputs: "none",
        summary: "personalityMysticismAuraCue=mysticism:,halo:deepMysticHalo,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasPersonalityMysticismAuraCueFields(
        mysticism: "moonlitAura",
        halo: "deepMysticHalo",
        assetOutputs: "texture",
        summary: "personalityMysticismAuraCue=mysticism:moonlitAura,halo:deepMysticHalo,assetOutputs:texture"
    ))

    #expect(RendererMetadataSummary.personalityMysticismAuraCueReadinessSummary(isReady: true) == "personalityMysticismAuraCueReady:true")
    #expect(RendererMetadataSummary.personalityMysticismAuraCueReadinessSummary(isReady: false) == "personalityMysticismAuraCueReady:false")
}

@Test func rendererSpriteKitPatternMarkingCueSummaryReportsPatternLabels() {
    let summary = RendererMetadataSummary.spriteKitPatternMarkingCueSummary(
        gene: "contrast",
        mark: "softDapples",
        placement: "upperBelly",
        spread: "softSpread",
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitPatternMarkingCue=gene:contrast,mark:softDapples,placement:upperBelly,spread:softSpread,assetOutputs:none")
}

@Test func rendererSpriteKitPatternMarkingCueReadinessRequiresAllFields() {
    #expect(RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "contrast",
        mark: "softDapples",
        placement: "upperBelly",
        spread: "softSpread",
        assetOutputs: "none",
        summary: "spriteKitPatternMarkingCue=gene:contrast,mark:softDapples,placement:upperBelly,spread:softSpread,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "",
        mark: "softDapples",
        placement: "upperBelly",
        spread: "softSpread",
        assetOutputs: "none",
        summary: "spriteKitPatternMarkingCue=gene:,mark:softDapples,placement:upperBelly,spread:softSpread,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "contrast",
        mark: "",
        placement: "upperBelly",
        spread: "softSpread",
        assetOutputs: "none",
        summary: "spriteKitPatternMarkingCue=gene:contrast,mark:,placement:upperBelly,spread:softSpread,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "contrast",
        mark: "softDapples",
        placement: "",
        spread: "softSpread",
        assetOutputs: "none",
        summary: "spriteKitPatternMarkingCue=gene:contrast,mark:softDapples,placement:,spread:softSpread,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "contrast",
        mark: "softDapples",
        placement: "upperBelly",
        spread: "",
        assetOutputs: "none",
        summary: "spriteKitPatternMarkingCue=gene:contrast,mark:softDapples,placement:upperBelly,spread:,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
        gene: "contrast",
        mark: "softDapples",
        placement: "upperBelly",
        spread: "softSpread",
        assetOutputs: "CoreImage",
        summary: "spriteKitPatternMarkingCue=gene:contrast,mark:softDapples,placement:upperBelly,spread:softSpread,assetOutputs:CoreImage"
    ))

    #expect(RendererMetadataSummary.spriteKitPatternMarkingCueReadinessSummary(isReady: true) == "spriteKitPatternMarkingCueReady:true")
    #expect(RendererMetadataSummary.spriteKitPatternMarkingCueReadinessSummary(isReady: false) == "spriteKitPatternMarkingCueReady:false")
}

@Test func rendererCoreImagePatternGenerationPreflightSummaryReportsFutureGate() {
    let summary = RendererMetadataSummary.coreImagePatternGenerationPreflightSummary(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask", "glow", "noise", "cppnPrecursor"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "coreImagePatternGenerationPreflight=surface:GenomeVariation,candidate:CoreImage,inputs:mask+glow+noise+cppnPrecursor,handmadeVocabulary:true,snapshotBaseline:true,preservesSilhouette:true,externalDependency:false,packageEdited:false,projectEdited:false,rendererChanged:false,assetOutputs:none")
}

@Test func rendererCoreImagePatternGenerationPreflightReadinessRequiresHandmadeBaseline() {
    let summary = RendererMetadataSummary.coreImagePatternGenerationPreflightSummary(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask", "glow", "noise"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none"
    )

    #expect(RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask", "glow", "noise"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "ExternalTexturePackage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: [],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: false,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: false,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: false,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: true,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: true,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: true,
        rendererChanged: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasCoreImagePatternGenerationPreflightFields(
        surface: "GenomeVariation",
        candidate: "CoreImage",
        generatedInputs: ["mask"],
        handmadeVocabularyAccepted: true,
        snapshotBaselineAccepted: true,
        preservesHandmadeSilhouette: true,
        externalDependencyRequired: false,
        packageEdited: false,
        projectEdited: false,
        rendererChanged: false,
        assetOutputs: "PNG",
        summary: summary
    ))

    #expect(RendererMetadataSummary.coreImagePatternGenerationPreflightReadinessSummary(isReady: true) == "coreImagePatternGenerationPreflightReady:true")
    #expect(RendererMetadataSummary.coreImagePatternGenerationPreflightReadinessSummary(isReady: false) == "coreImagePatternGenerationPreflightReady:false")
}

@Test func rendererSpriteKitAncestralGlintCueSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitAncestralGlintCueSummary(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitAncestralGlintCueSummary(
        cue: "none",
        placement: "none",
        glintCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:upperChest,glints:2,ancestryLinked:true,active:true,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitAncestralGlintCue=cue:none,placement:none,glints:0,ancestryLinked:false,active:false,assetOutputs:none")
}

@Test func rendererSpriteKitAncestralGlintCueReadinessRequiresSafeAncestryState() {
    #expect(RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:upperChest,glints:2,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "none",
        placement: "none",
        glintCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:none,placement:none,glints:0,ancestryLinked:false,active:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:,placement:upperChest,glints:2,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:,glints:2,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: false,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:upperChest,glints:2,ancestryLinked:false,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "CoreImage",
        summary: "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:upperChest,glints:2,ancestryLinked:true,active:true,assetOutputs:CoreImage"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 2,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: ""
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "softAncestralGlint",
        placement: "upperChest",
        glintCount: 0,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:softAncestralGlint,placement:upperChest,glints:0,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
        cue: "none",
        placement: "none",
        glintCount: 1,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitAncestralGlintCue=cue:none,placement:none,glints:1,ancestryLinked:false,active:false,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitAncestralGlintCueReadinessSummary(isReady: true) == "spriteKitAncestralGlintCueReady:true")
    #expect(RendererMetadataSummary.spriteKitAncestralGlintCueReadinessSummary(isReady: false) == "spriteKitAncestralGlintCueReady:false")
}

@Test func rendererSpriteKitTailLineageEchoCueSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitTailLineageEchoCueSummary(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitTailLineageEchoCueSummary(
        cue: "none",
        tail: "none",
        placement: "none",
        dotCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:true,active:true,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitTailLineageEchoCue=cue:none,tail:none,placement:none,dots:0,ancestryLinked:false,active:false,assetOutputs:none")
}

@Test func rendererSpriteKitFaceLineageEchoCueSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitFaceLineageEchoCueSummary(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitFaceLineageEchoCueSummary(
        cue: "none",
        face: "none",
        placement: "none",
        dotCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:forehead,dots:3,ancestryLinked:true,active:true,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitFaceLineageEchoCue=cue:none,face:none,placement:none,dots:0,ancestryLinked:false,active:false,assetOutputs:none")
}

@Test func rendererSpriteKitFaceLineageEchoCueReadinessRequiresSafeAncestryState() {
    #expect(RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:forehead,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "none",
        face: "none",
        placement: "none",
        dotCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:none,face:none,placement:none,dots:0,ancestryLinked:false,active:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "",
        face: "softDeer",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:,face:softDeer,placement:forehead,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:,placement:forehead,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "forehead",
        dotCount: 0,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:forehead,dots:0,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: false,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:forehead,dots:3,ancestryLinked:false,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
        cue: "softForeheadMemoryDots",
        face: "softDeer",
        placement: "forehead",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "CoreImage",
        summary: "spriteKitFaceLineageEchoCue=cue:softForeheadMemoryDots,face:softDeer,placement:forehead,dots:3,ancestryLinked:true,active:true,assetOutputs:CoreImage"
    ))

    #expect(RendererMetadataSummary.spriteKitFaceLineageEchoCueReadinessSummary(isReady: true) == "spriteKitFaceLineageEchoCueReady:true")
    #expect(RendererMetadataSummary.spriteKitFaceLineageEchoCueReadinessSummary(isReady: false) == "spriteKitFaceLineageEchoCueReady:false")
}

@Test func rendererSpriteKitTailLineageEchoCueReadinessRequiresSafeAncestryState() {
    #expect(RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "none",
        tail: "none",
        placement: "none",
        dotCount: 0,
        ancestryLinked: false,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:none,tail:none,placement:none,dots:0,ancestryLinked:false,active:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:,placement:tailTip,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:,dots:3,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 1,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:1,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: false,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:false,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:true,active:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "CoreImage",
        summary: "spriteKitTailLineageEchoCue=cue:softTailMemoryDots,tail:floatingRibbon,placement:tailTip,dots:3,ancestryLinked:true,active:true,assetOutputs:CoreImage"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
        cue: "softTailMemoryDots",
        tail: "floatingRibbon",
        placement: "tailTip",
        dotCount: 3,
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitTailLineageEchoCueReadinessSummary(isReady: true) == "spriteKitTailLineageEchoCueReady:true")
    #expect(RendererMetadataSummary.spriteKitTailLineageEchoCueReadinessSummary(isReady: false) == "spriteKitTailLineageEchoCueReady:false")
}

@Test func rendererSpriteKitTailSilhouetteAccessoryCueSummaryReportsAccessoryLabels() {
    let fishSummary = RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueSummary(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let floatingSummary = RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueSummary(
        tail: "floatingRibbon",
        accessory: "softTetherDot",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let dragonSummary = RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueSummary(
        tail: "longDrake",
        accessory: "softDrakeRidge",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let plantSummary = RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueSummary(
        tail: "leafSprout",
        accessory: "softLeafVein",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(fishSummary == "spriteKitTailSilhouetteAccessory=tail:fishFin,accessory:softForkFin,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(floatingSummary == "spriteKitTailSilhouetteAccessory=tail:floatingRibbon,accessory:softTetherDot,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(dragonSummary == "spriteKitTailSilhouetteAccessory=tail:longDrake,accessory:softDrakeRidge,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(plantSummary == "spriteKitTailSilhouetteAccessory=tail:leafSprout,accessory:softLeafVein,visible:true,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererSpriteKitTailSilhouetteAccessoryCueReadinessRequiresExpectedAccessoryAndNoAssets() {
    let fishSummary = "spriteKitTailSilhouetteAccessory=tail:fishFin,accessory:softForkFin,visible:true,geometryGenerated:false,assetOutputs:none"
    let dragonSummary = "spriteKitTailSilhouetteAccessory=tail:longDrake,accessory:softDrakeRidge,visible:true,geometryGenerated:false,assetOutputs:none"
    let plantSummary = "spriteKitTailSilhouetteAccessory=tail:leafSprout,accessory:softLeafVein,visible:true,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fishSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "longDrake",
        accessory: "softDrakeRidge",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: dragonSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "leafSprout",
        accessory: "softLeafVein",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: plantSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "leafSprout",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: plantSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "longDrake",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: dragonSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fishSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "floatingRibbon",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fishSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: false,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fishSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: true,
        assetOutputs: "none",
        summary: fishSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "png",
        summary: fishSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: "fishFin",
        accessory: "softForkFin",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueReadinessSummary(isReady: true) == "spriteKitTailSilhouetteAccessoryReady:true")
    #expect(RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueReadinessSummary(isReady: false) == "spriteKitTailSilhouetteAccessoryReady:false")
}

@Test func rendererSpriteKitFishTailRecipeIntentSummaryNamesHandmadeRecipe() {
    let summary = RendererMetadataSummary.spriteKitFishTailRecipeIntentSummary(
        baseRecipe: "fishTaper",
        accessoryRecipe: "softForkFin",
        placement: "tailTip",
        silhouetteIntent: "secondarySilhouette",
        affectionIntent: "cuteMotionRoom",
        allowsSharpFin: false,
        labelOnly: false,
        geometryChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitFishTailRecipeIntent=base:fishTaper,accessory:softForkFin,placement:tailTip,silhouette:secondarySilhouette,affection:cuteMotionRoom,sharpFin:false,labelOnly:false,geometryChanged:false,assetOutputs:none")
}

@Test func rendererSpriteKitFishTailRecipeIntentReadinessRejectsSharpLabelsAndAssets() {
    let summary = "spriteKitFishTailRecipeIntent=base:fishTaper,accessory:softForkFin,placement:tailTip,silhouette:secondarySilhouette,affection:cuteMotionRoom,sharpFin:false,labelOnly:false,geometryChanged:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitFishTailRecipeIntentFields(
        baseRecipe: "fishTaper",
        accessoryRecipe: "softForkFin",
        placement: "tailTip",
        silhouetteIntent: "secondarySilhouette",
        affectionIntent: "cuteMotionRoom",
        allowsSharpFin: false,
        labelOnly: false,
        geometryChanged: false,
        assetOutputs: "none",
        summary: summary
    ))

    let rejectedCases = [
        ("dragonTaper", "softForkFin", "tailTip", "secondarySilhouette", "cuteMotionRoom", false, false, false, "none"),
        ("fishTaper", "softDrakeRidge", "tailTip", "secondarySilhouette", "cuteMotionRoom", false, false, false, "none"),
        ("fishTaper", "softForkFin", "tailRoot", "secondarySilhouette", "cuteMotionRoom", false, false, false, "none"),
        ("fishTaper", "softForkFin", "tailTip", "primaryBody", "cuteMotionRoom", false, false, false, "none"),
        ("fishTaper", "softForkFin", "tailTip", "secondarySilhouette", "rarityMarker", false, false, false, "none"),
        ("fishTaper", "softForkFin", "tailTip", "secondarySilhouette", "cuteMotionRoom", true, false, false, "none"),
        ("fishTaper", "softForkFin", "tailTip", "secondarySilhouette", "cuteMotionRoom", false, true, false, "none"),
        ("fishTaper", "softForkFin", "tailTip", "secondarySilhouette", "cuteMotionRoom", false, false, true, "none"),
        ("fishTaper", "softForkFin", "tailTip", "secondarySilhouette", "cuteMotionRoom", false, false, false, "png")
    ]

    for rejected in rejectedCases {
        #expect(!RendererMetadataSummary.hasSpriteKitFishTailRecipeIntentFields(
            baseRecipe: rejected.0,
            accessoryRecipe: rejected.1,
            placement: rejected.2,
            silhouetteIntent: rejected.3,
            affectionIntent: rejected.4,
            allowsSharpFin: rejected.5,
            labelOnly: rejected.6,
            geometryChanged: rejected.7,
            assetOutputs: rejected.8,
            summary: summary
        ))
    }
    #expect(!RendererMetadataSummary.hasSpriteKitFishTailRecipeIntentFields(
        baseRecipe: "fishTaper",
        accessoryRecipe: "softForkFin",
        placement: "tailTip",
        silhouetteIntent: "secondarySilhouette",
        affectionIntent: "cuteMotionRoom",
        allowsSharpFin: false,
        labelOnly: false,
        geometryChanged: false,
        assetOutputs: "none",
        summary: ""
    ))
    #expect(RendererMetadataSummary.spriteKitFishTailRecipeIntentReadinessSummary(isReady: true) == "spriteKitFishTailRecipeIntentReady:true")
    #expect(RendererMetadataSummary.spriteKitFishTailRecipeIntentReadinessSummary(isReady: false) == "spriteKitFishTailRecipeIntentReady:false")
}

@Test func rendererSpriteKitWingSilhouetteAccessoryCueSummaryReportsAccessoryLabels() {
    let fairySummary = RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueSummary(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let dragonSummary = RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueSummary(
        wing: "wideSail",
        accessory: "softWingTipClaw",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(fairySummary == "spriteKitWingSilhouetteAccessory=wing:leafPair,accessory:softWingTipPearl,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(dragonSummary == "spriteKitWingSilhouetteAccessory=wing:wideSail,accessory:softWingTipClaw,visible:true,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererSpriteKitWingSilhouetteAccessoryCueReadinessRequiresExpectedAccessoryAndNoAssets() {
    let fairySummary = "spriteKitWingSilhouetteAccessory=wing:leafPair,accessory:softWingTipPearl,visible:true,geometryGenerated:false,assetOutputs:none"
    let noneSummary = "spriteKitWingSilhouetteAccessory=wing:softLunar,accessory:none,visible:true,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fairySummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "softLunar",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: noneSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fairySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "wideSail",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fairySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: false,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: fairySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: true,
        assetOutputs: "none",
        summary: fairySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "png",
        summary: fairySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: "leafPair",
        accessory: "softWingTipPearl",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueReadinessSummary(isReady: true) == "spriteKitWingSilhouetteAccessoryReady:true")
    #expect(RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueReadinessSummary(isReady: false) == "spriteKitWingSilhouetteAccessoryReady:false")
}

@Test func rendererSpriteKitLineageVisualEchoPairSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitLineageVisualEchoPairSummary(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitLineageVisualEchoPairSummary(
        bodyCue: "none",
        tailCue: "none",
        ancestryLinked: false,
        activeCueCount: 0,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:2,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitLineageVisualEchoPair=body:none,tail:none,ancestryLinked:false,activeCueCount:0,assetOutputs:none")
}

@Test func rendererSpriteKitLineageVisualEchoPairReadinessRequiresSafePairedState() {
    #expect(RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:2,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "none",
        tailCue: "none",
        ancestryLinked: false,
        activeCueCount: 0,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:none,tail:none,ancestryLinked:false,activeCueCount:0,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:2,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:,ancestryLinked:true,activeCueCount:2,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "none",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 1,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:none,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:1,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: false,
        activeCueCount: 2,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:softTailMemoryDots,ancestryLinked:false,activeCueCount:2,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 1,
        assetOutputs: "none",
        summary: "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:1,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "CoreImage",
        summary: "spriteKitLineageVisualEchoPair=body:softAncestralGlint,tail:softTailMemoryDots,ancestryLinked:true,activeCueCount:2,assetOutputs:CoreImage"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        ancestryLinked: true,
        activeCueCount: 2,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitLineageVisualEchoPairReadinessSummary(isReady: true) == "spriteKitLineageVisualEchoPairReady:true")
    #expect(RendererMetadataSummary.spriteKitLineageVisualEchoPairReadinessSummary(isReady: false) == "spriteKitLineageVisualEchoPairReady:false")
}

@Test func rendererSpriteKitLineageMemoryThreadSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitLineageMemoryThreadSummary(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitLineageMemoryThreadSummary(
        cue: "none",
        bodyCue: "none",
        tailCue: "none",
        placement: "none",
        ancestryLinked: false,
        active: false,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitLineageMemoryThread=cue:none,body:none,tail:none,placement:none,ancestryLinked:false,active:false,assetOutputs:none")
}

@Test func rendererSpriteKitLineageMemoryThreadReadinessRequiresSafeThreadState() {
    #expect(RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "none",
        bodyCue: "none",
        tailCue: "none",
        placement: "none",
        ancestryLinked: false,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:none,body:none,tail:none,placement:none,ancestryLinked:false,active:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:,ancestryLinked:true,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: false,
        active: true,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:false,active:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: false,
        assetOutputs: "none",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "CoreImage",
        summary: "spriteKitLineageMemoryThread=cue:softLineageMemoryThread,body:softAncestralGlint,tail:softTailMemoryDots,placement:bodyToTail,ancestryLinked:true,active:true,assetOutputs:CoreImage"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
        cue: "softLineageMemoryThread",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        placement: "bodyToTail",
        ancestryLinked: true,
        active: true,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitLineageMemoryThreadReadinessSummary(isReady: true) == "spriteKitLineageMemoryThreadReady:true")
    #expect(RendererMetadataSummary.spriteKitLineageMemoryThreadReadinessSummary(isReady: false) == "spriteKitLineageMemoryThreadReady:false")
}

@Test func rendererSpriteKitLineageCueSetSummaryReportsActiveAndInactiveStates() {
    let activeSummary = RendererMetadataSummary.spriteKitLineageCueSetSummary(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none"
    )
    let inactiveSummary = RendererMetadataSummary.spriteKitLineageCueSetSummary(
        surface: "observationHome",
        bodyCue: "none",
        tailCue: "none",
        threadCue: "none",
        ancestryLinked: false,
        activeCueCount: 0,
        visibleInObservation: false,
        controlsEnabled: false,
        assetOutputs: "none"
    )

    #expect(activeSummary == "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:none")
    #expect(inactiveSummary == "spriteKitLineageCueSet=surface:observationHome,body:none,tail:none,thread:none,ancestryLinked:false,activeCueCount:0,visibleInObservation:false,controls:false,assetOutputs:none")
}

@Test func rendererSpriteKitLineageCueSetReadinessRequiresCompleteVisibleSetWithoutControls() {
    #expect(RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:none"
    ))
    #expect(RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "none",
        tailCue: "none",
        threadCue: "none",
        ancestryLinked: false,
        activeCueCount: 0,
        visibleInObservation: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:none,tail:none,thread:none,ancestryLinked:false,activeCueCount:0,visibleInObservation:false,controls:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "none",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 2,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:none,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:2,visibleInObservation:true,controls:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: false,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:false,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:false,controls:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: true,
        assetOutputs: "none",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "CoreImage",
        summary: "spriteKitLineageCueSet=surface:observationHome,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:3,visibleInObservation:true,controls:false,assetOutputs:CoreImage"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
        surface: "observationHome",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInObservation: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitLineageCueSetReadinessSummary(isReady: true) == "spriteKitLineageCueSetReady:true")
    #expect(RendererMetadataSummary.spriteKitLineageCueSetReadinessSummary(isReady: false) == "spriteKitLineageCueSetReady:false")
}

@Test func rendererSpriteKitChildDraftLineageCueSetSummaryReportsVisibleDraftEcho() {
    let summary = RendererMetadataSummary.spriteKitChildDraftLineageCueSetSummary(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitChildDraftLineageCueSet=surface:genomeVariationChildDraft,source:genomeVariationQA,face:softDeer,faceAccent:forestDots,wing:leafPair,wingAccessory:softWingTipPearl,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:5,visibleInDraftPortrait:true,persistence:false,breeding:false,controls:false,assetOutputs:none")
}

@Test func rendererSpriteKitChildDraftLineageCueSetReadinessRequiresVisibleSafeCueSet() {
    let summary = "spriteKitChildDraftLineageCueSet=surface:genomeVariationChildDraft,source:genomeVariationQA,face:softDeer,faceAccent:forestDots,wing:leafPair,wingAccessory:softWingTipPearl,body:softAncestralGlint,tail:softTailMemoryDots,thread:softLineageMemoryThread,ancestryLinked:true,activeCueCount:5,visibleInDraftPortrait:true,persistence:false,breeding:false,controls:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "observationHome",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "lineageFamilyQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softFeline",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "cheekGleam",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "softLunar",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "none",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "none",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: false,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 3,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: false,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: true,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: true,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitChildDraftLineageCueSetFields(
        surface: "genomeVariationChildDraft",
        source: "genomeVariationQA",
        faceCue: "softDeer",
        faceAccent: "forestDots",
        wingCue: "leafPair",
        wingAccessory: "softWingTipPearl",
        bodyCue: "softAncestralGlint",
        tailCue: "softTailMemoryDots",
        threadCue: "softLineageMemoryThread",
        ancestryLinked: true,
        activeCueCount: 5,
        visibleInDraftPortrait: true,
        allowsPersistenceWrite: false,
        allowsBreedingControls: false,
        controlsEnabled: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitChildDraftLineageCueSetReadinessSummary(isReady: true) == "spriteKitChildDraftLineageCueSetReady:true")
    #expect(RendererMetadataSummary.spriteKitChildDraftLineageCueSetReadinessSummary(isReady: false) == "spriteKitChildDraftLineageCueSetReady:false")
}

@Test func rendererSpriteKitGrowthStageCueSummaryReportsStageScaleAndPosture() {
    let summary = RendererMetadataSummary.spriteKitGrowthStageCueSummary(
        stage: "adult",
        scale: "grown",
        posture: "settled",
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitGrowthStageCue=stage:adult,scale:grown,posture:settled,assetOutputs:none")
}

@Test func rendererSpriteKitGrowthStageCueReadinessRequiresAllFields() {
    #expect(RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
        stage: "adult",
        scale: "grown",
        posture: "settled",
        assetOutputs: "none",
        summary: "spriteKitGrowthStageCue=stage:adult,scale:grown,posture:settled,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
        stage: "",
        scale: "grown",
        posture: "settled",
        assetOutputs: "none",
        summary: "spriteKitGrowthStageCue=stage:,scale:grown,posture:settled,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
        stage: "adult",
        scale: "",
        posture: "settled",
        assetOutputs: "none",
        summary: "spriteKitGrowthStageCue=stage:adult,scale:,posture:settled,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
        stage: "adult",
        scale: "grown",
        posture: "",
        assetOutputs: "none",
        summary: "spriteKitGrowthStageCue=stage:adult,scale:grown,posture:,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
        stage: "adult",
        scale: "grown",
        posture: "settled",
        assetOutputs: "generatedMesh",
        summary: "spriteKitGrowthStageCue=stage:adult,scale:grown,posture:settled,assetOutputs:generatedMesh"
    ))

    #expect(RendererMetadataSummary.spriteKitGrowthStageCueReadinessSummary(isReady: true) == "spriteKitGrowthStageCueReady:true")
    #expect(RendererMetadataSummary.spriteKitGrowthStageCueReadinessSummary(isReady: false) == "spriteKitGrowthStageCueReady:false")
}

@Test func rendererSpriteKitGrowthHornBudCueSummaryReportsSoftMetadataOnlyBud() {
    let summary = RendererMetadataSummary.spriteKitGrowthHornBudCueSummary(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitGrowthHornBudCue=gene:hornGrowth,bud:tinyRoundedBud,stage:juvenile,softness:rounded,visible:true,assetOutputs:none")
}

@Test func rendererSpriteKitGrowthHornBudCueReadinessRequiresDormantHiddenOrSoftVisibleBud() {
    let readyVisibleSummary = "spriteKitGrowthHornBudCue=gene:hornGrowth,bud:tinyRoundedBud,stage:juvenile,softness:rounded,visible:true,assetOutputs:none"
    let readyCrescentSummary = "spriteKitGrowthHornBudCue=gene:hornGrowth,bud:softCrescentBud,stage:adult,softness:rounded,visible:true,assetOutputs:none"
    let readyDormantSummary = "spriteKitGrowthHornBudCue=gene:hornGrowth,bud:dormantBud,stage:juvenile,softness:rounded,visible:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "softCrescentBud",
        stage: "adult",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyCrescentSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "dormantBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: false,
        assetOutputs: "none",
        summary: readyDormantSummary
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "wingGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "sharpHorn",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "sharp",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: false,
        assetOutputs: "none",
        summary: readyVisibleSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "dormantBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readyDormantSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
        gene: "hornGrowth",
        bud: "tinyRoundedBud",
        stage: "juvenile",
        softness: "rounded",
        visibleInPortrait: true,
        assetOutputs: "generatedMesh",
        summary: readyVisibleSummary
    ))

    #expect(RendererMetadataSummary.spriteKitGrowthHornBudCueReadinessSummary(isReady: true) == "spriteKitGrowthHornBudCueReady:true")
    #expect(RendererMetadataSummary.spriteKitGrowthHornBudCueReadinessSummary(isReady: false) == "spriteKitGrowthHornBudCueReady:false")
}

@Test func rendererGrowthHornBudCeremonyPreviewSummaryReportsPreviewOnlyBudBridge() {
    let summary = RendererMetadataSummary.growthHornBudCeremonyPreviewSummary(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none"
    )

    #expect(summary == "growthHornBudCeremonyPreview=current:dormantBud,next:tinyRoundedBud,visible:false,allowsMutation:false,widgetHandoffAllowed:false,discoveryAppend:false,assetOutputs:none")
}

@Test func rendererGrowthHornBudCeremonyPreviewReadinessRequiresNoMutationWidgetDiscoveryOrAssets() {
    let readySummary = "growthHornBudCeremonyPreview=current:dormantBud,next:tinyRoundedBud,visible:false,allowsMutation:false,widgetHandoffAllowed:false,discoveryAppend:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))

    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: true,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: true,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: true,
        appendsDiscovery: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasGrowthHornBudCeremonyPreviewFields(
        currentBud: "dormantBud",
        nextBud: "tinyRoundedBud",
        visibleInCeremony: false,
        allowsMutation: false,
        widgetHandoffAllowed: false,
        appendsDiscovery: false,
        assetOutputs: "generatedMesh",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.growthHornBudCeremonyPreviewReadinessSummary(isReady: true) == "growthHornBudCeremonyPreviewReady:true")
    #expect(RendererMetadataSummary.growthHornBudCeremonyPreviewReadinessSummary(isReady: false) == "growthHornBudCeremonyPreviewReady:false")
}

@Test func rendererSpriteKitGrowthTailTipCueSummaryReportsTailGrowthGlintCue() {
    let summary = RendererMetadataSummary.spriteKitGrowthTailTipCueSummary(
        gene: "tailGrowth",
        cue: "softTailTipGlint",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: true,
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitGrowthTailTipCue=gene:tailGrowth,cue:softTailTipGlint,tail:floatingRibbon,placement:tailTip,visible:true,assetOutputs:none")
}

@Test func rendererSpriteKitGrowthTailTipCueReadinessRequiresTailGrowthAndNoAssets() {
    let readySummary = "spriteKitGrowthTailTipCue=gene:tailGrowth,cue:softTailTipGlint,tail:floatingRibbon,placement:tailTip,visible:true,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "tailGrowth",
        cue: "softTailTipGlint",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "tailGrowth",
        cue: "restingTailTip",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: false,
        assetOutputs: "none",
        summary: readySummary
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "hornGrowth",
        cue: "softTailTipGlint",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "tailGrowth",
        cue: "softTailTipGlint",
        tail: "",
        placement: "tailTip",
        visibleInPortrait: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "tailGrowth",
        cue: "softTailTipGlint",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
        gene: "tailGrowth",
        cue: "softTailTipGlint",
        tail: "floatingRibbon",
        placement: "tailTip",
        visibleInPortrait: true,
        assetOutputs: "generatedMesh",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.spriteKitGrowthTailTipCueReadinessSummary(isReady: true) == "spriteKitGrowthTailTipCueReady:true")
    #expect(RendererMetadataSummary.spriteKitGrowthTailTipCueReadinessSummary(isReady: false) == "spriteKitGrowthTailTipCueReady:false")
}

@Test func rendererFixedPartHornBaseSocketSpecSummaryReportsRoundedHiddenArtDirectionGate() {
    let summary = RendererMetadataSummary.fixedPartHornBaseSocketSpecSummary(
        variants: ["dormantBud", "tinyRoundedBud", "softCrescentBud"],
        socketIDs: ["headTopCenter", "headTopPair"],
        rigTargets: ["horn_L", "horn_R"],
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartHornBaseSocketSpec=variants:dormantBud+tinyRoundedBud+softCrescentBud,sockets:headTopCenter+headTopPair,rig:horn_L+horn_R,silhouette:roundedNonSharp,visible:false,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererFixedPartHornBaseSocketSpecReadinessRequiresRoundedSocketsRigAndNoAssets() {
    let variants = ["dormantBud", "tinyRoundedBud", "softCrescentBud"]
    let sockets = ["headTopCenter", "headTopPair"]
    let rigTargets = ["horn_L", "horn_R"]
    let readySummary = "fixedPartHornBaseSocketSpec=variants:dormantBud+tinyRoundedBud+softCrescentBud,sockets:headTopCenter+headTopPair,rig:horn_L+horn_R,silhouette:roundedNonSharp,visible:false,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: ["dormantBud", "tinyRoundedBud"],
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: ["headTopCenter"],
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: ["horn_L"],
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "sharpAntler",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: true,
        generatedGeometry: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseSocketSpecFields(
        variants: variants,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        visibleInPortrait: false,
        generatedGeometry: false,
        assetOutputs: "glb",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.fixedPartHornBaseSocketSpecReadinessSummary(isReady: true) == "fixedPartHornBaseSocketSpecReady:true")
    #expect(RendererMetadataSummary.fixedPartHornBaseSocketSpecReadinessSummary(isReady: false) == "fixedPartHornBaseSocketSpecReady:false")
}

@Test func rendererFixedPartHornBaseReferenceEvidenceHandoffSummaryReportsAcceptedBudEvidenceSlots() {
    let summary = RendererMetadataSummary.fixedPartHornBaseReferenceEvidenceHandoffSummary(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram"],
        socketIDs: ["headTopCenter", "headTopPair"],
        rigTargets: ["horn_L", "horn_R"],
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartHornBaseReferenceEvidenceHandoff=v1;cue:tinyRoundedHornBud;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram;sockets:headTopCenter+headTopPair;rig:horn_L+horn_R;silhouette:roundedNonSharp;manualQA:true;evidenceRecorded:false;geometryGenerated:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartHornBaseReferenceEvidenceHandoffReadinessRequiresAcceptedManualQAAndNoAssets() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram"]
    let sockets = ["headTopCenter", "headTopPair"]
    let rigTargets = ["horn_L", "horn_R"]
    let readySummary = "fixedPartHornBaseReferenceEvidenceHandoff=v1;cue:tinyRoundedHornBud;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram;sockets:headTopCenter+headTopPair;rig:horn_L+horn_R;silhouette:roundedNonSharp;manualQA:true;evidenceRecorded:false;geometryGenerated:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "sharpHorn",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: ["frontView", "socketDiagram", "rigDiagram"],
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: ["headTopCenter"],
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: ["horn_L"],
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "sharpAntler",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: false,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: true,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: true,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: "tinyRoundedHornBud",
        requiredPanels: panels,
        socketIDs: sockets,
        rigTargets: rigTargets,
        silhouetteRule: "roundedNonSharp",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary(isReady: true) == "fixedPartHornBaseReferenceEvidenceHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary(isReady: false) == "fixedPartHornBaseReferenceEvidenceHandoffReady:false")
}

@Test func rendererGrowthBeforeAfterPortraitSurfaceSummaryReportsPreviewSafety() {
    let summary = RendererMetadataSummary.growthBeforeAfterPortraitSurfaceSummary(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none"
    )

    #expect(summary == "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none")
}

@Test func rendererGrowthBeforeAfterPortraitSurfaceReadinessRequiresSafePreviewFields() {
    #expect(RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: true,
        widgetHandoffAllowed: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:true,widgetHandoffAllowed:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: true,
        assetOutputs: "none",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: "juvenile",
        nextStage: "adult",
        currentCue: "youthful",
        nextCue: "grown",
        allowsMutation: false,
        widgetHandoffAllowed: false,
        assetOutputs: "snapshotImage",
        summary: "growthBeforeAfterPortraitSurface=current:juvenile,next:adult,currentCue:youthful,nextCue:grown,allowsMutation:false,widgetHandoffAllowed:false,assetOutputs:snapshotImage"
    ))

    #expect(RendererMetadataSummary.growthBeforeAfterPortraitSurfaceReadinessSummary(isReady: true) == "growthBeforeAfterPortraitSurfaceReady:true")
    #expect(RendererMetadataSummary.growthBeforeAfterPortraitSurfaceReadinessSummary(isReady: false) == "growthBeforeAfterPortraitSurfaceReady:false")
}

@Test func rendererGrowthBeforeAfterStageCuePairSummaryReportsCurrentAndNextCues() {
    let summary = RendererMetadataSummary.growthBeforeAfterStageCuePairSummary(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none"
    )

    #expect(summary == "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:none")
}

@Test func rendererGrowthBeforeAfterStageCuePairReadinessRequiresSafePreviewFields() {
    #expect(RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:+familiar+soft,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile++soft,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:+grown+settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult++settled,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+,previewOnly:true,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: false,
        allowsMutation: false,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+settled,previewOnly:false,mutation:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: true,
        assetOutputs: "none",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+settled,previewOnly:true,mutation:true,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasGrowthBeforeAfterStageCuePairFields(
        currentStage: "juvenile",
        currentScale: "familiar",
        currentPosture: "soft",
        nextStage: "adult",
        nextScale: "grown",
        nextPosture: "settled",
        previewOnly: true,
        allowsMutation: false,
        assetOutputs: "generatedMesh",
        summary: "growthBeforeAfterStageCuePair=current:juvenile+familiar+soft,next:adult+grown+settled,previewOnly:true,mutation:false,assetOutputs:generatedMesh"
    ))

    #expect(RendererMetadataSummary.growthBeforeAfterStageCuePairReadinessSummary(isReady: true) == "growthBeforeAfterStageCuePairReady:true")
    #expect(RendererMetadataSummary.growthBeforeAfterStageCuePairReadinessSummary(isReady: false) == "growthBeforeAfterStageCuePairReady:false")
}

@Test func rendererSpriteKitMotionGeneCueSummaryReportsMotionLabels() {
    let summary = RendererMetadataSummary.spriteKitMotionGeneCueSummary(
        float: "drifting",
        blink: "softBlink",
        tail: "softSway",
        wing: "livelyFlutter",
        wingFlutter: "3.16deg/1.896s",
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitMotionGeneCue=float:drifting,blink:softBlink,tail:softSway,wing:livelyFlutter,wingFlutter:3.16deg/1.896s,assetOutputs:none")
}

@Test func rendererSpriteKitMotionGeneCueReadinessRequiresAllFields() {
    #expect(RendererMetadataSummary.hasSpriteKitMotionGeneCueFields(
        float: "drifting",
        blink: "softBlink",
        tail: "softSway",
        wing: "livelyFlutter",
        wingFlutter: "3.16deg/1.896s",
        assetOutputs: "none",
        summary: "spriteKitMotionGeneCue=float:drifting,blink:softBlink,tail:softSway,wing:livelyFlutter,wingFlutter:3.16deg/1.896s,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitMotionGeneCueFields(
        float: "drifting",
        blink: "softBlink",
        tail: "softSway",
        wing: "",
        wingFlutter: "3.16deg/1.896s",
        assetOutputs: "none",
        summary: "spriteKitMotionGeneCue=float:drifting,blink:softBlink,tail:softSway,wing:,wingFlutter:3.16deg/1.896s,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitMotionGeneCueReadinessSummary(isReady: true) == "spriteKitMotionGeneCueReady:true")
    #expect(RendererMetadataSummary.spriteKitMotionGeneCueReadinessSummary(isReady: false) == "spriteKitMotionGeneCueReady:false")
}

@Test func rendererSpriteKitSilhouetteCueSummaryReportsNamedCues() {
    let summary = RendererMetadataSummary.spriteKitSilhouetteCueSummary(
        face: "faceted",
        body: "moonOval",
        wing: "none",
        tail: "floatingRibbon",
        visibleCueCount: 3
    )

    #expect(summary == "spriteKitSilhouetteCue=face:faceted,body:moonOval,wing:none,tail:floatingRibbon,visibleCueCount:3")
}

@Test func rendererSpriteKitSilhouetteCueSummaryReportsOptionalWingCue() {
    let summary = RendererMetadataSummary.spriteKitSilhouetteCueSummary(
        face: "smallFairy",
        body: "seedPetal",
        wing: "leafPair",
        tail: "fishFin",
        visibleCueCount: 4
    )

    #expect(summary == "spriteKitSilhouetteCue=face:smallFairy,body:seedPetal,wing:leafPair,tail:fishFin,visibleCueCount:4")
}

@Test func rendererSpriteKitSilhouetteCueMetadataReadinessRequiresAllFields() {
    #expect(RendererMetadataSummary.hasSpriteKitSilhouetteCueFields(
        face: "smallFairy",
        body: "seedPetal",
        wing: "leafPair",
        tail: "fishFin",
        visibleCueCount: 4,
        summary: "spriteKitSilhouetteCue=face:smallFairy,body:seedPetal,wing:leafPair,tail:fishFin,visibleCueCount:4"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitSilhouetteCueFields(
        face: "smallFairy",
        body: "seedPetal",
        wing: "",
        tail: "fishFin",
        visibleCueCount: 4,
        summary: "spriteKitSilhouetteCue=face:smallFairy,body:seedPetal,wing:,tail:fishFin,visibleCueCount:4"
    ))

    #expect(RendererMetadataSummary.spriteKitSilhouetteCueReadinessSummary(isReady: true) == "spriteKitSilhouetteCueMetadataReady:true")
    #expect(RendererMetadataSummary.spriteKitSilhouetteCueReadinessSummary(isReady: false) == "spriteKitSilhouetteCueMetadataReady:false")
}

@Test func rendererSpriteKitWingCueAccentSummaryReportsWingCueAccent() {
    let lumaSummary = RendererMetadataSummary.spriteKitWingCueAccentSummary(
        wing: "none",
        accent: "none",
        socketChanged: false,
        assetOutputs: "none"
    )
    let miraSummary = RendererMetadataSummary.spriteKitWingCueAccentSummary(
        wing: "leafPair",
        accent: "softVein",
        socketChanged: false,
        assetOutputs: "none"
    )

    #expect(lumaSummary == "spriteKitWingCueAccent=wing:none,accent:none,socketChanged:false,assetOutputs:none")
    #expect(miraSummary == "spriteKitWingCueAccent=wing:leafPair,accent:softVein,socketChanged:false,assetOutputs:none")
}

@Test func rendererSpriteKitWingCueAccentReadinessRequiresCueAccentAndSummary() {
    #expect(RendererMetadataSummary.hasSpriteKitWingCueAccentFields(
        wing: "leafPair",
        accent: "softVein",
        assetOutputs: "none",
        summary: "spriteKitWingCueAccent=wing:leafPair,accent:softVein,socketChanged:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitWingCueAccentFields(
        wing: "leafPair",
        accent: "",
        assetOutputs: "none",
        summary: "spriteKitWingCueAccent=wing:leafPair,accent:,socketChanged:false,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitWingCueAccentReadinessSummary(isReady: true) == "spriteKitWingCueAccentReady:true")
    #expect(RendererMetadataSummary.spriteKitWingCueAccentReadinessSummary(isReady: false) == "spriteKitWingCueAccentReady:false")
}

@Test func rendererSpriteKitBodyCueAccentSummaryReportsBodyCueAccent() {
    let lumaSummary = RendererMetadataSummary.spriteKitBodyCueAccentSummary(
        body: "moonOval",
        accent: "crescentBelly",
        socketChanged: false,
        assetOutputs: "none"
    )
    let miraSummary = RendererMetadataSummary.spriteKitBodyCueAccentSummary(
        body: "seedPetal",
        accent: "petalChest",
        socketChanged: false,
        assetOutputs: "none"
    )

    #expect(lumaSummary == "spriteKitBodyCueAccent=body:moonOval,accent:crescentBelly,socketChanged:false,assetOutputs:none")
    #expect(miraSummary == "spriteKitBodyCueAccent=body:seedPetal,accent:petalChest,socketChanged:false,assetOutputs:none")
}

@Test func rendererSpriteKitBodyCueAccentReadinessRequiresCueAccentAndSummary() {
    #expect(RendererMetadataSummary.hasSpriteKitBodyCueAccentFields(
        body: "moonOval",
        accent: "crescentBelly",
        assetOutputs: "none",
        summary: "spriteKitBodyCueAccent=body:moonOval,accent:crescentBelly,socketChanged:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitBodyCueAccentFields(
        body: "",
        accent: "crescentBelly",
        assetOutputs: "none",
        summary: "spriteKitBodyCueAccent=body:,accent:crescentBelly,socketChanged:false,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitBodyCueAccentReadinessSummary(isReady: true) == "spriteKitBodyCueAccentReady:true")
    #expect(RendererMetadataSummary.spriteKitBodyCueAccentReadinessSummary(isReady: false) == "spriteKitBodyCueAccentReady:false")
}

@Test func rendererSpriteKitBodyProportionCueSummaryReportsFamilyShapeLabels() {
    let summary = RendererMetadataSummary.spriteKitBodyProportionCueSummary(
        body: "moonOval",
        width: "moonBalanced",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(summary == "spriteKitBodyProportionCue=body:moonOval,width:moonBalanced,height:quietOval,affection:familiarMoonBelly,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererSpriteKitBodyProportionCueReadinessRequiresHandmadeProportionLabels() {
    let summary = "spriteKitBodyProportionCue=body:moonOval,width:moonBalanced,height:quietOval,affection:familiarMoonBelly,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
        body: "moonOval",
        width: "moonBalanced",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
        body: "",
        width: "moonBalanced",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
        body: "moonOval",
        width: "",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
        body: "moonOval",
        width: "moonBalanced",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
        body: "moonOval",
        width: "moonBalanced",
        height: "quietOval",
        affection: "familiarMoonBelly",
        geometryGenerated: false,
        assetOutputs: "generatedBodyMesh",
        summary: summary
    ))
    #expect(RendererMetadataSummary.spriteKitBodyProportionCueReadinessSummary(isReady: true) == "spriteKitBodyProportionCueReady:true")
    #expect(RendererMetadataSummary.spriteKitBodyProportionCueReadinessSummary(isReady: false) == "spriteKitBodyProportionCueReady:false")
}

@Test func rendererSpriteKitBodySilhouetteAccessoryCueSummaryReportsAccessoryLabels() {
    let sylphianSummary = RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueSummary(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let verdantSummary = RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueSummary(
        body: "leafBelly",
        accessory: "leafShoulderNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let lunarianSummary = RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueSummary(
        body: "moonOval",
        accessory: "softMoonShoulderCrescents",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(sylphianSummary == "spriteKitBodySilhouetteAccessory=body:seedPetal,accessory:softShoulderPetals,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(verdantSummary == "spriteKitBodySilhouetteAccessory=body:leafBelly,accessory:leafShoulderNubs,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(lunarianSummary == "spriteKitBodySilhouetteAccessory=body:moonOval,accessory:softMoonShoulderCrescents,visible:true,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererSpriteKitBodySilhouetteAccessoryCueReadinessRequiresExpectedAccessoryAndNoAssets() {
    let sylphianSummary = "spriteKitBodySilhouetteAccessory=body:seedPetal,accessory:softShoulderPetals,visible:true,geometryGenerated:false,assetOutputs:none"
    let lunarianSummary = "spriteKitBodySilhouetteAccessory=body:moonOval,accessory:softMoonShoulderCrescents,visible:true,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: sylphianSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "moonOval",
        accessory: "softMoonShoulderCrescents",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: lunarianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "moonOval",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: lunarianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: sylphianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "leafBelly",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: sylphianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: false,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: sylphianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: true,
        assetOutputs: "none",
        summary: sylphianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "png",
        summary: sylphianSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: "seedPetal",
        accessory: "softShoulderPetals",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueReadinessSummary(isReady: true) == "spriteKitBodySilhouetteAccessoryReady:true")
    #expect(RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueReadinessSummary(isReady: false) == "spriteKitBodySilhouetteAccessoryReady:false")
}

@Test func rendererSpriteKitFaceCueAccentSummaryReportsFaceCueAccent() {
    let lumaSummary = RendererMetadataSummary.spriteKitFaceCueAccentSummary(
        face: "faceted",
        accent: "softFacet",
        dotCount: 0,
        socketChanged: false,
        assetOutputs: "none"
    )
    let miraSummary = RendererMetadataSummary.spriteKitFaceCueAccentSummary(
        face: "smallFairy",
        accent: "cheekGleam",
        dotCount: 0,
        socketChanged: false,
        assetOutputs: "none"
    )

    #expect(lumaSummary == "spriteKitFaceCueAccent=face:faceted,accent:softFacet,dots:0,socketChanged:false,assetOutputs:none")
    #expect(miraSummary == "spriteKitFaceCueAccent=face:smallFairy,accent:cheekGleam,dots:0,socketChanged:false,assetOutputs:none")
}

@Test func rendererSpriteKitFaceCueAccentReadinessRequiresCueAccentAndSummary() {
    #expect(RendererMetadataSummary.hasSpriteKitFaceCueAccentFields(
        face: "faceted",
        accent: "softFacet",
        dotCount: 0,
        assetOutputs: "none",
        summary: "spriteKitFaceCueAccent=face:faceted,accent:softFacet,dots:0,socketChanged:false,assetOutputs:none"
    ))

    #expect(!RendererMetadataSummary.hasSpriteKitFaceCueAccentFields(
        face: "",
        accent: "softFacet",
        dotCount: 0,
        assetOutputs: "none",
        summary: "spriteKitFaceCueAccent=face:,accent:softFacet,dots:0,socketChanged:false,assetOutputs:none"
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceCueAccentFields(
        face: "softDeer",
        accent: "forestDots",
        dotCount: 6,
        assetOutputs: "none",
        summary: "spriteKitFaceCueAccent=face:softDeer,accent:forestDots,dots:6,socketChanged:false,assetOutputs:none"
    ))

    #expect(RendererMetadataSummary.spriteKitFaceCueAccentReadinessSummary(isReady: true) == "spriteKitFaceCueAccentReady:true")
    #expect(RendererMetadataSummary.spriteKitFaceCueAccentReadinessSummary(isReady: false) == "spriteKitFaceCueAccentReady:false")
}

@Test func rendererSpriteKitFaceSilhouetteAccessoryCueSummaryReportsAccessoryLabels() {
    let deerSummary = RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueSummary(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )
    let felineSummary = RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueSummary(
        face: "softFeline",
        accessory: "softEarTips",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(deerSummary == "spriteKitFaceSilhouetteAccessory=face:softDeer,accessory:softEarNubs,visible:true,geometryGenerated:false,assetOutputs:none")
    #expect(felineSummary == "spriteKitFaceSilhouetteAccessory=face:softFeline,accessory:softEarTips,visible:true,geometryGenerated:false,assetOutputs:none")
}

@Test func rendererSpriteKitFaceSilhouetteAccessoryCueReadinessRequiresExpectedAccessoryAndNoAssets() {
    let deerSummary = "spriteKitFaceSilhouetteAccessory=face:softDeer,accessory:softEarNubs,visible:true,geometryGenerated:false,assetOutputs:none"
    let noneSummary = "spriteKitFaceSilhouetteAccessory=face:faceted,accessory:none,visible:true,geometryGenerated:false,assetOutputs:none"

    #expect(RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: deerSummary
    ))
    #expect(RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "faceted",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: noneSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "none",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: deerSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softFeline",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: deerSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: false,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: deerSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: true,
        assetOutputs: "none",
        summary: deerSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "png",
        summary: deerSummary
    ))
    #expect(!RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: "softDeer",
        accessory: "softEarNubs",
        visibleInPortrait: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueReadinessSummary(isReady: true) == "spriteKitFaceSilhouetteAccessoryReady:true")
    #expect(RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueReadinessSummary(isReady: false) == "spriteKitFaceSilhouetteAccessoryReady:false")
}

@Test func rendererGenomeVariationSilhouetteCueSetAcceptanceSummarizesAcceptedCueSet() {
    let summary = RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceSummary(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "genomeVariationSilhouetteCueSetAcceptance=surface:genomeVariationQA,face:spriteKitFaceSilhouetteAccessoryReady:true,body:spriteKitBodySilhouetteAccessoryReady:true,wing:spriteKitWingSilhouetteAccessoryReady:true,tail:spriteKitTailSilhouetteAccessoryReady:true,manualQA:true,snapshotReference:false,technicalMetadata:false,appBehaviorChanged:false,assetOutputs:none,ready:true")
    #expect(RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceReadinessSummary(isReady: true) == "genomeVariationSilhouetteCueSetAcceptanceReady:true")
    #expect(RendererMetadataSummary.genomeVariationSilhouetteCueSetAcceptanceReadinessSummary(isReady: false) == "genomeVariationSilhouetteCueSetAcceptanceReady:false")
}

@Test func rendererGenomeVariationSilhouetteCueSetAcceptanceRequiresReadyCueSetAndNoSnapshotSideEffects() {
    #expect(RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "lineageFamilyQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:false",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:false",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:false",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:false",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: false,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: true,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: true,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: true,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: "genomeVariationQA",
        faceReadiness: "spriteKitFaceSilhouetteAccessoryReady:true",
        bodyReadiness: "spriteKitBodySilhouetteAccessoryReady:true",
        wingReadiness: "spriteKitWingSilhouetteAccessoryReady:true",
        tailReadiness: "spriteKitTailSilhouetteAccessoryReady:true",
        manualVisualQAPassing: true,
        snapshotReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        assetOutputs: "png"
    ))
}

@Test func rendererGenomeVariationVisibleCueRestraintSummaryRecordsAcceptedSingleCue() {
    let summary = RendererMetadataSummary.genomeVariationVisibleCueRestraintSummary(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "genomeVariationVisibleCueRestraint=surface:genomeVariationQA,cue:softWhiskerDots,purpose:kittenLikeSiblingFace,added:1,maxDelta:1,manualQA:true,imageReference:true,furtherVisibleCueBlocked:true,dependencyAdded:false,appBehaviorChanged:false,assetOutputs:none,ready:true")
    #expect(RendererMetadataSummary.genomeVariationVisibleCueRestraintReadinessSummary(isReady: true) == "genomeVariationVisibleCueRestraintReady:true")
    #expect(RendererMetadataSummary.genomeVariationVisibleCueRestraintReadinessSummary(isReady: false) == "genomeVariationVisibleCueRestraintReady:false")
}

@Test func rendererGenomeVariationVisibleCueRestraintRequiresAcceptedCueQAReferenceAndBlockedFollowup() {
    #expect(RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "observationHome",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softLeafVein",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "technicalDetail",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 2,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 2,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: false,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: false,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: false,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: true,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: true,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: "genomeVariationQA",
        acceptedCue: "softWhiskerDots",
        affectionPurpose: "kittenLikeSiblingFace",
        addedVisibleCueCount: 1,
        maxVisibleCueDelta: 1,
        manualVisualQAPassing: true,
        imageReferenceUpdated: true,
        furtherVisibleCueBlocked: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "png"
    ))
}

@Test func rendererGenomeVariationVisibleCueSetStabilitySummaryKeepsAcceptedCueSetClosed() {
    let summary = RendererMetadataSummary.genomeVariationVisibleCueSetStabilitySummary(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "genomeVariationVisibleCueSetStability=surface:genomeVariationQA,silhouette:genomeVariationSilhouetteCueSetAcceptanceReady:true,restraint:genomeVariationVisibleCueRestraintReady:true,imageReference:genome-variation-accepted,authorizedNewVisibleCues:0,futureManualReview:true,dependencyAdded:false,appBehaviorChanged:false,assetOutputs:none,ready:true")
    #expect(RendererMetadataSummary.genomeVariationVisibleCueSetStabilityReadinessSummary(isReady: true) == "genomeVariationVisibleCueSetStabilityReady:true")
    #expect(RendererMetadataSummary.genomeVariationVisibleCueSetStabilityReadinessSummary(isReady: false) == "genomeVariationVisibleCueSetStabilityReady:false")
}

@Test func rendererGenomeVariationVisibleCueSetStabilityRequiresReadyGatesAndNoNewVisibleWork() {
    #expect(RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "observationHome",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:false",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:false",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 1,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: false,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: true,
        appBehaviorChanged: false,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: true,
        assetOutputs: "none"
    ))
    #expect(!RendererMetadataSummary.hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: "genomeVariationQA",
        silhouetteCueSetReadiness: "genomeVariationSilhouetteCueSetAcceptanceReady:true",
        visibleCueRestraintReadiness: "genomeVariationVisibleCueRestraintReady:true",
        acceptedImageReferenceName: "genome-variation-accepted",
        authorizedNewVisibleCueCount: 0,
        futureVisibleCueRequiresManualReview: true,
        dependencyAdded: false,
        appBehaviorChanged: false,
        assetOutputs: "png"
    ))
}

@Test func rendererObservationCueLineReadabilityPreflightSummaryReportsTextBudget() {
    let summary = RendererMetadataSummary.observationCueLineReadabilityPreflightSummary(
        surfaceID: "observationHome",
        segmentCount: 6,
        maxSegments: 6,
        characterCount: 105,
        maxCharacters: 128,
        includesEyeGlint: true,
        includesMemoryCue: true,
        lineLimit: 3,
        minimumScaleFactor: "0.78",
        appHostVisualQAPending: true,
        visibleCopyChanged: false,
        assetOutputs: "none"
    )

    #expect(summary == "observationCueLineReadabilityPreflight=surface:observationHome,segments:6/6,characters:105/128,eyeGlint:true,memoryCue:true,lineLimit:3,minimumScale:0.78,appHostVisualQAPending:true,visibleCopyChanged:false,assetOutputs:none")
}

@Test func rendererObservationCueLineReadabilityPreflightRequiresCompactCueLine() {
    let summary = "observationCueLineReadabilityPreflight=surface:observationHome,segments:6/6,characters:105/128,eyeGlint:true,memoryCue:true,lineLimit:3,minimumScale:0.78,appHostVisualQAPending:true,visibleCopyChanged:false,assetOutputs:none"

    func isReady(
        surfaceID: String = "observationHome",
        segmentCount: Int = 6,
        maxSegments: Int = 6,
        characterCount: Int = 105,
        maxCharacters: Int = 128,
        includesEyeGlint: Bool = true,
        includesMemoryCue: Bool = true,
        lineLimit: Int = 3,
        minimumScaleFactor: String = "0.78",
        appHostVisualQAPending: Bool = true,
        visibleCopyChanged: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasObservationCueLineReadabilityPreflightFields(
            surfaceID: surfaceID,
            segmentCount: segmentCount,
            maxSegments: maxSegments,
            characterCount: characterCount,
            maxCharacters: maxCharacters,
            includesEyeGlint: includesEyeGlint,
            includesMemoryCue: includesMemoryCue,
            lineLimit: lineLimit,
            minimumScaleFactor: minimumScaleFactor,
            appHostVisualQAPending: appHostVisualQAPending,
            visibleCopyChanged: visibleCopyChanged,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(surfaceID: "genomeVariationQA"))
    #expect(!isReady(segmentCount: 0))
    #expect(!isReady(segmentCount: 7))
    #expect(!isReady(maxSegments: 7))
    #expect(!isReady(characterCount: 0))
    #expect(!isReady(characterCount: 129))
    #expect(!isReady(maxCharacters: 140))
    #expect(!isReady(includesEyeGlint: false))
    #expect(!isReady(includesMemoryCue: false))
    #expect(!isReady(lineLimit: 2))
    #expect(!isReady(minimumScaleFactor: "0.70"))
    #expect(!isReady(appHostVisualQAPending: false))
    #expect(!isReady(visibleCopyChanged: true))
    #expect(!isReady(assetOutputs: "png"))
    #expect(!isReady(summary: ""))

    #expect(RendererMetadataSummary.observationCueLineReadabilityPreflightReadinessSummary(isReady: true) == "observationCueLineReadabilityPreflightReady:true")
    #expect(RendererMetadataSummary.observationCueLineReadabilityPreflightReadinessSummary(isReady: false) == "observationCueLineReadabilityPreflightReady:false")
}

@Test func rendererAppHostVisualQARecoveryStateSummaryReportsPausedObservationGate() {
    let summary = RendererMetadataSummary.appHostVisualQARecoveryStateSummary(
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

    #expect(summary == "appHostVisualQARecoveryState=surface:observationHome,externalXcode:true,externalArtifacts:true,dryRun:true,simulator:D1C8187C-29D0-4145-94C7-6F887207A27F,targetedBuild:false,silentStopped:true,watchdogTimeout:true,timeoutSeconds:180,sourceControlWorkers:false,visibleChanges:false,assetOutputs:none")
}

@Test func rendererAppHostVisualQARecoveryStateRequiresIntentionalPausedState() {
    let summary = "appHostVisualQARecoveryState=surface:observationHome,externalXcode:true,externalArtifacts:true,dryRun:true,simulator:D1C8187C-29D0-4145-94C7-6F887207A27F,targetedBuild:false,silentStopped:true,watchdogTimeout:true,timeoutSeconds:180,sourceControlWorkers:false,visibleChanges:false,assetOutputs:none"

    func isReady(
        surfaceID: String = "observationHome",
        externalXcodeReady: Bool = true,
        externalArtifactsReady: Bool = true,
        dryRunResolved: Bool = true,
        simulatorID: String = "D1C8187C-29D0-4145-94C7-6F887207A27F",
        targetedBuildCompleted: Bool = false,
        buildSilentStopped: Bool = true,
        watchdogTimedOut: Bool = true,
        timeoutSeconds: Int = 180,
        sourceControlWorkersActive: Bool = false,
        visibleChangesAllowed: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasAppHostVisualQARecoveryStateFields(
            surfaceID: surfaceID,
            externalXcodeReady: externalXcodeReady,
            externalArtifactsReady: externalArtifactsReady,
            dryRunResolved: dryRunResolved,
            simulatorID: simulatorID,
            targetedBuildCompleted: targetedBuildCompleted,
            buildSilentStopped: buildSilentStopped,
            watchdogTimedOut: watchdogTimedOut,
            timeoutSeconds: timeoutSeconds,
            sourceControlWorkersActive: sourceControlWorkersActive,
            visibleChangesAllowed: visibleChangesAllowed,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(surfaceID: "genomeVariationQA"))
    #expect(!isReady(externalXcodeReady: false))
    #expect(!isReady(externalArtifactsReady: false))
    #expect(!isReady(dryRunResolved: false))
    #expect(!isReady(simulatorID: "other-simulator"))
    #expect(!isReady(targetedBuildCompleted: true))
    #expect(!isReady(buildSilentStopped: false))
    #expect(!isReady(watchdogTimedOut: false))
    #expect(!isReady(timeoutSeconds: 300))
    #expect(!isReady(sourceControlWorkersActive: true))
    #expect(!isReady(visibleChangesAllowed: true))
    #expect(!isReady(assetOutputs: "png"))
    #expect(!isReady(summary: ""))

    #expect(RendererMetadataSummary.appHostVisualQARecoveryStateReadinessSummary(isReady: true) == "appHostVisualQARecoveryStateReady:true")
    #expect(RendererMetadataSummary.appHostVisualQARecoveryStateReadinessSummary(isReady: false) == "appHostVisualQARecoveryStateReady:false")
}

@Test func rendererAppHostVisualQAResumeGateReportsWhyVisibleWorkStaysPaused() {
    let summary = RendererMetadataSummary.appHostVisualQAResumeGateSummary(
        surfaceID: "observationHome",
        sourceControlWorkersActive: true,
        visibleXcodebuildActive: false,
        dataVolumeFreeMegabytes: 595,
        minimumDataVolumeFreeMegabytes: 2048,
        lastSnapshotBuildTimedOut: true,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    )

    #expect(summary == "appHostVisualQAResumeGate=surface:observationHome,sourceControlWorkers:true,xcodebuild:false,dataFreeMB:595,minDataFreeMB:2048,lastSnapshotBuildTimedOut:true,visibleChanges:false,assetOutputs:none,resume:false")
    #expect(!RendererMetadataSummary.canResumeAppHostVisualQA(
        surfaceID: "observationHome",
        sourceControlWorkersActive: true,
        visibleXcodebuildActive: false,
        dataVolumeFreeMegabytes: 595,
        minimumDataVolumeFreeMegabytes: 2048,
        lastSnapshotBuildTimedOut: true,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    ))
}

@Test func rendererAppHostVisualQAResumeGateRequiresQuietXcodeAndEnoughDisk() {
    let summary = "appHostVisualQAResumeGate=surface:observationHome,sourceControlWorkers:true,xcodebuild:false,dataFreeMB:595,minDataFreeMB:2048,lastSnapshotBuildTimedOut:true,visibleChanges:false,assetOutputs:none,resume:false"

    func blockedGateReady(
        surfaceID: String = "observationHome",
        sourceControlWorkersActive: Bool = true,
        visibleXcodebuildActive: Bool = false,
        dataVolumeFreeMegabytes: Int = 595,
        minimumDataVolumeFreeMegabytes: Int = 2048,
        lastSnapshotBuildTimedOut: Bool = true,
        visibleChangesAllowed: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasAppHostVisualQAResumeGateFields(
            surfaceID: surfaceID,
            sourceControlWorkersActive: sourceControlWorkersActive,
            visibleXcodebuildActive: visibleXcodebuildActive,
            dataVolumeFreeMegabytes: dataVolumeFreeMegabytes,
            minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes,
            lastSnapshotBuildTimedOut: lastSnapshotBuildTimedOut,
            visibleChangesAllowed: visibleChangesAllowed,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(blockedGateReady())
    #expect(blockedGateReady(visibleXcodebuildActive: true))
    #expect(blockedGateReady(sourceControlWorkersActive: false, dataVolumeFreeMegabytes: 1024))
    #expect(blockedGateReady(sourceControlWorkersActive: false, dataVolumeFreeMegabytes: 4096, lastSnapshotBuildTimedOut: true))
    #expect(!blockedGateReady(surfaceID: "genomeVariationQA"))
    #expect(!blockedGateReady(sourceControlWorkersActive: false, dataVolumeFreeMegabytes: 4096, lastSnapshotBuildTimedOut: false))
    #expect(!blockedGateReady(visibleChangesAllowed: true))
    #expect(!blockedGateReady(assetOutputs: "png"))
    #expect(!blockedGateReady(summary: ""))
    #expect(!blockedGateReady(dataVolumeFreeMegabytes: -1))
    #expect(!blockedGateReady(minimumDataVolumeFreeMegabytes: 1024))

    #expect(RendererMetadataSummary.canResumeAppHostVisualQA(
        surfaceID: "observationHome",
        sourceControlWorkersActive: false,
        visibleXcodebuildActive: false,
        dataVolumeFreeMegabytes: 4096,
        minimumDataVolumeFreeMegabytes: 2048,
        lastSnapshotBuildTimedOut: false,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    ))
    #expect(RendererMetadataSummary.appHostVisualQAResumeGateReadinessSummary(isReady: true) == "appHostVisualQAResumeGateReady:true")
    #expect(RendererMetadataSummary.appHostVisualQAResumeGateReadinessSummary(isReady: false) == "appHostVisualQAResumeGateReady:false")
}

@Test func rendererXCTestDevicesExternalStorageGateRecordsMigrationButKeepsVisibleWorkPaused() {
    let path = "/Volumes/WD_BLACK SN770 500GB Media/XcodeStorage/Developer/XCTestDevices"
    let summary = RendererMetadataSummary.xctestDevicesExternalStorageGateSummary(
        surfaceID: "observationHome",
        xctestDevicesExternalized: true,
        xctestDevicesPath: path,
        dataVolumeFreeMegabytes: 710,
        minimumDataVolumeFreeMegabytes: 2048,
        externalVolumeFreeGigabytes: 179,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    )

    #expect(summary == "xctestDevicesExternalStorageGate=surface:observationHome,externalized:true,path:/Volumes/WD_BLACK SN770 500GB Media/XcodeStorage/Developer/XCTestDevices,dataFreeMB:710,minDataFreeMB:2048,externalFreeGB:179,minExternalFreeGB:16,visibleChanges:false,assetOutputs:none,resume:false")
    #expect(RendererMetadataSummary.hasXCTestDevicesExternalStorageGateFields(
        surfaceID: "observationHome",
        xctestDevicesExternalized: true,
        xctestDevicesPath: path,
        dataVolumeFreeMegabytes: 710,
        minimumDataVolumeFreeMegabytes: 2048,
        externalVolumeFreeGigabytes: 179,
        visibleChangesAllowed: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.canResumeWithExternalXCTestDevicesStorage(
        surfaceID: "observationHome",
        xctestDevicesExternalized: true,
        xctestDevicesPath: path,
        dataVolumeFreeMegabytes: 710,
        minimumDataVolumeFreeMegabytes: 2048,
        externalVolumeFreeGigabytes: 179,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    ))
}

@Test func rendererXCTestDevicesExternalStorageGateRequiresExternalPathEnoughDiskAndNoVisibleChanges() {
    let path = "/Volumes/WD_BLACK SN770 500GB Media/XcodeStorage/Developer/XCTestDevices"
    let summary = "xctestDevicesExternalStorageGate=surface:observationHome,externalized:true,path:/Volumes/WD_BLACK SN770 500GB Media/XcodeStorage/Developer/XCTestDevices,dataFreeMB:710,minDataFreeMB:2048,externalFreeGB:179,minExternalFreeGB:16,visibleChanges:false,assetOutputs:none,resume:false"

    func blockedGateReady(
        surfaceID: String = "observationHome",
        xctestDevicesExternalized: Bool = true,
        xctestDevicesPath: String = path,
        dataVolumeFreeMegabytes: Int = 710,
        minimumDataVolumeFreeMegabytes: Int = 2048,
        externalVolumeFreeGigabytes: Int = 179,
        visibleChangesAllowed: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasXCTestDevicesExternalStorageGateFields(
            surfaceID: surfaceID,
            xctestDevicesExternalized: xctestDevicesExternalized,
            xctestDevicesPath: xctestDevicesPath,
            dataVolumeFreeMegabytes: dataVolumeFreeMegabytes,
            minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes,
            externalVolumeFreeGigabytes: externalVolumeFreeGigabytes,
            visibleChangesAllowed: visibleChangesAllowed,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(blockedGateReady())
    #expect(!blockedGateReady(surfaceID: "widget"))
    #expect(!blockedGateReady(xctestDevicesExternalized: false))
    #expect(!blockedGateReady(xctestDevicesPath: "/Users/taikikira/Library/Developer/XCTestDevices"))
    #expect(!blockedGateReady(dataVolumeFreeMegabytes: -1))
    #expect(!blockedGateReady(dataVolumeFreeMegabytes: 4096))
    #expect(!blockedGateReady(externalVolumeFreeGigabytes: 2))
    #expect(!blockedGateReady(visibleChangesAllowed: true))
    #expect(!blockedGateReady(assetOutputs: "png"))
    #expect(!blockedGateReady(summary: ""))

    #expect(RendererMetadataSummary.canResumeWithExternalXCTestDevicesStorage(
        surfaceID: "observationHome",
        xctestDevicesExternalized: true,
        xctestDevicesPath: path,
        dataVolumeFreeMegabytes: 4096,
        minimumDataVolumeFreeMegabytes: 2048,
        externalVolumeFreeGigabytes: 179,
        visibleChangesAllowed: false,
        assetOutputs: "none"
    ))
    #expect(RendererMetadataSummary.xctestDevicesExternalStorageGateReadinessSummary(isReady: true) == "xctestDevicesExternalStorageGateReady:true")
    #expect(RendererMetadataSummary.xctestDevicesExternalStorageGateReadinessSummary(isReady: false) == "xctestDevicesExternalStorageGateReady:false")
}

@Test func rendererFixedPartVocabularyBridgeSummaryMapsSpriteKitCuesToReferenceTerms() {
    let summary = RendererMetadataSummary.fixedPartVocabularyBridgeSummary(
        faceMappings: [
            "faceted->Face.crystal",
            "smallFairy->Face.fairy",
            "softRound->Face.round",
            "broadDragon->Face.dragon",
            "wideAxolotl->Face.axolotl",
            "softDeer->Face.deer",
            "softFeline->Face.feline",
            "softCrescent->Face.lunar"
        ],
        upperBodyMappings: [
            "moonOval->UpperBody.lunarian",
            "seedPetal->UpperBody.sylphian",
            "waterDrop->UpperBody.aquarian",
            "pebbleGem->UpperBody.crystalian",
            "leafBelly->UpperBody.verdant"
        ],
        wingMappings: [
            "none->none",
            "leafPair->Wing.fairy",
            "wideSail->Wing.dragon",
            "gemPair->Wing.crystal",
            "softBell->Wing.jellyfish",
            "sproutLeaf->Wing.plant"
        ],
        tailMappings: [
            "floatingRibbon->Tail.floating",
            "fishFin->Tail.fish",
            "longDrake->Tail.dragon",
            "gemTail->Tail.crystal",
            "leafSprout->Tail.plant",
            "none->none"
        ],
        assetOutputs: "none",
        geometryChanged: false
    )

    #expect(summary == "fixedPartVocabularyBridge=v1;face:faceted->Face.crystal,smallFairy->Face.fairy,softRound->Face.round,broadDragon->Face.dragon,wideAxolotl->Face.axolotl,softDeer->Face.deer,softFeline->Face.feline,softCrescent->Face.lunar;upperBody:moonOval->UpperBody.lunarian,seedPetal->UpperBody.sylphian,waterDrop->UpperBody.aquarian,pebbleGem->UpperBody.crystalian,leafBelly->UpperBody.verdant;wing:none->none,leafPair->Wing.fairy,wideSail->Wing.dragon,gemPair->Wing.crystal,softBell->Wing.jellyfish,sproutLeaf->Wing.plant;tail:floatingRibbon->Tail.floating,fishFin->Tail.fish,longDrake->Tail.dragon,gemTail->Tail.crystal,leafSprout->Tail.plant,none->none;assetOutputs:none;geometryChanged:false")
}

@Test func rendererFixedPartVocabularyBridgeReadinessRequiresMappingsAndSummary() {
    let summary = "fixedPartVocabularyBridge=v1;face:faceted->Face.crystal;upperBody:moonOval->UpperBody.lunarian;wing:none->none;tail:floatingRibbon->Tail.floating;assetOutputs:none;geometryChanged:false"

    #expect(RendererMetadataSummary.hasFixedPartVocabularyBridgeFields(
        faceMappings: ["faceted->Face.crystal"],
        upperBodyMappings: ["moonOval->UpperBody.lunarian"],
        wingMappings: ["none->none"],
        tailMappings: ["floatingRibbon->Tail.floating"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartVocabularyBridgeFields(
        faceMappings: ["faceted->Face.crystal"],
        upperBodyMappings: [],
        wingMappings: ["none->none"],
        tailMappings: ["floatingRibbon->Tail.floating"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPartVocabularyBridgeReadinessSummary(isReady: true) == "fixedPartVocabularyBridgeMetadataReady:true")
    #expect(RendererMetadataSummary.fixedPartVocabularyBridgeReadinessSummary(isReady: false) == "fixedPartVocabularyBridgeMetadataReady:false")
}

@Test func rendererFixedPart2DRecipeBridgeSummaryNamesCurrentSpriteKitRecipes() {
    let summary = RendererMetadataSummary.fixedPart2DRecipeBridgeSummary(
        headRecipes: ["softRound", "softPetal", "softBroad", "softWide", "softFacet", "softDeer", "softFeline", "softCrescent"],
        bodyRecipes: ["softOval", "waterDrop", "seedPetal", "pebbleGem", "moonOval", "leafBelly"],
        wingRecipes: ["softLunar", "softLeaf", "softSail", "softFacet", "softBell", "softSprout"],
        tailRecipes: ["roundedRibbon", "fishTaper", "dragonTaper", "softFacet", "leafSprout"],
        futureTargets: ["FaceBase", "UpperBody", "WingBase", "TailBase"],
        assetOutputs: "none",
        geometryChanged: false
    )

    #expect(summary == "fixedPart2DRecipeBridge=v1;head:softRound,softPetal,softBroad,softWide,softFacet,softDeer,softFeline,softCrescent;body:softOval,waterDrop,seedPetal,pebbleGem,moonOval,leafBelly;wing:softLunar,softLeaf,softSail,softFacet,softBell,softSprout;tail:roundedRibbon,fishTaper,dragonTaper,softFacet,leafSprout;futureTargets:FaceBase,UpperBody,WingBase,TailBase;assetOutputs:none;geometryChanged:false")
}

@Test func fixedPartCoreEnumsIncludeMasterFaceWingAndTailCoverage() {
    #expect(FaceBase.allCases.map(\.rawValue).contains("deer"))
    #expect(FaceBase.allCases.map(\.rawValue).contains("feline"))
    #expect(FaceBase.allCases.map(\.rawValue).contains("lunar"))
    #expect(WingBase.allCases.map(\.rawValue).contains("lunar"))
    #expect(WingBase.allCases.map(\.rawValue).contains("plant"))
    #expect(TailBase.allCases.map(\.rawValue).contains("plant"))
}

@Test func rendererFixedPart2DRecipeBridgeReadinessRequiresRecipesTargetsAndSummary() {
    let summary = "fixedPart2DRecipeBridge=v1;head:softRound;body:softOval;wing:softLunar;tail:roundedRibbon;futureTargets:FaceBase;assetOutputs:none;geometryChanged:false"

    #expect(RendererMetadataSummary.hasFixedPart2DRecipeBridgeFields(
        headRecipes: ["softRound"],
        bodyRecipes: ["softOval"],
        wingRecipes: ["softLunar"],
        tailRecipes: ["roundedRibbon"],
        futureTargets: ["FaceBase"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPart2DRecipeBridgeFields(
        headRecipes: ["softRound"],
        bodyRecipes: [],
        wingRecipes: [],
        tailRecipes: ["roundedRibbon"],
        futureTargets: ["FaceBase"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPart2DRecipeBridgeReadinessSummary(isReady: true) == "fixedPart2DRecipeBridgeReady:true")
    #expect(RendererMetadataSummary.fixedPart2DRecipeBridgeReadinessSummary(isReady: false) == "fixedPart2DRecipeBridgeReady:false")
}

@Test func rendererFixedPartAccessoryRecipeBridgeSummaryNamesCurrentAccessoryRecipes() {
    let summary = RendererMetadataSummary.fixedPartAccessoryRecipeBridgeSummary(
        faceAccessories: ["softEarNubs", "softEarTips"],
        bodyAccessories: ["softShoulderPetals", "softMoonShoulderCrescents", "leafShoulderNubs"],
        wingAccessories: ["softWingTipPearl", "softWingTipClaw"],
        tailAccessories: ["softForkFin", "softTetherDot", "softDrakeRidge", "softLeafVein"],
        futureTargets: ["FaceAccessory", "UpperBodyAccessory", "WingAccessory", "TailAccessory"],
        assetOutputs: "none",
        geometryChanged: false
    )

    #expect(summary == "fixedPartAccessoryRecipeBridge=v1;face:softEarNubs,softEarTips;body:softShoulderPetals,softMoonShoulderCrescents,leafShoulderNubs;wing:softWingTipPearl,softWingTipClaw;tail:softForkFin,softTetherDot,softDrakeRidge,softLeafVein;futureTargets:FaceAccessory,UpperBodyAccessory,WingAccessory,TailAccessory;assetOutputs:none;geometryChanged:false")
}

@Test func rendererFixedPartAccessoryRecipeBridgeReadinessRequiresRecipesTargetsAndNoAssets() {
    let summary = "fixedPartAccessoryRecipeBridge=v1;face:softEarNubs;body:softShoulderPetals;wing:softWingTipPearl;tail:softForkFin;futureTargets:FaceAccessory;assetOutputs:none;geometryChanged:false"

    #expect(RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: ["softEarNubs"],
        bodyAccessories: ["softShoulderPetals"],
        wingAccessories: ["softWingTipPearl"],
        tailAccessories: ["softForkFin"],
        futureTargets: ["FaceAccessory"],
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: [],
        bodyAccessories: ["softShoulderPetals"],
        wingAccessories: ["softWingTipPearl"],
        tailAccessories: ["softForkFin"],
        futureTargets: ["FaceAccessory"],
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: ["softEarNubs"],
        bodyAccessories: [""],
        wingAccessories: ["softWingTipPearl"],
        tailAccessories: ["softForkFin"],
        futureTargets: ["FaceAccessory"],
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: ["softEarNubs"],
        bodyAccessories: ["softShoulderPetals"],
        wingAccessories: ["softWingTipPearl"],
        tailAccessories: ["softForkFin"],
        futureTargets: ["FaceAccessory"],
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: ["softEarNubs"],
        bodyAccessories: ["softShoulderPetals"],
        wingAccessories: ["softWingTipPearl"],
        tailAccessories: ["softForkFin"],
        futureTargets: ["FaceAccessory"],
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartAccessoryRecipeBridgeReadinessSummary(isReady: true) == "fixedPartAccessoryRecipeBridgeReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryRecipeBridgeReadinessSummary(isReady: false) == "fixedPartAccessoryRecipeBridgeReady:false")
}

@Test func rendererFixedPartAccessoryReferenceAnnotationSummaryMapsCurrentAccessoriesToSockets() {
    let summary = RendererMetadataSummary.fixedPartAccessoryReferenceAnnotationSummary(
        faceAnnotations: [
            "softEarNubs->FaceBase.deer@headCenter#accessoryCue",
            "softEarTips->FaceBase.feline@headCenter#accessoryCue"
        ],
        bodyAnnotations: [
            "softShoulderPetals->UpperBody.sylphian@bodyCenter#accessoryCue",
            "softMoonShoulderCrescents->UpperBody.lunarian@bodyCenter#accessoryCue",
            "leafShoulderNubs->UpperBody.verdant@bodyCenter#accessoryCue"
        ],
        wingAnnotations: [
            "softWingTipPearl->WingBase.fairy@wingTip#accessoryCue",
            "softWingTipClaw->WingBase.dragon@wingTip#accessoryCue"
        ],
        tailAnnotations: [
            "softForkFin->TailBase.fish@tailTip#accessoryCue",
            "softTetherDot->TailBase.floating@tailTip#accessoryCue",
            "softDrakeRidge->TailBase.dragon@tailTip#accessoryCue"
        ],
        requiredPanels: ["accessoryCue", "socketDiagram", "rigDiagram"],
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false
    )

    #expect(summary == "fixedPartAccessoryReferenceAnnotation=v1;face:softEarNubs->FaceBase.deer@headCenter#accessoryCue,softEarTips->FaceBase.feline@headCenter#accessoryCue;body:softShoulderPetals->UpperBody.sylphian@bodyCenter#accessoryCue,softMoonShoulderCrescents->UpperBody.lunarian@bodyCenter#accessoryCue,leafShoulderNubs->UpperBody.verdant@bodyCenter#accessoryCue;wing:softWingTipPearl->WingBase.fairy@wingTip#accessoryCue,softWingTipClaw->WingBase.dragon@wingTip#accessoryCue;tail:softForkFin->TailBase.fish@tailTip#accessoryCue,softTetherDot->TailBase.floating@tailTip#accessoryCue,softDrakeRidge->TailBase.dragon@tailTip#accessoryCue;panels:accessoryCue,socketDiagram,rigDiagram;sourceBridgeReady:true;assetOutputs:none;generatedAssets:false")
}

@Test func rendererFixedPartAccessoryReferenceAnnotationReadinessRequiresPanelsBridgeAndNoAssets() {
    let faceAnnotations = ["softEarNubs->FaceBase.deer@headCenter#accessoryCue"]
    let bodyAnnotations = ["softShoulderPetals->UpperBody.sylphian@bodyCenter#accessoryCue"]
    let wingAnnotations = ["softWingTipPearl->WingBase.fairy@wingTip#accessoryCue"]
    let tailAnnotations = ["softForkFin->TailBase.fish@tailTip#accessoryCue"]
    let panels = ["accessoryCue", "socketDiagram", "rigDiagram"]
    let summary = "fixedPartAccessoryReferenceAnnotation=v1;face:softEarNubs->FaceBase.deer@headCenter#accessoryCue;body:softShoulderPetals->UpperBody.sylphian@bodyCenter#accessoryCue;wing:softWingTipPearl->WingBase.fairy@wingTip#accessoryCue;tail:softForkFin->TailBase.fish@tailTip#accessoryCue;panels:accessoryCue,socketDiagram,rigDiagram;sourceBridgeReady:true;assetOutputs:none;generatedAssets:false"

    #expect(RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: [],
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: [""],
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["accessoryCue", "socketDiagram"],
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: false,
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "png",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: true,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        wingAnnotations: wingAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        sourceBridgeReady: true,
        assetOutputs: "none",
        generatedAssets: false,
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceAnnotationReadinessSummary(isReady: true) == "fixedPartAccessoryReferenceAnnotationReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceAnnotationReadinessSummary(isReady: false) == "fixedPartAccessoryReferenceAnnotationReady:false")
}

@Test func rendererFixedPartAccessoryReferenceSheetPreflightSummaryReportsClosedGate() {
    let summary = RendererMetadataSummary.fixedPartAccessoryReferenceSheetPreflightSummary(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAccessoryReferenceSheetPreflight=v1;accessoryReferenceReady:true;manualChecklistReady:true;manualReviewStateReady:true;reviewEvidenceFieldsReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartAccessoryReferenceSheetPreflightReadinessRequiresClosedGate() {
    let summary = "fixedPartAccessoryReferenceSheetPreflight=v1;accessoryReferenceReady:true;manualChecklistReady:true;manualReviewStateReady:true;reviewEvidenceFieldsReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: false,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: false,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: false,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: false,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: true,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: true,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceSheetPreflightReadinessSummary(isReady: true) == "fixedPartAccessoryReferenceSheetPreflightReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceSheetPreflightReadinessSummary(isReady: false) == "fixedPartAccessoryReferenceSheetPreflightReady:false")
}

@Test func rendererFixedPartAccessoryReferenceSheetPanelNotesSummaryReportsAcceptedAccessoryNotes() {
    let notes = [
        "softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette",
        "softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette",
        "softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette",
        "softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette",
        "softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette",
        "softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette",
        "softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette"
    ]
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]

    let summary = RendererMetadataSummary.fixedPartAccessoryReferenceSheetPanelNotesSummary(
        notes: notes,
        requiredPanels: panels,
        preflightReady: true,
        grayscaleOnly: true,
        noColorPatternGlow: true,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAccessoryReferenceSheetPanelNotes=v1;notes:softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette,softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette,softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette,softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette,softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette,softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette,softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette;panels:frontView,sideView,threeQuarterView,socketDiagram,rigDiagram,accessoryCue;preflightReady:true;grayscaleOnly:true;noColorPatternGlow:true;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPartAccessoryReferenceSheetPanelNotesReadinessRequiresAcceptedNotesPanelsAndNoAssets() {
    let notes = [
        "softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette",
        "softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette",
        "softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette",
        "softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette",
        "softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette",
        "softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette",
        "softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette"
    ]
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartAccessoryReferenceSheetPanelNotes=v1;notes:softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette,softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette,softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette,softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette,softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette,softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette,softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette;panels:frontView,sideView,threeQuarterView,socketDiagram,rigDiagram,accessoryCue;preflightReady:true;grayscaleOnly:true;noColorPatternGlow:true;generatedAssets:false;assetOutputs:none"

    func isReady(
        notes candidateNotes: [String] = notes,
        requiredPanels: [String] = panels,
        preflightReady: Bool = true,
        grayscaleOnly: Bool = true,
        noColorPatternGlow: Bool = true,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPanelNotesFields(
            notes: candidateNotes,
            requiredPanels: requiredPanels,
            preflightReady: preflightReady,
            grayscaleOnly: grayscaleOnly,
            noColorPatternGlow: noColorPatternGlow,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(notes: Array(notes.dropLast())))
    #expect(!isReady(requiredPanels: Array(panels.dropLast())))
    #expect(!isReady(preflightReady: false))
    #expect(!isReady(grayscaleOnly: false))
    #expect(!isReady(noColorPatternGlow: false))
    #expect(!isReady(generatedAssets: true))
    #expect(!isReady(assetOutputs: "png"))
    #expect(!isReady(summary: ""))
    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary(isReady: true) == "fixedPartAccessoryReferenceSheetPanelNotesReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary(isReady: false) == "fixedPartAccessoryReferenceSheetPanelNotesReady:false")
}

@Test func rendererFixedPartAccessoryManualReviewChecklistSummaryReportsAccessoryReviewItems() {
    let summary = RendererMetadataSummary.fixedPartAccessoryManualReviewChecklistSummary(
        reviewerRole: "CreatureArtDirector",
        checklistItems: [
            "softAccessoryScale",
            "socketOwnership",
            "silhouetteSecondary",
            "cuteReadability",
            "familyLikenessSafe",
            "grayscaleOnly",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ],
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAccessoryManualReviewChecklist=v1;reviewer:CreatureArtDirector;items:softAccessoryScale,socketOwnership,silhouetteSecondary,cuteReadability,familyLikenessSafe,grayscaleOnly,noColorPatternGlow,noGeneratedGeometry;preflightReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartAccessoryManualReviewChecklistReadinessRequiresAccessoryArtCriteriaAndClosedGate() {
    let items = [
        "softAccessoryScale",
        "socketOwnership",
        "silhouetteSecondary",
        "cuteReadability",
        "familyLikenessSafe",
        "grayscaleOnly",
        "noColorPatternGlow",
        "noGeneratedGeometry"
    ]
    let summary = "fixedPartAccessoryManualReviewChecklist=v1;reviewer:CreatureArtDirector;items:softAccessoryScale,socketOwnership,silhouetteSecondary,cuteReadability,familyLikenessSafe,grayscaleOnly,noColorPatternGlow,noGeneratedGeometry;preflightReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "QAEngineer",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: Array(items.dropLast()),
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        preflightReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartAccessoryManualReviewChecklistReadinessSummary(isReady: true) == "fixedPartAccessoryManualReviewChecklistReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryManualReviewChecklistReadinessSummary(isReady: false) == "fixedPartAccessoryManualReviewChecklistReady:false")
}

@Test func rendererFixedPartAccessoryReviewEvidenceHandoffSummaryReportsEmptyEvidenceSlots() {
    let summary = RendererMetadataSummary.fixedPartAccessoryReviewEvidenceHandoffSummary(
        checklistReady: true,
        evidenceFields: [
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "decisionReason",
            "affectionRisk",
            "revisionNotes"
        ],
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAccessoryReviewEvidenceHandoff=v1;checklistReady:true;fields:reviewerNote,checkedItems,visualQAImage,decisionReason,affectionRisk,revisionNotes;evidenceRecorded:false;evidencePath:;reviewerNote:;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPartAccessoryReviewEvidenceHandoffReadinessRequiresEmptyClosedEvidenceSlots() {
    let fields = [
        "reviewerNote",
        "checkedItems",
        "visualQAImage",
        "decisionReason",
        "affectionRisk",
        "revisionNotes"
    ]
    let summary = "fixedPartAccessoryReviewEvidenceHandoff=v1;checklistReady:true;fields:reviewerNote,checkedItems,visualQAImage,decisionReason,affectionRisk,revisionNotes;evidenceRecorded:false;evidencePath:;reviewerNote:;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: false,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: Array(fields.dropLast()),
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: true,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "docs/For_Agent/reference_sheets/accessory_review.md",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "looks soft",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: true,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: true,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartAccessoryReviewEvidenceHandoffReadinessSummary(isReady: true) == "fixedPartAccessoryReviewEvidenceHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryReviewEvidenceHandoffReadinessSummary(isReady: false) == "fixedPartAccessoryReviewEvidenceHandoffReady:false")
}

@Test func rendererFixedPartAccessoryArtifactCandidateRecordSummaryReportsReservedFuturePath() {
    let summary = RendererMetadataSummary.fixedPartAccessoryArtifactCandidateRecordSummary(
        artifactStem: "wipet_fixed_part_accessory_reference_sheet_v1",
        relativePath: "docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png",
        format: "png",
        surface: "fixedPartAccessoryReferenceSheet",
        evidenceHandoffReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAccessoryArtifactCandidateRecord=v1;stem:wipet_fixed_part_accessory_reference_sheet_v1;path:docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png;format:png;surface:fixedPartAccessoryReferenceSheet;evidenceHandoffReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPartAccessoryArtifactCandidateRecordReadinessRequiresNamedClosedCandidate() {
    let stem = "wipet_fixed_part_accessory_reference_sheet_v1"
    let path = "docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png"
    let summary = "fixedPartAccessoryArtifactCandidateRecord=v1;stem:wipet_fixed_part_accessory_reference_sheet_v1;path:docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png;format:png;surface:fixedPartAccessoryReferenceSheet;evidenceHandoffReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none"

    func isReady(
        artifactStem: String = stem,
        relativePath: String = path,
        format: String = "png",
        surface: String = "fixedPartAccessoryReferenceSheet",
        evidenceHandoffReady: Bool = true,
        candidateExists: Bool = false,
        generationAllowed: Bool = false,
        snapshotReferenceAccepted: Bool = false,
        runtimeLoaded: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasFixedPartAccessoryArtifactCandidateRecordFields(
            artifactStem: artifactStem,
            relativePath: relativePath,
            format: format,
            surface: surface,
            evidenceHandoffReady: evidenceHandoffReady,
            candidateExists: candidateExists,
            generationAllowed: generationAllowed,
            snapshotReferenceAccepted: snapshotReferenceAccepted,
            runtimeLoaded: runtimeLoaded,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(artifactStem: "wipet_fixed_part_accessory_reference_sheet_v2"))
    #expect(!isReady(relativePath: "docs/For_Agent/reference_sheets/other.png"))
    #expect(!isReady(format: "jpg"))
    #expect(!isReady(surface: "fixedPartReferenceSheet"))
    #expect(!isReady(evidenceHandoffReady: false))
    #expect(!isReady(candidateExists: true))
    #expect(!isReady(generationAllowed: true))
    #expect(!isReady(snapshotReferenceAccepted: true))
    #expect(!isReady(runtimeLoaded: true))
    #expect(!isReady(generatedAssets: true))
    #expect(!isReady(assetOutputs: "png"))
    #expect(!isReady(summary: ""))

    #expect(RendererMetadataSummary.fixedPartAccessoryArtifactCandidateRecordReadinessSummary(isReady: true) == "fixedPartAccessoryArtifactCandidateRecordReady:true")
    #expect(RendererMetadataSummary.fixedPartAccessoryArtifactCandidateRecordReadinessSummary(isReady: false) == "fixedPartAccessoryArtifactCandidateRecordReady:false")
}

@Test func rendererFixedPartLineageCueReferenceAnnotationSummaryMapsCurrentFamilyCues() {
    let summary = RendererMetadataSummary.fixedPartLineageCueReferenceAnnotationSummary(
        bodyAnnotations: [
            "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
            "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue"
        ],
        tailAnnotations: ["softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"],
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: false
    )

    #expect(summary == "fixedPartLineageCueReferenceAnnotation=v1;body:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue;tail:softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:lineageCue,socketDiagram,rigDiagram;assetOutputs:none;generatedAssets:false")
}

@Test func rendererFixedPartLineageCueReferenceAnnotationReadinessRequiresAnnotationsPanelsAndNoAssets() {
    let bodyAnnotations = [
        "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
        "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue"
    ]
    let tailAnnotations = ["softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"]
    let summary = "fixedPartLineageCueReferenceAnnotation=v1;body:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue;tail:softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:lineageCue,socketDiagram,rigDiagram;assetOutputs:none;generatedAssets:false"

    #expect(RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: [],
        tailAnnotations: ["softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"],
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: [""],
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram"],
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "glb",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: true,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        assetOutputs: "none",
        generatedAssets: false,
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartLineageCueReferenceAnnotationReadinessSummary(isReady: true) == "fixedPartLineageCueReferenceAnnotationReady:true")
    #expect(RendererMetadataSummary.fixedPartLineageCueReferenceAnnotationReadinessSummary(isReady: false) == "fixedPartLineageCueReferenceAnnotationReady:false")
}

@Test func rendererFixedPartChildDraftLineageCueReferenceSummaryReportsFaceBodyTailHandoff() {
    let summary = RendererMetadataSummary.fixedPartChildDraftLineageCueReferenceSummary(
        faceAnnotations: [
            "softDeer->FaceBase.deer@headCenter#lineageCue",
            "forestDots->FaceBase.deer@headCenter#lineageCue"
        ],
        bodyAnnotations: [
            "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
            "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue"
        ],
        tailAnnotations: [
            "softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"
        ],
        requiredPanels: ["childDraftPortrait", "lineageCue", "socketDiagram", "rigDiagram"],
        socketMappings: ["headCenter->head", "bodyCenter->body", "tailRoot->tail_1"],
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false
    )

    #expect(summary == "fixedPartChildDraftLineageCueReference=v1;face:softDeer->FaceBase.deer@headCenter#lineageCue,forestDots->FaceBase.deer@headCenter#lineageCue;body:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue;tail:softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:childDraftPortrait,lineageCue,socketDiagram,rigDiagram;sockets:headCenter->head,bodyCenter->body,tailRoot->tail_1;source:genomeVariationChildDraft;assetOutputs:none;generatedAssets:false")
}

@Test func rendererFixedPartChildDraftLineageCueReferenceReadinessRequiresFaceBodyTailHandoff() {
    let faceAnnotations = [
        "softDeer->FaceBase.deer@headCenter#lineageCue",
        "forestDots->FaceBase.deer@headCenter#lineageCue"
    ]
    let bodyAnnotations = [
        "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
        "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue"
    ]
    let tailAnnotations = [
        "softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"
    ]
    let panels = ["childDraftPortrait", "lineageCue", "socketDiagram", "rigDiagram"]
    let sockets = ["headCenter->head", "bodyCenter->body", "tailRoot->tail_1"]
    let summary = "fixedPartChildDraftLineageCueReference=v1;face:softDeer->FaceBase.deer@headCenter#lineageCue,forestDots->FaceBase.deer@headCenter#lineageCue;body:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue;tail:softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:childDraftPortrait,lineageCue,socketDiagram,rigDiagram;sockets:headCenter->head,bodyCenter->body,tailRoot->tail_1;source:genomeVariationChildDraft;assetOutputs:none;generatedAssets:false"

    #expect(RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: Array(faceAnnotations.dropFirst()),
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: Array(bodyAnnotations.dropLast()),
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: [],
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: ["lineageCue", "socketDiagram", "rigDiagram"],
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: ["bodyCenter->body", "tailRoot->tail_1"],
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "observationHome",
        assetOutputs: "none",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "png",
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: true,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: faceAnnotations,
        bodyAnnotations: bodyAnnotations,
        tailAnnotations: tailAnnotations,
        requiredPanels: panels,
        socketMappings: sockets,
        sourceSurface: "genomeVariationChildDraft",
        assetOutputs: "none",
        generatedAssets: false,
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartChildDraftLineageCueReferenceReadinessSummary(isReady: true) == "fixedPartChildDraftLineageCueReferenceReady:true")
    #expect(RendererMetadataSummary.fixedPartChildDraftLineageCueReferenceReadinessSummary(isReady: false) == "fixedPartChildDraftLineageCueReferenceReady:false")
}

@Test func rendererFixedPartChildDraftLineageCueAcceptanceGateSummaryReportsClosedReviewGate() {
    let summary = RendererMetadataSummary.fixedPartChildDraftLineageCueAcceptanceGateSummary(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartChildDraftLineageCueAcceptanceGate=v1;source:genomeVariationChildDraft;referenceReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;referenceImageAccepted:false;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPartChildDraftLineageCueAcceptanceGateReadinessRequiresClosedReviewState() {
    let summary = "fixedPartChildDraftLineageCueAcceptanceGate=v1;source:genomeVariationChildDraft;referenceReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;referenceImageAccepted:false;generatedAssets:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "observationHome",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: true,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: "genomeVariationChildDraft",
        childDraftReferenceReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        referenceImageAccepted: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary(isReady: true) == "fixedPartChildDraftLineageCueAcceptanceGateReady:true")
    #expect(RendererMetadataSummary.fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary(isReady: false) == "fixedPartChildDraftLineageCueAcceptanceGateReady:false")
}

@Test func rendererFixedPartLineageCueSetReferenceSheetSummaryMapsCueSetPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartLineageCueSetReferenceSheetSummary(
        cueSetID: "softLineageCueSet",
        cueAnnotations: [
            "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
            "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue",
            "softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"
        ],
        requiredPanels: [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "lineageCue"
        ],
        socketMappings: [
            "bodyCenter->body",
            "tailRoot->tail_1"
        ],
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartLineageCueSetReferenceSheet=v1;cueSet:softLineageCueSet;annotations:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue,softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:frontView,sideView,threeQuarterView,socketDiagram,rigDiagram,lineageCue;sockets:bodyCenter->body,tailRoot->tail_1;grayscaleOnly:true;excludesColorPatternGlow:true;geometryGenerated:false;assetOutputs:none")
}

@Test func rendererFixedPartLineageCueSetReferenceSheetReadinessRequiresFullNoAssetSheetContract() {
    let annotations = [
        "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
        "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue",
        "softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"
    ]
    let panels = [
        "frontView",
        "sideView",
        "threeQuarterView",
        "socketDiagram",
        "rigDiagram",
        "lineageCue"
    ]
    let sockets = [
        "bodyCenter->body",
        "tailRoot->tail_1"
    ]
    let summary = "fixedPartLineageCueSetReferenceSheet=v1;cueSet:softLineageCueSet;annotations:softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue,softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue,softTailMemoryDots->TailBase.floating@tailRoot#lineageCue;panels:frontView,sideView,threeQuarterView,socketDiagram,rigDiagram,lineageCue;sockets:bodyCenter->body,tailRoot->tail_1;grayscaleOnly:true;excludesColorPatternGlow:true;geometryGenerated:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "lineageCue",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: Array(annotations.prefix(2)),
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: [
            "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
            "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue",
            "softTailMemoryDots->TailBase.floating@tailRoot#surface"
        ],
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: ["frontView", "sideView", "socketDiagram", "rigDiagram", "lineageCue"],
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: ["bodyCenter->body"],
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: false,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: false,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: "softLineageCueSet",
        cueAnnotations: annotations,
        requiredPanels: panels,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        geometryGenerated: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartLineageCueSetReferenceSheetReadinessSummary(isReady: true) == "fixedPartLineageCueSetReferenceSheetReady:true")
    #expect(RendererMetadataSummary.fixedPartLineageCueSetReferenceSheetReadinessSummary(isReady: false) == "fixedPartLineageCueSetReferenceSheetReady:false")
}

@Test func rendererFixedPartReferenceSheetPanelLayoutSummaryReportsPanelRolesOrderAndCallouts() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetPanelLayoutSummary(
        cueSetID: "softLineageCueSet",
        panelRoles: [
            "frontView:silhouette",
            "sideView:depth",
            "threeQuarterView:volume",
            "socketDiagram:bodyTailSockets",
            "rigDiagram:CommonPetRig",
            "lineageCue:softLineageCueSet"
        ],
        readingOrder: [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "lineageCue"
        ],
        requiredCallouts: [
            "cuteSilhouette",
            "bodyCenter",
            "tailRoot",
            "CommonPetRig",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ],
        generatedReferenceSheet: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetPanelLayout=v1;cueSet:softLineageCueSet;panels:frontView:silhouette,sideView:depth,threeQuarterView:volume,socketDiagram:bodyTailSockets,rigDiagram:CommonPetRig,lineageCue:softLineageCueSet;order:frontView>sideView>threeQuarterView>socketDiagram>rigDiagram>lineageCue;callouts:cuteSilhouette,bodyCenter,tailRoot,CommonPetRig,noColorPatternGlow,noGeneratedGeometry;generatedReferenceSheet:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetPanelLayoutReadinessRequiresAllPanelsAndNoGeneratedSheet() {
    let panelRoles = [
        "frontView:silhouette",
        "sideView:depth",
        "threeQuarterView:volume",
        "socketDiagram:bodyTailSockets",
        "rigDiagram:CommonPetRig",
        "lineageCue:softLineageCueSet"
    ]
    let readingOrder = [
        "frontView",
        "sideView",
        "threeQuarterView",
        "socketDiagram",
        "rigDiagram",
        "lineageCue"
    ]
    let callouts = [
        "cuteSilhouette",
        "bodyCenter",
        "tailRoot",
        "CommonPetRig",
        "noColorPatternGlow",
        "noGeneratedGeometry"
    ]
    let summary = "fixedPartReferenceSheetPanelLayout=v1;cueSet:softLineageCueSet;panels:frontView:silhouette,sideView:depth,threeQuarterView:volume,socketDiagram:bodyTailSockets,rigDiagram:CommonPetRig,lineageCue:softLineageCueSet;order:frontView>sideView>threeQuarterView>socketDiagram>rigDiagram>lineageCue;callouts:cuteSilhouette,bodyCenter,tailRoot,CommonPetRig,noColorPatternGlow,noGeneratedGeometry;generatedReferenceSheet:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "lineageCue",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: Array(panelRoles.dropLast()),
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: [
            "frontView",
            "threeQuarterView",
            "sideView",
            "socketDiagram",
            "rigDiagram",
            "lineageCue"
        ],
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: Array(callouts.dropLast()),
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: "softLineageCueSet",
        panelRoles: panelRoles,
        readingOrder: readingOrder,
        requiredCallouts: callouts,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetPanelLayoutReadinessSummary(isReady: true) == "fixedPartReferenceSheetPanelLayoutReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetPanelLayoutReadinessSummary(isReady: false) == "fixedPartReferenceSheetPanelLayoutReady:false")
}

@Test func rendererFixedPartReferenceSheetAcceptanceGateSummaryReportsPreGenerationGate() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetAcceptanceGateSummary(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetAcceptanceGate=v1;cueSet:softLineageCueSet;lineageReferenceReady:true;panelLayoutReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;generatedReferenceSheet:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetAcceptanceGateReadinessRequiresGenerationToStayClosed() {
    let summary = "fixedPartReferenceSheetAcceptanceGate=v1;cueSet:softLineageCueSet;lineageReferenceReady:true;panelLayoutReady:true;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;generatedReferenceSheet:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "lineageCue",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: false,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: "softLineageCueSet",
        lineageReferenceReady: true,
        panelLayoutReady: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        generatedReferenceSheet: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetAcceptanceGateReadinessSummary(isReady: true) == "fixedPartReferenceSheetAcceptanceGateReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetAcceptanceGateReadinessSummary(isReady: false) == "fixedPartReferenceSheetAcceptanceGateReady:false")
}

@Test func rendererFixedPartReferenceSheetArtifactNamingSummaryReportsFuturePNGPath() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetArtifactNamingSummary(
        artifactStem: "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1",
        relativePath: "docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png",
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetArtifactNaming=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;path:docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png;format:png;surface:fixedPartReferenceSheet;cueSet:softLineageCueSet;generatedReferenceSheet:false;manualArtReview:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetArtifactNamingReadinessRequiresUngeneratedUnloadedPNGContract() {
    let stem = "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    let path = "docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png"
    let summary = "fixedPartReferenceSheetArtifactNaming=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;path:docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png;format:png;surface:fixedPartReferenceSheet;cueSet:softLineageCueSet;generatedReferenceSheet:false;manualArtReview:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: "soft_lineage_reference",
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: "docs/reference.png",
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "jpg",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "spriteKit",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "lineageCue",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: true,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: true,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: stem,
        relativePath: path,
        format: "png",
        surface: "fixedPartReferenceSheet",
        cueSetID: "softLineageCueSet",
        generatedReferenceSheet: false,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetArtifactNamingReadinessSummary(isReady: true) == "fixedPartReferenceSheetArtifactNamingReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetArtifactNamingReadinessSummary(isReady: false) == "fixedPartReferenceSheetArtifactNamingReady:false")
}

@Test func rendererFixedPartReferenceSheetManualReviewChecklistSummaryReportsReviewFields() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetManualReviewChecklistSummary(
        artifactStem: "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1",
        reviewerRole: "CreatureArtDirector",
        checklistItems: [
            "cuteSilhouette",
            "panelCompleteness",
            "bodyCenter",
            "tailRoot",
            "CommonPetRig",
            "softLineageCueSet",
            "grayscaleOnly",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ],
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetManualReviewChecklist=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;reviewer:CreatureArtDirector;items:cuteSilhouette,panelCompleteness,bodyCenter,tailRoot,CommonPetRig,softLineageCueSet,grayscaleOnly,noColorPatternGlow,noGeneratedGeometry;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetManualReviewChecklistReadinessRequiresReviewToStayOpen() {
    let stem = "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    let items = [
        "cuteSilhouette",
        "panelCompleteness",
        "bodyCenter",
        "tailRoot",
        "CommonPetRig",
        "softLineageCueSet",
        "grayscaleOnly",
        "noColorPatternGlow",
        "noGeneratedGeometry"
    ]
    let summary = "fixedPartReferenceSheetManualReviewChecklist=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;reviewer:CreatureArtDirector;items:cuteSilhouette,panelCompleteness,bodyCenter,tailRoot,CommonPetRig,softLineageCueSet,grayscaleOnly,noColorPatternGlow,noGeneratedGeometry;manualArtReview:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: "soft_lineage_reference",
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "Renderer",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: Array(items.dropLast()),
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: stem,
        reviewerRole: "CreatureArtDirector",
        checklistItems: items,
        manualArtDirectionReviewed: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetManualReviewChecklistReadinessSummary(isReady: true) == "fixedPartReferenceSheetManualReviewChecklistReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetManualReviewChecklistReadinessSummary(isReady: false) == "fixedPartReferenceSheetManualReviewChecklistReady:false")
}

@Test func rendererFixedPartReferenceSheetManualReviewResultStateSummaryReportsOpenReviewState() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetManualReviewResultStateSummary(
        artifactStem: "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1",
        currentState: "notStarted",
        allowedStates: ["notStarted", "needsRevision", "accepted"],
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetManualReviewResultState=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;state:notStarted;allowed:notStarted,needsRevision,accepted;reviewer:CreatureArtDirector;manualArtReview:false;revisionRequired:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetManualReviewResultStateReadinessRequiresNotStartedState() {
    let stem = "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    let states = ["notStarted", "needsRevision", "accepted"]
    let summary = "fixedPartReferenceSheetManualReviewResultState=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;state:notStarted;allowed:notStarted,needsRevision,accepted;reviewer:CreatureArtDirector;manualArtReview:false;revisionRequired:false;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: "soft_lineage_reference",
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "needsRevision",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "accepted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: true,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: ["notStarted", "accepted"],
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "Renderer",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: true,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: true,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: stem,
        currentState: "notStarted",
        allowedStates: states,
        reviewerRole: "CreatureArtDirector",
        manualArtDirectionReviewed: false,
        revisionRequired: false,
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetManualReviewResultStateReadinessSummary(isReady: true) == "fixedPartReferenceSheetManualReviewResultStateReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetManualReviewResultStateReadinessSummary(isReady: false) == "fixedPartReferenceSheetManualReviewResultStateReady:false")
}

@Test func rendererFixedPartReferenceSheetReviewEvidenceFieldsSummaryReportsEmptyEvidenceSlots() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetReviewEvidenceFieldsSummary(
        artifactStem: "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1",
        evidenceFields: [
            "artifactPath",
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "snapshotReference",
            "decisionReason"
        ],
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetReviewEvidenceFields=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;fields:artifactPath,reviewerNote,checkedItems,visualQAImage,snapshotReference,decisionReason;evidenceRecorded:false;evidencePath:;reviewerNote:;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetReviewEvidenceFieldsReadinessRequiresNoRecordedEvidenceYet() {
    let stem = "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    let fields = [
        "artifactPath",
        "reviewerNote",
        "checkedItems",
        "visualQAImage",
        "snapshotReference",
        "decisionReason"
    ]
    let summary = "fixedPartReferenceSheetReviewEvidenceFields=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;fields:artifactPath,reviewerNote,checkedItems,visualQAImage,snapshotReference,decisionReason;evidenceRecorded:false;evidencePath:;reviewerNote:;snapshotAccepted:false;generationAllowed:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: "soft_lineage_reference",
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: Array(fields.dropLast()),
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: true,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "docs/For_Agent/reference_sheets/review.md",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "Looks soft.",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: true,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: stem,
        evidenceFields: fields,
        evidenceRecorded: false,
        evidencePath: "",
        reviewerNote: "",
        snapshotReferenceAccepted: false,
        generationAllowed: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary(isReady: true) == "fixedPartReferenceSheetReviewEvidenceFieldsReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary(isReady: false) == "fixedPartReferenceSheetReviewEvidenceFieldsReady:false")
}

@Test func rendererFixedPartReferenceSheetPNGCandidatePreflightSummaryReportsClosedGenerationGate() {
    let summary = RendererMetadataSummary.fixedPartReferenceSheetPNGCandidatePreflightSummary(
        artifactStem: "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1",
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartReferenceSheetPNGCandidatePreflight=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;artifactNamingReady:true;manualChecklistReady:true;manualReviewStateReady:true;reviewEvidenceFieldsReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartReferenceSheetPNGCandidatePreflightReadinessRequiresPriorMetadataAndNoCandidate() {
    let stem = "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    let summary = "fixedPartReferenceSheetPNGCandidatePreflight=v1;stem:wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1;artifactNamingReady:true;manualChecklistReady:true;manualReviewStateReady:true;reviewEvidenceFieldsReady:true;candidateExists:false;generationAllowed:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: "soft_lineage_reference",
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: false,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: false,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: false,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: false,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: true,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: true,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "png",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: stem,
        artifactNamingReady: true,
        manualChecklistReady: true,
        manualReviewStateReady: true,
        reviewEvidenceFieldsReady: true,
        candidateExists: false,
        generationAllowed: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: ""
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary(isReady: true) == "fixedPartReferenceSheetPNGCandidatePreflightReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary(isReady: false) == "fixedPartReferenceSheetPNGCandidatePreflightReady:false")
}

@Test func rendererFixedPartAssetSocketMappingSummaryNamesFutureAssetsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartAssetSocketMappingSummary(
        faceMappings: ["softRound->FaceBase.round@headCenter"],
        upperBodyMappings: ["softOval->UpperBody.juvenile@bodyCenter"],
        wingMappings: ["softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot"],
        tailMappings: ["fishTaper->TailBase.fish@tailRoot"],
        socketIDs: ["bodyCenter", "headCenter", "leftWingRoot", "rightWingRoot", "tailRoot"],
        assetOutputs: "none",
        validated3DAssets: false
    )

    #expect(summary == "fixedPartAssetSocketMapping=v1;face:softRound->FaceBase.round@headCenter;upperBody:softOval->UpperBody.juvenile@bodyCenter;wing:softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot;tail:fishTaper->TailBase.fish@tailRoot;sockets:bodyCenter,headCenter,leftWingRoot,rightWingRoot,tailRoot;assetOutputs:none;validated3DAssets:false")
}

@Test func rendererFixedPartAssetSocketMappingReadinessRequiresMappingsSocketsAndSummary() {
    let summary = "fixedPartAssetSocketMapping=v1;face:softRound->FaceBase.round@headCenter;upperBody:softOval->UpperBody.juvenile@bodyCenter;wing:softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot;tail:fishTaper->TailBase.fish@tailRoot;sockets:bodyCenter,headCenter,leftWingRoot,rightWingRoot,tailRoot;assetOutputs:none;validated3DAssets:false"

    #expect(RendererMetadataSummary.hasFixedPartAssetSocketMappingFields(
        faceMappings: ["softRound->FaceBase.round@headCenter"],
        upperBodyMappings: ["softOval->UpperBody.juvenile@bodyCenter"],
        wingMappings: ["softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot"],
        tailMappings: ["fishTaper->TailBase.fish@tailRoot"],
        socketIDs: ["bodyCenter", "headCenter", "leftWingRoot", "rightWingRoot", "tailRoot"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartAssetSocketMappingFields(
        faceMappings: ["softRound->FaceBase.round@headCenter"],
        upperBodyMappings: [],
        wingMappings: ["softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot"],
        tailMappings: ["fishTaper->TailBase.fish@tailRoot"],
        socketIDs: ["bodyCenter"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPartAssetSocketMappingReadinessSummary(isReady: true) == "fixedPartAssetSocketMappingReady:true")
    #expect(RendererMetadataSummary.fixedPartAssetSocketMappingReadinessSummary(isReady: false) == "fixedPartAssetSocketMappingReady:false")
}

@Test func commonPetRigSocketMapNamesTypedFixedPartBindings() {
    let map = CommonPetRigSocketMap()

    #expect(map.hasRequiredFields)
    #expect(map.bindings.count == 4)
    #expect(map.bindings.map(\.family) == [.faceBase, .upperBody, .wingBase, .tailBase])
    #expect(map.bindings[0].summary == "FaceBase:headCenter->head")
    #expect(map.bindings[1].summary == "UpperBody:bodyCenter->body")
    #expect(map.bindings[2].summary == "WingBase:leftWingRoot+rightWingRoot->wing_L+wing_R")
    #expect(map.bindings[3].summary == "TailBase:tailRoot->tail_1")
    #expect(map.summary == "commonPetRigSocketMap=rig:CommonPetRig;bindings:FaceBase:headCenter->head,UpperBody:bodyCenter->body,WingBase:leftWingRoot+rightWingRoot->wing_L+wing_R,TailBase:tailRoot->tail_1;geometryGenerated:false;runtimeLoaded:false;assetOutputs:none;validated3DAssets:false")
    #expect(map.readinessSummary == "commonPetRigSocketMapReady:true")
}

@Test func commonPetRigSocketMapReadinessRejectsMissingFamiliesAssetsAndRuntimeClaims() {
    #expect(!FixedPartSocketBinding(
        family: .faceBase,
        socketIDs: [],
        rigJointIDs: [.head]
    ).hasRequiredFields)
    #expect(!FixedPartSocketBinding(
        family: .faceBase,
        socketIDs: [.headCenter],
        rigJointIDs: []
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        rigID: "OtherRig"
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        bindings: Array(CommonPetRigSocketMap.defaultBindings.dropLast())
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        allowsGeneratedGeometry: true
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        allowsRuntimeAssetLoad: true
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        assetOutputs: "glb"
    ).hasRequiredFields)
    #expect(!CommonPetRigSocketMap(
        validated3DAssets: true
    ).hasRequiredFields)
}

@Test func commonPetRigAssetValidationPreflightDefers3DFrameworksUntilArtifactsExist() {
    let preflight = CommonPetRigAssetValidationPreflight()

    #expect(preflight.isDeferredSafely)
    #expect(!preflight.validationAllowed)
    #expect(preflight.summary == "commonPetRigAssetValidationPreflight=rig:CommonPetRig;socketMapReady:true;referenceArtifact:false;assetCandidate:false;modelIO:false;sceneKit:false;realityKit:false;validationAllowed:false;deferredSafely:true;geometryGenerated:false;runtimeLoaded:false;assetOutputs:none")
    #expect(preflight.readinessSummary == "commonPetRigAssetValidationPreflightReady:true")
}

@Test func commonPetRigAssetValidationPreflightAllowsValidationOnlyAfterArtifactEvidence() {
    let preflight = CommonPetRigAssetValidationPreflight(
        hasAcceptedReferenceArtifact: true,
        usesModelIO: true
    )

    #expect(preflight.hasArtifactEvidence)
    #expect(!preflight.isDeferredSafely)
    #expect(preflight.validationAllowed)
    #expect(preflight.summary == "commonPetRigAssetValidationPreflight=rig:CommonPetRig;socketMapReady:true;referenceArtifact:true;assetCandidate:false;modelIO:true;sceneKit:false;realityKit:false;validationAllowed:true;deferredSafely:false;geometryGenerated:false;runtimeLoaded:false;assetOutputs:none")
    #expect(preflight.readinessSummary == "commonPetRigAssetValidationPreflightReady:true")
}

@Test func commonPetRigAssetValidationPreflightRejectsPrematureFrameworksAndRuntimeClaims() {
    let prematureModelIO = CommonPetRigAssetValidationPreflight(
        usesModelIO: true
    )

    #expect(!prematureModelIO.validationAllowed)
    #expect(!prematureModelIO.isDeferredSafely)
    #expect(prematureModelIO.readinessSummary == "commonPetRigAssetValidationPreflightReady:false")
    #expect(!CommonPetRigAssetValidationPreflight(
        hasAssetCandidate: true,
        usesSceneKit: true
    ).validationAllowed)
    #expect(!CommonPetRigAssetValidationPreflight(
        hasAssetCandidate: true,
        usesRealityKit: true
    ).validationAllowed)
    #expect(!CommonPetRigAssetValidationPreflight(
        hasAcceptedReferenceArtifact: true,
        usesModelIO: true,
        allowsGeneratedGeometry: true
    ).validationAllowed)
    #expect(!CommonPetRigAssetValidationPreflight(
        hasAcceptedReferenceArtifact: true,
        usesModelIO: true,
        allowsRuntimeAssetLoad: true
    ).validationAllowed)
    #expect(!CommonPetRigAssetValidationPreflight(
        hasAcceptedReferenceArtifact: true,
        usesModelIO: true,
        assetOutputs: "glb"
    ).validationAllowed)
    #expect(!CommonPetRigAssetValidationPreflight(
        socketMap: CommonPetRigSocketMap(rigID: "CreatureRig"),
        hasAcceptedReferenceArtifact: true,
        usesModelIO: true
    ).validationAllowed)
}

@Test func rendererFixedPartUpperBodyProportionHandoffSummaryNamesFutureBodiesAndPanels() {
    let mappings = [
        "waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue",
        "seedPetal|petalSlim|tallSprout|lightFairySeed->UpperBody.sylphian@bodyCenter#proportionCue",
        "pebbleGem|gemBalanced|tallFacet|softPebbleGem->UpperBody.crystalian@bodyCenter#proportionCue",
        "moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue",
        "leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue"
    ]
    let summary = RendererMetadataSummary.fixedPartUpperBodyProportionHandoffSummary(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram"],
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartUpperBodyProportionHandoff=v1;mappings:waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue,seedPetal|petalSlim|tallSprout|lightFairySeed->UpperBody.sylphian@bodyCenter#proportionCue,pebbleGem|gemBalanced|tallFacet|softPebbleGem->UpperBody.crystalian@bodyCenter#proportionCue,moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue,leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue;socket:bodyCenter;rig:body;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPartUpperBodyProportionHandoffReadinessRequiresAllBodiesAndNoAssets() {
    let mappings = [
        "waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue",
        "seedPetal|petalSlim|tallSprout|lightFairySeed->UpperBody.sylphian@bodyCenter#proportionCue",
        "pebbleGem|gemBalanced|tallFacet|softPebbleGem->UpperBody.crystalian@bodyCenter#proportionCue",
        "moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue",
        "leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue"
    ]
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram"]
    let summary = "fixedPartUpperBodyProportionHandoff=v1;mappings:waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue,seedPetal|petalSlim|tallSprout|lightFairySeed->UpperBody.sylphian@bodyCenter#proportionCue,pebbleGem|gemBalanced|tallFacet|softPebbleGem->UpperBody.crystalian@bodyCenter#proportionCue,moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue,leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue;socket:bodyCenter;rig:body;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram;generatedAssets:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: panels,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: Array(mappings.dropLast()),
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: panels,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "headCenter",
        rigTarget: "body",
        requiredPanels: panels,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "spine_1",
        requiredPanels: panels,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: ["frontView", "socketDiagram"],
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: panels,
        generatedAssets: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
        mappings: mappings,
        socketID: "bodyCenter",
        rigTarget: "body",
        requiredPanels: panels,
        generatedAssets: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartUpperBodyProportionHandoffReadinessSummary(isReady: true) == "fixedPartUpperBodyProportionHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartUpperBodyProportionHandoffReadinessSummary(isReady: false) == "fixedPartUpperBodyProportionHandoffReady:false")
}

@Test func rendererFixedPartTailFloatingHandoffSummaryNamesFloatingTailPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartTailFloatingHandoffSummary(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartTailFloatingHandoff=v1;mapping:floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:floatingRibbon+softTetherDot;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartTailFloatingHandoffReadinessRequiresFloatingCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartTailFloatingHandoff=v1;mapping:floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:floatingRibbon+softTetherDot;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailTip",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_2",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
        mapping: "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartTailFloatingHandoffReadinessSummary(isReady: true) == "fixedPartTailFloatingHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartTailFloatingHandoffReadinessSummary(isReady: false) == "fixedPartTailFloatingHandoffReady:false")
}

@Test func rendererFixedPartTailDragonHandoffSummaryNamesDragonTailPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartTailDragonHandoffSummary(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartTailDragonHandoff=v1;mapping:longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:longDrake+softDrakeRidge;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartTailDragonHandoffReadinessRequiresDragonCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartTailDragonHandoff=v1;mapping:longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:longDrake+softDrakeRidge;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailTip",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_2",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
        mapping: "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "longDrake+softDrakeRidge",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartTailDragonHandoffReadinessSummary(isReady: true) == "fixedPartTailDragonHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartTailDragonHandoffReadinessSummary(isReady: false) == "fixedPartTailDragonHandoffReady:false")
}

@Test func rendererFixedPartTailFishHandoffSummaryNamesFishTailPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartTailFishHandoffSummary(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartTailFishHandoff=v1;mapping:fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:fishFin+softForkFin;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartTailFishHandoffReadinessRequiresFishCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartTailFishHandoff=v1;mapping:fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:fishFin+softForkFin;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailTip",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_2",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
        mapping: "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "fishFin+softForkFin",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartTailFishHandoffReadinessSummary(isReady: true) == "fixedPartTailFishHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartTailFishHandoffReadinessSummary(isReady: false) == "fixedPartTailFishHandoffReady:false")
}

@Test func rendererFixedPartTailPlantHandoffSummaryNamesPlantTailPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartTailPlantHandoffSummary(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartTailPlantHandoff=v1;mapping:leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:leafSprout+softLeafVein;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartTailPlantHandoffReadinessRequiresPlantCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartTailPlantHandoff=v1;mapping:leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue;socket:tailRoot;rig:tail_1;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:leafSprout+softLeafVein;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailTip",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_2",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
        mapping: "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue",
        socketID: "tailRoot",
        rigTarget: "tail_1",
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafSprout+softLeafVein",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartTailPlantHandoffReadinessSummary(isReady: true) == "fixedPartTailPlantHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartTailPlantHandoffReadinessSummary(isReady: false) == "fixedPartTailPlantHandoffReady:false")
}

@Test func rendererFixedPartFaceDeerHandoffSummaryNamesDeerFacePanelsAndSocket() {
    let summary = RendererMetadataSummary.fixedPartFaceDeerHandoffSummary(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartFaceDeerHandoff=v1;mapping:softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue;socket:headCenter;rig:head;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:softDeer+softEarNubs;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartFaceDeerHandoffReadinessRequiresDeerCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartFaceDeerHandoff=v1;mapping:softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue;socket:headCenter;rig:head;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:softDeer+softEarNubs;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@faceCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "faceCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "neck",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
        mapping: "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softDeer+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartFaceDeerHandoffReadinessSummary(isReady: true) == "fixedPartFaceDeerHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartFaceDeerHandoffReadinessSummary(isReady: false) == "fixedPartFaceDeerHandoffReady:false")
}

@Test func rendererFixedPartFaceFelineHandoffSummaryNamesFelineFacePanelsAndSocket() {
    let summary = RendererMetadataSummary.fixedPartFaceFelineHandoffSummary(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartFaceFelineHandoff=v1;mapping:softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue;socket:headCenter;rig:head;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:softFeline+softEarTips;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartFaceFelineHandoffReadinessRequiresFelineCueAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartFaceFelineHandoff=v1;mapping:softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue;socket:headCenter;rig:head;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:softFeline+softEarTips;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@faceCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "faceCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "neck",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarNubs",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
        mapping: "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue",
        socketID: "headCenter",
        rigTarget: "head",
        requiredPanels: panels,
        acceptedSpriteKitCue: "softFeline+softEarTips",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartFaceFelineHandoffReadinessSummary(isReady: true) == "fixedPartFaceFelineHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartFaceFelineHandoffReadinessSummary(isReady: false) == "fixedPartFaceFelineHandoffReady:false")
}

@Test func rendererFixedPartFaceBaseReferenceEvidenceHandoffSummaryReportsAcceptedFaceEvidenceSlots() {
    let summary = RendererMetadataSummary.fixedPartFaceBaseReferenceEvidenceHandoffSummary(
        sourceCues: ["softDeer+softEarNubs", "softFeline+softEarTips"],
        faceBases: ["deer", "feline"],
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartFaceBaseReferenceEvidenceHandoff=v1;cues:softDeer+softEarNubs|softFeline+softEarTips;faceBases:deer+feline;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;socket:headCenter;rig:head;silhouette:secondarySoftEarAccessories;manualQA:true;evidenceRecorded:false;geometryGenerated:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartFaceBaseReferenceEvidenceHandoffReadinessRequiresAcceptedFaceCuesAndNoAssets() {
    let cues = ["softDeer+softEarNubs", "softFeline+softEarTips"]
    let faceBases = ["deer", "feline"]
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let readySummary = "fixedPartFaceBaseReferenceEvidenceHandoff=v1;cues:softDeer+softEarNubs|softFeline+softEarTips;faceBases:deer+feline;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;socket:headCenter;rig:head;silhouette:secondarySoftEarAccessories;manualQA:true;evidenceRecorded:false;geometryGenerated:false;snapshotAccepted:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: ["softDeer+softEarNubs"],
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: ["deer"],
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: ["frontView", "socketDiagram", "rigDiagram", "accessoryCue"],
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "faceCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "neck",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "sharpEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: false,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: true,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: true,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: readySummary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: cues,
        faceBases: faceBases,
        requiredPanels: panels,
        socketID: "headCenter",
        rigTarget: "head",
        silhouetteRule: "secondarySoftEarAccessories",
        manualVisualQAAccepted: true,
        evidenceRecorded: false,
        generatedGeometry: false,
        snapshotReferenceAccepted: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: readySummary
    ))

    #expect(RendererMetadataSummary.fixedPartFaceBaseReferenceEvidenceHandoffReadinessSummary(isReady: true) == "fixedPartFaceBaseReferenceEvidenceHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartFaceBaseReferenceEvidenceHandoffReadinessSummary(isReady: false) == "fixedPartFaceBaseReferenceEvidenceHandoffReady:false")
}

@Test func rendererFixedPartWingFairyHandoffSummaryNamesFairyWingPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartWingFairyHandoffSummary(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartWingFairyHandoff=v1;mapping:leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue;sockets:leftWingRoot+rightWingRoot;rig:wing_L+wing_R;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:leafPair+softWingTipPearl;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartWingFairyHandoffReadinessRequiresFairyCuePairedSocketsAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartWingFairyHandoff=v1;mapping:leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue;sockets:leftWingRoot+rightWingRoot;rig:wing_L+wing_R;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:leafPair+softWingTipPearl;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
        mapping: "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "leafPair+softWingTipPearl",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartWingFairyHandoffReadinessSummary(isReady: true) == "fixedPartWingFairyHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartWingFairyHandoffReadinessSummary(isReady: false) == "fixedPartWingFairyHandoffReady:false")
}

@Test func rendererFixedPartWingDragonHandoffSummaryNamesDragonWingPanelsAndSockets() {
    let summary = RendererMetadataSummary.fixedPartWingDragonHandoffSummary(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"],
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartWingDragonHandoff=v1;mapping:wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue;sockets:leftWingRoot+rightWingRoot;rig:wing_L+wing_R;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:wideSail+softWingTipClaw;generatedAssets:false;runtimeLoaded:false;assetOutputs:none")
}

@Test func rendererFixedPartWingDragonHandoffReadinessRequiresDragonCuePairedSocketsAndClosedAssetGates() {
    let panels = ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"]
    let summary = "fixedPartWingDragonHandoff=v1;mapping:wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue;sockets:leftWingRoot+rightWingRoot;rig:wing_L+wing_R;panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue;acceptedCue:wideSail+softWingTipClaw;generatedAssets:false;runtimeLoaded:false;assetOutputs:none"

    #expect(RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: ["frontView", "socketDiagram"],
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: true,
        runtimeLoaded: false,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: true,
        assetOutputs: "none",
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
        mapping: "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue",
        socketIDs: ["leftWingRoot", "rightWingRoot"],
        rigTargets: ["wing_L", "wing_R"],
        requiredPanels: panels,
        acceptedSpriteKitCue: "wideSail+softWingTipClaw",
        generatedAssets: false,
        runtimeLoaded: false,
        assetOutputs: "glb",
        summary: summary
    ))
    #expect(RendererMetadataSummary.fixedPartWingDragonHandoffReadinessSummary(isReady: true) == "fixedPartWingDragonHandoffReady:true")
    #expect(RendererMetadataSummary.fixedPartWingDragonHandoffReadinessSummary(isReady: false) == "fixedPartWingDragonHandoffReady:false")
}

@Test func rendererFixedPart3DManifestSummaryNamesFutureGLBUSDAssetsAndCommonRig() {
    let summary = RendererMetadataSummary.fixedPart3DManifestSummary(
        assetStems: [
            "wipet_face_round_head_v001",
            "wipet_face_deer_head_v001",
            "wipet_upperbody_aquarian_baby_v001",
            "wipet_wing_plant_pair_v001",
            "wipet_tail_floating_tail_v001"
        ],
        formats: ["glb", "usd"],
        rigName: "CommonPetRig",
        requiredBones: ["root", "body", "spine_1", "spine_2", "neck", "head", "wing_L", "wing_R", "tail_1"],
        socketMappings: ["bodyCenter->body", "headCenter->head", "leftWingRoot->wing_L", "rightWingRoot->wing_R", "tailRoot->tail_1"],
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false
    )

    #expect(summary == "fixedPart3DManifest=v1;assets:wipet_face_round_head_v001,wipet_face_deer_head_v001,wipet_upperbody_aquarian_baby_v001,wipet_wing_plant_pair_v001,wipet_tail_floating_tail_v001;formats:glb,usd;rig:CommonPetRig;bones:root,body,spine_1,spine_2,neck,head,wing_L,wing_R,tail_1;sockets:bodyCenter->body,headCenter->head,leftWingRoot->wing_L,rightWingRoot->wing_R,tailRoot->tail_1;grayscaleOnly:true;excludesColorPatternGlow:true;validatedAssets:false;generatedAssets:false")
}

@Test func rendererFixedPart3DManifestReadinessRequiresManifestBoundary() {
    let assetStems = [
        "wipet_face_round_head_v001",
        "wipet_face_deer_head_v001",
        "wipet_upperbody_aquarian_baby_v001",
        "wipet_wing_plant_pair_v001",
        "wipet_tail_floating_tail_v001"
    ]
    let formats = ["glb", "usd"]
    let bones = ["root", "body", "spine_1", "spine_2", "neck", "head", "wing_L", "wing_R", "tail_1"]
    let sockets = ["bodyCenter->body", "headCenter->head", "leftWingRoot->wing_L", "rightWingRoot->wing_R", "tailRoot->tail_1"]
    let summary = "fixedPart3DManifest=v1;assets:wipet_face_round_head_v001,wipet_face_deer_head_v001,wipet_upperbody_aquarian_baby_v001,wipet_wing_plant_pair_v001,wipet_tail_floating_tail_v001;formats:glb,usd;rig:CommonPetRig;bones:root,body,spine_1,spine_2,neck,head,wing_L,wing_R,tail_1;sockets:bodyCenter->body,headCenter->head,leftWingRoot->wing_L,rightWingRoot->wing_R,tailRoot->tail_1;grayscaleOnly:true;excludesColorPatternGlow:true;validatedAssets:false;generatedAssets:false"

    #expect(RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: [],
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: ["face_round_head_v001"],
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: ["glb"],
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CreatureRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: ["root", "body", "head"],
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: ["bodyCenter->body"],
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: false,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: false,
        validatedAssets: false,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: true,
        generatedAssets: false,
        summary: summary
    ))
    #expect(!RendererMetadataSummary.hasFixedPart3DManifestFields(
        assetStems: assetStems,
        formats: formats,
        rigName: "CommonPetRig",
        requiredBones: bones,
        socketMappings: sockets,
        grayscaleOnly: true,
        excludesColorPatternGlow: true,
        validatedAssets: false,
        generatedAssets: true,
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPart3DManifestReadinessSummary(isReady: true) == "fixedPart3DManifestReady:true")
    #expect(RendererMetadataSummary.fixedPart3DManifestReadinessSummary(isReady: false) == "fixedPart3DManifestReady:false")
}

@Test func rendererFixedPart3DReferenceAcceptanceGateSummaryKeepsApple3DFrameworksDeferred() {
    let summary = RendererMetadataSummary.fixedPart3DReferenceAcceptanceGateSummary(
        cueSetID: "softLineageCueSet",
        referenceSheetReady: true,
        panelLayoutReady: true,
        referenceAcceptanceReady: true,
        artifactNamingReady: true,
        manualReviewChecklistReady: true,
        childDraftGateReady: true,
        modelIODeferred: true,
        sceneKitDeferred: true,
        realityKitDeferred: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPart3DReferenceAcceptanceGate=v1;cueSet:softLineageCueSet;referenceSheetReady:true;panelLayoutReady:true;referenceAcceptanceReady:true;artifactNamingReady:true;manualReviewChecklistReady:true;childDraftGateReady:true;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none")
}

@Test func rendererFixedPart3DReferenceAcceptanceGateReadinessRequiresClosedNoAssetState() {
    let summary = "fixedPart3DReferenceAcceptanceGate=v1;cueSet:softLineageCueSet;referenceSheetReady:true;panelLayoutReady:true;referenceAcceptanceReady:true;artifactNamingReady:true;manualReviewChecklistReady:true;childDraftGateReady:true;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none"

    func isReady(
        cueSetID: String = "softLineageCueSet",
        referenceSheetReady: Bool = true,
        panelLayoutReady: Bool = true,
        referenceAcceptanceReady: Bool = true,
        artifactNamingReady: Bool = true,
        manualReviewChecklistReady: Bool = true,
        childDraftGateReady: Bool = true,
        modelIODeferred: Bool = true,
        sceneKitDeferred: Bool = true,
        realityKitDeferred: Bool = true,
        generationAllowed: Bool = false,
        runtimeLoaded: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasFixedPart3DReferenceAcceptanceGateFields(
            cueSetID: cueSetID,
            referenceSheetReady: referenceSheetReady,
            panelLayoutReady: panelLayoutReady,
            referenceAcceptanceReady: referenceAcceptanceReady,
            artifactNamingReady: artifactNamingReady,
            manualReviewChecklistReady: manualReviewChecklistReady,
            childDraftGateReady: childDraftGateReady,
            modelIODeferred: modelIODeferred,
            sceneKitDeferred: sceneKitDeferred,
            realityKitDeferred: realityKitDeferred,
            generationAllowed: generationAllowed,
            runtimeLoaded: runtimeLoaded,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(cueSetID: "dragonWingCueSet"))
    #expect(!isReady(referenceSheetReady: false))
    #expect(!isReady(panelLayoutReady: false))
    #expect(!isReady(referenceAcceptanceReady: false))
    #expect(!isReady(artifactNamingReady: false))
    #expect(!isReady(manualReviewChecklistReady: false))
    #expect(!isReady(childDraftGateReady: false))
    #expect(!isReady(modelIODeferred: false))
    #expect(!isReady(sceneKitDeferred: false))
    #expect(!isReady(realityKitDeferred: false))
    #expect(!isReady(generationAllowed: true))
    #expect(!isReady(runtimeLoaded: true))
    #expect(!isReady(generatedAssets: true))
    #expect(!isReady(assetOutputs: "glb"))
    #expect(!isReady(summary: ""))

    #expect(RendererMetadataSummary.fixedPart3DReferenceAcceptanceGateReadinessSummary(isReady: true) == "fixedPart3DReferenceAcceptanceGateReady:true")
    #expect(RendererMetadataSummary.fixedPart3DReferenceAcceptanceGateReadinessSummary(isReady: false) == "fixedPart3DReferenceAcceptanceGateReady:false")
}

@Test func rendererFixedPartAssetPipelineResumeGateReportsBlocked3DState() {
    let summary = RendererMetadataSummary.fixedPartAssetPipelineResumeGateSummary(
        manifestReady: true,
        rigPreflightDeferredSafely: true,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: false,
        manualReferenceAccepted: false,
        modelIODeferred: true,
        sceneKitDeferred: true,
        realityKitDeferred: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAssetPipelineResumeGate=v1;manifestReady:true;rigPreflightDeferred:true;referenceGateReady:true;appHostResume:false;manualReferenceAccepted:false;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none;resume:false")
    #expect(!RendererMetadataSummary.canResumeFixedPartAssetPipeline(
        manifestReady: true,
        rigPreflightDeferredSafely: true,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: false,
        manualReferenceAccepted: false,
        modelIODeferred: true,
        sceneKitDeferred: true,
        realityKitDeferred: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    ))
}

@Test func rendererFixedPartAssetPipelineResumeGateRequiresAcceptedReferencesAndAppHostQA() {
    let summary = "fixedPartAssetPipelineResumeGate=v1;manifestReady:true;rigPreflightDeferred:true;referenceGateReady:true;appHostResume:false;manualReferenceAccepted:false;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none;resume:false"

    func blockedGateReady(
        manifestReady: Bool = true,
        rigPreflightDeferredSafely: Bool = true,
        referenceAcceptanceGateReady: Bool = true,
        appHostVisualQAResumeReady: Bool = false,
        manualReferenceAccepted: Bool = false,
        modelIODeferred: Bool = true,
        sceneKitDeferred: Bool = true,
        realityKitDeferred: Bool = true,
        generationAllowed: Bool = false,
        runtimeLoaded: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasFixedPartAssetPipelineResumeGateFields(
            manifestReady: manifestReady,
            rigPreflightDeferredSafely: rigPreflightDeferredSafely,
            referenceAcceptanceGateReady: referenceAcceptanceGateReady,
            appHostVisualQAResumeReady: appHostVisualQAResumeReady,
            manualReferenceAccepted: manualReferenceAccepted,
            modelIODeferred: modelIODeferred,
            sceneKitDeferred: sceneKitDeferred,
            realityKitDeferred: realityKitDeferred,
            generationAllowed: generationAllowed,
            runtimeLoaded: runtimeLoaded,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(blockedGateReady())
    #expect(!blockedGateReady(manifestReady: false))
    #expect(!blockedGateReady(rigPreflightDeferredSafely: false))
    #expect(!blockedGateReady(referenceAcceptanceGateReady: false))
    #expect(!blockedGateReady(appHostVisualQAResumeReady: true))
    #expect(!blockedGateReady(manualReferenceAccepted: true))
    #expect(!blockedGateReady(modelIODeferred: false))
    #expect(!blockedGateReady(sceneKitDeferred: false))
    #expect(!blockedGateReady(realityKitDeferred: false))
    #expect(!blockedGateReady(generationAllowed: true))
    #expect(!blockedGateReady(runtimeLoaded: true))
    #expect(!blockedGateReady(generatedAssets: true))
    #expect(!blockedGateReady(assetOutputs: "glb"))
    #expect(!blockedGateReady(summary: ""))

    #expect(RendererMetadataSummary.canResumeFixedPartAssetPipeline(
        manifestReady: true,
        rigPreflightDeferredSafely: false,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: true,
        manualReferenceAccepted: true,
        modelIODeferred: false,
        sceneKitDeferred: false,
        realityKitDeferred: false,
        generationAllowed: true,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    ))
    #expect(RendererMetadataSummary.fixedPartAssetPipelineResumeGateReadinessSummary(isReady: true) == "fixedPartAssetPipelineResumeGateReady:true")
    #expect(RendererMetadataSummary.fixedPartAssetPipelineResumeGateReadinessSummary(isReady: false) == "fixedPartAssetPipelineResumeGateReady:false")
}

@Test func rendererFixedPartAssetPipelineReadinessLedgerReportsBlockedNextAction() {
    let summary = RendererMetadataSummary.fixedPartAssetPipelineReadinessLedgerSummary(
        manifestReady: true,
        rigPreflightDeferredSafely: true,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: false,
        manualReferenceAccepted: false,
        modelIODeferred: true,
        sceneKitDeferred: true,
        realityKitDeferred: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary == "fixedPartAssetPipelineReadinessLedger=v1;manifestReady:true;rigPreflightDeferred:true;referenceGateReady:true;appHostResume:false;manualReferenceAccepted:false;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none;next:waitForReferenceAndAppHostQA;resume:false")
    #expect(RendererMetadataSummary.hasFixedPartAssetPipelineReadinessLedgerFields(
        manifestReady: true,
        rigPreflightDeferredSafely: true,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: false,
        manualReferenceAccepted: false,
        modelIODeferred: true,
        sceneKitDeferred: true,
        realityKitDeferred: true,
        generationAllowed: false,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none",
        summary: summary
    ))
}

@Test func rendererFixedPartAssetPipelineReadinessLedgerRejectsPrematureFrameworkOrAssetState() {
    let summary = "fixedPartAssetPipelineReadinessLedger=v1;manifestReady:true;rigPreflightDeferred:true;referenceGateReady:true;appHostResume:false;manualReferenceAccepted:false;modelIODeferred:true;sceneKitDeferred:true;realityKitDeferred:true;generationAllowed:false;runtimeLoaded:false;generatedAssets:false;assetOutputs:none;next:waitForReferenceAndAppHostQA;resume:false"

    func isReady(
        manifestReady: Bool = true,
        rigPreflightDeferredSafely: Bool = true,
        referenceAcceptanceGateReady: Bool = true,
        appHostVisualQAResumeReady: Bool = false,
        manualReferenceAccepted: Bool = false,
        modelIODeferred: Bool = true,
        sceneKitDeferred: Bool = true,
        realityKitDeferred: Bool = true,
        generationAllowed: Bool = false,
        runtimeLoaded: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        summary: String = summary
    ) -> Bool {
        RendererMetadataSummary.hasFixedPartAssetPipelineReadinessLedgerFields(
            manifestReady: manifestReady,
            rigPreflightDeferredSafely: rigPreflightDeferredSafely,
            referenceAcceptanceGateReady: referenceAcceptanceGateReady,
            appHostVisualQAResumeReady: appHostVisualQAResumeReady,
            manualReferenceAccepted: manualReferenceAccepted,
            modelIODeferred: modelIODeferred,
            sceneKitDeferred: sceneKitDeferred,
            realityKitDeferred: realityKitDeferred,
            generationAllowed: generationAllowed,
            runtimeLoaded: runtimeLoaded,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs,
            summary: summary
        )
    }

    #expect(isReady())
    #expect(!isReady(manifestReady: false))
    #expect(!isReady(rigPreflightDeferredSafely: false))
    #expect(!isReady(referenceAcceptanceGateReady: false))
    #expect(!isReady(appHostVisualQAResumeReady: true))
    #expect(!isReady(manualReferenceAccepted: true))
    #expect(!isReady(modelIODeferred: false))
    #expect(!isReady(sceneKitDeferred: false))
    #expect(!isReady(realityKitDeferred: false))
    #expect(!isReady(generationAllowed: true))
    #expect(!isReady(runtimeLoaded: true))
    #expect(!isReady(generatedAssets: true))
    #expect(!isReady(assetOutputs: "glb"))
    #expect(!isReady(summary: ""))
    #expect(RendererMetadataSummary.fixedPartAssetPipelineReadinessLedgerReadinessSummary(isReady: true) == "fixedPartAssetPipelineReadinessLedgerReady:true")
    #expect(RendererMetadataSummary.fixedPartAssetPipelineReadinessLedgerReadinessSummary(isReady: false) == "fixedPartAssetPipelineReadinessLedgerReady:false")
}

@Test func rendererFixedPartAssetPipelineReadinessLedgerNamesFutureModelIOValidation() {
    let summary = RendererMetadataSummary.fixedPartAssetPipelineReadinessLedgerSummary(
        manifestReady: true,
        rigPreflightDeferredSafely: false,
        referenceAcceptanceGateReady: true,
        appHostVisualQAResumeReady: true,
        manualReferenceAccepted: true,
        modelIODeferred: false,
        sceneKitDeferred: false,
        realityKitDeferred: false,
        generationAllowed: true,
        runtimeLoaded: false,
        generatedAssets: false,
        assetOutputs: "none"
    )

    #expect(summary.contains("next:beginModelIOValidation"))
    #expect(summary.contains("resume:true"))
}

@Test func rendererFixedPartReferenceCoverageSummaryReportsCurrentBasesAndMissingIntent() {
    let summary = RendererMetadataSummary.fixedPartReferenceCoverageSummary(
        faceBases: ["round", "fairy", "dragon", "axolotl", "crystal", "deer", "feline", "lunar"],
        bodyBases: ["aquarian", "sylphian", "crystalian", "lunarian", "verdant"],
        wingBases: ["fairy", "dragon", "crystal", "jellyfish", "lunar", "plant"],
        tailBases: ["dragon", "fish", "crystal", "floating", "plant"],
        optionalValidBases: ["wing:none", "tail:none"],
        missingFaceBases: [],
        missingWingBases: [],
        missingTailBases: [],
        missingUpperBodyIntent: "babyAdultDeltas",
        missingHornIntent: "all",
        missingEarIntent: "all",
        missingCrystalIntent: "all",
        missingGlowIntent: "all"
    )

    #expect(
        summary == "fixedPart2DReferenceCoverage=face:8/8(round,fairy,dragon,axolotl,crystal,deer,feline,lunar);body:5/5(aquarian,sylphian,crystalian,lunarian,verdant);wing:6/6(fairy,dragon,crystal,jellyfish,lunar,plant);tail:5/5(dragon,fish,crystal,floating,plant);optionalValid=wing:none,tail:none;missingIntent=face();wing();tail();upperBody:babyAdultDeltas;horn:all;ear:all;crystal:all;glow:all"
    )
}

@Test func rendererFixedPartReferenceCoverageReadinessRequiresCoverageAndMissingIntent() {
    let summary = "fixedPart2DReferenceCoverage=face:8/8(round,fairy,dragon,axolotl,crystal,deer,feline,lunar);body:5/5(aquarian,sylphian,crystalian,lunarian,verdant);wing:6/6(fairy,dragon,crystal,jellyfish,lunar,plant);tail:5/5(dragon,fish,crystal,floating,plant);optionalValid=wing:none,tail:none;missingIntent=face();wing();tail();upperBody:babyAdultDeltas;horn:all;ear:all;crystal:all;glow:all"

    #expect(RendererMetadataSummary.hasFixedPartReferenceCoverageFields(
        faceBases: ["round", "fairy", "dragon", "axolotl", "crystal", "deer", "feline", "lunar"],
        bodyBases: ["aquarian", "sylphian", "crystalian", "lunarian", "verdant"],
        wingBases: ["fairy", "dragon", "crystal", "jellyfish", "lunar", "plant"],
        tailBases: ["dragon", "fish", "crystal", "floating", "plant"],
        optionalValidBases: ["wing:none", "tail:none"],
        missingFaceBases: [],
        missingWingBases: [],
        missingTailBases: [],
        missingUpperBodyIntent: "babyAdultDeltas",
        missingHornIntent: "all",
        missingEarIntent: "all",
        missingCrystalIntent: "all",
        missingGlowIntent: "all",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartReferenceCoverageFields(
        faceBases: ["round", "fairy", "dragon", "axolotl", "crystal", "deer", "feline", "lunar"],
        bodyBases: ["aquarian", "sylphian", "crystalian", "lunarian", "verdant"],
        wingBases: [],
        tailBases: ["dragon", "fish", "crystal", "floating"],
        optionalValidBases: ["wing:none", "tail:none"],
        missingFaceBases: [],
        missingWingBases: [],
        missingTailBases: [],
        missingUpperBodyIntent: "babyAdultDeltas",
        missingHornIntent: "all",
        missingEarIntent: "all",
        missingCrystalIntent: "all",
        missingGlowIntent: "all",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPartReferenceCoverageReadinessSummary(isReady: true) == "fixedPartReferenceCoverageMetadataReady:true")
    #expect(RendererMetadataSummary.fixedPartReferenceCoverageReadinessSummary(isReady: false) == "fixedPartReferenceCoverageMetadataReady:false")
}

@Test func rendererFixedPartCatalogArtDirectionSummaryReportsFamilyIntentAndAffection() {
    let summary = RendererMetadataSummary.fixedPartCatalogArtDirectionSummary(
        familyIDs: ["lunarWing", "floatingTail", "juvenileBody"],
        silhouetteIntents: ["softArc", "moonRibbon", "roundBelly"],
        affectionCues: ["protective", "ancestralGlow", "touchable"],
        assetOutputs: "none",
        geometryChanged: false
    )

    #expect(summary == "fixedPartCatalogArtDirection=families:lunarWing,floatingTail,juvenileBody;silhouette:softArc,moonRibbon,roundBelly;affection:protective,ancestralGlow,touchable;assetOutputs:none;geometryChanged:false")
}

@Test func rendererFixedPartCatalogArtDirectionReadinessRequiresAlignedFields() {
    let summary = "fixedPartCatalogArtDirection=families:lunarWing,floatingTail;silhouette:softArc,moonRibbon;affection:protective,ancestralGlow;assetOutputs:none;geometryChanged:false"

    #expect(RendererMetadataSummary.hasFixedPartCatalogArtDirectionFields(
        familyIDs: ["lunarWing", "floatingTail"],
        silhouetteIntents: ["softArc", "moonRibbon"],
        affectionCues: ["protective", "ancestralGlow"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartCatalogArtDirectionFields(
        familyIDs: ["lunarWing", "floatingTail"],
        silhouetteIntents: ["softArc"],
        affectionCues: ["protective", "ancestralGlow"],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartCatalogArtDirectionFields(
        familyIDs: ["lunarWing", "floatingTail"],
        silhouetteIntents: ["softArc", "moonRibbon"],
        affectionCues: ["protective", ""],
        assetOutputs: "none",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPartCatalogArtDirectionReadinessSummary(isReady: true) == "fixedPartCatalogArtDirectionReady:true")
    #expect(RendererMetadataSummary.fixedPartCatalogArtDirectionReadinessSummary(isReady: false) == "fixedPartCatalogArtDirectionReady:false")
}

@Test func rendererFixedPartLineageAffectionSummaryReportsAncestorContextWithoutPlayerFacingCopy() {
    let summary = RendererMetadataSummary.fixedPartLineageAffectionSummary(
        familyIDs: ["floatingTail", "roundHead"],
        affectionCues: ["ancestralGlow", "approachable"],
        ancestorContext: "ancestorEcho",
        assetOutputs: "none",
        playerFacing: false
    )

    #expect(summary == "fixedPartLineageAffection=families:floatingTail,roundHead;affection:ancestralGlow,approachable;ancestor:ancestorEcho;assetOutputs:none;playerFacing:false")
}

@Test func rendererFixedPartLineageAffectionReadinessRequiresAlignedFamilyAndCueFields() {
    let summary = "fixedPartLineageAffection=families:floatingTail,roundHead;affection:ancestralGlow,approachable;ancestor:ancestorEcho;assetOutputs:none;playerFacing:false"

    #expect(RendererMetadataSummary.hasFixedPartLineageAffectionFields(
        familyIDs: ["floatingTail", "roundHead"],
        affectionCues: ["ancestralGlow", "approachable"],
        ancestorContext: "ancestorEcho",
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartLineageAffectionFields(
        familyIDs: ["floatingTail", "roundHead"],
        affectionCues: ["ancestralGlow"],
        ancestorContext: "ancestorEcho",
        assetOutputs: "none",
        summary: summary
    ))

    #expect(!RendererMetadataSummary.hasFixedPartLineageAffectionFields(
        familyIDs: ["floatingTail", "roundHead"],
        affectionCues: ["ancestralGlow", "approachable"],
        ancestorContext: "",
        assetOutputs: "none",
        summary: summary
    ))

    #expect(RendererMetadataSummary.fixedPartLineageAffectionReadinessSummary(isReady: true) == "fixedPartLineageAffectionReady:true")
    #expect(RendererMetadataSummary.fixedPartLineageAffectionReadinessSummary(isReady: false) == "fixedPartLineageAffectionReady:false")
}

@Test func nodeInspectionSummaryCombinesReadinessAndRendererMetadata() {
    let summary = RendererMetadataSummary.nodeInspectionSummary(
        readinessSummary: "rendererMetadataReady:true",
        rendererMetadataSummary: "catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func nodeInspectionReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasNodeInspectionFields(
        readinessSummary: "rendererMetadataReady:true",
        rendererMetadataSummary: "catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        nodeInspectionSummary: "rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasNodeInspectionFields(
        readinessSummary: "rendererMetadataReady:true",
        rendererMetadataSummary: "",
        nodeInspectionSummary: "rendererMetadataReady:true,"
    ))
}

@Test func nodeInspectionReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.nodeInspectionReadinessSummary(isReady: true) == "nodeInspectionMetadataReady:true")
    #expect(RendererMetadataSummary.nodeInspectionReadinessSummary(isReady: false) == "nodeInspectionMetadataReady:false")
}

@Test func fullNodeInspectionSummaryCombinesReadinessAndNodeMetadata() {
    let summary = RendererMetadataSummary.fullNodeInspectionSummary(
        readinessSummary: "nodeInspectionMetadataReady:true",
        nodeInspectionSummary: "rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func fullNodeInspectionReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasFullNodeInspectionFields(
        readinessSummary: "nodeInspectionMetadataReady:true",
        nodeInspectionSummary: "rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        fullNodeInspectionSummary: "nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasFullNodeInspectionFields(
        readinessSummary: "nodeInspectionMetadataReady:true",
        nodeInspectionSummary: "rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        fullNodeInspectionSummary: ""
    ))
}

@Test func fullNodeInspectionReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.fullNodeInspectionReadinessSummary(isReady: true) == "fullNodeInspectionMetadataReady:true")
    #expect(RendererMetadataSummary.fullNodeInspectionReadinessSummary(isReady: false) == "fullNodeInspectionMetadataReady:false")
}

@Test func inspectionDebugSummaryCombinesReadinessAndFullNodeInspection() {
    let summary = RendererMetadataSummary.inspectionDebugSummary(
        readinessSummary: "fullNodeInspectionMetadataReady:true",
        fullNodeInspectionSummary: "nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func inspectionDebugReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasInspectionDebugFields(
        readinessSummary: "fullNodeInspectionMetadataReady:true",
        fullNodeInspectionSummary: "nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        inspectionDebugSummary: "fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasInspectionDebugFields(
        readinessSummary: "fullNodeInspectionMetadataReady:true",
        fullNodeInspectionSummary: "nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        inspectionDebugSummary: ""
    ))
}

@Test func inspectionDebugReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.inspectionDebugReadinessSummary(isReady: true) == "inspectionDebugMetadataReady:true")
    #expect(RendererMetadataSummary.inspectionDebugReadinessSummary(isReady: false) == "inspectionDebugMetadataReady:false")
}

@Test func visualInspectionSummaryCombinesReadinessAndInspectionDebug() {
    let summary = RendererMetadataSummary.visualInspectionSummary(
        readinessSummary: "inspectionDebugMetadataReady:true",
        inspectionDebugSummary: "fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func visualInspectionReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasVisualInspectionFields(
        readinessSummary: "inspectionDebugMetadataReady:true",
        inspectionDebugSummary: "fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        visualInspectionSummary: "inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasVisualInspectionFields(
        readinessSummary: "inspectionDebugMetadataReady:true",
        inspectionDebugSummary: "fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        visualInspectionSummary: ""
    ))
}

@Test func visualInspectionReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.visualInspectionReadinessSummary(isReady: true) == "visualInspectionMetadataReady:true")
    #expect(RendererMetadataSummary.visualInspectionReadinessSummary(isReady: false) == "visualInspectionMetadataReady:false")
}

@Test func qaInspectionSummaryCombinesReadinessAndVisualInspection() {
    let summary = RendererMetadataSummary.qaInspectionSummary(
        readinessSummary: "visualInspectionMetadataReady:true",
        visualInspectionSummary: "inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func qaInspectionReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasQAInspectionFields(
        readinessSummary: "visualInspectionMetadataReady:true",
        visualInspectionSummary: "inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        qaInspectionSummary: "visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasQAInspectionFields(
        readinessSummary: "visualInspectionMetadataReady:true",
        visualInspectionSummary: "inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        qaInspectionSummary: ""
    ))
}

@Test func qaInspectionReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.qaInspectionReadinessSummary(isReady: true) == "qaInspectionMetadataReady:true")
    #expect(RendererMetadataSummary.qaInspectionReadinessSummary(isReady: false) == "qaInspectionMetadataReady:false")
}

@Test func qaInspectionSnapshotSummaryCombinesReadinessAndQAInspection() {
    let summary = RendererMetadataSummary.qaInspectionSnapshotSummary(
        readinessSummary: "qaInspectionMetadataReady:true",
        qaInspectionSummary: "visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func qaInspectionSnapshotReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasQAInspectionSnapshotFields(
        readinessSummary: "qaInspectionMetadataReady:true",
        qaInspectionSummary: "visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        qaInspectionSnapshotSummary: "qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasQAInspectionSnapshotFields(
        readinessSummary: "qaInspectionMetadataReady:true",
        qaInspectionSummary: "visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        qaInspectionSnapshotSummary: ""
    ))
}

@Test func qaInspectionSnapshotReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.qaInspectionSnapshotReadinessSummary(isReady: true) == "qaInspectionSnapshotMetadataReady:true")
    #expect(RendererMetadataSummary.qaInspectionSnapshotReadinessSummary(isReady: false) == "qaInspectionSnapshotMetadataReady:false")
}

@Test func widgetInspectionSnapshotSummaryCombinesReadinessAndQAInspectionSnapshot() {
    let summary = RendererMetadataSummary.widgetInspectionSnapshotSummary(
        readinessSummary: "qaInspectionSnapshotMetadataReady:true",
        qaInspectionSnapshotSummary: "qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func widgetInspectionSnapshotReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasWidgetInspectionSnapshotFields(
        readinessSummary: "qaInspectionSnapshotMetadataReady:true",
        qaInspectionSnapshotSummary: "qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        widgetInspectionSnapshotSummary: "qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasWidgetInspectionSnapshotFields(
        readinessSummary: "qaInspectionSnapshotMetadataReady:true",
        qaInspectionSnapshotSummary: "qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        widgetInspectionSnapshotSummary: ""
    ))
}

@Test func widgetInspectionSnapshotReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.widgetInspectionSnapshotReadinessSummary(isReady: true) == "widgetInspectionSnapshotMetadataReady:true")
    #expect(RendererMetadataSummary.widgetInspectionSnapshotReadinessSummary(isReady: false) == "widgetInspectionSnapshotMetadataReady:false")
}

@Test func widgetInspectionReadinessSummaryCombinesReadinessAndWidgetSnapshot() {
    let summary = RendererMetadataSummary.widgetInspectionReadinessSummary(
        readinessSummary: "widgetInspectionSnapshotMetadataReady:true",
        widgetInspectionSnapshotSummary: "qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )

    #expect(
        summary == "widgetInspectionSnapshotMetadataReady:true,qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    )
}

@Test func widgetInspectionReadinessRequiresAllInspectionFields() {
    #expect(RendererMetadataSummary.hasWidgetInspectionFields(
        readinessSummary: "widgetInspectionSnapshotMetadataReady:true",
        widgetInspectionSnapshotSummary: "qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        widgetInspectionReadinessSummary: "widgetInspectionSnapshotMetadataReady:true,qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true"
    ))

    #expect(!RendererMetadataSummary.hasWidgetInspectionFields(
        readinessSummary: "widgetInspectionSnapshotMetadataReady:true",
        widgetInspectionSnapshotSummary: "qaInspectionSnapshotMetadataReady:true,qaInspectionMetadataReady:true,visualInspectionMetadataReady:true,inspectionDebugMetadataReady:true,fullNodeInspectionMetadataReady:true,nodeInspectionMetadataReady:true,rendererMetadataReady:true,catalogBacked:true,catalogCoverage=family:true,layer:true,socket:true",
        widgetInspectionReadinessSummary: ""
    ))
}

@Test func widgetInspectionMetadataReadinessSummaryReportsBooleanState() {
    #expect(RendererMetadataSummary.widgetInspectionMetadataReadinessSummary(isReady: true) == "widgetInspectionMetadataReady:true")
    #expect(RendererMetadataSummary.widgetInspectionMetadataReadinessSummary(isReady: false) == "widgetInspectionMetadataReady:false")
}

@Test func snapshotTestingDependencyProposalNamesStableVisualSurfacesWithoutAddingDependency() {
    let surfaces = ["lineageFamilyQA", "genomeVariationQA"]
    let summary = RendererMetadataSummary.snapshotTestingDependencyProposalSummary(
        stableSurfaceCount: 2,
        surfaceIDs: surfaces,
        manualVisualQAPassing: true,
        dependencyAdded: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 2,
        surfaceIDs: surfaces,
        manualVisualQAPassing: true,
        dependencyAdded: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotTestingProposal=surfaces:lineageFamilyQA+genomeVariationQA,stable:2,manualQA:true,dependencyAdded:false,appBehaviorChanged:false,proposalReady:true")
    #expect(RendererMetadataSummary.snapshotTestingDependencyProposalReadinessSummary(isReady: true) == "snapshotTestingProposalReady:true")
}

@Test func snapshotTestingDependencyProposalRejectsIncompleteOrAlreadyChangedState() {
    #expect(!RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 1,
        surfaceIDs: ["lineageFamilyQA"],
        manualVisualQAPassing: true,
        dependencyAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 2,
        surfaceIDs: ["lineageFamilyQA", ""],
        manualVisualQAPassing: true,
        dependencyAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 2,
        surfaceIDs: ["lineageFamilyQA", "genomeVariationQA"],
        manualVisualQAPassing: false,
        dependencyAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 2,
        surfaceIDs: ["lineageFamilyQA", "genomeVariationQA"],
        manualVisualQAPassing: true,
        dependencyAdded: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: 2,
        surfaceIDs: ["lineageFamilyQA", "genomeVariationQA"],
        manualVisualQAPassing: true,
        dependencyAdded: false,
        appBehaviorChanged: true
    ))
    #expect(
        RendererMetadataSummary.snapshotTestingDependencyProposalSummary(
            stableSurfaceCount: 0,
            surfaceIDs: [],
            manualVisualQAPassing: false,
            dependencyAdded: false,
            appBehaviorChanged: false
        )
        == "snapshotTestingProposal=surfaces:none,stable:0,manualQA:false,dependencyAdded:false,appBehaviorChanged:false,proposalReady:false"
    )
    #expect(RendererMetadataSummary.snapshotTestingDependencyProposalReadinessSummary(isReady: false) == "snapshotTestingProposalReady:false")
}

@Test func snapshotTestingVisibleSurfaceGateAcceptsAvailableDependencyWithoutReferenceImages() {
    let surfaces = ["genomeVariationQA", "growthCeremonyPreview"]
    let summary = RendererMetadataSummary.snapshotTestingVisibleSurfaceGateSummary(
        candidateSurfaceIDs: surfaces,
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: surfaces,
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotTestingVisibleSurfaceGate=surfaces:genomeVariationQA+growthCeremonyPreview,available:true,manualQA:true,referenceImages:false,appHost:false,appBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotTestingVisibleSurfaceGateReadinessSummary(isReady: true) == "snapshotTestingVisibleSurfaceGateReady:true")
}

@Test func snapshotTestingVisibleSurfaceGateRejectsUnreviewedOrAlreadyExpandedState() {
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA"],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", ""],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", "growthCeremonyPreview"],
        snapshotTestingAvailable: false,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", "growthCeremonyPreview"],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: false,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", "growthCeremonyPreview"],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: true,
        appTargetHostAdded: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", "growthCeremonyPreview"],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: ["genomeVariationQA", "growthCeremonyPreview"],
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceImagesRecorded: false,
        appTargetHostAdded: false,
        appBehaviorChanged: true
    ))
    #expect(RendererMetadataSummary.snapshotTestingVisibleSurfaceGateReadinessSummary(isReady: false) == "snapshotTestingVisibleSurfaceGateReady:false")
}

@Test func snapshotHostCandidateAcceptsReviewedGenomeVariationQAWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostCandidateSummary(
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

    #expect(RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostCandidate=surface:genomeVariationQA,view:GenomeVariationQAView,available:true,manualQA:true,stable:true,referenceImage:false,appHost:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotHostCandidateReadinessSummary(isReady: true) == "snapshotHostCandidateReady:true")
}

@Test func snapshotHostCandidateAcceptsReviewedObservationHomeWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostCandidateSummary(
        surfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostCandidate=surface:observationHome,view:ObservationHomeView,available:true,manualQA:true,stable:true,referenceImage:false,appHost:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotHostCandidateAcceptsReviewedLineageFamilyQAWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostCandidateSummary(
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

    #expect(RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "lineageFamilyQA",
        viewTarget: "LineageFamilyQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostCandidate=surface:lineageFamilyQA,view:LineageFamilyQAView,available:true,manualQA:true,stable:true,referenceImage:false,appHost:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotHostCandidateRejectsUnreviewedOrExpandedState() {
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "lineageFamilyQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "LineageFamilyQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: false,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: false,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: false,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: true,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: true,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostCandidateFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: false,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: true
    ))
    #expect(RendererMetadataSummary.snapshotHostCandidateSummary(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        stableSurface: true,
        referenceImageRecorded: true,
        appTargetHostAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ) == "snapshotHostCandidate=surface:genomeVariationQA,view:GenomeVariationQAView,available:true,manualQA:true,stable:true,referenceImage:true,appHost:false,technicalMetadata:false,appBehaviorChanged:false,ready:false")
    #expect(RendererMetadataSummary.snapshotHostCandidateReadinessSummary(isReady: false) == "snapshotHostCandidateReady:false")
}

@Test func snapshotHostEntryAcceptsGenomeVariationLaunchHostWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostEntrySummary(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostEntry=surface:genomeVariationQA,view:GenomeVariationQAView,launch:--wipet-snapshot-host-genome-variation,candidateReady:true,appHost:true,referenceImage:false,snapshotAssertion:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotHostEntryReadinessSummary(isReady: true) == "snapshotHostEntryReady:true")
}

@Test func snapshotHostEntryAcceptsObservationHomeLaunchHostWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostEntrySummary(
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

    #expect(RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostEntry=surface:observationHome,view:ObservationHomeView,launch:--wipet-snapshot-host-observation-home,candidateReady:true,appHost:true,referenceImage:false,snapshotAssertion:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotHostEntryAcceptsLineageFamilyLaunchHostWithoutReferenceImage() {
    let summary = RendererMetadataSummary.snapshotHostEntrySummary(
        surfaceID: "lineageFamilyQA",
        viewTarget: "LineageFamilyQAView",
        launchArgument: "--wipet-snapshot-host-lineage-family",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "lineageFamilyQA",
        viewTarget: "LineageFamilyQAView",
        launchArgument: "--wipet-snapshot-host-lineage-family",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotHostEntry=surface:lineageFamilyQA,view:LineageFamilyQAView,launch:--wipet-snapshot-host-lineage-family,candidateReady:true,appHost:true,referenceImage:false,snapshotAssertion:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotHostEntryRejectsWrongOrAlreadyExpandedState() {
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "lineageFamilyQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "LineageFamilyQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "lineageFamilyQA",
        viewTarget: "LineageFamilyQAView",
        launchArgument: "--wipet-lineage-family-preview",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-genome-variation-preview",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: false,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: false,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: true,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: true,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotHostEntryFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        candidateReady: true,
        appTargetHostAdded: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: true
    ))
    #expect(RendererMetadataSummary.snapshotHostEntryReadinessSummary(isReady: false) == "snapshotHostEntryReady:false")
}

@Test func snapshotFirstReferenceSurfaceSelectionChoosesObservationHomeBeforeImageAssertion() {
    let summary = RendererMetadataSummary.snapshotFirstReferenceSurfaceSelectionSummary(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotFirstReferenceSurface=surface:observationHome,view:ObservationHomeView,launch:--wipet-snapshot-host-observation-home,hostReady:true,manualQA:true,referenceImage:false,snapshotAssertion:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotFirstReferenceSurfaceSelectionReadinessSummary(isReady: true) == "snapshotFirstReferenceSurfaceReady:true")
}

@Test func snapshotFirstReferenceSurfaceSelectionRejectsNonObservationOrAlreadyExpandedState() {
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: false,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: false,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: true,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: true,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: true
    ))

    #expect(RendererMetadataSummary.snapshotFirstReferenceSurfaceSelectionReadinessSummary(isReady: false) == "snapshotFirstReferenceSurfaceReady:false")
}

@Test func snapshotAppTestTargetAdoptionGatePlansObservationHomeImageAssertionWithoutProjectEdit() {
    let summary = RendererMetadataSummary.snapshotAppTestTargetAdoptionGateSummary(
        surfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        firstReferenceSurfaceReady: true,
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        appTestTargetPlanned: true,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotAppTestTargetAdoptionGateFields(
        surfaceID: "observationHome",
        viewTarget: "ObservationHomeView",
        launchArgument: "--wipet-snapshot-host-observation-home",
        firstReferenceSurfaceReady: true,
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        appTestTargetPlanned: true,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        referenceImageRecorded: false,
        snapshotAssertionAdded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    ))
    #expect(summary == "snapshotAppTestTargetGate=surface:observationHome,view:ObservationHomeView,launch:--wipet-snapshot-host-observation-home,firstReferenceReady:true,available:true,manualQA:true,planned:true,targetAdded:false,projectEdited:false,referenceImage:false,snapshotAssertion:false,technicalMetadata:false,appBehaviorChanged:false,widgetBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotAppTestTargetAdoptionGateReadinessSummary(isReady: true) == "snapshotAppTestTargetGateReady:true")
}

@Test func snapshotAppTestTargetAdoptionGateRejectsWrongOrAlreadyExpandedState() {
    func isReady(
        surfaceID: String = "observationHome",
        viewTarget: String = "ObservationHomeView",
        launchArgument: String = "--wipet-snapshot-host-observation-home",
        firstReferenceSurfaceReady: Bool = true,
        snapshotTestingAvailable: Bool = true,
        manualVisualQAPassing: Bool = true,
        appTestTargetPlanned: Bool = true,
        appTestTargetAdded: Bool = false,
        xcodeProjectEdited: Bool = false,
        referenceImageRecorded: Bool = false,
        snapshotAssertionAdded: Bool = false,
        visibleTechnicalMetadata: Bool = false,
        appBehaviorChanged: Bool = false,
        widgetBehaviorChanged: Bool = false
    ) -> Bool {
        RendererMetadataSummary.hasSnapshotAppTestTargetAdoptionGateFields(
            surfaceID: surfaceID,
            viewTarget: viewTarget,
            launchArgument: launchArgument,
            firstReferenceSurfaceReady: firstReferenceSurfaceReady,
            snapshotTestingAvailable: snapshotTestingAvailable,
            manualVisualQAPassing: manualVisualQAPassing,
            appTestTargetPlanned: appTestTargetPlanned,
            appTestTargetAdded: appTestTargetAdded,
            xcodeProjectEdited: xcodeProjectEdited,
            referenceImageRecorded: referenceImageRecorded,
            snapshotAssertionAdded: snapshotAssertionAdded,
            visibleTechnicalMetadata: visibleTechnicalMetadata,
            appBehaviorChanged: appBehaviorChanged,
            widgetBehaviorChanged: widgetBehaviorChanged
        )
    }

    #expect(!isReady(surfaceID: "lineageFamilyQA"))
    #expect(!isReady(viewTarget: "LineageFamilyQAView"))
    #expect(!isReady(launchArgument: "--wipet-snapshot-host-lineage-family"))
    #expect(!isReady(firstReferenceSurfaceReady: false))
    #expect(!isReady(snapshotTestingAvailable: false))
    #expect(!isReady(manualVisualQAPassing: false))
    #expect(!isReady(appTestTargetPlanned: false))
    #expect(!isReady(appTestTargetAdded: true))
    #expect(!isReady(xcodeProjectEdited: true))
    #expect(!isReady(referenceImageRecorded: true))
    #expect(!isReady(snapshotAssertionAdded: true))
    #expect(!isReady(visibleTechnicalMetadata: true))
    #expect(!isReady(appBehaviorChanged: true))
    #expect(!isReady(widgetBehaviorChanged: true))
    #expect(RendererMetadataSummary.snapshotAppTestTargetAdoptionGateReadinessSummary(isReady: false) == "snapshotAppTestTargetGateReady:false")
}

@Test func snapshotReferenceAssertionAcceptsObservationHomeFamilyEchoTextReference() {
    let summary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotReferenceAssertion=surface:observationHome,kind:textLines,reference:observation-home-family-echo,available:true,manualQA:true,referenceRecorded:true,assertion:true,imageReference:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotReferenceAssertionReadinessSummary(isReady: true) == "snapshotReferenceAssertionReady:true")
}

@Test func snapshotReferenceAssertionAcceptsGenomeVariationCueSetTextReference() {
    let summary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "genomeVariationQA",
        assertionKind: "textLines",
        referenceName: "genome-variation-silhouette-cue-set",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "genomeVariationQA",
        assertionKind: "textLines",
        referenceName: "genome-variation-silhouette-cue-set",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotReferenceAssertion=surface:genomeVariationQA,kind:textLines,reference:genome-variation-silhouette-cue-set,available:true,manualQA:true,referenceRecorded:true,assertion:true,imageReference:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotReferenceAssertionAcceptsGrowthCeremonyPreviewTextReference() {
    let summary = RendererMetadataSummary.snapshotReferenceAssertionSummary(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "growth-ceremony-preview-contract",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "growth-ceremony-preview-contract",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(summary == "snapshotReferenceAssertion=surface:observationHome,kind:textLines,reference:growth-ceremony-preview-contract,available:true,manualQA:true,referenceRecorded:true,assertion:true,imageReference:false,technicalMetadata:false,appBehaviorChanged:false,ready:true")
}

@Test func snapshotReferenceAssertionRejectsImageUnreviewedOrTechnicalStates() {
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "lineageFamilyQA",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "image",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: false,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: false,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: false,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: false,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: true,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: true,
        appBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceAssertionFields(
        surfaceID: "observationHome",
        assertionKind: "textLines",
        referenceName: "observation-home-family-echo",
        snapshotTestingAvailable: true,
        manualVisualQAPassing: true,
        referenceRecorded: true,
        snapshotAssertionAdded: true,
        imageReferenceRecorded: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: true
    ))
    #expect(RendererMetadataSummary.snapshotReferenceAssertionReadinessSummary(isReady: false) == "snapshotReferenceAssertionReady:false")
}

@Test func snapshotReferenceRegistrySummarizesCurrentTextReferencesAndAppHosts() {
    let textReferences = [
        "observation-home-family-echo",
        "lineage-family-qa-review-stack",
        "genome-variation-silhouette-cue-set",
        "growth-ceremony-preview-contract"
    ]
    let appHosts = [
        "observationHome",
        "genomeVariationQA",
        "lineageFamilyQA"
    ]
    let summary = RendererMetadataSummary.snapshotReferenceRegistrySummary(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(summary == "snapshotReferenceRegistry=text:observation-home-family-echo+lineage-family-qa-review-stack+genome-variation-silhouette-cue-set+growth-ceremony-preview-contract,appHosts:observationHome+genomeVariationQA+lineageFamilyQA,imageReferences:0,appTargetImage:false,projectEdited:false,runtimeChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotReferenceRegistryReadinessSummary(isReady: true) == "snapshotReferenceRegistryReady:true")
}

@Test func snapshotReferenceRegistryRejectsMissingReferencesImageWorkAndRuntimeChanges() {
    let textReferences = [
        "observation-home-family-echo",
        "lineage-family-qa-review-stack",
        "genome-variation-silhouette-cue-set",
        "growth-ceremony-preview-contract"
    ]
    let appHosts = [
        "observationHome",
        "genomeVariationQA",
        "lineageFamilyQA"
    ]

    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: ["observation-home-family-echo", "genome-variation-silhouette-cue-set"],
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: Array(textReferences.reversed()),
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: ["observationHome", "genomeVariationQA"],
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 1,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: true,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: true,
        runtimeBehaviorChanged: false
    ))
    #expect(!RendererMetadataSummary.hasSnapshotReferenceRegistryFields(
        textReferences: textReferences,
        appHostSurfaceIDs: appHosts,
        imageReferenceCount: 0,
        appTargetImageSnapshotAdded: false,
        projectEditedForImageSnapshots: false,
        runtimeBehaviorChanged: true
    ))
    #expect(RendererMetadataSummary.snapshotReferenceRegistrySummary(
        textReferences: [],
        appHostSurfaceIDs: [],
        imageReferenceCount: 1,
        appTargetImageSnapshotAdded: true,
        projectEditedForImageSnapshots: true,
        runtimeBehaviorChanged: true
    ) == "snapshotReferenceRegistry=text:none,appHosts:none,imageReferences:1,appTargetImage:true,projectEdited:true,runtimeChanged:true,ready:false")
    #expect(RendererMetadataSummary.snapshotReferenceRegistryReadinessSummary(isReady: false) == "snapshotReferenceRegistryReady:false")
}

@Test func snapshotImageCandidateAcceptsGenomeVariationHostBeforeImageReference() {
    let summary = RendererMetadataSummary.snapshotImageCandidateSummary(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotImageCandidateReadinessFields(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    ))
    #expect(summary == "snapshotImageCandidate=surface:genomeVariationQA,view:GenomeVariationQAView,launch:--wipet-snapshot-host-genome-variation,hostReady:true,manualQA:true,referenceImage:false,imageAssertion:false,appTarget:false,projectEdited:false,technicalMetadata:false,appBehaviorChanged:false,widgetBehaviorChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotImageCandidateReadinessSummary(isReady: true) == "snapshotImageCandidateReady:true")
}

@Test func snapshotImageCandidateRejectsWrongSurfacePrematureImageWorkAndBehaviorChanges() {
    func isReady(
        surfaceID: String = "genomeVariationQA",
        viewTarget: String = "GenomeVariationQAView",
        launchArgument: String = "--wipet-snapshot-host-genome-variation",
        hostEntryReady: Bool = true,
        manualVisualQAPassing: Bool = true,
        referenceImageRecorded: Bool = false,
        imageSnapshotAssertionAdded: Bool = false,
        appTestTargetAdded: Bool = false,
        xcodeProjectEdited: Bool = false,
        visibleTechnicalMetadata: Bool = false,
        appBehaviorChanged: Bool = false,
        widgetBehaviorChanged: Bool = false
    ) -> Bool {
        RendererMetadataSummary.hasSnapshotImageCandidateReadinessFields(
            surfaceID: surfaceID,
            viewTarget: viewTarget,
            launchArgument: launchArgument,
            hostEntryReady: hostEntryReady,
            manualVisualQAPassing: manualVisualQAPassing,
            referenceImageRecorded: referenceImageRecorded,
            imageSnapshotAssertionAdded: imageSnapshotAssertionAdded,
            appTestTargetAdded: appTestTargetAdded,
            xcodeProjectEdited: xcodeProjectEdited,
            visibleTechnicalMetadata: visibleTechnicalMetadata,
            appBehaviorChanged: appBehaviorChanged,
            widgetBehaviorChanged: widgetBehaviorChanged
        )
    }

    #expect(!isReady(surfaceID: "observationHome"))
    #expect(!isReady(viewTarget: "ObservationHomeView"))
    #expect(!isReady(launchArgument: "--wipet-genome-variation-preview"))
    #expect(!isReady(hostEntryReady: false))
    #expect(!isReady(manualVisualQAPassing: false))
    #expect(!isReady(referenceImageRecorded: true))
    #expect(!isReady(imageSnapshotAssertionAdded: true))
    #expect(!isReady(appTestTargetAdded: true))
    #expect(!isReady(xcodeProjectEdited: true))
    #expect(!isReady(visibleTechnicalMetadata: true))
    #expect(!isReady(appBehaviorChanged: true))
    #expect(!isReady(widgetBehaviorChanged: true))
    #expect(RendererMetadataSummary.snapshotImageCandidateSummary(
        surfaceID: "genomeVariationQA",
        viewTarget: "GenomeVariationQAView",
        launchArgument: "--wipet-snapshot-host-genome-variation",
        hostEntryReady: true,
        manualVisualQAPassing: true,
        referenceImageRecorded: true,
        imageSnapshotAssertionAdded: false,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        visibleTechnicalMetadata: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    ) == "snapshotImageCandidate=surface:genomeVariationQA,view:GenomeVariationQAView,launch:--wipet-snapshot-host-genome-variation,hostReady:true,manualQA:true,referenceImage:true,imageAssertion:false,appTarget:false,projectEdited:false,technicalMetadata:false,appBehaviorChanged:false,widgetBehaviorChanged:false,ready:false")
    #expect(RendererMetadataSummary.snapshotImageCandidateReadinessSummary(isReady: false) == "snapshotImageCandidateReady:false")
}

@Test func snapshotAppTargetIsolationPlanAcceptsFutureGenomeVariationSnapshotTargetWithoutProjectEdit() {
    let summary = RendererMetadataSummary.snapshotAppTargetIsolationPlanSummary(
        surfaceID: "genomeVariationQA",
        plannedTargetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget"],
        snapshotImageCandidateReady: true,
        snapshotTestingPackageAvailable: true,
        xctestHarnessPlanned: true,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        rendererChanged: false,
        widgetBehaviorChanged: false
    )

    #expect(RendererMetadataSummary.hasSnapshotAppTargetIsolationPlanFields(
        surfaceID: "genomeVariationQA",
        plannedTargetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget"],
        snapshotImageCandidateReady: true,
        snapshotTestingPackageAvailable: true,
        xctestHarnessPlanned: true,
        appTestTargetAdded: false,
        xcodeProjectEdited: false,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        rendererChanged: false,
        widgetBehaviorChanged: false
    ))
    #expect(summary == "snapshotAppTargetIsolationPlan=surface:genomeVariationQA,target:WiPetSnapshotTests,existingTargets:WiPet+WiPetWidget,imageCandidateReady:true,snapshotTesting:true,xctest:true,targetAdded:false,projectEdited:false,referenceImage:false,imageAssertion:false,rendererChanged:false,widgetChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotAppTargetIsolationPlanReadinessSummary(isReady: true) == "snapshotAppTargetIsolationPlanReady:true")
}

@Test func snapshotAppTargetIsolationPlanRejectsWrongScopeOrAlreadyEditedProject() {
    func isReady(
        surfaceID: String = "genomeVariationQA",
        plannedTargetName: String = "WiPetSnapshotTests",
        existingProjectTargets: [String] = ["WiPet", "WiPetWidget"],
        snapshotImageCandidateReady: Bool = true,
        snapshotTestingPackageAvailable: Bool = true,
        xctestHarnessPlanned: Bool = true,
        appTestTargetAdded: Bool = false,
        xcodeProjectEdited: Bool = false,
        referenceImageRecorded: Bool = false,
        imageSnapshotAssertionAdded: Bool = false,
        rendererChanged: Bool = false,
        widgetBehaviorChanged: Bool = false
    ) -> Bool {
        RendererMetadataSummary.hasSnapshotAppTargetIsolationPlanFields(
            surfaceID: surfaceID,
            plannedTargetName: plannedTargetName,
            existingProjectTargets: existingProjectTargets,
            snapshotImageCandidateReady: snapshotImageCandidateReady,
            snapshotTestingPackageAvailable: snapshotTestingPackageAvailable,
            xctestHarnessPlanned: xctestHarnessPlanned,
            appTestTargetAdded: appTestTargetAdded,
            xcodeProjectEdited: xcodeProjectEdited,
            referenceImageRecorded: referenceImageRecorded,
            imageSnapshotAssertionAdded: imageSnapshotAssertionAdded,
            rendererChanged: rendererChanged,
            widgetBehaviorChanged: widgetBehaviorChanged
        )
    }

    #expect(!isReady(surfaceID: "observationHome"))
    #expect(!isReady(plannedTargetName: "WiPetUITests"))
    #expect(!isReady(existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"]))
    #expect(!isReady(existingProjectTargets: ["WiPetWidget", "WiPet"]))
    #expect(!isReady(snapshotImageCandidateReady: false))
    #expect(!isReady(snapshotTestingPackageAvailable: false))
    #expect(!isReady(xctestHarnessPlanned: false))
    #expect(!isReady(appTestTargetAdded: true))
    #expect(!isReady(xcodeProjectEdited: true))
    #expect(!isReady(referenceImageRecorded: true))
    #expect(!isReady(imageSnapshotAssertionAdded: true))
    #expect(!isReady(rendererChanged: true))
    #expect(!isReady(widgetBehaviorChanged: true))
    #expect(RendererMetadataSummary.snapshotAppTargetIsolationPlanSummary(
        surfaceID: "genomeVariationQA",
        plannedTargetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
        snapshotImageCandidateReady: true,
        snapshotTestingPackageAvailable: true,
        xctestHarnessPlanned: true,
        appTestTargetAdded: true,
        xcodeProjectEdited: true,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        rendererChanged: false,
        widgetBehaviorChanged: false
    ) == "snapshotAppTargetIsolationPlan=surface:genomeVariationQA,target:WiPetSnapshotTests,existingTargets:WiPet+WiPetWidget+WiPetSnapshotTests,imageCandidateReady:true,snapshotTesting:true,xctest:true,targetAdded:true,projectEdited:true,referenceImage:false,imageAssertion:false,rendererChanged:false,widgetChanged:false,ready:false")
    #expect(RendererMetadataSummary.snapshotAppTargetIsolationPlanReadinessSummary(isReady: false) == "snapshotAppTargetIsolationPlanReady:false")
}

@Test func snapshotAppTargetEntryAcceptsWiPetSnapshotTestsWithoutImageReference() {
    let summary = RendererMetadataSummary.snapshotAppTargetEntrySummary(
        surfaceID: "genomeVariationQA",
        targetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
        snapshotImageCandidateReady: true,
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

    #expect(RendererMetadataSummary.hasSnapshotAppTargetEntryFields(
        surfaceID: "genomeVariationQA",
        targetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
        snapshotImageCandidateReady: true,
        snapshotTestingPackageAvailable: true,
        xctestHarnessAdded: true,
        appTestTargetAdded: true,
        xcodeProjectEdited: true,
        referenceImageRecorded: false,
        imageSnapshotAssertionAdded: false,
        rendererChanged: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    ))
    #expect(summary == "snapshotAppTargetEntry=surface:genomeVariationQA,target:WiPetSnapshotTests,existingTargets:WiPet+WiPetWidget+WiPetSnapshotTests,imageCandidateReady:true,snapshotTesting:true,xctest:true,targetAdded:true,projectEdited:true,referenceImage:false,imageAssertion:false,rendererChanged:false,appBehaviorChanged:false,widgetChanged:false,ready:true")
    #expect(RendererMetadataSummary.snapshotAppTargetEntryReadinessSummary(isReady: true) == "snapshotAppTargetEntryReady:true")
}

@Test func snapshotAppTargetEntryRejectsMissingTargetImageWorkOrBehaviorChanges() {
    func isReady(
        surfaceID: String = "genomeVariationQA",
        targetName: String = "WiPetSnapshotTests",
        existingProjectTargets: [String] = ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
        snapshotImageCandidateReady: Bool = true,
        snapshotTestingPackageAvailable: Bool = true,
        xctestHarnessAdded: Bool = true,
        appTestTargetAdded: Bool = true,
        xcodeProjectEdited: Bool = true,
        referenceImageRecorded: Bool = false,
        imageSnapshotAssertionAdded: Bool = false,
        rendererChanged: Bool = false,
        appBehaviorChanged: Bool = false,
        widgetBehaviorChanged: Bool = false
    ) -> Bool {
        RendererMetadataSummary.hasSnapshotAppTargetEntryFields(
            surfaceID: surfaceID,
            targetName: targetName,
            existingProjectTargets: existingProjectTargets,
            snapshotImageCandidateReady: snapshotImageCandidateReady,
            snapshotTestingPackageAvailable: snapshotTestingPackageAvailable,
            xctestHarnessAdded: xctestHarnessAdded,
            appTestTargetAdded: appTestTargetAdded,
            xcodeProjectEdited: xcodeProjectEdited,
            referenceImageRecorded: referenceImageRecorded,
            imageSnapshotAssertionAdded: imageSnapshotAssertionAdded,
            rendererChanged: rendererChanged,
            appBehaviorChanged: appBehaviorChanged,
            widgetBehaviorChanged: widgetBehaviorChanged
        )
    }

    #expect(!isReady(surfaceID: "observationHome"))
    #expect(!isReady(targetName: "WiPetUITests"))
    #expect(!isReady(existingProjectTargets: ["WiPet", "WiPetWidget"]))
    #expect(!isReady(snapshotImageCandidateReady: false))
    #expect(!isReady(snapshotTestingPackageAvailable: false))
    #expect(!isReady(xctestHarnessAdded: false))
    #expect(!isReady(appTestTargetAdded: false))
    #expect(!isReady(xcodeProjectEdited: false))
    #expect(!isReady(referenceImageRecorded: true))
    #expect(!isReady(imageSnapshotAssertionAdded: true))
    #expect(!isReady(rendererChanged: true))
    #expect(!isReady(appBehaviorChanged: true))
    #expect(!isReady(widgetBehaviorChanged: true))
    #expect(RendererMetadataSummary.snapshotAppTargetEntrySummary(
        surfaceID: "genomeVariationQA",
        targetName: "WiPetSnapshotTests",
        existingProjectTargets: ["WiPet", "WiPetWidget", "WiPetSnapshotTests"],
        snapshotImageCandidateReady: true,
        snapshotTestingPackageAvailable: true,
        xctestHarnessAdded: true,
        appTestTargetAdded: true,
        xcodeProjectEdited: true,
        referenceImageRecorded: true,
        imageSnapshotAssertionAdded: true,
        rendererChanged: false,
        appBehaviorChanged: false,
        widgetBehaviorChanged: false
    ) == "snapshotAppTargetEntry=surface:genomeVariationQA,target:WiPetSnapshotTests,existingTargets:WiPet+WiPetWidget+WiPetSnapshotTests,imageCandidateReady:true,snapshotTesting:true,xctest:true,targetAdded:true,projectEdited:true,referenceImage:true,imageAssertion:true,rendererChanged:false,appBehaviorChanged:false,widgetChanged:false,ready:false")
    #expect(RendererMetadataSummary.snapshotAppTargetEntryReadinessSummary(isReady: false) == "snapshotAppTargetEntryReady:false")
}

@Test func widgetPetSnapshotUsesLatestDiscoveryForObservationWindow() {
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
        relatedAncestorID: UUID()
    )

    let snapshot = WidgetPetSnapshot(creature: creature, mood: "Dreamy", ageLabel: "12 days")

    #expect(snapshot.name == "Luma")
    #expect(snapshot.speciesName == "Lunarian")
    #expect(snapshot.growthStageName == "Juvenile")
    #expect(snapshot.generation == 3)
    #expect(snapshot.mood == "Dreamy")
    #expect(snapshot.ageLabel == "12 days")
    #expect(snapshot.latestDiscoveryText == "The floating tail shimmer resembles the first ancestor.")
    #expect(snapshot.latestDiscoveryMemoryCueLabel == "Juvenile inherited memory")
    #expect(snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
}

@Test func widgetPetSnapshotKeepsChronologicalLineageWhenHomeFocusPrefersGrowth() {
    let growthMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .juvenile
    )
    let lineageMemory = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        generation: 3,
        discoveredTraits: [
            growthMemory,
            lineageMemory
        ]
    )

    let snapshot = WidgetPetSnapshot(creature: creature, mood: "Dreamy", ageLabel: "12 days")

    #expect(creature.preferredDailyObservationDiscovery == growthMemory)
    #expect(creature.widgetSnapshotDiscovery == lineageMemory)
    #expect(snapshot.latestDiscoveryText == "The floating tail shimmer resembles the first ancestor.")
    #expect(snapshot.latestDiscoveryMemoryCueLabel == "Juvenile inherited memory")
    #expect(snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
}

@Test func widgetPetSnapshotFallsBackToGentleRestingDiscoveryText() {
    let creature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .baby,
        generation: 0
    )

    let snapshot = WidgetPetSnapshot(creature: creature)

    #expect(snapshot.name == "Miri")
    #expect(snapshot.speciesName == "Sylphian")
    #expect(snapshot.growthStageName == "Baby")
    #expect(snapshot.generation == 1)
    #expect(snapshot.mood == "Quietly curious")
    #expect(snapshot.ageLabel == "Tiny days")
    #expect(snapshot.latestDiscoveryText == "Miri is resting quietly.")
    #expect(snapshot.latestDiscoveryMemoryCueLabel == "Baby quiet memory")
    #expect(snapshot.latestDiscoveryLineageCueLabel == nil)
    #expect(WidgetPetSnapshotText(snapshot: snapshot).lineageCueCompactLine == nil)
}

@Test func widgetRestingFallbackWordingStaysCreatureSpecificAndQuiet() {
    let creature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .baby,
        generation: 1
    )

    #expect(creature.widgetSnapshotDiscovery == nil)
    #expect(creature.widgetRestingDiscoveryText == "Miri is resting quietly.")
    #expect(creature.widgetRestingMemoryCueLabel == "Baby quiet memory")
}

@Test func widgetPetSnapshotTextHidesProductionSelectiveCueForRestingFallback() {
    let creature = Creature(
        name: "Miri",
        species: .sylphian,
        genome: Genome(morph: MorphGenes(face: .fairy, body: .sylphian)),
        growthStage: .baby,
        generation: 1
    )
    let snapshot = WidgetPetSnapshot(creature: creature)
    let text = WidgetPetSnapshotText(snapshot: snapshot)

    #expect(text.discoveryLine == "Miri is resting quietly.")
    #expect(text.memoryCueLine == "Baby quiet memory")
    #expect(text.lineageCueLine == nil)
    #expect(text.lineageCueCompactLine == nil)
    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 44) == nil)
}

@Test func widgetPetSnapshotTextBuildsCompactObservationLines() {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor.",
        latestDiscoveryLineageCueLabel: "Echoes an ancestor"
    )

    let text = WidgetPetSnapshotText(snapshot: snapshot)

    #expect(text.identityLine == "Luma - Lunarian - Gen 3")
    #expect(text.stateLine == "Dreamy - 12 days")
    #expect(text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(text.memoryCueLine == "Quiet memory")
    #expect(text.lineageCueLine == "Echoes an ancestor")
    #expect(text.lineageCueCompactLine == "Family line")
}

@Test func widgetPetSnapshotTextOmitsCompactLineageCueWithoutAncestorCue() {
    let snapshot = WidgetPetSnapshot(
        name: "Miri",
        speciesName: "Sylphian",
        growthStageName: "Baby",
        generation: 1,
        mood: "Curious",
        ageLabel: "Tiny days",
        latestDiscoveryText: "Miri learned a gentle hover.",
        latestDiscoveryMemoryCueLabel: "Baby motion memory"
    )

    let text = WidgetPetSnapshotText(snapshot: snapshot)

    #expect(text.lineageCueLine == nil)
    #expect(text.lineageCueCompactLine == nil)
}

@Test func widgetPetSnapshotTextShowsCompactLineageCueOnlyWhenDiscoveryFits() {
    let text = WidgetPetSnapshotText(
        identityLine: "Luma - Lunarian - Gen 3",
        stateLine: "Dreamy - 12 days",
        discoveryLine: "Tail echoes the first ancestor.",
        memoryCueLine: "Juvenile inherited memory",
        lineageCueLine: "Echoes an ancestor",
        lineageCueCompactLine: "Family line"
    )

    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 31) == "Family line")
    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 30) == nil)
    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 0) == nil)
}

@Test func widgetPetSnapshotTextBuildsObservationWindowAccessibilityLabel() {
    let text = WidgetPetSnapshotText(
        identityLine: "Luma - Lunarian - Gen 3",
        stateLine: "Dreamy - 12 days",
        discoveryLine: "Tail echoes Nana.",
        memoryCueLine: "Juvenile inherited memory",
        lineageCueLine: "Echoes an ancestor",
        lineageCueCompactLine: "Family line"
    )

    #expect(
        text.observationWindowAccessibilityLabel(displayedLineageCueLine: "Family line")
            == "WiPet observation window. Luma - Lunarian - Gen 3. Dreamy - 12 days. Tail echoes Nana. Juvenile inherited memory. Family line"
    )
}

@Test func widgetPetSnapshotTextObservationWindowLabelOmitsHiddenLineageCue() {
    let text = WidgetPetSnapshotText(
        identityLine: "Luma - Lunarian - Gen 3",
        stateLine: "Dreamy - 12 days",
        discoveryLine: "The floating tail shimmer resembles the first ancestor.",
        memoryCueLine: "Juvenile inherited memory",
        lineageCueLine: "Echoes an ancestor",
        lineageCueCompactLine: "Family line"
    )

    let label = text.observationWindowAccessibilityLabel(
        displayedLineageCueLine: text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 44)
    )

    #expect(label.contains("WiPet observation window. Luma - Lunarian - Gen 3"))
    #expect(label.contains("The floating tail shimmer resembles the first ancestor."))
    #expect(label.contains("Juvenile inherited memory"))
    #expect(!label.contains("Family line"))
}

@Test func widgetPetSnapshotTextHidesSelectiveCompactLineageCueWhenCueIsMissing() {
    let text = WidgetPetSnapshotText(
        identityLine: "Miri - Sylphian - Gen 1",
        stateLine: "Curious - Tiny days",
        discoveryLine: "Miri learned a gentle hover.",
        memoryCueLine: "Baby motion memory"
    )

    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 80) == nil)
}

@Test func widgetPetSnapshotTextHidesSelectiveCompactLineageCueForLongDiscovery() {
    let text = WidgetPetSnapshotText(
        identityLine: "Luma - Lunarian - Gen 3",
        stateLine: "Dreamy - 12 days",
        discoveryLine: "The floating tail shimmer resembles the first ancestor.",
        memoryCueLine: "Juvenile inherited memory",
        lineageCueLine: "Echoes an ancestor",
        lineageCueCompactLine: "Family line"
    )

    #expect(text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 44) == nil)
}

@Test func widgetPetObservationDerivesSnapshotAndTextFromCreature() {
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
        relatedAncestorID: UUID()
    )

    let observation = WidgetPetObservation(creature: creature, mood: "Dreamy", ageLabel: "12 days")

    #expect(observation.snapshot.name == "Luma")
    #expect(observation.snapshot.speciesName == "Lunarian")
    #expect(observation.snapshot.generation == 3)
    #expect(observation.snapshot.mood == "Dreamy")
    #expect(observation.snapshot.ageLabel == "12 days")
    #expect(observation.snapshot.latestDiscoveryText == "The floating tail shimmer resembles the first ancestor.")
    #expect(observation.snapshot.latestDiscoveryMemoryCueLabel == "Juvenile inherited memory")
    #expect(observation.snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
    #expect(observation.text.identityLine == "Luma - Lunarian - Gen 3")
    #expect(observation.text.stateLine == "Dreamy - 12 days")
    #expect(observation.text.discoveryLine == observation.snapshot.latestDiscoveryText)
    #expect(observation.text.memoryCueLine == "Juvenile inherited memory")
    #expect(observation.text.lineageCueLine == "Echoes an ancestor")
    #expect(observation.text.lineageCueCompactLine == "Family line")
}

@Test func widgetHandoffPayloadKeepsChronologicalLineageWhenHomeFocusPrefersGrowth() throws {
    let growthMemory = DiscoveryEvent(
        title: "A quiet lunar glow deepened around the tail.",
        kind: .glow,
        stage: .juvenile
    )
    let lineageMemory = DiscoveryEvent(
        title: "The floating tail shimmer resembles the first ancestor.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID()
    )
    let creature = Creature(
        name: "Luma",
        species: .lunarian,
        genome: Genome(morph: MorphGenes(face: .crystal, body: .lunarian, tail: .floating)),
        growthStage: .juvenile,
        generation: 3,
        discoveredTraits: [
            growthMemory,
            lineageMemory
        ]
    )
    let observation = WidgetPetObservation(creature: creature, mood: "Dreamy", ageLabel: "12 days")
    let payload = WidgetPetObservationTransferPayload(observation: observation)
    let data = try payload.encodeJSON()

    let sourceResult = WidgetPetObservationHandoffReader.currentObservation(from: data)
    let decodedObservation = try #require(sourceResult.payload?.observation)

    #expect(creature.preferredDailyObservationDiscovery == growthMemory)
    #expect(creature.widgetSnapshotDiscovery == lineageMemory)
    #expect(decodedObservation.snapshot.latestDiscoveryText == "The floating tail shimmer resembles the first ancestor.")
    #expect(decodedObservation.snapshot.latestDiscoveryMemoryCueLabel == "Juvenile inherited memory")
    #expect(decodedObservation.snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
    #expect(decodedObservation.text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(decodedObservation.text.memoryCueLine == "Juvenile inherited memory")
    #expect(decodedObservation.text.lineageCueLine == "Echoes an ancestor")
}

@Test func widgetSharedDataKeysNameFutureAppGroupHandoff() {
    #expect(WidgetSharedDataKeys.widgetKind == "WiPetWidget")
    #expect(WidgetSharedDataKeys.appGroupIdentifier == "group.com.taikikira.WiPet")
    #expect(WidgetSharedDataKeys.currentObservationJSON == "widget.currentObservation.json")
}

@Test func widgetObservationTransferPayloadRoundTripsCurrentSnapshotFields() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor.",
        latestDiscoveryLineageCueLabel: "Echoes an ancestor"
    )
    let observation = WidgetPetObservation(
        snapshot: snapshot,
        text: WidgetPetSnapshotText(snapshot: snapshot)
    )

    let payload = WidgetPetObservationTransferPayload(observation: observation)
    let data = try JSONEncoder().encode(payload)
    let decoded = try JSONDecoder().decode(WidgetPetObservationTransferPayload.self, from: data)

    #expect(decoded == payload)
    #expect(decoded.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion)
    #expect(decoded.snapshot == snapshot)
    #expect(decoded.observation == observation)
    #expect(decoded.observation.text.identityLine == "Luma - Lunarian - Gen 3")
    #expect(decoded.observation.text.stateLine == "Dreamy - 12 days")
    #expect(decoded.observation.text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(decoded.observation.text.memoryCueLine == "Quiet memory")
    #expect(decoded.observation.text.lineageCueLine == "Echoes an ancestor")
    #expect(decoded.observation.text.lineageCueCompactLine == "Family line")
    #expect(decoded.latestDiscoveryMemoryCueLabel == "Quiet memory")
    #expect(decoded.snapshot.latestDiscoveryMemoryCueLabel == "Quiet memory")
    #expect(decoded.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
    #expect(decoded.snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
}

@Test func widgetObservationTransferPayloadDecodesValidJSONData() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)
    let data = try JSONEncoder().encode(payload)

    let decoded = try WidgetPetObservationTransferPayload.decodeJSON(from: data)

    #expect(decoded == payload)
    #expect(decoded.observation.text.identityLine == "Luma - Lunarian - Gen 3")
    #expect(decoded.observation.text.stateLine == "Dreamy - 12 days")
    #expect(decoded.observation.text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(decoded.observation.text.memoryCueLine == "Quiet memory")
    #expect(decoded.observation.text.lineageCueLine == nil)
    #expect(decoded.observation.text.lineageCueCompactLine == nil)
    #expect(decoded.latestDiscoveryMemoryCueLabel == "Quiet memory")
    #expect(decoded.latestDiscoveryLineageCueLabel == nil)
}

@Test func widgetObservationTransferPayloadDecodesOlderPayloadWithoutMemoryCue() throws {
    let data = Data("""
    {
      "schemaVersion": 1,
      "name": "Luma",
      "speciesName": "Lunarian",
      "growthStageName": "Juvenile",
      "generation": 3,
      "mood": "Dreamy",
      "ageLabel": "12 days",
      "latestDiscoveryText": "The floating tail shimmer resembles the first ancestor."
    }
    """.utf8)

    let decoded = try WidgetPetObservationTransferPayload.decodeJSON(from: data)

    #expect(decoded.latestDiscoveryMemoryCueLabel == nil)
    #expect(decoded.latestDiscoveryLineageCueLabel == nil)
    #expect(decoded.snapshot.latestDiscoveryMemoryCueLabel == "Juvenile quiet memory")
    #expect(decoded.snapshot.latestDiscoveryLineageCueLabel == nil)
    #expect(decoded.observation.text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(decoded.observation.text.memoryCueLine == "Juvenile quiet memory")
    #expect(decoded.observation.text.lineageCueLine == nil)
    #expect(decoded.observation.text.lineageCueCompactLine == nil)
}

@Test func widgetObservationTransferPayloadCompatibilityMemoryCueStaysStageBased() {
    #expect(
        WidgetPetObservationTransferPayload.compatibilityMemoryCueLabel(growthStageName: "Juvenile")
            == "Juvenile quiet memory"
    )
    #expect(
        WidgetPetObservationTransferPayload.compatibilityMemoryCueLabel(growthStageName: "Baby")
            == "Baby quiet memory"
    )
}

@Test func widgetObservationTransferPayloadDecodeThrowsForInvalidData() {
    let invalidData = Data("not a widget observation payload".utf8)
    var didThrow = false

    do {
        _ = try WidgetPetObservationTransferPayload.decodeJSON(from: invalidData)
    } catch {
        didThrow = true
    }

    #expect(didThrow)
}

@Test func widgetObservationTransferPayloadEncodesJSONDataDecodableByHelper() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)

    let data = try payload.encodeJSON()
    let decoded = try WidgetPetObservationTransferPayload.decodeJSON(from: data)

    #expect(decoded == payload)
    #expect(decoded.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion)
    #expect(decoded.snapshot == snapshot)
    #expect(decoded.observation.text.identityLine == "Luma - Lunarian - Gen 3")
}

@Test func widgetObservationPayloadSourceResultReturnsLoadedPayload() {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)
    let result = WidgetPetObservationPayloadSourceResult.loaded(payload)

    #expect(result.payload == payload)
    #expect(result.payload?.observation.text.identityLine == "Luma - Lunarian - Gen 3")
}

@Test func widgetObservationPayloadSourceResultDecodesValidJSONDataAsLoadedPayload() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)
    let data = try payload.encodeJSON()

    let result = WidgetPetObservationPayloadSourceResult.decodeJSONData(data)

    #expect(result == .loaded(payload))
    #expect(result.payload == payload)
    #expect(result.payload?.observation.text.identityLine == "Luma - Lunarian - Gen 3")
}

@Test func widgetObservationPayloadSourceResultDecodesInvalidJSONDataAsMissing() {
    let invalidData = Data("not a widget observation payload".utf8)

    let result = WidgetPetObservationPayloadSourceResult.decodeJSONData(invalidData)

    #expect(result == .missing)
    #expect(result.payload == nil)
}

@Test func widgetObservationPayloadSourceResultMapsNilDataToMissing() {
    let result = WidgetPetObservationPayloadSourceResult.data(nil)

    #expect(result == .missing)
    #expect(result.payload == nil)
}

@Test func widgetObservationPayloadSourceResultMapsValidOptionalDataToLoadedPayload() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)
    let data = try payload.encodeJSON()

    let result = WidgetPetObservationPayloadSourceResult.data(data)

    #expect(result == .loaded(payload))
    #expect(result.payload == payload)
}

@Test func widgetObservationPayloadSourceResultMapsInvalidOptionalDataToMissing() {
    let invalidData = Data("not a widget observation payload".utf8)

    let result = WidgetPetObservationPayloadSourceResult.data(invalidData)

    #expect(result == .missing)
    #expect(result.payload == nil)
}

@Test func widgetObservationPayloadSourceResultReportsMissingPayload() {
    let result = WidgetPetObservationPayloadSourceResult.missing

    #expect(result.payload == nil)
}

@Test func widgetObservationPayloadSourceResultNamesFallbackRequirement() {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)

    #expect(!WidgetPetObservationPayloadSourceResult.loaded(payload).requiresFallbackObservation)
    #expect(WidgetPetObservationPayloadSourceResult.missing.requiresFallbackObservation)
}

@Test func widgetObservationPayloadSourceResultNamesQAReadinessSourceState() {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)

    #expect(WidgetPetObservationPayloadSourceResult.loaded(payload).qaReadinessSourceState == "loaded")
    #expect(WidgetPetObservationPayloadSourceResult.missing.qaReadinessSourceState == "fallbackRequired")
}

@Test func widgetObservationHandoffReaderMapsNilCurrentObservationDataToMissing() {
    let result = WidgetPetObservationHandoffReader.currentObservation(from: nil)

    #expect(result == .missing)
    #expect(result.payload == nil)
}

@Test func widgetObservationHandoffReaderMapsValidCurrentObservationDataToLoadedPayload() throws {
    let snapshot = WidgetPetSnapshot(
        name: "Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    )
    let payload = WidgetPetObservationTransferPayload(snapshot: snapshot)
    let data = try payload.encodeJSON()

    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(result == .loaded(payload))
    #expect(result.payload == payload)
}

@Test func widgetObservationHandoffReaderMapsInvalidCurrentObservationDataToMissing() {
    let invalidData = Data("not a widget observation payload".utf8)

    let result = WidgetPetObservationHandoffReader.currentObservation(from: invalidData)

    #expect(result == .missing)
    #expect(result.payload == nil)
}

@Test func widgetCurrentObservationDataProviderReturnsValidStoredData() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let sharedPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Shared Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Curious",
        ageLabel: "13 days",
        latestDiscoveryText: "Shared starlight hums softly."
    ))
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let sharedData = try sharedPayload.encodeJSON()
    let fallbackData = try fallbackPayload.encodeJSON()
    defaults.set(sharedData, forKey: WidgetSharedDataKeys.currentObservationJSON)

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(data == sharedData)
    #expect(result.payload == sharedPayload)
}

@Test func widgetCurrentObservationDataProviderSourceResultNamesSharedData() throws {
    let sharedPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Shared Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Curious",
        ageLabel: "13 days",
        latestDiscoveryText: "Shared starlight hums softly."
    ))
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let sharedData = try sharedPayload.encodeJSON()
    let fallbackData = try fallbackPayload.encodeJSON()

    let result = WidgetCurrentObservationDataProvider.currentObservationSourceResult(
        sharedData: sharedData,
        fallbackData: fallbackData
    )

    #expect(result == .shared(sharedData))
    #expect(result.data == sharedData)
    #expect(!result.usesFallbackData)
}

@Test func widgetCurrentObservationDataProviderSourceResultNamesNilDefaultsFallback() throws {
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()

    let result = WidgetCurrentObservationDataProvider.currentObservationSourceResult(
        from: nil,
        fallbackData: fallbackData
    )

    #expect(result == .fallback(fallbackData))
    #expect(result.data == fallbackData)
    #expect(result.usesFallbackData)
}

@Test func widgetCurrentObservationDataProviderSourceResultNamesMissingKeyFallback() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()

    let result = WidgetCurrentObservationDataProvider.currentObservationSourceResult(
        from: defaults,
        fallbackData: fallbackData
    )

    #expect(result == .fallback(fallbackData))
    #expect(result.data == fallbackData)
    #expect(result.usesFallbackData)
}

@Test func widgetCurrentObservationDataProviderSourceResultNamesInvalidStoredFallbacks() throws {
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()
    let invalidData = Data("not a widget observation payload".utf8)

    let nonDataSuiteName = "WiPetTests.\(UUID().uuidString)"
    let nonDataDefaults = UserDefaults(suiteName: nonDataSuiteName)!
    defer {
        nonDataDefaults.removePersistentDomain(forName: nonDataSuiteName)
    }
    nonDataDefaults.set("not data", forKey: WidgetSharedDataKeys.currentObservationJSON)

    let invalidDataSuiteName = "WiPetTests.\(UUID().uuidString)"
    let invalidDataDefaults = UserDefaults(suiteName: invalidDataSuiteName)!
    defer {
        invalidDataDefaults.removePersistentDomain(forName: invalidDataSuiteName)
    }
    invalidDataDefaults.set(invalidData, forKey: WidgetSharedDataKeys.currentObservationJSON)

    let nonDataResult = WidgetCurrentObservationDataProvider.currentObservationSourceResult(
        from: nonDataDefaults,
        fallbackData: fallbackData
    )
    let invalidDataResult = WidgetCurrentObservationDataProvider.currentObservationSourceResult(
        from: invalidDataDefaults,
        fallbackData: fallbackData
    )

    #expect(nonDataResult == .fallback(fallbackData))
    #expect(nonDataResult.data == fallbackData)
    #expect(nonDataResult.usesFallbackData)
    #expect(invalidDataResult == .fallback(fallbackData))
    #expect(invalidDataResult.data == fallbackData)
    #expect(invalidDataResult.usesFallbackData)
}

@Test func widgetCurrentObservationRenderingUsesValidStoredData() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let sharedPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Mira",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 4,
        mood: "Curious",
        ageLabel: "14 days",
        latestDiscoveryText: "Mira's glow echoes Luma's moonlit tail."
    ))
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let sharedData = try sharedPayload.encodeJSON()
    let fallbackData = try fallbackPayload.encodeJSON()
    defaults.set(sharedData, forKey: WidgetSharedDataKeys.currentObservationJSON)

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)
    let observation = try #require(result.payload?.observation)

    #expect(data == sharedData)
    #expect(observation.text.identityLine == "Mira - Lunarian - Gen 4")
    #expect(observation.text.stateLine == "Curious - 14 days")
    #expect(observation.text.discoveryLine == "Mira's glow echoes Luma's moonlit tail.")
    #expect(observation.text.memoryCueLine == "Quiet memory")
    #expect(observation.text.identityLine != "Fallback Luma - Lunarian - Gen 3")
}

@Test func widgetCurrentObservationRenderingConsumesAppWrittenLumaPayload() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
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
        relatedAncestorID: UUID()
    )
    let appObservation = WidgetPetObservation(
        creature: creature,
        mood: "Dreamy",
        ageLabel: "12 days"
    )
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Miri",
        speciesName: "Sylphian",
        growthStageName: "Baby",
        generation: 1,
        mood: "Quietly curious",
        ageLabel: "Tiny days",
        latestDiscoveryText: "Fallback Miri is resting quietly."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()

    let writeResult = WidgetCurrentObservationDataWriter.writeCurrentObservation(
        appObservation,
        to: defaults
    )
    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let sourceResult = WidgetPetObservationHandoffReader.currentObservation(from: data)
    let observation = try #require(sourceResult.payload?.observation)

    #expect(writeResult == .written)
    #expect(data != fallbackData)
    #expect(observation.text.identityLine == "Luma - Lunarian - Gen 3")
    #expect(observation.text.stateLine == "Dreamy - 12 days")
    #expect(observation.text.discoveryLine == "The floating tail shimmer resembles the first ancestor.")
    #expect(observation.text.memoryCueLine == "Juvenile inherited memory")
    #expect(observation.text.lineageCueLine == "Echoes an ancestor")
    #expect(observation.text.lineageCueCompactLine == "Family line")
    #expect(observation.snapshot.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
    #expect(observation.text.identityLine != "Fallback Miri - Sylphian - Gen 1")
}

@Test func widgetCurrentObservationPayloadContractBuildsAcknowledgedMiraObservation() throws {
    var creature = Creature(
        name: "Mira",
        species: .sylphian,
        genome: Genome(
            morph: MorphGenes(
                face: .feline,
                body: .sylphian,
                wing: .fairy,
                tail: .fish
            ),
            growth: GrowthGenes(
                wingGrowth: ScalarGene(0.68),
                tailGrowth: ScalarGene(0.34),
                glowGrowth: ScalarGene(0.42)
            )
        ),
        growthStage: .juvenile,
        generation: 3
    )
    creature.recordDiscovery(
        title: "Mira's winglets opened like soft leaves.",
        kind: .growth,
        stage: .juvenile
    )
    creature.recordDiscovery(
        title: "Mira's glow echoes Luma's moonlit tail.",
        kind: .inheritedResemblance,
        stage: .juvenile,
        relatedAncestorID: UUID(uuidString: "45B571D6-32AD-4C02-A58D-79941AE5E7DA")!
    )
    let observation = WidgetPetObservation(
        creature: creature,
        mood: "Dreamy",
        ageLabel: "12 days"
    )
    let payload = WidgetPetObservationTransferPayload(observation: observation)
    let decoded = try WidgetPetObservationTransferPayload.decodeJSON(from: payload.encodeJSON())
    let restoredObservation = decoded.observation

    #expect(payload.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion)
    #expect(payload.schemaVersion == 1)
    #expect(payload.name == "Mira")
    #expect(payload.speciesName == "Sylphian")
    #expect(payload.growthStageName == "Juvenile")
    #expect(payload.generation == 3)
    #expect(payload.mood == "Dreamy")
    #expect(payload.ageLabel == "12 days")
    #expect(payload.latestDiscoveryText == "Mira's glow echoes Luma's moonlit tail.")
    #expect(payload.latestDiscoveryMemoryCueLabel == "Juvenile inherited memory")
    #expect(payload.latestDiscoveryLineageCueLabel == "Echoes an ancestor")
    #expect(decoded == payload)
    #expect(restoredObservation.text.identityLine == "Mira - Sylphian - Gen 3")
    #expect(restoredObservation.text.stateLine == "Dreamy - 12 days")
    #expect(restoredObservation.text.discoveryLine == "Mira's glow echoes Luma's moonlit tail.")
    #expect(restoredObservation.text.memoryCueLine == "Juvenile inherited memory")
    #expect(restoredObservation.text.lineageCueLine == "Echoes an ancestor")
    #expect(restoredObservation.text.lineageCueCompactLine == "Family line")
}

@Test func widgetCurrentObservationHidesSelectiveCueForAppWrittenOrdinaryDiscovery() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
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
    let appObservation = WidgetPetObservation(
        creature: creature,
        mood: "Gently floating",
        ageLabel: "Tiny days"
    )

    let writeResult = WidgetCurrentObservationDataWriter.writeCurrentObservation(
        appObservation,
        to: defaults
    )
    let data = try #require(defaults.data(forKey: WidgetSharedDataKeys.currentObservationJSON))
    let sourceResult = WidgetPetObservationHandoffReader.currentObservation(from: data)
    let observation = try #require(sourceResult.payload?.observation)

    #expect(writeResult == .written)
    #expect(observation.text.discoveryLine == "Miri learned a soft hover.")
    #expect(observation.text.memoryCueLine == "Baby growth memory")
    #expect(observation.text.lineageCueLine == nil)
    #expect(observation.text.lineageCueCompactLine == nil)
    #expect(observation.text.lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: 44) == nil)
    #expect(observation.snapshot.latestDiscoveryLineageCueLabel == nil)
}

@Test func widgetCurrentObservationDataWriterStoresEncodedPayload() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let payload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Mira",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 4,
        mood: "Curious",
        ageLabel: "14 days",
        latestDiscoveryText: "Mira's glow echoes Luma's moonlit tail."
    ))

    let result = WidgetCurrentObservationDataWriter.writeCurrentObservationPayload(
        payload,
        to: defaults
    )
    let storedData = try #require(defaults.data(forKey: WidgetSharedDataKeys.currentObservationJSON))
    let decoded = try WidgetPetObservationTransferPayload.decodeJSON(from: storedData)

    #expect(result == .written)
    #expect(decoded == payload)
    #expect(decoded.schemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion)
}

@Test func widgetCurrentObservationDataWriterFailsWhenDefaultsMissing() {
    let snapshot = WidgetPetSnapshot(
        name: "Mira",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 4,
        mood: "Curious",
        ageLabel: "14 days",
        latestDiscoveryText: "Mira's glow echoes Luma's moonlit tail."
    )
    let observation = WidgetPetObservation(
        snapshot: snapshot,
        text: WidgetPetSnapshotText(snapshot: snapshot)
    )

    let result = WidgetCurrentObservationDataWriter.writeCurrentObservation(
        observation,
        to: nil
    )

    #expect(result == .failed)
}

@Test func widgetCurrentObservationDataProviderFallsBackWhenDefaultsMissing() throws {
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: nil,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(data == fallbackData)
    #expect(result.payload == fallbackPayload)
}

@Test func widgetCurrentObservationDataProviderFallsBackWhenKeyMissing() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(data == fallbackData)
    #expect(result.payload == fallbackPayload)
}

@Test func widgetCurrentObservationDataProviderFallsBackWhenValueIsNotData() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()
    defaults.set("not data", forKey: WidgetSharedDataKeys.currentObservationJSON)

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(data == fallbackData)
    #expect(result.payload == fallbackPayload)
}

@Test func widgetCurrentObservationDataProviderFallsBackWhenStoredDataIsInvalid() throws {
    let suiteName = "WiPetTests.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer {
        defaults.removePersistentDomain(forName: suiteName)
    }
    let fallbackPayload = WidgetPetObservationTransferPayload(snapshot: WidgetPetSnapshot(
        name: "Fallback Luma",
        speciesName: "Lunarian",
        growthStageName: "Juvenile",
        generation: 3,
        mood: "Dreamy",
        ageLabel: "12 days",
        latestDiscoveryText: "The floating tail shimmer resembles the first ancestor."
    ))
    let fallbackData = try fallbackPayload.encodeJSON()
    defaults.set(Data("not a widget observation payload".utf8), forKey: WidgetSharedDataKeys.currentObservationJSON)

    let data = WidgetCurrentObservationDataProvider.currentObservationData(
        from: defaults,
        fallbackData: fallbackData
    )
    let result = WidgetPetObservationHandoffReader.currentObservation(from: data)

    #expect(data == fallbackData)
    #expect(result.payload == fallbackPayload)
}
