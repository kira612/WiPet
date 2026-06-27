public enum FaceBase: String, CaseIterable, Codable, Equatable, Sendable {
    case round
    case fairy
    case dragon
    case axolotl
    case crystal
    case deer
    case feline
    case lunar
}

public enum BodyBase: String, CaseIterable, Codable, Equatable, Sendable {
    case aquarian
    case sylphian
    case crystalian
    case lunarian
    case verdant
}

public enum WingBase: String, CaseIterable, Codable, Equatable, Sendable {
    case fairy
    case dragon
    case crystal
    case jellyfish
    case lunar
    case plant
}

public enum TailBase: String, CaseIterable, Codable, Equatable, Sendable {
    case dragon
    case fish
    case crystal
    case floating
    case plant
}

public enum FixedPartSocketID: String, CaseIterable, Codable, Equatable, Sendable {
    case bodyCenter
    case headCenter
    case leftWingRoot
    case rightWingRoot
    case tailRoot
}

public enum CommonPetRigJointID: String, CaseIterable, Codable, Equatable, Sendable {
    case body
    case head
    case wingL = "wing_L"
    case wingR = "wing_R"
    case tail1 = "tail_1"
}

public enum FixedPartFamilyID: String, CaseIterable, Codable, Equatable, Sendable {
    case faceBase = "FaceBase"
    case upperBody = "UpperBody"
    case wingBase = "WingBase"
    case tailBase = "TailBase"
}

public struct FixedPartSocketBinding: Equatable, Codable, Sendable {
    public var family: FixedPartFamilyID
    public var socketIDs: [FixedPartSocketID]
    public var rigJointIDs: [CommonPetRigJointID]

    public init(
        family: FixedPartFamilyID,
        socketIDs: [FixedPartSocketID],
        rigJointIDs: [CommonPetRigJointID]
    ) {
        self.family = family
        self.socketIDs = socketIDs
        self.rigJointIDs = rigJointIDs
    }

    public var hasRequiredFields: Bool {
        !socketIDs.isEmpty
            && !rigJointIDs.isEmpty
    }

    public var summary: String {
        "\(family.rawValue):\(Self.format(socketIDs.map(\.rawValue)))->\(Self.format(rigJointIDs.map(\.rawValue)))"
    }

    private static func format(_ values: [String]) -> String {
        values.isEmpty ? "none" : values.joined(separator: "+")
    }
}

public struct CommonPetRigSocketMap: Equatable, Codable, Sendable {
    public var rigID: String
    public var bindings: [FixedPartSocketBinding]
    public var allowsGeneratedGeometry: Bool
    public var allowsRuntimeAssetLoad: Bool
    public var assetOutputs: String
    public var validated3DAssets: Bool

    public init(
        rigID: String = "CommonPetRig",
        bindings: [FixedPartSocketBinding] = Self.defaultBindings,
        allowsGeneratedGeometry: Bool = false,
        allowsRuntimeAssetLoad: Bool = false,
        assetOutputs: String = "none",
        validated3DAssets: Bool = false
    ) {
        self.rigID = rigID
        self.bindings = bindings
        self.allowsGeneratedGeometry = allowsGeneratedGeometry
        self.allowsRuntimeAssetLoad = allowsRuntimeAssetLoad
        self.assetOutputs = assetOutputs
        self.validated3DAssets = validated3DAssets
    }

    public static var defaultBindings: [FixedPartSocketBinding] {
        [
            FixedPartSocketBinding(
                family: .faceBase,
                socketIDs: [.headCenter],
                rigJointIDs: [.head]
            ),
            FixedPartSocketBinding(
                family: .upperBody,
                socketIDs: [.bodyCenter],
                rigJointIDs: [.body]
            ),
            FixedPartSocketBinding(
                family: .wingBase,
                socketIDs: [.leftWingRoot, .rightWingRoot],
                rigJointIDs: [.wingL, .wingR]
            ),
            FixedPartSocketBinding(
                family: .tailBase,
                socketIDs: [.tailRoot],
                rigJointIDs: [.tail1]
            )
        ]
    }

    public var hasRequiredFields: Bool {
        rigID == "CommonPetRig"
            && Set(bindings.map(\.family)) == Set(FixedPartFamilyID.allCases)
            && bindings.allSatisfy(\.hasRequiredFields)
            && !allowsGeneratedGeometry
            && !allowsRuntimeAssetLoad
            && assetOutputs == "none"
            && !validated3DAssets
    }

    public var summary: String {
        let bindingSummary = bindings
            .map(\.summary)
            .joined(separator: ",")
        return "commonPetRigSocketMap=rig:\(rigID);bindings:\(bindingSummary);geometryGenerated:\(allowsGeneratedGeometry);runtimeLoaded:\(allowsRuntimeAssetLoad);assetOutputs:\(assetOutputs);validated3DAssets:\(validated3DAssets)"
    }

    public var readinessSummary: String {
        "commonPetRigSocketMapReady:\(hasRequiredFields)"
    }
}

public struct CommonPetRigAssetValidationPreflight: Equatable, Codable, Sendable {
    public var socketMap: CommonPetRigSocketMap
    public var hasAcceptedReferenceArtifact: Bool
    public var hasAssetCandidate: Bool
    public var usesModelIO: Bool
    public var usesSceneKit: Bool
    public var usesRealityKit: Bool
    public var allowsGeneratedGeometry: Bool
    public var allowsRuntimeAssetLoad: Bool
    public var assetOutputs: String

    public init(
        socketMap: CommonPetRigSocketMap = CommonPetRigSocketMap(),
        hasAcceptedReferenceArtifact: Bool = false,
        hasAssetCandidate: Bool = false,
        usesModelIO: Bool = false,
        usesSceneKit: Bool = false,
        usesRealityKit: Bool = false,
        allowsGeneratedGeometry: Bool = false,
        allowsRuntimeAssetLoad: Bool = false,
        assetOutputs: String = "none"
    ) {
        self.socketMap = socketMap
        self.hasAcceptedReferenceArtifact = hasAcceptedReferenceArtifact
        self.hasAssetCandidate = hasAssetCandidate
        self.usesModelIO = usesModelIO
        self.usesSceneKit = usesSceneKit
        self.usesRealityKit = usesRealityKit
        self.allowsGeneratedGeometry = allowsGeneratedGeometry
        self.allowsRuntimeAssetLoad = allowsRuntimeAssetLoad
        self.assetOutputs = assetOutputs
    }

    public var hasArtifactEvidence: Bool {
        hasAcceptedReferenceArtifact || hasAssetCandidate
    }

    public var validationAllowed: Bool {
        socketMap.hasRequiredFields
            && hasArtifactEvidence
            && usesModelIO
            && !allowsGeneratedGeometry
            && !allowsRuntimeAssetLoad
            && assetOutputs == "none"
    }

    public var isDeferredSafely: Bool {
        socketMap.hasRequiredFields
            && !hasArtifactEvidence
            && !usesModelIO
            && !usesSceneKit
            && !usesRealityKit
            && !allowsGeneratedGeometry
            && !allowsRuntimeAssetLoad
            && assetOutputs == "none"
    }

    public var summary: String {
        "commonPetRigAssetValidationPreflight=rig:\(socketMap.rigID);socketMapReady:\(socketMap.hasRequiredFields);referenceArtifact:\(hasAcceptedReferenceArtifact);assetCandidate:\(hasAssetCandidate);modelIO:\(usesModelIO);sceneKit:\(usesSceneKit);realityKit:\(usesRealityKit);validationAllowed:\(validationAllowed);deferredSafely:\(isDeferredSafely);geometryGenerated:\(allowsGeneratedGeometry);runtimeLoaded:\(allowsRuntimeAssetLoad);assetOutputs:\(assetOutputs)"
    }

    public var readinessSummary: String {
        "commonPetRigAssetValidationPreflightReady:\(validationAllowed || isDeferredSafely)"
    }
}
