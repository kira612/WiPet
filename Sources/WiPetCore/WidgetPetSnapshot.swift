public struct WidgetPetSnapshot: Equatable, Sendable {
    public var name: String
    public var speciesName: String
    public var growthStageName: String
    public var generation: Int
    public var mood: String
    public var ageLabel: String
    public var latestDiscoveryText: String
    public var latestDiscoveryMemoryCueLabel: String
    public var latestDiscoveryLineageCueLabel: String?

    public init(
        name: String,
        speciesName: String,
        growthStageName: String,
        generation: Int,
        mood: String,
        ageLabel: String,
        latestDiscoveryText: String,
        latestDiscoveryMemoryCueLabel: String = "Quiet memory",
        latestDiscoveryLineageCueLabel: String? = nil
    ) {
        self.name = name
        self.speciesName = speciesName
        self.growthStageName = growthStageName
        self.generation = max(1, generation)
        self.mood = mood
        self.ageLabel = ageLabel
        self.latestDiscoveryText = latestDiscoveryText
        self.latestDiscoveryMemoryCueLabel = latestDiscoveryMemoryCueLabel
        self.latestDiscoveryLineageCueLabel = latestDiscoveryLineageCueLabel
    }

    public init(
        creature: Creature,
        mood: String = "Quietly curious",
        ageLabel: String? = nil
    ) {
        let discovery = creature.widgetSnapshotDiscovery

        self.init(
            name: creature.name,
            speciesName: creature.species.widgetDisplayName,
            growthStageName: creature.growthStage.widgetDisplayName,
            generation: creature.generation,
            mood: mood,
            ageLabel: ageLabel ?? creature.growthStage.widgetAgeLabel,
            latestDiscoveryText: discovery?.title ?? creature.widgetRestingDiscoveryText,
            latestDiscoveryMemoryCueLabel: discovery?.memoryCueLabel ?? creature.widgetRestingMemoryCueLabel,
            latestDiscoveryLineageCueLabel: discovery?.lineageCueLabel
        )
    }
}

public extension Creature {
    var widgetRestingDiscoveryText: String {
        "\(name) is resting quietly."
    }

    var widgetRestingMemoryCueLabel: String {
        "\(growthStage.widgetDisplayName) quiet memory"
    }
}

public struct WidgetPetSnapshotText: Equatable, Sendable {
    public var identityLine: String
    public var stateLine: String
    public var discoveryLine: String
    public var memoryCueLine: String
    public var lineageCueLine: String?
    public var lineageCueCompactLine: String?

    public init(
        identityLine: String,
        stateLine: String,
        discoveryLine: String,
        memoryCueLine: String,
        lineageCueLine: String? = nil,
        lineageCueCompactLine: String? = nil
    ) {
        self.identityLine = identityLine
        self.stateLine = stateLine
        self.discoveryLine = discoveryLine
        self.memoryCueLine = memoryCueLine
        self.lineageCueLine = lineageCueLine
        self.lineageCueCompactLine = lineageCueCompactLine
    }

    public init(snapshot: WidgetPetSnapshot) {
        let lineageCueLine = snapshot.latestDiscoveryLineageCueLabel
        self.init(
            identityLine: "\(snapshot.name) - \(snapshot.speciesName) - Gen \(snapshot.generation)",
            stateLine: "\(snapshot.mood) - \(snapshot.ageLabel)",
            discoveryLine: snapshot.latestDiscoveryText,
            memoryCueLine: snapshot.latestDiscoveryMemoryCueLabel,
            lineageCueLine: lineageCueLine,
            lineageCueCompactLine: lineageCueLine == nil ? nil : "Family line"
        )
    }

    public func lineageCueCompactLineWhenDiscoveryFits(maxDiscoveryCharacters: Int) -> String? {
        guard maxDiscoveryCharacters > 0,
              discoveryLine.count <= maxDiscoveryCharacters
        else {
            return nil
        }

        return lineageCueCompactLine
    }

    public func observationWindowAccessibilityLabel(displayedLineageCueLine: String? = nil) -> String {
        var segments = [
            "WiPet observation window",
            identityLine,
            stateLine,
            discoveryLine,
            memoryCueLine
        ]

        if let displayedLineageCueLine,
           !displayedLineageCueLine.isEmpty {
            segments.append(displayedLineageCueLine)
        }

        return segments
            .map(Self.normalizedAccessibilitySegment)
            .filter { !$0.isEmpty }
            .joined(separator: ". ")
    }

    private static func normalizedAccessibilitySegment(_ segment: String) -> String {
        var normalized = segment

        while normalized.last == "." {
            normalized.removeLast()
        }

        return normalized
    }
}

public struct WidgetPetObservation: Equatable, Sendable {
    public var snapshot: WidgetPetSnapshot
    public var text: WidgetPetSnapshotText

    public init(
        snapshot: WidgetPetSnapshot,
        text: WidgetPetSnapshotText
    ) {
        self.snapshot = snapshot
        self.text = text
    }

    public init(
        creature: Creature,
        mood: String = "Quietly curious",
        ageLabel: String? = nil
    ) {
        let snapshot = WidgetPetSnapshot(
            creature: creature,
            mood: mood,
            ageLabel: ageLabel
        )
        self.init(
            snapshot: snapshot,
            text: WidgetPetSnapshotText(snapshot: snapshot)
        )
    }
}

private extension Species {
    var widgetDisplayName: String {
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
    var widgetDisplayName: String {
        switch self {
        case .egg: "Egg"
        case .baby: "Baby"
        case .juvenile: "Juvenile"
        case .adult: "Adult"
        case .elder: "Elder"
        }
    }

    var widgetAgeLabel: String {
        switch self {
        case .egg: "Newly formed"
        case .baby: "Tiny days"
        case .juvenile: "Growing days"
        case .adult: "Settled days"
        case .elder: "Ancestral days"
        }
    }
}
