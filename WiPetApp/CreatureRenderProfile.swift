import SpriteKit
import WiPetCore

struct CreatureRenderProfile {
    struct Palette {
        var body: SKColor
        var head: SKColor
        var eye: SKColor
        var mouth: SKColor
        var leftWing: SKColor
        var rightWing: SKColor
        var tail: SKColor
        var tailStroke: SKColor
        var glow: SKColor
        var shadow: SKColor
    }

    struct Motion {
        var floatAmount: CGFloat
        var floatDuration: TimeInterval
        var blinkDelay: TimeInterval
        var blinkClosedScale: CGFloat
        var blinkHoldDuration: TimeInterval
        var sleepinessBreathScale: CGFloat
        var sleepinessBreathDuration: TimeInterval
        var tailSwayDegrees: CGFloat
        var wingFlutterDegrees: CGFloat
        var wingFlutterDuration: TimeInterval
        var floatLabel: String
        var blinkLabel: String
        var blinkStyleLabel: String
        var blinkDepthLabel: String
        var blinkHoldLabel: String
        var sleepinessStyleLabel: String
        var sleepinessBreathLabel: String
        var sleepinessPaceLabel: String
        var tailLabel: String
        var wingLabel: String

        var summary: String {
            RendererMetadataSummary.spriteKitMotionGeneCueSummary(
                float: floatLabel,
                blink: blinkLabel,
                tail: tailLabel,
                wing: wingLabel,
                wingFlutter: "\(wingFlutterDegrees)deg/\(wingFlutterDuration)s",
                assetOutputs: "none"
            )
        }

        var blinkSummary: String {
            RendererMetadataSummary.personalityBlinkCueSummary(
                style: blinkStyleLabel,
                depth: blinkDepthLabel,
                hold: blinkHoldLabel,
                assetOutputs: "none"
            )
        }

        var sleepinessSummary: String {
            RendererMetadataSummary.personalitySleepinessIdleCueSummary(
                style: sleepinessStyleLabel,
                breath: sleepinessBreathLabel,
                pace: sleepinessPaceLabel,
                assetOutputs: "none"
            )
        }
    }

    struct Silhouette {
        var bodyRect: CGRect
        var bodyAccent: BodyAccent
        var headRect: CGRect
        var faceAccent: FaceAccent
        var faceLineageEcho: FaceLineageEcho
        var wingXScale: CGFloat
        var wingYScale: CGFloat
        var wingRotationAdjustmentDegrees: CGFloat
        var wingAccent: WingAccent
        var wingSilhouetteAccessory: WingSilhouetteAccessory
        var tailRect: CGRect
        var tailRotationDegrees: CGFloat
        var tailAccent: TailAccent
        var tailSilhouetteAccessory: TailSilhouetteAccessory
        var tailLineageEcho: TailLineageEcho
        var mouthWidth: CGFloat
    }

    struct BodyAccent {
        let kind: BodyAccentKind
        let bodyCue: String
        let accent: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitBodyCueAccentSummary(
                body: bodyCue,
                accent: accent,
                socketChanged: false,
                assetOutputs: "none"
            )
        }
    }

    enum BodyAccentKind {
        case bellyDrop
        case petalChest
        case softFacet
        case crescentBelly
        case sproutBelly
    }

    struct BodyProportionCue {
        let bodyCue: String
        let widthLabel: String
        let heightLabel: String
        let affectionLabel: String

        var summary: String {
            RendererMetadataSummary.spriteKitBodyProportionCueSummary(
                body: bodyCue,
                width: widthLabel,
                height: heightLabel,
                affection: affectionLabel,
                geometryGenerated: false,
                assetOutputs: "none"
            )
        }
    }

    struct BodySilhouetteAccessory {
        let accessory: BodySilhouetteAccessoryKind
        let bodyCue: String
        let accessoryCue: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueSummary(
                body: bodyCue,
                accessory: accessoryCue,
                visibleInPortrait: true,
                geometryGenerated: false,
                assetOutputs: "none"
            )
        }
    }

    enum BodySilhouetteAccessoryKind {
        case none
        case softShoulderPetals
        case softMoonShoulderCrescents
        case leafShoulderNubs
    }

    struct FaceAccent {
        let kind: FaceAccentKind
        let faceCue: String
        let accent: String
        let dotCount: Int
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitFaceCueAccentSummary(
                face: faceCue,
                accent: accent,
                dotCount: dotCount,
                socketChanged: false,
                assetOutputs: "none"
            )
        }
    }

    enum FaceAccentKind {
        case softCheek
        case cheekGleam
        case muzzleGlow
        case sideCheekDots
        case softFacet
        case forestDots
        case kittenGleam
    }

    struct FaceSilhouetteAccessory {
        let accessory: FaceSilhouetteAccessoryKind
        let faceCue: String
        let accessoryCue: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueSummary(
                face: faceCue,
                accessory: accessoryCue,
                visibleInPortrait: true,
                geometryGenerated: false,
                assetOutputs: "none"
            )
        }
    }

    enum FaceSilhouetteAccessoryKind {
        case none
        case softEarNubs
        case softEarTips
    }

    struct FaceLineageEcho {
        let isActive: Bool
        let cueLabel: String
        let faceCueLabel: String
        let placementLabel: String
        let dotCount: Int
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitFaceLineageEchoCueSummary(
                cue: cueLabel,
                face: faceCueLabel,
                placement: placementLabel,
                dotCount: dotCount,
                ancestryLinked: isActive,
                active: isActive,
                assetOutputs: "none"
            )
        }
    }

    struct WingAccent {
        let kind: WingAccentKind
        let wingCue: String
        let accent: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitWingCueAccentSummary(
                wing: wingCue,
                accent: accent,
                socketChanged: false,
                assetOutputs: "none"
            )
        }
    }

    enum WingAccentKind {
        case none
        case softVein
        case softRim
        case facetDot
        case bellDot
    }

    struct WingSilhouetteAccessory {
        let accessory: WingSilhouetteAccessoryKind
        let wingCue: String
        let accessoryCue: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueSummary(
                wing: wingCue,
                accessory: accessoryCue,
                visibleInPortrait: true,
                geometryGenerated: false,
                assetOutputs: "none"
            )
        }
    }

    enum WingSilhouetteAccessoryKind {
        case none
        case softWingTipPearl
        case softWingTipClaw
    }

    struct WingLineageEcho {
        let isActive: Bool
        let cueLabel: String
        let wingCueLabel: String
        let accessoryCueLabel: String
        let placementLabel: String

        var summary: String {
            RendererMetadataSummary.spriteKitWingLineageEchoCueSummary(
                cue: cueLabel,
                wing: wingCueLabel,
                accessory: accessoryCueLabel,
                placement: placementLabel,
                ancestryLinked: isActive,
                active: isActive,
                assetOutputs: "none"
            )
        }
    }

    struct TailAccent {
        let kind: TailAccentKind
        let color: SKColor
        let alpha: CGFloat
    }

    enum TailAccentKind {
        case roundedCap
        case floatingOrb
        case fishFin
        case leafBud
    }

    struct TailSilhouetteAccessory {
        let accessory: TailSilhouetteAccessoryKind
        let tailCue: String
        let accessoryCue: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueSummary(
                tail: tailCue,
                accessory: accessoryCue,
                visibleInPortrait: true,
                geometryGenerated: false,
                assetOutputs: "none"
            )
        }
    }

    enum TailSilhouetteAccessoryKind {
        case none
        case softForkFin
        case softTetherDot
        case softDrakeRidge
        case softLeafVein
    }

    struct TailLineageEcho {
        let isActive: Bool
        let cueLabel: String
        let tailCueLabel: String
        let placementLabel: String
        let dotCount: Int
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitTailLineageEchoCueSummary(
                cue: cueLabel,
                tail: tailCueLabel,
                placement: placementLabel,
                dotCount: dotCount,
                ancestryLinked: isActive,
                active: isActive,
                assetOutputs: "none"
            )
        }
    }

    struct AncestralGlint {
        let isActive: Bool
        let cueLabel: String
        let placementLabel: String
        let glintCount: Int
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitAncestralGlintCueSummary(
                cue: cueLabel,
                placement: placementLabel,
                glintCount: glintCount,
                ancestryLinked: isActive,
                active: isActive,
                assetOutputs: "none"
            )
        }
    }

    struct LineageMemoryThread {
        let isActive: Bool
        let cueLabel: String
        let bodyCueLabel: String
        let tailCueLabel: String
        let placementLabel: String
        let color: SKColor
        let alpha: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitLineageMemoryThreadSummary(
                cue: cueLabel,
                bodyCue: bodyCueLabel,
                tailCue: tailCueLabel,
                placement: placementLabel,
                ancestryLinked: isActive,
                active: isActive,
                assetOutputs: "none"
            )
        }
    }

    struct GlowAura {
        let outerScale: CGFloat
        let outerLineWidth: CGFloat
        let outerGlowWidth: CGFloat
        let outerAlpha: CGFloat
        let moteCount: Int
        let moteAlpha: CGFloat
        let moteScale: CGFloat
        let moteOffset: CGPoint
        let glowLabel: String
        let auraLabel: String
        let pulseLabel: String
        let motePlacementLabel: String
        let mysticismLabel: String
        let mysticismHaloLabel: String

        var summary: String {
            RendererMetadataSummary.spriteKitGlowAuraCueSummary(
                glow: glowLabel,
                aura: auraLabel,
                pulse: pulseLabel,
                motes: motePlacementLabel,
                assetOutputs: "none"
            )
        }

        var mysticismSummary: String {
            RendererMetadataSummary.personalityMysticismAuraCueSummary(
                mysticism: mysticismLabel,
                halo: mysticismHaloLabel,
                assetOutputs: "none"
            )
        }
    }

    struct PatternMarking {
        let markLabel: String
        let placementLabel: String
        let color: SKColor
        let alpha: CGFloat
        let visibleSpotCount: Int
        let spotScale: CGFloat
        let spotSpread: CGFloat
        let spreadLabel: String

        var summary: String {
            RendererMetadataSummary.spriteKitPatternMarkingCueSummary(
                gene: "contrast",
                mark: markLabel,
                placement: placementLabel,
                spread: spreadLabel,
                assetOutputs: "none"
            )
        }
    }

    struct GrowthStageCue {
        let stageLabel: String
        let scaleLabel: String
        let postureLabel: String
        let bodyScale: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitGrowthStageCueSummary(
                stage: stageLabel,
                scale: scaleLabel,
                posture: postureLabel,
                assetOutputs: "none"
            )
        }
    }

    struct GrowthHornBudCue {
        let geneLabel: String
        let budLabel: String
        let stageLabel: String
        let softnessLabel: String
        let visibleInPortrait: Bool
        let budScale: CGFloat
        let fillColor: SKColor
        let strokeColor: SKColor
        let glowWidth: CGFloat

        var summary: String {
            RendererMetadataSummary.spriteKitGrowthHornBudCueSummary(
                gene: geneLabel,
                bud: budLabel,
                stage: stageLabel,
                softness: softnessLabel,
                visibleInPortrait: visibleInPortrait,
                assetOutputs: "none"
            )
        }
    }

    struct GrowthTailTipCue {
        let geneLabel: String
        let cueLabel: String
        let tailLabel: String
        let placementLabel: String
        let visibleInPortrait: Bool
        let glintSize: CGFloat
        let glintAlpha: CGFloat
        let glowWidth: CGFloat
        let color: SKColor

        var summary: String {
            RendererMetadataSummary.spriteKitGrowthTailTipCueSummary(
                gene: geneLabel,
                cue: cueLabel,
                tail: tailLabel,
                placement: placementLabel,
                visibleInPortrait: visibleInPortrait,
                assetOutputs: "none"
            )
        }
    }

    struct PersonalityPosture {
        let attentionLabel: String
        let timidityLabel: String
        let leanLabel: String
        let rotationDegrees: CGFloat

        var summary: String {
            RendererMetadataSummary.personalityPostureCueSummary(
                attention: attentionLabel,
                timidity: timidityLabel,
                lean: leanLabel,
                assetOutputs: "none"
            )
        }
    }

    struct Expression {
        var eyeXScale: CGFloat
        var eyeYScale: CGFloat
        var catchlightAlpha: CGFloat
        var catchlightSize: CGFloat
        var catchlightOffset: CGPoint
        var gazeOffset: CGPoint
        var cheekWarmthAlpha: CGFloat
        var cheekWarmthScale: CGFloat
        var opennessLabel: String
        var softnessLabel: String
        var sparkleLabel: String
        var gazeLabel: String
        var catchlightStyleLabel: String
        var catchlightPlacementLabel: String
        var cheekWarmthLabel: String
        var cheekWarmthPlacementLabel: String
        var mouthStyleLabel: String
        var mouthEnergyLabel: String
        var mouthWidthLabel: String
        var mouthWidthAdjustment: CGFloat

        var summary: String {
            RendererMetadataSummary.personalityEyeCueSummary(
                openness: opennessLabel,
                softness: softnessLabel,
                sparkle: sparkleLabel
            )
        }

        var gazeSummary: String {
            RendererMetadataSummary.personalityEyeGazeCueSummary(
                gaze: gazeLabel,
                assetOutputs: "none"
            )
        }

        var detailSummary: String {
            RendererMetadataSummary.personalityEyeDetailSummary(
                catchlightStyle: catchlightStyleLabel,
                catchlightPlacement: catchlightPlacementLabel,
                assetOutputs: "none"
            )
        }

        var cheekWarmthSummary: String {
            RendererMetadataSummary.personalityCheekWarmthCueSummary(
                warmth: cheekWarmthLabel,
                placement: cheekWarmthPlacementLabel,
                assetOutputs: "none"
            )
        }

        var mouthSummary: String {
            RendererMetadataSummary.personalityMouthCueSummary(
                style: mouthStyleLabel,
                energy: mouthEnergyLabel,
                width: mouthWidthLabel,
                assetOutputs: "none"
            )
        }
    }

    struct GenomeVisualVariation {
        var face: String
        var body: String
        var wing: String
        var tail: String
        var visibleTraitCount: Int

        var summary: String {
            RendererMetadataSummary.genomeVisualVariationSummary(
                face: face,
                body: body,
                wing: wing,
                tail: tail,
                visibleTraitCount: visibleTraitCount
            )
        }
    }

    struct SilhouetteCue {
        var face: String
        var body: String
        var wing: String
        var tail: String
        var visibleCueCount: Int

        var summary: String {
            RendererMetadataSummary.spriteKitSilhouetteCueSummary(
                face: face,
                body: body,
                wing: wing,
                tail: tail,
                visibleCueCount: visibleCueCount
            )
        }
    }

    var palette: Palette
    var motion: Motion
    var silhouette: Silhouette
    var expression: Expression
    var genomeVisualVariation: GenomeVisualVariation
    var silhouetteCue: SilhouetteCue
    var bodyProportionCue: BodyProportionCue
    var bodyAccent: BodyAccent
    var bodySilhouetteAccessory: BodySilhouetteAccessory
    var faceAccent: FaceAccent
    var faceSilhouetteAccessory: FaceSilhouetteAccessory
    var faceLineageEcho: FaceLineageEcho
    var wingAccent: WingAccent
    var wingSilhouetteAccessory: WingSilhouetteAccessory
    var wingLineageEcho: WingLineageEcho
    var tailSilhouetteAccessory: TailSilhouetteAccessory
    var ancestralGlint: AncestralGlint
    var lineageMemoryThread: LineageMemoryThread
    var glowAura: GlowAura
    var patternMarking: PatternMarking
    var growthStageCue: GrowthStageCue
    var growthHornBudCue: GrowthHornBudCue
    var growthTailTipCue: GrowthTailTipCue
    var personalityPosture: PersonalityPosture
    var glowLineWidth: CGFloat
    var glowWidth: CGFloat
    var glowPulseScale: CGFloat
    var glowPulseDuration: TimeInterval

    init(creature: Creature) {
        let glow = creature.genome.pattern.glow.value
        let contrast = creature.genome.pattern.contrast.value
        let mysticism = creature.genome.personality.mysticism.value
        let morph = creature.genome.morph
        let bodyStyle = Self.bodyStyle(for: morph.body)
        let bodyAccent = Self.bodyAccent(for: morph.body)
        let bodySilhouetteAccessory = Self.bodySilhouetteAccessory(for: morph.body)
        let faceStyle = Self.faceStyle(for: morph.face)
        let hasAncestorEcho = creature.discoveredTraits.contains { discovery in
            discovery.kind == .inheritedResemblance && discovery.relatedAncestorID != nil
        }
        let faceAccent = Self.faceAccent(
            for: morph.face,
            generation: creature.generation,
            hasAncestorEcho: hasAncestorEcho
        )
        let faceSilhouetteAccessory = Self.faceSilhouetteAccessory(for: morph.face)
        let faceLineageEcho = FaceLineageEcho(
            isActive: hasAncestorEcho,
            cueLabel: hasAncestorEcho ? "softForeheadMemoryDots" : "none",
            faceCueLabel: hasAncestorEcho ? Self.faceCue(for: morph.face) : "none",
            placementLabel: hasAncestorEcho ? "forehead" : "none",
            dotCount: hasAncestorEcho ? Self.faceLineageEchoDotCount(forGeneration: creature.generation) : 0,
            color: SKColor.white,
            alpha: 0.48
        )
        let expression = Self.expression(for: creature.genome.personality)
        let wingStyle = Self.wingStyle(for: morph.wing)
        let wingAccent = Self.wingAccent(for: morph.wing)
        let wingSilhouetteAccessory = Self.wingSilhouetteAccessory(for: morph.wing)
        let wingLineageEcho = WingLineageEcho(
            isActive: hasAncestorEcho && wingSilhouetteAccessory.accessoryCue != "none",
            cueLabel: hasAncestorEcho && wingSilhouetteAccessory.accessoryCue != "none" ? "softWingMemoryTips" : "none",
            wingCueLabel: hasAncestorEcho && wingSilhouetteAccessory.accessoryCue != "none" ? wingSilhouetteAccessory.wingCue : "none",
            accessoryCueLabel: hasAncestorEcho && wingSilhouetteAccessory.accessoryCue != "none" ? wingSilhouetteAccessory.accessoryCue : "none",
            placementLabel: hasAncestorEcho && wingSilhouetteAccessory.accessoryCue != "none" ? "wingTips" : "none"
        )
        let glowAura = Self.glowAura(for: glow, mysticism: mysticism)
        let patternMarking = Self.patternMarking(for: contrast)
        let growthStageCue = Self.growthStageCue(for: creature.growthStage)
        let growthHornBudCue = Self.growthHornBudCue(
            for: creature.genome.growth.hornGrowth.value,
            stage: creature.growthStage
        )
        let growthTailTipCue = Self.growthTailTipCue(
            for: creature.genome.growth.tailGrowth.value,
            tail: morph.tail
        )
        let personalityPosture = Self.personalityPosture(for: creature.genome.personality)
        let tailStyle = Self.tailStyle(
            for: morph.tail,
            growth: creature.genome.growth.tailGrowth.value
        )
        let wingBase = morph.wing?.rawValue ?? "none"
        let tailBase = morph.tail?.rawValue ?? "none"

        self.palette = Palette(
            body: bodyStyle.bodyColor,
            head: faceStyle.headColor,
            eye: SKColor(red: 0.16, green: 0.18, blue: 0.22, alpha: 1),
            mouth: SKColor(red: 0.43, green: 0.45, blue: 0.48, alpha: 0.72),
            leftWing: wingStyle.leftWingColor.withAlphaComponent(0.68 + (contrast * 0.08)),
            rightWing: wingStyle.rightWingColor.withAlphaComponent(0.68 + (contrast * 0.08)),
            tail: tailStyle.tailColor.withAlphaComponent(0.72 + (glow * 0.16)),
            tailStroke: SKColor.white.withAlphaComponent(0.46 + (glow * 0.12)),
            glow: SKColor.white.withAlphaComponent(0.44 + (0.26 * glow)),
            shadow: SKColor.white.withAlphaComponent(0.28)
        )

        self.motion = Motion(
            floatAmount: 8 + (creature.genome.motion.float.value * 10),
            floatDuration: 2.8 - (creature.genome.motion.float.value * 0.8),
            blinkDelay: 2.6 + ((1 - creature.genome.motion.blink.value) * 2.2),
            blinkClosedScale: Self.blinkClosedScale(for: creature.genome.personality),
            blinkHoldDuration: Self.blinkHoldDuration(for: creature.genome.personality),
            sleepinessBreathScale: Self.sleepinessBreathScale(for: creature.genome.personality),
            sleepinessBreathDuration: Self.sleepinessBreathDuration(for: creature.genome.personality),
            tailSwayDegrees: 2 + (creature.genome.motion.tailMotion.value * 5),
            wingFlutterDegrees: 1 + (creature.genome.motion.wingMotion.value * 3),
            wingFlutterDuration: 2.4 - (creature.genome.motion.wingMotion.value * 0.7),
            floatLabel: Self.motionLabel(
                value: creature.genome.motion.float.value,
                low: "settled",
                middle: "drifting",
                high: "buoyant"
            ),
            blinkLabel: Self.motionLabel(
                value: creature.genome.motion.blink.value,
                low: "slowBlink",
                middle: "softBlink",
                high: "brightBlink"
            ),
            blinkStyleLabel: Self.blinkStyleLabel(for: creature.genome.personality),
            blinkDepthLabel: Self.blinkDepthLabel(for: creature.genome.personality),
            blinkHoldLabel: Self.blinkHoldLabel(for: creature.genome.personality),
            sleepinessStyleLabel: Self.sleepinessStyleLabel(for: creature.genome.personality),
            sleepinessBreathLabel: Self.sleepinessBreathLabel(for: creature.genome.personality),
            sleepinessPaceLabel: Self.sleepinessPaceLabel(for: creature.genome.personality),
            tailLabel: Self.motionLabel(
                value: creature.genome.motion.tailMotion.value,
                low: "stillTail",
                middle: "softSway",
                high: "livelySway"
            ),
            wingLabel: Self.motionLabel(
                value: creature.genome.motion.wingMotion.value,
                low: "restingWing",
                middle: "softFlutter",
                high: "livelyFlutter"
            )
        )

        let wingGrowth = CGFloat(creature.genome.growth.wingGrowth.value)
        self.silhouette = Silhouette(
            bodyRect: bodyStyle.bodyRect,
            bodyAccent: bodyAccent,
            headRect: faceStyle.headRect,
            faceAccent: faceAccent,
            faceLineageEcho: faceLineageEcho,
            wingXScale: wingStyle.xScale + (wingGrowth * 0.12),
            wingYScale: wingStyle.yScale + (wingGrowth * 0.10),
            wingRotationAdjustmentDegrees: wingStyle.rotationAdjustmentDegrees,
            wingAccent: wingAccent,
            wingSilhouetteAccessory: wingSilhouetteAccessory,
            tailRect: tailStyle.tailRect,
            tailRotationDegrees: tailStyle.rotationDegrees,
            tailAccent: tailStyle.accent,
            tailSilhouetteAccessory: Self.tailSilhouetteAccessory(for: morph.tail),
            tailLineageEcho: TailLineageEcho(
                isActive: hasAncestorEcho,
                cueLabel: hasAncestorEcho ? "softTailMemoryDots" : "none",
                tailCueLabel: hasAncestorEcho ? Self.tailCue(for: morph.tail) : "none",
                placementLabel: hasAncestorEcho ? "tailTip" : "none",
                dotCount: hasAncestorEcho ? Self.tailLineageEchoDotCount(forGeneration: creature.generation) : 0,
                color: SKColor.white,
                alpha: 0.58
            ),
            mouthWidth: faceStyle.mouthWidth + expression.mouthWidthAdjustment
        )

        self.expression = expression
        self.bodyProportionCue = Self.bodyProportionCue(
            for: morph.body,
            style: bodyStyle
        )
        self.bodyAccent = bodyAccent
        self.bodySilhouetteAccessory = bodySilhouetteAccessory
        self.faceAccent = faceAccent
        self.faceSilhouetteAccessory = faceSilhouetteAccessory
        self.faceLineageEcho = faceLineageEcho
        self.wingAccent = wingAccent
        self.wingSilhouetteAccessory = wingSilhouetteAccessory
        self.wingLineageEcho = wingLineageEcho
        self.tailSilhouetteAccessory = silhouette.tailSilhouetteAccessory
        self.ancestralGlint = AncestralGlint(
            isActive: hasAncestorEcho,
            cueLabel: hasAncestorEcho ? "softAncestralGlint" : "none",
            placementLabel: hasAncestorEcho ? "upperChest" : "none",
            glintCount: hasAncestorEcho ? Self.ancestralGlintCount(forGeneration: creature.generation) : 0,
            color: SKColor(red: 1.00, green: 0.93, blue: 0.74, alpha: 1),
            alpha: hasAncestorEcho ? 0.56 : 0
        )
        self.lineageMemoryThread = LineageMemoryThread(
            isActive: hasAncestorEcho,
            cueLabel: hasAncestorEcho ? "softLineageMemoryThread" : "none",
            bodyCueLabel: hasAncestorEcho ? "softAncestralGlint" : "none",
            tailCueLabel: hasAncestorEcho ? "softTailMemoryDots" : "none",
            placementLabel: hasAncestorEcho ? "bodyToTail" : "none",
            color: SKColor(red: 1.00, green: 0.94, blue: 0.76, alpha: 1),
            alpha: hasAncestorEcho ? 0.26 : 0
        )
        self.glowAura = glowAura
        self.patternMarking = patternMarking
        self.growthStageCue = growthStageCue
        self.growthHornBudCue = growthHornBudCue
        self.growthTailTipCue = growthTailTipCue
        self.personalityPosture = personalityPosture
        self.genomeVisualVariation = GenomeVisualVariation(
            face: morph.face.rawValue,
            body: morph.body.rawValue,
            wing: wingBase,
            tail: tailBase,
            visibleTraitCount: Self.visibleTraitCount(for: morph)
        )
        self.silhouetteCue = SilhouetteCue(
            face: Self.faceCue(for: morph.face),
            body: Self.bodyCue(for: morph.body),
            wing: Self.wingCue(for: morph.wing),
            tail: Self.tailCue(for: morph.tail),
            visibleCueCount: Self.visibleTraitCount(for: morph)
        )

        self.glowLineWidth = 7
        self.glowWidth = 10 + (glow * 8)
        self.glowPulseScale = 1.006 + (glow * 0.022)
        self.glowPulseDuration = 2.9 - (glow * 0.55)
    }

    var genomeVisualVariationSummary: String {
        genomeVisualVariation.summary
    }

    var personalityEyeCueSummary: String {
        expression.summary
    }

    var personalityEyeDetailSummary: String {
        expression.detailSummary
    }

    var personalityCheekWarmthCueSummary: String {
        expression.cheekWarmthSummary
    }

    var hasPersonalityCheekWarmthCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityCheekWarmthCueFields(
            warmth: expression.cheekWarmthLabel,
            placement: expression.cheekWarmthPlacementLabel,
            assetOutputs: "none",
            summary: personalityCheekWarmthCueSummary
        )
    }

    var personalityCheekWarmthCueReadinessSummary: String {
        RendererMetadataSummary.personalityCheekWarmthCueReadinessSummary(
            isReady: hasPersonalityCheekWarmthCueMetadata
        )
    }

    var personalityEyeGazeCueSummary: String {
        expression.gazeSummary
    }

    var personalityMouthCueSummary: String {
        expression.mouthSummary
    }

    var hasPersonalityMouthCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityMouthCueFields(
            style: expression.mouthStyleLabel,
            energy: expression.mouthEnergyLabel,
            width: expression.mouthWidthLabel,
            assetOutputs: "none",
            summary: personalityMouthCueSummary
        )
    }

    var personalityMouthCueReadinessSummary: String {
        RendererMetadataSummary.personalityMouthCueReadinessSummary(isReady: hasPersonalityMouthCueMetadata)
    }

    var personalityPostureCueSummary: String {
        personalityPosture.summary
    }

    var hasPersonalityPostureCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityPostureCueFields(
            attention: personalityPosture.attentionLabel,
            timidity: personalityPosture.timidityLabel,
            lean: personalityPosture.leanLabel,
            assetOutputs: "none",
            summary: personalityPostureCueSummary
        )
    }

    var personalityPostureCueReadinessSummary: String {
        RendererMetadataSummary.personalityPostureCueReadinessSummary(
            isReady: hasPersonalityPostureCueMetadata
        )
    }

    var hasPersonalityEyeGazeCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityEyeGazeCueFields(
            gaze: expression.gazeLabel,
            assetOutputs: "none",
            summary: personalityEyeGazeCueSummary
        )
    }

    var personalityEyeGazeCueReadinessSummary: String {
        RendererMetadataSummary.personalityEyeGazeCueReadinessSummary(isReady: hasPersonalityEyeGazeCueMetadata)
    }

    var spriteKitGlowAuraCueSummary: String {
        glowAura.summary
    }

    var personalityMysticismAuraCueSummary: String {
        glowAura.mysticismSummary
    }

    var hasPersonalityMysticismAuraCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityMysticismAuraCueFields(
            mysticism: glowAura.mysticismLabel,
            halo: glowAura.mysticismHaloLabel,
            assetOutputs: "none",
            summary: personalityMysticismAuraCueSummary
        )
    }

    var personalityMysticismAuraCueReadinessSummary: String {
        RendererMetadataSummary.personalityMysticismAuraCueReadinessSummary(
            isReady: hasPersonalityMysticismAuraCueMetadata
        )
    }

    var hasSpriteKitGlowAuraCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitGlowAuraCueFields(
            glow: glowAura.glowLabel,
            aura: glowAura.auraLabel,
            pulse: glowAura.pulseLabel,
            motes: glowAura.motePlacementLabel,
            assetOutputs: "none",
            summary: spriteKitGlowAuraCueSummary
        )
    }

    var spriteKitPatternMarkingCueSummary: String {
        patternMarking.summary
    }

    var hasSpriteKitPatternMarkingCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitPatternMarkingCueFields(
            gene: "contrast",
            mark: patternMarking.markLabel,
            placement: patternMarking.placementLabel,
            spread: patternMarking.spreadLabel,
            assetOutputs: "none",
            summary: spriteKitPatternMarkingCueSummary
        )
    }

    var spriteKitPatternMarkingCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitPatternMarkingCueReadinessSummary(isReady: hasSpriteKitPatternMarkingCueMetadata)
    }

    var spriteKitGrowthHornBudCueSummary: String {
        growthHornBudCue.summary
    }

    var hasSpriteKitGrowthHornBudCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitGrowthHornBudCueFields(
            gene: growthHornBudCue.geneLabel,
            bud: growthHornBudCue.budLabel,
            stage: growthHornBudCue.stageLabel,
            softness: growthHornBudCue.softnessLabel,
            visibleInPortrait: growthHornBudCue.visibleInPortrait,
            assetOutputs: "none",
            summary: spriteKitGrowthHornBudCueSummary
        )
    }

    var spriteKitGrowthHornBudCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitGrowthHornBudCueReadinessSummary(
            isReady: hasSpriteKitGrowthHornBudCueMetadata
        )
    }

    var spriteKitGrowthTailTipCueSummary: String {
        growthTailTipCue.summary
    }

    var hasSpriteKitGrowthTailTipCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitGrowthTailTipCueFields(
            gene: growthTailTipCue.geneLabel,
            cue: growthTailTipCue.cueLabel,
            tail: growthTailTipCue.tailLabel,
            placement: growthTailTipCue.placementLabel,
            visibleInPortrait: growthTailTipCue.visibleInPortrait,
            assetOutputs: "none",
            summary: spriteKitGrowthTailTipCueSummary
        )
    }

    var spriteKitGrowthTailTipCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitGrowthTailTipCueReadinessSummary(
            isReady: hasSpriteKitGrowthTailTipCueMetadata
        )
    }

    var spriteKitAncestralGlintCueSummary: String {
        ancestralGlint.summary
    }

    var spriteKitFaceLineageEchoCueSummary: String {
        faceLineageEcho.summary
    }

    var hasSpriteKitFaceLineageEchoCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitFaceLineageEchoCueFields(
            cue: faceLineageEcho.cueLabel,
            face: faceLineageEcho.faceCueLabel,
            placement: faceLineageEcho.placementLabel,
            dotCount: faceLineageEcho.dotCount,
            ancestryLinked: faceLineageEcho.isActive,
            active: faceLineageEcho.isActive,
            assetOutputs: "none",
            summary: spriteKitFaceLineageEchoCueSummary
        )
    }

    var spriteKitFaceLineageEchoCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitFaceLineageEchoCueReadinessSummary(
            isReady: hasSpriteKitFaceLineageEchoCueMetadata
        )
    }

    var hasSpriteKitAncestralGlintCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitAncestralGlintCueFields(
            cue: ancestralGlint.cueLabel,
            placement: ancestralGlint.placementLabel,
            glintCount: ancestralGlint.glintCount,
            ancestryLinked: ancestralGlint.isActive,
            active: ancestralGlint.isActive,
            assetOutputs: "none",
            summary: spriteKitAncestralGlintCueSummary
        )
    }

    var spriteKitAncestralGlintCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitAncestralGlintCueReadinessSummary(isReady: hasSpriteKitAncestralGlintCueMetadata)
    }

    var spriteKitTailLineageEchoCueSummary: String {
        silhouette.tailLineageEcho.summary
    }

    var hasSpriteKitTailLineageEchoCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitTailLineageEchoCueFields(
            cue: silhouette.tailLineageEcho.cueLabel,
            tail: silhouette.tailLineageEcho.tailCueLabel,
            placement: silhouette.tailLineageEcho.placementLabel,
            dotCount: silhouette.tailLineageEcho.dotCount,
            ancestryLinked: silhouette.tailLineageEcho.isActive,
            active: silhouette.tailLineageEcho.isActive,
            assetOutputs: "none",
            summary: spriteKitTailLineageEchoCueSummary
        )
    }

    var spriteKitTailLineageEchoCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitTailLineageEchoCueReadinessSummary(isReady: hasSpriteKitTailLineageEchoCueMetadata)
    }

    var spriteKitTailSilhouetteAccessoryCueSummary: String {
        silhouette.tailSilhouetteAccessory.summary
    }

    var hasSpriteKitTailSilhouetteAccessoryCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitTailSilhouetteAccessoryCueFields(
            tail: silhouette.tailSilhouetteAccessory.tailCue,
            accessory: silhouette.tailSilhouetteAccessory.accessoryCue,
            visibleInPortrait: true,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: spriteKitTailSilhouetteAccessoryCueSummary
        )
    }

    var spriteKitTailSilhouetteAccessoryCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitTailSilhouetteAccessoryCueReadinessSummary(
            isReady: hasSpriteKitTailSilhouetteAccessoryCueMetadata
        )
    }

    var spriteKitLineageVisualEchoPairSummary: String {
        RendererMetadataSummary.spriteKitLineageVisualEchoPairSummary(
            bodyCue: ancestralGlint.cueLabel,
            tailCue: silhouette.tailLineageEcho.cueLabel,
            ancestryLinked: ancestralGlint.isActive && silhouette.tailLineageEcho.isActive,
            activeCueCount: [ancestralGlint.isActive, silhouette.tailLineageEcho.isActive].filter { $0 }.count,
            assetOutputs: "none"
        )
    }

    var hasSpriteKitLineageVisualEchoPairMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitLineageVisualEchoPairFields(
            bodyCue: ancestralGlint.cueLabel,
            tailCue: silhouette.tailLineageEcho.cueLabel,
            ancestryLinked: ancestralGlint.isActive && silhouette.tailLineageEcho.isActive,
            activeCueCount: [ancestralGlint.isActive, silhouette.tailLineageEcho.isActive].filter { $0 }.count,
            assetOutputs: "none",
            summary: spriteKitLineageVisualEchoPairSummary
        )
    }

    var spriteKitLineageVisualEchoPairReadinessSummary: String {
        RendererMetadataSummary.spriteKitLineageVisualEchoPairReadinessSummary(isReady: hasSpriteKitLineageVisualEchoPairMetadata)
    }

    var spriteKitLineageMemoryThreadSummary: String {
        lineageMemoryThread.summary
    }

    var hasSpriteKitLineageMemoryThreadMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitLineageMemoryThreadFields(
            cue: lineageMemoryThread.cueLabel,
            bodyCue: lineageMemoryThread.bodyCueLabel,
            tailCue: lineageMemoryThread.tailCueLabel,
            placement: lineageMemoryThread.placementLabel,
            ancestryLinked: lineageMemoryThread.isActive,
            active: lineageMemoryThread.isActive,
            assetOutputs: "none",
            summary: spriteKitLineageMemoryThreadSummary
        )
    }

    var spriteKitLineageMemoryThreadReadinessSummary: String {
        RendererMetadataSummary.spriteKitLineageMemoryThreadReadinessSummary(isReady: hasSpriteKitLineageMemoryThreadMetadata)
    }

    var spriteKitLineageCueSetSummary: String {
        RendererMetadataSummary.spriteKitLineageCueSetSummary(
            surface: "observationHome",
            bodyCue: ancestralGlint.cueLabel,
            tailCue: silhouette.tailLineageEcho.cueLabel,
            threadCue: lineageMemoryThread.cueLabel,
            ancestryLinked: ancestralGlint.isActive
                && silhouette.tailLineageEcho.isActive
                && lineageMemoryThread.isActive,
            activeCueCount: [
                ancestralGlint.isActive,
                silhouette.tailLineageEcho.isActive,
                lineageMemoryThread.isActive
            ].filter { $0 }.count,
            visibleInObservation: ancestralGlint.isActive
                && silhouette.tailLineageEcho.isActive
                && lineageMemoryThread.isActive,
            controlsEnabled: false,
            assetOutputs: "none"
        )
    }

    var hasSpriteKitLineageCueSetMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitLineageCueSetFields(
            surface: "observationHome",
            bodyCue: ancestralGlint.cueLabel,
            tailCue: silhouette.tailLineageEcho.cueLabel,
            threadCue: lineageMemoryThread.cueLabel,
            ancestryLinked: ancestralGlint.isActive
                && silhouette.tailLineageEcho.isActive
                && lineageMemoryThread.isActive,
            activeCueCount: [
                ancestralGlint.isActive,
                silhouette.tailLineageEcho.isActive,
                lineageMemoryThread.isActive
            ].filter { $0 }.count,
            visibleInObservation: ancestralGlint.isActive
                && silhouette.tailLineageEcho.isActive
                && lineageMemoryThread.isActive,
            controlsEnabled: false,
            assetOutputs: "none",
            summary: spriteKitLineageCueSetSummary
        )
    }

    var spriteKitLineageCueSetReadinessSummary: String {
        RendererMetadataSummary.spriteKitLineageCueSetReadinessSummary(isReady: hasSpriteKitLineageCueSetMetadata)
    }

    var spriteKitGrowthStageCueSummary: String {
        growthStageCue.summary
    }

    var hasSpriteKitGrowthStageCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitGrowthStageCueFields(
            stage: growthStageCue.stageLabel,
            scale: growthStageCue.scaleLabel,
            posture: growthStageCue.postureLabel,
            assetOutputs: "none",
            summary: spriteKitGrowthStageCueSummary
        )
    }

    var spriteKitGrowthStageCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitGrowthStageCueReadinessSummary(isReady: hasSpriteKitGrowthStageCueMetadata)
    }

    var spriteKitMotionGeneCueSummary: String {
        motion.summary
    }

    var hasSpriteKitMotionGeneCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitMotionGeneCueFields(
            float: motion.floatLabel,
            blink: motion.blinkLabel,
            tail: motion.tailLabel,
            wing: motion.wingLabel,
            wingFlutter: "\(motion.wingFlutterDegrees)deg/\(motion.wingFlutterDuration)s",
            assetOutputs: "none",
            summary: spriteKitMotionGeneCueSummary
        )
    }

    var spriteKitMotionGeneCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitMotionGeneCueReadinessSummary(isReady: hasSpriteKitMotionGeneCueMetadata)
    }

    var personalityBlinkCueSummary: String {
        motion.blinkSummary
    }

    var hasPersonalityBlinkCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalityBlinkCueFields(
            style: motion.blinkStyleLabel,
            depth: motion.blinkDepthLabel,
            hold: motion.blinkHoldLabel,
            assetOutputs: "none",
            summary: personalityBlinkCueSummary
        )
    }

    var personalityBlinkCueReadinessSummary: String {
        RendererMetadataSummary.personalityBlinkCueReadinessSummary(isReady: hasPersonalityBlinkCueMetadata)
    }

    var personalitySleepinessIdleCueSummary: String {
        motion.sleepinessSummary
    }

    var hasPersonalitySleepinessIdleCueMetadata: Bool {
        RendererMetadataSummary.hasPersonalitySleepinessIdleCueFields(
            style: motion.sleepinessStyleLabel,
            breath: motion.sleepinessBreathLabel,
            pace: motion.sleepinessPaceLabel,
            assetOutputs: "none",
            summary: personalitySleepinessIdleCueSummary
        )
    }

    var personalitySleepinessIdleCueReadinessSummary: String {
        RendererMetadataSummary.personalitySleepinessIdleCueReadinessSummary(
            isReady: hasPersonalitySleepinessIdleCueMetadata
        )
    }

    var spriteKitSilhouetteCueSummary: String {
        silhouetteCue.summary
    }

    var spriteKitWingCueAccentSummary: String {
        wingAccent.summary
    }

    var hasSpriteKitWingCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitWingCueAccentFields(
            wing: wingAccent.wingCue,
            accent: wingAccent.accent,
            assetOutputs: "none",
            summary: spriteKitWingCueAccentSummary
        )
    }

    var spriteKitWingCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitWingCueAccentReadinessSummary(
            isReady: hasSpriteKitWingCueAccentMetadata
        )
    }

    var spriteKitWingSilhouetteAccessoryCueSummary: String {
        wingSilhouetteAccessory.summary
    }

    var hasSpriteKitWingSilhouetteAccessoryCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitWingSilhouetteAccessoryCueFields(
            wing: wingSilhouetteAccessory.wingCue,
            accessory: wingSilhouetteAccessory.accessoryCue,
            visibleInPortrait: true,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: spriteKitWingSilhouetteAccessoryCueSummary
        )
    }

    var spriteKitWingSilhouetteAccessoryCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitWingSilhouetteAccessoryCueReadinessSummary(
            isReady: hasSpriteKitWingSilhouetteAccessoryCueMetadata
        )
    }

    var spriteKitWingLineageEchoCueSummary: String {
        wingLineageEcho.summary
    }

    var hasSpriteKitWingLineageEchoCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitWingLineageEchoCueFields(
            cue: wingLineageEcho.cueLabel,
            wing: wingLineageEcho.wingCueLabel,
            accessory: wingLineageEcho.accessoryCueLabel,
            placement: wingLineageEcho.placementLabel,
            ancestryLinked: wingLineageEcho.isActive,
            active: wingLineageEcho.isActive,
            assetOutputs: "none",
            summary: spriteKitWingLineageEchoCueSummary
        )
    }

    var spriteKitWingLineageEchoCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitWingLineageEchoCueReadinessSummary(
            isReady: hasSpriteKitWingLineageEchoCueMetadata
        )
    }

    var spriteKitBodyCueAccentSummary: String {
        bodyAccent.summary
    }

    var hasSpriteKitBodyCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitBodyCueAccentFields(
            body: bodyAccent.bodyCue,
            accent: bodyAccent.accent,
            assetOutputs: "none",
            summary: spriteKitBodyCueAccentSummary
        )
    }

    var spriteKitBodyCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitBodyCueAccentReadinessSummary(
            isReady: hasSpriteKitBodyCueAccentMetadata
        )
    }

    var spriteKitBodyProportionCueSummary: String {
        bodyProportionCue.summary
    }

    var hasSpriteKitBodyProportionCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitBodyProportionCueFields(
            body: bodyProportionCue.bodyCue,
            width: bodyProportionCue.widthLabel,
            height: bodyProportionCue.heightLabel,
            affection: bodyProportionCue.affectionLabel,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: spriteKitBodyProportionCueSummary
        )
    }

    var spriteKitBodyProportionCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitBodyProportionCueReadinessSummary(
            isReady: hasSpriteKitBodyProportionCueMetadata
        )
    }

    var spriteKitBodySilhouetteAccessoryCueSummary: String {
        bodySilhouetteAccessory.summary
    }

    var hasSpriteKitBodySilhouetteAccessoryCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitBodySilhouetteAccessoryCueFields(
            body: bodySilhouetteAccessory.bodyCue,
            accessory: bodySilhouetteAccessory.accessoryCue,
            visibleInPortrait: true,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: spriteKitBodySilhouetteAccessoryCueSummary
        )
    }

    var spriteKitBodySilhouetteAccessoryCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitBodySilhouetteAccessoryCueReadinessSummary(
            isReady: hasSpriteKitBodySilhouetteAccessoryCueMetadata
        )
    }

    var spriteKitFaceCueAccentSummary: String {
        faceAccent.summary
    }

    var hasSpriteKitFaceCueAccentMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitFaceCueAccentFields(
            face: faceAccent.faceCue,
            accent: faceAccent.accent,
            dotCount: faceAccent.dotCount,
            assetOutputs: "none",
            summary: spriteKitFaceCueAccentSummary
        )
    }

    var spriteKitFaceCueAccentReadinessSummary: String {
        RendererMetadataSummary.spriteKitFaceCueAccentReadinessSummary(
            isReady: hasSpriteKitFaceCueAccentMetadata
        )
    }

    var spriteKitFaceSilhouetteAccessoryCueSummary: String {
        faceSilhouetteAccessory.summary
    }

    var hasSpriteKitFaceSilhouetteAccessoryCueMetadata: Bool {
        RendererMetadataSummary.hasSpriteKitFaceSilhouetteAccessoryCueFields(
            face: faceSilhouetteAccessory.faceCue,
            accessory: faceSilhouetteAccessory.accessoryCue,
            visibleInPortrait: true,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: spriteKitFaceSilhouetteAccessoryCueSummary
        )
    }

    var spriteKitFaceSilhouetteAccessoryCueReadinessSummary: String {
        RendererMetadataSummary.spriteKitFaceSilhouetteAccessoryCueReadinessSummary(
            isReady: hasSpriteKitFaceSilhouetteAccessoryCueMetadata
        )
    }

    static var fixedPartReferenceCoverageSummary: String {
        RendererMetadataSummary.fixedPartReferenceCoverageSummary(
            faceBases: FaceBase.allCases.map(\.rawValue),
            bodyBases: BodyBase.allCases.map(\.rawValue),
            wingBases: WingBase.allCases.map(\.rawValue),
            tailBases: TailBase.allCases.map(\.rawValue),
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
    }

    static var hasFixedPartReferenceCoverageMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceCoverageFields(
            faceBases: FaceBase.allCases.map(\.rawValue),
            bodyBases: BodyBase.allCases.map(\.rawValue),
            wingBases: WingBase.allCases.map(\.rawValue),
            tailBases: TailBase.allCases.map(\.rawValue),
            optionalValidBases: ["wing:none", "tail:none"],
            missingFaceBases: [],
            missingWingBases: [],
            missingTailBases: [],
            missingUpperBodyIntent: "babyAdultDeltas",
            missingHornIntent: "all",
            missingEarIntent: "all",
            missingCrystalIntent: "all",
            missingGlowIntent: "all",
            summary: fixedPartReferenceCoverageSummary
        )
    }

    static var fixedPartReferenceCoverageReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceCoverageReadinessSummary(
            isReady: hasFixedPartReferenceCoverageMetadata
        )
    }

    static var fixedPartHornBaseReferenceEvidenceHandoffSummary: String {
        RendererMetadataSummary.fixedPartHornBaseReferenceEvidenceHandoffSummary(
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
    }

    static var hasFixedPartHornBaseReferenceEvidenceHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartHornBaseReferenceEvidenceHandoffFields(
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
            assetOutputs: "none",
            summary: fixedPartHornBaseReferenceEvidenceHandoffSummary
        )
    }

    static var fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary(
            isReady: hasFixedPartHornBaseReferenceEvidenceHandoffMetadata
        )
    }

    static var fixedPartVocabularyBridgeFaceMappings: [String] {
        [
            "faceted->Face.crystal",
            "smallFairy->Face.fairy",
            "softRound->Face.round",
            "broadDragon->Face.dragon",
            "wideAxolotl->Face.axolotl",
            "softDeer->Face.deer",
            "softFeline->Face.feline",
            "softCrescent->Face.lunar"
        ]
    }

    static var fixedPartVocabularyBridgeUpperBodyMappings: [String] {
        [
            "moonOval->UpperBody.lunarian",
            "seedPetal->UpperBody.sylphian",
            "waterDrop->UpperBody.aquarian",
            "pebbleGem->UpperBody.crystalian",
            "leafBelly->UpperBody.verdant"
        ]
    }

    static var fixedPartVocabularyBridgeWingMappings: [String] {
        [
            "none->none",
            "leafPair->Wing.fairy",
            "wideSail->Wing.dragon",
            "gemPair->Wing.crystal",
            "softBell->Wing.jellyfish",
            "sproutLeaf->Wing.plant"
        ]
    }

    static var fixedPartVocabularyBridgeTailMappings: [String] {
        [
            "floatingRibbon->Tail.floating",
            "fishFin->Tail.fish",
            "longDrake->Tail.dragon",
            "gemTail->Tail.crystal",
            "leafSprout->Tail.plant",
            "none->none"
        ]
    }

    static var fixedPartVocabularyBridgeSummary: String {
        RendererMetadataSummary.fixedPartVocabularyBridgeSummary(
            faceMappings: fixedPartVocabularyBridgeFaceMappings,
            upperBodyMappings: fixedPartVocabularyBridgeUpperBodyMappings,
            wingMappings: fixedPartVocabularyBridgeWingMappings,
            tailMappings: fixedPartVocabularyBridgeTailMappings,
            assetOutputs: "none",
            geometryChanged: false
        )
    }

    static var hasFixedPartVocabularyBridgeMetadata: Bool {
        RendererMetadataSummary.hasFixedPartVocabularyBridgeFields(
            faceMappings: fixedPartVocabularyBridgeFaceMappings,
            upperBodyMappings: fixedPartVocabularyBridgeUpperBodyMappings,
            wingMappings: fixedPartVocabularyBridgeWingMappings,
            tailMappings: fixedPartVocabularyBridgeTailMappings,
            assetOutputs: "none",
            summary: fixedPartVocabularyBridgeSummary
        )
    }

    static var fixedPartVocabularyBridgeReadinessSummary: String {
        RendererMetadataSummary.fixedPartVocabularyBridgeReadinessSummary(
            isReady: hasFixedPartVocabularyBridgeMetadata
        )
    }

    static var fixedPart2DRecipeBridgeHeadRecipes: [String] {
        ["softRound", "softPetal", "softBroad", "softWide", "softFacet", "softDeer", "softFeline", "softCrescent"]
    }

    static var fixedPart2DRecipeBridgeBodyRecipes: [String] {
        ["softOval", "waterDrop", "seedPetal", "pebbleGem", "moonOval", "leafBelly"]
    }

    static var fixedPart2DRecipeBridgeWingRecipes: [String] {
        ["softLunar", "softLeaf", "softSail", "softFacet", "softBell", "softSprout"]
    }

    static var fixedPart2DRecipeBridgeTailRecipes: [String] {
        ["roundedRibbon", "fishTaper", "dragonTaper", "softFacet", "leafSprout"]
    }

    static var fixedPart2DRecipeBridgeFutureTargets: [String] {
        ["FaceBase", "UpperBody", "WingBase", "TailBase"]
    }

    static var fixedPart2DRecipeBridgeSummary: String {
        RendererMetadataSummary.fixedPart2DRecipeBridgeSummary(
            headRecipes: fixedPart2DRecipeBridgeHeadRecipes,
            bodyRecipes: fixedPart2DRecipeBridgeBodyRecipes,
            wingRecipes: fixedPart2DRecipeBridgeWingRecipes,
            tailRecipes: fixedPart2DRecipeBridgeTailRecipes,
            futureTargets: fixedPart2DRecipeBridgeFutureTargets,
            assetOutputs: "none",
            geometryChanged: false
        )
    }

    static var hasFixedPart2DRecipeBridgeMetadata: Bool {
        RendererMetadataSummary.hasFixedPart2DRecipeBridgeFields(
            headRecipes: fixedPart2DRecipeBridgeHeadRecipes,
            bodyRecipes: fixedPart2DRecipeBridgeBodyRecipes,
            wingRecipes: fixedPart2DRecipeBridgeWingRecipes,
            tailRecipes: fixedPart2DRecipeBridgeTailRecipes,
            futureTargets: fixedPart2DRecipeBridgeFutureTargets,
            assetOutputs: "none",
            summary: fixedPart2DRecipeBridgeSummary
        )
    }

    static var fixedPart2DRecipeBridgeReadinessSummary: String {
        RendererMetadataSummary.fixedPart2DRecipeBridgeReadinessSummary(
            isReady: hasFixedPart2DRecipeBridgeMetadata
        )
    }

    static var fixedPartAccessoryRecipeBridgeFaceAccessories: [String] {
        ["softEarNubs", "softEarTips"]
    }

    static var fixedPartAccessoryRecipeBridgeBodyAccessories: [String] {
        ["softShoulderPetals", "softMoonShoulderCrescents", "leafShoulderNubs"]
    }

    static var fixedPartAccessoryRecipeBridgeWingAccessories: [String] {
        ["softWingTipPearl", "softWingTipClaw"]
    }

    static var fixedPartAccessoryRecipeBridgeTailAccessories: [String] {
        ["softForkFin", "softTetherDot", "softDrakeRidge", "softLeafVein"]
    }

    static var fixedPartAccessoryRecipeBridgeFutureTargets: [String] {
        ["FaceAccessory", "UpperBodyAccessory", "WingAccessory", "TailAccessory"]
    }

    static var fixedPartAccessoryRecipeBridgeSummary: String {
        RendererMetadataSummary.fixedPartAccessoryRecipeBridgeSummary(
            faceAccessories: fixedPartAccessoryRecipeBridgeFaceAccessories,
            bodyAccessories: fixedPartAccessoryRecipeBridgeBodyAccessories,
            wingAccessories: fixedPartAccessoryRecipeBridgeWingAccessories,
            tailAccessories: fixedPartAccessoryRecipeBridgeTailAccessories,
            futureTargets: fixedPartAccessoryRecipeBridgeFutureTargets,
            assetOutputs: "none",
            geometryChanged: false
        )
    }

    static var hasFixedPartAccessoryRecipeBridgeMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryRecipeBridgeFields(
            faceAccessories: fixedPartAccessoryRecipeBridgeFaceAccessories,
            bodyAccessories: fixedPartAccessoryRecipeBridgeBodyAccessories,
            wingAccessories: fixedPartAccessoryRecipeBridgeWingAccessories,
            tailAccessories: fixedPartAccessoryRecipeBridgeTailAccessories,
            futureTargets: fixedPartAccessoryRecipeBridgeFutureTargets,
            assetOutputs: "none",
            summary: fixedPartAccessoryRecipeBridgeSummary
        )
    }

    static var fixedPartAccessoryRecipeBridgeReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryRecipeBridgeReadinessSummary(
            isReady: hasFixedPartAccessoryRecipeBridgeMetadata
        )
    }

    static var fixedPartAccessoryReferenceFaceAnnotations: [String] {
        [
            "softEarNubs->FaceBase.deer@headCenter#accessoryCue",
            "softEarTips->FaceBase.feline@headCenter#accessoryCue"
        ]
    }

    static var fixedPartAccessoryReferenceBodyAnnotations: [String] {
        [
            "softShoulderPetals->UpperBody.sylphian@bodyCenter#accessoryCue",
            "softMoonShoulderCrescents->UpperBody.lunarian@bodyCenter#accessoryCue",
            "leafShoulderNubs->UpperBody.verdant@bodyCenter#accessoryCue"
        ]
    }

    static var fixedPartAccessoryReferenceWingAnnotations: [String] {
        [
            "softWingTipPearl->WingBase.fairy@wingTip#accessoryCue",
            "softWingTipClaw->WingBase.dragon@wingTip#accessoryCue"
        ]
    }

    static var fixedPartAccessoryReferenceTailAnnotations: [String] {
        [
            "softForkFin->TailBase.fish@tailTip#accessoryCue",
            "softTetherDot->TailBase.floating@tailTip#accessoryCue",
            "softDrakeRidge->TailBase.dragon@tailTip#accessoryCue"
        ]
    }

    static var fixedPartAccessoryReferenceRequiredPanels: [String] {
        [
            "accessoryCue",
            "socketDiagram",
            "rigDiagram"
        ]
    }

    static var fixedPartAccessoryReferenceAnnotationSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceAnnotationSummary(
            faceAnnotations: fixedPartAccessoryReferenceFaceAnnotations,
            bodyAnnotations: fixedPartAccessoryReferenceBodyAnnotations,
            wingAnnotations: fixedPartAccessoryReferenceWingAnnotations,
            tailAnnotations: fixedPartAccessoryReferenceTailAnnotations,
            requiredPanels: fixedPartAccessoryReferenceRequiredPanels,
            sourceBridgeReady: hasFixedPartAccessoryRecipeBridgeMetadata,
            assetOutputs: "none",
            generatedAssets: false
        )
    }

    static var hasFixedPartAccessoryReferenceAnnotationMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryReferenceAnnotationFields(
            faceAnnotations: fixedPartAccessoryReferenceFaceAnnotations,
            bodyAnnotations: fixedPartAccessoryReferenceBodyAnnotations,
            wingAnnotations: fixedPartAccessoryReferenceWingAnnotations,
            tailAnnotations: fixedPartAccessoryReferenceTailAnnotations,
            requiredPanels: fixedPartAccessoryReferenceRequiredPanels,
            sourceBridgeReady: hasFixedPartAccessoryRecipeBridgeMetadata,
            assetOutputs: "none",
            generatedAssets: false,
            summary: fixedPartAccessoryReferenceAnnotationSummary
        )
    }

    static var fixedPartAccessoryReferenceAnnotationReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceAnnotationReadinessSummary(
            isReady: hasFixedPartAccessoryReferenceAnnotationMetadata
        )
    }

    static var fixedPartAccessoryReferenceSheetPreflightSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceSheetPreflightSummary(
            accessoryReferenceReady: hasFixedPartAccessoryReferenceAnnotationMetadata,
            manualChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            manualReviewStateReady: hasFixedPartReferenceSheetManualReviewResultStateMetadata,
            reviewEvidenceFieldsReady: hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartAccessoryReferenceSheetPreflightMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPreflightFields(
            accessoryReferenceReady: hasFixedPartAccessoryReferenceAnnotationMetadata,
            manualChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            manualReviewStateReady: hasFixedPartReferenceSheetManualReviewResultStateMetadata,
            reviewEvidenceFieldsReady: hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartAccessoryReferenceSheetPreflightSummary
        )
    }

    static var fixedPartAccessoryReferenceSheetPreflightReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceSheetPreflightReadinessSummary(
            isReady: hasFixedPartAccessoryReferenceSheetPreflightMetadata
        )
    }

    static var fixedPartAccessoryReferenceSheetPanelNotes: [String] {
        [
            "softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette",
            "softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette",
            "softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette",
            "softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette",
            "softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette",
            "softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette",
            "softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette"
        ]
    }

    static var fixedPartAccessoryReferenceSheetPanelNoteRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartAccessoryReferenceSheetPanelNotesSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceSheetPanelNotesSummary(
            notes: fixedPartAccessoryReferenceSheetPanelNotes,
            requiredPanels: fixedPartAccessoryReferenceSheetPanelNoteRequiredPanels,
            preflightReady: hasFixedPartAccessoryReferenceSheetPreflightMetadata,
            grayscaleOnly: true,
            noColorPatternGlow: true,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartAccessoryReferenceSheetPanelNotesMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryReferenceSheetPanelNotesFields(
            notes: fixedPartAccessoryReferenceSheetPanelNotes,
            requiredPanels: fixedPartAccessoryReferenceSheetPanelNoteRequiredPanels,
            preflightReady: hasFixedPartAccessoryReferenceSheetPreflightMetadata,
            grayscaleOnly: true,
            noColorPatternGlow: true,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPartAccessoryReferenceSheetPanelNotesSummary
        )
    }

    static var fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary(
            isReady: hasFixedPartAccessoryReferenceSheetPanelNotesMetadata
        )
    }

    static var fixedPartAccessoryManualReviewChecklistItems: [String] {
        [
            "softAccessoryScale",
            "socketOwnership",
            "silhouetteSecondary",
            "cuteReadability",
            "familyLikenessSafe",
            "grayscaleOnly",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ]
    }

    static var fixedPartAccessoryManualReviewChecklistSummary: String {
        RendererMetadataSummary.fixedPartAccessoryManualReviewChecklistSummary(
            reviewerRole: "CreatureArtDirector",
            checklistItems: fixedPartAccessoryManualReviewChecklistItems,
            preflightReady: hasFixedPartAccessoryReferenceSheetPreflightMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartAccessoryManualReviewChecklistMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryManualReviewChecklistFields(
            reviewerRole: "CreatureArtDirector",
            checklistItems: fixedPartAccessoryManualReviewChecklistItems,
            preflightReady: hasFixedPartAccessoryReferenceSheetPreflightMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartAccessoryManualReviewChecklistSummary
        )
    }

    static var fixedPartAccessoryManualReviewChecklistReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryManualReviewChecklistReadinessSummary(
            isReady: hasFixedPartAccessoryManualReviewChecklistMetadata
        )
    }

    static var fixedPartAccessoryReviewEvidenceFields: [String] {
        [
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "decisionReason",
            "affectionRisk",
            "revisionNotes"
        ]
    }

    static var fixedPartAccessoryReviewEvidenceHandoffSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReviewEvidenceHandoffSummary(
            checklistReady: hasFixedPartAccessoryManualReviewChecklistMetadata,
            evidenceFields: fixedPartAccessoryReviewEvidenceFields,
            evidenceRecorded: false,
            evidencePath: "",
            reviewerNote: "",
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartAccessoryReviewEvidenceHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryReviewEvidenceHandoffFields(
            checklistReady: hasFixedPartAccessoryManualReviewChecklistMetadata,
            evidenceFields: fixedPartAccessoryReviewEvidenceFields,
            evidenceRecorded: false,
            evidencePath: "",
            reviewerNote: "",
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPartAccessoryReviewEvidenceHandoffSummary
        )
    }

    static var fixedPartAccessoryReviewEvidenceHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryReviewEvidenceHandoffReadinessSummary(
            isReady: hasFixedPartAccessoryReviewEvidenceHandoffMetadata
        )
    }

    static var fixedPartAccessoryArtifactCandidateStem: String {
        "wipet_fixed_part_accessory_reference_sheet_v1"
    }

    static var fixedPartAccessoryArtifactCandidateRelativePath: String {
        "docs/For_Agent/reference_sheets/\(fixedPartAccessoryArtifactCandidateStem).png"
    }

    static var fixedPartAccessoryArtifactCandidateRecordSummary: String {
        RendererMetadataSummary.fixedPartAccessoryArtifactCandidateRecordSummary(
            artifactStem: fixedPartAccessoryArtifactCandidateStem,
            relativePath: fixedPartAccessoryArtifactCandidateRelativePath,
            format: "png",
            surface: "fixedPartAccessoryReferenceSheet",
            evidenceHandoffReady: hasFixedPartAccessoryReviewEvidenceHandoffMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartAccessoryArtifactCandidateRecordMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAccessoryArtifactCandidateRecordFields(
            artifactStem: fixedPartAccessoryArtifactCandidateStem,
            relativePath: fixedPartAccessoryArtifactCandidateRelativePath,
            format: "png",
            surface: "fixedPartAccessoryReferenceSheet",
            evidenceHandoffReady: hasFixedPartAccessoryReviewEvidenceHandoffMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPartAccessoryArtifactCandidateRecordSummary
        )
    }

    static var fixedPartAccessoryArtifactCandidateRecordReadinessSummary: String {
        RendererMetadataSummary.fixedPartAccessoryArtifactCandidateRecordReadinessSummary(
            isReady: hasFixedPartAccessoryArtifactCandidateRecordMetadata
        )
    }

    static var fixedPartAssetSocketFaceMappings: [String] {
        [
            "softRound->FaceBase.round@headCenter",
            "softPetal->FaceBase.fairy@headCenter",
            "softBroad->FaceBase.dragon@headCenter",
            "softWide->FaceBase.axolotl@headCenter",
            "softFacet->FaceBase.crystal@headCenter",
            "softDeer->FaceBase.deer@headCenter",
            "softFeline->FaceBase.feline@headCenter",
            "softCrescent->FaceBase.lunar@headCenter"
        ]
    }

    static var fixedPartAssetSocketUpperBodyMappings: [String] {
        [
            "softOval->UpperBody.juvenile@bodyCenter",
            "waterDrop->UpperBody.aquarian@bodyCenter",
            "seedPetal->UpperBody.sylphian@bodyCenter",
            "pebbleGem->UpperBody.crystalian@bodyCenter",
            "moonOval->UpperBody.lunarian@bodyCenter",
            "leafBelly->UpperBody.verdant@bodyCenter"
        ]
    }

    static var fixedPartAssetSocketWingMappings: [String] {
        [
            "softLunar->WingBase.lunar@leftWingRoot+rightWingRoot",
            "softLeaf->WingBase.fairy@leftWingRoot+rightWingRoot",
            "softSail->WingBase.dragon@leftWingRoot+rightWingRoot",
            "softFacet->WingBase.crystal@leftWingRoot+rightWingRoot",
            "softBell->WingBase.jellyfish@leftWingRoot+rightWingRoot",
            "softSprout->WingBase.plant@leftWingRoot+rightWingRoot"
        ]
    }

    static var fixedPartAssetSocketTailMappings: [String] {
        [
            "roundedRibbon->TailBase.floating@tailRoot",
            "fishTaper->TailBase.fish@tailRoot",
            "dragonTaper->TailBase.dragon@tailRoot",
            "softFacet->TailBase.crystal@tailRoot",
            "leafSprout->TailBase.plant@tailRoot"
        ]
    }

    static var fixedPartAssetSocketIDs: [String] {
        [
            "bodyCenter",
            "headCenter",
            "leftWingRoot",
            "rightWingRoot",
            "tailRoot"
        ]
    }

    static var fixedPartAssetSocketMappingSummary: String {
        RendererMetadataSummary.fixedPartAssetSocketMappingSummary(
            faceMappings: fixedPartAssetSocketFaceMappings,
            upperBodyMappings: fixedPartAssetSocketUpperBodyMappings,
            wingMappings: fixedPartAssetSocketWingMappings,
            tailMappings: fixedPartAssetSocketTailMappings,
            socketIDs: fixedPartAssetSocketIDs,
            assetOutputs: "none",
            validated3DAssets: false
        )
    }

    static var hasFixedPartAssetSocketMappingMetadata: Bool {
        RendererMetadataSummary.hasFixedPartAssetSocketMappingFields(
            faceMappings: fixedPartAssetSocketFaceMappings,
            upperBodyMappings: fixedPartAssetSocketUpperBodyMappings,
            wingMappings: fixedPartAssetSocketWingMappings,
            tailMappings: fixedPartAssetSocketTailMappings,
            socketIDs: fixedPartAssetSocketIDs,
            assetOutputs: "none",
            summary: fixedPartAssetSocketMappingSummary
        )
    }

    static var fixedPartAssetSocketMappingReadinessSummary: String {
        RendererMetadataSummary.fixedPartAssetSocketMappingReadinessSummary(
            isReady: hasFixedPartAssetSocketMappingMetadata
        )
    }

    static var fixedPartUpperBodyProportionHandoffMappings: [String] {
        [
            "waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue",
            "seedPetal|petalSlim|tallSprout|lightFairySeed->UpperBody.sylphian@bodyCenter#proportionCue",
            "pebbleGem|gemBalanced|tallFacet|softPebbleGem->UpperBody.crystalian@bodyCenter#proportionCue",
            "moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue",
            "leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue"
        ]
    }

    static var fixedPartUpperBodyProportionHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram"
        ]
    }

    static var fixedPartUpperBodyProportionHandoffSummary: String {
        RendererMetadataSummary.fixedPartUpperBodyProportionHandoffSummary(
            mappings: fixedPartUpperBodyProportionHandoffMappings,
            socketID: "bodyCenter",
            rigTarget: "body",
            requiredPanels: fixedPartUpperBodyProportionHandoffRequiredPanels,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartUpperBodyProportionHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartUpperBodyProportionHandoffFields(
            mappings: fixedPartUpperBodyProportionHandoffMappings,
            socketID: "bodyCenter",
            rigTarget: "body",
            requiredPanels: fixedPartUpperBodyProportionHandoffRequiredPanels,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPartUpperBodyProportionHandoffSummary
        )
    }

    static var fixedPartUpperBodyProportionHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartUpperBodyProportionHandoffReadinessSummary(
            isReady: hasFixedPartUpperBodyProportionHandoffMetadata
        )
    }

    static var fixedPartTailFloatingHandoffMapping: String {
        "floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue"
    }

    static var fixedPartTailFloatingHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartTailFloatingHandoffSummary: String {
        RendererMetadataSummary.fixedPartTailFloatingHandoffSummary(
            mapping: fixedPartTailFloatingHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailFloatingHandoffRequiredPanels,
            acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartTailFloatingHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartTailFloatingHandoffFields(
            mapping: fixedPartTailFloatingHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailFloatingHandoffRequiredPanels,
            acceptedSpriteKitCue: "floatingRibbon+softTetherDot",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartTailFloatingHandoffSummary
        )
    }

    static var fixedPartTailFloatingHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartTailFloatingHandoffReadinessSummary(
            isReady: hasFixedPartTailFloatingHandoffMetadata
        )
    }

    static var fixedPartTailDragonHandoffMapping: String {
        "longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue"
    }

    static var fixedPartTailDragonHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartTailDragonHandoffSummary: String {
        RendererMetadataSummary.fixedPartTailDragonHandoffSummary(
            mapping: fixedPartTailDragonHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailDragonHandoffRequiredPanels,
            acceptedSpriteKitCue: "longDrake+softDrakeRidge",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartTailDragonHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartTailDragonHandoffFields(
            mapping: fixedPartTailDragonHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailDragonHandoffRequiredPanels,
            acceptedSpriteKitCue: "longDrake+softDrakeRidge",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartTailDragonHandoffSummary
        )
    }

    static var fixedPartTailDragonHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartTailDragonHandoffReadinessSummary(
            isReady: hasFixedPartTailDragonHandoffMetadata
        )
    }

    static var fixedPartTailFishHandoffMapping: String {
        "fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue"
    }

    static var fixedPartTailFishHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartTailFishHandoffSummary: String {
        RendererMetadataSummary.fixedPartTailFishHandoffSummary(
            mapping: fixedPartTailFishHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailFishHandoffRequiredPanels,
            acceptedSpriteKitCue: "fishFin+softForkFin",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartTailFishHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartTailFishHandoffFields(
            mapping: fixedPartTailFishHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailFishHandoffRequiredPanels,
            acceptedSpriteKitCue: "fishFin+softForkFin",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartTailFishHandoffSummary
        )
    }

    static var fixedPartTailFishHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartTailFishHandoffReadinessSummary(
            isReady: hasFixedPartTailFishHandoffMetadata
        )
    }

    static var fixedPartTailPlantHandoffMapping: String {
        "leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue"
    }

    static var fixedPartTailPlantHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartTailPlantHandoffSummary: String {
        RendererMetadataSummary.fixedPartTailPlantHandoffSummary(
            mapping: fixedPartTailPlantHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailPlantHandoffRequiredPanels,
            acceptedSpriteKitCue: "leafSprout+softLeafVein",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartTailPlantHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartTailPlantHandoffFields(
            mapping: fixedPartTailPlantHandoffMapping,
            socketID: "tailRoot",
            rigTarget: "tail_1",
            requiredPanels: fixedPartTailPlantHandoffRequiredPanels,
            acceptedSpriteKitCue: "leafSprout+softLeafVein",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartTailPlantHandoffSummary
        )
    }

    static var fixedPartTailPlantHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartTailPlantHandoffReadinessSummary(
            isReady: hasFixedPartTailPlantHandoffMetadata
        )
    }

    static var fixedPartFaceDeerHandoffMapping: String {
        "softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue"
    }

    static var fixedPartFaceDeerHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartFaceDeerHandoffSummary: String {
        RendererMetadataSummary.fixedPartFaceDeerHandoffSummary(
            mapping: fixedPartFaceDeerHandoffMapping,
            socketID: "headCenter",
            rigTarget: "head",
            requiredPanels: fixedPartFaceDeerHandoffRequiredPanels,
            acceptedSpriteKitCue: "softDeer+softEarNubs",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartFaceDeerHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartFaceDeerHandoffFields(
            mapping: fixedPartFaceDeerHandoffMapping,
            socketID: "headCenter",
            rigTarget: "head",
            requiredPanels: fixedPartFaceDeerHandoffRequiredPanels,
            acceptedSpriteKitCue: "softDeer+softEarNubs",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartFaceDeerHandoffSummary
        )
    }

    static var fixedPartFaceDeerHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartFaceDeerHandoffReadinessSummary(
            isReady: hasFixedPartFaceDeerHandoffMetadata
        )
    }

    static var fixedPartFaceFelineHandoffMapping: String {
        "softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue"
    }

    static var fixedPartFaceFelineHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartFaceFelineHandoffSummary: String {
        RendererMetadataSummary.fixedPartFaceFelineHandoffSummary(
            mapping: fixedPartFaceFelineHandoffMapping,
            socketID: "headCenter",
            rigTarget: "head",
            requiredPanels: fixedPartFaceFelineHandoffRequiredPanels,
            acceptedSpriteKitCue: "softFeline+softEarTips",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartFaceFelineHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartFaceFelineHandoffFields(
            mapping: fixedPartFaceFelineHandoffMapping,
            socketID: "headCenter",
            rigTarget: "head",
            requiredPanels: fixedPartFaceFelineHandoffRequiredPanels,
            acceptedSpriteKitCue: "softFeline+softEarTips",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartFaceFelineHandoffSummary
        )
    }

    static var fixedPartFaceFelineHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartFaceFelineHandoffReadinessSummary(
            isReady: hasFixedPartFaceFelineHandoffMetadata
        )
    }

    static var fixedPartWingFairyHandoffMapping: String {
        "leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue"
    }

    static var fixedPartWingFairyHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartWingFairyHandoffSummary: String {
        RendererMetadataSummary.fixedPartWingFairyHandoffSummary(
            mapping: fixedPartWingFairyHandoffMapping,
            socketIDs: ["leftWingRoot", "rightWingRoot"],
            rigTargets: ["wing_L", "wing_R"],
            requiredPanels: fixedPartWingFairyHandoffRequiredPanels,
            acceptedSpriteKitCue: "leafPair+softWingTipPearl",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartWingFairyHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartWingFairyHandoffFields(
            mapping: fixedPartWingFairyHandoffMapping,
            socketIDs: ["leftWingRoot", "rightWingRoot"],
            rigTargets: ["wing_L", "wing_R"],
            requiredPanels: fixedPartWingFairyHandoffRequiredPanels,
            acceptedSpriteKitCue: "leafPair+softWingTipPearl",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartWingFairyHandoffSummary
        )
    }

    static var fixedPartWingFairyHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartWingFairyHandoffReadinessSummary(
            isReady: hasFixedPartWingFairyHandoffMetadata
        )
    }

    static var fixedPartWingDragonHandoffMapping: String {
        "wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue"
    }

    static var fixedPartWingDragonHandoffRequiredPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]
    }

    static var fixedPartWingDragonHandoffSummary: String {
        RendererMetadataSummary.fixedPartWingDragonHandoffSummary(
            mapping: fixedPartWingDragonHandoffMapping,
            socketIDs: ["leftWingRoot", "rightWingRoot"],
            rigTargets: ["wing_L", "wing_R"],
            requiredPanels: fixedPartWingDragonHandoffRequiredPanels,
            acceptedSpriteKitCue: "wideSail+softWingTipClaw",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartWingDragonHandoffMetadata: Bool {
        RendererMetadataSummary.hasFixedPartWingDragonHandoffFields(
            mapping: fixedPartWingDragonHandoffMapping,
            socketIDs: ["leftWingRoot", "rightWingRoot"],
            rigTargets: ["wing_L", "wing_R"],
            requiredPanels: fixedPartWingDragonHandoffRequiredPanels,
            acceptedSpriteKitCue: "wideSail+softWingTipClaw",
            generatedAssets: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartWingDragonHandoffSummary
        )
    }

    static var fixedPartWingDragonHandoffReadinessSummary: String {
        RendererMetadataSummary.fixedPartWingDragonHandoffReadinessSummary(
            isReady: hasFixedPartWingDragonHandoffMetadata
        )
    }

    static var fixedPartLineageCueReferenceBodyAnnotations: [String] {
        [
            "softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue",
            "softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue"
        ]
    }

    static var fixedPartChildDraftLineageCueReferenceFaceAnnotations: [String] {
        [
            "softDeer->FaceBase.deer@headCenter#lineageCue",
            "forestDots->FaceBase.deer@headCenter#lineageCue"
        ]
    }

    static var fixedPartLineageCueReferenceTailAnnotations: [String] {
        [
            "softTailMemoryDots->TailBase.floating@tailRoot#lineageCue"
        ]
    }

    static var fixedPartLineageCueReferenceRequiredPanels: [String] {
        [
            "lineageCue",
            "socketDiagram",
            "rigDiagram"
        ]
    }

    static var fixedPartChildDraftLineageCueReferenceRequiredPanels: [String] {
        [
            "childDraftPortrait",
            "lineageCue",
            "socketDiagram",
            "rigDiagram"
        ]
    }

    static var fixedPartChildDraftLineageCueReferenceSocketMappings: [String] {
        [
            "headCenter->head",
            "bodyCenter->body",
            "tailRoot->tail_1"
        ]
    }

    static var fixedPartLineageCueSetReferenceSheetPanels: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "lineageCue"
        ]
    }

    static var fixedPartLineageCueSetReferenceSheetSocketMappings: [String] {
        [
            "bodyCenter->body",
            "tailRoot->tail_1"
        ]
    }

    static var fixedPartReferenceSheetPanelRoles: [String] {
        [
            "frontView:silhouette",
            "sideView:depth",
            "threeQuarterView:volume",
            "socketDiagram:bodyTailSockets",
            "rigDiagram:CommonPetRig",
            "lineageCue:softLineageCueSet"
        ]
    }

    static var fixedPartReferenceSheetPanelReadingOrder: [String] {
        [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "lineageCue"
        ]
    }

    static var fixedPartReferenceSheetPanelCallouts: [String] {
        [
            "cuteSilhouette",
            "bodyCenter",
            "tailRoot",
            "CommonPetRig",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ]
    }

    static var fixedPartReferenceSheetArtifactStem: String {
        "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
    }

    static var fixedPartReferenceSheetArtifactRelativePath: String {
        "docs/For_Agent/reference_sheets/\(fixedPartReferenceSheetArtifactStem).png"
    }

    static var fixedPartReferenceSheetManualReviewChecklistItems: [String] {
        [
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
    }

    static var fixedPartReferenceSheetManualReviewAllowedStates: [String] {
        [
            "notStarted",
            "needsRevision",
            "accepted"
        ]
    }

    static var fixedPartReferenceSheetReviewEvidenceFields: [String] {
        [
            "artifactPath",
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "snapshotReference",
            "decisionReason"
        ]
    }

    static var fixedPartLineageCueReferenceAnnotationSummary: String {
        RendererMetadataSummary.fixedPartLineageCueReferenceAnnotationSummary(
            bodyAnnotations: fixedPartLineageCueReferenceBodyAnnotations,
            tailAnnotations: fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartLineageCueReferenceRequiredPanels,
            assetOutputs: "none",
            generatedAssets: false
        )
    }

    static var hasFixedPartLineageCueReferenceAnnotationMetadata: Bool {
        RendererMetadataSummary.hasFixedPartLineageCueReferenceAnnotationFields(
            bodyAnnotations: fixedPartLineageCueReferenceBodyAnnotations,
            tailAnnotations: fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartLineageCueReferenceRequiredPanels,
            assetOutputs: "none",
            generatedAssets: false,
            summary: fixedPartLineageCueReferenceAnnotationSummary
        )
    }

    static var fixedPartLineageCueReferenceAnnotationReadinessSummary: String {
        RendererMetadataSummary.fixedPartLineageCueReferenceAnnotationReadinessSummary(
            isReady: hasFixedPartLineageCueReferenceAnnotationMetadata
        )
    }

    static var fixedPartChildDraftLineageCueReferenceSummary: String {
        RendererMetadataSummary.fixedPartChildDraftLineageCueReferenceSummary(
            faceAnnotations: fixedPartChildDraftLineageCueReferenceFaceAnnotations,
            bodyAnnotations: fixedPartLineageCueReferenceBodyAnnotations,
            tailAnnotations: fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartChildDraftLineageCueReferenceRequiredPanels,
            socketMappings: fixedPartChildDraftLineageCueReferenceSocketMappings,
            sourceSurface: "genomeVariationChildDraft",
            assetOutputs: "none",
            generatedAssets: false
        )
    }

    static var hasFixedPartChildDraftLineageCueReferenceMetadata: Bool {
        RendererMetadataSummary.hasFixedPartChildDraftLineageCueReferenceFields(
            faceAnnotations: fixedPartChildDraftLineageCueReferenceFaceAnnotations,
            bodyAnnotations: fixedPartLineageCueReferenceBodyAnnotations,
            tailAnnotations: fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartChildDraftLineageCueReferenceRequiredPanels,
            socketMappings: fixedPartChildDraftLineageCueReferenceSocketMappings,
            sourceSurface: "genomeVariationChildDraft",
            assetOutputs: "none",
            generatedAssets: false,
            summary: fixedPartChildDraftLineageCueReferenceSummary
        )
    }

    static var fixedPartChildDraftLineageCueReferenceReadinessSummary: String {
        RendererMetadataSummary.fixedPartChildDraftLineageCueReferenceReadinessSummary(
            isReady: hasFixedPartChildDraftLineageCueReferenceMetadata
        )
    }

    static var fixedPartChildDraftLineageCueAcceptanceGateSummary: String {
        RendererMetadataSummary.fixedPartChildDraftLineageCueAcceptanceGateSummary(
            sourceSurface: "genomeVariationChildDraft",
            childDraftReferenceReady: hasFixedPartChildDraftLineageCueReferenceMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            referenceImageAccepted: false,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartChildDraftLineageCueAcceptanceGateMetadata: Bool {
        RendererMetadataSummary.hasFixedPartChildDraftLineageCueAcceptanceGateFields(
            sourceSurface: "genomeVariationChildDraft",
            childDraftReferenceReady: hasFixedPartChildDraftLineageCueReferenceMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            referenceImageAccepted: false,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPartChildDraftLineageCueAcceptanceGateSummary
        )
    }

    static var fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary: String {
        RendererMetadataSummary.fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary(
            isReady: hasFixedPartChildDraftLineageCueAcceptanceGateMetadata
        )
    }

    static var fixedPartLineageCueSetReferenceSheetSummary: String {
        RendererMetadataSummary.fixedPartLineageCueSetReferenceSheetSummary(
            cueSetID: "softLineageCueSet",
            cueAnnotations: fixedPartLineageCueReferenceBodyAnnotations
                + fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartLineageCueSetReferenceSheetPanels,
            socketMappings: fixedPartLineageCueSetReferenceSheetSocketMappings,
            grayscaleOnly: true,
            excludesColorPatternGlow: true,
            geometryGenerated: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartLineageCueSetReferenceSheetMetadata: Bool {
        RendererMetadataSummary.hasFixedPartLineageCueSetReferenceSheetFields(
            cueSetID: "softLineageCueSet",
            cueAnnotations: fixedPartLineageCueReferenceBodyAnnotations
                + fixedPartLineageCueReferenceTailAnnotations,
            requiredPanels: fixedPartLineageCueSetReferenceSheetPanels,
            socketMappings: fixedPartLineageCueSetReferenceSheetSocketMappings,
            grayscaleOnly: true,
            excludesColorPatternGlow: true,
            geometryGenerated: false,
            assetOutputs: "none",
            summary: fixedPartLineageCueSetReferenceSheetSummary
        )
    }

    static var fixedPartLineageCueSetReferenceSheetReadinessSummary: String {
        RendererMetadataSummary.fixedPartLineageCueSetReferenceSheetReadinessSummary(
            isReady: hasFixedPartLineageCueSetReferenceSheetMetadata
        )
    }

    static var fixedPartReferenceSheetPanelLayoutSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetPanelLayoutSummary(
            cueSetID: "softLineageCueSet",
            panelRoles: fixedPartReferenceSheetPanelRoles,
            readingOrder: fixedPartReferenceSheetPanelReadingOrder,
            requiredCallouts: fixedPartReferenceSheetPanelCallouts,
            generatedReferenceSheet: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetPanelLayoutMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetPanelLayoutFields(
            cueSetID: "softLineageCueSet",
            panelRoles: fixedPartReferenceSheetPanelRoles,
            readingOrder: fixedPartReferenceSheetPanelReadingOrder,
            requiredCallouts: fixedPartReferenceSheetPanelCallouts,
            generatedReferenceSheet: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetPanelLayoutSummary
        )
    }

    static var fixedPartReferenceSheetPanelLayoutReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetPanelLayoutReadinessSummary(
            isReady: hasFixedPartReferenceSheetPanelLayoutMetadata
        )
    }

    static var fixedPartReferenceSheetAcceptanceGateSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetAcceptanceGateSummary(
            cueSetID: "softLineageCueSet",
            lineageReferenceReady: hasFixedPartLineageCueSetReferenceSheetMetadata,
            panelLayoutReady: hasFixedPartReferenceSheetPanelLayoutMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            generatedReferenceSheet: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetAcceptanceGateMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetAcceptanceGateFields(
            cueSetID: "softLineageCueSet",
            lineageReferenceReady: hasFixedPartLineageCueSetReferenceSheetMetadata,
            panelLayoutReady: hasFixedPartReferenceSheetPanelLayoutMetadata,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            generatedReferenceSheet: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetAcceptanceGateSummary
        )
    }

    static var fixedPartReferenceSheetAcceptanceGateReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetAcceptanceGateReadinessSummary(
            isReady: hasFixedPartReferenceSheetAcceptanceGateMetadata
        )
    }

    static var fixedPartReferenceSheetArtifactNamingSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetArtifactNamingSummary(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            relativePath: fixedPartReferenceSheetArtifactRelativePath,
            format: "png",
            surface: "fixedPartReferenceSheet",
            cueSetID: "softLineageCueSet",
            generatedReferenceSheet: false,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetArtifactNamingMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetArtifactNamingFields(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            relativePath: fixedPartReferenceSheetArtifactRelativePath,
            format: "png",
            surface: "fixedPartReferenceSheet",
            cueSetID: "softLineageCueSet",
            generatedReferenceSheet: false,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetArtifactNamingSummary
        )
    }

    static var fixedPartReferenceSheetArtifactNamingReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetArtifactNamingReadinessSummary(
            isReady: hasFixedPartReferenceSheetArtifactNamingMetadata
        )
    }

    static var fixedPartReferenceSheetManualReviewChecklistSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetManualReviewChecklistSummary(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            reviewerRole: "CreatureArtDirector",
            checklistItems: fixedPartReferenceSheetManualReviewChecklistItems,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetManualReviewChecklistMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewChecklistFields(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            reviewerRole: "CreatureArtDirector",
            checklistItems: fixedPartReferenceSheetManualReviewChecklistItems,
            manualArtDirectionReviewed: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetManualReviewChecklistSummary
        )
    }

    static var fixedPartReferenceSheetManualReviewChecklistReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetManualReviewChecklistReadinessSummary(
            isReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata
        )
    }

    static var fixedPartReferenceSheetManualReviewResultStateSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetManualReviewResultStateSummary(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            currentState: "notStarted",
            allowedStates: fixedPartReferenceSheetManualReviewAllowedStates,
            reviewerRole: "CreatureArtDirector",
            manualArtDirectionReviewed: false,
            revisionRequired: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetManualReviewResultStateMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetManualReviewResultStateFields(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            currentState: "notStarted",
            allowedStates: fixedPartReferenceSheetManualReviewAllowedStates,
            reviewerRole: "CreatureArtDirector",
            manualArtDirectionReviewed: false,
            revisionRequired: false,
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetManualReviewResultStateSummary
        )
    }

    static var fixedPartReferenceSheetManualReviewResultStateReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetManualReviewResultStateReadinessSummary(
            isReady: hasFixedPartReferenceSheetManualReviewResultStateMetadata
        )
    }

    static var fixedPartReferenceSheetReviewEvidenceFieldsSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetReviewEvidenceFieldsSummary(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            evidenceFields: fixedPartReferenceSheetReviewEvidenceFields,
            evidenceRecorded: false,
            evidencePath: "",
            reviewerNote: "",
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetReviewEvidenceFields(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            evidenceFields: fixedPartReferenceSheetReviewEvidenceFields,
            evidenceRecorded: false,
            evidencePath: "",
            reviewerNote: "",
            snapshotReferenceAccepted: false,
            generationAllowed: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetReviewEvidenceFieldsSummary
        )
    }

    static var fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary(
            isReady: hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata
        )
    }

    static var fixedPartReferenceSheetPNGCandidatePreflightSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetPNGCandidatePreflightSummary(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            artifactNamingReady: hasFixedPartReferenceSheetArtifactNamingMetadata,
            manualChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            manualReviewStateReady: hasFixedPartReferenceSheetManualReviewResultStateMetadata,
            reviewEvidenceFieldsReady: hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPartReferenceSheetPNGCandidatePreflightMetadata: Bool {
        RendererMetadataSummary.hasFixedPartReferenceSheetPNGCandidatePreflightFields(
            artifactStem: fixedPartReferenceSheetArtifactStem,
            artifactNamingReady: hasFixedPartReferenceSheetArtifactNamingMetadata,
            manualChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            manualReviewStateReady: hasFixedPartReferenceSheetManualReviewResultStateMetadata,
            reviewEvidenceFieldsReady: hasFixedPartReferenceSheetReviewEvidenceFieldsMetadata,
            candidateExists: false,
            generationAllowed: false,
            snapshotReferenceAccepted: false,
            runtimeLoaded: false,
            assetOutputs: "none",
            summary: fixedPartReferenceSheetPNGCandidatePreflightSummary
        )
    }

    static var fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary: String {
        RendererMetadataSummary.fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary(
            isReady: hasFixedPartReferenceSheetPNGCandidatePreflightMetadata
        )
    }

    static var fixedPart3DManifestSummary: String {
        RendererMetadataSummary.fixedPart3DManifestSummary(
            assetStems: fixedPart3DManifestAssetStems,
            formats: fixedPart3DManifestFormats,
            rigName: "CommonPetRig",
            requiredBones: fixedPart3DManifestRequiredBones,
            socketMappings: fixedPart3DManifestSocketMappings,
            grayscaleOnly: true,
            excludesColorPatternGlow: true,
            validatedAssets: false,
            generatedAssets: false
        )
    }

    static var hasFixedPart3DManifestMetadata: Bool {
        RendererMetadataSummary.hasFixedPart3DManifestFields(
            assetStems: fixedPart3DManifestAssetStems,
            formats: fixedPart3DManifestFormats,
            rigName: "CommonPetRig",
            requiredBones: fixedPart3DManifestRequiredBones,
            socketMappings: fixedPart3DManifestSocketMappings,
            grayscaleOnly: true,
            excludesColorPatternGlow: true,
            validatedAssets: false,
            generatedAssets: false,
            summary: fixedPart3DManifestSummary
        )
    }

    static var fixedPart3DManifestReadinessSummary: String {
        RendererMetadataSummary.fixedPart3DManifestReadinessSummary(
            isReady: hasFixedPart3DManifestMetadata
        )
    }

    static var fixedPart3DReferenceAcceptanceGateSummary: String {
        RendererMetadataSummary.fixedPart3DReferenceAcceptanceGateSummary(
            cueSetID: "softLineageCueSet",
            referenceSheetReady: hasFixedPartLineageCueSetReferenceSheetMetadata,
            panelLayoutReady: hasFixedPartReferenceSheetPanelLayoutMetadata,
            referenceAcceptanceReady: hasFixedPartReferenceSheetAcceptanceGateMetadata,
            artifactNamingReady: hasFixedPartReferenceSheetArtifactNamingMetadata,
            manualReviewChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            childDraftGateReady: hasFixedPartChildDraftLineageCueAcceptanceGateMetadata,
            modelIODeferred: true,
            sceneKitDeferred: true,
            realityKitDeferred: true,
            generationAllowed: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none"
        )
    }

    static var hasFixedPart3DReferenceAcceptanceGateMetadata: Bool {
        RendererMetadataSummary.hasFixedPart3DReferenceAcceptanceGateFields(
            cueSetID: "softLineageCueSet",
            referenceSheetReady: hasFixedPartLineageCueSetReferenceSheetMetadata,
            panelLayoutReady: hasFixedPartReferenceSheetPanelLayoutMetadata,
            referenceAcceptanceReady: hasFixedPartReferenceSheetAcceptanceGateMetadata,
            artifactNamingReady: hasFixedPartReferenceSheetArtifactNamingMetadata,
            manualReviewChecklistReady: hasFixedPartReferenceSheetManualReviewChecklistMetadata,
            childDraftGateReady: hasFixedPartChildDraftLineageCueAcceptanceGateMetadata,
            modelIODeferred: true,
            sceneKitDeferred: true,
            realityKitDeferred: true,
            generationAllowed: false,
            runtimeLoaded: false,
            generatedAssets: false,
            assetOutputs: "none",
            summary: fixedPart3DReferenceAcceptanceGateSummary
        )
    }

    static var fixedPart3DReferenceAcceptanceGateReadinessSummary: String {
        RendererMetadataSummary.fixedPart3DReferenceAcceptanceGateReadinessSummary(
            isReady: hasFixedPart3DReferenceAcceptanceGateMetadata
        )
    }

    static var commonPetRigSocketMapSummary: String {
        CommonPetRigSocketMap().summary
    }

    static var commonPetRigSocketMapReadinessSummary: String {
        CommonPetRigSocketMap().readinessSummary
    }

    static var commonPetRigAssetValidationPreflightSummary: String {
        CommonPetRigAssetValidationPreflight().summary
    }

    static var commonPetRigAssetValidationPreflightReadinessSummary: String {
        CommonPetRigAssetValidationPreflight().readinessSummary
    }

    private static var fixedPart3DManifestAssetStems: [String] {
        [
            "wipet_face_round_head_v001",
            "wipet_face_deer_head_v001",
            "wipet_upperbody_aquarian_baby_v001",
            "wipet_wing_plant_pair_v001",
            "wipet_tail_floating_tail_v001"
        ]
    }

    private static var fixedPart3DManifestFormats: [String] {
        ["glb", "usd"]
    }

    private static var fixedPart3DManifestRequiredBones: [String] {
        ["root", "body", "spine_1", "spine_2", "neck", "head", "wing_L", "wing_R", "tail_1"]
    }

    private static var fixedPart3DManifestSocketMappings: [String] {
        ["bodyCenter->body", "headCenter->head", "leftWingRoot->wing_L", "rightWingRoot->wing_R", "tailRoot->tail_1"]
    }
}

private extension CreatureRenderProfile {
    struct BodyStyle {
        let bodyRect: CGRect
        let bodyColor: SKColor
        let widthLabel: String
        let heightLabel: String
        let affectionLabel: String
    }

    struct FaceStyle {
        let headRect: CGRect
        let headColor: SKColor
        let mouthWidth: CGFloat
    }

    struct WingStyle {
        let xScale: CGFloat
        let yScale: CGFloat
        let rotationAdjustmentDegrees: CGFloat
        let leftWingColor: SKColor
        let rightWingColor: SKColor
    }

    struct TailStyle {
        let tailRect: CGRect
        let rotationDegrees: CGFloat
        let tailColor: SKColor
        let accent: TailAccent
    }

    static func tailLineageEchoDotCount(forGeneration generation: Int) -> Int {
        min(4, max(2, generation))
    }

    static func faceLineageEchoDotCount(forGeneration generation: Int) -> Int {
        min(3, max(2, generation / 2))
    }

    static func glowAura(for glow: Double, mysticism: Double) -> GlowAura {
        GlowAura(
            outerScale: CGFloat(1.04 + (glow * 0.08) + (mysticism * 0.010)),
            outerLineWidth: CGFloat(1.6 + (glow * 1.8)),
            outerGlowWidth: CGFloat(4 + (glow * 7)),
            outerAlpha: CGFloat(0.08 + (glow * 0.12) + (mysticism * 0.012)),
            moteCount: Self.glowMoteCount(for: glow),
            moteAlpha: CGFloat(0.14 + (glow * 0.20)),
            moteScale: CGFloat(0.82 + (glow * 0.36)),
            moteOffset: Self.glowMoteOffset(for: glow),
            glowLabel: expressionLabel(
                value: glow,
                low: "faint",
                middle: "soft",
                high: "deep"
            ),
            auraLabel: expressionLabel(
                value: glow,
                low: "smallHalo",
                middle: "quietHalo",
                high: "ancestralHalo"
            ),
            pulseLabel: expressionLabel(
                value: glow,
                low: "slowPulse",
                middle: "breathingPulse",
                high: "brightPulse"
            ),
            motePlacementLabel: expressionLabel(
                value: glow,
                low: "closeMotes",
                middle: "softOrbitMotes",
                high: "wideOrbitMotes"
            ),
            mysticismLabel: expressionLabel(
                value: mysticism,
                low: "quietAura",
                middle: "softMysticAura",
                high: "moonlitAura"
            ),
            mysticismHaloLabel: expressionLabel(
                value: mysticism,
                low: "faintMysticHalo",
                middle: "softMysticHalo",
                high: "deepMysticHalo"
            )
        )
    }

    static func glowMoteCount(for glow: Double) -> Int {
        switch glow {
        case ..<0.42:
            1
        case ..<0.70:
            2
        default:
            3
        }
    }

    static func glowMoteOffset(for glow: Double) -> CGPoint {
        switch glow {
        case ..<0.42:
            CGPoint(x: -1.6, y: 1.2)
        case ..<0.70:
            CGPoint(x: 0.8, y: 0.4)
        default:
            CGPoint(x: 1.8, y: -1.2)
        }
    }

    static func patternMarking(for contrast: Double) -> PatternMarking {
        PatternMarking(
            markLabel: expressionLabel(
                value: contrast,
                low: "faintDapples",
                middle: "softDapples",
                high: "clearDapples"
            ),
            placementLabel: "upperBelly",
            color: SKColor(red: 0.66, green: 0.73, blue: 0.82, alpha: 1),
            alpha: CGFloat(0.09 + (contrast * 0.19)),
            visibleSpotCount: Self.patternSpotCount(for: contrast),
            spotScale: CGFloat(0.86 + (contrast * 0.32)),
            spotSpread: CGFloat(0.92 + (contrast * 0.16)),
            spreadLabel: expressionLabel(
                value: contrast,
                low: "closeGather",
                middle: "softSpread",
                high: "wideSprinkle"
            )
        )
    }

    static func patternSpotCount(for contrast: Double) -> Int {
        switch contrast {
        case ..<0.48:
            2
        case ..<0.70:
            3
        default:
            4
        }
    }

    static func ancestralGlintCount(forGeneration generation: Int) -> Int {
        min(3, max(1, generation - 1))
    }

    static func growthStageCue(for stage: GrowthStage) -> GrowthStageCue {
        switch stage {
        case .egg:
            GrowthStageCue(stageLabel: "egg", scaleLabel: "shelled", postureLabel: "resting", bodyScale: 0.74)
        case .baby:
            GrowthStageCue(stageLabel: "baby", scaleLabel: "small", postureLabel: "curled", bodyScale: 0.86)
        case .juvenile:
            GrowthStageCue(stageLabel: "juvenile", scaleLabel: "familiar", postureLabel: "soft", bodyScale: 1.0)
        case .adult:
            GrowthStageCue(stageLabel: "adult", scaleLabel: "grown", postureLabel: "settled", bodyScale: 1.08)
        case .elder:
            GrowthStageCue(stageLabel: "elder", scaleLabel: "elderSoft", postureLabel: "ancestral", bodyScale: 1.04)
        }
    }

    static func growthHornBudCue(
        for hornGrowth: Double,
        stage: GrowthStage
    ) -> GrowthHornBudCue {
        let budLabel: String
        if hornGrowth >= 0.66 {
            budLabel = "softCrescentBud"
        } else if hornGrowth >= 0.24 {
            budLabel = "tinyRoundedBud"
        } else {
            budLabel = "dormantBud"
        }
        let visibleInPortrait = budLabel != "dormantBud"
        let budScale: CGFloat = budLabel == "softCrescentBud" ? 1.08 : 1.0

        return GrowthHornBudCue(
            geneLabel: "hornGrowth",
            budLabel: budLabel,
            stageLabel: growthStageCue(for: stage).stageLabel,
            softnessLabel: "rounded",
            visibleInPortrait: visibleInPortrait,
            budScale: visibleInPortrait ? budScale : 0,
            fillColor: SKColor(red: 0.93, green: 0.95, blue: 0.86, alpha: 1),
            strokeColor: SKColor.white.withAlphaComponent(0.62),
            glowWidth: visibleInPortrait ? 2.8 : 0
        )
    }

    static func growthTailTipCue(
        for tailGrowth: Double,
        tail: TailBase?
    ) -> GrowthTailTipCue {
        let visibleInPortrait = tailGrowth >= 0.52
        let cueLabel: String
        if tailGrowth >= 0.72 {
            cueLabel = "brightTailTipGlint"
        } else if visibleInPortrait {
            cueLabel = "softTailTipGlint"
        } else {
            cueLabel = "restingTailTip"
        }

        return GrowthTailTipCue(
            geneLabel: "tailGrowth",
            cueLabel: cueLabel,
            tailLabel: tailCue(for: tail),
            placementLabel: "tailTip",
            visibleInPortrait: visibleInPortrait,
            glintSize: CGFloat(4.8 + (tailGrowth * 4.2)),
            glintAlpha: visibleInPortrait ? CGFloat(0.34 + (tailGrowth * 0.18)) : 0,
            glowWidth: visibleInPortrait ? CGFloat(1.2 + (tailGrowth * 1.6)) : 0,
            color: SKColor.white
        )
    }

    static func personalityPosture(for personality: PersonalityGenes) -> PersonalityPosture {
        let curiosity = personality.curiosity.value
        let timidity = personality.timidity.value

        return PersonalityPosture(
            attentionLabel: postureAttentionLabel(curiosity: curiosity, timidity: timidity),
            timidityLabel: postureTimidityLabel(timidity: timidity),
            leanLabel: postureLeanLabel(curiosity: curiosity, timidity: timidity),
            rotationDegrees: postureRotationDegrees(curiosity: curiosity, timidity: timidity)
        )
    }

    static func expression(for personality: PersonalityGenes) -> Expression {
        let curiosity = personality.curiosity.value
        let energy = personality.energy.value
        let sociality = personality.sociality.value
        let timidity = personality.timidity.value

        return Expression(
            eyeXScale: CGFloat(0.94 + (curiosity * 0.14)),
            eyeYScale: CGFloat(0.90 + ((1 - timidity) * 0.16)),
            catchlightAlpha: CGFloat(0.72 + (sociality * 0.20)),
            catchlightSize: CGFloat(4.4 + (sociality * 1.2)),
            catchlightOffset: CGPoint(
                x: -2.4 + (curiosity * 0.8),
                y: timidity >= 0.7 ? 3.0 : 4.0 + (sociality * 0.5)
            ),
            gazeOffset: gazeOffset(curiosity: curiosity, timidity: timidity),
            cheekWarmthAlpha: CGFloat(0.12 + (sociality * 0.14)),
            cheekWarmthScale: CGFloat(1.05 + (sociality * 0.24)),
            opennessLabel: expressionLabel(
                value: (curiosity + (1 - timidity)) / 2,
                low: "soft",
                middle: "open",
                high: "wide"
            ),
            softnessLabel: expressionLabel(
                value: timidity,
                low: "steady",
                middle: "gentle",
                high: "shy"
            ),
            sparkleLabel: expressionLabel(
                value: sociality,
                low: "quiet",
                middle: "warm",
                high: "bright"
            ),
            gazeLabel: gazeLabel(curiosity: curiosity, timidity: timidity),
            catchlightStyleLabel: catchlightStyleLabel(sociality: sociality, timidity: timidity),
            catchlightPlacementLabel: catchlightPlacementLabel(curiosity: curiosity, timidity: timidity),
            cheekWarmthLabel: cheekWarmthLabel(sociality: sociality),
            cheekWarmthPlacementLabel: cheekWarmthPlacementLabel(sociality: sociality, timidity: timidity),
            mouthStyleLabel: mouthStyleLabel(sociality: sociality, energy: energy),
            mouthEnergyLabel: mouthEnergyLabel(energy: energy),
            mouthWidthLabel: mouthWidthLabel(sociality: sociality, energy: energy),
            mouthWidthAdjustment: mouthWidthAdjustment(sociality: sociality, energy: energy)
        )
    }

    static func gazeOffset(curiosity: Double, timidity: Double) -> CGPoint {
        if timidity >= 0.7 {
            return CGPoint(x: -0.35, y: -0.35)
        }

        if curiosity >= 0.7 {
            return CGPoint(x: 0.75, y: 0.10)
        }

        if curiosity >= 0.55 {
            return CGPoint(x: 0.55, y: 0)
        }

        return .zero
    }

    static func gazeLabel(curiosity: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "shyLowerGaze"
        }

        if curiosity >= 0.7 {
            return "curiousRightGaze"
        }

        if curiosity >= 0.55 {
            return "attentiveRightGaze"
        }

        return "centeredGaze"
    }

    static func blinkClosedScale(for personality: PersonalityGenes) -> CGFloat {
        if personality.timidity.value >= 0.7 {
            return 0.10
        }

        if personality.sociality.value >= 0.7 {
            return 0.16
        }

        return 0.14
    }

    static func blinkHoldDuration(for personality: PersonalityGenes) -> TimeInterval {
        if personality.timidity.value >= 0.7 {
            return 0.12
        }

        if personality.sociality.value >= 0.7 {
            return 0.06
        }

        return 0.07
    }

    static func blinkStyleLabel(for personality: PersonalityGenes) -> String {
        if personality.timidity.value >= 0.7 {
            return "shyLongBlink"
        }

        if personality.sociality.value >= 0.7 {
            return "brightQuickBlink"
        }

        return "softQuickBlink"
    }

    static func blinkDepthLabel(for personality: PersonalityGenes) -> String {
        if personality.timidity.value >= 0.7 {
            return "deepClose"
        }

        if personality.sociality.value >= 0.7 {
            return "lightClose"
        }

        return "softClose"
    }

    static func blinkHoldLabel(for personality: PersonalityGenes) -> String {
        if personality.timidity.value >= 0.7 {
            return "longHold"
        }

        if personality.sociality.value >= 0.7 {
            return "quickHold"
        }

        return "shortHold"
    }

    static func sleepinessBreathScale(for personality: PersonalityGenes) -> CGFloat {
        1.002 + (CGFloat(personality.sleepiness.value) * 0.008)
    }

    static func sleepinessBreathDuration(for personality: PersonalityGenes) -> TimeInterval {
        2.2 + (personality.sleepiness.value * 0.9)
    }

    static func sleepinessStyleLabel(for personality: PersonalityGenes) -> String {
        if personality.sleepiness.value >= 0.7 {
            return "drowsyRest"
        }

        if personality.sleepiness.value >= 0.45 {
            return "cozyRest"
        }

        return "alertRest"
    }

    static func sleepinessBreathLabel(for personality: PersonalityGenes) -> String {
        if personality.sleepiness.value >= 0.7 {
            return "deepBreath"
        }

        if personality.sleepiness.value >= 0.45 {
            return "softBreath"
        }

        return "lightBreath"
    }

    static func sleepinessPaceLabel(for personality: PersonalityGenes) -> String {
        if personality.sleepiness.value >= 0.7 {
            return "slowPace"
        }

        if personality.sleepiness.value >= 0.45 {
            return "quietPace"
        }

        return "awakePace"
    }

    static func catchlightStyleLabel(sociality: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "softLowGlint"
        }

        if sociality >= 0.7 {
            return "brightTinyGlint"
        }

        return "warmGlint"
    }

    static func catchlightPlacementLabel(curiosity: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "lowerLeft"
        }

        if curiosity >= 0.7 {
            return "upperCurious"
        }

        return "upperLeft"
    }

    static func cheekWarmthLabel(sociality: Double) -> String {
        if sociality >= 0.7 {
            return "friendlyWarmth"
        }

        if sociality >= 0.45 {
            return "softWarmth"
        }

        return "quietWarmth"
    }

    static func cheekWarmthPlacementLabel(sociality: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "shyLowCheeks"
        }

        if sociality >= 0.7 {
            return "openCheeks"
        }

        return "softCheeks"
    }

    static func postureAttentionLabel(curiosity: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "shyListening"
        }

        if curiosity >= 0.7 {
            return "curiousLean"
        }

        if curiosity >= 0.55 {
            return "attentiveLean"
        }

        return "centeredAttention"
    }

    static func postureTimidityLabel(timidity: Double) -> String {
        if timidity >= 0.7 {
            return "shyPresence"
        }

        if timidity >= 0.45 {
            return "gentlePresence"
        }

        return "steadyPresence"
    }

    static func postureLeanLabel(curiosity: Double, timidity: Double) -> String {
        if timidity >= 0.7 {
            return "shyBackLean"
        }

        if curiosity >= 0.7 {
            return "curiousRightLean"
        }

        if curiosity >= 0.55 {
            return "rightListeningLean"
        }

        return "centeredLean"
    }

    static func postureRotationDegrees(curiosity: Double, timidity: Double) -> CGFloat {
        if timidity >= 0.7 {
            return 0.6
        }

        if curiosity >= 0.7 {
            return -1.0
        }

        if curiosity >= 0.55 {
            return -0.7
        }

        return 0
    }

    static func mouthStyleLabel(sociality: Double, energy: Double) -> String {
        let warmth = (sociality + energy) / 2

        if warmth >= 0.68 {
            return "brightGreetingMouth"
        }

        if warmth >= 0.45 {
            return "softGreetingMouth"
        }

        return "quietMouth"
    }

    static func mouthEnergyLabel(energy: Double) -> String {
        if energy >= 0.68 {
            return "livelyEnergy"
        }

        if energy >= 0.42 {
            return "settledEnergy"
        }

        return "sleepyEnergy"
    }

    static func mouthWidthLabel(sociality: Double, energy: Double) -> String {
        let warmth = (sociality + energy) / 2

        if warmth >= 0.68 {
            return "openWidth"
        }

        if warmth >= 0.45 {
            return "softWidth"
        }

        return "quietWidth"
    }

    static func mouthWidthAdjustment(sociality: Double, energy: Double) -> CGFloat {
        let warmth = (sociality + energy) / 2

        if warmth >= 0.68 {
            return 2
        }

        if warmth >= 0.45 {
            return 1
        }

        return 0
    }

    static func expressionLabel(
        value: Double,
        low: String,
        middle: String,
        high: String
    ) -> String {
        switch value {
        case ..<0.4:
            low
        case ..<0.7:
            middle
        default:
            high
        }
    }

    static func motionLabel(
        value: Double,
        low: String,
        middle: String,
        high: String
    ) -> String {
        expressionLabel(value: value, low: low, middle: middle, high: high)
    }

    static func bodyStyle(for body: BodyBase) -> BodyStyle {
        switch body {
        case .aquarian:
            BodyStyle(
                bodyRect: CGRect(x: -86, y: -98, width: 172, height: 170),
                bodyColor: SKColor(red: 0.84, green: 0.92, blue: 0.91, alpha: 1),
                widthLabel: "wideSoft",
                heightLabel: "roundedBelly",
                affectionLabel: "gentleWaterPuff"
            )
        case .sylphian:
            BodyStyle(
                bodyRect: CGRect(x: -72, y: -101, width: 144, height: 172),
                bodyColor: SKColor(red: 0.88, green: 0.93, blue: 0.84, alpha: 1),
                widthLabel: "petalSlim",
                heightLabel: "tallSprout",
                affectionLabel: "lightFairySeed"
            )
        case .crystalian:
            BodyStyle(
                bodyRect: CGRect(x: -78, y: -107, width: 156, height: 184),
                bodyColor: SKColor(red: 0.88, green: 0.89, blue: 0.94, alpha: 1),
                widthLabel: "gemBalanced",
                heightLabel: "tallFacet",
                affectionLabel: "softPebbleGem"
            )
        case .lunarian:
            BodyStyle(
                bodyRect: CGRect(x: -80, y: -103, width: 160, height: 178),
                bodyColor: SKColor(red: 0.88, green: 0.91, blue: 0.87, alpha: 1),
                widthLabel: "moonBalanced",
                heightLabel: "quietOval",
                affectionLabel: "familiarMoonBelly"
            )
        case .verdant:
            BodyStyle(
                bodyRect: CGRect(x: -84, y: -96, width: 168, height: 166),
                bodyColor: SKColor(red: 0.86, green: 0.92, blue: 0.82, alpha: 1),
                widthLabel: "leafWide",
                heightLabel: "lowSprout",
                affectionLabel: "softLeafBelly"
            )
        }
    }

    static func bodyProportionCue(
        for body: BodyBase,
        style: BodyStyle
    ) -> BodyProportionCue {
        BodyProportionCue(
            bodyCue: bodyCue(for: body),
            widthLabel: style.widthLabel,
            heightLabel: style.heightLabel,
            affectionLabel: style.affectionLabel
        )
    }

    static func bodyAccent(for body: BodyBase) -> BodyAccent {
        switch body {
        case .aquarian:
            BodyAccent(
                kind: .bellyDrop,
                bodyCue: bodyCue(for: body),
                accent: "bellyDrop",
                color: SKColor.white,
                alpha: 0.22
            )
        case .sylphian:
            BodyAccent(
                kind: .petalChest,
                bodyCue: bodyCue(for: body),
                accent: "petalChest",
                color: SKColor.white,
                alpha: 0.25
            )
        case .crystalian:
            BodyAccent(
                kind: .softFacet,
                bodyCue: bodyCue(for: body),
                accent: "softFacet",
                color: SKColor.white,
                alpha: 0.24
            )
        case .lunarian:
            BodyAccent(
                kind: .crescentBelly,
                bodyCue: bodyCue(for: body),
                accent: "crescentBelly",
                color: SKColor.white,
                alpha: 0.23
            )
        case .verdant:
            BodyAccent(
                kind: .sproutBelly,
                bodyCue: bodyCue(for: body),
                accent: "sproutBelly",
                color: SKColor.white,
                alpha: 0.24
            )
        }
    }

    static func bodySilhouetteAccessory(for body: BodyBase) -> BodySilhouetteAccessory {
        switch body {
        case .sylphian:
            BodySilhouetteAccessory(
                accessory: .softShoulderPetals,
                bodyCue: bodyCue(for: body),
                accessoryCue: "softShoulderPetals",
                color: SKColor(red: 0.91, green: 0.97, blue: 0.88, alpha: 1),
                alpha: 0.74
            )
        case .lunarian:
            BodySilhouetteAccessory(
                accessory: .softMoonShoulderCrescents,
                bodyCue: bodyCue(for: body),
                accessoryCue: "softMoonShoulderCrescents",
                color: SKColor(red: 0.91, green: 0.91, blue: 1.00, alpha: 1),
                alpha: 0.62
            )
        case .verdant:
            BodySilhouetteAccessory(
                accessory: .leafShoulderNubs,
                bodyCue: bodyCue(for: body),
                accessoryCue: "leafShoulderNubs",
                color: SKColor(red: 0.87, green: 0.95, blue: 0.78, alpha: 1),
                alpha: 0.70
            )
        default:
            BodySilhouetteAccessory(
                accessory: .none,
                bodyCue: bodyCue(for: body),
                accessoryCue: "none",
                color: SKColor.clear,
                alpha: 0
            )
        }
    }

    static func faceStyle(for face: FaceBase) -> FaceStyle {
        switch face {
        case .round:
            FaceStyle(
                headRect: CGRect(x: -72, y: 4, width: 144, height: 132),
                headColor: SKColor(red: 0.96, green: 0.95, blue: 0.90, alpha: 1),
                mouthWidth: 30
            )
        case .fairy:
            FaceStyle(
                headRect: CGRect(x: -63, y: 12, width: 126, height: 116),
                headColor: SKColor(red: 0.95, green: 0.97, blue: 0.90, alpha: 1),
                mouthWidth: 24
            )
        case .dragon:
            FaceStyle(
                headRect: CGRect(x: -70, y: 8, width: 140, height: 120),
                headColor: SKColor(red: 0.94, green: 0.93, blue: 0.87, alpha: 1),
                mouthWidth: 32
            )
        case .axolotl:
            FaceStyle(
                headRect: CGRect(x: -78, y: 10, width: 156, height: 112),
                headColor: SKColor(red: 0.97, green: 0.93, blue: 0.90, alpha: 1),
                mouthWidth: 34
            )
        case .crystal:
            FaceStyle(
                headRect: CGRect(x: -69, y: 7, width: 138, height: 126),
                headColor: SKColor(red: 0.95, green: 0.96, blue: 0.91, alpha: 1),
                mouthWidth: 28
            )
        case .deer:
            FaceStyle(
                headRect: CGRect(x: -70, y: 8, width: 140, height: 124),
                headColor: SKColor(red: 0.96, green: 0.94, blue: 0.88, alpha: 1),
                mouthWidth: 26
            )
        case .feline:
            FaceStyle(
                headRect: CGRect(x: -68, y: 8, width: 136, height: 124),
                headColor: SKColor(red: 0.95, green: 0.94, blue: 0.89, alpha: 1),
                mouthWidth: 24
            )
        case .lunar:
            FaceStyle(
                headRect: CGRect(x: -70, y: 6, width: 140, height: 128),
                headColor: SKColor(red: 0.95, green: 0.95, blue: 0.88, alpha: 1),
                mouthWidth: 27
            )
        }
    }

    static func faceAccent(
        for face: FaceBase,
        generation: Int = 1,
        hasAncestorEcho: Bool = false
    ) -> FaceAccent {
        switch face {
        case .round:
            FaceAccent(
                kind: .softCheek,
                faceCue: faceCue(for: face),
                accent: "softCheek",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.20
            )
        case .fairy:
            FaceAccent(
                kind: .cheekGleam,
                faceCue: faceCue(for: face),
                accent: "cheekGleam",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.27
            )
        case .dragon:
            FaceAccent(
                kind: .muzzleGlow,
                faceCue: faceCue(for: face),
                accent: "muzzleGlow",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.22
            )
        case .axolotl:
            FaceAccent(
                kind: .sideCheekDots,
                faceCue: faceCue(for: face),
                accent: "sideCheekDots",
                dotCount: 2,
                color: SKColor.white,
                alpha: 0.24
            )
        case .crystal:
            FaceAccent(
                kind: .softFacet,
                faceCue: faceCue(for: face),
                accent: "softFacet",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.25
            )
        case .deer:
            FaceAccent(
                kind: .forestDots,
                faceCue: faceCue(for: face),
                accent: "forestDots",
                dotCount: hasAncestorEcho ? Self.forestDotCount(forGeneration: generation) : 3,
                color: SKColor.white,
                alpha: 0.28
            )
        case .feline:
            FaceAccent(
                kind: .kittenGleam,
                faceCue: faceCue(for: face),
                accent: "kittenGleam",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.24
            )
        case .lunar:
            FaceAccent(
                kind: .softCheek,
                faceCue: faceCue(for: face),
                accent: "moonCheek",
                dotCount: 0,
                color: SKColor.white,
                alpha: 0.23
            )
        }
    }

    static func forestDotCount(forGeneration generation: Int) -> Int {
        min(5, max(3, 3 + (generation / 4)))
    }

    static func faceSilhouetteAccessory(for face: FaceBase) -> FaceSilhouetteAccessory {
        switch face {
        case .deer:
            FaceSilhouetteAccessory(
                accessory: .softEarNubs,
                faceCue: faceCue(for: face),
                accessoryCue: "softEarNubs",
                color: SKColor(red: 0.96, green: 0.94, blue: 0.88, alpha: 1),
                alpha: 0.92
            )
        case .feline:
            FaceSilhouetteAccessory(
                accessory: .softEarTips,
                faceCue: faceCue(for: face),
                accessoryCue: "softEarTips",
                color: SKColor(red: 0.95, green: 0.94, blue: 0.89, alpha: 1),
                alpha: 0.90
            )
        default:
            FaceSilhouetteAccessory(
                accessory: .none,
                faceCue: faceCue(for: face),
                accessoryCue: "none",
                color: SKColor.clear,
                alpha: 0
            )
        }
    }

    static func wingStyle(for wing: WingBase?) -> WingStyle {
        switch wing {
        case .fairy:
            WingStyle(
                xScale: 0.84,
                yScale: 1.12,
                rotationAdjustmentDegrees: 8,
                leftWingColor: SKColor(red: 0.75, green: 0.88, blue: 0.86, alpha: 1),
                rightWingColor: SKColor(red: 0.77, green: 0.84, blue: 0.89, alpha: 1)
            )
        case .dragon:
            WingStyle(
                xScale: 1.14,
                yScale: 0.92,
                rotationAdjustmentDegrees: -5,
                leftWingColor: SKColor(red: 0.75, green: 0.81, blue: 0.86, alpha: 1),
                rightWingColor: SKColor(red: 0.75, green: 0.78, blue: 0.88, alpha: 1)
            )
        case .crystal:
            WingStyle(
                xScale: 0.98,
                yScale: 1.02,
                rotationAdjustmentDegrees: 3,
                leftWingColor: SKColor(red: 0.75, green: 0.82, blue: 0.90, alpha: 1),
                rightWingColor: SKColor(red: 0.72, green: 0.76, blue: 0.90, alpha: 1)
            )
        case .jellyfish:
            WingStyle(
                xScale: 0.90,
                yScale: 0.96,
                rotationAdjustmentDegrees: 12,
                leftWingColor: SKColor(red: 0.78, green: 0.86, blue: 0.88, alpha: 1),
                rightWingColor: SKColor(red: 0.76, green: 0.82, blue: 0.89, alpha: 1)
            )
        case .lunar:
            WingStyle(
                xScale: 1,
                yScale: 1,
                rotationAdjustmentDegrees: 0,
                leftWingColor: SKColor(red: 0.73, green: 0.82, blue: 0.88, alpha: 1),
                rightWingColor: SKColor(red: 0.72, green: 0.76, blue: 0.88, alpha: 1)
            )
        case .plant:
            WingStyle(
                xScale: 0.86,
                yScale: 1.10,
                rotationAdjustmentDegrees: 10,
                leftWingColor: SKColor(red: 0.75, green: 0.88, blue: 0.78, alpha: 1),
                rightWingColor: SKColor(red: 0.74, green: 0.86, blue: 0.80, alpha: 1)
            )
        case nil:
            WingStyle(
                xScale: 1,
                yScale: 1,
                rotationAdjustmentDegrees: 0,
                leftWingColor: SKColor(red: 0.73, green: 0.82, blue: 0.88, alpha: 1),
                rightWingColor: SKColor(red: 0.72, green: 0.76, blue: 0.88, alpha: 1)
            )
        }
    }

    static func wingAccent(for wing: WingBase?) -> WingAccent {
        switch wing {
        case .fairy:
            WingAccent(
                kind: .softVein,
                wingCue: wingCue(for: wing),
                accent: "softVein",
                color: SKColor.white,
                alpha: 0.42
            )
        case .dragon:
            WingAccent(
                kind: .softRim,
                wingCue: wingCue(for: wing),
                accent: "softRim",
                color: SKColor.white,
                alpha: 0.34
            )
        case .crystal:
            WingAccent(
                kind: .facetDot,
                wingCue: wingCue(for: wing),
                accent: "facetDot",
                color: SKColor.white,
                alpha: 0.46
            )
        case .jellyfish:
            WingAccent(
                kind: .bellDot,
                wingCue: wingCue(for: wing),
                accent: "bellDot",
                color: SKColor.white,
                alpha: 0.38
            )
        case .lunar:
            WingAccent(
                kind: .none,
                wingCue: wingCue(for: wing),
                accent: "none",
                color: SKColor.clear,
                alpha: 0
            )
        case .plant:
            WingAccent(
                kind: .softVein,
                wingCue: wingCue(for: wing),
                accent: "sproutVein",
                color: SKColor.white,
                alpha: 0.38
            )
        case nil:
            WingAccent(
                kind: .none,
                wingCue: wingCue(for: wing),
                accent: "none",
                color: SKColor.clear,
                alpha: 0
            )
        }
    }

    static func wingSilhouetteAccessory(for wing: WingBase?) -> WingSilhouetteAccessory {
        switch wing {
        case .fairy:
            WingSilhouetteAccessory(
                accessory: .softWingTipPearl,
                wingCue: wingCue(for: wing),
                accessoryCue: "softWingTipPearl",
                color: SKColor.white,
                alpha: 0.50
            )
        case .dragon:
            WingSilhouetteAccessory(
                accessory: .softWingTipClaw,
                wingCue: wingCue(for: wing),
                accessoryCue: "softWingTipClaw",
                color: SKColor.white,
                alpha: 0.42
            )
        default:
            WingSilhouetteAccessory(
                accessory: .none,
                wingCue: wingCue(for: wing),
                accessoryCue: "none",
                color: SKColor.clear,
                alpha: 0
            )
        }
    }

    static func tailStyle(for tail: TailBase?, growth: Double) -> TailStyle {
        let growthScale = CGFloat(1 + (growth * 0.14))
        let base: (width: CGFloat, height: CGFloat, rotation: CGFloat, color: SKColor)

        switch tail {
        case .dragon:
            base = (174, 30, 8, SKColor(red: 0.74, green: 0.78, blue: 0.88, alpha: 1))
        case .fish:
            base = (132, 40, 18, SKColor(red: 0.70, green: 0.84, blue: 0.88, alpha: 1))
        case .crystal:
            base = (146, 30, 16, SKColor(red: 0.76, green: 0.77, blue: 0.93, alpha: 1))
        case .floating:
            base = (156, 34, 13, SKColor(red: 0.73, green: 0.76, blue: 0.91, alpha: 1))
        case .plant:
            base = (138, 36, 14, SKColor(red: 0.70, green: 0.84, blue: 0.76, alpha: 1))
        case nil:
            base = (144, 32, 12, SKColor(red: 0.75, green: 0.79, blue: 0.89, alpha: 1))
        }

        let width = base.width * growthScale
        return TailStyle(
            tailRect: CGRect(x: -width / 2, y: -base.height / 2, width: width, height: base.height),
            rotationDegrees: base.rotation,
            tailColor: base.color,
            accent: tailAccent(for: tail)
        )
    }

    static func tailAccent(for tail: TailBase?) -> TailAccent {
        switch tail {
        case .fish:
            TailAccent(
                kind: .fishFin,
                color: SKColor(red: 0.82, green: 0.92, blue: 0.94, alpha: 1),
                alpha: 0.66
            )
        case .floating:
            TailAccent(
                kind: .floatingOrb,
                color: SKColor.white,
                alpha: 0.58
            )
        case .plant:
            TailAccent(
                kind: .leafBud,
                color: SKColor.white,
                alpha: 0.36
            )
        default:
            TailAccent(
                kind: .roundedCap,
                color: SKColor.white,
                alpha: 0.30
            )
        }
    }

    static func tailSilhouetteAccessory(for tail: TailBase?) -> TailSilhouetteAccessory {
        switch tail {
        case .dragon:
            TailSilhouetteAccessory(
                accessory: .softDrakeRidge,
                tailCue: tailCue(for: tail),
                accessoryCue: "softDrakeRidge",
                color: SKColor.white,
                alpha: 0.38
            )
        case .fish:
            TailSilhouetteAccessory(
                accessory: .softForkFin,
                tailCue: tailCue(for: tail),
                accessoryCue: "softForkFin",
                color: SKColor(red: 0.82, green: 0.92, blue: 0.94, alpha: 1),
                alpha: 0.56
            )
        case .floating:
            TailSilhouetteAccessory(
                accessory: .softTetherDot,
                tailCue: tailCue(for: tail),
                accessoryCue: "softTetherDot",
                color: SKColor.white,
                alpha: 0.46
            )
        case .plant:
            TailSilhouetteAccessory(
                accessory: .softLeafVein,
                tailCue: tailCue(for: tail),
                accessoryCue: "softLeafVein",
                color: SKColor.white,
                alpha: 0.44
            )
        default:
            TailSilhouetteAccessory(
                accessory: .none,
                tailCue: tailCue(for: tail),
                accessoryCue: "none",
                color: SKColor.clear,
                alpha: 0
            )
        }
    }

    static func visibleTraitCount(for morph: MorphGenes) -> Int {
        2
            + (morph.wing == nil ? 0 : 1)
            + (morph.tail == nil ? 0 : 1)
    }

    static func faceCue(for face: FaceBase) -> String {
        switch face {
        case .round:
            "softRound"
        case .fairy:
            "smallFairy"
        case .dragon:
            "broadDragon"
        case .axolotl:
            "wideAxolotl"
        case .crystal:
            "faceted"
        case .deer:
            "softDeer"
        case .feline:
            "softFeline"
        case .lunar:
            "softCrescent"
        }
    }

    static func bodyCue(for body: BodyBase) -> String {
        switch body {
        case .aquarian:
            "waterDrop"
        case .sylphian:
            "seedPetal"
        case .crystalian:
            "pebbleGem"
        case .lunarian:
            "moonOval"
        case .verdant:
            "leafBelly"
        }
    }

    static func wingCue(for wing: WingBase?) -> String {
        switch wing {
        case .fairy:
            "leafPair"
        case .dragon:
            "wideSail"
        case .crystal:
            "gemPair"
        case .jellyfish:
            "softBell"
        case .lunar:
            "softLunar"
        case .plant:
            "sproutLeaf"
        case nil:
            "none"
        }
    }

    static func tailCue(for tail: TailBase?) -> String {
        switch tail {
        case .dragon:
            "longDrake"
        case .fish:
            "fishFin"
        case .crystal:
            "gemTail"
        case .floating:
            "floatingRibbon"
        case .plant:
            "leafSprout"
        case nil:
            "none"
        }
    }
}
