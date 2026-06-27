import SpriteKit
import WiPetCore

enum CreatureLayerID: String, CaseIterable {
    case shadow
    case leftWing
    case rightWing
    case tail
    case body
    case head
    case glowRing
    case leftEye
    case rightEye
    case mouth

    var zPosition: CGFloat {
        switch self {
        case .shadow:
            -10
        case .leftWing, .rightWing:
            -4
        case .body:
            1
        case .glowRing:
            2
        case .tail:
            3
        case .head:
            4
        case .leftEye, .rightEye, .mouth:
            6
        }
    }
}

enum CreatureSocketID: String, CaseIterable {
    case bodyCenter
    case headCenter
    case leftWingRoot
    case rightWingRoot
    case tailRoot
    case leftEyeCenter
    case rightEyeCenter
    case mouthCenter
}

enum CreaturePartFamilyID: String, CaseIterable {
    case lunarWing
    case fairyWing
    case dragonWing
    case crystalWing
    case jellyfishWing
    case plantWing
    case floatingTail
    case dragonTail
    case fishTail
    case crystalTail
    case plantTail
    case softTail
    case juvenileBody
    case aquarianBody
    case sylphianBody
    case crystalianBody
    case lunarianBody
    case verdantBody
    case roundHead
    case fairyHead
    case dragonHead
    case axolotlHead
    case crystalHead
    case deerHead
    case felineHead
    case lunarHead
    case softEye
    case quietMouth
}

enum CreatureShapeRecipeID: String {
    case softLunarWing
    case softLeafWing
    case softSailWing
    case softFacetWing
    case softBellWing
    case softSproutWing
    case roundedRibbonTail
    case fishTaperTail
    case dragonTaperTail
    case softFacetTail
    case leafSproutTail
    case softOvalBody
    case waterDropBody
    case seedPetalBody
    case pebbleGemBody
    case moonOvalBody
    case leafBellyBody
    case softRoundHead
    case softPetalHead
    case softBroadHead
    case softWideHead
    case softFacetHead
    case softDeerHead
    case softFelineHead
    case softCrescentHead
    case softEyeDot
    case quietMouthLine
}

enum CreatureDetailRecipeID: String {
    case softVein
    case softRim
    case facetDot
    case bellDot
    case sproutVein
    case softWingTipPearl
    case softWingTipClaw
    case floatingOrb
    case fishFin
    case roundedCap
    case leafBud
    case softForkFin
    case softTetherDot
    case softDrakeRidge
    case softLeafVein
    case bellyDrop
    case petalChest
    case softFacetBody
    case crescentBelly
    case sproutBelly
    case softShoulderPetals
    case softMoonShoulderCrescents
    case leafShoulderNubs
    case softCheek
    case cheekGleam
    case muzzleGlow
    case sideCheekDots
    case softFacetFace
    case forestDots
    case kittenGleam
    case softWhiskerDots
    case moonCheek
    case softEarNubs
    case softEarTips
    case softCatchlight
    case tinyRoundedHornBud
}

enum CreatureAmbientRecipeID: String {
    case softGlowRing
    case quietGlowMotes
}

enum CreaturePatternRecipeID: String {
    case softBellyDapples
}

struct CreatureSocket {
    let id: CreatureSocketID
    let position: CGPoint
}

struct CreaturePartDescriptor {
    let layerID: CreatureLayerID
    let socketID: CreatureSocketID
}

struct CreatureFixedPartCatalogEntry {
    let familyID: CreaturePartFamilyID
    let layerIDs: [CreatureLayerID]
    let socketIDs: [CreatureSocketID]
    let shapeRecipeIDs: [CreatureShapeRecipeID]
    let detailRecipeIDs: [CreatureDetailRecipeID]
    let silhouetteIntent: String
    let affectionCue: String
}

struct CreatureFixedPartCatalog {
    let ambientRecipeIDs: [CreatureAmbientRecipeID]
    let patternRecipeIDs: [CreaturePatternRecipeID]
    let growthDetailRecipeIDs: [CreatureDetailRecipeID]
    let entries: [CreatureFixedPartCatalogEntry]

    var familyIDs: [CreaturePartFamilyID] {
        entries.map(\.familyID)
    }

    var silhouetteIntents: [String] {
        entries.map(\.silhouetteIntent)
    }

    var affectionCues: [String] {
        entries.map(\.affectionCue)
    }

    var shapeRecipeIDs: [CreatureShapeRecipeID] {
        entries.flatMap(\.shapeRecipeIDs)
    }

    var detailRecipeIDs: [CreatureDetailRecipeID] {
        entries.flatMap(\.detailRecipeIDs)
    }

    var ambientRecipeCoverageSummary: String {
        let recipes = ambientRecipeIDs.map(\.rawValue).joined(separator: ",")
        return "ambientRecipeCatalog=recipes:\(recipes.isEmpty ? "none" : recipes)"
    }

    var patternRecipeCoverageSummary: String {
        let recipes = patternRecipeIDs.map(\.rawValue).joined(separator: ",")
        return "patternRecipeCatalog=recipes:\(recipes.isEmpty ? "none" : recipes)"
    }

    var growthDetailRecipeCoverageSummary: String {
        let recipes = growthDetailRecipeIDs.map(\.rawValue).joined(separator: ",")
        return "growthDetailRecipeCatalog=recipes:\(recipes.isEmpty ? "none" : recipes)"
    }

    var coverageSummary: String {
        entries.map { entry in
            let layers = entry.layerIDs.map(\.rawValue).joined(separator: ",")
            let sockets = entry.socketIDs.map(\.rawValue).joined(separator: ",")
            return "\(entry.familyID.rawValue):\(layers)@\(sockets)"
        }
        .joined(separator: ";")
    }

    var shapeRecipeCoverageSummary: String {
        entries.map { entry in
            let recipes = entry.shapeRecipeIDs.map(\.rawValue).joined(separator: ",")
            return "\(entry.familyID.rawValue)#\(recipes)"
        }
        .joined(separator: ";")
    }

    var detailRecipeCoverageSummary: String {
        entries.map { entry in
            let recipes = entry.detailRecipeIDs.map(\.rawValue).joined(separator: ",")
            return "\(entry.familyID.rawValue)#\(recipes.isEmpty ? "none" : recipes)"
        }
        .joined(separator: ";")
    }

    var artDirectionSummary: String {
        RendererMetadataSummary.fixedPartCatalogArtDirectionSummary(
            familyIDs: familyIDs.map(\.rawValue),
            silhouetteIntents: silhouetteIntents,
            affectionCues: affectionCues,
            assetOutputs: "none",
            geometryChanged: false
        )
    }

    var hasArtDirectionMetadata: Bool {
        RendererMetadataSummary.hasFixedPartCatalogArtDirectionFields(
            familyIDs: familyIDs.map(\.rawValue),
            silhouetteIntents: silhouetteIntents,
            affectionCues: affectionCues,
            assetOutputs: "none",
            summary: artDirectionSummary
        )
    }

    var artDirectionReadinessSummary: String {
        RendererMetadataSummary.fixedPartCatalogArtDirectionReadinessSummary(isReady: hasArtDirectionMetadata)
    }

    var lineageAffectionAncestorContext: String {
        "ancestorEcho"
    }

    var lineageAffectionSummary: String {
        RendererMetadataSummary.fixedPartLineageAffectionSummary(
            familyIDs: familyIDs.map(\.rawValue),
            affectionCues: affectionCues,
            ancestorContext: lineageAffectionAncestorContext,
            assetOutputs: "none",
            playerFacing: false
        )
    }

    var hasLineageAffectionMetadata: Bool {
        RendererMetadataSummary.hasFixedPartLineageAffectionFields(
            familyIDs: familyIDs.map(\.rawValue),
            affectionCues: affectionCues,
            ancestorContext: lineageAffectionAncestorContext,
            assetOutputs: "none",
            summary: lineageAffectionSummary
        )
    }

    var lineageAffectionReadinessSummary: String {
        RendererMetadataSummary.fixedPartLineageAffectionReadinessSummary(isReady: hasLineageAffectionMetadata)
    }

    func entry(for familyID: CreaturePartFamilyID) -> CreatureFixedPartCatalogEntry? {
        entries.first { $0.familyID == familyID }
    }
}

struct CreaturePartFamilySelection {
    let face: CreaturePartFamilyID
    let body: CreaturePartFamilyID
    let wing: CreaturePartFamilyID
    let tail: CreaturePartFamilyID

    var visibleFamilyIDs: [CreaturePartFamilyID] {
        [
            wing,
            wing,
            tail,
            body,
            face,
            .softEye,
            .softEye,
            .quietMouth
        ]
    }

    var summary: String {
        let families = visibleFamilyIDs.map(\.rawValue).joined(separator: ",")
        return "partFamilySelection=face:\(face.rawValue),body:\(body.rawValue),wing:\(wing.rawValue),tail:\(tail.rawValue);families:\(families)"
    }

    init(profile: CreatureRenderProfile) {
        self.face = Self.faceFamily(for: profile.genomeVisualVariation.face)
        self.body = Self.bodyFamily(for: profile.genomeVisualVariation.body)
        self.wing = Self.wingFamily(for: profile.genomeVisualVariation.wing)
        self.tail = Self.tailFamily(for: profile.genomeVisualVariation.tail)
    }

    private static func faceFamily(for face: String) -> CreaturePartFamilyID {
        switch face {
        case FaceBase.fairy.rawValue:
            .fairyHead
        case FaceBase.dragon.rawValue:
            .dragonHead
        case FaceBase.axolotl.rawValue:
            .axolotlHead
        case FaceBase.crystal.rawValue:
            .crystalHead
        case FaceBase.deer.rawValue:
            .deerHead
        case FaceBase.feline.rawValue:
            .felineHead
        case FaceBase.lunar.rawValue:
            .lunarHead
        default:
            .roundHead
        }
    }

    private static func bodyFamily(for body: String) -> CreaturePartFamilyID {
        switch body {
        case BodyBase.aquarian.rawValue:
            .aquarianBody
        case BodyBase.sylphian.rawValue:
            .sylphianBody
        case BodyBase.crystalian.rawValue:
            .crystalianBody
        case BodyBase.lunarian.rawValue:
            .lunarianBody
        case BodyBase.verdant.rawValue:
            .verdantBody
        default:
            .juvenileBody
        }
    }

    private static func wingFamily(for wing: String) -> CreaturePartFamilyID {
        switch wing {
        case WingBase.fairy.rawValue:
            .fairyWing
        case WingBase.dragon.rawValue:
            .dragonWing
        case WingBase.crystal.rawValue:
            .crystalWing
        case WingBase.jellyfish.rawValue:
            .jellyfishWing
        case WingBase.lunar.rawValue:
            .lunarWing
        case WingBase.plant.rawValue:
            .plantWing
        default:
            .lunarWing
        }
    }

    private static func tailFamily(for tail: String) -> CreaturePartFamilyID {
        switch tail {
        case TailBase.dragon.rawValue:
            .dragonTail
        case TailBase.fish.rawValue:
            .fishTail
        case TailBase.crystal.rawValue:
            .crystalTail
        case TailBase.floating.rawValue:
            .floatingTail
        case TailBase.plant.rawValue:
            .plantTail
        default:
            .softTail
        }
    }
}

struct WingBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let rotationDegrees: CGFloat
    let color: SKColor
}

struct EyeBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let node: SKShapeNode
}

struct TailBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let fillColor: SKColor
    let strokeColor: SKColor
    let rotationDegrees: CGFloat
}

struct BodyBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let fillColor: SKColor
}

struct HeadBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let fillColor: SKColor
}

struct MouthBuildInput {
    let descriptor: CreaturePartDescriptor
    let familyID: CreaturePartFamilyID
    let fillColor: SKColor
}

struct WingShapeRecipe {
    let top: CGPoint
    let rightTip: CGPoint
    let rightControl: CGPoint
    let bottomControl: CGPoint
    let leftTip: CGPoint
    let leftControl: CGPoint

    init(familyID: CreaturePartFamilyID) {
        switch familyID {
        case .fairyWing:
            self = .softLeaf
        case .dragonWing:
            self = .softSail
        case .crystalWing:
            self = .softFacet
        case .jellyfishWing:
            self = .softBell
        case .plantWing:
            self = .softSprout
        default:
            self = .softLunar
        }
    }

    static func recipeID(for familyID: CreaturePartFamilyID) -> CreatureShapeRecipeID {
        switch familyID {
        case .fairyWing:
            .softLeafWing
        case .dragonWing:
            .softSailWing
        case .crystalWing:
            .softFacetWing
        case .jellyfishWing:
            .softBellWing
        case .plantWing:
            .softSproutWing
        default:
            .softLunarWing
        }
    }

    init(
        top: CGPoint,
        rightTip: CGPoint,
        rightControl: CGPoint,
        bottomControl: CGPoint,
        leftTip: CGPoint,
        leftControl: CGPoint
    ) {
        self.top = top
        self.rightTip = rightTip
        self.rightControl = rightControl
        self.bottomControl = bottomControl
        self.leftTip = leftTip
        self.leftControl = leftControl
    }

    func path() -> CGPath {
        let path = CGMutablePath()
        path.move(to: top)
        path.addQuadCurve(to: rightTip, control: rightControl)
        path.addQuadCurve(to: leftTip, control: bottomControl)
        path.addQuadCurve(to: top, control: leftControl)
        return path
    }
}

enum TailShapeRecipe {
    case roundedRibbon
    case fishTaper
    case dragonTaper
    case softFacet
    case leafSprout

    init(familyID: CreaturePartFamilyID) {
        switch familyID {
        case .fishTail:
            self = .fishTaper
        case .dragonTail:
            self = .dragonTaper
        case .crystalTail:
            self = .softFacet
        case .plantTail:
            self = .leafSprout
        default:
            self = .roundedRibbon
        }
    }

    static func recipeID(for familyID: CreaturePartFamilyID) -> CreatureShapeRecipeID {
        switch familyID {
        case .fishTail:
            .fishTaperTail
        case .dragonTail:
            .dragonTaperTail
        case .crystalTail:
            .softFacetTail
        case .plantTail:
            .leafSproutTail
        default:
            .roundedRibbonTail
        }
    }

    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .roundedRibbon:
            let path = CGMutablePath()
            path.addRoundedRect(
                in: rect,
                cornerWidth: rect.height / 2,
                cornerHeight: rect.height / 2
            )
            return path
        case .fishTaper:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.18),
                control: CGPoint(x: rect.midX, y: rect.maxY + rect.height * 0.20)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.18),
                control: CGPoint(x: rect.maxX + rect.height * 0.18, y: rect.midY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.midX, y: rect.minY - rect.height * 0.20)
            )
            path.closeSubpath()
            return path
        case .dragonTaper:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.25),
                control: CGPoint(x: rect.midX + rect.width * 0.12, y: rect.maxY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.25),
                control: CGPoint(x: rect.maxX + rect.height * 0.12, y: rect.midY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.midX - rect.width * 0.05, y: rect.minY)
            )
            path.closeSubpath()
            return path
        case .softFacet:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.minX + rect.height * 0.30, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.28, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - rect.height * 0.20, y: rect.maxY - rect.height * 0.16))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - rect.height * 0.20, y: rect.minY + rect.height * 0.16))
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.28, y: rect.minY))
            path.closeSubpath()
            return path
        case .leafSprout:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.height * 0.30, y: rect.maxY),
                control: CGPoint(x: rect.midX, y: rect.maxY + rect.height * 0.10)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.maxX + rect.height * 0.16, y: rect.maxY - rect.height * 0.05)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.height * 0.30, y: rect.minY),
                control: CGPoint(x: rect.maxX + rect.height * 0.16, y: rect.minY + rect.height * 0.05)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.midX, y: rect.minY - rect.height * 0.10)
            )
            path.closeSubpath()
            return path
        }
    }
}

enum BodyShapeRecipe {
    case softOval
    case waterDrop
    case seedPetal
    case pebbleGem
    case moonOval
    case leafBelly

    init(familyID: CreaturePartFamilyID) {
        switch familyID {
        case .aquarianBody:
            self = .waterDrop
        case .sylphianBody:
            self = .seedPetal
        case .crystalianBody:
            self = .pebbleGem
        case .lunarianBody:
            self = .moonOval
        case .verdantBody:
            self = .leafBelly
        default:
            self = .softOval
        }
    }

    static func recipeID(for familyID: CreaturePartFamilyID) -> CreatureShapeRecipeID {
        switch familyID {
        case .aquarianBody:
            .waterDropBody
        case .sylphianBody:
            .seedPetalBody
        case .crystalianBody:
            .pebbleGemBody
        case .lunarianBody:
            .moonOvalBody
        case .verdantBody:
            .leafBellyBody
        default:
            .softOvalBody
        }
    }

    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .softOval:
            let path = CGMutablePath()
            path.addEllipse(in: rect)
            return path
        case .waterDrop:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.08, y: rect.midY - rect.height * 0.02),
                control: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.maxY - rect.height * 0.08)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY),
                control: CGPoint(x: rect.maxX + rect.width * 0.02, y: rect.minY + rect.height * 0.20)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.midY - rect.height * 0.02),
                control: CGPoint(x: rect.minX - rect.width * 0.02, y: rect.minY + rect.height * 0.20)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.04, y: rect.maxY - rect.height * 0.08)
            )
            path.closeSubpath()
            return path
        case .seedPetal:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.10, y: rect.midY + rect.height * 0.02),
                control: CGPoint(x: rect.maxX - rect.width * 0.14, y: rect.maxY + rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.02),
                control: CGPoint(x: rect.maxX + rect.width * 0.01, y: rect.minY + rect.height * 0.16)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.10, y: rect.midY + rect.height * 0.02),
                control: CGPoint(x: rect.minX - rect.width * 0.01, y: rect.minY + rect.height * 0.16)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.14, y: rect.maxY + rect.height * 0.02)
            )
            path.closeSubpath()
            return path
        case .pebbleGem:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY + rect.height * 0.05),
                control: CGPoint(x: rect.maxX - rect.width * 0.08, y: rect.maxY - rect.height * 0.04)
            )
            path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.12, y: rect.minY + rect.height * 0.10))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY),
                control: CGPoint(x: rect.maxX - rect.width * 0.28, y: rect.minY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.12, y: rect.minY + rect.height * 0.10),
                control: CGPoint(x: rect.minX + rect.width * 0.28, y: rect.minY - rect.height * 0.02)
            )
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + rect.height * 0.05))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.maxY - rect.height * 0.04)
            )
            path.closeSubpath()
            return path
        case .moonOval:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.midY),
                control: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.maxY - rect.height * 0.04)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX + rect.width * 0.03, y: rect.minY),
                control: CGPoint(x: rect.maxX + rect.width * 0.02, y: rect.minY + rect.height * 0.20)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.15)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.05, y: rect.maxY - rect.height * 0.03)
            )
            path.closeSubpath()
            return path
        case .leafBelly:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY + rect.height * 0.03),
                control: CGPoint(x: rect.maxX - rect.width * 0.10, y: rect.maxY - rect.height * 0.06)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX + rect.width * 0.02, y: rect.minY),
                control: CGPoint(x: rect.maxX - rect.width * 0.05, y: rect.minY + rect.height * 0.12)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY + rect.height * 0.03),
                control: CGPoint(x: rect.minX + rect.width * 0.05, y: rect.minY + rect.height * 0.12)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.10, y: rect.maxY - rect.height * 0.06)
            )
            path.closeSubpath()
            return path
        }
    }
}

enum HeadShapeRecipe {
    case softRound
    case softPetal
    case softBroad
    case softWide
    case softFacet
    case softDeer
    case softFeline
    case softCrescent

    init(familyID: CreaturePartFamilyID) {
        switch familyID {
        case .fairyHead:
            self = .softPetal
        case .dragonHead:
            self = .softBroad
        case .axolotlHead:
            self = .softWide
        case .crystalHead:
            self = .softFacet
        case .deerHead:
            self = .softDeer
        case .felineHead:
            self = .softFeline
        case .lunarHead:
            self = .softCrescent
        default:
            self = .softRound
        }
    }

    static func recipeID(for familyID: CreaturePartFamilyID) -> CreatureShapeRecipeID {
        switch familyID {
        case .fairyHead:
            .softPetalHead
        case .dragonHead:
            .softBroadHead
        case .axolotlHead:
            .softWideHead
        case .crystalHead:
            .softFacetHead
        case .deerHead:
            .softDeerHead
        case .felineHead:
            .softFelineHead
        case .lunarHead:
            .softCrescentHead
        default:
            .softRoundHead
        }
    }

    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .softRound:
            let path = CGMutablePath()
            path.addEllipse(in: rect)
            return path
        case .softPetal:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.08, y: rect.midY + rect.height * 0.10),
                control: CGPoint(x: rect.maxX - rect.width * 0.12, y: rect.maxY + rect.height * 0.03)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY),
                control: CGPoint(x: rect.maxX + rect.width * 0.02, y: rect.minY + rect.height * 0.18)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.midY + rect.height * 0.10),
                control: CGPoint(x: rect.minX - rect.width * 0.02, y: rect.minY + rect.height * 0.18)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.12, y: rect.maxY + rect.height * 0.03)
            )
            path.closeSubpath()
            return path
        case .softBroad:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY - rect.height * 0.03),
                control: CGPoint(x: rect.maxX - rect.width * 0.08, y: rect.maxY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY),
                control: CGPoint(x: rect.maxX - rect.width * 0.02, y: rect.minY + rect.height * 0.08)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY - rect.height * 0.03),
                control: CGPoint(x: rect.minX + rect.width * 0.02, y: rect.minY + rect.height * 0.08)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.08, y: rect.maxY - rect.height * 0.02)
            )
            path.closeSubpath()
            return path
        case .softWide:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.maxY - rect.height * 0.04)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.02),
                control: CGPoint(x: rect.maxX + rect.width * 0.03, y: rect.minY + rect.height * 0.14)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.minX - rect.width * 0.03, y: rect.minY + rect.height * 0.14)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.04, y: rect.maxY - rect.height * 0.04)
            )
            path.closeSubpath()
            return path
        case .softFacet:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.18, y: rect.maxY - rect.height * 0.06))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.28)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.18, y: rect.minY + rect.height * 0.06),
                control: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.28)
            )
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.minY + rect.height * 0.06))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.midY),
                control: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.28)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.maxY - rect.height * 0.06),
                control: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.28)
            )
            path.closeSubpath()
            return path
        case .softDeer:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.10, y: rect.midY + rect.height * 0.12),
                control: CGPoint(x: rect.maxX - rect.width * 0.12, y: rect.maxY - rect.height * 0.01)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.17, y: rect.minY + rect.height * 0.16),
                control: CGPoint(x: rect.maxX + rect.width * 0.02, y: rect.minY + rect.height * 0.32)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY),
                control: CGPoint(x: rect.maxX - rect.width * 0.30, y: rect.minY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.17, y: rect.minY + rect.height * 0.16),
                control: CGPoint(x: rect.minX + rect.width * 0.30, y: rect.minY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.10, y: rect.midY + rect.height * 0.12),
                control: CGPoint(x: rect.minX - rect.width * 0.02, y: rect.minY + rect.height * 0.32)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.12, y: rect.maxY - rect.height * 0.01)
            )
            path.closeSubpath()
            return path
        case .softFeline:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.midY + rect.height * 0.04),
                control: CGPoint(x: rect.maxX - rect.width * 0.06, y: rect.maxY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.20, y: rect.minY + rect.height * 0.12),
                control: CGPoint(x: rect.maxX + rect.width * 0.02, y: rect.minY + rect.height * 0.22)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.02),
                control: CGPoint(x: rect.maxX - rect.width * 0.28, y: rect.minY - rect.height * 0.04)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.20, y: rect.minY + rect.height * 0.12),
                control: CGPoint(x: rect.minX + rect.width * 0.28, y: rect.minY - rect.height * 0.04)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.04, y: rect.midY + rect.height * 0.04),
                control: CGPoint(x: rect.minX - rect.width * 0.02, y: rect.minY + rect.height * 0.22)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.06, y: rect.maxY - rect.height * 0.02)
            )
            path.closeSubpath()
            return path
        case .softCrescent:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX - rect.width * 0.02, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.width * 0.04, y: rect.midY + rect.height * 0.04),
                control: CGPoint(x: rect.maxX - rect.width * 0.06, y: rect.maxY - rect.height * 0.02)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX + rect.width * 0.04, y: rect.minY),
                control: CGPoint(x: rect.maxX + rect.width * 0.03, y: rect.minY + rect.height * 0.20)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + rect.width * 0.04, y: rect.midY),
                control: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.16)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX - rect.width * 0.02, y: rect.maxY),
                control: CGPoint(x: rect.minX + rect.width * 0.06, y: rect.maxY - rect.height * 0.04)
            )
            path.closeSubpath()
            return path
        }
    }
}

enum CreatureAssemblyItem {
    case wing(WingBuildInput)
    case tail(TailBuildInput)
    case body(BodyBuildInput)
    case head(HeadBuildInput)
    case eye(EyeBuildInput)
    case mouth(MouthBuildInput)

    var layerID: CreatureLayerID {
        switch self {
        case .wing(let input):
            input.descriptor.layerID
        case .tail(let input):
            input.descriptor.layerID
        case .body(let input):
            input.descriptor.layerID
        case .head(let input):
            input.descriptor.layerID
        case .eye(let input):
            input.descriptor.layerID
        case .mouth(let input):
            input.descriptor.layerID
        }
    }

    var familyID: CreaturePartFamilyID {
        switch self {
        case .wing(let input):
            input.familyID
        case .tail(let input):
            input.familyID
        case .body(let input):
            input.familyID
        case .head(let input):
            input.familyID
        case .eye(let input):
            input.familyID
        case .mouth(let input):
            input.familyID
        }
    }

    var socketID: CreatureSocketID {
        switch self {
        case .wing(let input):
            input.descriptor.socketID
        case .tail(let input):
            input.descriptor.socketID
        case .body(let input):
            input.descriptor.socketID
        case .head(let input):
            input.descriptor.socketID
        case .eye(let input):
            input.descriptor.socketID
        case .mouth(let input):
            input.descriptor.socketID
        }
    }

    var shapeRecipeID: CreatureShapeRecipeID {
        switch self {
        case .wing(let input):
            WingShapeRecipe.recipeID(for: input.familyID)
        case .tail(let input):
            TailShapeRecipe.recipeID(for: input.familyID)
        case .body(let input):
            BodyShapeRecipe.recipeID(for: input.familyID)
        case .head(let input):
            HeadShapeRecipe.recipeID(for: input.familyID)
        case .eye:
            .softEyeDot
        case .mouth:
            .quietMouthLine
        }
    }

    var detailRecipeIDs: [CreatureDetailRecipeID] {
        switch self {
        case .wing(let input):
            CreatureDetailRecipeID.recipeIDs(for: input.familyID)
        case .tail(let input):
            CreatureDetailRecipeID.recipeIDs(for: input.familyID)
        case .body(let input):
            CreatureDetailRecipeID.recipeIDs(for: input.familyID)
        case .head(let input):
            CreatureDetailRecipeID.recipeIDs(for: input.familyID)
        case .eye:
            [.softCatchlight]
        case .mouth:
            []
        }
    }
}

struct CreatureAssemblyPlan {
    static let expectedVisibleLayerOrder: [CreatureLayerID] = [
        .leftWing,
        .rightWing,
        .tail,
        .body,
        .head,
        .leftEye,
        .rightEye,
        .mouth
    ]

    let visibleParts: [CreatureAssemblyItem]

    var layerIDs: [CreatureLayerID] {
        visibleParts.map(\.layerID)
    }

    var familyIDs: [CreaturePartFamilyID] {
        visibleParts.map(\.familyID)
    }

    var shapeRecipeIDs: [CreatureShapeRecipeID] {
        visibleParts.map(\.shapeRecipeID)
    }

    var detailRecipeIDs: [CreatureDetailRecipeID] {
        visibleParts.flatMap(\.detailRecipeIDs)
    }

    var matchesExpectedVisibleLayerOrder: Bool {
        layerIDs == Self.expectedVisibleLayerOrder
    }

    var inspectionSummary: String {
        let orderedLayers = layerIDs.map(\.rawValue).joined(separator: ",")
        return "layers=\(orderedLayers); matchesExpected=\(matchesExpectedVisibleLayerOrder)"
    }

    var familySummary: String {
        familyIDs.map(\.rawValue).joined(separator: ",")
    }

    func hasCatalogFamilyCoverage(in catalog: CreatureFixedPartCatalog) -> Bool {
        familyIDs.allSatisfy { catalog.entry(for: $0) != nil }
    }

    func hasCatalogLayerCoverage(in catalog: CreatureFixedPartCatalog) -> Bool {
        visibleParts.allSatisfy { item in
            guard let entry = catalog.entry(for: item.familyID) else {
                return false
            }
            return entry.layerIDs.contains(item.layerID)
        }
    }

    func hasCatalogSocketCoverage(in catalog: CreatureFixedPartCatalog) -> Bool {
        visibleParts.allSatisfy { item in
            guard let entry = catalog.entry(for: item.familyID) else {
                return false
            }
            return entry.socketIDs.contains(item.socketID)
        }
    }

    func hasCatalogShapeRecipeCoverage(in catalog: CreatureFixedPartCatalog) -> Bool {
        visibleParts.allSatisfy { item in
            guard let entry = catalog.entry(for: item.familyID) else {
                return false
            }
            return entry.shapeRecipeIDs.contains(item.shapeRecipeID)
        }
    }

    func hasCatalogDetailRecipeCoverage(in catalog: CreatureFixedPartCatalog) -> Bool {
        visibleParts.allSatisfy { item in
            guard let entry = catalog.entry(for: item.familyID) else {
                return false
            }
            return item.detailRecipeIDs.allSatisfy { entry.detailRecipeIDs.contains($0) }
        }
    }

    func shapeRecipeValidationSummary(in catalog: CreatureFixedPartCatalog) -> String {
        let recipes = shapeRecipeIDs.map(\.rawValue).joined(separator: ",")
        return "shapeRecipeCoverage=recipes:\(recipes),catalog:\(hasCatalogShapeRecipeCoverage(in: catalog))"
    }

    func detailRecipeValidationSummary(in catalog: CreatureFixedPartCatalog) -> String {
        let recipes = detailRecipeIDs.map(\.rawValue).joined(separator: ",")
        return "detailRecipeCoverage=recipes:\(recipes.isEmpty ? "none" : recipes),catalog:\(hasCatalogDetailRecipeCoverage(in: catalog))"
    }

    static func glowAmbientRecipeIDs(for profile: CreatureRenderProfile) -> [CreatureAmbientRecipeID] {
        profile.glowAura.moteCount > 0 ? [.softGlowRing, .quietGlowMotes] : [.softGlowRing]
    }

    static func hasGlowAmbientRecipeCoverage(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> Bool {
        glowAmbientRecipeIDs(for: profile).allSatisfy { catalog.ambientRecipeIDs.contains($0) }
    }

    static func glowAmbientRecipeValidationSummary(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> String {
        let recipes = glowAmbientRecipeIDs(for: profile).map(\.rawValue).joined(separator: ",")
        return "glowAmbientRecipeCoverage=recipes:\(recipes),catalog:\(hasGlowAmbientRecipeCoverage(for: profile, in: catalog))"
    }

    static func patternRecipeIDs(for profile: CreatureRenderProfile) -> [CreaturePatternRecipeID] {
        profile.patternMarking.visibleSpotCount > 0 ? [.softBellyDapples] : []
    }

    static func hasPatternRecipeCoverage(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> Bool {
        let recipes = patternRecipeIDs(for: profile)
        return !recipes.isEmpty
            && recipes.allSatisfy { catalog.patternRecipeIDs.contains($0) }
    }

    static func patternRecipeValidationSummary(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> String {
        let recipes = patternRecipeIDs(for: profile).map(\.rawValue).joined(separator: ",")
        return "patternRecipeCoverage=recipes:\(recipes.isEmpty ? "none" : recipes),catalog:\(hasPatternRecipeCoverage(for: profile, in: catalog))"
    }

    static func growthHornBudDetailRecipeIDs(for profile: CreatureRenderProfile) -> [CreatureDetailRecipeID] {
        profile.growthHornBudCue.visibleInPortrait ? [.tinyRoundedHornBud] : []
    }

    static func hasGrowthHornBudDetailRecipeCoverage(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> Bool {
        let recipes = growthHornBudDetailRecipeIDs(for: profile)
        guard !recipes.isEmpty else {
            return !profile.growthHornBudCue.visibleInPortrait
        }

        return recipes.allSatisfy { catalog.growthDetailRecipeIDs.contains($0) }
    }

    static func growthHornBudDetailRecipeValidationSummary(
        for profile: CreatureRenderProfile,
        in catalog: CreatureFixedPartCatalog
    ) -> String {
        let recipes = growthHornBudDetailRecipeIDs(for: profile).map(\.rawValue).joined(separator: ",")
        return "growthHornBudDetailRecipeCoverage=recipes:\(recipes.isEmpty ? "none" : recipes),catalog:\(hasGrowthHornBudDetailRecipeCoverage(for: profile, in: catalog))"
    }

    func catalogValidationSummary(in catalog: CreatureFixedPartCatalog) -> String {
        let family = hasCatalogFamilyCoverage(in: catalog)
        let layer = hasCatalogLayerCoverage(in: catalog)
        let socket = hasCatalogSocketCoverage(in: catalog)
        return "catalogCoverage=family:\(family),layer:\(layer),socket:\(socket)"
    }

    func isFullyCatalogBacked(in catalog: CreatureFixedPartCatalog) -> Bool {
        hasCatalogFamilyCoverage(in: catalog)
            && hasCatalogLayerCoverage(in: catalog)
            && hasCatalogSocketCoverage(in: catalog)
            && hasCatalogShapeRecipeCoverage(in: catalog)
            && hasCatalogDetailRecipeCoverage(in: catalog)
    }
}

private extension CreatureDetailRecipeID {
    static func recipeIDs(for familyID: CreaturePartFamilyID) -> [CreatureDetailRecipeID] {
        switch familyID {
        case .lunarWing:
            []
        case .fairyWing:
            [.softVein, .softWingTipPearl]
        case .dragonWing:
            [.softRim, .softWingTipClaw]
        case .crystalWing:
            [.facetDot]
        case .jellyfishWing:
            [.bellDot]
        case .plantWing:
            [.sproutVein]
        case .floatingTail:
            [.floatingOrb, .softTetherDot]
        case .dragonTail:
            [.roundedCap, .softDrakeRidge]
        case .crystalTail, .softTail:
            [.roundedCap]
        case .fishTail:
            [.fishFin, .softForkFin]
        case .plantTail:
            [.leafBud, .softLeafVein]
        case .juvenileBody:
            []
        case .aquarianBody:
            [.bellyDrop]
        case .sylphianBody:
            [.petalChest, .softShoulderPetals]
        case .crystalianBody:
            [.softFacetBody]
        case .lunarianBody:
            [.crescentBelly, .softMoonShoulderCrescents]
        case .verdantBody:
            [.sproutBelly, .leafShoulderNubs]
        case .roundHead:
            [.softCheek]
        case .fairyHead:
            [.cheekGleam]
        case .dragonHead:
            [.muzzleGlow]
        case .axolotlHead:
            [.sideCheekDots]
        case .crystalHead:
            [.softFacetFace]
        case .deerHead:
            [.forestDots, .softEarNubs]
        case .felineHead:
            [.kittenGleam, .softWhiskerDots, .softEarTips]
        case .lunarHead:
            [.moonCheek]
        case .softEye, .quietMouth:
            []
        }
    }
}

@MainActor
struct PartAssembler {
    let profile: CreatureRenderProfile
    let partFamilies: CreaturePartFamilySelection
    let sockets: [CreatureSocketID: CreatureSocket]
    let partDescriptors: [CreatureLayerID: CreaturePartDescriptor]

    init(profile: CreatureRenderProfile) {
        self.profile = profile
        self.partFamilies = CreaturePartFamilySelection(profile: profile)
        self.sockets = CreatureSocketID.defaultSockets
        self.partDescriptors = CreaturePartDescriptor.defaultDescriptors
    }

    func shadowNode() -> SKShapeNode {
        let node = SKShapeNode(ellipseIn: CGRect(x: -122, y: -154, width: 244, height: 68))
        node.fillColor = profile.palette.shadow
        node.strokeColor = .clear
        node.glowWidth = 8
        apply(.shadow, to: node)
        return node
    }

    func wingNode(_ input: WingBuildInput) -> SKShapeNode {
        let node = SKShapeNode(path: WingShapeRecipe(familyID: input.familyID).path())
        node.fillColor = input.color
        node.strokeColor = .clear
        node.position = socketPosition(input.descriptor.socketID)
        node.zRotation = input.rotationDegrees * .pi / 180
        node.xScale = profile.silhouette.wingXScale
        node.yScale = profile.silhouette.wingYScale
        node.addChild(wingSilhouetteAccessoryNode())
        node.addChild(wingAccentNode())
        apply(input.descriptor.layerID, to: node)
        return node
    }

    private func wingSilhouetteAccessoryNode() -> SKNode {
        let accessory = profile.silhouette.wingSilhouetteAccessory
        let node = SKNode()
        node.zPosition = 2

        switch accessory.accessory {
        case .none:
            break
        case .softWingTipPearl:
            let pearl = SKShapeNode(ellipseIn: CGRect(x: -5, y: -5, width: 10, height: 10))
            pearl.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
            pearl.strokeColor = .clear
            pearl.position = CGPoint(x: 20, y: 38)
            pearl.glowWidth = 2
            node.addChild(pearl)
        case .softWingTipClaw:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 20, y: 42))
            path.addLine(to: CGPoint(x: 34, y: 34))
            path.addLine(to: CGPoint(x: 23, y: 28))
            path.closeSubpath()

            let claw = SKShapeNode(path: path)
            claw.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
            claw.strokeColor = .clear
            claw.glowWidth = 1
            node.addChild(claw)
        }

        return node
    }

    private func wingAccentNode() -> SKNode {
        let accent = profile.silhouette.wingAccent
        let node = SKNode()
        node.zPosition = 1

        switch accent.kind {
        case .none:
            break
        case .softVein:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -1, y: 36))
            path.addQuadCurve(to: CGPoint(x: 4, y: -30), control: CGPoint(x: 16, y: 2))

            let vein = SKShapeNode(path: path)
            vein.strokeColor = accent.color.withAlphaComponent(accent.alpha)
            vein.fillColor = .clear
            vein.lineWidth = 3
            vein.lineCap = .round
            node.addChild(vein)
        case .softRim:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 4, y: 42))
            path.addQuadCurve(to: CGPoint(x: 34, y: -34), control: CGPoint(x: 41, y: 1))

            let rim = SKShapeNode(path: path)
            rim.strokeColor = accent.color.withAlphaComponent(accent.alpha)
            rim.fillColor = .clear
            rim.lineWidth = 3
            rim.lineCap = .round
            node.addChild(rim)
        case .facetDot:
            let dot = SKShapeNode(ellipseIn: CGRect(x: -6, y: -6, width: 12, height: 12))
            dot.fillColor = accent.color.withAlphaComponent(accent.alpha)
            dot.strokeColor = .clear
            dot.position = CGPoint(x: 10, y: -4)
            dot.glowWidth = 2
            node.addChild(dot)
        case .bellDot:
            for xOffset in [-10.0, 10.0] {
                let dot = SKShapeNode(ellipseIn: CGRect(x: -4, y: -4, width: 8, height: 8))
                dot.fillColor = accent.color.withAlphaComponent(accent.alpha)
                dot.strokeColor = .clear
                dot.position = CGPoint(x: xOffset, y: -28)
                node.addChild(dot)
            }
        }

        return node
    }

    func tailNode(_ input: TailBuildInput) -> SKShapeNode {
        let rect = profile.silhouette.tailRect
        let path = TailShapeRecipe(familyID: input.familyID).path(in: rect)
        let node = SKShapeNode(path: path)
        node.fillColor = input.fillColor
        node.strokeColor = input.strokeColor
        node.lineWidth = 4
        node.position = socketPosition(input.descriptor.socketID)
        node.zRotation = input.rotationDegrees * .pi / 180
        node.addChild(tailAccentNode(in: rect))
        node.addChild(tailGrowthTipNode(in: rect))
        node.addChild(tailSilhouetteAccessoryNode(in: rect))
        apply(input.descriptor.layerID, to: node)
        return node
    }

    private func tailGrowthTipNode(in rect: CGRect) -> SKNode {
        let cue = profile.growthTailTipCue
        let node = SKNode()
        node.zPosition = 2.2

        guard cue.visibleInPortrait else {
            return node
        }

        let size = cue.glintSize
        let glint = SKShapeNode(ellipseIn: CGRect(
            x: -size / 2,
            y: -size / 2,
            width: size,
            height: size
        ))
        glint.fillColor = cue.color.withAlphaComponent(cue.glintAlpha)
        glint.strokeColor = .clear
        glint.glowWidth = cue.glowWidth
        glint.position = CGPoint(x: rect.maxX - rect.height * 0.24, y: rect.height * 0.08)
        node.addChild(glint)

        return node
    }

    private func tailSilhouetteAccessoryNode(in rect: CGRect) -> SKNode {
        let accessory = profile.silhouette.tailSilhouetteAccessory
        let node = SKNode()
        node.zPosition = 1.5

        switch accessory.accessory {
        case .none:
            break
        case .softForkFin:
            let finSize = max(8, rect.height * 0.25)
            for yOffset in [finSize * 0.42, -finSize * 0.42] {
                let fin = SKShapeNode(ellipseIn: CGRect(
                    x: -finSize / 2,
                    y: -finSize / 2,
                    width: finSize,
                    height: finSize * 0.72
                ))
                fin.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                fin.strokeColor = .clear
                fin.position = CGPoint(x: rect.maxX - rect.height * 0.02, y: yOffset)
                fin.zRotation = yOffset > 0 ? 0.68 : -0.68
                node.addChild(fin)
            }
        case .softTetherDot:
            let dotSize = max(5.5, rect.height * 0.18)
            let dot = SKShapeNode(ellipseIn: CGRect(
                x: -dotSize / 2,
                y: -dotSize / 2,
                width: dotSize,
                height: dotSize
            ))
            dot.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
            dot.strokeColor = .clear
            dot.glowWidth = 1.5
            dot.position = CGPoint(x: rect.minX + rect.height * 0.32, y: rect.height * 0.04)
            node.addChild(dot)
        case .softDrakeRidge:
            let ridgeSize = max(5.5, rect.height * 0.18)
            let placements = [
                CGPoint(x: rect.midX - rect.width * 0.18, y: rect.height * 0.20),
                CGPoint(x: rect.midX + rect.width * 0.03, y: rect.height * 0.18),
                CGPoint(x: rect.midX + rect.width * 0.24, y: rect.height * 0.14)
            ]

            for (index, placement) in placements.enumerated() {
                let ridge = SKShapeNode(ellipseIn: CGRect(
                    x: -ridgeSize / 2,
                    y: -ridgeSize / 2,
                    width: ridgeSize,
                    height: ridgeSize * 0.72
                ))
                ridge.fillColor = accessory.color.withAlphaComponent(accessory.alpha - CGFloat(index) * 0.05)
                ridge.strokeColor = .clear
                ridge.glowWidth = 1
                ridge.position = placement
                ridge.zRotation = -0.24
                node.addChild(ridge)
            }
        case .softLeafVein:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.maxX - rect.height * 0.33, y: -rect.height * 0.16))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - rect.height * 0.04, y: rect.height * 0.24),
                control: CGPoint(x: rect.maxX - rect.height * 0.08, y: -rect.height * 0.02)
            )

            let vein = SKShapeNode(path: path)
            vein.strokeColor = accessory.color.withAlphaComponent(accessory.alpha)
            vein.fillColor = .clear
            vein.lineWidth = max(1.2, rect.height * 0.055)
            vein.lineCap = .round
            vein.glowWidth = 0.5
            node.addChild(vein)
        }

        return node
    }

    private func tailAccentNode(in rect: CGRect) -> SKNode {
        let accent = profile.silhouette.tailAccent
        let node = SKNode()
        node.zPosition = 1

        switch accent.kind {
        case .floatingOrb:
            let orbSize = max(13, rect.height * 0.42)
            let orb = SKShapeNode(ellipseIn: CGRect(
                x: -orbSize / 2,
                y: -orbSize / 2,
                width: orbSize,
                height: orbSize
            ))
            orb.fillColor = accent.color.withAlphaComponent(accent.alpha)
            orb.strokeColor = SKColor.white.withAlphaComponent(0.32)
            orb.lineWidth = 1.5
            orb.glowWidth = 4
            orb.position = CGPoint(x: rect.maxX - (rect.height * 0.12), y: 0)
            node.addChild(orb)
        case .fishFin:
            let finWidth = max(14, rect.height * 0.46)
            let finHeight = max(11, rect.height * 0.34)
            for yOffset in [finHeight * 0.34, -finHeight * 0.34] {
                let fin = SKShapeNode(ellipseIn: CGRect(
                    x: -finWidth / 2,
                    y: -finHeight / 2,
                    width: finWidth,
                    height: finHeight
                ))
                fin.fillColor = accent.color.withAlphaComponent(accent.alpha)
                fin.strokeColor = .clear
                fin.position = CGPoint(x: rect.maxX - (rect.height * 0.18), y: yOffset)
                fin.zRotation = yOffset > 0 ? 0.45 : -0.45
                node.addChild(fin)
            }
        case .roundedCap:
            let capSize = max(10, rect.height * 0.32)
            let cap = SKShapeNode(ellipseIn: CGRect(
                x: -capSize / 2,
                y: -capSize / 2,
                width: capSize,
                height: capSize
            ))
            cap.fillColor = accent.color.withAlphaComponent(accent.alpha)
            cap.strokeColor = .clear
            cap.position = CGPoint(x: rect.maxX - (rect.height * 0.18), y: 0)
            node.addChild(cap)
        case .leafBud:
            let bud = SKShapeNode(ellipseIn: CGRect(
                x: -rect.height * 0.22,
                y: -rect.height * 0.34,
                width: rect.height * 0.44,
                height: rect.height * 0.68
            ))
            bud.fillColor = accent.color.withAlphaComponent(accent.alpha)
            bud.strokeColor = .clear
            bud.position = CGPoint(x: rect.maxX - (rect.height * 0.18), y: rect.height * 0.04)
            bud.zRotation = 0.55
            node.addChild(bud)
        }

        if profile.silhouette.tailLineageEcho.isActive {
            node.addChild(tailLineageEchoNode(in: rect))
        }

        return node
    }

    private func tailLineageEchoNode(in rect: CGRect) -> SKNode {
        let echo = profile.silhouette.tailLineageEcho
        let node = SKNode()
        node.zPosition = 2

        let offsets = [
            CGPoint(x: -0.38, y: 0.18),
            CGPoint(x: -0.20, y: -0.16),
            CGPoint(x: -0.04, y: 0.08),
            CGPoint(x: -0.56, y: -0.04)
        ]

        for (index, offset) in offsets.prefix(echo.dotCount).enumerated() {
            let size = [5.5, 3.8, 3.2, 2.8][index]
            let glint = SKShapeNode(ellipseIn: CGRect(
                x: -size / 2,
                y: -size / 2,
                width: size,
                height: size
            ))
            glint.fillColor = echo.color.withAlphaComponent(echo.alpha - CGFloat(index) * 0.16)
            glint.strokeColor = .clear
            glint.glowWidth = index == 0 ? 2 : 1
            glint.position = CGPoint(
                x: rect.maxX + (rect.height * offset.x),
                y: rect.height * offset.y
            )
            node.addChild(glint)
        }

        return node
    }

    func bodyNode(_ input: BodyBuildInput) -> SKShapeNode {
        let bodyRect = profile.silhouette.bodyRect
        let node = SKShapeNode(path: BodyShapeRecipe(familyID: input.familyID).path(in: bodyRect))
        node.fillColor = input.fillColor
        node.strokeColor = .clear
        node.glowWidth = 1
        node.position = socketPosition(input.descriptor.socketID)
        node.addChild(bodySilhouetteAccessoryNode(in: bodyRect))
        node.addChild(bodyAccentNode(in: bodyRect))
        node.addChild(patternMarkingNode(in: bodyRect))
        node.addChild(lineageMemoryThreadNode(in: bodyRect))
        node.addChild(ancestralGlintNode(in: bodyRect))
        apply(input.descriptor.layerID, to: node)
        return node
    }

    private func bodySilhouetteAccessoryNode(in rect: CGRect) -> SKNode {
        let accessory = profile.bodySilhouetteAccessory
        let node = SKNode()
        node.zPosition = -0.5

        switch accessory.accessory {
        case .none:
            break
        case .softShoulderPetals:
            for xOffset in [-rect.width * 0.34, rect.width * 0.34] {
                let petal = SKShapeNode(ellipseIn: CGRect(
                    x: -rect.width * 0.095,
                    y: -rect.height * 0.105,
                    width: rect.width * 0.19,
                    height: rect.height * 0.21
                ))
                petal.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                petal.strokeColor = SKColor.white.withAlphaComponent(0.20)
                petal.lineWidth = 1
                petal.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY - rect.height * 0.18)
                petal.zRotation = xOffset < 0 ? -0.58 : 0.58
                node.addChild(petal)
            }
        case .softMoonShoulderCrescents:
            for xOffset in [-rect.width * 0.35, rect.width * 0.35] {
                let outer = SKShapeNode(ellipseIn: CGRect(
                    x: -rect.width * 0.088,
                    y: -rect.height * 0.105,
                    width: rect.width * 0.176,
                    height: rect.height * 0.21
                ))
                outer.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                outer.strokeColor = SKColor.white.withAlphaComponent(0.18)
                outer.lineWidth = 1
                outer.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY - rect.height * 0.18)
                outer.zRotation = xOffset < 0 ? -0.50 : 0.50

                let inner = SKShapeNode(ellipseIn: CGRect(
                    x: -rect.width * 0.078,
                    y: -rect.height * 0.095,
                    width: rect.width * 0.156,
                    height: rect.height * 0.19
                ))
                inner.fillColor = profile.palette.body
                inner.strokeColor = .clear
                inner.position = CGPoint(
                    x: (xOffset < 0 ? rect.width * 0.035 : -rect.width * 0.035),
                    y: rect.height * 0.012
                )

                outer.addChild(inner)
                node.addChild(outer)
            }
        case .leafShoulderNubs:
            for xOffset in [-rect.width * 0.36, rect.width * 0.36] {
                let leaf = SKShapeNode(ellipseIn: CGRect(
                    x: -rect.width * 0.080,
                    y: -rect.height * 0.125,
                    width: rect.width * 0.16,
                    height: rect.height * 0.25
                ))
                leaf.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                leaf.strokeColor = SKColor.white.withAlphaComponent(0.18)
                leaf.lineWidth = 1
                leaf.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY - rect.height * 0.20)
                leaf.zRotation = xOffset < 0 ? -0.72 : 0.72
                node.addChild(leaf)
            }
        }

        return node
    }

    private func lineageMemoryThreadNode(in rect: CGRect) -> SKNode {
        let thread = profile.lineageMemoryThread
        let node = SKNode()
        node.zPosition = 2.5

        guard thread.isActive else {
            return node
        }

        let path = CGMutablePath()
        path.move(to: CGPoint(
            x: rect.midX + rect.width * 0.08,
            y: rect.midY + rect.height * 0.12
        ))
        path.addQuadCurve(
            to: CGPoint(
                x: rect.midX + rect.width * 0.25,
                y: rect.midY - rect.height * 0.18
            ),
            control: CGPoint(
                x: rect.midX + rect.width * 0.25,
                y: rect.midY - rect.height * 0.02
            )
        )

        let curve = SKShapeNode(path: path)
        curve.strokeColor = thread.color.withAlphaComponent(thread.alpha)
        curve.fillColor = .clear
        curve.lineWidth = 1.4
        curve.lineCap = .round
        curve.glowWidth = 1.6
        node.addChild(curve)

        return node
    }

    private func ancestralGlintNode(in rect: CGRect) -> SKNode {
        let glint = profile.ancestralGlint
        let node = SKNode()
        node.zPosition = 3

        guard glint.isActive else {
            return node
        }

        let sizes: [CGFloat] = [6.2, 3.8, 2.7]
        let positions = [
            CGPoint(x: rect.midX + rect.width * 0.13, y: rect.midY + rect.height * 0.18),
            CGPoint(x: rect.midX + rect.width * 0.04, y: rect.midY + rect.height * 0.10),
            CGPoint(x: rect.midX + rect.width * 0.19, y: rect.midY + rect.height * 0.08)
        ]

        for (index, size) in sizes.prefix(glint.glintCount).enumerated() {
            let dot = SKShapeNode(ellipseIn: CGRect(
                x: -size / 2,
                y: -size / 2,
                width: size,
                height: size
            ))
            dot.fillColor = glint.color.withAlphaComponent(glint.alpha - CGFloat(index) * 0.14)
            dot.strokeColor = .clear
            dot.glowWidth = index == 0 ? 2 : 1
            dot.position = positions[index]
            node.addChild(dot)
        }

        return node
    }

    private func patternMarkingNode(in rect: CGRect) -> SKNode {
        let marking = profile.patternMarking
        let node = SKNode()
        node.zPosition = 2

        let spots: [(CGPoint, CGSize, CGFloat)] = [
            (
                CGPoint(x: rect.midX - rect.width * 0.16, y: rect.midY + rect.height * 0.02),
                CGSize(width: rect.width * 0.11, height: rect.height * 0.060),
                -0.22
            ),
            (
                CGPoint(x: rect.midX + rect.width * 0.11, y: rect.midY - rect.height * 0.06),
                CGSize(width: rect.width * 0.085, height: rect.height * 0.050),
                0.18
            ),
            (
                CGPoint(x: rect.midX - rect.width * 0.02, y: rect.midY - rect.height * 0.18),
                CGSize(width: rect.width * 0.065, height: rect.height * 0.040),
                -0.08
            ),
            (
                CGPoint(x: rect.midX + rect.width * 0.20, y: rect.midY + rect.height * 0.08),
                CGSize(width: rect.width * 0.050, height: rect.height * 0.034),
                0.30
            )
        ]

        for (position, size, rotation) in spots.prefix(marking.visibleSpotCount) {
            let spreadPosition = CGPoint(
                x: rect.midX + ((position.x - rect.midX) * marking.spotSpread),
                y: rect.midY + ((position.y - rect.midY) * marking.spotSpread)
            )
            let scaledSize = CGSize(
                width: size.width * marking.spotScale,
                height: size.height * marking.spotScale
            )
            let dapple = SKShapeNode(ellipseIn: CGRect(
                x: -scaledSize.width / 2,
                y: -scaledSize.height / 2,
                width: scaledSize.width,
                height: scaledSize.height
            ))
            dapple.fillColor = marking.color.withAlphaComponent(marking.alpha)
            dapple.strokeColor = .clear
            dapple.position = spreadPosition
            dapple.zRotation = rotation
            node.addChild(dapple)
        }

        return node
    }

    private func bodyAccentNode(in rect: CGRect) -> SKNode {
        let accent = profile.silhouette.bodyAccent
        let node = SKNode()
        node.zPosition = 1

        switch accent.kind {
        case .bellyDrop:
            let drop = SKShapeNode(ellipseIn: CGRect(x: -14, y: -18, width: 28, height: 36))
            drop.fillColor = accent.color.withAlphaComponent(accent.alpha)
            drop.strokeColor = .clear
            drop.position = CGPoint(x: 0, y: rect.midY - 22)
            node.addChild(drop)
        case .petalChest:
            let petal = SKShapeNode(ellipseIn: CGRect(x: -10, y: -18, width: 20, height: 36))
            petal.fillColor = accent.color.withAlphaComponent(accent.alpha)
            petal.strokeColor = .clear
            petal.position = CGPoint(x: 0, y: rect.midY + 12)
            petal.zRotation = 0.18
            node.addChild(petal)
        case .softFacet:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -18, y: rect.midY + 12))
            path.addLine(to: CGPoint(x: 12, y: rect.midY + 24))
            path.addLine(to: CGPoint(x: 24, y: rect.midY - 2))
            path.addLine(to: CGPoint(x: -8, y: rect.midY - 18))
            path.closeSubpath()

            let facet = SKShapeNode(path: path)
            facet.fillColor = accent.color.withAlphaComponent(accent.alpha)
            facet.strokeColor = .clear
            node.addChild(facet)
        case .crescentBelly:
            let outer = SKShapeNode(ellipseIn: CGRect(x: -23, y: -19, width: 46, height: 38))
            outer.fillColor = accent.color.withAlphaComponent(accent.alpha)
            outer.strokeColor = .clear
            outer.position = CGPoint(x: 8, y: rect.midY - 10)

            let inner = SKShapeNode(ellipseIn: CGRect(x: -22, y: -18, width: 44, height: 36))
            inner.fillColor = profile.palette.body
            inner.strokeColor = .clear
            inner.position = CGPoint(x: 18, y: rect.midY - 7)

            node.addChild(outer)
            node.addChild(inner)
        case .sproutBelly:
            for xOffset in [-8.0, 8.0] {
                let leaf = SKShapeNode(ellipseIn: CGRect(x: -8, y: -13, width: 16, height: 26))
                leaf.fillColor = accent.color.withAlphaComponent(accent.alpha)
                leaf.strokeColor = .clear
                leaf.position = CGPoint(x: xOffset, y: rect.midY - 8)
                leaf.zRotation = xOffset < 0 ? -0.45 : 0.45
                node.addChild(leaf)
            }
        }

        return node
    }

    func headNode(_ input: HeadBuildInput) -> SKShapeNode {
        let headRect = profile.silhouette.headRect
        let node = SKShapeNode(path: HeadShapeRecipe(familyID: input.familyID).path(in: headRect))
        node.fillColor = input.fillColor
        node.strokeColor = .clear
        node.position = socketPosition(input.descriptor.socketID)
        node.addChild(growthHornBudNode(in: headRect))
        node.addChild(faceSilhouetteAccessoryNode(in: headRect))
        node.addChild(faceWarmthNode(in: headRect))
        node.addChild(faceAccentNode(in: headRect))
        node.addChild(faceLineageEchoNode(in: headRect))
        apply(input.descriptor.layerID, to: node)
        return node
    }

    private func growthHornBudNode(in rect: CGRect) -> SKNode {
        let cue = profile.growthHornBudCue
        let node = SKNode()
        node.zPosition = -0.35

        guard cue.visibleInPortrait else {
            return node
        }

        switch cue.budLabel {
        case "tinyRoundedBud":
            let size = CGSize(width: 17 * cue.budScale, height: 21 * cue.budScale)
            let bud = SKShapeNode(ellipseIn: CGRect(
                x: -size.width / 2,
                y: -size.height / 2,
                width: size.width,
                height: size.height
            ))
            bud.fillColor = cue.fillColor.withAlphaComponent(0.84)
            bud.strokeColor = cue.strokeColor
            bud.lineWidth = 1
            bud.glowWidth = cue.glowWidth
            bud.position = CGPoint(x: rect.midX, y: rect.maxY + 2)
            node.addChild(bud)
        case "softCrescentBud":
            for xOffset in [-8.0, 8.0] {
                let size = CGSize(width: 15 * cue.budScale, height: 23 * cue.budScale)
                let bud = SKShapeNode(ellipseIn: CGRect(
                    x: -size.width / 2,
                    y: -size.height / 2,
                    width: size.width,
                    height: size.height
                ))
                bud.fillColor = cue.fillColor.withAlphaComponent(0.84)
                bud.strokeColor = cue.strokeColor
                bud.lineWidth = 1
                bud.glowWidth = cue.glowWidth
                bud.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY + 1)
                bud.zRotation = xOffset < 0 ? -0.18 : 0.18
                node.addChild(bud)
            }
        default:
            break
        }

        return node
    }

    private func faceSilhouetteAccessoryNode(in rect: CGRect) -> SKNode {
        let accessory = profile.faceSilhouetteAccessory
        let node = SKNode()
        node.zPosition = -0.5

        switch accessory.accessory {
        case .none:
            break
        case .softEarNubs:
            for xOffset in [-33.0, 33.0] {
                let nub = SKShapeNode(ellipseIn: CGRect(x: -9, y: -11, width: 18, height: 22))
                nub.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                nub.strokeColor = SKColor.white.withAlphaComponent(0.20)
                nub.lineWidth = 1
                nub.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY - 4)
                nub.zRotation = xOffset < 0 ? -0.32 : 0.32
                node.addChild(nub)
            }
        case .softEarTips:
            for xOffset in [-32.0, 32.0] {
                let path = CGMutablePath()
                path.move(to: CGPoint(x: 0, y: 12))
                path.addQuadCurve(to: CGPoint(x: 10, y: -8), control: CGPoint(x: 10, y: 4))
                path.addQuadCurve(to: CGPoint(x: -10, y: -8), control: CGPoint(x: 0, y: -14))
                path.addQuadCurve(to: CGPoint(x: 0, y: 12), control: CGPoint(x: -10, y: 4))
                path.closeSubpath()

                let ear = SKShapeNode(path: path)
                ear.fillColor = accessory.color.withAlphaComponent(accessory.alpha)
                ear.strokeColor = SKColor.white.withAlphaComponent(0.20)
                ear.lineWidth = 1
                ear.position = CGPoint(x: rect.midX + xOffset, y: rect.maxY - 6)
                ear.zRotation = xOffset < 0 ? -0.48 : 0.48
                node.addChild(ear)
            }
        }

        return node
    }

    private func faceWarmthNode(in rect: CGRect) -> SKNode {
        let node = SKNode()
        node.zPosition = 0.8

        let cheekColor = SKColor(red: 1.00, green: 0.62, blue: 0.68, alpha: 1)
        let baseSize = CGSize(width: 22 * profile.expression.cheekWarmthScale, height: 11 * profile.expression.cheekWarmthScale)

        for xOffset in [-27.0, 27.0] {
            let cheek = SKShapeNode(ellipseIn: CGRect(
                x: -baseSize.width / 2,
                y: -baseSize.height / 2,
                width: baseSize.width,
                height: baseSize.height
            ))
            cheek.fillColor = cheekColor.withAlphaComponent(profile.expression.cheekWarmthAlpha)
            cheek.strokeColor = .clear
            cheek.glowWidth = 1.2
            cheek.position = CGPoint(x: rect.midX + xOffset, y: rect.midY - 10)
            node.addChild(cheek)
        }

        return node
    }

    private func faceAccentNode(in rect: CGRect) -> SKNode {
        let accent = profile.silhouette.faceAccent
        let node = SKNode()
        node.zPosition = 1

        switch accent.kind {
        case .softCheek:
            let cheek = SKShapeNode(ellipseIn: CGRect(x: -7, y: -4, width: 14, height: 8))
            cheek.fillColor = accent.color.withAlphaComponent(accent.alpha)
            cheek.strokeColor = .clear
            cheek.position = CGPoint(x: rect.midX + 28, y: rect.midY - 9)
            node.addChild(cheek)
        case .cheekGleam:
            for xOffset in [-26.0, 26.0] {
                let gleam = SKShapeNode(ellipseIn: CGRect(x: -4, y: -3, width: 8, height: 6))
                gleam.fillColor = accent.color.withAlphaComponent(accent.alpha)
                gleam.strokeColor = .clear
                gleam.position = CGPoint(x: rect.midX + xOffset, y: rect.midY - 8)
                node.addChild(gleam)
            }
        case .kittenGleam:
            for xOffset in [-26.0, 26.0] {
                let gleam = SKShapeNode(ellipseIn: CGRect(x: -4, y: -3, width: 8, height: 6))
                gleam.fillColor = accent.color.withAlphaComponent(accent.alpha)
                gleam.strokeColor = .clear
                gleam.position = CGPoint(x: rect.midX + xOffset, y: rect.midY - 8)
                node.addChild(gleam)
            }

            for xOffset in [-38.0, 38.0] {
                for (index, yOffset) in [-2.5, -8.0].enumerated() {
                    let dotSize = index == 0 ? 3.4 : 2.8
                    let dot = SKShapeNode(ellipseIn: CGRect(
                        x: -dotSize / 2,
                        y: -dotSize / 2,
                        width: dotSize,
                        height: dotSize
                    ))
                    dot.fillColor = accent.color.withAlphaComponent(accent.alpha * 0.86)
                    dot.strokeColor = .clear
                    dot.position = CGPoint(x: rect.midX + xOffset, y: rect.midY + yOffset)
                    node.addChild(dot)
                }
            }
        case .muzzleGlow:
            let muzzle = SKShapeNode(ellipseIn: CGRect(x: -13, y: -6, width: 26, height: 12))
            muzzle.fillColor = accent.color.withAlphaComponent(accent.alpha)
            muzzle.strokeColor = .clear
            muzzle.position = CGPoint(x: rect.midX, y: rect.midY - 20)
            node.addChild(muzzle)
        case .sideCheekDots:
            for xOffset in [-34.0, 34.0] {
                let dot = SKShapeNode(ellipseIn: CGRect(x: -3, y: -3, width: 6, height: 6))
                dot.fillColor = accent.color.withAlphaComponent(accent.alpha)
                dot.strokeColor = .clear
                dot.position = CGPoint(x: rect.midX + xOffset, y: rect.midY - 4)
                node.addChild(dot)
            }
        case .softFacet:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: rect.midX + 18, y: rect.midY + 12))
            path.addLine(to: CGPoint(x: rect.midX + 34, y: rect.midY + 18))
            path.addLine(to: CGPoint(x: rect.midX + 30, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX + 14, y: rect.midY - 5))
            path.closeSubpath()

            let facet = SKShapeNode(path: path)
            facet.fillColor = accent.color.withAlphaComponent(accent.alpha)
            facet.strokeColor = .clear
            node.addChild(facet)
        case .forestDots:
            let offsets = [
                CGPoint(x: -18, y: 2),
                CGPoint(x: 0, y: -4),
                CGPoint(x: 18, y: 2),
                CGPoint(x: -8, y: 9),
                CGPoint(x: 8, y: 9)
            ]
            for (index, offset) in offsets.prefix(accent.dotCount).enumerated() {
                let size = index == 1 ? 4.5 : 5.5
                let dot = SKShapeNode(ellipseIn: CGRect(
                    x: -size / 2,
                    y: -size / 2,
                    width: size,
                    height: size
                ))
                dot.fillColor = accent.color.withAlphaComponent(accent.alpha)
                dot.strokeColor = .clear
                dot.position = CGPoint(
                    x: rect.midX + offset.x,
                    y: rect.midY + offset.y
                )
                node.addChild(dot)
            }
        }

        return node
    }

    private func faceLineageEchoNode(in rect: CGRect) -> SKNode {
        let echo = profile.faceLineageEcho
        let node = SKNode()
        node.zPosition = 1.4

        guard echo.isActive else {
            return node
        }

        let placements = [
            CGPoint(x: rect.midX, y: rect.midY + rect.height * 0.23),
            CGPoint(x: rect.midX - rect.width * 0.10, y: rect.midY + rect.height * 0.17),
            CGPoint(x: rect.midX + rect.width * 0.10, y: rect.midY + rect.height * 0.17)
        ]

        for (index, placement) in placements.prefix(echo.dotCount).enumerated() {
            let size = [4.8, 3.4, 3.4][index]
            let dot = SKShapeNode(ellipseIn: CGRect(
                x: -size / 2,
                y: -size / 2,
                width: size,
                height: size
            ))
            dot.fillColor = echo.color.withAlphaComponent(echo.alpha - CGFloat(index) * 0.10)
            dot.strokeColor = .clear
            dot.glowWidth = index == 0 ? 1.4 : 0.8
            dot.position = placement
            node.addChild(dot)
        }

        return node
    }

    func glowRingNode() -> SKShapeNode {
        let node = SKShapeNode(ellipseIn: CGRect(x: -98, y: -98, width: 196, height: 196))
        node.fillColor = .clear
        node.strokeColor = profile.palette.glow
        node.lineWidth = profile.glowLineWidth
        node.glowWidth = profile.glowWidth

        let outerSize = 196 * profile.glowAura.outerScale
        let outerAura = SKShapeNode(ellipseIn: CGRect(
            x: -outerSize / 2,
            y: -outerSize / 2,
            width: outerSize,
            height: outerSize
        ))
        outerAura.fillColor = .clear
        outerAura.strokeColor = profile.palette.glow.withAlphaComponent(profile.glowAura.outerAlpha)
        outerAura.lineWidth = profile.glowAura.outerLineWidth
        outerAura.glowWidth = profile.glowAura.outerGlowWidth
        outerAura.zPosition = -1
        node.addChild(outerAura)
        node.addChild(glowMoteNode())

        apply(.glowRing, to: node)
        return node
    }

    private func glowMoteNode() -> SKNode {
        let node = SKNode()
        node.zPosition = 1

        let motes: [(CGPoint, CGFloat)] = [
            (CGPoint(x: -56, y: 66), 4.8),
            (CGPoint(x: 70, y: 34), 3.8),
            (CGPoint(x: 38, y: -74), 3.2)
        ]

        for (position, baseSize) in motes.prefix(profile.glowAura.moteCount) {
            let size = baseSize * profile.glowAura.moteScale
            let adjustedPosition = CGPoint(
                x: position.x + profile.glowAura.moteOffset.x,
                y: position.y + profile.glowAura.moteOffset.y
            )
            let mote = SKShapeNode(ellipseIn: CGRect(
                x: -size / 2,
                y: -size / 2,
                width: size,
                height: size
            ))
            mote.fillColor = profile.palette.glow.withAlphaComponent(profile.glowAura.moteAlpha)
            mote.strokeColor = .clear
            mote.glowWidth = size * 0.48
            mote.position = adjustedPosition
            node.addChild(mote)
        }

        return node
    }

    func eyeNode(_ input: EyeBuildInput) -> SKNode {
        let node = input.node
        node.fillColor = profile.palette.eye
        node.strokeColor = .clear
        let socket = socketPosition(input.descriptor.socketID)
        node.position = CGPoint(
            x: socket.x + profile.expression.gazeOffset.x,
            y: socket.y + profile.expression.gazeOffset.y
        )
        node.xScale = profile.expression.eyeXScale
        node.yScale = profile.expression.eyeYScale
        apply(input.descriptor.layerID, to: node)

        let catchlightSize = profile.expression.catchlightSize
        let catchlight = SKShapeNode(ellipseIn: CGRect(
            x: -catchlightSize / 2,
            y: -catchlightSize / 2,
            width: catchlightSize,
            height: catchlightSize
        ))
        catchlight.fillColor = SKColor.white.withAlphaComponent(profile.expression.catchlightAlpha)
        catchlight.strokeColor = .clear
        catchlight.position = profile.expression.catchlightOffset
        catchlight.zPosition = 7
        node.addChild(catchlight)
        return node
    }

    func mouthNode(_ input: MouthBuildInput) -> SKShapeNode {
        let path = CGMutablePath()
        let width = profile.silhouette.mouthWidth
        path.addRoundedRect(
            in: CGRect(x: -width / 2, y: -2.5, width: width, height: 5),
            cornerWidth: 2.5,
            cornerHeight: 2.5
        )
        let node = SKShapeNode(path: path)
        node.fillColor = input.fillColor
        node.strokeColor = .clear
        node.position = socketPosition(input.descriptor.socketID)
        apply(input.descriptor.layerID, to: node)
        return node
    }

    func wingInput(_ id: CreatureLayerID) -> WingBuildInput {
        WingBuildInput(
            descriptor: partDescriptor(id),
            familyID: partFamilies.wing,
            rotationDegrees: id == .leftWing
                ? 28 + profile.silhouette.wingRotationAdjustmentDegrees
                : -28 - profile.silhouette.wingRotationAdjustmentDegrees,
            color: id == .leftWing ? profile.palette.leftWing : profile.palette.rightWing
        )
    }

    func tailInput() -> TailBuildInput {
        TailBuildInput(
            descriptor: partDescriptor(.tail),
            familyID: partFamilies.tail,
            fillColor: profile.palette.tail,
            strokeColor: profile.palette.tailStroke,
            rotationDegrees: profile.silhouette.tailRotationDegrees
        )
    }

    func bodyInput() -> BodyBuildInput {
        BodyBuildInput(
            descriptor: partDescriptor(.body),
            familyID: partFamilies.body,
            fillColor: profile.palette.body
        )
    }

    func headInput() -> HeadBuildInput {
        HeadBuildInput(
            descriptor: partDescriptor(.head),
            familyID: partFamilies.face,
            fillColor: profile.palette.head
        )
    }

    func eyeInput(_ id: CreatureLayerID, node: SKShapeNode) -> EyeBuildInput {
        EyeBuildInput(
            descriptor: partDescriptor(id),
            familyID: .softEye,
            node: node
        )
    }

    func mouthInput() -> MouthBuildInput {
        MouthBuildInput(
            descriptor: partDescriptor(.mouth),
            familyID: .quietMouth,
            fillColor: profile.palette.mouth
        )
    }

    func assemblyPlan(leftEye: SKShapeNode, rightEye: SKShapeNode) -> CreatureAssemblyPlan {
        CreatureAssemblyPlan(
            visibleParts: [
                .wing(wingInput(.leftWing)),
                .wing(wingInput(.rightWing)),
                .tail(tailInput()),
                .body(bodyInput()),
                .head(headInput()),
                .eye(eyeInput(.leftEye, node: leftEye)),
                .eye(eyeInput(.rightEye, node: rightEye)),
                .mouth(mouthInput())
            ]
        )
    }

    private func apply(_ id: CreatureLayerID, to node: SKNode) {
        node.name = id.rawValue
        node.zPosition = id.zPosition
    }

    private func socketPosition(_ id: CreatureSocketID) -> CGPoint {
        sockets[id]?.position ?? .zero
    }

    func partDescriptor(_ id: CreatureLayerID) -> CreaturePartDescriptor {
        partDescriptors[id] ?? CreaturePartDescriptor(layerID: id, socketID: .bodyCenter)
    }
}

private extension CreatureSocketID {
    static var defaultSockets: [CreatureSocketID: CreatureSocket] {
        Dictionary(uniqueKeysWithValues: allCases.map { id in
            (id, CreatureSocket(id: id, position: id.defaultPosition))
        })
    }

    var defaultPosition: CGPoint {
        switch self {
        case .bodyCenter, .headCenter:
            .zero
        case .leftWingRoot:
            CGPoint(x: -82, y: -4)
        case .rightWingRoot:
            CGPoint(x: 82, y: -4)
        case .tailRoot:
            CGPoint(x: 78, y: -72)
        case .leftEyeCenter:
            CGPoint(x: -31, y: 68)
        case .rightEyeCenter:
            CGPoint(x: 31, y: 68)
        case .mouthCenter:
            CGPoint(x: 0, y: 43)
        }
    }
}

private extension CreaturePartDescriptor {
    static var defaultDescriptors: [CreatureLayerID: CreaturePartDescriptor] {
        [
            .leftWing: CreaturePartDescriptor(layerID: .leftWing, socketID: .leftWingRoot),
            .rightWing: CreaturePartDescriptor(layerID: .rightWing, socketID: .rightWingRoot),
            .tail: CreaturePartDescriptor(layerID: .tail, socketID: .tailRoot),
            .body: CreaturePartDescriptor(layerID: .body, socketID: .bodyCenter),
            .head: CreaturePartDescriptor(layerID: .head, socketID: .headCenter),
            .leftEye: CreaturePartDescriptor(layerID: .leftEye, socketID: .leftEyeCenter),
            .rightEye: CreaturePartDescriptor(layerID: .rightEye, socketID: .rightEyeCenter),
            .mouth: CreaturePartDescriptor(layerID: .mouth, socketID: .mouthCenter)
        ]
    }
}

extension CreatureFixedPartCatalog {
    static let currentLuma = CreatureFixedPartCatalog(
        ambientRecipeIDs: [.softGlowRing, .quietGlowMotes],
        patternRecipeIDs: [.softBellyDapples],
        growthDetailRecipeIDs: [.tinyRoundedHornBud],
        entries: [
            CreatureFixedPartCatalogEntry(
                familyID: .lunarWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softLunarWing],
                detailRecipeIDs: [],
                silhouetteIntent: "softArc",
                affectionCue: "protective"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .fairyWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softLeafWing],
                detailRecipeIDs: [.softVein, .softWingTipPearl],
                silhouetteIntent: "leafPair",
                affectionCue: "lightWinglets"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .dragonWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softSailWing],
                detailRecipeIDs: [.softRim, .softWingTipClaw],
                silhouetteIntent: "wideSail",
                affectionCue: "braveLift"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .crystalWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softFacetWing],
                detailRecipeIDs: [.facetDot],
                silhouetteIntent: "gemPair",
                affectionCue: "sparkFacet"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .jellyfishWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softBellWing],
                detailRecipeIDs: [.bellDot],
                silhouetteIntent: "softBell",
                affectionCue: "gentleDrift"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .plantWing,
                layerIDs: [.leftWing, .rightWing],
                socketIDs: [.leftWingRoot, .rightWingRoot],
                shapeRecipeIDs: [.softSproutWing],
                detailRecipeIDs: [.sproutVein],
                silhouetteIntent: "sproutLeaf",
                affectionCue: "freshLittleLift"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .floatingTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.roundedRibbonTail],
                detailRecipeIDs: [.floatingOrb, .softTetherDot],
                silhouetteIntent: "moonRibbon",
                affectionCue: "ancestralGlow"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .dragonTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.dragonTaperTail],
                detailRecipeIDs: [.roundedCap, .softDrakeRidge],
                silhouetteIntent: "longDrake",
                affectionCue: "smallCourage"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .fishTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.fishTaperTail],
                detailRecipeIDs: [.fishFin, .softForkFin],
                silhouetteIntent: "fishFin",
                affectionCue: "waterWiggle"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .crystalTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.softFacetTail],
                detailRecipeIDs: [.roundedCap],
                silhouetteIntent: "gemTail",
                affectionCue: "clearGlint"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .plantTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.leafSproutTail],
                detailRecipeIDs: [.leafBud, .softLeafVein],
                silhouetteIntent: "leafSprout",
                affectionCue: "tinySprout"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .softTail,
                layerIDs: [.tail],
                socketIDs: [.tailRoot],
                shapeRecipeIDs: [.roundedRibbonTail],
                detailRecipeIDs: [.roundedCap],
                silhouetteIntent: "softStub",
                affectionCue: "littleBalance"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .juvenileBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.softOvalBody],
                detailRecipeIDs: [],
                silhouetteIntent: "roundBelly",
                affectionCue: "touchable"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .aquarianBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.waterDropBody],
                detailRecipeIDs: [.bellyDrop],
                silhouetteIntent: "waterDrop",
                affectionCue: "coolBelly"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .sylphianBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.seedPetalBody],
                detailRecipeIDs: [.petalChest, .softShoulderPetals],
                silhouetteIntent: "seedPetal",
                affectionCue: "softSprout"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .crystalianBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.pebbleGemBody],
                detailRecipeIDs: [.softFacetBody],
                silhouetteIntent: "pebbleGem",
                affectionCue: "quietFacet"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .lunarianBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.moonOvalBody],
                detailRecipeIDs: [.crescentBelly, .softMoonShoulderCrescents],
                silhouetteIntent: "moonOval",
                affectionCue: "sleepyGlow"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .verdantBody,
                layerIDs: [.body],
                socketIDs: [.bodyCenter],
                shapeRecipeIDs: [.leafBellyBody],
                detailRecipeIDs: [.sproutBelly, .leafShoulderNubs],
                silhouetteIntent: "leafBelly",
                affectionCue: "leafWarmth"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .roundHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softRoundHead],
                detailRecipeIDs: [.softCheek],
                silhouetteIntent: "largeSoftFace",
                affectionCue: "approachable"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .fairyHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softPetalHead],
                detailRecipeIDs: [.cheekGleam],
                silhouetteIntent: "smallFairy",
                affectionCue: "brightLittleFace"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .dragonHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softBroadHead],
                detailRecipeIDs: [.muzzleGlow],
                silhouetteIntent: "broadDragon",
                affectionCue: "babyBravery"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .axolotlHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softWideHead],
                detailRecipeIDs: [.sideCheekDots],
                silhouetteIntent: "wideAxolotl",
                affectionCue: "curiousCheeks"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .crystalHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softFacetHead],
                detailRecipeIDs: [.softFacetFace],
                silhouetteIntent: "faceted",
                affectionCue: "clearGaze"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .deerHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softDeerHead],
                detailRecipeIDs: [.forestDots, .softEarNubs],
                silhouetteIntent: "softDeer",
                affectionCue: "gentleForestFace"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .felineHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softFelineHead],
                detailRecipeIDs: [.kittenGleam, .softWhiskerDots, .softEarTips],
                silhouetteIntent: "softFeline",
                affectionCue: "watchfulKittenFace"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .lunarHead,
                layerIDs: [.head],
                socketIDs: [.headCenter],
                shapeRecipeIDs: [.softCrescentHead],
                detailRecipeIDs: [.moonCheek],
                silhouetteIntent: "softCrescent",
                affectionCue: "moonlitCalm"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .softEye,
                layerIDs: [.leftEye, .rightEye],
                socketIDs: [.leftEyeCenter, .rightEyeCenter],
                shapeRecipeIDs: [.softEyeDot],
                detailRecipeIDs: [.softCatchlight],
                silhouetteIntent: "kindDots",
                affectionCue: "watchful"
            ),
            CreatureFixedPartCatalogEntry(
                familyID: .quietMouth,
                layerIDs: [.mouth],
                socketIDs: [.mouthCenter],
                shapeRecipeIDs: [.quietMouthLine],
                detailRecipeIDs: [],
                silhouetteIntent: "tinyCalmLine",
                affectionCue: "gentleMood"
            )
        ]
    )
}

private extension WingShapeRecipe {
    static let softLunar = WingShapeRecipe(
        top: CGPoint(x: 0, y: 54),
        rightTip: CGPoint(x: 45, y: -48),
        rightControl: CGPoint(x: 50, y: 0),
        bottomControl: CGPoint(x: 0, y: -66),
        leftTip: CGPoint(x: -45, y: -48),
        leftControl: CGPoint(x: -50, y: 0)
    )

    static let softLeaf = WingShapeRecipe(
        top: CGPoint(x: 0, y: 60),
        rightTip: CGPoint(x: 34, y: -52),
        rightControl: CGPoint(x: 42, y: 6),
        bottomControl: CGPoint(x: 0, y: -70),
        leftTip: CGPoint(x: -34, y: -52),
        leftControl: CGPoint(x: -42, y: 6)
    )

    static let softSail = WingShapeRecipe(
        top: CGPoint(x: 0, y: 48),
        rightTip: CGPoint(x: 54, y: -44),
        rightControl: CGPoint(x: 60, y: -4),
        bottomControl: CGPoint(x: 0, y: -62),
        leftTip: CGPoint(x: -54, y: -44),
        leftControl: CGPoint(x: -60, y: -4)
    )

    static let softFacet = WingShapeRecipe(
        top: CGPoint(x: 0, y: 52),
        rightTip: CGPoint(x: 43, y: -45),
        rightControl: CGPoint(x: 52, y: 8),
        bottomControl: CGPoint(x: 3, y: -64),
        leftTip: CGPoint(x: -42, y: -50),
        leftControl: CGPoint(x: -48, y: -2)
    )

    static let softBell = WingShapeRecipe(
        top: CGPoint(x: 0, y: 45),
        rightTip: CGPoint(x: 40, y: -38),
        rightControl: CGPoint(x: 54, y: 6),
        bottomControl: CGPoint(x: 0, y: -58),
        leftTip: CGPoint(x: -40, y: -38),
        leftControl: CGPoint(x: -54, y: 6)
    )

    static let softSprout = WingShapeRecipe(
        top: CGPoint(x: 0, y: 62),
        rightTip: CGPoint(x: 30, y: -48),
        rightControl: CGPoint(x: 46, y: 12),
        bottomControl: CGPoint(x: 0, y: -64),
        leftTip: CGPoint(x: -30, y: -48),
        leftControl: CGPoint(x: -46, y: 12)
    )
}
