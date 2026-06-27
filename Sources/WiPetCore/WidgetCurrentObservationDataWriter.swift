import Foundation

public enum WidgetCurrentObservationDataWriteResult: Equatable, Sendable {
    case written
    case failed
}

public enum WidgetCurrentObservationDataWriter {
    public static func writeCurrentObservation(
        _ observation: WidgetPetObservation,
        to defaults: UserDefaults?
    ) -> WidgetCurrentObservationDataWriteResult {
        writeCurrentObservationPayload(
            WidgetPetObservationTransferPayload(observation: observation),
            to: defaults
        )
    }

    public static func writeCurrentObservationPayload(
        _ payload: WidgetPetObservationTransferPayload,
        to defaults: UserDefaults?
    ) -> WidgetCurrentObservationDataWriteResult {
        guard let defaults else {
            return .failed
        }

        do {
            let data = try payload.encodeJSON()
            defaults.set(data, forKey: WidgetSharedDataKeys.currentObservationJSON)
            return .written
        } catch {
            return .failed
        }
    }
}
