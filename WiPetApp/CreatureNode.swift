import SpriteKit
import WiPetCore

final class CreatureNode: SKNode {
    private let profile: CreatureRenderProfile
    private let assembler: PartAssembler
    private let fixedPartCatalog = CreatureFixedPartCatalog.currentLuma
    private let bodyNode = SKNode()
    private let leftEye = SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
    private let rightEye = SKShapeNode(ellipseIn: CGRect(x: -7, y: -9, width: 14, height: 18))
    private var leftWingNode: SKShapeNode?
    private var rightWingNode: SKShapeNode?
    private var tailNode: SKShapeNode?
    private var glowRingNode: SKShapeNode?
    private(set) var isAssemblyPlanCatalogBacked = false
    private(set) var assemblyPlanCatalogValidationSummary = ""

    var catalogMetadataSummary: String {
        "catalogBacked:\(isAssemblyPlanCatalogBacked),\(fixedPartCatalog.artDirectionReadinessSummary),\(fixedPartCatalog.artDirectionSummary),\(fixedPartCatalog.lineageAffectionReadinessSummary),\(fixedPartCatalog.lineageAffectionSummary)"
    }

    var rendererMetadataSummary: String {
        RendererMetadataSummary.combine(
            catalogMetadataSummary: catalogMetadataSummary,
            assemblyPlanCatalogValidationSummary: assemblyPlanCatalogValidationSummary
        )
    }

    var isRendererMetadataReady: Bool {
        RendererMetadataSummary.hasPopulatedFields(
            catalogMetadataSummary: catalogMetadataSummary,
            assemblyPlanCatalogValidationSummary: assemblyPlanCatalogValidationSummary,
            rendererMetadataSummary: rendererMetadataSummary
        )
    }

    var rendererMetadataReadinessSummary: String {
        RendererMetadataSummary.readinessSummary(isReady: isRendererMetadataReady)
    }

    var genomeVisualVariationSummary: String {
        profile.genomeVisualVariationSummary
    }

    var hasGenomeVisualVariationMetadata: Bool {
        RendererMetadataSummary.hasGenomeVisualVariationFields(
            face: profile.genomeVisualVariation.face,
            body: profile.genomeVisualVariation.body,
            wing: profile.genomeVisualVariation.wing,
            tail: profile.genomeVisualVariation.tail,
            visibleTraitCount: profile.genomeVisualVariation.visibleTraitCount,
            summary: genomeVisualVariationSummary
        )
    }

    var genomeVisualVariationReadinessSummary: String {
        RendererMetadataSummary.genomeVisualVariationReadinessSummary(isReady: hasGenomeVisualVariationMetadata)
    }

    var personalityEyeCueSummary: String {
        profile.personalityEyeCueSummary
    }

    var hasPersonalityEyeCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityEyeCueFields(
            openness: profile.expression.opennessLabel,
            softness: profile.expression.softnessLabel,
            sparkle: profile.expression.sparkleLabel,
            summary: personalityEyeCueSummary
        )
    }

    var personalityEyeCueReadinessSummary: String {
        RendererMetadataSummary.personalityEyeCueReadinessSummary(isReady: hasPersonalityEyeCueMetadata)
    }

    var spriteKitSilhouetteCueSummary: String {
        profile.spriteKitSilhouetteCueSummary
    }

    var hasSpriteKitSilhouetteCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitSilhouetteCueFields(
            face: profile.silhouetteCue.face,
            body: profile.silhouetteCue.body,
            wing: profile.silhouetteCue.wing,
            tail: profile.silhouetteCue.tail,
            visibleCueCount: profile.silhouetteCue.visibleCueCount,
            summary: spriteKitSilhouetteCueSummary
        )
    }

    var spriteKitSilhouetteCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitSilhouetteCueReadinessSummary(isReady: hasSpriteKitSilhouetteCueMetadata)
    }

    var spriteKitWingCueAccentSummary: String {
        profile.spriteKitWingCueAccentSummary
    }

    var hasSpriteKitWingCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitWingCueAccentFields(
            wing: profile.wingAccent.wingCue,
            accent: profile.wingAccent.accent,
            assetOutputs: "none",
            summary: spriteKitWingCueAccentSummary
        )
    }

    var spriteKitWingCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitWingCueAccentReadinessSummary(isReady: hasSpriteKitWingCueAccentMetadata)
    }

    var spriteKitBodyCueAccentSummary: String {
        profile.spriteKitBodyCueAccentSummary
    }

    var hasSpriteKitBodyCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitBodyCueAccentFields(
            body: profile.bodyAccent.bodyCue,
            accent: profile.bodyAccent.accent,
            assetOutputs: "none",
            summary: spriteKitBodyCueAccentSummary
        )
    }

    var spriteKitBodyCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitBodyCueAccentReadinessSummary(isReady: hasSpriteKitBodyCueAccentMetadata)
    }

    var spriteKitFaceCueAccentSummary: String {
        profile.spriteKitFaceCueAccentSummary
    }

    var hasSpriteKitFaceCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitFaceCueAccentFields(
            face: profile.faceAccent.faceCue,
            accent: profile.faceAccent.accent,
            dotCount: profile.faceAccent.dotCount,
            assetOutputs: "none",
            summary: spriteKitFaceCueAccentSummary
        )
    }

    var spriteKitFaceCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitFaceCueAccentReadinessSummary(isReady: hasSpriteKitFaceCueAccentMetadata)
    }

    var nodeInspectionSummary: String {
        RendererMetadataSummary.nodeInspectionSummary(
            readinessSummary: rendererMetadataReadinessSummary,
            rendererMetadataSummary: rendererMetadataSummary
        )
    }

    var hasNodeInspectionMetadata: Bool {
        RendererMetadataSummary.hasNodeInspectionFields(
            readinessSummary: rendererMetadataReadinessSummary,
            rendererMetadataSummary: rendererMetadataSummary,
            nodeInspectionSummary: nodeInspectionSummary
        )
    }

    var nodeInspectionReadinessSummary: String {
        RendererMetadataSummary.nodeInspectionReadinessSummary(isReady: hasNodeInspectionMetadata)
    }

    var fullNodeInspectionSummary: String {
        RendererMetadataSummary.fullNodeInspectionSummary(
            readinessSummary: nodeInspectionReadinessSummary,
            nodeInspectionSummary: nodeInspectionSummary
        )
    }

    var hasFullNodeInspectionMetadata: Bool {
        RendererMetadataSummary.hasFullNodeInspectionFields(
            readinessSummary: nodeInspectionReadinessSummary,
            nodeInspectionSummary: nodeInspectionSummary,
            fullNodeInspectionSummary: fullNodeInspectionSummary
        )
    }

    var fullNodeInspectionReadinessSummary: String {
        RendererMetadataSummary.fullNodeInspectionReadinessSummary(isReady: hasFullNodeInspectionMetadata)
    }

    var inspectionDebugSummary: String {
        RendererMetadataSummary.inspectionDebugSummary(
            readinessSummary: fullNodeInspectionReadinessSummary,
            fullNodeInspectionSummary: fullNodeInspectionSummary
        )
    }

    var hasInspectionDebugMetadata: Bool {
        RendererMetadataSummary.hasInspectionDebugFields(
            readinessSummary: fullNodeInspectionReadinessSummary,
            fullNodeInspectionSummary: fullNodeInspectionSummary,
            inspectionDebugSummary: inspectionDebugSummary
        )
    }

    var inspectionDebugReadinessSummary: String {
        RendererMetadataSummary.inspectionDebugReadinessSummary(isReady: hasInspectionDebugMetadata)
    }

    var visualInspectionSummary: String {
        RendererMetadataSummary.visualInspectionSummary(
            readinessSummary: inspectionDebugReadinessSummary,
            inspectionDebugSummary: inspectionDebugSummary
        )
    }

    var hasVisualInspectionMetadata: Bool {
        RendererMetadataSummary.hasVisualInspectionFields(
            readinessSummary: inspectionDebugReadinessSummary,
            inspectionDebugSummary: inspectionDebugSummary,
            visualInspectionSummary: visualInspectionSummary
        )
    }

    var visualInspectionReadinessSummary: String {
        RendererMetadataSummary.visualInspectionReadinessSummary(isReady: hasVisualInspectionMetadata)
    }

    var qaInspectionSummary: String {
        RendererMetadataSummary.qaInspectionSummary(
            readinessSummary: visualInspectionReadinessSummary,
            visualInspectionSummary: visualInspectionSummary
        )
    }

    var hasQAInspectionMetadata: Bool {
        RendererMetadataSummary.hasQAInspectionFields(
            readinessSummary: visualInspectionReadinessSummary,
            visualInspectionSummary: visualInspectionSummary,
            qaInspectionSummary: qaInspectionSummary
        )
    }

    var qaInspectionReadinessSummary: String {
        RendererMetadataSummary.qaInspectionReadinessSummary(isReady: hasQAInspectionMetadata)
    }

    var qaInspectionSnapshotSummary: String {
        RendererMetadataSummary.qaInspectionSnapshotSummary(
            readinessSummary: qaInspectionReadinessSummary,
            qaInspectionSummary: qaInspectionSummary
        )
    }

    var hasQAInspectionSnapshotMetadata: Bool {
        RendererMetadataSummary.hasQAInspectionSnapshotFields(
            readinessSummary: qaInspectionReadinessSummary,
            qaInspectionSummary: qaInspectionSummary,
            qaInspectionSnapshotSummary: qaInspectionSnapshotSummary
        )
    }

    var qaInspectionSnapshotReadinessSummary: String {
        RendererMetadataSummary.qaInspectionSnapshotReadinessSummary(isReady: hasQAInspectionSnapshotMetadata)
    }

    var widgetInspectionSnapshotSummary: String {
        RendererMetadataSummary.widgetInspectionSnapshotSummary(
            readinessSummary: qaInspectionSnapshotReadinessSummary,
            qaInspectionSnapshotSummary: qaInspectionSnapshotSummary
        )
    }

    var hasWidgetInspectionSnapshotMetadata: Bool {
        RendererMetadataSummary.hasWidgetInspectionSnapshotFields(
            readinessSummary: qaInspectionSnapshotReadinessSummary,
            qaInspectionSnapshotSummary: qaInspectionSnapshotSummary,
            widgetInspectionSnapshotSummary: widgetInspectionSnapshotSummary
        )
    }

    var widgetInspectionSnapshotReadinessSummary: String {
        RendererMetadataSummary.widgetInspectionSnapshotReadinessSummary(isReady: hasWidgetInspectionSnapshotMetadata)
    }

    var widgetInspectionReadinessSummary: String {
        RendererMetadataSummary.widgetInspectionReadinessSummary(
            readinessSummary: widgetInspectionSnapshotReadinessSummary,
            widgetInspectionSnapshotSummary: widgetInspectionSnapshotSummary
        )
    }

    var hasWidgetInspectionMetadata: Bool {
        RendererMetadataSummary.hasWidgetInspectionFields(
            readinessSummary: widgetInspectionSnapshotReadinessSummary,
            widgetInspectionSnapshotSummary: widgetInspectionSnapshotSummary,
            widgetInspectionReadinessSummary: widgetInspectionReadinessSummary
        )
    }

    var widgetInspectionMetadataReadinessSummary: String {
        RendererMetadataSummary.widgetInspectionMetadataReadinessSummary(isReady: hasWidgetInspectionMetadata)
    }

    convenience init(creature: Creature) {
        self.init(profile: CreatureRenderProfile(creature: creature))
    }

    init(profile: CreatureRenderProfile) {
        self.profile = profile
        self.assembler = PartAssembler(profile: profile)
        super.init()
        buildLayers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func startIdleMotion() {
        let floatUp = SKAction.moveBy(x: 0, y: profile.motion.floatAmount, duration: profile.motion.floatDuration)
        floatUp.timingMode = .easeInEaseOut
        let floatDown = SKAction.moveBy(x: 0, y: -profile.motion.floatAmount, duration: profile.motion.floatDuration)
        floatDown.timingMode = .easeInEaseOut
        bodyNode.run(.repeatForever(.sequence([floatUp, floatDown])), withKey: "idleFloat")

        let breatheIn = SKAction.scaleX(by: 1, y: profile.motion.sleepinessBreathScale, duration: profile.motion.sleepinessBreathDuration)
        breatheIn.timingMode = .easeInEaseOut
        let breatheOut = SKAction.scaleX(by: 1, y: 1 / profile.motion.sleepinessBreathScale, duration: profile.motion.sleepinessBreathDuration)
        breatheOut.timingMode = .easeInEaseOut
        bodyNode.run(.repeatForever(.sequence([breatheIn, breatheOut])), withKey: "sleepinessBreath")

        let close = SKAction.scaleY(to: profile.motion.blinkClosedScale, duration: 0.08)
        let open = SKAction.scaleY(to: 1, duration: 0.12)
        let blink = SKAction.sequence([
            .wait(forDuration: profile.motion.blinkDelay),
            close,
            .wait(forDuration: profile.motion.blinkHoldDuration),
            open
        ])
        leftEye.run(.repeatForever(blink), withKey: "blink")
        rightEye.run(.repeatForever(blink), withKey: "blink")

        let swing = SKAction.sequence([
            .rotate(byAngle: profile.motion.tailSwayDegrees * .pi / 180, duration: 1.6),
            .rotate(byAngle: -profile.motion.tailSwayDegrees * 2 * .pi / 180, duration: 3.2),
            .rotate(byAngle: profile.motion.tailSwayDegrees * .pi / 180, duration: 1.6)
        ])
        tailNode?.run(.repeatForever(swing), withKey: "tailSway")

        let flutterAngle = profile.motion.wingFlutterDegrees * .pi / 180
        let leftWingFlutter = SKAction.sequence([
            .rotate(byAngle: flutterAngle, duration: profile.motion.wingFlutterDuration),
            .rotate(byAngle: -flutterAngle * 2, duration: profile.motion.wingFlutterDuration * 2),
            .rotate(byAngle: flutterAngle, duration: profile.motion.wingFlutterDuration)
        ])
        let rightWingFlutter = SKAction.sequence([
            .rotate(byAngle: -flutterAngle, duration: profile.motion.wingFlutterDuration),
            .rotate(byAngle: flutterAngle * 2, duration: profile.motion.wingFlutterDuration * 2),
            .rotate(byAngle: -flutterAngle, duration: profile.motion.wingFlutterDuration)
        ])
        leftWingNode?.run(.repeatForever(leftWingFlutter), withKey: "wingFlutter")
        rightWingNode?.run(.repeatForever(rightWingFlutter), withKey: "wingFlutter")

        let glowPulse = SKAction.sequence([
            .scale(to: profile.glowPulseScale, duration: profile.glowPulseDuration),
            .scale(to: 1, duration: profile.glowPulseDuration)
        ])
        glowRingNode?.run(.repeatForever(glowPulse), withKey: "glowPulse")
    }

    private func buildLayers() {
        addChild(bodyNode)
        bodyNode.setScale(profile.growthStageCue.bodyScale)
        bodyNode.zRotation = profile.personalityPosture.rotationDegrees * .pi / 180
        bodyNode.addChild(assembler.shadowNode())
        let plan = assembler.assemblyPlan(leftEye: leftEye, rightEye: rightEye)
        isAssemblyPlanCatalogBacked = plan.isFullyCatalogBacked(in: fixedPartCatalog)
        assemblyPlanCatalogValidationSummary = plan.catalogValidationSummary(in: fixedPartCatalog)
        addVisibleParts(from: plan)
        let glowRing = assembler.glowRingNode()
        glowRingNode = glowRing
        bodyNode.addChild(glowRing)
    }

    private func addVisibleParts(from plan: CreatureAssemblyPlan) {
        for item in plan.visibleParts {
            switch item {
            case .wing(let input):
                let node = assembler.wingNode(input)
                retainMotionNodeIfNeeded(node, for: item.layerID)
                bodyNode.addChild(node)
            case .tail(let input):
                let node = assembler.tailNode(input)
                retainMotionNodeIfNeeded(node, for: item.layerID)
                bodyNode.addChild(node)
            case .body(let input):
                bodyNode.addChild(assembler.bodyNode(input))
            case .head(let input):
                bodyNode.addChild(assembler.headNode(input))
            case .eye(let input):
                bodyNode.addChild(assembler.eyeNode(input))
            case .mouth(let input):
                bodyNode.addChild(assembler.mouthNode(input))
            }
        }
    }

    private func retainMotionNodeIfNeeded(_ node: SKShapeNode, for layerID: CreatureLayerID) {
        if layerID == .tail {
            tailNode = node
        } else if layerID == .leftWing {
            leftWingNode = node
        } else if layerID == .rightWing {
            rightWingNode = node
        }
    }
}
