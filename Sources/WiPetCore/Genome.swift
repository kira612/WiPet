import Foundation
import GameplayKit

public struct Genome: Equatable, Sendable {
    public var morph: MorphGenes
    public var growth: GrowthGenes
    public var motion: MotionGenes
    public var personality: PersonalityGenes
    public var pattern: PatternGenes

    public init(
        morph: MorphGenes,
        growth: GrowthGenes = GrowthGenes(),
        motion: MotionGenes = MotionGenes(),
        personality: PersonalityGenes = PersonalityGenes(),
        pattern: PatternGenes = PatternGenes()
    ) {
        self.morph = morph
        self.growth = growth
        self.motion = motion
        self.personality = personality
        self.pattern = pattern
    }
}

public struct ScalarGene: Equatable, Sendable {
    public var value: Double

    public init(_ value: Double) {
        self.value = min(1, max(0, value))
    }
}

public struct MorphGenes: Equatable, Sendable {
    public var face: FaceBase
    public var body: BodyBase
    public var wing: WingBase?
    public var tail: TailBase?

    public init(
        face: FaceBase,
        body: BodyBase,
        wing: WingBase? = nil,
        tail: TailBase? = nil
    ) {
        self.face = face
        self.body = body
        self.wing = wing
        self.tail = tail
    }
}

public struct GrowthGenes: Equatable, Sendable {
    public var hornGrowth: ScalarGene
    public var wingGrowth: ScalarGene
    public var tailGrowth: ScalarGene
    public var glowGrowth: ScalarGene

    public init(
        hornGrowth: ScalarGene = ScalarGene(0),
        wingGrowth: ScalarGene = ScalarGene(0),
        tailGrowth: ScalarGene = ScalarGene(0),
        glowGrowth: ScalarGene = ScalarGene(0)
    ) {
        self.hornGrowth = hornGrowth
        self.wingGrowth = wingGrowth
        self.tailGrowth = tailGrowth
        self.glowGrowth = glowGrowth
    }
}

public struct MotionGenes: Equatable, Sendable {
    public var blink: ScalarGene
    public var float: ScalarGene
    public var tailMotion: ScalarGene
    public var wingMotion: ScalarGene

    public init(
        blink: ScalarGene = ScalarGene(0.5),
        float: ScalarGene = ScalarGene(0.5),
        tailMotion: ScalarGene = ScalarGene(0.5),
        wingMotion: ScalarGene = ScalarGene(0.5)
    ) {
        self.blink = blink
        self.float = float
        self.tailMotion = tailMotion
        self.wingMotion = wingMotion
    }
}

public struct PersonalityGenes: Equatable, Sendable {
    public var curiosity: ScalarGene
    public var sociality: ScalarGene
    public var timidity: ScalarGene
    public var energy: ScalarGene
    public var sleepiness: ScalarGene
    public var mysticism: ScalarGene

    public init(
        curiosity: ScalarGene = ScalarGene(0.5),
        sociality: ScalarGene = ScalarGene(0.5),
        timidity: ScalarGene = ScalarGene(0.5),
        energy: ScalarGene = ScalarGene(0.5),
        sleepiness: ScalarGene = ScalarGene(0.5),
        mysticism: ScalarGene = ScalarGene(0.5)
    ) {
        self.curiosity = curiosity
        self.sociality = sociality
        self.timidity = timidity
        self.energy = energy
        self.sleepiness = sleepiness
        self.mysticism = mysticism
    }
}

public struct PatternGenes: Equatable, Sendable {
    public var contrast: ScalarGene
    public var glow: ScalarGene

    public init(
        contrast: ScalarGene = ScalarGene(0.5),
        glow: ScalarGene = ScalarGene(0)
    ) {
        self.contrast = contrast
        self.glow = glow
    }
}

public enum LineageMutationTrait: String, CaseIterable, Sendable {
    case face
    case body
    case wing
    case tail
    case glow
    case motion
}

public struct LineageMutationPlan: Equatable, Sendable {
    public var source: String
    public var seed: UInt64
    public var generation: Int
    public var inheritedTraitID: String
    public var mutationTraitID: String
    public var ancestralResemblance: Double
    public var mutationAmount: Double
    public var resemblanceLabel: String
    public var mutationLabel: String
    public var affinityLine: String

    public init(
        source: String = "GameplayKit",
        seed: UInt64,
        generation: Int,
        inheritedTraitID: String,
        mutationTraitID: String,
        ancestralResemblance: Double,
        mutationAmount: Double,
        resemblanceLabel: String,
        mutationLabel: String,
        affinityLine: String
    ) {
        self.source = source
        self.seed = seed
        self.generation = max(1, generation)
        self.inheritedTraitID = inheritedTraitID
        self.mutationTraitID = mutationTraitID
        self.ancestralResemblance = min(1, max(0, ancestralResemblance))
        self.mutationAmount = min(1, max(0, mutationAmount))
        self.resemblanceLabel = resemblanceLabel
        self.mutationLabel = mutationLabel
        self.affinityLine = affinityLine
    }

    public var hasRequiredFields: Bool {
        !source.isEmpty
            && seed > 0
            && generation >= 1
            && !inheritedTraitID.isEmpty
            && !mutationTraitID.isEmpty
            && !resemblanceLabel.isEmpty
            && !mutationLabel.isEmpty
            && !affinityLine.isEmpty
    }

    public var resemblanceAdvantage: Double {
        ancestralResemblance - mutationAmount
    }

    public func keepsAncestralResemblance(minimumAdvantage: Double = 0.50) -> Bool {
        ancestralResemblance > mutationAmount
            && resemblanceAdvantage >= max(0, minimumAdvantage)
    }

    public var summary: String {
        "lineageMutationPlan=source:\(source),seed:\(seed),generation:\(generation),inherit:\(inheritedTraitID),mutation:\(mutationTraitID),resemblance:\(Self.format(ancestralResemblance)),amount:\(Self.format(mutationAmount))"
    }

    public var readinessSummary: String {
        "lineageMutationPlanReady:\(hasRequiredFields)"
    }

    private static func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}

public struct LineageRandomnessLibraryAdoptionGate: Equatable, Sendable {
    public var plan: LineageMutationPlan
    public var repeatedPlan: LineageMutationPlan
    public var parentOrderStablePlan: LineageMutationPlan
    public var coreOnlyScope: Bool
    public var allowsPlayerFacingRandomness: Bool
    public var allowsPersistenceWrite: Bool
    public var externalDependencyRequired: Bool
    public var minimumResemblanceAdvantage: Double

    public init(
        plan: LineageMutationPlan,
        repeatedPlan: LineageMutationPlan,
        parentOrderStablePlan: LineageMutationPlan,
        coreOnlyScope: Bool = true,
        allowsPlayerFacingRandomness: Bool = false,
        allowsPersistenceWrite: Bool = false,
        externalDependencyRequired: Bool = false,
        minimumResemblanceAdvantage: Double = 0.50
    ) {
        self.plan = plan
        self.repeatedPlan = repeatedPlan
        self.parentOrderStablePlan = parentOrderStablePlan
        self.coreOnlyScope = coreOnlyScope
        self.allowsPlayerFacingRandomness = allowsPlayerFacingRandomness
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.externalDependencyRequired = externalDependencyRequired
        self.minimumResemblanceAdvantage = max(0, minimumResemblanceAdvantage)
    }

    public var usesGameplayKit: Bool {
        plan.source == "GameplayKit"
            && repeatedPlan.source == "GameplayKit"
            && parentOrderStablePlan.source == "GameplayKit"
    }

    public var deterministicReplay: Bool {
        plan == repeatedPlan
    }

    public var parentOrderStable: Bool {
        plan == parentOrderStablePlan
    }

    public var resemblanceBeatsMutation: Bool {
        plan.keepsAncestralResemblance(minimumAdvantage: minimumResemblanceAdvantage)
    }

    public var hasRequiredFields: Bool {
        plan.hasRequiredFields
            && repeatedPlan.hasRequiredFields
            && parentOrderStablePlan.hasRequiredFields
            && usesGameplayKit
            && deterministicReplay
            && parentOrderStable
            && resemblanceBeatsMutation
            && coreOnlyScope
            && !allowsPlayerFacingRandomness
            && !allowsPersistenceWrite
            && !externalDependencyRequired
    }

    public var summary: String {
        "lineageRandomnessLibraryAdoption=source:\(plan.source),deterministic:\(deterministicReplay),parentOrderStable:\(parentOrderStable),coreOnly:\(coreOnlyScope),playerFacingRandomness:\(allowsPlayerFacingRandomness),persistence:\(allowsPersistenceWrite),externalDependency:\(externalDependencyRequired),resemblanceBeatsMutation:\(resemblanceBeatsMutation)"
    }

    public var readinessSummary: String {
        "lineageRandomnessLibraryAdoptionReady:\(hasRequiredFields)"
    }
}

public struct LineageMutationAffectionProfile: Equatable, Sendable {
    public var plan: LineageMutationPlan
    public var inheritedLine: String
    public var variationLine: String
    public var safetyLine: String
    public var hidesSeedDetails: Bool
    public var exposesRawRandomness: Bool
    public var allowsPersistenceWrite: Bool
    public var playerFacing: Bool
    public var minimumResemblanceAdvantage: Double

    public init(
        plan: LineageMutationPlan,
        inheritedLine: String? = nil,
        variationLine: String? = nil,
        safetyLine: String = "Family resemblance stays stronger than the surprise.",
        hidesSeedDetails: Bool = true,
        exposesRawRandomness: Bool = false,
        allowsPersistenceWrite: Bool = false,
        playerFacing: Bool = false,
        minimumResemblanceAdvantage: Double = 0.50
    ) {
        self.plan = plan
        self.inheritedLine = inheritedLine ?? "Mostly echoes \(plan.inheritedTraitID)."
        self.variationLine = variationLine ?? "A \(plan.mutationLabel) may appear in \(plan.mutationTraitID)."
        self.safetyLine = safetyLine
        self.hidesSeedDetails = hidesSeedDetails
        self.exposesRawRandomness = exposesRawRandomness
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.playerFacing = playerFacing
        self.minimumResemblanceAdvantage = max(0, minimumResemblanceAdvantage)
    }

    public var usesGameplayKit: Bool {
        plan.source == "GameplayKit"
    }

    public var resemblanceBeatsMutation: Bool {
        plan.keepsAncestralResemblance(minimumAdvantage: minimumResemblanceAdvantage)
    }

    public var hasRequiredFields: Bool {
        plan.hasRequiredFields
            && usesGameplayKit
            && resemblanceBeatsMutation
            && !inheritedLine.isEmpty
            && !variationLine.isEmpty
            && !safetyLine.isEmpty
            && hidesSeedDetails
            && !exposesRawRandomness
            && !allowsPersistenceWrite
            && !playerFacing
    }

    public var summary: String {
        "lineageMutationAffectionProfile=source:\(plan.source),inherit:\(plan.inheritedTraitID),mutation:\(plan.mutationTraitID),hidesSeed:\(hidesSeedDetails),rawRandomness:\(exposesRawRandomness),persistence:\(allowsPersistenceWrite),playerFacing:\(playerFacing),resemblanceBeatsMutation:\(resemblanceBeatsMutation)"
    }

    public var readinessSummary: String {
        "lineageMutationAffectionProfileReady:\(hasRequiredFields)"
    }
}

public struct LineageMutationDistributionSample: Equatable, Sendable {
    public var plans: [LineageMutationPlan]
    public var minimumResemblanceAdvantage: Double
    public var gentleResemblanceRange: ClosedRange<Double>
    public var gentleMutationRange: ClosedRange<Double>

    public init(
        plans: [LineageMutationPlan],
        minimumResemblanceAdvantage: Double = 0.50,
        gentleResemblanceRange: ClosedRange<Double> = 0.72 ... 0.92,
        gentleMutationRange: ClosedRange<Double> = 0.06 ... 0.18
    ) {
        self.plans = plans
        self.minimumResemblanceAdvantage = max(0, minimumResemblanceAdvantage)
        self.gentleResemblanceRange = gentleResemblanceRange
        self.gentleMutationRange = gentleMutationRange
    }

    public var sampleCount: Int {
        plans.count
    }

    public var generationSpanLabel: String {
        guard let first = plans.first?.generation,
              let last = plans.last?.generation
        else {
            return "none"
        }

        return "\(first)-\(last)"
    }

    public var traitIDs: [String] {
        Array(Set(plans.map(\.mutationTraitID))).sorted()
    }

    public var allUseGameplayKit: Bool {
        !plans.isEmpty && plans.allSatisfy { $0.source == "GameplayKit" }
    }

    public var allHaveRequiredFields: Bool {
        !plans.isEmpty && plans.allSatisfy(\.hasRequiredFields)
    }

    public var allResemblanceBeatsMutation: Bool {
        !plans.isEmpty && plans.allSatisfy {
            $0.keepsAncestralResemblance(minimumAdvantage: minimumResemblanceAdvantage)
        }
    }

    public var allStayGentle: Bool {
        !plans.isEmpty && plans.allSatisfy {
            gentleResemblanceRange.contains($0.ancestralResemblance)
                && gentleMutationRange.contains($0.mutationAmount)
        }
    }

    public var hasTraitCoverage: Bool {
        !traitIDs.isEmpty
    }

    public var hasRequiredFields: Bool {
        allHaveRequiredFields
            && allUseGameplayKit
            && allResemblanceBeatsMutation
            && allStayGentle
            && hasTraitCoverage
            && generationSpanLabel != "none"
    }

    public var summary: String {
        "lineageMutationDistributionSample=source:\(sourceLabel),count:\(sampleCount),generations:\(generationSpanLabel),traits:\(traitLabel),minResemblance:\(Self.format(minimumResemblance)),maxMutation:\(Self.format(maximumMutation)),resemblanceBeatsMutation:\(allResemblanceBeatsMutation),gentle:\(allStayGentle)"
    }

    public var readinessSummary: String {
        "lineageMutationDistributionSampleReady:\(hasRequiredFields)"
    }

    private var sourceLabel: String {
        allUseGameplayKit ? "GameplayKit" : "mixed"
    }

    private var traitLabel: String {
        traitIDs.isEmpty ? "none" : traitIDs.joined(separator: "+")
    }

    private var minimumResemblance: Double {
        plans.map(\.ancestralResemblance).min() ?? 0
    }

    private var maximumMutation: Double {
        plans.map(\.mutationAmount).max() ?? 0
    }

    private static func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}

public struct LineageMutationPlanningProof: Equatable, Sendable {
    public var adoptionGate: LineageRandomnessLibraryAdoptionGate
    public var affectionProfile: LineageMutationAffectionProfile
    public var distributionSample: LineageMutationDistributionSample
    public var coreOnlyScope: Bool
    public var allowsPlayerFacingRandomness: Bool
    public var allowsPersistenceWrite: Bool
    public var externalDependencyRequired: Bool

    public init(
        adoptionGate: LineageRandomnessLibraryAdoptionGate,
        affectionProfile: LineageMutationAffectionProfile,
        distributionSample: LineageMutationDistributionSample,
        coreOnlyScope: Bool = true,
        allowsPlayerFacingRandomness: Bool = false,
        allowsPersistenceWrite: Bool = false,
        externalDependencyRequired: Bool = false
    ) {
        self.adoptionGate = adoptionGate
        self.affectionProfile = affectionProfile
        self.distributionSample = distributionSample
        self.coreOnlyScope = coreOnlyScope
        self.allowsPlayerFacingRandomness = allowsPlayerFacingRandomness
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.externalDependencyRequired = externalDependencyRequired
    }

    public var usesGameplayKit: Bool {
        adoptionGate.usesGameplayKit
            && affectionProfile.usesGameplayKit
            && distributionSample.allUseGameplayKit
    }

    public var deterministicReplay: Bool {
        adoptionGate.deterministicReplay
            && adoptionGate.parentOrderStable
    }

    public var keepsAffectionSafe: Bool {
        affectionProfile.hasRequiredFields
            && affectionProfile.hidesSeedDetails
            && !affectionProfile.exposesRawRandomness
            && !affectionProfile.allowsPersistenceWrite
            && !affectionProfile.playerFacing
    }

    public var keepsGentleDistribution: Bool {
        distributionSample.hasRequiredFields
            && distributionSample.allResemblanceBeatsMutation
            && distributionSample.allStayGentle
    }

    public var hasRequiredFields: Bool {
        adoptionGate.hasRequiredFields
            && keepsAffectionSafe
            && keepsGentleDistribution
            && usesGameplayKit
            && deterministicReplay
            && coreOnlyScope
            && !allowsPlayerFacingRandomness
            && !allowsPersistenceWrite
            && !externalDependencyRequired
    }

    public var summary: String {
        "lineageMutationPlanningProof=source:\(sourceLabel),deterministic:\(deterministicReplay),sample:\(distributionSample.sampleCount),affectionSafe:\(keepsAffectionSafe),gentle:\(keepsGentleDistribution),coreOnly:\(coreOnlyScope),playerFacingRandomness:\(allowsPlayerFacingRandomness),persistence:\(allowsPersistenceWrite),externalDependency:\(externalDependencyRequired)"
    }

    public var readinessSummary: String {
        "lineageMutationPlanningProofReady:\(hasRequiredFields)"
    }

    private var sourceLabel: String {
        usesGameplayKit ? "GameplayKit" : "mixed"
    }
}

public struct LineageParentGenome: Equatable, Sendable {
    public var id: UUID
    public var genome: Genome

    public init(
        id: UUID,
        genome: Genome
    ) {
        self.id = id
        self.genome = genome
    }
}

public struct LineageGenomePreview: Equatable, Sendable {
    public var plan: LineageMutationPlan
    public var genome: Genome
    public var inheritedParentID: UUID
    public var variationParentID: UUID
    public var changedTraitID: String
    public var affinityLine: String

    public init(
        plan: LineageMutationPlan,
        genome: Genome,
        inheritedParentID: UUID,
        variationParentID: UUID,
        changedTraitID: String,
        affinityLine: String
    ) {
        self.plan = plan
        self.genome = genome
        self.inheritedParentID = inheritedParentID
        self.variationParentID = variationParentID
        self.changedTraitID = changedTraitID
        self.affinityLine = affinityLine
    }

    public var hasRequiredFields: Bool {
        plan.hasRequiredFields
            && !changedTraitID.isEmpty
            && !affinityLine.isEmpty
    }

    public var summary: String {
        "lineageGenomePreview=source:\(plan.source),seed:\(plan.seed),inheritParent:\(inheritedParentID.uuidString),variationParent:\(variationParentID.uuidString),changed:\(changedTraitID),\(plan.summary)"
    }

    public var readinessSummary: String {
        "lineageGenomePreviewReady:\(hasRequiredFields)"
    }
}

public struct LineageGenomePreviewLibraryAdoptionGate: Equatable, Sendable {
    public var preview: LineageGenomePreview
    public var parentIDs: [UUID]
    public var coreOnlyScope: Bool
    public var allowsPlayerFacingRandomness: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var externalDependencyRequired: Bool

    public init(
        preview: LineageGenomePreview,
        parentIDs: [UUID],
        coreOnlyScope: Bool = true,
        allowsPlayerFacingRandomness: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        externalDependencyRequired: Bool = false
    ) {
        self.preview = preview
        self.parentIDs = parentIDs
        self.coreOnlyScope = coreOnlyScope
        self.allowsPlayerFacingRandomness = allowsPlayerFacingRandomness
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.externalDependencyRequired = externalDependencyRequired
    }

    public var usesGameplayKit: Bool {
        preview.plan.source == "GameplayKit"
    }

    public var changedTraitMatchesPlan: Bool {
        preview.changedTraitID == preview.plan.mutationTraitID
    }

    public var parentsStayInFamily: Bool {
        let familyIDs = Set(parentIDs)
        return !familyIDs.isEmpty
            && familyIDs.contains(preview.inheritedParentID)
            && familyIDs.contains(preview.variationParentID)
    }

    public var resemblanceBeatsMutation: Bool {
        preview.plan.keepsAncestralResemblance()
    }

    public var hasRequiredFields: Bool {
        preview.hasRequiredFields
            && usesGameplayKit
            && changedTraitMatchesPlan
            && parentsStayInFamily
            && resemblanceBeatsMutation
            && coreOnlyScope
            && !allowsPlayerFacingRandomness
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !externalDependencyRequired
    }

    public var summary: String {
        "lineageGenomePreviewLibraryAdoption=source:\(preview.plan.source),changedMatchesPlan:\(changedTraitMatchesPlan),parentsInFamily:\(parentsStayInFamily),resemblanceBeatsMutation:\(resemblanceBeatsMutation),coreOnly:\(coreOnlyScope),playerFacingRandomness:\(allowsPlayerFacingRandomness),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),externalDependency:\(externalDependencyRequired)"
    }

    public var readinessSummary: String {
        "lineageGenomePreviewLibraryAdoptionReady:\(hasRequiredFields)"
    }
}

public struct LineageReadOnlyPreviewCopy: Equatable, Sendable {
    public var gate: LineageGenomePreviewLibraryAdoptionGate
    public var title: String
    public var inheritedLine: String
    public var variationLine: String
    public var safetyLine: String
    public var exposesSeedDetails: Bool
    public var exposesRawRandomness: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var publishesWidgetHandoff: Bool
    public var playerFacing: Bool

    public init(
        gate: LineageGenomePreviewLibraryAdoptionGate,
        inheritedParentDisplayName: String,
        variationAncestorDisplayName: String,
        title: String = "Family preview",
        inheritedLine: String? = nil,
        variationLine: String? = nil,
        safetyLine: String = "Family resemblance stays stronger than the surprise.",
        exposesSeedDetails: Bool = false,
        exposesRawRandomness: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        publishesWidgetHandoff: Bool = false,
        playerFacing: Bool = false
    ) {
        self.gate = gate
        self.title = title
        self.inheritedLine = inheritedLine
            ?? "This draft stays closest to \(inheritedParentDisplayName)."
        self.variationLine = variationLine
            ?? "\(variationAncestorDisplayName) may lend a \(gate.preview.plan.mutationLabel) \(gate.preview.changedTraitID) cue."
        self.safetyLine = safetyLine
        self.exposesSeedDetails = exposesSeedDetails
        self.exposesRawRandomness = exposesRawRandomness
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.playerFacing = playerFacing
    }

    public static func preview(
        parents: [LineageParentGenome],
        generation: Int,
        inheritedParentDisplayName: String,
        variationAncestorDisplayName: String,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageReadOnlyPreviewCopy? {
        guard let gate = LineageGenomePreviewPlanner.libraryAdoptionGate(
            parents: parents,
            generation: generation,
            salt: salt
        ) else {
            return nil
        }

        let copy = LineageReadOnlyPreviewCopy(
            gate: gate,
            inheritedParentDisplayName: inheritedParentDisplayName,
            variationAncestorDisplayName: variationAncestorDisplayName
        )

        return copy.hasRequiredFields ? copy : nil
    }

    public var hasRequiredFields: Bool {
        gate.hasRequiredFields
            && !title.isEmpty
            && !inheritedLine.isEmpty
            && !variationLine.isEmpty
            && !safetyLine.isEmpty
            && !exposesSeedDetails
            && !exposesRawRandomness
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !publishesWidgetHandoff
            && !playerFacing
    }

    public var summary: String {
        "lineageReadOnlyPreviewCopy=title:\(title),changed:\(gate.preview.changedTraitID),resemblanceBeatsMutation:\(gate.resemblanceBeatsMutation),seedHidden:\(!exposesSeedDetails),rawRandomness:\(exposesRawRandomness),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),widget:\(publishesWidgetHandoff),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageReadOnlyPreviewCopyReady:\(hasRequiredFields)"
    }
}

public struct LineageReadOnlyPreviewSurface: Equatable, Sendable {
    public var copy: LineageReadOnlyPreviewCopy
    public var title: String
    public var subtitle: String
    public var inheritedLine: String
    public var variationLine: String
    public var safetyLine: String
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsGraphNavigation: Bool
    public var allowsOptimizationControls: Bool
    public var publishesWidgetHandoff: Bool
    public var playerFacing: Bool

    public init(
        copy: LineageReadOnlyPreviewCopy,
        title: String = "Family preview",
        subtitle: String = "A quiet look at what this line may remember.",
        inheritedLine: String? = nil,
        variationLine: String? = nil,
        safetyLine: String? = nil,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsGraphNavigation: Bool = false,
        allowsOptimizationControls: Bool = false,
        publishesWidgetHandoff: Bool = false,
        playerFacing: Bool = false
    ) {
        self.copy = copy
        self.title = title
        self.subtitle = subtitle
        self.inheritedLine = inheritedLine ?? copy.inheritedLine
        self.variationLine = variationLine ?? copy.variationLine
        self.safetyLine = safetyLine ?? copy.safetyLine
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsGraphNavigation = allowsGraphNavigation
        self.allowsOptimizationControls = allowsOptimizationControls
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.playerFacing = playerFacing
    }

    public static func preview(
        parents: [LineageParentGenome],
        generation: Int,
        inheritedParentDisplayName: String,
        variationAncestorDisplayName: String,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageReadOnlyPreviewSurface? {
        guard let copy = LineageReadOnlyPreviewCopy.preview(
            parents: parents,
            generation: generation,
            inheritedParentDisplayName: inheritedParentDisplayName,
            variationAncestorDisplayName: variationAncestorDisplayName,
            salt: salt
        ) else {
            return nil
        }

        let surface = LineageReadOnlyPreviewSurface(copy: copy)
        return surface.hasRequiredFields ? surface : nil
    }

    public var hasRequiredFields: Bool {
        copy.hasRequiredFields
            && !title.isEmpty
            && !subtitle.isEmpty
            && !inheritedLine.isEmpty
            && !variationLine.isEmpty
            && !safetyLine.isEmpty
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsGraphNavigation
            && !allowsOptimizationControls
            && !publishesWidgetHandoff
            && !playerFacing
    }

    public var summary: String {
        "lineageReadOnlyPreviewSurface=title:\(title),changed:\(copy.gate.preview.changedTraitID),readOnly:\(!allowsPersistenceWrite && !allowsBreedingControls),graph:\(allowsGraphNavigation),optimization:\(allowsOptimizationControls),widget:\(publishesWidgetHandoff),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageReadOnlyPreviewSurfaceReady:\(hasRequiredFields)"
    }
}

public struct LineageReadOnlyPreviewSurfaceText: Equatable, Sendable {
    public var surface: LineageReadOnlyPreviewSurface
    public var titleLine: String
    public var subtitleLine: String
    public var inheritedLine: String
    public var variationLine: String
    public var safetyLine: String

    public init?(
        surface: LineageReadOnlyPreviewSurface
    ) {
        guard surface.hasRequiredFields else {
            return nil
        }

        self.surface = surface
        self.titleLine = surface.title
        self.subtitleLine = surface.subtitle
        self.inheritedLine = surface.inheritedLine
        self.variationLine = surface.variationLine
        self.safetyLine = surface.safetyLine
    }

    public static func preview(
        parents: [LineageParentGenome],
        generation: Int,
        inheritedParentDisplayName: String,
        variationAncestorDisplayName: String,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageReadOnlyPreviewSurfaceText? {
        guard let surface = LineageReadOnlyPreviewSurface.preview(
            parents: parents,
            generation: generation,
            inheritedParentDisplayName: inheritedParentDisplayName,
            variationAncestorDisplayName: variationAncestorDisplayName,
            salt: salt
        ) else {
            return nil
        }

        return LineageReadOnlyPreviewSurfaceText(surface: surface)
    }

    public var hasRequiredFields: Bool {
        surface.hasRequiredFields
            && !titleLine.isEmpty
            && !subtitleLine.isEmpty
            && !inheritedLine.isEmpty
            && !variationLine.isEmpty
            && !safetyLine.isEmpty
            && !containsHiddenRandomDetails
    }

    public var lines: [String] {
        [
            titleLine,
            subtitleLine,
            inheritedLine,
            variationLine,
            safetyLine
        ]
    }

    public var snapshotText: String {
        lines.joined(separator: "\n")
    }

    public var containsHiddenRandomDetails: Bool {
        let text = snapshotText.lowercased()
        return text.contains("seed")
            || text.contains("random")
    }

    public var summary: String {
        "lineageReadOnlyPreviewSurfaceText=lines:\(lines.count),changed:\(surface.copy.gate.preview.changedTraitID),readOnly:\(!surface.allowsPersistenceWrite && !surface.allowsBreedingControls),hiddenRandomDetails:\(containsHiddenRandomDetails)"
    }

    public var readinessSummary: String {
        "lineageReadOnlyPreviewSurfaceTextReady:\(hasRequiredFields)"
    }
}

public struct LineageChildDraftMemoryReference: Equatable, Sendable {
    public var preview: LineageGenomePreview
    public var memorySource: String
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var playerFacing: Bool

    public init(
        preview: LineageGenomePreview,
        memorySource: String = "genomeVariationQA",
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.preview = preview
        self.memorySource = memorySource
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        preview.hasRequiredFields
            && !memorySource.isEmpty
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !playerFacing
    }

    public var summary: String {
        "lineageChildDraftMemory=source:\(memorySource),generation:\(preview.plan.generation),changed:\(preview.changedTraitID),inheritParent:\(preview.inheritedParentID.uuidString),variationParent:\(preview.variationParentID.uuidString),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageChildDraftMemoryReady:\(hasRequiredFields)"
    }
}

public struct LineageChildDraftInheritedFaceEcho: Equatable, Sendable {
    public var memoryReference: LineageChildDraftMemoryReference
    public var ancestorLabel: String
    public var faceCue: String
    public var accentCue: String
    public var accentDotCount: Int
    public var visibleInDraftPortrait: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var playerFacing: Bool

    public init(
        memoryReference: LineageChildDraftMemoryReference,
        ancestorLabel: String,
        faceCue: String,
        accentCue: String,
        accentDotCount: Int = 0,
        visibleInDraftPortrait: Bool = true,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.memoryReference = memoryReference
        self.ancestorLabel = ancestorLabel
        self.faceCue = faceCue
        self.accentCue = accentCue
        self.accentDotCount = accentDotCount
        self.visibleInDraftPortrait = visibleInDraftPortrait
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.playerFacing = playerFacing
    }

    public var isFaceEcho: Bool {
        memoryReference.preview.changedTraitID == LineageMutationTrait.face.rawValue
    }

    public var hasRequiredFields: Bool {
        memoryReference.hasRequiredFields
            && isFaceEcho
            && !ancestorLabel.isEmpty
            && !faceCue.isEmpty
            && !accentCue.isEmpty
            && accentDotCount >= 0
            && accentDotCount <= 5
            && visibleInDraftPortrait
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !playerFacing
    }

    public var summary: String {
        "lineageChildDraftInheritedFaceEcho=source:\(memoryReference.memorySource),changed:\(memoryReference.preview.changedTraitID),ancestor:\(ancestorLabel),face:\(faceCue),accent:\(accentCue),dots:\(accentDotCount),visible:\(visibleInDraftPortrait),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageChildDraftInheritedFaceEchoReady:\(hasRequiredFields)"
    }
}

public struct LineageChildDraftInheritedVisualCuePolicy: Equatable, Sendable {
    public var memoryReference: LineageChildDraftMemoryReference
    public var inheritedWing: WingBase?
    public var inheritedTail: TailBase?
    public var sourceLabel: String
    public var inheritedFromLabel: String
    public var previewOnly: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var allowsBreedingControls: Bool
    public var exposesPlayerControls: Bool
    public var outputsGeneratedAssets: Bool
    public var playerFacing: Bool

    public init(
        memoryReference: LineageChildDraftMemoryReference,
        inheritedWing: WingBase? = nil,
        inheritedTail: TailBase? = nil,
        sourceLabel: String = "genomeVariationQA",
        inheritedFromLabel: String,
        previewOnly: Bool = true,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        allowsBreedingControls: Bool = false,
        exposesPlayerControls: Bool = false,
        outputsGeneratedAssets: Bool = false,
        playerFacing: Bool = false
    ) {
        self.memoryReference = memoryReference
        self.inheritedWing = inheritedWing
        self.inheritedTail = inheritedTail
        self.sourceLabel = sourceLabel
        self.inheritedFromLabel = inheritedFromLabel
        self.previewOnly = previewOnly
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.allowsBreedingControls = allowsBreedingControls
        self.exposesPlayerControls = exposesPlayerControls
        self.outputsGeneratedAssets = outputsGeneratedAssets
        self.playerFacing = playerFacing
    }

    public var hasInheritedVisualCue: Bool {
        inheritedWing != nil || inheritedTail != nil
    }

    public var hasRequiredFields: Bool {
        memoryReference.hasRequiredFields
            && hasInheritedVisualCue
            && !sourceLabel.isEmpty
            && !inheritedFromLabel.isEmpty
            && previewOnly
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !allowsBreedingControls
            && !exposesPlayerControls
            && !outputsGeneratedAssets
            && !playerFacing
    }

    public func renderGenome(for draftGenome: Genome) -> Genome {
        var genome = draftGenome
        if let inheritedWing {
            genome.morph.wing = inheritedWing
        }
        if let inheritedTail {
            genome.morph.tail = inheritedTail
        }
        return genome
    }

    public var summary: String {
        "lineageChildDraftInheritedVisualCuePolicy=source:\(sourceLabel),changed:\(memoryReference.preview.changedTraitID),wing:\(inheritedWing?.rawValue ?? "none"),tail:\(inheritedTail?.rawValue ?? "none"),inheritedFrom:\(inheritedFromLabel),previewOnly:\(previewOnly),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),breeding:\(allowsBreedingControls),controls:\(exposesPlayerControls),assetOutputs:\(outputsGeneratedAssets ? "generated" : "none"),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageChildDraftInheritedVisualCuePolicyReady:\(hasRequiredFields)"
    }
}

public struct LineageGenomeVariationFamilyEchoCopy: Equatable, Sendable {
    public var memoryReference: LineageChildDraftMemoryReference
    public var inheritedParentDisplayName: String
    public var variationAncestorDisplayName: String
    public var inheritedCue: String
    public var changedCue: String
    public var visibleLine: String
    public var exposesSeedDetails: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var playerFacing: Bool

    public init(
        memoryReference: LineageChildDraftMemoryReference,
        inheritedParentDisplayName: String,
        variationAncestorDisplayName: String,
        inheritedCue: String,
        changedCue: String,
        visibleLine: String? = nil,
        exposesSeedDetails: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.memoryReference = memoryReference
        self.inheritedParentDisplayName = inheritedParentDisplayName
        self.variationAncestorDisplayName = variationAncestorDisplayName
        self.inheritedCue = inheritedCue
        self.changedCue = changedCue
        self.visibleLine = visibleLine
            ?? "\(inheritedParentDisplayName) keeps \(inheritedCue) in the family, while \(variationAncestorDisplayName)'s \(changedCue) may softly appear in the child draft."
        self.exposesSeedDetails = exposesSeedDetails
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        memoryReference.hasRequiredFields
            && !inheritedParentDisplayName.isEmpty
            && !variationAncestorDisplayName.isEmpty
            && !inheritedCue.isEmpty
            && !changedCue.isEmpty
            && !visibleLine.isEmpty
            && !exposesSeedDetails
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !playerFacing
    }

    public var summary: String {
        "lineageGenomeVariationFamilyEchoCopy=source:\(memoryReference.memorySource),generation:\(memoryReference.preview.plan.generation),changed:\(memoryReference.preview.changedTraitID),inheritedParent:\(inheritedParentDisplayName),variationAncestor:\(variationAncestorDisplayName),inheritedCue:\(inheritedCue),changedCue:\(changedCue),seed:\(exposesSeedDetails),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageGenomeVariationFamilyEchoCopyReady:\(hasRequiredFields)"
    }
}

public struct LineageAncestorPortraitMemoryCardCopy: Equatable, Sendable {
    public var familyEchoCopy: LineageGenomeVariationFamilyEchoCopy
    public var title: String
    public var ancestorPortraitLabel: String
    public var inheritedCueLine: String
    public var changedCueLine: String
    public var safetyLine: String
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var publishesWidgetHandoff: Bool
    public var playerFacing: Bool

    public init(
        familyEchoCopy: LineageGenomeVariationFamilyEchoCopy,
        title: String = "Ancestor memory",
        ancestorPortraitLabel: String? = nil,
        inheritedCueLine: String? = nil,
        changedCueLine: String? = nil,
        safetyLine: String = "This card only remembers the family echo.",
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        publishesWidgetHandoff: Bool = false,
        playerFacing: Bool = false
    ) {
        self.familyEchoCopy = familyEchoCopy
        self.title = title
        self.ancestorPortraitLabel = ancestorPortraitLabel
            ?? "\(familyEchoCopy.variationAncestorDisplayName) portrait"
        self.inheritedCueLine = inheritedCueLine
            ?? "\(familyEchoCopy.inheritedParentDisplayName) keeps \(familyEchoCopy.inheritedCue) close."
        self.changedCueLine = changedCueLine
            ?? "\(familyEchoCopy.variationAncestorDisplayName)'s \(familyEchoCopy.changedCue) is remembered here."
        self.safetyLine = safetyLine
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.playerFacing = playerFacing
    }

    public var lines: [String] {
        [
            title,
            ancestorPortraitLabel,
            inheritedCueLine,
            changedCueLine,
            safetyLine
        ]
    }

    public var containsHiddenRandomDetails: Bool {
        let text = lines.joined(separator: " ").lowercased()
        return text.contains("seed")
            || text.contains("random")
    }

    public var hasRequiredFields: Bool {
        familyEchoCopy.hasRequiredFields
            && !lines.contains { $0.isEmpty }
            && !containsHiddenRandomDetails
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !publishesWidgetHandoff
            && !playerFacing
    }

    public var summary: String {
        "lineageAncestorPortraitMemoryCard=ancestor:\(familyEchoCopy.variationAncestorDisplayName),portrait:\(ancestorPortraitLabel),changed:\(familyEchoCopy.memoryReference.preview.changedTraitID),inheritedCue:\(familyEchoCopy.inheritedCue),changedCue:\(familyEchoCopy.changedCue),readOnly:\(!allowsPersistenceWrite && !allowsBreedingControls),seed:\(familyEchoCopy.exposesSeedDetails),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),widget:\(publishesWidgetHandoff),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageAncestorPortraitMemoryCardReady:\(hasRequiredFields)"
    }
}

public struct LineageChildDraftAcknowledgementPreview: Equatable, Sendable {
    public var memoryReference: LineageChildDraftMemoryReference
    public var acknowledgementLine: String
    public var isAcknowledged: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var playerFacing: Bool

    public init(
        memoryReference: LineageChildDraftMemoryReference,
        acknowledgementLine: String = "Notice the family echo before this draft becomes a memory.",
        isAcknowledged: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.memoryReference = memoryReference
        self.acknowledgementLine = acknowledgementLine
        self.isAcknowledged = isAcknowledged
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.playerFacing = playerFacing
    }

    public var allowsCommit: Bool {
        isAcknowledged
            && allowsPersistenceWrite
            && !allowsBreedingControls
            && playerFacing
    }

    public var hasRequiredFields: Bool {
        memoryReference.hasRequiredFields
            && !acknowledgementLine.isEmpty
            && !allowsCommit
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !playerFacing
    }

    public var summary: String {
        "lineageChildDraftAcknowledgement=source:\(memoryReference.memorySource),generation:\(memoryReference.preview.plan.generation),changed:\(memoryReference.preview.changedTraitID),acknowledged:\(isAcknowledged),allowsCommit:\(allowsCommit),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageChildDraftAcknowledgementReady:\(hasRequiredFields)"
    }
}

public struct LineageChildDraftAcknowledgementSurfaceCopy: Equatable, Sendable {
    public var acknowledgement: LineageChildDraftAcknowledgementPreview
    public var promptLine: String
    public var waitingLine: String

    public init(
        acknowledgement: LineageChildDraftAcknowledgementPreview,
        promptLine: String? = nil,
        waitingLine: String? = nil
    ) {
        self.acknowledgement = acknowledgement
        self.promptLine = promptLine ?? acknowledgement.acknowledgementLine
        self.waitingLine = waitingLine ?? "This family echo will wait until the moment is ready."
    }

    public var hasRequiredFields: Bool {
        acknowledgement.hasRequiredFields
            && !promptLine.isEmpty
            && !waitingLine.isEmpty
            && !acknowledgement.allowsCommit
    }

    public var summary: String {
        "lineageChildDraftAcknowledgementSurface=acknowledged:\(acknowledgement.isAcknowledged),allowsCommit:\(acknowledgement.allowsCommit),promptReady:\(!promptLine.isEmpty),waitingReady:\(!waitingLine.isEmpty)"
    }

    public var readinessSummary: String {
        "lineageChildDraftAcknowledgementSurfaceReady:\(hasRequiredFields)"
    }
}

public struct LineageGenomePreviewComparison: Equatable, Sendable {
    public var first: LineageGenomePreview
    public var second: LineageGenomePreview
    public var sharedParentIDs: [UUID]
    public var sharedChangedTraitIDs: [String]
    public var distinctChangedTraitIDs: [String]
    public var familyLine: String

    public init(
        first: LineageGenomePreview,
        second: LineageGenomePreview,
        sharedParentIDs: [UUID],
        sharedChangedTraitIDs: [String],
        distinctChangedTraitIDs: [String],
        familyLine: String
    ) {
        self.first = first
        self.second = second
        self.sharedParentIDs = sharedParentIDs
        self.sharedChangedTraitIDs = sharedChangedTraitIDs
        self.distinctChangedTraitIDs = distinctChangedTraitIDs
        self.familyLine = familyLine
    }

    public var hasRequiredFields: Bool {
        first.hasRequiredFields
            && second.hasRequiredFields
            && !sharedParentIDs.isEmpty
            && !familyLine.isEmpty
    }

    public var summary: String {
        "lineageGenomePreviewComparison=first:\(first.changedTraitID),second:\(second.changedTraitID),shared:\(Self.format(sharedChangedTraitIDs)),distinct:\(Self.format(distinctChangedTraitIDs)),parents:\(sharedParentIDs.count)"
    }

    public var readinessSummary: String {
        "lineageGenomePreviewComparisonReady:\(hasRequiredFields)"
    }

    private static func format(_ values: [String]) -> String {
        values.isEmpty ? "none" : values.joined(separator: "+")
    }
}

public enum LineageMutationPlanner {
    public static func affectionProfile(
        parentIDs: [UUID],
        generation: Int,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageMutationAffectionProfile? {
        guard let plan = plan(
            parentIDs: parentIDs,
            generation: generation,
            salt: salt
        ) else {
            return nil
        }

        let profile = LineageMutationAffectionProfile(plan: plan)
        return profile.hasRequiredFields ? profile : nil
    }

    public static func distributionSample(
        parentIDs: [UUID],
        generationRange: Range<Int>,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageMutationDistributionSample? {
        guard !parentIDs.isEmpty,
              !generationRange.isEmpty
        else {
            return nil
        }

        let plans = generationRange.compactMap { generation in
            plan(
                parentIDs: parentIDs,
                generation: generation,
                salt: salt
            )
        }

        guard plans.count == generationRange.count else {
            return nil
        }

        return LineageMutationDistributionSample(plans: plans)
    }

    public static func libraryAdoptionGate(
        parentIDs: [UUID],
        generation: Int,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageRandomnessLibraryAdoptionGate? {
        guard !parentIDs.isEmpty,
              let plan = plan(
                  parentIDs: parentIDs,
                  generation: generation,
                  salt: salt
              ),
              let repeatedPlan = Self.plan(
                  parentIDs: parentIDs,
                  generation: generation,
                  salt: salt
              ),
              let parentOrderStablePlan = Self.plan(
                  parentIDs: Array(parentIDs.reversed()),
                  generation: generation,
                  salt: salt
              )
        else {
            return nil
        }

        return LineageRandomnessLibraryAdoptionGate(
            plan: plan,
            repeatedPlan: repeatedPlan,
            parentOrderStablePlan: parentOrderStablePlan
        )
    }

    public static func planningProof(
        parentIDs: [UUID],
        generation: Int,
        salt: String = "WiPetLineageMutationV1",
        sampleGenerationRange: Range<Int>? = nil
    ) -> LineageMutationPlanningProof? {
        let sampleRange = sampleGenerationRange ?? generation ..< generation + 4
        guard let adoptionGate = libraryAdoptionGate(
                  parentIDs: parentIDs,
                  generation: generation,
                  salt: salt
              ),
              let affectionProfile = affectionProfile(
                  parentIDs: parentIDs,
                  generation: generation,
                  salt: salt
              ),
              let distributionSample = distributionSample(
                  parentIDs: parentIDs,
                  generationRange: sampleRange,
                  salt: salt
              )
        else {
            return nil
        }

        return LineageMutationPlanningProof(
            adoptionGate: adoptionGate,
            affectionProfile: affectionProfile,
            distributionSample: distributionSample
        )
    }

    public static func plan(
        parentIDs: [UUID],
        generation: Int,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageMutationPlan? {
        guard !parentIDs.isEmpty else {
            return nil
        }

        let clampedGeneration = max(1, generation)
        let seed = deterministicSeed(
            parentIDs: parentIDs,
            generation: clampedGeneration,
            salt: salt
        )
        let randomSource = GKLinearCongruentialRandomSource(seed: seed)
        let traits = LineageMutationTrait.allCases
        let traitDistribution = GKRandomDistribution(
            randomSource: randomSource,
            lowestValue: 0,
            highestValue: traits.count - 1
        )
        let inheritedIndex = traitDistribution.nextInt()
        var mutationIndex = traitDistribution.nextInt()
        if mutationIndex == inheritedIndex {
            mutationIndex = (mutationIndex + 1) % traits.count
        }

        let resemblanceDistribution = GKGaussianDistribution(
            randomSource: randomSource,
            lowestValue: 72,
            highestValue: 92
        )
        let mutationDistribution = GKGaussianDistribution(
            randomSource: randomSource,
            lowestValue: 6,
            highestValue: 18
        )
        let ancestralResemblance = Double(resemblanceDistribution.nextInt()) / 100
        let mutationAmount = Double(mutationDistribution.nextInt()) / 100
        let inheritedTrait = traits[inheritedIndex].rawValue
        let mutationTrait = traits[mutationIndex].rawValue
        let resemblanceLabel = resemblanceLabel(for: ancestralResemblance)
        let mutationLabel = mutationLabel(for: mutationAmount)

        return LineageMutationPlan(
            seed: seed,
            generation: clampedGeneration,
            inheritedTraitID: inheritedTrait,
            mutationTraitID: mutationTrait,
            ancestralResemblance: ancestralResemblance,
            mutationAmount: mutationAmount,
            resemblanceLabel: resemblanceLabel,
            mutationLabel: mutationLabel,
            affinityLine: "Mostly echoes \(inheritedTrait), with a \(mutationLabel) in \(mutationTrait)."
        )
    }

    private static func deterministicSeed(
        parentIDs: [UUID],
        generation: Int,
        salt: String
    ) -> UInt64 {
        var hash: UInt64 = 14_695_981_039_346_656_037

        func combine(_ text: String) {
            for byte in text.utf8 {
                hash ^= UInt64(byte)
                hash &*= 1_099_511_628_211
            }
        }

        combine(salt)
        parentIDs
            .map(\.uuidString)
            .sorted()
            .forEach(combine)
        combine("generation:\(max(1, generation))")

        return hash == 0 ? 1 : hash
    }

    private static func resemblanceLabel(for value: Double) -> String {
        if value >= 0.84 {
            return "strongAncestorEcho"
        } else if value >= 0.78 {
            return "clearFamilyEcho"
        } else {
            return "softFamilyEcho"
        }
    }

    private static func mutationLabel(for value: Double) -> String {
        if value <= 0.10 {
            return "tinyVariation"
        } else if value <= 0.15 {
            return "gentleVariation"
        } else {
            return "noticeableButSoft"
        }
    }
}

public enum LineageGenomePreviewPlanner {
    public static func libraryAdoptionGate(
        parents: [LineageParentGenome],
        generation: Int,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageGenomePreviewLibraryAdoptionGate? {
        guard let preview = preview(
            parents: parents,
            generation: generation,
            salt: salt
        ) else {
            return nil
        }

        let parentIDs = parents
            .map(\.id)
            .sorted { $0.uuidString < $1.uuidString }

        return LineageGenomePreviewLibraryAdoptionGate(
            preview: preview,
            parentIDs: parentIDs
        )
    }

    public static func preview(
        parents: [LineageParentGenome],
        generation: Int,
        matchingMutationTraits: Set<LineageMutationTrait>,
        preferredVariationParentID: UUID? = nil,
        saltPrefix: String = "WiPetLineageMutationSearch",
        maxAttempts: Int = 64
    ) -> LineageGenomePreview? {
        guard !parents.isEmpty,
              !matchingMutationTraits.isEmpty,
              maxAttempts > 0
        else {
            return nil
        }

        for attempt in 0 ..< maxAttempts {
            guard let preview = preview(
                parents: parents,
                generation: generation,
                salt: "\(saltPrefix)-\(attempt)"
            ), let trait = LineageMutationTrait(rawValue: preview.changedTraitID),
               matchingMutationTraits.contains(trait)
            else {
                continue
            }

            if let preferredVariationParentID,
               preview.variationParentID != preferredVariationParentID {
                continue
            }

            return preview
        }

        return nil
    }

    public static func preview(
        parents: [LineageParentGenome],
        generation: Int,
        salt: String = "WiPetLineageMutationV1"
    ) -> LineageGenomePreview? {
        guard !parents.isEmpty,
              let plan = LineageMutationPlanner.plan(
                  parentIDs: parents.map(\.id),
                  generation: generation,
                  salt: salt
              )
        else {
            return nil
        }

        let sortedParents = parents.sorted { $0.id.uuidString < $1.id.uuidString }
        let inheritedParent = selectedParent(
            from: sortedParents,
            seed: plan.seed,
            offset: 0
        )
        let variationParent = selectedParent(
            from: sortedParents,
            seed: plan.seed,
            offset: 1
        )
        var genome = inheritedParent.genome
        applyPlannedVariation(
            to: &genome,
            from: variationParent.genome,
            plan: plan
        )

        return LineageGenomePreview(
            plan: plan,
            genome: genome,
            inheritedParentID: inheritedParent.id,
            variationParentID: variationParent.id,
            changedTraitID: plan.mutationTraitID,
            affinityLine: "Mostly inherits from \(inheritedParent.id.uuidString), with \(plan.mutationLabel) in \(plan.mutationTraitID)."
        )
    }

    private static func selectedParent(
        from parents: [LineageParentGenome],
        seed: UInt64,
        offset: Int
    ) -> LineageParentGenome {
        let index = Int((seed + UInt64(offset)) % UInt64(parents.count))
        return parents[index]
    }

    private static func applyPlannedVariation(
        to genome: inout Genome,
        from variationGenome: Genome,
        plan: LineageMutationPlan
    ) {
        switch LineageMutationTrait(rawValue: plan.mutationTraitID) {
        case .face:
            genome.morph.face = variationGenome.morph.face
        case .body:
            genome.morph.body = variationGenome.morph.body
        case .wing:
            genome.morph.wing = variationGenome.morph.wing
        case .tail:
            genome.morph.tail = variationGenome.morph.tail
        case .glow:
            genome.pattern.glow = ScalarGene(genome.pattern.glow.value + plan.mutationAmount)
        case .motion:
            let nudge = plan.mutationAmount / 2
            genome.motion.float = ScalarGene(genome.motion.float.value + nudge)
            genome.motion.tailMotion = ScalarGene(genome.motion.tailMotion.value + nudge)
            genome.motion.wingMotion = ScalarGene(genome.motion.wingMotion.value + nudge)
        case nil:
            break
        }
    }
}

public enum LineageGenomePreviewComparisonPlanner {
    public static func comparison(
        parents: [LineageParentGenome],
        generation: Int,
        firstSalt: String = "WiPetLineagePreviewComparisonA",
        secondSalt: String = "WiPetLineagePreviewComparisonB"
    ) -> LineageGenomePreviewComparison? {
        guard let first = LineageGenomePreviewPlanner.preview(
            parents: parents,
            generation: generation,
            salt: firstSalt
        ), let second = LineageGenomePreviewPlanner.preview(
            parents: parents,
            generation: generation,
            salt: secondSalt
        ) else {
            return nil
        }

        let firstTraits = Set([first.changedTraitID])
        let secondTraits = Set([second.changedTraitID])
        let shared = firstTraits
            .intersection(secondTraits)
            .sorted()
        let distinct = firstTraits
            .symmetricDifference(secondTraits)
            .sorted()
        let parentIDs = parents
            .map(\.id)
            .sorted { $0.uuidString < $1.uuidString }

        return LineageGenomePreviewComparison(
            first: first,
            second: second,
            sharedParentIDs: parentIDs,
            sharedChangedTraitIDs: shared,
            distinctChangedTraitIDs: distinct,
            familyLine: "Both previews come from the same family, with \(distinct.isEmpty ? "the same gentle difference" : "different gentle differences")."
        )
    }
}
