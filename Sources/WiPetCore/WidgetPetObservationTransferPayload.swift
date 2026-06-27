import Foundation

public struct WidgetPetObservationTransferPayload: Codable, Equatable, Sendable {
    public static let currentSchemaVersion = 1

    public var schemaVersion: Int
    public var name: String
    public var speciesName: String
    public var growthStageName: String
    public var generation: Int
    public var mood: String
    public var ageLabel: String
    public var latestDiscoveryText: String
    public var latestDiscoveryMemoryCueLabel: String?
    public var latestDiscoveryLineageCueLabel: String?

    public init(
        snapshot: WidgetPetSnapshot,
        schemaVersion: Int = Self.currentSchemaVersion
    ) {
        self.schemaVersion = schemaVersion
        self.name = snapshot.name
        self.speciesName = snapshot.speciesName
        self.growthStageName = snapshot.growthStageName
        self.generation = snapshot.generation
        self.mood = snapshot.mood
        self.ageLabel = snapshot.ageLabel
        self.latestDiscoveryText = snapshot.latestDiscoveryText
        self.latestDiscoveryMemoryCueLabel = snapshot.latestDiscoveryMemoryCueLabel
        self.latestDiscoveryLineageCueLabel = snapshot.latestDiscoveryLineageCueLabel
    }

    public init(observation: WidgetPetObservation) {
        self.init(snapshot: observation.snapshot)
    }

    public var snapshot: WidgetPetSnapshot {
        WidgetPetSnapshot(
            name: name,
            speciesName: speciesName,
            growthStageName: growthStageName,
            generation: generation,
            mood: mood,
            ageLabel: ageLabel,
            latestDiscoveryText: latestDiscoveryText,
            latestDiscoveryMemoryCueLabel: latestDiscoveryMemoryCueLabel ?? Self.compatibilityMemoryCueLabel(
                growthStageName: growthStageName
            ),
            latestDiscoveryLineageCueLabel: latestDiscoveryLineageCueLabel
        )
    }

    public var observation: WidgetPetObservation {
        let rebuiltSnapshot = snapshot
        return WidgetPetObservation(
            snapshot: rebuiltSnapshot,
            text: WidgetPetSnapshotText(snapshot: rebuiltSnapshot)
        )
    }

    public static func decodeJSON(from data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }

    public func encodeJSON() throws -> Data {
        try JSONEncoder().encode(self)
    }

    public static func compatibilityMemoryCueLabel(growthStageName: String) -> String {
        "\(growthStageName) quiet memory"
    }
}

public enum WidgetPetObservationPayloadSourceResult: Equatable, Sendable {
    case loaded(WidgetPetObservationTransferPayload)
    case missing

    public static func decodeJSONData(_ data: Data) -> Self {
        do {
            return try .loaded(WidgetPetObservationTransferPayload.decodeJSON(from: data))
        } catch {
            return .missing
        }
    }

    public static func data(_ data: Data?) -> Self {
        guard let data else {
            return .missing
        }
        return decodeJSONData(data)
    }

    public var payload: WidgetPetObservationTransferPayload? {
        switch self {
        case let .loaded(payload):
            payload
        case .missing:
            nil
        }
    }

    public var requiresFallbackObservation: Bool {
        switch self {
        case .loaded:
            false
        case .missing:
            true
        }
    }

    public var qaReadinessSourceState: String {
        requiresFallbackObservation ? "fallbackRequired" : "loaded"
    }
}

public enum WidgetPetObservationHandoffReader {
    public static func currentObservation(from data: Data?) -> WidgetPetObservationPayloadSourceResult {
        WidgetPetObservationPayloadSourceResult.data(data)
    }
}
