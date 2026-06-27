import SwiftUI
import WiPetCore

enum WiPetWidgetLineageCueDisplayMode {
    case hidden
    case full
    case compact
    case compactWhenDiscoveryFits(maxDiscoveryCharacters: Int)

    static let selectiveCompactMaxDiscoveryCharacters = 44
}

struct WiPetWidgetObservationContentView: View {
    let observation: WidgetPetObservation
    var lineageCueDisplayMode: WiPetWidgetLineageCueDisplayMode = .hidden

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(observation.text.identityLine)
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.20, green: 0.24, blue: 0.28))

            Text(observation.text.stateLine)
                .font(.system(.footnote, design: .rounded, weight: .medium))
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

            Spacer(minLength: 4)

            Text(observation.text.discoveryLine)
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(Color(red: 0.15, green: 0.17, blue: 0.20))
                .lineLimit(3)

            HStack(spacing: 5) {
                Image(systemName: "sparkle.magnifyingglass")
                    .font(.system(.caption2, weight: .semibold))

                Text(observation.text.memoryCueLine)
                    .font(.system(.caption2, design: .rounded, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .allowsTightening(true)
            }
            .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))

            if let lineageCueLine {
                HStack(spacing: 5) {
                    Image(systemName: "link")
                        .font(.system(.caption2, weight: .semibold))

                    Text(lineageCueLine)
                        .font(.system(.caption2, design: .rounded, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)
                        .allowsTightening(true)
                }
                .foregroundStyle(Color(red: 0.35, green: 0.41, blue: 0.48))
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityIdentifier("wiPetWidgetObservationWindow")
        .accessibilityLabel(observationWindowAccessibilityLabel)
    }

    private var lineageCueLine: String? {
        switch lineageCueDisplayMode {
        case .hidden:
            nil
        case .full:
            observation.text.lineageCueLine
        case .compact:
            observation.text.lineageCueCompactLine
        case let .compactWhenDiscoveryFits(maxDiscoveryCharacters):
            observation.text.lineageCueCompactLineWhenDiscoveryFits(
                maxDiscoveryCharacters: maxDiscoveryCharacters
            )
        }
    }

    private var observationWindowAccessibilityLabel: String {
        observation.text.observationWindowAccessibilityLabel(displayedLineageCueLine: lineageCueLine)
    }
}

extension LinearGradient {
    static var wiPetWidgetObservationBackground: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.97, green: 0.94, blue: 0.88),
                Color(red: 0.84, green: 0.92, blue: 0.91),
                Color(red: 0.80, green: 0.82, blue: 0.91)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
