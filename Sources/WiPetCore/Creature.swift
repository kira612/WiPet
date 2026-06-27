import Foundation

public struct Creature: Equatable, Identifiable, Sendable {
    public let id: UUID
    public var name: String
    public var species: Species
    public var genome: Genome
    public var growthStage: GrowthStage
    public var generation: Int
    public var parentIDs: [UUID]
    public var discoveredTraits: [DiscoveryEvent]

    public init(
        id: UUID = UUID(),
        name: String,
        species: Species,
        genome: Genome,
        growthStage: GrowthStage = .egg,
        generation: Int = 1,
        parentIDs: [UUID] = [],
        discoveredTraits: [DiscoveryEvent] = []
    ) {
        self.id = id
        self.name = name
        self.species = species
        self.genome = genome
        self.growthStage = growthStage
        self.generation = max(1, generation)
        self.parentIDs = Array(parentIDs.prefix(2))
        self.discoveredTraits = discoveredTraits
    }

    public mutating func recordDiscovery(
        title: String,
        kind: DiscoveryEvent.Kind,
        stage: GrowthStage,
        relatedAncestorID: UUID? = nil
    ) {
        discoveredTraits.append(
            DiscoveryEvent(
                title: title,
                kind: kind,
                stage: stage,
                relatedAncestorID: relatedAncestorID
            )
        )
    }

    public var latestGrowthChangeDiscovery: DiscoveryEvent? {
        discoveredTraits.last { $0.isGrowthChangeMoment }
    }

    public var preferredDailyObservationDiscovery: DiscoveryEvent? {
        latestGrowthChangeDiscovery ?? discoveredTraits.last
    }

    public var widgetSnapshotDiscovery: DiscoveryEvent? {
        discoveredTraits.last
    }

    public var nextGrowthStage: GrowthStage? {
        growthStage.nextStage
    }

    public var nextGrowthMomentPreview: GrowthMomentPreview? {
        guard let nextGrowthStage else {
            return nil
        }

        return GrowthMomentPreview(
            creatureName: name,
            currentStage: growthStage,
            nextStage: nextGrowthStage
        )
    }

    public var growthCeremonyPlan: GrowthCeremonyPlan? {
        guard let preview = nextGrowthMomentPreview else {
            return nil
        }

        return GrowthCeremonyPlan(preview: preview)
    }

    @discardableResult
    public mutating func advanceGrowthStage() -> GrowthMomentPreview? {
        guard let preview = nextGrowthMomentPreview else {
            return nil
        }

        growthStage = preview.nextStage
        recordDiscovery(
            title: preview.discoveryTitle,
            kind: .growth,
            stage: preview.nextStage
        )
        return preview
    }
}

public struct GrowthCeremonyPlan: Equatable, Sendable {
    public var creatureName: String
    public var currentStage: GrowthStage
    public var nextStage: GrowthStage
    public var previewTitle: String
    public var discoveryTitle: String
    public var traitReveal: GrowthCeremonyTraitReveal
    public var confirmationGate: GrowthCeremonyConfirmationGate
    public var beforeAfterObservation: GrowthCeremonyBeforeAfterObservation
    public var mutationProof: GrowthCeremonyMutationProof
    public var requirements: [GrowthCeremonyRequirement]

    public init(
        preview: GrowthMomentPreview,
        traitReveal: GrowthCeremonyTraitReveal? = nil,
        confirmationGate: GrowthCeremonyConfirmationGate? = nil,
        beforeAfterObservation: GrowthCeremonyBeforeAfterObservation? = nil,
        mutationProof: GrowthCeremonyMutationProof? = nil,
        requirements: [GrowthCeremonyRequirement] = GrowthCeremonyRequirement.playerFacingRequirements
    ) {
        self.creatureName = preview.creatureName
        self.currentStage = preview.currentStage
        self.nextStage = preview.nextStage
        self.previewTitle = preview.title
        self.discoveryTitle = preview.discoveryTitle
        let resolvedTraitReveal = traitReveal ?? GrowthCeremonyTraitReveal(
            currentStage: preview.currentStage,
            nextStage: preview.nextStage
        )
        self.traitReveal = resolvedTraitReveal
        self.confirmationGate = confirmationGate ?? GrowthCeremonyConfirmationGate(
            requirements: requirements,
            traitReveal: resolvedTraitReveal
        )
        self.beforeAfterObservation = beforeAfterObservation ?? GrowthCeremonyBeforeAfterObservation(
            creatureName: preview.creatureName,
            currentStage: preview.currentStage,
            nextStage: preview.nextStage,
            traitReveal: resolvedTraitReveal
        )
        self.mutationProof = mutationProof ?? GrowthCeremonyMutationProof(traitReveal: resolvedTraitReveal)
        self.requirements = requirements
    }

    public var readinessSummary: String {
        "growthCeremonyReady:\(hasPlayerFacingRequirements),requirements:\(requirements.map(\.rawValue).joined(separator: "+")),\(traitReveal.readinessSummary),\(traitReveal.summary),\(confirmationGate.readinessSummary),\(confirmationGate.summary),\(beforeAfterObservation.readinessSummary),\(beforeAfterObservation.summary),\(mutationProof.readinessSummary),\(mutationProof.summary)"
    }

    public var hasPlayerFacingRequirements: Bool {
        let requirementSet = Set(requirements)
        return GrowthCeremonyRequirement.playerFacingRequirements.allSatisfy(requirementSet.contains)
    }
}

public struct GrowthCeremonyBeforeAfterObservation: Equatable, Sendable {
    public var currentLine: String
    public var nextLine: String
    public var comparisonLine: String

    public init(
        currentLine: String,
        nextLine: String,
        comparisonLine: String
    ) {
        self.currentLine = currentLine
        self.nextLine = nextLine
        self.comparisonLine = comparisonLine
    }

    public init(
        creatureName: String,
        currentStage: GrowthStage,
        nextStage: GrowthStage,
        traitReveal: GrowthCeremonyTraitReveal
    ) {
        self.init(
            currentLine: "\(creatureName) now carries a \(traitReveal.currentCue).",
            nextLine: "\(nextStage.growthPreviewName) \(creatureName) may show a \(traitReveal.nextCue).",
            comparisonLine: "Watch the \(traitReveal.displayName.lowercased()) before deciding together."
        )
    }

    public var hasRequiredFields: Bool {
        !currentLine.isEmpty
            && !nextLine.isEmpty
            && !comparisonLine.isEmpty
    }

    public var readinessSummary: String {
        "growthBeforeAfterObservationReady:\(hasRequiredFields)"
    }

    public var summary: String {
        "growthBeforeAfterObservation=current:\(currentLine),next:\(nextLine)"
    }
}

public struct GrowthCeremonyLineageCueBridge: Equatable, Sendable {
    public var traitReveal: GrowthCeremonyTraitReveal
    public var lineageCopy: LineageVisibleCueObservationCopy
    public var ceremonyLine: String
    public var allowsMutation: Bool

    public init(
        traitReveal: GrowthCeremonyTraitReveal,
        lineageCopy: LineageVisibleCueObservationCopy,
        ceremonyLine: String? = nil,
        allowsMutation: Bool = false
    ) {
        self.traitReveal = traitReveal
        self.lineageCopy = lineageCopy
        self.ceremonyLine = ceremonyLine
            ?? "Notice the \(traitReveal.displayName.lowercased()) beside \(lineageCopy.memory.displayName.lowercased())."
        self.allowsMutation = allowsMutation
    }

    public var hasRequiredFields: Bool {
        traitReveal.hasRequiredFields
            && lineageCopy.hasRequiredFields
            && !ceremonyLine.isEmpty
    }

    public var summary: String {
        "growthLineageCueBridge=trait:\(traitReveal.traitID),cue:\(lineageCopy.memory.visibleCue),ancestor:\(lineageCopy.memory.ancestorLabel),allowsMutation:\(allowsMutation)"
    }

    public var readinessSummary: String {
        "growthLineageCueBridgeReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyInheritedVisualMemoryBridge: Equatable, Sendable {
    public var plan: GrowthCeremonyPlan
    public var visualPolicy: LineageChildDraftInheritedVisualCuePolicy
    public var memoryLine: String
    public var previewOnly: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool
    public var playerFacing: Bool

    public init(
        plan: GrowthCeremonyPlan,
        visualPolicy: LineageChildDraftInheritedVisualCuePolicy,
        memoryLine: String? = nil,
        previewOnly: Bool = true,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false,
        playerFacing: Bool = false
    ) {
        self.plan = plan
        self.visualPolicy = visualPolicy
        self.memoryLine = memoryLine ?? Self.defaultMemoryLine(
            creatureName: plan.creatureName,
            visualPolicy: visualPolicy
        )
        self.previewOnly = previewOnly
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        plan.hasPlayerFacingRequirements
            && visualPolicy.hasRequiredFields
            && !memoryLine.isEmpty
            && memoryLine.contains(plan.creatureName)
            && memoryLine.contains(visualPolicy.inheritedFromLabel)
            && previewOnly
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
            && !playerFacing
    }

    public var summary: String {
        "growthInheritedVisualMemoryBridge=source:\(visualPolicy.sourceLabel),creature:\(plan.creatureName),ancestor:\(visualPolicy.inheritedFromLabel),wing:\(visualPolicy.inheritedWing?.rawValue ?? "none"),tail:\(visualPolicy.inheritedTail?.rawValue ?? "none"),previewOnly:\(previewOnly),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "growthInheritedVisualMemoryBridgeReady:\(hasRequiredFields)"
    }

    private static func defaultMemoryLine(
        creatureName: String,
        visualPolicy: LineageChildDraftInheritedVisualCuePolicy
    ) -> String {
        "\(creatureName)'s growth preview can remember \(visualPolicy.inheritedFromLabel)'s \(visualCueLine(visualPolicy))."
    }

    private static func visualCueLine(_ visualPolicy: LineageChildDraftInheritedVisualCuePolicy) -> String {
        let cues = [
            visualPolicy.inheritedWing.map { "\($0.rawValue) wing" },
            visualPolicy.inheritedTail.map { "\($0.rawValue) tail" }
        ].compactMap { $0 }

        switch cues.count {
        case 0:
            return "quiet family shape"
        case 1:
            return cues[0]
        default:
            return "\(cues.dropLast().joined(separator: ", ")) and \(cues.last ?? "")"
        }
    }
}

public struct GrowthCeremonyInheritedVisualVisiblePromotionGate: Equatable, Sendable {
    public var bridge: GrowthCeremonyInheritedVisualMemoryBridge
    public var manualCopyReviewed: Bool
    public var appHostVisualQAReviewed: Bool
    public var snapshotReferenceReviewed: Bool
    public var ceremonyLayoutHasRoom: Bool
    public var preservesQuietTone: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool
    public var playerFacing: Bool

    public init(
        bridge: GrowthCeremonyInheritedVisualMemoryBridge,
        manualCopyReviewed: Bool = false,
        appHostVisualQAReviewed: Bool = false,
        snapshotReferenceReviewed: Bool = false,
        ceremonyLayoutHasRoom: Bool = false,
        preservesQuietTone: Bool = true,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false,
        playerFacing: Bool = false
    ) {
        self.bridge = bridge
        self.manualCopyReviewed = manualCopyReviewed
        self.appHostVisualQAReviewed = appHostVisualQAReviewed
        self.snapshotReferenceReviewed = snapshotReferenceReviewed
        self.ceremonyLayoutHasRoom = ceremonyLayoutHasRoom
        self.preservesQuietTone = preservesQuietTone
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
        self.playerFacing = playerFacing
    }

    public var canPromoteVisibleLine: Bool {
        bridge.hasRequiredFields
            && manualCopyReviewed
            && appHostVisualQAReviewed
            && snapshotReferenceReviewed
            && ceremonyLayoutHasRoom
            && preservesQuietTone
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        bridge.hasRequiredFields
            && preservesQuietTone
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
            && !playerFacing
    }

    public var summary: String {
        "growthInheritedVisualVisiblePromotionGate=bridgeReady:\(bridge.hasRequiredFields),copyReview:\(manualCopyReviewed),appHostVisualQA:\(appHostVisualQAReviewed),snapshotReview:\(snapshotReferenceReviewed),layoutRoom:\(ceremonyLayoutHasRoom),quietTone:\(preservesQuietTone),promote:\(canPromoteVisibleLine),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "growthInheritedVisualVisiblePromotionGateReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyInheritedVisualPromotionDeferralEvidence: Equatable, Sendable {
    public var gate: GrowthCeremonyInheritedVisualVisiblePromotionGate
    public var deferralReason: String
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool
    public var playerFacing: Bool

    public init(
        gate: GrowthCeremonyInheritedVisualVisiblePromotionGate,
        deferralReason: String = "appHostVisualQAPending",
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false,
        playerFacing: Bool = false
    ) {
        self.gate = gate
        self.deferralReason = deferralReason
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        gate.hasRequiredFields
            && gate.manualCopyReviewed
            && !gate.appHostVisualQAReviewed
            && !gate.snapshotReferenceReviewed
            && !gate.ceremonyLayoutHasRoom
            && !gate.canPromoteVisibleLine
            && deferralReason == "appHostVisualQAPending"
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
            && !playerFacing
    }

    public var summary: String {
        "growthInheritedVisualPromotionDeferral=gateReady:\(gate.hasRequiredFields),copyReview:\(gate.manualCopyReviewed),appHostVisualQA:\(gate.appHostVisualQAReviewed),snapshotReview:\(gate.snapshotReferenceReviewed),layoutRoom:\(gate.ceremonyLayoutHasRoom),reason:\(deferralReason),defers:\(hasRequiredFields),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "growthInheritedVisualPromotionDeferralReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyLineageTeaserCopy: Equatable, Sendable {
    public var bridge: GrowthCeremonyLineageCueBridge
    public var eyebrow: String
    public var title: String
    public var lineageLine: String

    public init(
        previewTitle: String,
        bridge: GrowthCeremonyLineageCueBridge,
        eyebrow: String = "A quiet change is near",
        lineageLine: String? = nil
    ) {
        self.bridge = bridge
        self.eyebrow = eyebrow
        self.title = previewTitle
        self.lineageLine = lineageLine ?? bridge.lineageCopy.observationLine
    }

    public var hasRequiredFields: Bool {
        bridge.hasRequiredFields
            && !eyebrow.isEmpty
            && !title.isEmpty
            && !lineageLine.isEmpty
            && !bridge.allowsMutation
    }

    public var accessibilityLabel: String {
        "\(eyebrow), \(title), \(lineageLine)"
    }

    public var summary: String {
        "growthLineageTeaser=trait:\(bridge.traitReveal.traitID),cue:\(bridge.lineageCopy.memory.visibleCue),ancestor:\(bridge.lineageCopy.memory.ancestorLabel),playerFacing:\(bridge.lineageCopy.playerFacing)"
    }

    public var readinessSummary: String {
        "growthLineageTeaserReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyLineageAffectionCopy: Equatable, Sendable {
    public var plan: GrowthCeremonyPlan
    public var profile: LineageMutationAffectionProfile
    public var title: String
    public var inheritedLine: String
    public var variationLine: String
    public var safetyLine: String
    public var affectionLine: String
    public var exposesSeedDetails: Bool
    public var exposesRawRandomness: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var playerFacing: Bool

    public init(
        plan: GrowthCeremonyPlan,
        profile: LineageMutationAffectionProfile,
        title: String = "Family echo",
        inheritedLine: String? = nil,
        variationLine: String? = nil,
        safetyLine: String? = nil,
        affectionLine: String? = nil,
        exposesSeedDetails: Bool = false,
        exposesRawRandomness: Bool = false,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        playerFacing: Bool = true
    ) {
        self.plan = plan
        self.profile = profile
        self.title = title
        self.inheritedLine = inheritedLine ?? profile.inheritedLine
        self.variationLine = variationLine ?? profile.variationLine
        self.safetyLine = safetyLine ?? profile.safetyLine
        self.affectionLine = affectionLine ?? Self.defaultAffectionLine(profile: profile)
        self.exposesSeedDetails = exposesSeedDetails
        self.exposesRawRandomness = exposesRawRandomness
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.playerFacing = playerFacing
    }

    public static func preview(
        plan: GrowthCeremonyPlan,
        parentIDs: [UUID],
        generation: Int,
        salt: String = "WiPetGrowthCeremonyAffectionCopy"
    ) -> Self? {
        guard let profile = LineageMutationPlanner.affectionProfile(
            parentIDs: parentIDs,
            generation: generation,
            salt: salt
        ) else {
            return nil
        }

        let copy = Self(plan: plan, profile: profile)
        return copy.hasRequiredFields ? copy : nil
    }

    public var hasRequiredFields: Bool {
        plan.hasPlayerFacingRequirements
            && profile.hasRequiredFields
            && profile.hidesSeedDetails
            && !profile.exposesRawRandomness
            && !title.isEmpty
            && !inheritedLine.isEmpty
            && !variationLine.isEmpty
            && !safetyLine.isEmpty
            && !affectionLine.isEmpty
            && !exposesSeedDetails
            && !exposesRawRandomness
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && playerFacing
    }

    public var summary: String {
        "growthLineageAffectionCopy=title:\(title),inherit:\(profile.plan.inheritedTraitID),variation:\(profile.plan.mutationTraitID),seedHidden:\(!exposesSeedDetails && profile.hidesSeedDetails),rawRandomness:\(exposesRawRandomness || profile.exposesRawRandomness),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "growthLineageAffectionCopyReady:\(hasRequiredFields)"
    }

    private static func defaultAffectionLine(profile: LineageMutationAffectionProfile) -> String {
        "A familiar \(softTraitName(profile.plan.inheritedTraitID)) echo stays close while a soft \(softTraitName(profile.plan.mutationTraitID)) difference waits."
    }

    private static func softTraitName(_ traitID: String) -> String {
        switch traitID {
        case "face":
            return "face"
        case "body":
            return "body"
        case "wing":
            return "wing"
        case "tail":
            return "tail"
        case "glow":
            return "glow"
        case "motion":
            return "movement"
        default:
            return traitID
        }
    }
}

public struct GrowthCeremonyDiscoveryLogHandoffPreview: Equatable, Sendable {
    public var discoveryTitle: String
    public var stage: GrowthStage
    public var kind: DiscoveryEvent.Kind
    public var memoryLine: String
    public var includesLineageEcho: Bool
    public var allowsWrite: Bool

    public init(
        plan: GrowthCeremonyPlan,
        lineageTeaserCopy: GrowthCeremonyLineageTeaserCopy? = nil,
        allowsWrite: Bool = false
    ) {
        self.init(
            discoveryTitle: plan.discoveryTitle,
            stage: plan.nextStage,
            kind: .growth,
            memoryLine: lineageTeaserCopy?.lineageLine ?? plan.traitReveal.ceremonyLine,
            includesLineageEcho: lineageTeaserCopy != nil,
            allowsWrite: allowsWrite
        )
    }

    public init(
        discoveryTitle: String,
        stage: GrowthStage,
        kind: DiscoveryEvent.Kind,
        memoryLine: String,
        includesLineageEcho: Bool = false,
        allowsWrite: Bool = false
    ) {
        self.discoveryTitle = discoveryTitle
        self.stage = stage
        self.kind = kind
        self.memoryLine = memoryLine
        self.includesLineageEcho = includesLineageEcho
        self.allowsWrite = allowsWrite
    }

    public var hasRequiredFields: Bool {
        !discoveryTitle.isEmpty
            && !memoryLine.isEmpty
            && !allowsWrite
    }

    public var summary: String {
        "growthDiscoveryLogHandoff=title:\(discoveryTitle),stage:\(stage.discoverySummaryName),kind:\(kind.rawValue),lineage:\(includesLineageEcho),allowsWrite:\(allowsWrite)"
    }

    public var readinessSummary: String {
        "growthDiscoveryLogHandoffReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyNoticedMemoryLineCopy: Equatable, Sendable {
    public var discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview
    public var isPlayerAcknowledged: Bool
    public var memoryLine: String
    public var previewOnly: Bool
    public var allowsWrite: Bool
    public var mutatesCreature: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool

    public init(
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview,
        isPlayerAcknowledged: Bool,
        memoryLine: String? = nil,
        previewOnly: Bool = true,
        allowsWrite: Bool = false,
        mutatesCreature: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false
    ) {
        self.discoveryHandoff = discoveryHandoff
        self.isPlayerAcknowledged = isPlayerAcknowledged
        self.memoryLine = memoryLine
            ?? "This noticed change will wait as a quiet memory."
        self.previewOnly = previewOnly
        self.allowsWrite = allowsWrite
        self.mutatesCreature = mutatesCreature
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
    }

    public var shouldDisplay: Bool {
        isPlayerAcknowledged && hasRequiredFields
    }

    public var hasRequiredFields: Bool {
        discoveryHandoff.hasRequiredFields
            && isPlayerAcknowledged
            && !memoryLine.isEmpty
            && previewOnly
            && !allowsWrite
            && !discoveryHandoff.allowsWrite
            && !mutatesCreature
            && !publishesWidgetHandoff
            && !appendsDiscovery
    }

    public var summary: String {
        "growthNoticedMemoryLine=acknowledged:\(isPlayerAcknowledged),display:\(shouldDisplay),previewOnly:\(previewOnly),write:\(allowsWrite || discoveryHandoff.allowsWrite),mutation:\(mutatesCreature),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery)"
    }

    public var readinessSummary: String {
        "growthNoticedMemoryLineReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyNoticedMemoryCatalogEntry: Equatable, Sendable {
    public var cueID: String
    public var traitID: String
    public var memoryLine: String
    public var previewOnly: Bool
    public var allowsWrite: Bool
    public var mutatesCreature: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool

    public init(
        cueID: String,
        traitID: String,
        memoryLine: String,
        previewOnly: Bool = true,
        allowsWrite: Bool = false,
        mutatesCreature: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false
    ) {
        self.cueID = cueID
        self.traitID = traitID
        self.memoryLine = memoryLine
        self.previewOnly = previewOnly
        self.allowsWrite = allowsWrite
        self.mutatesCreature = mutatesCreature
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
    }

    public var hasRequiredFields: Bool {
        !cueID.isEmpty
            && !traitID.isEmpty
            && !memoryLine.isEmpty
            && previewOnly
            && !allowsWrite
            && !mutatesCreature
            && !publishesWidgetHandoff
            && !appendsDiscovery
    }

    public var summary: String {
        "growthNoticedMemoryCatalog=cue:\(cueID),trait:\(traitID),previewOnly:\(previewOnly),write:\(allowsWrite),mutation:\(mutatesCreature),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery)"
    }

    public var readinessSummary: String {
        "growthNoticedMemoryCatalogReady:\(hasRequiredFields)"
    }
}

public enum GrowthCeremonyNoticedMemoryCatalog {
    public static func entry(for cueID: String) -> GrowthCeremonyNoticedMemoryCatalogEntry? {
        switch cueID {
        case "tinyRoundedBud":
            return GrowthCeremonyNoticedMemoryCatalogEntry(
                cueID: cueID,
                traitID: "hornGrowth",
                memoryLine: "The tiny rounded bud can wait here as a quiet growth memory."
            )
        case "softCrescentBud":
            return GrowthCeremonyNoticedMemoryCatalogEntry(
                cueID: cueID,
                traitID: "hornGrowth",
                memoryLine: "The soft crescent buds can wait here as a quiet growth memory."
            )
        case "brightTailTipGlint":
            return GrowthCeremonyNoticedMemoryCatalogEntry(
                cueID: cueID,
                traitID: "tailGrowth",
                memoryLine: "Brighter tail-tip glow will wait here as a quiet memory."
            )
        case "softTailTipGlint":
            return GrowthCeremonyNoticedMemoryCatalogEntry(
                cueID: cueID,
                traitID: "tailGrowth",
                memoryLine: "Soft tail-tip glow will wait here as a quiet memory."
            )
        case "crescentBelly":
            return GrowthCeremonyNoticedMemoryCatalogEntry(
                cueID: cueID,
                traitID: "bodyAccent",
                memoryLine: "The soft moon-belly mark can wait here as a quiet memory."
            )
        default:
            return nil
        }
    }
}

public struct GrowthCeremonyPlayerAcknowledgementGatePreview: Equatable, Sendable {
    public var acknowledgementLine: String
    public var isPlayerAcknowledged: Bool
    public var discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview
    public var mutationProof: GrowthCeremonyMutationProof

    public init(
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview,
        mutationProof: GrowthCeremonyMutationProof,
        acknowledgementLine: String? = nil,
        isPlayerAcknowledged: Bool = false
    ) {
        self.discoveryHandoff = discoveryHandoff
        self.mutationProof = mutationProof
        self.acknowledgementLine = acknowledgementLine
            ?? "Notice the change together before it becomes a memory."
        self.isPlayerAcknowledged = isPlayerAcknowledged
    }

    public var allowsCommit: Bool {
        isPlayerAcknowledged
            && discoveryHandoff.allowsWrite
            && mutationProof.isSatisfied
    }

    public var hasRequiredFields: Bool {
        !acknowledgementLine.isEmpty
            && discoveryHandoff.hasRequiredFields
            && mutationProof.hasRequiredFields
            && !allowsCommit
    }

    public var summary: String {
        "growthAcknowledgementGate=acknowledged:\(isPlayerAcknowledged),handoffReady:\(discoveryHandoff.hasRequiredFields),proofSatisfied:\(mutationProof.isSatisfied),allowsCommit:\(allowsCommit)"
    }

    public var readinessSummary: String {
        "growthAcknowledgementGateReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyAcknowledgementSurfaceCopy: Equatable, Sendable {
    public var gate: GrowthCeremonyPlayerAcknowledgementGatePreview
    public var promptLine: String
    public var commitStateLine: String

    public init(
        gate: GrowthCeremonyPlayerAcknowledgementGatePreview,
        promptLine: String? = nil,
        commitStateLine: String? = nil
    ) {
        self.gate = gate
        self.promptLine = promptLine ?? gate.acknowledgementLine
        self.commitStateLine = commitStateLine ?? "This memory will wait until the moment is noticed."
    }

    public var hasRequiredFields: Bool {
        gate.hasRequiredFields
            && !promptLine.isEmpty
            && !commitStateLine.isEmpty
            && !gate.allowsCommit
    }

    public var summary: String {
        "growthAcknowledgementSurface=acknowledged:\(gate.isPlayerAcknowledged),allowsCommit:\(gate.allowsCommit),promptReady:\(!promptLine.isEmpty)"
    }

    public var readinessSummary: String {
        "growthAcknowledgementSurfaceReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyConfirmationSurfaceCopy: Equatable, Sendable {
    public var observation: GrowthCeremonyBeforeAfterObservation
    public var acknowledgementSurface: GrowthCeremonyAcknowledgementSurfaceCopy
    public var discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview
    public var title: String
    public var confirmationLine: String
    public var safetyLine: String

    public init(
        observation: GrowthCeremonyBeforeAfterObservation,
        acknowledgementSurface: GrowthCeremonyAcknowledgementSurfaceCopy,
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview,
        title: String = "Ceremony preview",
        confirmationLine: String? = nil,
        safetyLine: String? = nil
    ) {
        self.observation = observation
        self.acknowledgementSurface = acknowledgementSurface
        self.discoveryHandoff = discoveryHandoff
        self.title = title
        self.confirmationLine = confirmationLine ?? observation.comparisonLine
        self.safetyLine = safetyLine ?? acknowledgementSurface.commitStateLine
    }

    public var hasRequiredFields: Bool {
        observation.hasRequiredFields
            && acknowledgementSurface.hasRequiredFields
            && discoveryHandoff.hasRequiredFields
            && !title.isEmpty
            && !confirmationLine.isEmpty
            && !safetyLine.isEmpty
            && !acknowledgementSurface.gate.allowsCommit
            && !discoveryHandoff.allowsWrite
    }

    public var summary: String {
        "growthConfirmationSurface=title:\(title),observationReady:\(observation.hasRequiredFields),acknowledgementReady:\(acknowledgementSurface.hasRequiredFields),handoffWrite:\(discoveryHandoff.allowsWrite),allowsCommit:\(acknowledgementSurface.gate.allowsCommit)"
    }

    public var readinessSummary: String {
        "growthConfirmationSurfaceReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyContinuityLineCopy: Equatable, Sendable {
    public var plan: GrowthCeremonyPlan
    public var continuityLine: String
    public var previewOnly: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool
    public var playerFacing: Bool

    public init(
        plan: GrowthCeremonyPlan,
        continuityLine: String? = nil,
        previewOnly: Bool = true,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false,
        playerFacing: Bool = true
    ) {
        self.plan = plan
        let nextStageName = Self.displayName(for: plan.nextStage)
        self.continuityLine = continuityLine
            ?? "\(nextStageName) \(plan.creatureName) can still feel like the same \(plan.creatureName)."
        self.previewOnly = previewOnly
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        !plan.creatureName.isEmpty
            && !continuityLine.isEmpty
            && continuityLine.contains(plan.creatureName)
            && continuityLine.contains(Self.displayName(for: plan.nextStage))
            && previewOnly
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
            && playerFacing
    }

    public var summary: String {
        "growthContinuityLine=stage:\(plan.nextStage.discoverySummaryName),creature:\(plan.creatureName),lineReady:\(!continuityLine.isEmpty),previewOnly:\(previewOnly),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "growthContinuityLineReady:\(hasRequiredFields)"
    }

    private static func displayName(for stage: GrowthStage) -> String {
        let summaryName = stage.discoverySummaryName
        return summaryName.prefix(1).uppercased() + summaryName.dropFirst()
    }
}

public struct GrowthCeremonyAcknowledgementIntentContract: Equatable, Sendable {
    public var confirmationSurface: GrowthCeremonyConfirmationSurfaceCopy
    public var intentLabel: String
    public var disabledReason: String
    public var previewOnly: Bool
    public var enabledInNormalUI: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool

    public init(
        confirmationSurface: GrowthCeremonyConfirmationSurfaceCopy,
        intentLabel: String = "I noticed this change",
        disabledReason: String = "Growth will wait until memory and Widget handoff are prepared.",
        previewOnly: Bool = true,
        enabledInNormalUI: Bool = false,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false
    ) {
        self.confirmationSurface = confirmationSurface
        self.intentLabel = intentLabel
        self.disabledReason = disabledReason
        self.previewOnly = previewOnly
        self.enabledInNormalUI = enabledInNormalUI
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
    }

    public var hasRequiredFields: Bool {
        confirmationSurface.hasRequiredFields
            && !intentLabel.isEmpty
            && !disabledReason.isEmpty
            && previewOnly
            && !enabledInNormalUI
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
    }

    public var summary: String {
        "growthAcknowledgementIntent=intent:\(intentLabel),previewOnly:\(previewOnly),normalUI:\(enabledInNormalUI),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff)"
    }

    public var readinessSummary: String {
        "growthAcknowledgementIntentReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyObservationAcknowledgementInteraction: Equatable, Sendable {
    public var observation: GrowthCeremonyBeforeAfterObservation
    public var hasNotedObservation: Bool
    public var noteLine: String
    public var waitingLine: String
    public var previewOnly: Bool
    public var enabledInNormalUI: Bool
    public var allowsMutation: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var appendsDiscovery: Bool

    public init(
        observation: GrowthCeremonyBeforeAfterObservation,
        hasNotedObservation: Bool = false,
        noteLine: String = "I noticed this change",
        waitingLine: String = "This only marks the preview as noticed.",
        previewOnly: Bool = true,
        enabledInNormalUI: Bool = false,
        allowsMutation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        appendsDiscovery: Bool = false
    ) {
        self.observation = observation
        self.hasNotedObservation = hasNotedObservation
        self.noteLine = noteLine
        self.waitingLine = waitingLine
        self.previewOnly = previewOnly
        self.enabledInNormalUI = enabledInNormalUI
        self.allowsMutation = allowsMutation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.appendsDiscovery = appendsDiscovery
    }

    public var hasRequiredFields: Bool {
        observation.hasRequiredFields
            && !noteLine.isEmpty
            && !waitingLine.isEmpty
            && previewOnly
            && !enabledInNormalUI
            && !allowsMutation
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !appendsDiscovery
    }

    public var summary: String {
        "growthObservationAcknowledgement=noted:\(hasNotedObservation),previewOnly:\(previewOnly),normalUI:\(enabledInNormalUI),mutation:\(allowsMutation),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),discovery:\(appendsDiscovery)"
    }

    public var readinessSummary: String {
        "growthObservationAcknowledgementReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyPersistenceBoundaryContract: Equatable, Sendable {
    public var acknowledgementIntent: GrowthCeremonyAcknowledgementIntentContract
    public var targetsSwiftData: Bool
    public var targetsAppGroup: Bool
    public var dryRunOnly: Bool
    public var performsPersistenceWrite: Bool
    public var mutatesCreature: Bool
    public var appendsDiscovery: Bool
    public var publishesWidgetHandoff: Bool

    public init(
        acknowledgementIntent: GrowthCeremonyAcknowledgementIntentContract,
        targetsSwiftData: Bool = true,
        targetsAppGroup: Bool = true,
        dryRunOnly: Bool = true,
        performsPersistenceWrite: Bool = false,
        mutatesCreature: Bool = false,
        appendsDiscovery: Bool = false,
        publishesWidgetHandoff: Bool = false
    ) {
        self.acknowledgementIntent = acknowledgementIntent
        self.targetsSwiftData = targetsSwiftData
        self.targetsAppGroup = targetsAppGroup
        self.dryRunOnly = dryRunOnly
        self.performsPersistenceWrite = performsPersistenceWrite
        self.mutatesCreature = mutatesCreature
        self.appendsDiscovery = appendsDiscovery
        self.publishesWidgetHandoff = publishesWidgetHandoff
    }

    public var isSafeDryRun: Bool {
        dryRunOnly
            && !performsPersistenceWrite
            && !mutatesCreature
            && !appendsDiscovery
            && !publishesWidgetHandoff
    }

    public var hasRequiredFields: Bool {
        acknowledgementIntent.hasRequiredFields
            && targetsSwiftData
            && targetsAppGroup
            && isSafeDryRun
    }

    public var summary: String {
        "growthPersistenceBoundary=swiftData:\(targetsSwiftData),appGroup:\(targetsAppGroup),dryRun:\(dryRunOnly),write:\(performsPersistenceWrite),mutatesCreature:\(mutatesCreature),discovery:\(appendsDiscovery),widget:\(publishesWidgetHandoff),safe:\(isSafeDryRun)"
    }

    public var readinessSummary: String {
        "growthPersistenceBoundaryReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyWidgetHandoffPreflightContract: Equatable, Sendable {
    public var plan: GrowthCeremonyPlan
    public var persistenceBoundary: GrowthCeremonyPersistenceBoundaryContract
    public var payloadSchemaVersion: Int
    public var appGroupPayloadKey: String
    public var widgetKind: String
    public var payloadPrepared: Bool
    public var previewOnly: Bool
    public var performsAppGroupWrite: Bool
    public var reloadsWidgetTimeline: Bool
    public var publishesWidgetHandoff: Bool

    public init(
        plan: GrowthCeremonyPlan,
        persistenceBoundary: GrowthCeremonyPersistenceBoundaryContract,
        payloadSchemaVersion: Int = WidgetPetObservationTransferPayload.currentSchemaVersion,
        appGroupPayloadKey: String = WidgetSharedDataKeys.currentObservationJSON,
        widgetKind: String = WidgetSharedDataKeys.widgetKind,
        payloadPrepared: Bool = true,
        previewOnly: Bool = true,
        performsAppGroupWrite: Bool = false,
        reloadsWidgetTimeline: Bool = false,
        publishesWidgetHandoff: Bool = false
    ) {
        self.plan = plan
        self.persistenceBoundary = persistenceBoundary
        self.payloadSchemaVersion = payloadSchemaVersion
        self.appGroupPayloadKey = appGroupPayloadKey
        self.widgetKind = widgetKind
        self.payloadPrepared = payloadPrepared
        self.previewOnly = previewOnly
        self.performsAppGroupWrite = performsAppGroupWrite
        self.reloadsWidgetTimeline = reloadsWidgetTimeline
        self.publishesWidgetHandoff = publishesWidgetHandoff
    }

    public var hasRequiredFields: Bool {
        plan.hasPlayerFacingRequirements
            && plan.requirements.contains(.widgetHandoff)
            && persistenceBoundary.hasRequiredFields
            && payloadSchemaVersion == WidgetPetObservationTransferPayload.currentSchemaVersion
            && appGroupPayloadKey == WidgetSharedDataKeys.currentObservationJSON
            && widgetKind == WidgetSharedDataKeys.widgetKind
            && payloadPrepared
            && previewOnly
            && !performsAppGroupWrite
            && !reloadsWidgetTimeline
            && !publishesWidgetHandoff
    }

    public var summary: String {
        "growthWidgetHandoffPreflight=schema:\(payloadSchemaVersion),key:\(appGroupPayloadKey),widgetKind:\(widgetKind),payloadPrepared:\(payloadPrepared),previewOnly:\(previewOnly),write:\(performsAppGroupWrite),reload:\(reloadsWidgetTimeline),publish:\(publishesWidgetHandoff),persistenceBoundary:\(persistenceBoundary.hasRequiredFields),ready:\(hasRequiredFields)"
    }

    public var readinessSummary: String {
        "growthWidgetHandoffPreflightReady:\(hasRequiredFields)"
    }
}

public struct GrowthCeremonyConfirmationGate: Equatable, Sendable {
    public var requiredSteps: [GrowthCeremonyRequirement]
    public var traitID: String
    public var allowsMutation: Bool

    public init(
        requirements: [GrowthCeremonyRequirement],
        traitReveal: GrowthCeremonyTraitReveal,
        allowsMutation: Bool = false
    ) {
        self.requiredSteps = requirements
        self.traitID = traitReveal.traitID
        self.allowsMutation = allowsMutation
    }

    public var hasRequiredFields: Bool {
        let requirementSet = Set(requiredSteps)
        return GrowthCeremonyRequirement.playerFacingRequirements.allSatisfy(requirementSet.contains)
            && !traitID.isEmpty
    }

    public var requiredStepsSummary: String {
        requiredSteps.map(\.rawValue).joined(separator: "+")
    }

    public var readinessSummary: String {
        "growthConfirmationGateReady:\(hasRequiredFields)"
    }

    public var summary: String {
        "growthConfirmationGate=ready:\(hasRequiredFields),allowsMutation:\(allowsMutation),required:\(requiredStepsSummary),trait:\(traitID)"
    }
}

public struct GrowthCeremonyMutationProof: Equatable, Sendable {
    public var requiredEvidence: [GrowthCeremonyMutationProofEvidence]
    public var satisfiedEvidence: [GrowthCeremonyMutationProofEvidence]
    public var traitID: String

    public init(
        requiredEvidence: [GrowthCeremonyMutationProofEvidence] = GrowthCeremonyMutationProofEvidence.requiredEvidence,
        satisfiedEvidence: [GrowthCeremonyMutationProofEvidence] = [],
        traitID: String
    ) {
        self.requiredEvidence = requiredEvidence
        self.satisfiedEvidence = satisfiedEvidence
        self.traitID = traitID
    }

    public init(
        traitReveal: GrowthCeremonyTraitReveal,
        satisfiedEvidence: [GrowthCeremonyMutationProofEvidence] = []
    ) {
        self.init(
            satisfiedEvidence: satisfiedEvidence,
            traitID: traitReveal.traitID
        )
    }

    public var hasRequiredFields: Bool {
        let requiredEvidenceSet = Set(requiredEvidence)
        return GrowthCeremonyMutationProofEvidence.requiredEvidence.allSatisfy(requiredEvidenceSet.contains)
            && !traitID.isEmpty
    }

    public var isSatisfied: Bool {
        let satisfiedEvidenceSet = Set(satisfiedEvidence)
        return hasRequiredFields
            && requiredEvidence.allSatisfy(satisfiedEvidenceSet.contains)
    }

    public var requiredEvidenceSummary: String {
        requiredEvidence.map(\.rawValue).joined(separator: "+")
    }

    public var satisfiedEvidenceSummary: String {
        guard !satisfiedEvidence.isEmpty else {
            return "none"
        }

        return satisfiedEvidence.map(\.rawValue).joined(separator: "+")
    }

    public var readinessSummary: String {
        "growthMutationProofReady:\(hasRequiredFields)"
    }

    public var summary: String {
        "growthMutationProof=ready:\(hasRequiredFields),satisfied:\(isSatisfied),required:\(requiredEvidenceSummary),satisfiedEvidence:\(satisfiedEvidenceSummary),trait:\(traitID)"
    }
}

public struct GrowthCeremonyTraitReveal: Equatable, Sendable {
    public var traitID: String
    public var displayName: String
    public var currentCue: String
    public var nextCue: String
    public var ceremonyLine: String

    public init(
        traitID: String,
        displayName: String,
        currentCue: String,
        nextCue: String,
        ceremonyLine: String
    ) {
        self.traitID = traitID
        self.displayName = displayName
        self.currentCue = currentCue
        self.nextCue = nextCue
        self.ceremonyLine = ceremonyLine
    }

    public init(
        currentStage: GrowthStage,
        nextStage: GrowthStage
    ) {
        switch (currentStage, nextStage) {
        case (.egg, .baby):
            self.init(
                traitID: "bodyWarmth",
                displayName: "Body warmth",
                currentCue: "quiet shell",
                nextCue: "soft body warmth",
                ceremonyLine: "A soft warmth is gathering under the shell."
            )
        case (.baby, .juvenile):
            self.init(
                traitID: "eyeExpression",
                displayName: "Eye expression",
                currentCue: "sleepy gaze",
                nextCue: "curious gaze",
                ceremonyLine: "The gaze is beginning to meet the world."
            )
        case (.juvenile, .adult):
            self.init(
                traitID: "tailGlow",
                displayName: "Tail glow",
                currentCue: "small lunar shimmer",
                nextCue: "deeper tail glow",
                ceremonyLine: "The tail glow is deepening into an adult shimmer."
            )
        case (.adult, .elder):
            self.init(
                traitID: "ancestralGlow",
                displayName: "Ancestral glow",
                currentCue: "bright adult glow",
                nextCue: "gentle ancestral glow",
                ceremonyLine: "The glow is softening into an ancestral light."
            )
        default:
            self.init(
                traitID: "quietChange",
                displayName: "Quiet change",
                currentCue: currentStage.growthPreviewName,
                nextCue: nextStage.growthPreviewName,
                ceremonyLine: "A quiet change is ready to be noticed."
            )
        }
    }

    public var summary: String {
        "growthTraitReveal=trait:\(traitID),from:\(currentCue),to:\(nextCue)"
    }

    public var readinessSummary: String {
        "growthTraitRevealReady:\(hasRequiredFields)"
    }

    public var hasRequiredFields: Bool {
        !traitID.isEmpty
            && !displayName.isEmpty
            && !currentCue.isEmpty
            && !nextCue.isEmpty
            && !ceremonyLine.isEmpty
    }
}

public enum GrowthCeremonyRequirement: String, CaseIterable, Sendable {
    case playerAcknowledgement
    case beforeAfterObservation
    case discoveryLogHandoff
    case widgetHandoff
    case persistenceBeforeMutation

    public static var playerFacingRequirements: [GrowthCeremonyRequirement] {
        [
            .playerAcknowledgement,
            .beforeAfterObservation,
            .discoveryLogHandoff,
            .widgetHandoff,
            .persistenceBeforeMutation
        ]
    }
}

public enum GrowthCeremonyMutationProofEvidence: String, CaseIterable, Sendable {
    case playerAcknowledgementRecorded
    case beforeAfterObservationReviewed
    case discoveryLogPrepared
    case widgetHandoffPrepared
    case persistenceWritePrepared

    public static var requiredEvidence: [GrowthCeremonyMutationProofEvidence] {
        [
            .playerAcknowledgementRecorded,
            .beforeAfterObservationReviewed,
            .discoveryLogPrepared,
            .widgetHandoffPrepared,
            .persistenceWritePrepared
        ]
    }
}

public struct GrowthMomentPreview: Equatable, Sendable {
    public var creatureName: String
    public var currentStage: GrowthStage
    public var nextStage: GrowthStage
    public var title: String
    public var discoveryTitle: String

    public init(
        creatureName: String,
        currentStage: GrowthStage,
        nextStage: GrowthStage
    ) {
        self.creatureName = creatureName
        self.currentStage = currentStage
        self.nextStage = nextStage
        self.title = "\(creatureName) is ready to grow into \(nextStage.growthPreviewName)."
        self.discoveryTitle = "\(creatureName) grew into \(nextStage.growthPreviewName)."
    }
}

public enum Species: String, CaseIterable, Codable, Equatable, Sendable {
    case aquarian
    case sylphian
    case crystalian
    case lunarian
    case verdant
}

public enum GrowthStage: Int, CaseIterable, Codable, Comparable, Sendable {
    case egg
    case baby
    case juvenile
    case adult
    case elder

    public static func < (lhs: GrowthStage, rhs: GrowthStage) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var nextStage: GrowthStage? {
        switch self {
        case .egg:
            .baby
        case .baby:
            .juvenile
        case .juvenile:
            .adult
        case .adult:
            .elder
        case .elder:
            nil
        }
    }
}

public struct DiscoveryEvent: Equatable, Identifiable, Sendable {
    public enum Kind: String, CaseIterable, Codable, Equatable, Sendable {
        case growth
        case newPart
        case glow
        case pattern
        case inheritedResemblance
    }

    public let id: UUID
    public var title: String
    public var kind: Kind
    public var stage: GrowthStage
    public var relatedAncestorID: UUID?

    public init(
        id: UUID = UUID(),
        title: String,
        kind: Kind = .growth,
        stage: GrowthStage,
        relatedAncestorID: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.kind = kind
        self.stage = stage
        self.relatedAncestorID = relatedAncestorID
    }

    public var memoryCueLabel: String {
        "\(stage.discoveryMemoryName) \(kind.discoveryMemoryName)"
    }

    public var dailyChangeCueLabel: String {
        "\(stage.discoveryMemoryName) \(kind.dailyChangeCueName)"
    }

    public var isGrowthChangeMoment: Bool {
        kind.isGrowthChangeMoment
    }

    public var lineageCueLabel: String? {
        guard kind == .inheritedResemblance, relatedAncestorID != nil else {
            return nil
        }
        return "Echoes an ancestor"
    }
}

public struct LineageVisibleCueMemory: Equatable, Sendable {
    public var traitID: String
    public var displayName: String
    public var visibleCue: String
    public var ancestorLabel: String
    public var memoryLine: String

    public init(
        traitID: String,
        displayName: String,
        visibleCue: String,
        ancestorLabel: String,
        memoryLine: String
    ) {
        self.traitID = traitID
        self.displayName = displayName
        self.visibleCue = visibleCue
        self.ancestorLabel = ancestorLabel
        self.memoryLine = memoryLine
    }

    public init?(
        discovery: DiscoveryEvent?,
        traitID: String,
        displayName: String,
        visibleCue: String,
        ancestorLabel: String = "ancestor"
    ) {
        guard let discovery,
              discovery.kind == .inheritedResemblance,
              discovery.relatedAncestorID != nil
        else {
            return nil
        }

        self.init(
            traitID: traitID,
            displayName: displayName,
            visibleCue: visibleCue,
            ancestorLabel: ancestorLabel,
            memoryLine: "\(displayName) echoes \(ancestorLabel)."
        )
    }

    public var hasRequiredFields: Bool {
        !traitID.isEmpty
            && !displayName.isEmpty
            && !visibleCue.isEmpty
            && !ancestorLabel.isEmpty
            && !memoryLine.isEmpty
    }

    public var summary: String {
        "lineageVisibleCue=trait:\(traitID),cue:\(visibleCue),ancestor:\(ancestorLabel)"
    }

    public var readinessSummary: String {
        "lineageVisibleCueReady:\(hasRequiredFields)"
    }
}

public struct LineageVisibleCueObservationCopy: Equatable, Sendable {
    public var memory: LineageVisibleCueMemory
    public var ancestorContext: String
    public var observationLine: String
    public var playerFacing: Bool

    public init(
        memory: LineageVisibleCueMemory,
        ancestorContext: String = "ancestorEcho",
        observationLine: String? = nil,
        playerFacing: Bool = false
    ) {
        self.memory = memory
        self.ancestorContext = ancestorContext
        self.observationLine = observationLine
            ?? "\(memory.displayName) carries a quiet echo of \(Self.displayName(for: memory.ancestorLabel).lowercased())."
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        memory.hasRequiredFields
            && !ancestorContext.isEmpty
            && !observationLine.isEmpty
    }

    public var summary: String {
        "lineageVisibleCueObservation=trait:\(memory.traitID),cue:\(memory.visibleCue),ancestor:\(memory.ancestorLabel),context:\(ancestorContext),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageVisibleCueObservationReady:\(hasRequiredFields)"
    }

    private static func displayName(for ancestorLabel: String) -> String {
        LineageFamilyNodeCopy.displayName(for: ancestorLabel)
    }
}

public struct LineageFamilyNodeCopy: Equatable, Sendable {
    public var internalLabel: String
    public var displayName: String
    public var roleLine: String
    public var playerFacing: Bool

    public init(
        internalLabel: String,
        displayName: String? = nil,
        roleLine: String? = nil,
        playerFacing: Bool = false
    ) {
        let resolvedDisplayName = displayName ?? Self.displayName(for: internalLabel)
        self.internalLabel = internalLabel
        self.displayName = resolvedDisplayName
        self.roleLine = roleLine ?? "\(resolvedDisplayName) is remembered through a soft family echo."
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        !internalLabel.isEmpty
            && !displayName.isEmpty
            && !roleLine.isEmpty
            && UUID(uuidString: displayName) == nil
            && !playerFacing
    }

    public func memoryLine(for memory: LineageVisibleCueMemory) -> String {
        "\(memory.displayName) echoes \(displayName.lowercased())."
    }

    public var summary: String {
        "lineageFamilyNodeCopy=internal:\(internalLabel),display:\(displayName),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyNodeCopyReady:\(hasRequiredFields)"
    }

    public static func displayName(for internalLabel: String) -> String {
        switch internalLabel {
        case "firstAncestor":
            return "First ancestor"
        case "childDraft":
            return "Draft memory"
        default:
            return internalLabel
        }
    }
}

public struct LineageAncestorNamingPolicy: Equatable, Sendable {
    public var nodeCopy: LineageFamilyNodeCopy
    public var source: String
    public var allowsAutoProperName: Bool
    public var allowsPlayerRename: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        nodeCopy: LineageFamilyNodeCopy,
        source: String = "lineageMemory",
        allowsAutoProperName: Bool = false,
        allowsPlayerRename: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.nodeCopy = nodeCopy
        self.source = source
        self.allowsAutoProperName = allowsAutoProperName
        self.allowsPlayerRename = allowsPlayerRename
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var namingState: String {
        nodeCopy.displayName == LineageFamilyNodeCopy.displayName(for: nodeCopy.internalLabel)
            ? "genericDisplayLabel"
            : "properName"
    }

    public var hasRequiredFields: Bool {
        nodeCopy.hasRequiredFields
            && !source.isEmpty
            && !allowsAutoProperName
            && !allowsPlayerRename
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        "lineageAncestorNamingPolicy=internal:\(nodeCopy.internalLabel),display:\(nodeCopy.displayName),state:\(namingState),source:\(source),autoProperName:\(allowsAutoProperName),playerRename:\(allowsPlayerRename),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageAncestorNamingPolicyReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyPreview: Equatable, Sendable {
    public var ancestorLabel: String
    public var ancestorDisplayName: String
    public var memberNames: [String]
    public var memories: [LineageVisibleCueMemory]
    public var familyLine: String
    public var playerFacing: Bool

    public init(
        ancestorLabel: String,
        ancestorDisplayName: String? = nil,
        memberNames: [String],
        memories: [LineageVisibleCueMemory],
        familyLine: String? = nil,
        playerFacing: Bool = false
    ) {
        let resolvedAncestorDisplayName = ancestorDisplayName ?? LineageFamilyNodeCopy.displayName(for: ancestorLabel)
        self.ancestorLabel = ancestorLabel
        self.ancestorDisplayName = resolvedAncestorDisplayName
        self.memberNames = memberNames
        self.memories = memories
        self.familyLine = familyLine
            ?? "\(Self.join(memberNames)) carry a quiet echo of \(resolvedAncestorDisplayName.lowercased())."
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        !ancestorLabel.isEmpty
            && !ancestorDisplayName.isEmpty
            && memberNames.count >= 2
            && memberNames.allSatisfy { !$0.isEmpty }
            && !memories.isEmpty
            && memories.allSatisfy(\.hasRequiredFields)
            && !familyLine.isEmpty
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyPreview=ancestor:\(ancestorLabel),ancestorDisplay:\(ancestorDisplayName),members:\(Self.format(memberNames)),memories:\(memories.count),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyPreviewReady:\(hasRequiredFields)"
    }

    private static func join(_ values: [String]) -> String {
        switch values.count {
        case 0:
            return "No one"
        case 1:
            return values[0]
        case 2:
            return "\(values[0]) and \(values[1])"
        default:
            let head = values.dropLast().joined(separator: ", ")
            return "\(head), and \(values[values.count - 1])"
        }
    }

    private static func format(_ values: [String]) -> String {
        values.isEmpty ? "none" : values.joined(separator: "+")
    }
}

public struct LineageAncestorEchoSurfaceCopy: Equatable, Sendable {
    public var nodeCopy: LineageFamilyNodeCopy
    public var familyPreview: LineageFamilyPreview
    public var title: String
    public var cueLine: String
    public var statusLine: String
    public var allowsObservation: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        nodeCopy: LineageFamilyNodeCopy,
        familyPreview: LineageFamilyPreview,
        title: String? = nil,
        cueLine: String? = nil,
        statusLine: String? = nil,
        allowsObservation: Bool = true,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.nodeCopy = nodeCopy
        self.familyPreview = familyPreview
        self.title = title ?? "\(nodeCopy.displayName)'s echo"
        self.cueLine = cueLine ?? familyPreview.familyLine
        self.statusLine = statusLine ?? "\(familyPreview.memories.count) quiet memories are gathered here."
        self.allowsObservation = allowsObservation
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        nodeCopy.hasRequiredFields
            && familyPreview.hasRequiredFields
            && nodeCopy.internalLabel == familyPreview.ancestorLabel
            && nodeCopy.displayName == familyPreview.ancestorDisplayName
            && !title.isEmpty
            && !cueLine.isEmpty
            && !statusLine.isEmpty
            && allowsObservation
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        "lineageAncestorEchoSurface=ancestor:\(familyPreview.ancestorLabel),display:\(nodeCopy.displayName),memories:\(familyPreview.memories.count),observation:\(allowsObservation),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageAncestorEchoSurfaceReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilySurfacePlacement: Equatable, Sendable {
    public var surfaceName: String
    public var hostArea: String
    public var entryTone: String
    public var allowsObservation: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        surfaceName: String = "Family tree",
        hostArea: String = "Observation",
        entryTone: String = "observational",
        allowsObservation: Bool = true,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.surfaceName = surfaceName
        self.hostArea = hostArea
        self.entryTone = entryTone
        self.allowsObservation = allowsObservation
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        !surfaceName.isEmpty
            && !hostArea.isEmpty
            && entryTone == "observational"
            && allowsObservation
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilySurfacePlacement=surface:\(surfaceName),host:\(hostArea),tone:\(entryTone),observation:\(allowsObservation),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilySurfacePlacementReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyEntryPointCopy: Equatable, Sendable {
    public var placement: LineageFamilySurfacePlacement
    public var source: String
    public var title: String
    public var promptLine: String
    public var playerFacing: Bool

    public init(
        placement: LineageFamilySurfacePlacement = LineageFamilySurfacePlacement(),
        source: String = "observationMemory",
        title: String? = nil,
        promptLine: String? = nil,
        playerFacing: Bool = false
    ) {
        self.placement = placement
        self.source = source
        self.title = title ?? placement.surfaceName
        self.promptLine = promptLine ?? "When a family echo appears in Observation, keep it here as a quiet memory."
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        placement.hasRequiredFields
            && source == "observationMemory"
            && !title.isEmpty
            && !promptLine.isEmpty
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyEntryPoint=source:\(source),title:\(title),host:\(placement.hostArea),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyEntryPointReady:\(hasRequiredFields)"
    }
}

public struct LineageObservationMemoryTeaserCopy: Equatable, Sendable {
    public var entryPoint: LineageFamilyEntryPointCopy
    public var lineageCopy: LineageVisibleCueObservationCopy
    public var title: String
    public var memoryLine: String
    public var statusLine: String
    public var entryLine: String
    public var allowsNavigation: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        entryPoint: LineageFamilyEntryPointCopy = LineageFamilyEntryPointCopy(),
        lineageCopy: LineageVisibleCueObservationCopy,
        title: String = "Family echo",
        memoryLine: String? = nil,
        statusLine: String = "The family tree is only remembering this for now.",
        entryLine: String? = nil,
        allowsNavigation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = true
    ) {
        self.entryPoint = entryPoint
        self.lineageCopy = lineageCopy
        self.title = title
        self.memoryLine = memoryLine ?? lineageCopy.observationLine
        self.statusLine = statusLine
        self.entryLine = entryLine ?? "\(LineageFamilyNodeCopy.displayName(for: lineageCopy.memory.ancestorLabel)) is remembered in this branch."
        self.allowsNavigation = allowsNavigation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        entryPoint.hasRequiredFields
            && lineageCopy.hasRequiredFields
            && !title.isEmpty
            && !memoryLine.isEmpty
            && !statusLine.isEmpty
            && !entryLine.isEmpty
            && !allowsNavigation
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && playerFacing
    }

    public var summary: String {
        "lineageObservationMemoryTeaser=entry:\(entryPoint.title),trait:\(lineageCopy.memory.traitID),cue:\(lineageCopy.memory.visibleCue),entryLine:\(!entryLine.isEmpty),navigation:\(allowsNavigation),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageObservationMemoryTeaserReady:\(hasRequiredFields)"
    }
}

public struct LineageObservationMemorySheetCopy: Equatable, Sendable {
    public var teaser: LineageObservationMemoryTeaserCopy
    public var title: String
    public var ancestorLine: String
    public var memoryLine: String
    public var householdLine: String
    public var statusLine: String
    public var opensReadOnlySurface: Bool
    public var allowsGraphNavigation: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        teaser: LineageObservationMemoryTeaserCopy,
        title: String = "Family memory",
        ancestorLine: String? = nil,
        memoryLine: String? = nil,
        householdLine: String? = nil,
        statusLine: String = "This memory is only being kept for now.",
        opensReadOnlySurface: Bool = true,
        allowsGraphNavigation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = true
    ) {
        self.teaser = teaser
        self.title = title
        self.ancestorLine = ancestorLine ?? "Remembering \(LineageFamilyNodeCopy.displayName(for: teaser.lineageCopy.memory.ancestorLabel)) through \(teaser.lineageCopy.memory.displayName.lowercased())."
        self.memoryLine = memoryLine ?? teaser.memoryLine
        self.householdLine = householdLine ?? "This echo now belongs to this family's quiet line."
        self.statusLine = statusLine
        self.opensReadOnlySurface = opensReadOnlySurface
        self.allowsGraphNavigation = allowsGraphNavigation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        teaser.hasRequiredFields
            && !title.isEmpty
            && !ancestorLine.isEmpty
            && !memoryLine.isEmpty
            && !householdLine.isEmpty
            && !statusLine.isEmpty
            && opensReadOnlySurface
            && !allowsGraphNavigation
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && playerFacing
    }

    public var summary: String {
        "lineageObservationMemorySheet=entry:\(teaser.entryPoint.title),trait:\(teaser.lineageCopy.memory.traitID),ancestor:\(teaser.lineageCopy.memory.ancestorLabel),householdLine:\(!householdLine.isEmpty),readOnly:\(opensReadOnlySurface),graphNavigation:\(allowsGraphNavigation),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageObservationMemorySheetReady:\(hasRequiredFields)"
    }

    public var familyTreeEntryCopy: LineageObservationFamilyTreeEntryCopy {
        LineageObservationFamilyTreeEntryCopy(sheet: self)
    }
}

public struct LineageObservationFamilyTreeEntryCopy: Equatable, Sendable {
    public var sheet: LineageObservationMemorySheetCopy
    public var title: String
    public var ancestorLine: String
    public var memoryLine: String
    public var branchLine: String
    public var generationLine: String
    public var statusLine: String
    public var opensReadOnlySurface: Bool
    public var allowsGraphNavigation: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        sheet: LineageObservationMemorySheetCopy,
        title: String = "Family tree",
        ancestorLine: String? = nil,
        memoryLine: String? = nil,
        branchLine: String? = nil,
        generationLine: String? = nil,
        statusLine: String = "The tree is only holding this memory for now.",
        opensReadOnlySurface: Bool = true,
        allowsGraphNavigation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = true
    ) {
        self.sheet = sheet
        self.title = title
        self.ancestorLine = ancestorLine ?? "\(LineageFamilyNodeCopy.displayName(for: sheet.teaser.lineageCopy.memory.ancestorLabel)) begins this remembered line."
        self.memoryLine = memoryLine ?? sheet.memoryLine
        self.branchLine = branchLine ?? "\(LineageFamilyNodeCopy.displayName(for: sheet.teaser.lineageCopy.memory.ancestorLabel)) -> \(sheet.teaser.lineageCopy.memory.displayName.lowercased()) echo"
        self.generationLine = generationLine ?? "\(LineageFamilyNodeCopy.displayName(for: sheet.teaser.lineageCopy.memory.ancestorLabel)) is the first memory this line knows."
        self.statusLine = statusLine
        self.opensReadOnlySurface = opensReadOnlySurface
        self.allowsGraphNavigation = allowsGraphNavigation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        sheet.hasRequiredFields
            && !title.isEmpty
            && !ancestorLine.isEmpty
            && !memoryLine.isEmpty
            && !branchLine.isEmpty
            && !generationLine.isEmpty
            && !statusLine.isEmpty
            && opensReadOnlySurface
            && !allowsGraphNavigation
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && playerFacing
    }

    public var summary: String {
        "lineageObservationFamilyTreeEntry=title:\(title),ancestor:\(sheet.teaser.lineageCopy.memory.ancestorLabel),branchLine:\(!branchLine.isEmpty),generationLine:\(!generationLine.isEmpty),readOnly:\(opensReadOnlySurface),graphNavigation:\(allowsGraphNavigation),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageObservationFamilyTreeEntryReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyChildDraftNode: Equatable, Sendable {
    public var nodeCopy: LineageFamilyNodeCopy
    public var acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy
    public var nodeRole: String
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        nodeCopy: LineageFamilyNodeCopy = LineageFamilyNodeCopy(internalLabel: "childDraft"),
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy,
        nodeRole: String = "draftMemoryCandidate",
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.nodeCopy = nodeCopy
        self.acknowledgementSurface = acknowledgementSurface
        self.nodeRole = nodeRole
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        nodeCopy.hasRequiredFields
            && acknowledgementSurface.hasRequiredFields
            && !nodeRole.isEmpty
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        let preview = acknowledgementSurface.acknowledgement.memoryReference.preview
        return "lineageFamilyChildDraftNode=display:\(nodeCopy.displayName),role:\(nodeRole),generation:\(preview.plan.generation),changed:\(preview.changedTraitID),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyChildDraftNodeReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyTreeTeaserSurfaceCopy: Equatable, Sendable {
    public var entryPoint: LineageFamilyEntryPointCopy
    public var childDraftNode: LineageFamilyChildDraftNode?
    public var title: String
    public var subtitleLine: String
    public var statusLine: String
    public var allowsNavigation: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        entryPoint: LineageFamilyEntryPointCopy = LineageFamilyEntryPointCopy(),
        childDraftNode: LineageFamilyChildDraftNode? = nil,
        title: String? = nil,
        subtitleLine: String? = nil,
        statusLine: String? = nil,
        allowsNavigation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.entryPoint = entryPoint
        self.childDraftNode = childDraftNode
        self.title = title ?? entryPoint.title
        self.subtitleLine = subtitleLine ?? "A quiet place for family echoes to gather."
        self.statusLine = statusLine ?? Self.defaultStatusLine(childDraftNode: childDraftNode)
        self.allowsNavigation = allowsNavigation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        entryPoint.hasRequiredFields
            && (childDraftNode?.hasRequiredFields ?? true)
            && !title.isEmpty
            && !subtitleLine.isEmpty
            && !statusLine.isEmpty
            && !allowsNavigation
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyTreeTeaser=title:\(title),childDraft:\(childDraftNode == nil ? "none" : "ready"),navigation:\(allowsNavigation),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyTreeTeaserReady:\(hasRequiredFields)"
    }

    private static func defaultStatusLine(childDraftNode: LineageFamilyChildDraftNode?) -> String {
        guard let childDraftNode else {
            return "No draft echoes are waiting yet."
        }

        return "\(childDraftNode.nodeCopy.displayName) is quietly waiting in this branch."
    }
}

public struct LineageFamilyBranchPreview: Equatable, Sendable {
    public var ancestorNode: LineageFamilyNodeCopy
    public var familyPreview: LineageFamilyPreview
    public var childDraftNode: LineageFamilyChildDraftNode
    public var generationDepth: Int
    public var branchLine: String
    public var statusLine: String
    public var allowsNavigation: Bool
    public var allowsPersistenceWrite: Bool
    public var allowsBreedingControls: Bool
    public var allowsOptimizationControls: Bool
    public var playerFacing: Bool

    public init(
        ancestorNode: LineageFamilyNodeCopy,
        familyPreview: LineageFamilyPreview,
        childDraftNode: LineageFamilyChildDraftNode,
        generationDepth: Int = 3,
        branchLine: String? = nil,
        statusLine: String? = nil,
        allowsNavigation: Bool = false,
        allowsPersistenceWrite: Bool = false,
        allowsBreedingControls: Bool = false,
        allowsOptimizationControls: Bool = false,
        playerFacing: Bool = false
    ) {
        self.ancestorNode = ancestorNode
        self.familyPreview = familyPreview
        self.childDraftNode = childDraftNode
        self.generationDepth = max(1, generationDepth)
        self.branchLine = branchLine
            ?? "\(ancestorNode.displayName) begins this line; \(Self.join(familyPreview.memberNames)) carry it toward a draft memory."
        self.statusLine = statusLine
            ?? "This branch is only being observed; no family record is written yet."
        self.allowsNavigation = allowsNavigation
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.allowsBreedingControls = allowsBreedingControls
        self.allowsOptimizationControls = allowsOptimizationControls
        self.playerFacing = playerFacing
    }

    public var visibleNodeCount: Int {
        1 + familyPreview.memberNames.count + 1
    }

    public var visibleEdgeCount: Int {
        max(0, visibleNodeCount - 1)
    }

    public var hasRequiredFields: Bool {
        ancestorNode.hasRequiredFields
            && familyPreview.hasRequiredFields
            && childDraftNode.hasRequiredFields
            && ancestorNode.internalLabel == familyPreview.ancestorLabel
            && ancestorNode.displayName == familyPreview.ancestorDisplayName
            && generationDepth >= 3
            && visibleNodeCount >= 4
            && visibleEdgeCount == visibleNodeCount - 1
            && !branchLine.isEmpty
            && !statusLine.isEmpty
            && !allowsNavigation
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !allowsOptimizationControls
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyBranchPreview=ancestor:\(ancestorNode.displayName),members:\(Self.format(familyPreview.memberNames)),draft:\(childDraftNode.nodeCopy.displayName),generations:\(generationDepth),nodes:\(visibleNodeCount),edges:\(visibleEdgeCount),navigation:\(allowsNavigation),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),optimization:\(allowsOptimizationControls),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyBranchPreviewReady:\(hasRequiredFields)"
    }

    private static func join(_ values: [String]) -> String {
        switch values.count {
        case 0:
            return "no known descendants"
        case 1:
            return values[0]
        case 2:
            return "\(values[0]) and \(values[1])"
        default:
            let head = values.dropLast().joined(separator: ", ")
            return "\(head), and \(values[values.count - 1])"
        }
    }

    private static func format(_ values: [String]) -> String {
        values.isEmpty ? "none" : values.joined(separator: "+")
    }
}

public struct LineageBranchCaptionText: Equatable, Sendable {
    public var branchPreview: LineageFamilyBranchPreview
    public var previewText: LineageReadOnlyPreviewSurfaceText
    public var captionLine: String
    public var safetyLine: String

    public init(
        branchPreview: LineageFamilyBranchPreview,
        previewText: LineageReadOnlyPreviewSurfaceText,
        captionLine: String? = nil,
        safetyLine: String? = nil
    ) {
        self.branchPreview = branchPreview
        self.previewText = previewText
        self.captionLine = captionLine
            ?? "\(branchPreview.ancestorNode.displayName)'s line holds \(Self.join(branchPreview.familyPreview.memberNames)) close while \(branchPreview.childDraftNode.nodeCopy.displayName) waits as a quiet memory."
        self.safetyLine = safetyLine ?? previewText.safetyLine
    }

    public var containsHiddenRandomDetails: Bool {
        let text = snapshotText.lowercased()
        return text.contains("seed")
            || text.contains("random")
    }

    public var hasRequiredFields: Bool {
        branchPreview.hasRequiredFields
            && previewText.hasRequiredFields
            && branchPreview.generationDepth >= 3
            && !captionLine.isEmpty
            && !safetyLine.isEmpty
            && captionLine.contains(branchPreview.ancestorNode.displayName)
            && captionLine.contains(branchPreview.childDraftNode.nodeCopy.displayName)
            && branchPreview.familyPreview.memberNames.allSatisfy { captionLine.contains($0) }
            && !containsHiddenRandomDetails
            && !branchPreview.allowsNavigation
            && !branchPreview.allowsPersistenceWrite
            && !branchPreview.allowsBreedingControls
            && !branchPreview.allowsOptimizationControls
            && !branchPreview.playerFacing
    }

    public var lines: [String] {
        [
            captionLine,
            safetyLine
        ]
    }

    public var snapshotText: String {
        lines.joined(separator: "\n")
    }

    public var summary: String {
        "lineageBranchCaptionText=ancestor:\(branchPreview.ancestorNode.displayName),members:\(Self.format(branchPreview.familyPreview.memberNames)),draft:\(branchPreview.childDraftNode.nodeCopy.displayName),lines:\(lines.count),readOnly:\(!branchPreview.allowsPersistenceWrite && !branchPreview.allowsBreedingControls),hiddenRandomDetails:\(containsHiddenRandomDetails)"
    }

    public var readinessSummary: String {
        "lineageBranchCaptionTextReady:\(hasRequiredFields)"
    }

    private static func join(_ values: [String]) -> String {
        switch values.count {
        case 0:
            return "this family"
        case 1:
            return values[0]
        case 2:
            return "\(values[0]) and \(values[1])"
        default:
            let head = values.dropLast().joined(separator: ", ")
            return "\(head), and \(values[values.count - 1])"
        }
    }

    private static func format(_ values: [String]) -> String {
        values.isEmpty ? "none" : values.joined(separator: "+")
    }
}

public struct LineageObservationBranchCaptionBridge: Equatable, Sendable {
    public var observationEntry: LineageObservationFamilyTreeEntryCopy
    public var branchCaption: LineageBranchCaptionText
    public var bridgeLine: String

    public init(
        observationEntry: LineageObservationFamilyTreeEntryCopy,
        branchCaption: LineageBranchCaptionText,
        bridgeLine: String? = nil
    ) {
        self.observationEntry = observationEntry
        self.branchCaption = branchCaption
        self.bridgeLine = bridgeLine
            ?? "Observation keeps the first branch gentle before the family tree becomes a place to visit."
    }

    public var observationIsReadOnly: Bool {
        observationEntry.opensReadOnlySurface
            && !observationEntry.allowsGraphNavigation
            && !observationEntry.allowsPersistenceWrite
            && !observationEntry.allowsBreedingControls
            && !observationEntry.allowsOptimizationControls
    }

    public var branchCaptionIsReadOnly: Bool {
        !branchCaption.branchPreview.allowsNavigation
            && !branchCaption.branchPreview.allowsPersistenceWrite
            && !branchCaption.branchPreview.allowsBreedingControls
            && !branchCaption.branchPreview.allowsOptimizationControls
            && !branchCaption.branchPreview.playerFacing
    }

    public var sharesFamilyLineLanguage: Bool {
        let combined = [
            observationEntry.branchLine,
            observationEntry.generationLine,
            observationEntry.sheet.householdLine,
            branchCaption.captionLine,
            bridgeLine
        ].joined(separator: " ").lowercased()

        return combined.contains("family")
            && combined.contains("branch")
            && combined.contains("line")
    }

    public var containsHiddenRandomDetails: Bool {
        let combined = [
            observationEntry.branchLine,
            observationEntry.generationLine,
            observationEntry.sheet.householdLine,
            branchCaption.snapshotText,
            bridgeLine
        ].joined(separator: " ").lowercased()

        return combined.contains("seed")
            || combined.contains("random")
    }

    public var hasRequiredFields: Bool {
        observationEntry.hasRequiredFields
            && branchCaption.hasRequiredFields
            && !bridgeLine.isEmpty
            && observationIsReadOnly
            && branchCaptionIsReadOnly
            && sharesFamilyLineLanguage
            && !containsHiddenRandomDetails
    }

    public var summary: String {
        "lineageObservationBranchCaptionBridge=observationAncestor:\(observationEntry.sheet.teaser.lineageCopy.memory.ancestorLabel),branchAncestor:\(branchCaption.branchPreview.ancestorNode.displayName),observationReadOnly:\(observationIsReadOnly),branchReadOnly:\(branchCaptionIsReadOnly),sharedFamilyLine:\(sharesFamilyLineLanguage),hiddenRandomDetails:\(containsHiddenRandomDetails)"
    }

    public var readinessSummary: String {
        "lineageObservationBranchCaptionBridgeReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryCeremonyEvidence: Equatable, Sendable {
    public var memoryReference: LineageChildDraftMemoryReference
    public var hasObservedTraitChange: Bool
    public var hasAncestorResemblanceCopy: Bool
    public var hasObservationContext: Bool
    public var writesDiscoveryLog: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        memoryReference: LineageChildDraftMemoryReference,
        hasObservedTraitChange: Bool = true,
        hasAncestorResemblanceCopy: Bool = true,
        hasObservationContext: Bool = true,
        writesDiscoveryLog: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.memoryReference = memoryReference
        self.hasObservedTraitChange = hasObservedTraitChange
        self.hasAncestorResemblanceCopy = hasAncestorResemblanceCopy
        self.hasObservationContext = hasObservationContext
        self.writesDiscoveryLog = writesDiscoveryLog
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        memoryReference.hasRequiredFields
            && hasObservedTraitChange
            && hasAncestorResemblanceCopy
            && hasObservationContext
            && !writesDiscoveryLog
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = memoryReference.preview
        return "lineageDraftMemoryCeremonyEvidence=changed:\(preview.changedTraitID),trait:\(hasObservedTraitChange),ancestor:\(hasAncestorResemblanceCopy),observation:\(hasObservationContext),discoveryWrite:\(writesDiscoveryLog),createsChild:\(createsChildRecord),ready:\(hasRequiredFields),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryCeremonyEvidenceReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryEvidenceReviewSurfaceCopy: Equatable, Sendable {
    public var evidence: LineageDraftMemoryCeremonyEvidence
    public var title: String
    public var traitLine: String
    public var ancestorLine: String
    public var contextLine: String
    public var allowsPersistenceWrite: Bool
    public var writesDiscoveryLog: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        evidence: LineageDraftMemoryCeremonyEvidence,
        title: String = "Evidence review",
        traitLine: String? = nil,
        ancestorLine: String = "Ancestor resemblance has been noticed.",
        contextLine: String = "Keep this as an Observation memory candidate.",
        allowsPersistenceWrite: Bool = false,
        writesDiscoveryLog: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.evidence = evidence
        self.title = title
        self.traitLine = traitLine ?? "Observed \(evidence.memoryReference.preview.changedTraitID) change."
        self.ancestorLine = ancestorLine
        self.contextLine = contextLine
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.writesDiscoveryLog = writesDiscoveryLog
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        evidence.hasRequiredFields
            && !title.isEmpty
            && !traitLine.isEmpty
            && !ancestorLine.isEmpty
            && !contextLine.isEmpty
            && !allowsPersistenceWrite
            && !writesDiscoveryLog
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = evidence.memoryReference.preview
        return "lineageDraftMemoryEvidenceReview=changed:\(preview.changedTraitID),title:\(title),traitReady:\(!traitLine.isEmpty),ancestorReady:\(!ancestorLine.isEmpty),contextReady:\(!contextLine.isEmpty),persistence:\(allowsPersistenceWrite),discoveryWrite:\(writesDiscoveryLog),createsChild:\(createsChildRecord),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryEvidenceReviewReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryAcknowledgementReviewSurfaceCopy: Equatable, Sendable {
    public var evidenceReview: LineageDraftMemoryEvidenceReviewSurfaceCopy
    public var acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy
    public var title: String
    public var reviewLine: String
    public var waitingLine: String
    public var allowsCommit: Bool
    public var allowsPersistenceWrite: Bool
    public var writesDiscoveryLog: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        evidenceReview: LineageDraftMemoryEvidenceReviewSurfaceCopy,
        acknowledgementSurface: LineageChildDraftAcknowledgementSurfaceCopy,
        title: String = "Acknowledgement review",
        reviewLine: String? = nil,
        waitingLine: String? = nil,
        allowsCommit: Bool = false,
        allowsPersistenceWrite: Bool = false,
        writesDiscoveryLog: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.evidenceReview = evidenceReview
        self.acknowledgementSurface = acknowledgementSurface
        self.title = title
        self.reviewLine = reviewLine ?? acknowledgementSurface.promptLine
        self.waitingLine = waitingLine ?? acknowledgementSurface.waitingLine
        self.allowsCommit = allowsCommit
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.writesDiscoveryLog = writesDiscoveryLog
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        evidenceReview.hasRequiredFields
            && acknowledgementSurface.hasRequiredFields
            && !title.isEmpty
            && !reviewLine.isEmpty
            && !waitingLine.isEmpty
            && !allowsCommit
            && !allowsPersistenceWrite
            && !writesDiscoveryLog
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = evidenceReview.evidence.memoryReference.preview
        return "lineageDraftMemoryAcknowledgementReview=changed:\(preview.changedTraitID),title:\(title),reviewReady:\(!reviewLine.isEmpty),waitingReady:\(!waitingLine.isEmpty),commit:\(allowsCommit),persistence:\(allowsPersistenceWrite),discoveryWrite:\(writesDiscoveryLog),createsChild:\(createsChildRecord),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryAcknowledgementReviewReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryExplicitIntentGate: Equatable, Sendable {
    public var acknowledgementReview: LineageDraftMemoryAcknowledgementReviewSurfaceCopy
    public var title: String
    public var intentLine: String
    public var hasExplicitIntent: Bool
    public var allowsCommit: Bool
    public var allowsPersistenceWrite: Bool
    public var writesDiscoveryLog: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        acknowledgementReview: LineageDraftMemoryAcknowledgementReviewSurfaceCopy,
        title: String = "Intent gate",
        intentLine: String = "Explicit acknowledgement can be reviewed later.",
        hasExplicitIntent: Bool = false,
        allowsCommit: Bool = false,
        allowsPersistenceWrite: Bool = false,
        writesDiscoveryLog: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.acknowledgementReview = acknowledgementReview
        self.title = title
        self.intentLine = intentLine
        self.hasExplicitIntent = hasExplicitIntent
        self.allowsCommit = allowsCommit
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.writesDiscoveryLog = writesDiscoveryLog
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        acknowledgementReview.hasRequiredFields
            && !title.isEmpty
            && !intentLine.isEmpty
            && !allowsCommit
            && !allowsPersistenceWrite
            && !writesDiscoveryLog
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = acknowledgementReview.evidenceReview.evidence.memoryReference.preview
        return "lineageDraftMemoryExplicitIntentGate=changed:\(preview.changedTraitID),title:\(title),intent:\(hasExplicitIntent),commit:\(allowsCommit),persistence:\(allowsPersistenceWrite),discoveryWrite:\(writesDiscoveryLog),createsChild:\(createsChildRecord),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryExplicitIntentGateReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryPersistenceBoundary: Equatable, Sendable {
    public var childDraftNode: LineageFamilyChildDraftNode
    public var ceremonyEvidence: LineageDraftMemoryCeremonyEvidence?
    public var hasCeremonyAcknowledgement: Bool
    public var hasDiscoveryEvidence: Bool
    public var allowsSwiftDataWrite: Bool
    public var allowsAppGroupWrite: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        childDraftNode: LineageFamilyChildDraftNode,
        ceremonyEvidence: LineageDraftMemoryCeremonyEvidence? = nil,
        hasCeremonyAcknowledgement: Bool = false,
        hasDiscoveryEvidence: Bool = false,
        allowsSwiftDataWrite: Bool = false,
        allowsAppGroupWrite: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.childDraftNode = childDraftNode
        self.ceremonyEvidence = ceremonyEvidence
        self.hasCeremonyAcknowledgement = hasCeremonyAcknowledgement
        self.hasDiscoveryEvidence = ceremonyEvidence?.hasRequiredFields ?? hasDiscoveryEvidence
        self.allowsSwiftDataWrite = allowsSwiftDataWrite
        self.allowsAppGroupWrite = allowsAppGroupWrite
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var allowsFuturePersistence: Bool {
        childDraftNode.hasRequiredFields
            && hasCeremonyAcknowledgement
            && hasDiscoveryEvidence
            && allowsSwiftDataWrite
            && allowsAppGroupWrite
            && !createsChildRecord
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        childDraftNode.hasRequiredFields
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = childDraftNode.acknowledgementSurface.acknowledgement.memoryReference.preview
        return "lineageDraftMemoryPersistence=changed:\(preview.changedTraitID),ceremony:\(hasCeremonyAcknowledgement),evidence:\(hasDiscoveryEvidence),swiftData:\(allowsSwiftDataWrite),appGroup:\(allowsAppGroupWrite),createsChild:\(createsChildRecord),futureWrite:\(allowsFuturePersistence),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryPersistenceReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryPersistenceDryRunAdapter: Equatable, Sendable {
    public var boundary: LineageDraftMemoryPersistenceBoundary
    public var intentGate: LineageDraftMemoryExplicitIntentGate
    public var targetsSwiftData: Bool
    public var targetsAppGroup: Bool
    public var dryRunOnly: Bool
    public var performsWrite: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        boundary: LineageDraftMemoryPersistenceBoundary,
        intentGate: LineageDraftMemoryExplicitIntentGate,
        targetsSwiftData: Bool = true,
        targetsAppGroup: Bool = true,
        dryRunOnly: Bool = true,
        performsWrite: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.boundary = boundary
        self.intentGate = intentGate
        self.targetsSwiftData = targetsSwiftData
        self.targetsAppGroup = targetsAppGroup
        self.dryRunOnly = dryRunOnly
        self.performsWrite = performsWrite
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var isSafeDryRun: Bool {
        boundary.hasRequiredFields
            && intentGate.hasRequiredFields
            && dryRunOnly
            && !performsWrite
            && !createsChildRecord
            && !playerFacing
    }

    public var isReadyForFuturePersistence: Bool {
        isSafeDryRun
            && boundary.allowsFuturePersistence
            && intentGate.hasExplicitIntent
            && targetsSwiftData
            && targetsAppGroup
    }

    public var hasRequiredFields: Bool {
        isSafeDryRun
            && targetsSwiftData
            && targetsAppGroup
    }

    public var summary: String {
        let preview = boundary.childDraftNode.acknowledgementSurface.acknowledgement.memoryReference.preview
        return "lineageDraftMemoryPersistenceDryRun=changed:\(preview.changedTraitID),safe:\(isSafeDryRun),futureReady:\(isReadyForFuturePersistence),intent:\(intentGate.hasExplicitIntent),swiftData:\(targetsSwiftData),appGroup:\(targetsAppGroup),dryRun:\(dryRunOnly),write:\(performsWrite),createsChild:\(createsChildRecord),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryPersistenceDryRunReady:\(hasRequiredFields)"
    }
}

public struct LineageDraftMemoryConfirmationCeremony: Equatable, Sendable {
    public var acknowledgementReview: LineageDraftMemoryAcknowledgementReviewSurfaceCopy
    public var intentGate: LineageDraftMemoryExplicitIntentGate
    public var dryRunAdapter: LineageDraftMemoryPersistenceDryRunAdapter
    public var title: String
    public var ancestorLine: String
    public var safetyLine: String
    public var allowsCommit: Bool
    public var allowsPersistenceWrite: Bool
    public var writesDiscoveryLog: Bool
    public var createsChildRecord: Bool
    public var playerFacing: Bool

    public init(
        acknowledgementReview: LineageDraftMemoryAcknowledgementReviewSurfaceCopy,
        intentGate: LineageDraftMemoryExplicitIntentGate,
        dryRunAdapter: LineageDraftMemoryPersistenceDryRunAdapter,
        title: String = "Confirmation ceremony",
        ancestorLine: String? = nil,
        safetyLine: String = "This draft stays read-only until a future ceremony confirms it.",
        allowsCommit: Bool = false,
        allowsPersistenceWrite: Bool = false,
        writesDiscoveryLog: Bool = false,
        createsChildRecord: Bool = false,
        playerFacing: Bool = false
    ) {
        self.acknowledgementReview = acknowledgementReview
        self.intentGate = intentGate
        self.dryRunAdapter = dryRunAdapter
        self.title = title
        self.ancestorLine = ancestorLine ?? "Mostly family-like, with a gentle \(acknowledgementReview.evidenceReview.evidence.memoryReference.preview.changedTraitID) echo."
        self.safetyLine = safetyLine
        self.allowsCommit = allowsCommit
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.writesDiscoveryLog = writesDiscoveryLog
        self.createsChildRecord = createsChildRecord
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        acknowledgementReview.hasRequiredFields
            && intentGate.hasRequiredFields
            && dryRunAdapter.hasRequiredFields
            && !title.isEmpty
            && !ancestorLine.isEmpty
            && !safetyLine.isEmpty
            && !allowsCommit
            && !allowsPersistenceWrite
            && !writesDiscoveryLog
            && !createsChildRecord
            && !playerFacing
    }

    public var summary: String {
        let preview = acknowledgementReview.evidenceReview.evidence.memoryReference.preview
        return "lineageDraftMemoryConfirmationCeremony=changed:\(preview.changedTraitID),title:\(title),acknowledgement:\(acknowledgementReview.hasRequiredFields),intent:\(intentGate.hasRequiredFields),dryRun:\(dryRunAdapter.hasRequiredFields),commit:\(allowsCommit),persistence:\(allowsPersistenceWrite),discoveryWrite:\(writesDiscoveryLog),createsChild:\(createsChildRecord),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageDraftMemoryConfirmationCeremonyReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyGraphLayoutAdoptionGate: Equatable, Sendable {
    public var generationDepth: Int
    public var visibleNodeCount: Int
    public var visibleEdgeCount: Int
    public var requiresDeterministicLayout: Bool
    public var manualLayoutInsufficient: Bool
    public var playerFacing: Bool

    public init(
        generationDepth: Int,
        visibleNodeCount: Int,
        visibleEdgeCount: Int,
        requiresDeterministicLayout: Bool = false,
        manualLayoutInsufficient: Bool = false,
        playerFacing: Bool = false
    ) {
        self.generationDepth = max(0, generationDepth)
        self.visibleNodeCount = max(0, visibleNodeCount)
        self.visibleEdgeCount = max(0, visibleEdgeCount)
        self.requiresDeterministicLayout = requiresDeterministicLayout
        self.manualLayoutInsufficient = manualLayoutInsufficient
        self.playerFacing = playerFacing
    }

    public var shouldAdoptGraphLayoutHelper: Bool {
        generationDepth >= 3
            && visibleNodeCount >= 5
            && visibleEdgeCount >= 4
            && requiresDeterministicLayout
            && manualLayoutInsufficient
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        visibleNodeCount >= 2
            && visibleEdgeCount >= 1
            && visibleEdgeCount < visibleNodeCount
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyGraphLayoutAdoption=generations:\(generationDepth),nodes:\(visibleNodeCount),edges:\(visibleEdgeCount),deterministic:\(requiresDeterministicLayout),manualInsufficient:\(manualLayoutInsufficient),adopt:\(shouldAdoptGraphLayoutHelper),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyGraphLayoutAdoptionReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyGraphLayoutLibraryReview: Equatable, Sendable {
    public var gate: LineageFamilyGraphLayoutAdoptionGate
    public var candidateLibrary: String
    public var candidatePurpose: String
    public var manualLayoutStillPreferred: Bool
    public var dependencyAdded: Bool
    public var packageChanged: Bool
    public var appBehaviorChanged: Bool
    public var playerFacing: Bool

    public init(
        gate: LineageFamilyGraphLayoutAdoptionGate,
        candidateLibrary: String = "SwiftAlgorithmsCollections",
        candidatePurpose: String = "branchTraversalAndOrdering",
        manualLayoutStillPreferred: Bool = true,
        dependencyAdded: Bool = false,
        packageChanged: Bool = false,
        appBehaviorChanged: Bool = false,
        playerFacing: Bool = false
    ) {
        self.gate = gate
        self.candidateLibrary = candidateLibrary
        self.candidatePurpose = candidatePurpose
        self.manualLayoutStillPreferred = manualLayoutStillPreferred
        self.dependencyAdded = dependencyAdded
        self.packageChanged = packageChanged
        self.appBehaviorChanged = appBehaviorChanged
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        gate.hasRequiredFields
            && !gate.shouldAdoptGraphLayoutHelper
            && candidateLibrary == "SwiftAlgorithmsCollections"
            && candidatePurpose == "branchTraversalAndOrdering"
            && manualLayoutStillPreferred
            && !dependencyAdded
            && !packageChanged
            && !appBehaviorChanged
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyGraphLayoutLibraryReview=candidate:\(candidateLibrary),purpose:\(candidatePurpose),manualPreferred:\(manualLayoutStillPreferred),adoptGate:\(gate.shouldAdoptGraphLayoutHelper),dependencyAdded:\(dependencyAdded),packageChanged:\(packageChanged),appBehaviorChanged:\(appBehaviorChanged),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyGraphLayoutLibraryReviewReady:\(hasRequiredFields)"
    }
}

public struct LineageFamilyEntryMemoryBridge: Equatable, Sendable {
    public var entryPoint: LineageFamilyEntryPointCopy
    public var discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview
    public var playerFacing: Bool

    public init(
        entryPoint: LineageFamilyEntryPointCopy = LineageFamilyEntryPointCopy(),
        discoveryHandoff: GrowthCeremonyDiscoveryLogHandoffPreview,
        playerFacing: Bool = false
    ) {
        self.entryPoint = entryPoint
        self.discoveryHandoff = discoveryHandoff
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        entryPoint.hasRequiredFields
            && discoveryHandoff.hasRequiredFields
            && discoveryHandoff.includesLineageEcho
            && !discoveryHandoff.allowsWrite
            && !playerFacing
    }

    public var summary: String {
        "lineageFamilyEntryMemory=entry:\(entryPoint.title),source:\(entryPoint.source),discovery:\(discoveryHandoff.discoveryTitle),lineage:\(discoveryHandoff.includesLineageEcho),allowsWrite:\(discoveryHandoff.allowsWrite),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "lineageFamilyEntryMemoryReady:\(hasRequiredFields)"
    }
}

public struct GenomeVisibleCueMemory: Equatable, Sendable {
    public var source: String
    public var traitID: String
    public var displayName: String
    public var visibleCue: String
    public var genomeSummary: String
    public var playerFacing: Bool

    public init(
        source: String = "SpriteKit",
        traitID: String,
        displayName: String,
        visibleCue: String,
        genomeSummary: String,
        playerFacing: Bool = false
    ) {
        self.source = source
        self.traitID = traitID
        self.displayName = displayName
        self.visibleCue = visibleCue
        self.genomeSummary = genomeSummary
        self.playerFacing = playerFacing
    }

    public var hasRequiredFields: Bool {
        !source.isEmpty
            && !traitID.isEmpty
            && !displayName.isEmpty
            && !visibleCue.isEmpty
            && !genomeSummary.isEmpty
    }

    public func lineageMemory(
        discovery: DiscoveryEvent?,
        ancestorLabel: String = "ancestor"
    ) -> LineageVisibleCueMemory? {
        guard hasRequiredFields else {
            return nil
        }

        return LineageVisibleCueMemory(
            discovery: discovery,
            traitID: traitID,
            displayName: displayName,
            visibleCue: visibleCue,
            ancestorLabel: ancestorLabel
        )
    }

    public var summary: String {
        "genomeVisibleCueMemory=source:\(source),trait:\(traitID),cue:\(visibleCue),display:\(displayName),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "genomeVisibleCueMemoryReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitRecognizabilityCueCandidateGate: Equatable, Sendable {
    public var sourceLabel: String
    public var targetTraitIDs: [String]
    public var cuePurpose: String
    public var visualVocabulary: String
    public var manualArtReviewReady: Bool
    public var appHostVisualQAReady: Bool
    public var usesExistingHandmadeVocabulary: Bool
    public var changesVisiblePixels: Bool
    public var labelOnlyChange: Bool
    public var copyOnlyChange: Bool
    public var lineageMarkOnlyChange: Bool
    public var clutterRisk: String
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        sourceLabel: String = "genomeVariationQA",
        targetTraitIDs: [String] = ["body", "tail"],
        cuePurpose: String = "atAGlanceFamilyRecognition",
        visualVocabulary: String = "existingHandmadeSpriteKitParts",
        manualArtReviewReady: Bool = false,
        appHostVisualQAReady: Bool = false,
        usesExistingHandmadeVocabulary: Bool = true,
        changesVisiblePixels: Bool = false,
        labelOnlyChange: Bool = false,
        copyOnlyChange: Bool = false,
        lineageMarkOnlyChange: Bool = false,
        clutterRisk: String = "low",
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.sourceLabel = sourceLabel
        self.targetTraitIDs = targetTraitIDs
        self.cuePurpose = cuePurpose
        self.visualVocabulary = visualVocabulary
        self.manualArtReviewReady = manualArtReviewReady
        self.appHostVisualQAReady = appHostVisualQAReady
        self.usesExistingHandmadeVocabulary = usesExistingHandmadeVocabulary
        self.changesVisiblePixels = changesVisiblePixels
        self.labelOnlyChange = labelOnlyChange
        self.copyOnlyChange = copyOnlyChange
        self.lineageMarkOnlyChange = lineageMarkOnlyChange
        self.clutterRisk = clutterRisk
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var targetsRecognizableBodyWingOrTail: Bool {
        let allowedTargets = Set(["body", "wing", "tail"])
        return !targetTraitIDs.isEmpty
            && targetTraitIDs.allSatisfy { allowedTargets.contains($0) }
            && targetTraitIDs.contains { $0 == "body" || $0 == "tail" }
    }

    public var canImplementVisibleCue: Bool {
        targetsRecognizableBodyWingOrTail
            && !sourceLabel.isEmpty
            && cuePurpose == "atAGlanceFamilyRecognition"
            && visualVocabulary == "existingHandmadeSpriteKitParts"
            && manualArtReviewReady
            && appHostVisualQAReady
            && usesExistingHandmadeVocabulary
            && changesVisiblePixels
            && !labelOnlyChange
            && !copyOnlyChange
            && !lineageMarkOnlyChange
            && clutterRisk != "high"
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        targetsRecognizableBodyWingOrTail
            && !sourceLabel.isEmpty
            && cuePurpose == "atAGlanceFamilyRecognition"
            && visualVocabulary == "existingHandmadeSpriteKitParts"
            && !manualArtReviewReady
            && !appHostVisualQAReady
            && usesExistingHandmadeVocabulary
            && !changesVisiblePixels
            && !labelOnlyChange
            && !copyOnlyChange
            && !lineageMarkOnlyChange
            && clutterRisk != "high"
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canImplementVisibleCue
    }

    public var summary: String {
        let targets = targetTraitIDs.isEmpty ? "none" : targetTraitIDs.joined(separator: "+")
        return "spriteKitRecognizabilityCueCandidate=source:\(sourceLabel),targets:\(targets),purpose:\(cuePurpose),vocabulary:\(visualVocabulary),manualArtReview:\(manualArtReviewReady),appHostVisualQA:\(appHostVisualQAReady),visiblePixels:\(changesVisiblePixels),labelOnly:\(labelOnlyChange),copyOnly:\(copyOnlyChange),lineageMarkOnly:\(lineageMarkOnlyChange),clutter:\(clutterRisk),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),implement:\(canImplementVisibleCue)"
    }

    public var readinessSummary: String {
        "spriteKitRecognizabilityCueCandidateReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitRecognizabilityCueSelectionReview: Equatable, Sendable {
    public var gate: SpriteKitRecognizabilityCueCandidateGate
    public var selectedTraitID: String
    public var selectedCueID: String
    public var selectedPartFamily: String
    public var affectionReason: String
    public var rejectedAlternatives: [String]
    public var proposalOnly: Bool
    public var changesVisiblePixels: Bool
    public var usesExistingHandmadeVocabulary: Bool
    public var appHostVisualQAReady: Bool
    public var manualArtReviewReady: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        gate: SpriteKitRecognizabilityCueCandidateGate = SpriteKitRecognizabilityCueCandidateGate(),
        selectedTraitID: String = "tail",
        selectedCueID: String = "fishFin+softForkFin",
        selectedPartFamily: String = "Tail.fish",
        affectionReason: String = "softFishTailSilhouetteReadsAtAGlance",
        rejectedAlternatives: [String] = ["labelOnly", "copyOnly", "lineageMarkOnly"],
        proposalOnly: Bool = true,
        changesVisiblePixels: Bool = false,
        usesExistingHandmadeVocabulary: Bool = true,
        appHostVisualQAReady: Bool = false,
        manualArtReviewReady: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.gate = gate
        self.selectedTraitID = selectedTraitID
        self.selectedCueID = selectedCueID
        self.selectedPartFamily = selectedPartFamily
        self.affectionReason = affectionReason
        self.rejectedAlternatives = rejectedAlternatives
        self.proposalOnly = proposalOnly
        self.changesVisiblePixels = changesVisiblePixels
        self.usesExistingHandmadeVocabulary = usesExistingHandmadeVocabulary
        self.appHostVisualQAReady = appHostVisualQAReady
        self.manualArtReviewReady = manualArtReviewReady
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canProceedToVisibleImplementation: Bool {
        gate.canImplementVisibleCue
            && selectedTraitID == "tail"
            && selectedCueID == "fishFin+softForkFin"
            && selectedPartFamily == "Tail.fish"
            && affectionReason == "softFishTailSilhouetteReadsAtAGlance"
            && rejectedAlternatives.contains("labelOnly")
            && rejectedAlternatives.contains("copyOnly")
            && rejectedAlternatives.contains("lineageMarkOnly")
            && !proposalOnly
            && changesVisiblePixels
            && usesExistingHandmadeVocabulary
            && appHostVisualQAReady
            && manualArtReviewReady
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        gate.hasRequiredFields
            && selectedTraitID == "tail"
            && selectedCueID == "fishFin+softForkFin"
            && selectedPartFamily == "Tail.fish"
            && affectionReason == "softFishTailSilhouetteReadsAtAGlance"
            && rejectedAlternatives.contains("labelOnly")
            && rejectedAlternatives.contains("copyOnly")
            && rejectedAlternatives.contains("lineageMarkOnly")
            && proposalOnly
            && !changesVisiblePixels
            && usesExistingHandmadeVocabulary
            && !appHostVisualQAReady
            && !manualArtReviewReady
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canProceedToVisibleImplementation
    }

    public var summary: String {
        let rejected = rejectedAlternatives.isEmpty ? "none" : rejectedAlternatives.joined(separator: "+")
        return "spriteKitRecognizabilityCueSelection=gateReady:\(gate.hasRequiredFields),trait:\(selectedTraitID),cue:\(selectedCueID),family:\(selectedPartFamily),reason:\(affectionReason),rejected:\(rejected),proposalOnly:\(proposalOnly),visiblePixels:\(changesVisiblePixels),handmade:\(usesExistingHandmadeVocabulary),appHostVisualQA:\(appHostVisualQAReady),manualArtReview:\(manualArtReviewReady),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),proceed:\(canProceedToVisibleImplementation)"
    }

    public var readinessSummary: String {
        "spriteKitRecognizabilityCueSelectionReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailArtReviewChecklist: Equatable, Sendable {
    public var selectionReview: SpriteKitRecognizabilityCueSelectionReview
    public var checklistItems: [String]
    public var manualArtReviewReady: Bool
    public var appHostVisualQAReady: Bool
    public var snapshotReviewReady: Bool
    public var changesVisiblePixels: Bool
    public var allowsSharpFin: Bool
    public var allowsRarityOrStatFraming: Bool
    public var allowsLineageMarkOnlyCue: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        selectionReview: SpriteKitRecognizabilityCueSelectionReview = SpriteKitRecognizabilityCueSelectionReview(),
        checklistItems: [String] = [
            "softForkShape",
            "secondarySilhouette",
            "atAGlanceTailReadability",
            "cuteMotionRoom",
            "noSharpFin",
            "noRarityStatFraming",
            "noLineageMarkOnly"
        ],
        manualArtReviewReady: Bool = false,
        appHostVisualQAReady: Bool = false,
        snapshotReviewReady: Bool = false,
        changesVisiblePixels: Bool = false,
        allowsSharpFin: Bool = false,
        allowsRarityOrStatFraming: Bool = false,
        allowsLineageMarkOnlyCue: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.selectionReview = selectionReview
        self.checklistItems = checklistItems
        self.manualArtReviewReady = manualArtReviewReady
        self.appHostVisualQAReady = appHostVisualQAReady
        self.snapshotReviewReady = snapshotReviewReady
        self.changesVisiblePixels = changesVisiblePixels
        self.allowsSharpFin = allowsSharpFin
        self.allowsRarityOrStatFraming = allowsRarityOrStatFraming
        self.allowsLineageMarkOnlyCue = allowsLineageMarkOnlyCue
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasChecklistItems: Bool {
        checklistItems.contains("softForkShape")
            && checklistItems.contains("secondarySilhouette")
            && checklistItems.contains("atAGlanceTailReadability")
            && checklistItems.contains("cuteMotionRoom")
            && checklistItems.contains("noSharpFin")
            && checklistItems.contains("noRarityStatFraming")
            && checklistItems.contains("noLineageMarkOnly")
    }

    public var canAuthorizeVisibleImplementation: Bool {
        selectionReview.canProceedToVisibleImplementation
            && hasChecklistItems
            && manualArtReviewReady
            && appHostVisualQAReady
            && snapshotReviewReady
            && changesVisiblePixels
            && !allowsSharpFin
            && !allowsRarityOrStatFraming
            && !allowsLineageMarkOnlyCue
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        selectionReview.hasRequiredFields
            && hasChecklistItems
            && !manualArtReviewReady
            && !appHostVisualQAReady
            && !snapshotReviewReady
            && !changesVisiblePixels
            && !allowsSharpFin
            && !allowsRarityOrStatFraming
            && !allowsLineageMarkOnlyCue
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canAuthorizeVisibleImplementation
    }

    public var summary: String {
        let items = checklistItems.isEmpty ? "none" : checklistItems.joined(separator: "+")
        return "spriteKitFishTailArtReview=selectionReady:\(selectionReview.hasRequiredFields),items:\(items),manualArtReview:\(manualArtReviewReady),appHostVisualQA:\(appHostVisualQAReady),snapshotReview:\(snapshotReviewReady),visiblePixels:\(changesVisiblePixels),sharpFin:\(allowsSharpFin),rarityStat:\(allowsRarityOrStatFraming),lineageMarkOnly:\(allowsLineageMarkOnlyCue),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),authorize:\(canAuthorizeVisibleImplementation)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailArtReviewReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationPreflight: Equatable, Sendable {
    public var artReviewChecklist: SpriteKitFishTailArtReviewChecklist
    public var dataVolumeReady: Bool
    public var appHostVisualQAReady: Bool
    public var manualArtReviewAccepted: Bool
    public var snapshotReviewAccepted: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        artReviewChecklist: SpriteKitFishTailArtReviewChecklist = SpriteKitFishTailArtReviewChecklist(),
        dataVolumeReady: Bool = false,
        appHostVisualQAReady: Bool = false,
        manualArtReviewAccepted: Bool = false,
        snapshotReviewAccepted: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.artReviewChecklist = artReviewChecklist
        self.dataVolumeReady = dataVolumeReady
        self.appHostVisualQAReady = appHostVisualQAReady
        self.manualArtReviewAccepted = manualArtReviewAccepted
        self.snapshotReviewAccepted = snapshotReviewAccepted
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canOpenImplementation: Bool {
        artReviewChecklist.canAuthorizeVisibleImplementation
            && dataVolumeReady
            && appHostVisualQAReady
            && manualArtReviewAccepted
            && snapshotReviewAccepted
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        artReviewChecklist.hasRequiredFields
            && !dataVolumeReady
            && !appHostVisualQAReady
            && !manualArtReviewAccepted
            && !snapshotReviewAccepted
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canOpenImplementation
    }

    public var summary: String {
        "spriteKitFishTailImplementationPreflight=artReviewReady:\(artReviewChecklist.hasRequiredFields),dataReady:\(dataVolumeReady),appHostVisualQA:\(appHostVisualQAReady),manualArtReview:\(manualArtReviewAccepted),snapshotReview:\(snapshotReviewAccepted),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),open:\(canOpenImplementation)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationPreflightReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailVisibleWorkResumeBridge: Equatable, Sendable {
    public var implementationPreflight: SpriteKitFishTailImplementationPreflight
    public var xctestDevicesStorageGateReady: Bool
    public var xctestDevicesStorageCanResume: Bool
    public var appHostVisualQAResumeReady: Bool
    public var manualArtReviewAccepted: Bool
    public var snapshotReviewAccepted: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        implementationPreflight: SpriteKitFishTailImplementationPreflight = SpriteKitFishTailImplementationPreflight(),
        xctestDevicesStorageGateReady: Bool = true,
        xctestDevicesStorageCanResume: Bool = false,
        appHostVisualQAResumeReady: Bool = false,
        manualArtReviewAccepted: Bool = false,
        snapshotReviewAccepted: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.implementationPreflight = implementationPreflight
        self.xctestDevicesStorageGateReady = xctestDevicesStorageGateReady
        self.xctestDevicesStorageCanResume = xctestDevicesStorageCanResume
        self.appHostVisualQAResumeReady = appHostVisualQAResumeReady
        self.manualArtReviewAccepted = manualArtReviewAccepted
        self.snapshotReviewAccepted = snapshotReviewAccepted
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canResumeVisibleWork: Bool {
        implementationPreflight.canOpenImplementation
            && xctestDevicesStorageGateReady
            && xctestDevicesStorageCanResume
            && appHostVisualQAResumeReady
            && manualArtReviewAccepted
            && snapshotReviewAccepted
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        implementationPreflight.hasRequiredFields
            && xctestDevicesStorageGateReady
            && !xctestDevicesStorageCanResume
            && !appHostVisualQAResumeReady
            && !manualArtReviewAccepted
            && !snapshotReviewAccepted
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canResumeVisibleWork
    }

    public var summary: String {
        "spriteKitFishTailVisibleWorkResumeBridge=preflightReady:\(implementationPreflight.hasRequiredFields),storageGateReady:\(xctestDevicesStorageGateReady),storageCanResume:\(xctestDevicesStorageCanResume),appHostResume:\(appHostVisualQAResumeReady),manualArtReview:\(manualArtReviewAccepted),snapshotReview:\(snapshotReviewAccepted),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),resume:\(canResumeVisibleWork)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailVisibleWorkResumeBridgeReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailPixelHandoffGate: Equatable, Sendable {
    public var visibleWorkBridge: SpriteKitFishTailVisibleWorkResumeBridge
    public var recipeIntentReady: Bool
    public var usesPartAssembler: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        visibleWorkBridge: SpriteKitFishTailVisibleWorkResumeBridge = SpriteKitFishTailVisibleWorkResumeBridge(),
        recipeIntentReady: Bool = true,
        usesPartAssembler: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.visibleWorkBridge = visibleWorkBridge
        self.recipeIntentReady = recipeIntentReady
        self.usesPartAssembler = usesPartAssembler
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canHandoffToPixels: Bool {
        visibleWorkBridge.canResumeVisibleWork
            && recipeIntentReady
            && usesPartAssembler
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        visibleWorkBridge.hasRequiredFields
            && recipeIntentReady
            && !usesPartAssembler
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canHandoffToPixels
    }

    public var summary: String {
        "spriteKitFishTailPixelHandoffGate=bridgeReady:\(visibleWorkBridge.hasRequiredFields),recipeIntent:\(recipeIntentReady),partAssembler:\(usesPartAssembler),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),handoff:\(canHandoffToPixels)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailPixelHandoffGateReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailPixelHandoffQALabel: Equatable, Sendable {
    public var handoffGate: SpriteKitFishTailPixelHandoffGate
    public var hiddenLabel: String
    public var hiddenQAMetadataReady: Bool
    public var exposesPlayerFacingLabel: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        handoffGate: SpriteKitFishTailPixelHandoffGate = SpriteKitFishTailPixelHandoffGate(),
        hiddenLabel: String = "spriteKitFishTailPixelHandoffGate",
        hiddenQAMetadataReady: Bool = true,
        exposesPlayerFacingLabel: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.handoffGate = handoffGate
        self.hiddenLabel = hiddenLabel
        self.hiddenQAMetadataReady = hiddenQAMetadataReady
        self.exposesPlayerFacingLabel = exposesPlayerFacingLabel
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canConfirmPixelHandoff: Bool {
        handoffGate.canHandoffToPixels
            && !hiddenLabel.isEmpty
            && hiddenQAMetadataReady
            && !exposesPlayerFacingLabel
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        handoffGate.hasRequiredFields
            && !hiddenLabel.isEmpty
            && hiddenQAMetadataReady
            && !exposesPlayerFacingLabel
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canConfirmPixelHandoff
    }

    public var summary: String {
        "spriteKitFishTailPixelHandoffQALabel=gateReady:\(handoffGate.hasRequiredFields),label:\(hiddenLabel),hiddenQA:\(hiddenQAMetadataReady),playerLabel:\(exposesPlayerFacingLabel),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),confirm:\(canConfirmPixelHandoff)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailPixelHandoffQALabelReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailPartAssemblerEditPlan: Equatable, Sendable {
    public var qaLabel: SpriteKitFishTailPixelHandoffQALabel
    public var targetFile: String
    public var targetLayer: String
    public var baseRecipe: String
    public var accessoryRecipe: String
    public var placement: String
    public var hiddenQALabel: String
    public var keepsMotionRoom: Bool
    public var touchesPartAssembler: Bool
    public var touchesRenderProfile: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        qaLabel: SpriteKitFishTailPixelHandoffQALabel = SpriteKitFishTailPixelHandoffQALabel(),
        targetFile: String = "PartAssembler.swift",
        targetLayer: String = "tail",
        baseRecipe: String = "fishTaper",
        accessoryRecipe: String = "softForkFin",
        placement: String = "tailTip",
        hiddenQALabel: String = "spriteKitFishTailPixelHandoffGate",
        keepsMotionRoom: Bool = true,
        touchesPartAssembler: Bool = false,
        touchesRenderProfile: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.qaLabel = qaLabel
        self.targetFile = targetFile
        self.targetLayer = targetLayer
        self.baseRecipe = baseRecipe
        self.accessoryRecipe = accessoryRecipe
        self.placement = placement
        self.hiddenQALabel = hiddenQALabel
        self.keepsMotionRoom = keepsMotionRoom
        self.touchesPartAssembler = touchesPartAssembler
        self.touchesRenderProfile = touchesRenderProfile
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canBeginPixelEdit: Bool {
        qaLabel.canConfirmPixelHandoff
            && targetFile == "PartAssembler.swift"
            && targetLayer == "tail"
            && baseRecipe == "fishTaper"
            && accessoryRecipe == "softForkFin"
            && placement == "tailTip"
            && hiddenQALabel == qaLabel.hiddenLabel
            && keepsMotionRoom
            && touchesPartAssembler
            && !touchesRenderProfile
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        qaLabel.hasRequiredFields
            && targetFile == "PartAssembler.swift"
            && targetLayer == "tail"
            && baseRecipe == "fishTaper"
            && accessoryRecipe == "softForkFin"
            && placement == "tailTip"
            && hiddenQALabel == qaLabel.hiddenLabel
            && keepsMotionRoom
            && !touchesPartAssembler
            && !touchesRenderProfile
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canBeginPixelEdit
    }

    public var summary: String {
        "spriteKitFishTailPartAssemblerEditPlan=qaReady:\(qaLabel.hasRequiredFields),file:\(targetFile),layer:\(targetLayer),base:\(baseRecipe),accessory:\(accessoryRecipe),placement:\(placement),hiddenLabel:\(hiddenQALabel),motionRoom:\(keepsMotionRoom),partAssembler:\(touchesPartAssembler),renderProfile:\(touchesRenderProfile),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),begin:\(canBeginPixelEdit)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailPartAssemblerEditPlanReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailGeometryRecipe: Equatable, Sendable {
    public var editPlan: SpriteKitFishTailPartAssemblerEditPlan
    public var tailLength: Double
    public var rootWidth: Double
    public var tipWidth: Double
    public var forkSpread: Double
    public var forkDepth: Double
    public var cornerRadius: Double
    public var keepsRoundedTip: Bool
    public var keepsShallowFork: Bool
    public var keepsMotionRoom: Bool
    public var generatedPath: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        editPlan: SpriteKitFishTailPartAssemblerEditPlan = SpriteKitFishTailPartAssemblerEditPlan(),
        tailLength: Double = 28,
        rootWidth: Double = 16,
        tipWidth: Double = 9,
        forkSpread: Double = 12,
        forkDepth: Double = 6,
        cornerRadius: Double = 5,
        keepsRoundedTip: Bool = true,
        keepsShallowFork: Bool = true,
        keepsMotionRoom: Bool = true,
        generatedPath: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.editPlan = editPlan
        self.tailLength = tailLength
        self.rootWidth = rootWidth
        self.tipWidth = tipWidth
        self.forkSpread = forkSpread
        self.forkDepth = forkDepth
        self.cornerRadius = cornerRadius
        self.keepsRoundedTip = keepsRoundedTip
        self.keepsShallowFork = keepsShallowFork
        self.keepsMotionRoom = keepsMotionRoom
        self.generatedPath = generatedPath
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasSoftProportions: Bool {
        (24...34).contains(tailLength)
            && (12...20).contains(rootWidth)
            && (7...12).contains(tipWidth)
            && (8...16).contains(forkSpread)
            && (4...8).contains(forkDepth)
            && (3...7).contains(cornerRadius)
            && rootWidth > tipWidth
            && forkDepth < tailLength * 0.35
    }

    public var canApplyToPartAssembler: Bool {
        editPlan.canBeginPixelEdit
            && hasSoftProportions
            && keepsRoundedTip
            && keepsShallowFork
            && keepsMotionRoom
            && !generatedPath
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        editPlan.hasRequiredFields
            && hasSoftProportions
            && keepsRoundedTip
            && keepsShallowFork
            && keepsMotionRoom
            && !generatedPath
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canApplyToPartAssembler
    }

    public var summary: String {
        "spriteKitFishTailGeometryRecipe=planReady:\(editPlan.hasRequiredFields),length:\(tailLength),rootWidth:\(rootWidth),tipWidth:\(tipWidth),forkSpread:\(forkSpread),forkDepth:\(forkDepth),cornerRadius:\(cornerRadius),softProportions:\(hasSoftProportions),roundedTip:\(keepsRoundedTip),shallowFork:\(keepsShallowFork),motionRoom:\(keepsMotionRoom),generatedPath:\(generatedPath),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),apply:\(canApplyToPartAssembler)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailGeometryRecipeReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailMotionRoomRecipe: Equatable, Sendable {
    public var geometryRecipe: SpriteKitFishTailGeometryRecipe
    public var tailMotionGeneMinimum: Double
    public var tailMotionGeneMaximum: Double
    public var swayDegrees: Double
    public var swayDuration: Double
    public var anchor: String
    public var keepsExistingSKActionTiming: Bool
    public var keepsTailRootStable: Bool
    public var allowsPhysicsSimulation: Bool
    public var changesAnimationTiming: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        geometryRecipe: SpriteKitFishTailGeometryRecipe = SpriteKitFishTailGeometryRecipe(),
        tailMotionGeneMinimum: Double = 0.35,
        tailMotionGeneMaximum: Double = 0.75,
        swayDegrees: Double = 8,
        swayDuration: Double = 1.6,
        anchor: String = "tailRoot",
        keepsExistingSKActionTiming: Bool = true,
        keepsTailRootStable: Bool = true,
        allowsPhysicsSimulation: Bool = false,
        changesAnimationTiming: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.geometryRecipe = geometryRecipe
        self.tailMotionGeneMinimum = tailMotionGeneMinimum
        self.tailMotionGeneMaximum = tailMotionGeneMaximum
        self.swayDegrees = swayDegrees
        self.swayDuration = swayDuration
        self.anchor = anchor
        self.keepsExistingSKActionTiming = keepsExistingSKActionTiming
        self.keepsTailRootStable = keepsTailRootStable
        self.allowsPhysicsSimulation = allowsPhysicsSimulation
        self.changesAnimationTiming = changesAnimationTiming
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasGentleMotionRange: Bool {
        (0.25...0.5).contains(tailMotionGeneMinimum)
            && (0.6...0.9).contains(tailMotionGeneMaximum)
            && tailMotionGeneMinimum < tailMotionGeneMaximum
            && (4...12).contains(swayDegrees)
            && (1.2...2.2).contains(swayDuration)
    }

    public var canApplyWithVisibleFishTail: Bool {
        geometryRecipe.canApplyToPartAssembler
            && hasGentleMotionRange
            && anchor == "tailRoot"
            && keepsExistingSKActionTiming
            && keepsTailRootStable
            && !allowsPhysicsSimulation
            && !changesAnimationTiming
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        geometryRecipe.hasRequiredFields
            && hasGentleMotionRange
            && anchor == "tailRoot"
            && keepsExistingSKActionTiming
            && keepsTailRootStable
            && !allowsPhysicsSimulation
            && !changesAnimationTiming
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canApplyWithVisibleFishTail
    }

    public var summary: String {
        "spriteKitFishTailMotionRoomRecipe=geometryReady:\(geometryRecipe.hasRequiredFields),tailMotionRange:\(tailMotionGeneMinimum)-\(tailMotionGeneMaximum),swayDegrees:\(swayDegrees),swayDuration:\(swayDuration),anchor:\(anchor),gentleRange:\(hasGentleMotionRange),existingTiming:\(keepsExistingSKActionTiming),tailRootStable:\(keepsTailRootStable),physics:\(allowsPhysicsSimulation),animationTiming:\(changesAnimationTiming),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),apply:\(canApplyWithVisibleFishTail)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailMotionRoomRecipeReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailPathPointRecipe: Equatable, Sendable {
    public var motionRoomRecipe: SpriteKitFishTailMotionRoomRecipe
    public var pointOrder: [String]
    public var tailRoot: String
    public var rootUpper: String
    public var forkUpper: String
    public var forkNotch: String
    public var forkLower: String
    public var rootLower: String
    public var usesRoundedQuadraticCurves: Bool
    public var closesPath: Bool
    public var keepsShallowForkNotch: Bool
    public var generatedPath: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        motionRoomRecipe: SpriteKitFishTailMotionRoomRecipe = SpriteKitFishTailMotionRoomRecipe(),
        pointOrder: [String] = ["tailRoot", "rootUpper", "forkUpper", "forkNotch", "forkLower", "rootLower"],
        tailRoot: String = "0,0",
        rootUpper: String = "0,8",
        forkUpper: String = "28,6",
        forkNotch: String = "22,0",
        forkLower: String = "28,-6",
        rootLower: String = "0,-8",
        usesRoundedQuadraticCurves: Bool = true,
        closesPath: Bool = true,
        keepsShallowForkNotch: Bool = true,
        generatedPath: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.motionRoomRecipe = motionRoomRecipe
        self.pointOrder = pointOrder
        self.tailRoot = tailRoot
        self.rootUpper = rootUpper
        self.forkUpper = forkUpper
        self.forkNotch = forkNotch
        self.forkLower = forkLower
        self.rootLower = rootLower
        self.usesRoundedQuadraticCurves = usesRoundedQuadraticCurves
        self.closesPath = closesPath
        self.keepsShallowForkNotch = keepsShallowForkNotch
        self.generatedPath = generatedPath
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasSoftPointOrder: Bool {
        pointOrder == ["tailRoot", "rootUpper", "forkUpper", "forkNotch", "forkLower", "rootLower"]
            && tailRoot == "0,0"
            && rootUpper == "0,8"
            && forkUpper == "28,6"
            && forkNotch == "22,0"
            && forkLower == "28,-6"
            && rootLower == "0,-8"
            && usesRoundedQuadraticCurves
            && closesPath
            && keepsShallowForkNotch
    }

    public var canDrawVisiblePath: Bool {
        motionRoomRecipe.canApplyWithVisibleFishTail
            && hasSoftPointOrder
            && !generatedPath
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        motionRoomRecipe.hasRequiredFields
            && hasSoftPointOrder
            && !generatedPath
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canDrawVisiblePath
    }

    public var pointsSummary: String {
        "\(tailRoot)>\(rootUpper)>\(forkUpper)>\(forkNotch)>\(forkLower)>\(rootLower)"
    }

    public var summary: String {
        "spriteKitFishTailPathPointRecipe=motionReady:\(motionRoomRecipe.hasRequiredFields),order:\(pointOrder.joined(separator: ">")),points:\(pointsSummary),roundedCurves:\(usesRoundedQuadraticCurves),closed:\(closesPath),shallowFork:\(keepsShallowForkNotch),softOrder:\(hasSoftPointOrder),generatedPath:\(generatedPath),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),draw:\(canDrawVisiblePath)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailPathPointRecipeReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailStyleRecipe: Equatable, Sendable {
    public var pathPointRecipe: SpriteKitFishTailPathPointRecipe
    public var fillStyle: String
    public var strokeStyle: String
    public var fillAlpha: Double
    public var strokeAlpha: Double
    public var lineWidth: Double
    public var zLayer: String
    public var usesExistingTailPalette: Bool
    public var keepsSecondarySilhouette: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        pathPointRecipe: SpriteKitFishTailPathPointRecipe = SpriteKitFishTailPathPointRecipe(),
        fillStyle: String = "tailFill",
        strokeStyle: String = "tailSoftRim",
        fillAlpha: Double = 0.78,
        strokeAlpha: Double = 0.42,
        lineWidth: Double = 1.2,
        zLayer: String = "tail",
        usesExistingTailPalette: Bool = true,
        keepsSecondarySilhouette: Bool = true,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.pathPointRecipe = pathPointRecipe
        self.fillStyle = fillStyle
        self.strokeStyle = strokeStyle
        self.fillAlpha = fillAlpha
        self.strokeAlpha = strokeAlpha
        self.lineWidth = lineWidth
        self.zLayer = zLayer
        self.usesExistingTailPalette = usesExistingTailPalette
        self.keepsSecondarySilhouette = keepsSecondarySilhouette
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasSoftStyle: Bool {
        fillStyle == "tailFill"
            && strokeStyle == "tailSoftRim"
            && (0.6 ... 0.9).contains(fillAlpha)
            && (0.2 ... 0.55).contains(strokeAlpha)
            && (0.8 ... 1.8).contains(lineWidth)
            && zLayer == "tail"
            && usesExistingTailPalette
            && keepsSecondarySilhouette
    }

    public var canStyleVisiblePath: Bool {
        pathPointRecipe.canDrawVisiblePath
            && hasSoftStyle
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        pathPointRecipe.hasRequiredFields
            && hasSoftStyle
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canStyleVisiblePath
    }

    public var styleSummary: String {
        "\(fillStyle)@\(fillAlpha)|\(strokeStyle)@\(strokeAlpha)|line:\(lineWidth)|layer:\(zLayer)"
    }

    public var summary: String {
        "spriteKitFishTailStyleRecipe=pathReady:\(pathPointRecipe.hasRequiredFields),style:\(styleSummary),existingPalette:\(usesExistingTailPalette),secondarySilhouette:\(keepsSecondarySilhouette),softStyle:\(hasSoftStyle),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),styleVisible:\(canStyleVisiblePath)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailStyleRecipeReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationBundle: Equatable, Sendable {
    public var styleRecipe: SpriteKitFishTailStyleRecipe
    public var targetFile: String
    public var renderer: String
    public var changeScope: String
    public var requiresManualArtReview: Bool
    public var requiresAppHostVisualQA: Bool
    public var keepsSinglePartAssemblerEdit: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        styleRecipe: SpriteKitFishTailStyleRecipe = SpriteKitFishTailStyleRecipe(),
        targetFile: String = "PartAssembler.swift",
        renderer: String = "SpriteKit",
        changeScope: String = "fishTailOnly",
        requiresManualArtReview: Bool = true,
        requiresAppHostVisualQA: Bool = true,
        keepsSinglePartAssemblerEdit: Bool = true,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.styleRecipe = styleRecipe
        self.targetFile = targetFile
        self.renderer = renderer
        self.changeScope = changeScope
        self.requiresManualArtReview = requiresManualArtReview
        self.requiresAppHostVisualQA = requiresAppHostVisualQA
        self.keepsSinglePartAssemblerEdit = keepsSinglePartAssemblerEdit
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasNarrowTarget: Bool {
        targetFile == "PartAssembler.swift"
            && renderer == "SpriteKit"
            && changeScope == "fishTailOnly"
            && requiresManualArtReview
            && requiresAppHostVisualQA
            && keepsSinglePartAssemblerEdit
    }

    public var canOpenVisibleImplementation: Bool {
        styleRecipe.canStyleVisiblePath
            && hasNarrowTarget
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        styleRecipe.hasRequiredFields
            && hasNarrowTarget
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canOpenVisibleImplementation
    }

    public var handoffSummary: String {
        "\(targetFile)|\(renderer)|\(changeScope)"
    }

    public var summary: String {
        "spriteKitFishTailImplementationBundle=styleReady:\(styleRecipe.hasRequiredFields),handoff:\(handoffSummary),manualArtReview:\(requiresManualArtReview),appHostVisualQA:\(requiresAppHostVisualQA),singlePartAssemblerEdit:\(keepsSinglePartAssemblerEdit),narrowTarget:\(hasNarrowTarget),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),openVisibleImplementation:\(canOpenVisibleImplementation)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationBundleReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationBundleQALabel: Equatable, Sendable {
    public var bundle: SpriteKitFishTailImplementationBundle
    public var hiddenLabel: String
    public var hiddenQAMetadataReady: Bool
    public var exposesPlayerFacingLabel: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        bundle: SpriteKitFishTailImplementationBundle = SpriteKitFishTailImplementationBundle(),
        hiddenLabel: String = "spriteKitFishTailImplementationBundle",
        hiddenQAMetadataReady: Bool = true,
        exposesPlayerFacingLabel: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.bundle = bundle
        self.hiddenLabel = hiddenLabel
        self.hiddenQAMetadataReady = hiddenQAMetadataReady
        self.exposesPlayerFacingLabel = exposesPlayerFacingLabel
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasHiddenQAContract: Bool {
        hiddenLabel == "spriteKitFishTailImplementationBundle"
            && hiddenQAMetadataReady
            && !exposesPlayerFacingLabel
            && !playerFacing
    }

    public var canConfirmVisibleImplementation: Bool {
        bundle.canOpenVisibleImplementation
            && hasHiddenQAContract
            && updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
    }

    public var hasRequiredFields: Bool {
        bundle.hasRequiredFields
            && hasHiddenQAContract
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !canConfirmVisibleImplementation
    }

    public var summary: String {
        "spriteKitFishTailImplementationBundleQALabel=label:\(hiddenLabel),bundleReady:\(bundle.hasRequiredFields),hiddenMetadata:\(hiddenQAMetadataReady),playerLabel:\(exposesPlayerFacingLabel),hiddenContract:\(hasHiddenQAContract),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),confirmVisible:\(canConfirmVisibleImplementation)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationBundleQALabelReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationBundleQASurfaceGate: Equatable, Sendable {
    public var qaLabel: SpriteKitFishTailImplementationBundleQALabel
    public var qaHostName: String
    public var hiddenAccessibilityIdentifier: String
    public var requiresAppHostVisualQAResume: Bool
    public var appHostVisualQAResumeReady: Bool
    public var updatesQAHostHiddenLabels: Bool
    public var updatesSnapshotReference: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        qaLabel: SpriteKitFishTailImplementationBundleQALabel = SpriteKitFishTailImplementationBundleQALabel(),
        qaHostName: String = "GenomeVariationQAView",
        hiddenAccessibilityIdentifier: String = "spriteKitFishTailImplementationBundle",
        requiresAppHostVisualQAResume: Bool = true,
        appHostVisualQAResumeReady: Bool = false,
        updatesQAHostHiddenLabels: Bool = false,
        updatesSnapshotReference: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.qaLabel = qaLabel
        self.qaHostName = qaHostName
        self.hiddenAccessibilityIdentifier = hiddenAccessibilityIdentifier
        self.requiresAppHostVisualQAResume = requiresAppHostVisualQAResume
        self.appHostVisualQAResumeReady = appHostVisualQAResumeReady
        self.updatesQAHostHiddenLabels = updatesQAHostHiddenLabels
        self.updatesSnapshotReference = updatesSnapshotReference
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasQASurfaceTarget: Bool {
        qaHostName == "GenomeVariationQAView"
            && hiddenAccessibilityIdentifier == "spriteKitFishTailImplementationBundle"
            && requiresAppHostVisualQAResume
    }

    public var canExposeHiddenLabelInQAHost: Bool {
        qaLabel.hasRequiredFields
            && hasQASurfaceTarget
            && appHostVisualQAResumeReady
            && updatesQAHostHiddenLabels
            && updatesSnapshotReference
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        qaLabel.hasRequiredFields
            && hasQASurfaceTarget
            && !appHostVisualQAResumeReady
            && !updatesQAHostHiddenLabels
            && !updatesSnapshotReference
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canExposeHiddenLabelInQAHost
    }

    public var summary: String {
        "spriteKitFishTailImplementationBundleQASurfaceGate=labelReady:\(qaLabel.hasRequiredFields),host:\(qaHostName),identifier:\(hiddenAccessibilityIdentifier),requiresAppHostResume:\(requiresAppHostVisualQAResume),appHostResume:\(appHostVisualQAResumeReady),qaHiddenLabels:\(updatesQAHostHiddenLabels),snapshotReference:\(updatesSnapshotReference),surfaceTarget:\(hasQASurfaceTarget),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),expose:\(canExposeHiddenLabelInQAHost)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationBundleQASurfaceGateReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationBundleQASurfacePatchPlan: Equatable, Sendable {
    public var surfaceGate: SpriteKitFishTailImplementationBundleQASurfaceGate
    public var targetFile: String
    public var hiddenLabelIdentifier: String
    public var semanticSnapshotReference: String
    public var keepsHiddenOnly: Bool
    public var updatesQAHostFile: Bool
    public var updatesSnapshotReference: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        surfaceGate: SpriteKitFishTailImplementationBundleQASurfaceGate = SpriteKitFishTailImplementationBundleQASurfaceGate(),
        targetFile: String = "GenomeVariationQAView.swift",
        hiddenLabelIdentifier: String = "spriteKitFishTailImplementationBundle",
        semanticSnapshotReference: String = "SnapshotHostGenomeVariationTests.lines",
        keepsHiddenOnly: Bool = true,
        updatesQAHostFile: Bool = false,
        updatesSnapshotReference: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.surfaceGate = surfaceGate
        self.targetFile = targetFile
        self.hiddenLabelIdentifier = hiddenLabelIdentifier
        self.semanticSnapshotReference = semanticSnapshotReference
        self.keepsHiddenOnly = keepsHiddenOnly
        self.updatesQAHostFile = updatesQAHostFile
        self.updatesSnapshotReference = updatesSnapshotReference
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var hasPatchTarget: Bool {
        targetFile == "GenomeVariationQAView.swift"
            && hiddenLabelIdentifier == "spriteKitFishTailImplementationBundle"
            && semanticSnapshotReference == "SnapshotHostGenomeVariationTests.lines"
            && keepsHiddenOnly
    }

    public var canApplyHiddenQASurfacePatch: Bool {
        surfaceGate.canExposeHiddenLabelInQAHost
            && hasPatchTarget
            && updatesQAHostFile
            && updatesSnapshotReference
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var hasRequiredFields: Bool {
        surfaceGate.hasRequiredFields
            && hasPatchTarget
            && !updatesQAHostFile
            && !updatesSnapshotReference
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canApplyHiddenQASurfacePatch
    }

    public var summary: String {
        "spriteKitFishTailImplementationBundleQASurfacePatchPlan=gateReady:\(surfaceGate.hasRequiredFields),target:\(targetFile),identifier:\(hiddenLabelIdentifier),snapshot:\(semanticSnapshotReference),hiddenOnly:\(keepsHiddenOnly),patchTarget:\(hasPatchTarget),qaHostFile:\(updatesQAHostFile),snapshotReference:\(updatesSnapshotReference),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),apply:\(canApplyHiddenQASurfacePatch)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationBundleQASurfacePatchPlanReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitFishTailImplementationReadinessLedger: Equatable, Sendable {
    public var implementationBundle: SpriteKitFishTailImplementationBundle
    public var qaLabel: SpriteKitFishTailImplementationBundleQALabel
    public var qaSurfaceGate: SpriteKitFishTailImplementationBundleQASurfaceGate
    public var qaSurfacePatchPlan: SpriteKitFishTailImplementationBundleQASurfacePatchPlan
    public var appHostVisualQAResumeReady: Bool
    public var visiblePixelsApplied: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        implementationBundle: SpriteKitFishTailImplementationBundle = SpriteKitFishTailImplementationBundle(),
        qaLabel: SpriteKitFishTailImplementationBundleQALabel = SpriteKitFishTailImplementationBundleQALabel(),
        qaSurfaceGate: SpriteKitFishTailImplementationBundleQASurfaceGate = SpriteKitFishTailImplementationBundleQASurfaceGate(),
        qaSurfacePatchPlan: SpriteKitFishTailImplementationBundleQASurfacePatchPlan = SpriteKitFishTailImplementationBundleQASurfacePatchPlan(),
        appHostVisualQAResumeReady: Bool = false,
        visiblePixelsApplied: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.implementationBundle = implementationBundle
        self.qaLabel = qaLabel
        self.qaSurfaceGate = qaSurfaceGate
        self.qaSurfacePatchPlan = qaSurfacePatchPlan
        self.appHostVisualQAResumeReady = appHostVisualQAResumeReady
        self.visiblePixelsApplied = visiblePixelsApplied
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var readyMilestones: [String] {
        var milestones: [String] = []
        if implementationBundle.hasRequiredFields { milestones.append("bundle") }
        if qaLabel.hasRequiredFields { milestones.append("hiddenLabel") }
        if qaSurfaceGate.hasRequiredFields { milestones.append("qaSurfaceGate") }
        if qaSurfacePatchPlan.hasRequiredFields { milestones.append("qaSurfacePatchPlan") }
        return milestones
    }

    public var blockedMilestones: [String] {
        var milestones: [String] = []
        if !appHostVisualQAResumeReady { milestones.append("appHostVisualQA") }
        if !qaSurfaceGate.canExposeHiddenLabelInQAHost { milestones.append("hiddenQASurfaceExposure") }
        if !qaSurfacePatchPlan.canApplyHiddenQASurfacePatch { milestones.append("qaSurfacePatch") }
        if !implementationBundle.canOpenVisibleImplementation { milestones.append("visibleFishTailPixels") }
        return milestones
    }

    public var nextSafeAction: String {
        appHostVisualQAResumeReady ? "exposeHiddenQASurface" : "waitForAppHostVisualQAResume"
    }

    public var hasRequiredFields: Bool {
        implementationBundle.hasRequiredFields
            && qaLabel.hasRequiredFields
            && qaSurfaceGate.hasRequiredFields
            && qaSurfacePatchPlan.hasRequiredFields
            && !appHostVisualQAResumeReady
            && !visiblePixelsApplied
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && nextSafeAction == "waitForAppHostVisualQAResume"
    }

    public var summary: String {
        "spriteKitFishTailImplementationReadinessLedger=ready:\(readyMilestones.joined(separator: "+")),blocked:\(blockedMilestones.joined(separator: "+")),next:\(nextSafeAction),appHostResume:\(appHostVisualQAResumeReady),visiblePixels:\(visiblePixelsApplied),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing)"
    }

    public var readinessSummary: String {
        "spriteKitFishTailImplementationReadinessLedgerReady:\(hasRequiredFields)"
    }
}

public struct SpriteKitVisibleQAEnvironmentLedger: Equatable, Sendable {
    public var implementationReadinessLedger: SpriteKitFishTailImplementationReadinessLedger
    public var storageResumeReady: Bool
    public var sourceControlProcessesQuiet: Bool
    public var xcodebuildProcessesQuiet: Bool
    public var appHostVisualQAResumeReady: Bool
    public var xcodeDeveloperPathResolved: Bool
    public var xcodebuildAvailable: Bool
    public var simctlAvailable: Bool
    public var simulatorLaunchAvailable: Bool
    public var updatesHiddenQASurface: Bool
    public var updatesSpriteKitPixels: Bool
    public var updatesImageReference: Bool
    public var allowsPersistenceWrite: Bool
    public var publishesWidgetHandoff: Bool
    public var changesPackageOrProject: Bool
    public var generatedAssets: Bool
    public var assetOutputs: String
    public var playerFacing: Bool

    public init(
        implementationReadinessLedger: SpriteKitFishTailImplementationReadinessLedger = SpriteKitFishTailImplementationReadinessLedger(),
        storageResumeReady: Bool = true,
        sourceControlProcessesQuiet: Bool = true,
        xcodebuildProcessesQuiet: Bool = false,
        appHostVisualQAResumeReady: Bool = false,
        xcodeDeveloperPathResolved: Bool = true,
        xcodebuildAvailable: Bool = true,
        simctlAvailable: Bool = true,
        simulatorLaunchAvailable: Bool = false,
        updatesHiddenQASurface: Bool = false,
        updatesSpriteKitPixels: Bool = false,
        updatesImageReference: Bool = false,
        allowsPersistenceWrite: Bool = false,
        publishesWidgetHandoff: Bool = false,
        changesPackageOrProject: Bool = false,
        generatedAssets: Bool = false,
        assetOutputs: String = "none",
        playerFacing: Bool = false
    ) {
        self.implementationReadinessLedger = implementationReadinessLedger
        self.storageResumeReady = storageResumeReady
        self.sourceControlProcessesQuiet = sourceControlProcessesQuiet
        self.xcodebuildProcessesQuiet = xcodebuildProcessesQuiet
        self.appHostVisualQAResumeReady = appHostVisualQAResumeReady
        self.xcodeDeveloperPathResolved = xcodeDeveloperPathResolved
        self.xcodebuildAvailable = xcodebuildAvailable
        self.simctlAvailable = simctlAvailable
        self.simulatorLaunchAvailable = simulatorLaunchAvailable
        self.updatesHiddenQASurface = updatesHiddenQASurface
        self.updatesSpriteKitPixels = updatesSpriteKitPixels
        self.updatesImageReference = updatesImageReference
        self.allowsPersistenceWrite = allowsPersistenceWrite
        self.publishesWidgetHandoff = publishesWidgetHandoff
        self.changesPackageOrProject = changesPackageOrProject
        self.generatedAssets = generatedAssets
        self.assetOutputs = assetOutputs
        self.playerFacing = playerFacing
    }

    public var canRunVisualQA: Bool {
        implementationReadinessLedger.nextSafeAction == "exposeHiddenQASurface"
            && storageResumeReady
            && sourceControlProcessesQuiet
            && xcodebuildProcessesQuiet
            && appHostVisualQAResumeReady
            && xcodeDeveloperPathResolved
            && xcodebuildAvailable
            && simctlAvailable
            && simulatorLaunchAvailable
            && !updatesHiddenQASurface
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
    }

    public var nextSafeAction: String {
        if !xcodeDeveloperPathResolved || !xcodebuildAvailable || !simctlAvailable {
            return "resolveXcodeDeveloperPath"
        }

        if !sourceControlProcessesQuiet || !xcodebuildProcessesQuiet || !appHostVisualQAResumeReady {
            return "waitForXcodebuildQuiet"
        }

        if !simulatorLaunchAvailable {
            return "launchSimulatorForHiddenQASurface"
        }

        return "runHiddenQASurfaceVisualQA"
    }

    public var hasRequiredFields: Bool {
        implementationReadinessLedger.nextSafeAction == "waitForAppHostVisualQAResume"
            && storageResumeReady
            && sourceControlProcessesQuiet
            && !xcodebuildProcessesQuiet
            && !appHostVisualQAResumeReady
            && xcodeDeveloperPathResolved
            && xcodebuildAvailable
            && simctlAvailable
            && !simulatorLaunchAvailable
            && !updatesHiddenQASurface
            && !updatesSpriteKitPixels
            && !updatesImageReference
            && !allowsPersistenceWrite
            && !publishesWidgetHandoff
            && !changesPackageOrProject
            && !generatedAssets
            && assetOutputs == "none"
            && !playerFacing
            && !canRunVisualQA
            && nextSafeAction == "waitForXcodebuildQuiet"
    }

    public var summary: String {
        "spriteKitVisibleQAEnvironmentLedger=fishTailNext:\(implementationReadinessLedger.nextSafeAction),storage:\(storageResumeReady),sourceControlQuiet:\(sourceControlProcessesQuiet),xcodebuildQuiet:\(xcodebuildProcessesQuiet),appHostResume:\(appHostVisualQAResumeReady),developerPath:\(xcodeDeveloperPathResolved),xcodebuild:\(xcodebuildAvailable),simctl:\(simctlAvailable),simulatorLaunch:\(simulatorLaunchAvailable),hiddenQASurface:\(updatesHiddenQASurface),spriteKitPixels:\(updatesSpriteKitPixels),imageReference:\(updatesImageReference),persistence:\(allowsPersistenceWrite),widget:\(publishesWidgetHandoff),packageProject:\(changesPackageOrProject),generatedAssets:\(generatedAssets),assetOutputs:\(assetOutputs),playerFacing:\(playerFacing),next:\(nextSafeAction),runVisualQA:\(canRunVisualQA)"
    }

    public var readinessSummary: String {
        "spriteKitVisibleQAEnvironmentLedgerReady:\(hasRequiredFields)"
    }
}

private extension GrowthStage {
    var discoverySummaryName: String {
        switch self {
        case .egg: "egg"
        case .baby: "baby"
        case .juvenile: "juvenile"
        case .adult: "adult"
        case .elder: "elder"
        }
    }

    var growthPreviewName: String {
        switch self {
        case .egg: "Egg"
        case .baby: "Baby"
        case .juvenile: "Juvenile"
        case .adult: "Adult"
        case .elder: "Elder"
        }
    }

    var discoveryMemoryName: String {
        switch self {
        case .egg: "Egg"
        case .baby: "Baby"
        case .juvenile: "Juvenile"
        case .adult: "Adult"
        case .elder: "Elder"
        }
    }
}

private extension DiscoveryEvent.Kind {
    var discoveryMemoryName: String {
        switch self {
        case .growth: "growth memory"
        case .newPart: "part memory"
        case .glow: "glow memory"
        case .pattern: "pattern memory"
        case .inheritedResemblance: "inherited memory"
        }
    }

    var dailyChangeCueName: String {
        switch self {
        case .growth: "change noticed"
        case .newPart: "new shape noticed"
        case .glow: "glow deepened"
        case .pattern: "pattern shifted"
        case .inheritedResemblance: "family resemblance"
        }
    }

    var isGrowthChangeMoment: Bool {
        switch self {
        case .growth, .newPart, .glow, .pattern:
            true
        case .inheritedResemblance:
            false
        }
    }
}
