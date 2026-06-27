public enum RendererMetadataSummary {
    public static func combine(
        catalogMetadataSummary: String,
        assemblyPlanCatalogValidationSummary: String
    ) -> String {
        "\(catalogMetadataSummary),\(assemblyPlanCatalogValidationSummary)"
    }

    public static func hasPopulatedFields(
        catalogMetadataSummary: String,
        assemblyPlanCatalogValidationSummary: String,
        rendererMetadataSummary: String
    ) -> Bool {
        !catalogMetadataSummary.isEmpty
            && !assemblyPlanCatalogValidationSummary.isEmpty
            && !rendererMetadataSummary.isEmpty
    }

    public static func readinessSummary(isReady: Bool) -> String {
        "rendererMetadataReady:\(isReady)"
    }

    public static func nodeInspectionSummary(
        readinessSummary: String,
        rendererMetadataSummary: String
    ) -> String {
        "\(readinessSummary),\(rendererMetadataSummary)"
    }

    public static func hasNodeInspectionFields(
        readinessSummary: String,
        rendererMetadataSummary: String,
        nodeInspectionSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !rendererMetadataSummary.isEmpty
            && !nodeInspectionSummary.isEmpty
    }

    public static func nodeInspectionReadinessSummary(isReady: Bool) -> String {
        "nodeInspectionMetadataReady:\(isReady)"
    }

    public static func fullNodeInspectionSummary(
        readinessSummary: String,
        nodeInspectionSummary: String
    ) -> String {
        "\(readinessSummary),\(nodeInspectionSummary)"
    }

    public static func hasFullNodeInspectionFields(
        readinessSummary: String,
        nodeInspectionSummary: String,
        fullNodeInspectionSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !nodeInspectionSummary.isEmpty
            && !fullNodeInspectionSummary.isEmpty
    }

    public static func fullNodeInspectionReadinessSummary(isReady: Bool) -> String {
        "fullNodeInspectionMetadataReady:\(isReady)"
    }

    public static func inspectionDebugSummary(
        readinessSummary: String,
        fullNodeInspectionSummary: String
    ) -> String {
        "\(readinessSummary),\(fullNodeInspectionSummary)"
    }

    public static func hasInspectionDebugFields(
        readinessSummary: String,
        fullNodeInspectionSummary: String,
        inspectionDebugSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !fullNodeInspectionSummary.isEmpty
            && !inspectionDebugSummary.isEmpty
    }

    public static func inspectionDebugReadinessSummary(isReady: Bool) -> String {
        "inspectionDebugMetadataReady:\(isReady)"
    }

    public static func visualInspectionSummary(
        readinessSummary: String,
        inspectionDebugSummary: String
    ) -> String {
        "\(readinessSummary),\(inspectionDebugSummary)"
    }

    public static func hasVisualInspectionFields(
        readinessSummary: String,
        inspectionDebugSummary: String,
        visualInspectionSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !inspectionDebugSummary.isEmpty
            && !visualInspectionSummary.isEmpty
    }

    public static func visualInspectionReadinessSummary(isReady: Bool) -> String {
        "visualInspectionMetadataReady:\(isReady)"
    }

    public static func qaInspectionSummary(
        readinessSummary: String,
        visualInspectionSummary: String
    ) -> String {
        "\(readinessSummary),\(visualInspectionSummary)"
    }

    public static func hasQAInspectionFields(
        readinessSummary: String,
        visualInspectionSummary: String,
        qaInspectionSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !visualInspectionSummary.isEmpty
            && !qaInspectionSummary.isEmpty
    }

    public static func qaInspectionReadinessSummary(isReady: Bool) -> String {
        "qaInspectionMetadataReady:\(isReady)"
    }

    public static func qaInspectionSnapshotSummary(
        readinessSummary: String,
        qaInspectionSummary: String
    ) -> String {
        "\(readinessSummary),\(qaInspectionSummary)"
    }

    public static func hasQAInspectionSnapshotFields(
        readinessSummary: String,
        qaInspectionSummary: String,
        qaInspectionSnapshotSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !qaInspectionSummary.isEmpty
            && !qaInspectionSnapshotSummary.isEmpty
    }

    public static func qaInspectionSnapshotReadinessSummary(isReady: Bool) -> String {
        "qaInspectionSnapshotMetadataReady:\(isReady)"
    }

    public static func widgetInspectionSnapshotSummary(
        readinessSummary: String,
        qaInspectionSnapshotSummary: String
    ) -> String {
        "\(readinessSummary),\(qaInspectionSnapshotSummary)"
    }

    public static func hasWidgetInspectionSnapshotFields(
        readinessSummary: String,
        qaInspectionSnapshotSummary: String,
        widgetInspectionSnapshotSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !qaInspectionSnapshotSummary.isEmpty
            && !widgetInspectionSnapshotSummary.isEmpty
    }

    public static func widgetInspectionSnapshotReadinessSummary(isReady: Bool) -> String {
        "widgetInspectionSnapshotMetadataReady:\(isReady)"
    }

    public static func widgetInspectionReadinessSummary(
        readinessSummary: String,
        widgetInspectionSnapshotSummary: String
    ) -> String {
        "\(readinessSummary),\(widgetInspectionSnapshotSummary)"
    }

    public static func hasWidgetInspectionFields(
        readinessSummary: String,
        widgetInspectionSnapshotSummary: String,
        widgetInspectionReadinessSummary: String
    ) -> Bool {
        !readinessSummary.isEmpty
            && !widgetInspectionSnapshotSummary.isEmpty
            && !widgetInspectionReadinessSummary.isEmpty
    }

    public static func widgetInspectionMetadataReadinessSummary(isReady: Bool) -> String {
        "widgetInspectionMetadataReady:\(isReady)"
    }

    public static func snapshotTestingDependencyProposalSummary(
        stableSurfaceCount: Int,
        surfaceIDs: [String],
        manualVisualQAPassing: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        let surfaceSummary = surfaceIDs.isEmpty ? "none" : surfaceIDs.joined(separator: "+")
        return "snapshotTestingProposal=surfaces:\(surfaceSummary),stable:\(stableSurfaceCount),manualQA:\(manualVisualQAPassing),dependencyAdded:\(dependencyAdded),appBehaviorChanged:\(appBehaviorChanged),proposalReady:\(hasSnapshotTestingDependencyProposalFields(stableSurfaceCount: stableSurfaceCount, surfaceIDs: surfaceIDs, manualVisualQAPassing: manualVisualQAPassing, dependencyAdded: dependencyAdded, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotTestingDependencyProposalFields(
        stableSurfaceCount: Int,
        surfaceIDs: [String],
        manualVisualQAPassing: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        stableSurfaceCount >= 2
            && surfaceIDs.count >= 2
            && surfaceIDs.allSatisfy { !$0.isEmpty }
            && manualVisualQAPassing
            && !dependencyAdded
            && !appBehaviorChanged
    }

    public static func snapshotTestingDependencyProposalReadinessSummary(isReady: Bool) -> String {
        "snapshotTestingProposalReady:\(isReady)"
    }

    public static func snapshotTestingVisibleSurfaceGateSummary(
        candidateSurfaceIDs: [String],
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        referenceImagesRecorded: Bool,
        appTargetHostAdded: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        let surfaceSummary = candidateSurfaceIDs.isEmpty ? "none" : candidateSurfaceIDs.joined(separator: "+")
        return "snapshotTestingVisibleSurfaceGate=surfaces:\(surfaceSummary),available:\(snapshotTestingAvailable),manualQA:\(manualVisualQAPassing),referenceImages:\(referenceImagesRecorded),appHost:\(appTargetHostAdded),appBehaviorChanged:\(appBehaviorChanged),ready:\(hasSnapshotTestingVisibleSurfaceGateFields(candidateSurfaceIDs: candidateSurfaceIDs, snapshotTestingAvailable: snapshotTestingAvailable, manualVisualQAPassing: manualVisualQAPassing, referenceImagesRecorded: referenceImagesRecorded, appTargetHostAdded: appTargetHostAdded, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotTestingVisibleSurfaceGateFields(
        candidateSurfaceIDs: [String],
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        referenceImagesRecorded: Bool,
        appTargetHostAdded: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        candidateSurfaceIDs.count >= 2
            && candidateSurfaceIDs.allSatisfy { !$0.isEmpty }
            && snapshotTestingAvailable
            && manualVisualQAPassing
            && !referenceImagesRecorded
            && !appTargetHostAdded
            && !appBehaviorChanged
    }

    public static func snapshotTestingVisibleSurfaceGateReadinessSummary(isReady: Bool) -> String {
        "snapshotTestingVisibleSurfaceGateReady:\(isReady)"
    }

    public static func snapshotHostCandidateSummary(
        surfaceID: String,
        viewTarget: String,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        stableSurface: Bool,
        referenceImageRecorded: Bool,
        appTargetHostAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        "snapshotHostCandidate=surface:\(surfaceID),view:\(viewTarget),available:\(snapshotTestingAvailable),manualQA:\(manualVisualQAPassing),stable:\(stableSurface),referenceImage:\(referenceImageRecorded),appHost:\(appTargetHostAdded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),ready:\(hasSnapshotHostCandidateFields(surfaceID: surfaceID, viewTarget: viewTarget, snapshotTestingAvailable: snapshotTestingAvailable, manualVisualQAPassing: manualVisualQAPassing, stableSurface: stableSurface, referenceImageRecorded: referenceImageRecorded, appTargetHostAdded: appTargetHostAdded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotHostCandidateFields(
        surfaceID: String,
        viewTarget: String,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        stableSurface: Bool,
        referenceImageRecorded: Bool,
        appTargetHostAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        isSnapshotHostCandidate(surfaceID: surfaceID, viewTarget: viewTarget)
            && snapshotTestingAvailable
            && manualVisualQAPassing
            && stableSurface
            && !referenceImageRecorded
            && !appTargetHostAdded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
    }

    public static func snapshotHostCandidateReadinessSummary(isReady: Bool) -> String {
        "snapshotHostCandidateReady:\(isReady)"
    }

    public static func snapshotHostEntrySummary(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        candidateReady: Bool,
        appTargetHostAdded: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        "snapshotHostEntry=surface:\(surfaceID),view:\(viewTarget),launch:\(launchArgument),candidateReady:\(candidateReady),appHost:\(appTargetHostAdded),referenceImage:\(referenceImageRecorded),snapshotAssertion:\(snapshotAssertionAdded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),ready:\(hasSnapshotHostEntryFields(surfaceID: surfaceID, viewTarget: viewTarget, launchArgument: launchArgument, candidateReady: candidateReady, appTargetHostAdded: appTargetHostAdded, referenceImageRecorded: referenceImageRecorded, snapshotAssertionAdded: snapshotAssertionAdded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotHostEntryFields(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        candidateReady: Bool,
        appTargetHostAdded: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        isSnapshotHostEntry(
            surfaceID: surfaceID,
            viewTarget: viewTarget,
            launchArgument: launchArgument
        )
            && candidateReady
            && appTargetHostAdded
            && !referenceImageRecorded
            && !snapshotAssertionAdded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
    }

    public static func snapshotHostEntryReadinessSummary(isReady: Bool) -> String {
        "snapshotHostEntryReady:\(isReady)"
    }

    public static func snapshotFirstReferenceSurfaceSelectionSummary(
        selectedSurfaceID: String,
        viewTarget: String,
        launchArgument: String,
        hostEntryReady: Bool,
        manualVisualQAPassing: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        "snapshotFirstReferenceSurface=surface:\(selectedSurfaceID),view:\(viewTarget),launch:\(launchArgument),hostReady:\(hostEntryReady),manualQA:\(manualVisualQAPassing),referenceImage:\(referenceImageRecorded),snapshotAssertion:\(snapshotAssertionAdded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),ready:\(hasSnapshotFirstReferenceSurfaceSelectionFields(selectedSurfaceID: selectedSurfaceID, viewTarget: viewTarget, launchArgument: launchArgument, hostEntryReady: hostEntryReady, manualVisualQAPassing: manualVisualQAPassing, referenceImageRecorded: referenceImageRecorded, snapshotAssertionAdded: snapshotAssertionAdded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotFirstReferenceSurfaceSelectionFields(
        selectedSurfaceID: String,
        viewTarget: String,
        launchArgument: String,
        hostEntryReady: Bool,
        manualVisualQAPassing: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        selectedSurfaceID == "observationHome"
            && viewTarget == "ObservationHomeView"
            && launchArgument == "--wipet-snapshot-host-observation-home"
            && hostEntryReady
            && manualVisualQAPassing
            && !referenceImageRecorded
            && !snapshotAssertionAdded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
    }

    public static func snapshotFirstReferenceSurfaceSelectionReadinessSummary(isReady: Bool) -> String {
        "snapshotFirstReferenceSurfaceReady:\(isReady)"
    }

    public static func snapshotAppTestTargetAdoptionGateSummary(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        firstReferenceSurfaceReady: Bool,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        appTestTargetPlanned: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> String {
        "snapshotAppTestTargetGate=surface:\(surfaceID),view:\(viewTarget),launch:\(launchArgument),firstReferenceReady:\(firstReferenceSurfaceReady),available:\(snapshotTestingAvailable),manualQA:\(manualVisualQAPassing),planned:\(appTestTargetPlanned),targetAdded:\(appTestTargetAdded),projectEdited:\(xcodeProjectEdited),referenceImage:\(referenceImageRecorded),snapshotAssertion:\(snapshotAssertionAdded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),widgetBehaviorChanged:\(widgetBehaviorChanged),ready:\(hasSnapshotAppTestTargetAdoptionGateFields(surfaceID: surfaceID, viewTarget: viewTarget, launchArgument: launchArgument, firstReferenceSurfaceReady: firstReferenceSurfaceReady, snapshotTestingAvailable: snapshotTestingAvailable, manualVisualQAPassing: manualVisualQAPassing, appTestTargetPlanned: appTestTargetPlanned, appTestTargetAdded: appTestTargetAdded, xcodeProjectEdited: xcodeProjectEdited, referenceImageRecorded: referenceImageRecorded, snapshotAssertionAdded: snapshotAssertionAdded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged, widgetBehaviorChanged: widgetBehaviorChanged))"
    }

    public static func hasSnapshotAppTestTargetAdoptionGateFields(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        firstReferenceSurfaceReady: Bool,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        appTestTargetPlanned: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        snapshotAssertionAdded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> Bool {
        surfaceID == "observationHome"
            && viewTarget == "ObservationHomeView"
            && launchArgument == "--wipet-snapshot-host-observation-home"
            && firstReferenceSurfaceReady
            && snapshotTestingAvailable
            && manualVisualQAPassing
            && appTestTargetPlanned
            && !appTestTargetAdded
            && !xcodeProjectEdited
            && !referenceImageRecorded
            && !snapshotAssertionAdded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
            && !widgetBehaviorChanged
    }

    public static func snapshotAppTestTargetAdoptionGateReadinessSummary(isReady: Bool) -> String {
        "snapshotAppTestTargetGateReady:\(isReady)"
    }

    public static func snapshotReferenceAssertionSummary(
        surfaceID: String,
        assertionKind: String,
        referenceName: String,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        referenceRecorded: Bool,
        snapshotAssertionAdded: Bool,
        imageReferenceRecorded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> String {
        "snapshotReferenceAssertion=surface:\(surfaceID),kind:\(assertionKind),reference:\(referenceName),available:\(snapshotTestingAvailable),manualQA:\(manualVisualQAPassing),referenceRecorded:\(referenceRecorded),assertion:\(snapshotAssertionAdded),imageReference:\(imageReferenceRecorded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),ready:\(hasSnapshotReferenceAssertionFields(surfaceID: surfaceID, assertionKind: assertionKind, referenceName: referenceName, snapshotTestingAvailable: snapshotTestingAvailable, manualVisualQAPassing: manualVisualQAPassing, referenceRecorded: referenceRecorded, snapshotAssertionAdded: snapshotAssertionAdded, imageReferenceRecorded: imageReferenceRecorded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged))"
    }

    public static func hasSnapshotReferenceAssertionFields(
        surfaceID: String,
        assertionKind: String,
        referenceName: String,
        snapshotTestingAvailable: Bool,
        manualVisualQAPassing: Bool,
        referenceRecorded: Bool,
        snapshotAssertionAdded: Bool,
        imageReferenceRecorded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool
    ) -> Bool {
        isSnapshotReferenceAssertion(
            surfaceID: surfaceID,
            assertionKind: assertionKind,
            referenceName: referenceName
        )
            && snapshotTestingAvailable
            && manualVisualQAPassing
            && referenceRecorded
            && snapshotAssertionAdded
            && !imageReferenceRecorded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
    }

    public static func snapshotReferenceAssertionReadinessSummary(isReady: Bool) -> String {
        "snapshotReferenceAssertionReady:\(isReady)"
    }

    public static func snapshotReferenceRegistrySummary(
        textReferences: [String],
        appHostSurfaceIDs: [String],
        imageReferenceCount: Int,
        appTargetImageSnapshotAdded: Bool,
        projectEditedForImageSnapshots: Bool,
        runtimeBehaviorChanged: Bool
    ) -> String {
        let textReferenceSummary = textReferences.isEmpty ? "none" : textReferences.joined(separator: "+")
        let appHostSummary = appHostSurfaceIDs.isEmpty ? "none" : appHostSurfaceIDs.joined(separator: "+")
        return "snapshotReferenceRegistry=text:\(textReferenceSummary),appHosts:\(appHostSummary),imageReferences:\(imageReferenceCount),appTargetImage:\(appTargetImageSnapshotAdded),projectEdited:\(projectEditedForImageSnapshots),runtimeChanged:\(runtimeBehaviorChanged),ready:\(hasSnapshotReferenceRegistryFields(textReferences: textReferences, appHostSurfaceIDs: appHostSurfaceIDs, imageReferenceCount: imageReferenceCount, appTargetImageSnapshotAdded: appTargetImageSnapshotAdded, projectEditedForImageSnapshots: projectEditedForImageSnapshots, runtimeBehaviorChanged: runtimeBehaviorChanged))"
    }

    public static func hasSnapshotReferenceRegistryFields(
        textReferences: [String],
        appHostSurfaceIDs: [String],
        imageReferenceCount: Int,
        appTargetImageSnapshotAdded: Bool,
        projectEditedForImageSnapshots: Bool,
        runtimeBehaviorChanged: Bool
    ) -> Bool {
        textReferences == [
            "observation-home-family-echo",
            "lineage-family-qa-review-stack",
            "genome-variation-silhouette-cue-set",
            "growth-ceremony-preview-contract"
        ]
            && appHostSurfaceIDs == [
                "observationHome",
                "genomeVariationQA",
                "lineageFamilyQA"
            ]
            && imageReferenceCount == 0
            && !appTargetImageSnapshotAdded
            && !projectEditedForImageSnapshots
            && !runtimeBehaviorChanged
    }

    public static func snapshotReferenceRegistryReadinessSummary(isReady: Bool) -> String {
        "snapshotReferenceRegistryReady:\(isReady)"
    }

    public static func snapshotImageCandidateSummary(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        hostEntryReady: Bool,
        manualVisualQAPassing: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> String {
        "snapshotImageCandidate=surface:\(surfaceID),view:\(viewTarget),launch:\(launchArgument),hostReady:\(hostEntryReady),manualQA:\(manualVisualQAPassing),referenceImage:\(referenceImageRecorded),imageAssertion:\(imageSnapshotAssertionAdded),appTarget:\(appTestTargetAdded),projectEdited:\(xcodeProjectEdited),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),widgetBehaviorChanged:\(widgetBehaviorChanged),ready:\(hasSnapshotImageCandidateReadinessFields(surfaceID: surfaceID, viewTarget: viewTarget, launchArgument: launchArgument, hostEntryReady: hostEntryReady, manualVisualQAPassing: manualVisualQAPassing, referenceImageRecorded: referenceImageRecorded, imageSnapshotAssertionAdded: imageSnapshotAssertionAdded, appTestTargetAdded: appTestTargetAdded, xcodeProjectEdited: xcodeProjectEdited, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged, widgetBehaviorChanged: widgetBehaviorChanged))"
    }

    public static func hasSnapshotImageCandidateReadinessFields(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String,
        hostEntryReady: Bool,
        manualVisualQAPassing: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && viewTarget == "GenomeVariationQAView"
            && launchArgument == "--wipet-snapshot-host-genome-variation"
            && hostEntryReady
            && manualVisualQAPassing
            && !referenceImageRecorded
            && !imageSnapshotAssertionAdded
            && !appTestTargetAdded
            && !xcodeProjectEdited
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
            && !widgetBehaviorChanged
    }

    public static func snapshotImageCandidateReadinessSummary(isReady: Bool) -> String {
        "snapshotImageCandidateReady:\(isReady)"
    }

    public static func snapshotAppTargetIsolationPlanSummary(
        surfaceID: String,
        plannedTargetName: String,
        existingProjectTargets: [String],
        snapshotImageCandidateReady: Bool,
        snapshotTestingPackageAvailable: Bool,
        xctestHarnessPlanned: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        rendererChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> String {
        let targets = existingProjectTargets.isEmpty ? "none" : existingProjectTargets.joined(separator: "+")
        return "snapshotAppTargetIsolationPlan=surface:\(surfaceID),target:\(plannedTargetName),existingTargets:\(targets),imageCandidateReady:\(snapshotImageCandidateReady),snapshotTesting:\(snapshotTestingPackageAvailable),xctest:\(xctestHarnessPlanned),targetAdded:\(appTestTargetAdded),projectEdited:\(xcodeProjectEdited),referenceImage:\(referenceImageRecorded),imageAssertion:\(imageSnapshotAssertionAdded),rendererChanged:\(rendererChanged),widgetChanged:\(widgetBehaviorChanged),ready:\(hasSnapshotAppTargetIsolationPlanFields(surfaceID: surfaceID, plannedTargetName: plannedTargetName, existingProjectTargets: existingProjectTargets, snapshotImageCandidateReady: snapshotImageCandidateReady, snapshotTestingPackageAvailable: snapshotTestingPackageAvailable, xctestHarnessPlanned: xctestHarnessPlanned, appTestTargetAdded: appTestTargetAdded, xcodeProjectEdited: xcodeProjectEdited, referenceImageRecorded: referenceImageRecorded, imageSnapshotAssertionAdded: imageSnapshotAssertionAdded, rendererChanged: rendererChanged, widgetBehaviorChanged: widgetBehaviorChanged))"
    }

    public static func hasSnapshotAppTargetIsolationPlanFields(
        surfaceID: String,
        plannedTargetName: String,
        existingProjectTargets: [String],
        snapshotImageCandidateReady: Bool,
        snapshotTestingPackageAvailable: Bool,
        xctestHarnessPlanned: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        rendererChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && plannedTargetName == "WiPetSnapshotTests"
            && existingProjectTargets == ["WiPet", "WiPetWidget"]
            && snapshotImageCandidateReady
            && snapshotTestingPackageAvailable
            && xctestHarnessPlanned
            && !appTestTargetAdded
            && !xcodeProjectEdited
            && !referenceImageRecorded
            && !imageSnapshotAssertionAdded
            && !rendererChanged
            && !widgetBehaviorChanged
    }

    public static func snapshotAppTargetIsolationPlanReadinessSummary(isReady: Bool) -> String {
        "snapshotAppTargetIsolationPlanReady:\(isReady)"
    }

    public static func snapshotAppTargetEntrySummary(
        surfaceID: String,
        targetName: String,
        existingProjectTargets: [String],
        snapshotImageCandidateReady: Bool,
        snapshotTestingPackageAvailable: Bool,
        xctestHarnessAdded: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        rendererChanged: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> String {
        let targets = existingProjectTargets.isEmpty ? "none" : existingProjectTargets.joined(separator: "+")
        return "snapshotAppTargetEntry=surface:\(surfaceID),target:\(targetName),existingTargets:\(targets),imageCandidateReady:\(snapshotImageCandidateReady),snapshotTesting:\(snapshotTestingPackageAvailable),xctest:\(xctestHarnessAdded),targetAdded:\(appTestTargetAdded),projectEdited:\(xcodeProjectEdited),referenceImage:\(referenceImageRecorded),imageAssertion:\(imageSnapshotAssertionAdded),rendererChanged:\(rendererChanged),appBehaviorChanged:\(appBehaviorChanged),widgetChanged:\(widgetBehaviorChanged),ready:\(hasSnapshotAppTargetEntryFields(surfaceID: surfaceID, targetName: targetName, existingProjectTargets: existingProjectTargets, snapshotImageCandidateReady: snapshotImageCandidateReady, snapshotTestingPackageAvailable: snapshotTestingPackageAvailable, xctestHarnessAdded: xctestHarnessAdded, appTestTargetAdded: appTestTargetAdded, xcodeProjectEdited: xcodeProjectEdited, referenceImageRecorded: referenceImageRecorded, imageSnapshotAssertionAdded: imageSnapshotAssertionAdded, rendererChanged: rendererChanged, appBehaviorChanged: appBehaviorChanged, widgetBehaviorChanged: widgetBehaviorChanged))"
    }

    public static func hasSnapshotAppTargetEntryFields(
        surfaceID: String,
        targetName: String,
        existingProjectTargets: [String],
        snapshotImageCandidateReady: Bool,
        snapshotTestingPackageAvailable: Bool,
        xctestHarnessAdded: Bool,
        appTestTargetAdded: Bool,
        xcodeProjectEdited: Bool,
        referenceImageRecorded: Bool,
        imageSnapshotAssertionAdded: Bool,
        rendererChanged: Bool,
        appBehaviorChanged: Bool,
        widgetBehaviorChanged: Bool
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && targetName == "WiPetSnapshotTests"
            && existingProjectTargets == ["WiPet", "WiPetWidget", "WiPetSnapshotTests"]
            && snapshotImageCandidateReady
            && snapshotTestingPackageAvailable
            && xctestHarnessAdded
            && appTestTargetAdded
            && xcodeProjectEdited
            && !referenceImageRecorded
            && !imageSnapshotAssertionAdded
            && !rendererChanged
            && !appBehaviorChanged
            && !widgetBehaviorChanged
    }

    public static func snapshotAppTargetEntryReadinessSummary(isReady: Bool) -> String {
        "snapshotAppTargetEntryReady:\(isReady)"
    }

    private static func isSnapshotHostCandidate(
        surfaceID: String,
        viewTarget: String
    ) -> Bool {
        (surfaceID == "genomeVariationQA" && viewTarget == "GenomeVariationQAView")
            || (surfaceID == "observationHome" && viewTarget == "ObservationHomeView")
            || (surfaceID == "lineageFamilyQA" && viewTarget == "LineageFamilyQAView")
    }

    private static func isSnapshotHostEntry(
        surfaceID: String,
        viewTarget: String,
        launchArgument: String
    ) -> Bool {
        (surfaceID == "genomeVariationQA"
            && viewTarget == "GenomeVariationQAView"
            && launchArgument == "--wipet-snapshot-host-genome-variation")
            || (surfaceID == "observationHome"
                && viewTarget == "ObservationHomeView"
                && launchArgument == "--wipet-snapshot-host-observation-home")
            || (surfaceID == "lineageFamilyQA"
                && viewTarget == "LineageFamilyQAView"
                && launchArgument == "--wipet-snapshot-host-lineage-family")
    }

    private static func isSnapshotReferenceAssertion(
        surfaceID: String,
        assertionKind: String,
        referenceName: String
    ) -> Bool {
        assertionKind == "textLines"
            && ((surfaceID == "observationHome"
                && referenceName == "observation-home-family-echo")
                || (surfaceID == "observationHome"
                    && referenceName == "growth-ceremony-preview-contract")
                || (surfaceID == "genomeVariationQA"
                    && referenceName == "genome-variation-silhouette-cue-set"))
    }

    public static func genomeVisualVariationSummary(
        face: String,
        body: String,
        wing: String,
        tail: String,
        visibleTraitCount: Int
    ) -> String {
        "genomeVariation=face:\(face),body:\(body),wing:\(wing),tail:\(tail),visibleTraitCount:\(visibleTraitCount)"
    }

    public static func hasGenomeVisualVariationFields(
        face: String,
        body: String,
        wing: String,
        tail: String,
        visibleTraitCount: Int,
        summary: String
    ) -> Bool {
        !face.isEmpty
            && !body.isEmpty
            && !wing.isEmpty
            && !tail.isEmpty
            && visibleTraitCount > 0
            && !summary.isEmpty
    }

    public static func genomeVisualVariationReadinessSummary(isReady: Bool) -> String {
        "genomeVisualVariationMetadataReady:\(isReady)"
    }

    public static func personalityEyeCueSummary(
        openness: String,
        softness: String,
        sparkle: String
    ) -> String {
        "personalityEyeCue=openness:\(openness),softness:\(softness),sparkle:\(sparkle)"
    }

    public static func hasPersonalityEyeCueFields(
        openness: String,
        softness: String,
        sparkle: String,
        summary: String
    ) -> Bool {
        !openness.isEmpty
            && !softness.isEmpty
            && !sparkle.isEmpty
            && !summary.isEmpty
    }

    public static func personalityEyeCueReadinessSummary(isReady: Bool) -> String {
        "personalityEyeCueMetadataReady:\(isReady)"
    }

    public static func personalityEyeGazeCueSummary(
        gaze: String,
        assetOutputs: String
    ) -> String {
        "personalityEyeGazeCue=gaze:\(gaze),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityEyeGazeCueFields(
        gaze: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !gaze.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityEyeGazeCueReadinessSummary(isReady: Bool) -> String {
        "personalityEyeGazeCueReady:\(isReady)"
    }

    public static func personalityBlinkCueSummary(
        style: String,
        depth: String,
        hold: String,
        assetOutputs: String
    ) -> String {
        "personalityBlinkCue=style:\(style),depth:\(depth),hold:\(hold),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityBlinkCueFields(
        style: String,
        depth: String,
        hold: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !style.isEmpty
            && !depth.isEmpty
            && !hold.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityBlinkCueReadinessSummary(isReady: Bool) -> String {
        "personalityBlinkCueReady:\(isReady)"
    }

    public static func personalitySleepinessIdleCueSummary(
        style: String,
        breath: String,
        pace: String,
        assetOutputs: String
    ) -> String {
        "personalitySleepinessIdleCue=style:\(style),breath:\(breath),pace:\(pace),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalitySleepinessIdleCueFields(
        style: String,
        breath: String,
        pace: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !style.isEmpty
            && !breath.isEmpty
            && !pace.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalitySleepinessIdleCueReadinessSummary(isReady: Bool) -> String {
        "personalitySleepinessIdleCueReady:\(isReady)"
    }

    public static func personalityEyeDetailSummary(
        catchlightStyle: String,
        catchlightPlacement: String,
        assetOutputs: String
    ) -> String {
        "personalityEyeDetail=catchlight:\(catchlightStyle),placement:\(catchlightPlacement),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityEyeDetailFields(
        catchlightStyle: String,
        catchlightPlacement: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !catchlightStyle.isEmpty
            && !catchlightPlacement.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func personalityEyeDetailReadinessSummary(isReady: Bool) -> String {
        "personalityEyeDetailReady:\(isReady)"
    }

    public static func personalityCheekWarmthCueSummary(
        warmth: String,
        placement: String,
        assetOutputs: String
    ) -> String {
        "personalityCheekWarmthCue=warmth:\(warmth),placement:\(placement),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityCheekWarmthCueFields(
        warmth: String,
        placement: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !warmth.isEmpty
            && !placement.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityCheekWarmthCueReadinessSummary(isReady: Bool) -> String {
        "personalityCheekWarmthCueReady:\(isReady)"
    }

    public static func personalityMouthCueSummary(
        style: String,
        energy: String,
        width: String,
        assetOutputs: String
    ) -> String {
        "personalityMouthCue=style:\(style),energy:\(energy),width:\(width),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityMouthCueFields(
        style: String,
        energy: String,
        width: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !style.isEmpty
            && !energy.isEmpty
            && !width.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityMouthCueReadinessSummary(isReady: Bool) -> String {
        "personalityMouthCueReady:\(isReady)"
    }

    public static func personalityPostureCueSummary(
        attention: String,
        timidity: String,
        lean: String,
        assetOutputs: String
    ) -> String {
        "personalityPostureCue=attention:\(attention),timidity:\(timidity),lean:\(lean),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityPostureCueFields(
        attention: String,
        timidity: String,
        lean: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !attention.isEmpty
            && !timidity.isEmpty
            && !lean.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityPostureCueReadinessSummary(isReady: Bool) -> String {
        "personalityPostureCueReady:\(isReady)"
    }

    public static func spriteKitGlowAuraCueSummary(
        glow: String,
        aura: String,
        pulse: String,
        motes: String,
        assetOutputs: String
    ) -> String {
        "spriteKitGlowAuraCue=glow:\(glow),aura:\(aura),pulse:\(pulse),motes:\(motes),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitGlowAuraCueFields(
        glow: String,
        aura: String,
        pulse: String,
        motes: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !glow.isEmpty
            && !aura.isEmpty
            && !pulse.isEmpty
            && !motes.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func spriteKitGlowAuraCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitGlowAuraCueReady:\(isReady)"
    }

    public static func personalityMysticismAuraCueSummary(
        mysticism: String,
        halo: String,
        assetOutputs: String
    ) -> String {
        "personalityMysticismAuraCue=mysticism:\(mysticism),halo:\(halo),assetOutputs:\(assetOutputs)"
    }

    public static func hasPersonalityMysticismAuraCueFields(
        mysticism: String,
        halo: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mysticism.isEmpty
            && !halo.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func personalityMysticismAuraCueReadinessSummary(isReady: Bool) -> String {
        "personalityMysticismAuraCueReady:\(isReady)"
    }

    public static func spriteKitPatternMarkingCueSummary(
        gene: String,
        mark: String,
        placement: String,
        spread: String,
        assetOutputs: String
    ) -> String {
        "spriteKitPatternMarkingCue=gene:\(gene),mark:\(mark),placement:\(placement),spread:\(spread),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitPatternMarkingCueFields(
        gene: String,
        mark: String,
        placement: String,
        spread: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !gene.isEmpty
            && !mark.isEmpty
            && !placement.isEmpty
            && !spread.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitPatternMarkingCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitPatternMarkingCueReady:\(isReady)"
    }

    public static func coreImagePatternGenerationPreflightSummary(
        surface: String,
        candidate: String,
        generatedInputs: [String],
        handmadeVocabularyAccepted: Bool,
        snapshotBaselineAccepted: Bool,
        preservesHandmadeSilhouette: Bool,
        externalDependencyRequired: Bool,
        packageEdited: Bool,
        projectEdited: Bool,
        rendererChanged: Bool,
        assetOutputs: String
    ) -> String {
        let inputs = generatedInputs.isEmpty ? "none" : generatedInputs.joined(separator: "+")
        return "coreImagePatternGenerationPreflight=surface:\(surface),candidate:\(candidate),inputs:\(inputs),handmadeVocabulary:\(handmadeVocabularyAccepted),snapshotBaseline:\(snapshotBaselineAccepted),preservesSilhouette:\(preservesHandmadeSilhouette),externalDependency:\(externalDependencyRequired),packageEdited:\(packageEdited),projectEdited:\(projectEdited),rendererChanged:\(rendererChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasCoreImagePatternGenerationPreflightFields(
        surface: String,
        candidate: String,
        generatedInputs: [String],
        handmadeVocabularyAccepted: Bool,
        snapshotBaselineAccepted: Bool,
        preservesHandmadeSilhouette: Bool,
        externalDependencyRequired: Bool,
        packageEdited: Bool,
        projectEdited: Bool,
        rendererChanged: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !surface.isEmpty
            && candidate == "CoreImage"
            && !generatedInputs.isEmpty
            && handmadeVocabularyAccepted
            && snapshotBaselineAccepted
            && preservesHandmadeSilhouette
            && !externalDependencyRequired
            && !packageEdited
            && !projectEdited
            && !rendererChanged
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func coreImagePatternGenerationPreflightReadinessSummary(isReady: Bool) -> String {
        "coreImagePatternGenerationPreflightReady:\(isReady)"
    }

    public static func spriteKitAncestralGlintCueSummary(
        cue: String,
        placement: String,
        glintCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitAncestralGlintCue=cue:\(cue),placement:\(placement),glints:\(glintCount),ancestryLinked:\(ancestryLinked),active:\(active),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitAncestralGlintCueFields(
        cue: String,
        placement: String,
        glintCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveCue = active
            && ancestryLinked
            && cue != "none"
            && placement != "none"
            && glintCount >= 1
        let readyInactiveCue = !active
            && !ancestryLinked
            && cue == "none"
            && placement == "none"
            && glintCount == 0

        return !cue.isEmpty
            && !placement.isEmpty
            && glintCount >= 0
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveCue || readyInactiveCue)
    }

    public static func spriteKitAncestralGlintCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitAncestralGlintCueReady:\(isReady)"
    }

    public static func spriteKitFaceLineageEchoCueSummary(
        cue: String,
        face: String,
        placement: String,
        dotCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitFaceLineageEchoCue=cue:\(cue),face:\(face),placement:\(placement),dots:\(dotCount),ancestryLinked:\(ancestryLinked),active:\(active),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitFaceLineageEchoCueFields(
        cue: String,
        face: String,
        placement: String,
        dotCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveCue = active
            && ancestryLinked
            && cue != "none"
            && face != "none"
            && placement != "none"
            && dotCount >= 1
        let readyInactiveCue = !active
            && !ancestryLinked
            && cue == "none"
            && face == "none"
            && placement == "none"
            && dotCount == 0

        return !cue.isEmpty
            && !face.isEmpty
            && !placement.isEmpty
            && dotCount >= 0
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveCue || readyInactiveCue)
    }

    public static func spriteKitFaceLineageEchoCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitFaceLineageEchoCueReady:\(isReady)"
    }

    public static func spriteKitTailLineageEchoCueSummary(
        cue: String,
        tail: String,
        placement: String,
        dotCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitTailLineageEchoCue=cue:\(cue),tail:\(tail),placement:\(placement),dots:\(dotCount),ancestryLinked:\(ancestryLinked),active:\(active),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitTailLineageEchoCueFields(
        cue: String,
        tail: String,
        placement: String,
        dotCount: Int,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveCue = active
            && ancestryLinked
            && cue != "none"
            && tail != "none"
            && placement != "none"
            && (2 ... 4).contains(dotCount)
        let readyInactiveCue = !active
            && !ancestryLinked
            && cue == "none"
            && tail == "none"
            && placement == "none"
            && dotCount == 0

        return !cue.isEmpty
            && !tail.isEmpty
            && !placement.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveCue || readyInactiveCue)
    }

    public static func spriteKitTailLineageEchoCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitTailLineageEchoCueReady:\(isReady)"
    }

    public static func spriteKitWingSilhouetteAccessoryCueSummary(
        wing: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitWingSilhouetteAccessory=wing:\(wing),accessory:\(accessory),visible:\(visibleInPortrait),geometryGenerated:\(geometryGenerated),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitWingSilhouetteAccessoryCueFields(
        wing: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let expectedAccessory = switch wing {
        case "leafPair":
            "softWingTipPearl"
        case "wideSail":
            "softWingTipClaw"
        default:
            "none"
        }

        return !wing.isEmpty
            && accessory == expectedAccessory
            && visibleInPortrait
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitWingSilhouetteAccessoryCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitWingSilhouetteAccessoryReady:\(isReady)"
    }

    public static func spriteKitWingLineageEchoCueSummary(
        cue: String,
        wing: String,
        accessory: String,
        placement: String,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitWingLineageEchoCue=cue:\(cue),wing:\(wing),accessory:\(accessory),placement:\(placement),ancestryLinked:\(ancestryLinked),active:\(active),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitWingLineageEchoCueFields(
        cue: String,
        wing: String,
        accessory: String,
        placement: String,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveCue = active
            && ancestryLinked
            && cue != "none"
            && wing != "none"
            && accessory != "none"
            && placement == "wingTips"
        let readyInactiveCue = !active
            && !ancestryLinked
            && cue == "none"
            && wing == "none"
            && accessory == "none"
            && placement == "none"

        return !cue.isEmpty
            && !wing.isEmpty
            && !accessory.isEmpty
            && !placement.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveCue || readyInactiveCue)
    }

    public static func spriteKitWingLineageEchoCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitWingLineageEchoCueReady:\(isReady)"
    }

    public static func spriteKitTailSilhouetteAccessoryCueSummary(
        tail: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitTailSilhouetteAccessory=tail:\(tail),accessory:\(accessory),visible:\(visibleInPortrait),geometryGenerated:\(geometryGenerated),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitTailSilhouetteAccessoryCueFields(
        tail: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let expectedAccessory = switch tail {
        case "fishFin":
            "softForkFin"
        case "floatingRibbon":
            "softTetherDot"
        case "longDrake":
            "softDrakeRidge"
        case "leafSprout":
            "softLeafVein"
        default:
            "none"
        }

        return !tail.isEmpty
            && accessory == expectedAccessory
            && visibleInPortrait
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitTailSilhouetteAccessoryCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitTailSilhouetteAccessoryReady:\(isReady)"
    }

    public static func spriteKitFishTailRecipeIntentSummary(
        baseRecipe: String,
        accessoryRecipe: String,
        placement: String,
        silhouetteIntent: String,
        affectionIntent: String,
        allowsSharpFin: Bool,
        labelOnly: Bool,
        geometryChanged: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitFishTailRecipeIntent=base:\(baseRecipe),accessory:\(accessoryRecipe),placement:\(placement),silhouette:\(silhouetteIntent),affection:\(affectionIntent),sharpFin:\(allowsSharpFin),labelOnly:\(labelOnly),geometryChanged:\(geometryChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitFishTailRecipeIntentFields(
        baseRecipe: String,
        accessoryRecipe: String,
        placement: String,
        silhouetteIntent: String,
        affectionIntent: String,
        allowsSharpFin: Bool,
        labelOnly: Bool,
        geometryChanged: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        baseRecipe == "fishTaper"
            && accessoryRecipe == "softForkFin"
            && placement == "tailTip"
            && silhouetteIntent == "secondarySilhouette"
            && affectionIntent == "cuteMotionRoom"
            && !allowsSharpFin
            && !labelOnly
            && !geometryChanged
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitFishTailRecipeIntentReadinessSummary(isReady: Bool) -> String {
        "spriteKitFishTailRecipeIntentReady:\(isReady)"
    }

    public static func spriteKitLineageVisualEchoPairSummary(
        bodyCue: String,
        tailCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        assetOutputs: String
    ) -> String {
        "spriteKitLineageVisualEchoPair=body:\(bodyCue),tail:\(tailCue),ancestryLinked:\(ancestryLinked),activeCueCount:\(activeCueCount),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitLineageVisualEchoPairFields(
        bodyCue: String,
        tailCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActivePair = ancestryLinked
            && bodyCue != "none"
            && tailCue != "none"
            && activeCueCount >= 2
        let readyInactivePair = !ancestryLinked
            && bodyCue == "none"
            && tailCue == "none"
            && activeCueCount == 0

        return !bodyCue.isEmpty
            && !tailCue.isEmpty
            && activeCueCount >= 0
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActivePair || readyInactivePair)
    }

    public static func spriteKitLineageVisualEchoPairReadinessSummary(isReady: Bool) -> String {
        "spriteKitLineageVisualEchoPairReady:\(isReady)"
    }

    public static func spriteKitLineageMemoryThreadSummary(
        cue: String,
        bodyCue: String,
        tailCue: String,
        placement: String,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitLineageMemoryThread=cue:\(cue),body:\(bodyCue),tail:\(tailCue),placement:\(placement),ancestryLinked:\(ancestryLinked),active:\(active),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitLineageMemoryThreadFields(
        cue: String,
        bodyCue: String,
        tailCue: String,
        placement: String,
        ancestryLinked: Bool,
        active: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveThread = active
            && ancestryLinked
            && cue != "none"
            && bodyCue != "none"
            && tailCue != "none"
            && placement != "none"
        let readyInactiveThread = !active
            && !ancestryLinked
            && cue == "none"
            && bodyCue == "none"
            && tailCue == "none"
            && placement == "none"

        return !cue.isEmpty
            && !bodyCue.isEmpty
            && !tailCue.isEmpty
            && !placement.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveThread || readyInactiveThread)
    }

    public static func spriteKitLineageMemoryThreadReadinessSummary(isReady: Bool) -> String {
        "spriteKitLineageMemoryThreadReady:\(isReady)"
    }

    public static func spriteKitLineageCueSetSummary(
        surface: String,
        bodyCue: String,
        tailCue: String,
        threadCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        visibleInObservation: Bool,
        controlsEnabled: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitLineageCueSet=surface:\(surface),body:\(bodyCue),tail:\(tailCue),thread:\(threadCue),ancestryLinked:\(ancestryLinked),activeCueCount:\(activeCueCount),visibleInObservation:\(visibleInObservation),controls:\(controlsEnabled),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitLineageCueSetFields(
        surface: String,
        bodyCue: String,
        tailCue: String,
        threadCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        visibleInObservation: Bool,
        controlsEnabled: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let readyActiveSet = ancestryLinked
            && visibleInObservation
            && bodyCue != "none"
            && tailCue != "none"
            && threadCue != "none"
            && activeCueCount >= 3
        let readyInactiveSet = !ancestryLinked
            && !visibleInObservation
            && bodyCue == "none"
            && tailCue == "none"
            && threadCue == "none"
            && activeCueCount == 0

        return !surface.isEmpty
            && !bodyCue.isEmpty
            && !tailCue.isEmpty
            && !threadCue.isEmpty
            && activeCueCount >= 0
            && !controlsEnabled
            && assetOutputs == "none"
            && !summary.isEmpty
            && (readyActiveSet || readyInactiveSet)
    }

    public static func spriteKitLineageCueSetReadinessSummary(isReady: Bool) -> String {
        "spriteKitLineageCueSetReady:\(isReady)"
    }

    public static func spriteKitChildDraftLineageCueSetSummary(
        surface: String,
        source: String,
        faceCue: String,
        faceAccent: String,
        wingCue: String,
        wingAccessory: String,
        bodyCue: String,
        tailCue: String,
        threadCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        visibleInDraftPortrait: Bool,
        allowsPersistenceWrite: Bool,
        allowsBreedingControls: Bool,
        controlsEnabled: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitChildDraftLineageCueSet=surface:\(surface),source:\(source),face:\(faceCue),faceAccent:\(faceAccent),wing:\(wingCue),wingAccessory:\(wingAccessory),body:\(bodyCue),tail:\(tailCue),thread:\(threadCue),ancestryLinked:\(ancestryLinked),activeCueCount:\(activeCueCount),visibleInDraftPortrait:\(visibleInDraftPortrait),persistence:\(allowsPersistenceWrite),breeding:\(allowsBreedingControls),controls:\(controlsEnabled),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitChildDraftLineageCueSetFields(
        surface: String,
        source: String,
        faceCue: String,
        faceAccent: String,
        wingCue: String,
        wingAccessory: String,
        bodyCue: String,
        tailCue: String,
        threadCue: String,
        ancestryLinked: Bool,
        activeCueCount: Int,
        visibleInDraftPortrait: Bool,
        allowsPersistenceWrite: Bool,
        allowsBreedingControls: Bool,
        controlsEnabled: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        surface == "genomeVariationChildDraft"
            && source == "genomeVariationQA"
            && faceCue == "softDeer"
            && faceAccent == "forestDots"
            && wingCue == "leafPair"
            && wingAccessory == "softWingTipPearl"
            && bodyCue == "softAncestralGlint"
            && tailCue == "softTailMemoryDots"
            && threadCue == "softLineageMemoryThread"
            && ancestryLinked
            && activeCueCount >= 5
            && visibleInDraftPortrait
            && !allowsPersistenceWrite
            && !allowsBreedingControls
            && !controlsEnabled
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitChildDraftLineageCueSetReadinessSummary(isReady: Bool) -> String {
        "spriteKitChildDraftLineageCueSetReady:\(isReady)"
    }

    public static func spriteKitGrowthStageCueSummary(
        stage: String,
        scale: String,
        posture: String,
        assetOutputs: String
    ) -> String {
        "spriteKitGrowthStageCue=stage:\(stage),scale:\(scale),posture:\(posture),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitGrowthStageCueFields(
        stage: String,
        scale: String,
        posture: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !stage.isEmpty
            && !scale.isEmpty
            && !posture.isEmpty
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitGrowthStageCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitGrowthStageCueReady:\(isReady)"
    }

    public static func spriteKitGrowthHornBudCueSummary(
        gene: String,
        bud: String,
        stage: String,
        softness: String,
        visibleInPortrait: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitGrowthHornBudCue=gene:\(gene),bud:\(bud),stage:\(stage),softness:\(softness),visible:\(visibleInPortrait),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitGrowthHornBudCueFields(
        gene: String,
        bud: String,
        stage: String,
        softness: String,
        visibleInPortrait: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let supportedBud = ["dormantBud", "tinyRoundedBud", "softCrescentBud"].contains(bud)
        let visibilityMatchesBud = bud == "dormantBud" ? !visibleInPortrait : visibleInPortrait

        return gene == "hornGrowth"
            && supportedBud
            && !stage.isEmpty
            && softness == "rounded"
            && visibilityMatchesBud
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitGrowthHornBudCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitGrowthHornBudCueReady:\(isReady)"
    }

    public static func spriteKitGrowthTailTipCueSummary(
        gene: String,
        cue: String,
        tail: String,
        placement: String,
        visibleInPortrait: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitGrowthTailTipCue=gene:\(gene),cue:\(cue),tail:\(tail),placement:\(placement),visible:\(visibleInPortrait),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitGrowthTailTipCueFields(
        gene: String,
        cue: String,
        tail: String,
        placement: String,
        visibleInPortrait: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        gene == "tailGrowth"
            && !cue.isEmpty
            && !tail.isEmpty
            && !placement.isEmpty
            && (visibleInPortrait || cue == "restingTailTip")
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitGrowthTailTipCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitGrowthTailTipCueReady:\(isReady)"
    }

    public static func growthHornBudCeremonyPreviewSummary(
        currentBud: String,
        nextBud: String,
        visibleInCeremony: Bool,
        allowsMutation: Bool,
        widgetHandoffAllowed: Bool,
        appendsDiscovery: Bool,
        assetOutputs: String
    ) -> String {
        "growthHornBudCeremonyPreview=current:\(currentBud),next:\(nextBud),visible:\(visibleInCeremony),allowsMutation:\(allowsMutation),widgetHandoffAllowed:\(widgetHandoffAllowed),discoveryAppend:\(appendsDiscovery),assetOutputs:\(assetOutputs)"
    }

    public static func hasGrowthHornBudCeremonyPreviewFields(
        currentBud: String,
        nextBud: String,
        visibleInCeremony: Bool,
        allowsMutation: Bool,
        widgetHandoffAllowed: Bool,
        appendsDiscovery: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !currentBud.isEmpty
            && !nextBud.isEmpty
            && !visibleInCeremony
            && !allowsMutation
            && !widgetHandoffAllowed
            && !appendsDiscovery
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func growthHornBudCeremonyPreviewReadinessSummary(isReady: Bool) -> String {
        "growthHornBudCeremonyPreviewReady:\(isReady)"
    }

    public static func fixedPartHornBaseSocketSpecSummary(
        variants: [String],
        socketIDs: [String],
        rigTargets: [String],
        silhouetteRule: String,
        visibleInPortrait: Bool,
        generatedGeometry: Bool,
        assetOutputs: String
    ) -> String {
        let variantSummary = variants.isEmpty ? "none" : variants.joined(separator: "+")
        let socketSummary = socketIDs.isEmpty ? "none" : socketIDs.joined(separator: "+")
        let rigSummary = rigTargets.isEmpty ? "none" : rigTargets.joined(separator: "+")
        return "fixedPartHornBaseSocketSpec=variants:\(variantSummary),sockets:\(socketSummary),rig:\(rigSummary),silhouette:\(silhouetteRule),visible:\(visibleInPortrait),geometryGenerated:\(generatedGeometry),assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartHornBaseSocketSpecFields(
        variants: [String],
        socketIDs: [String],
        rigTargets: [String],
        silhouetteRule: String,
        visibleInPortrait: Bool,
        generatedGeometry: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        Set(variants).isSuperset(of: ["dormantBud", "tinyRoundedBud", "softCrescentBud"])
            && Set(socketIDs).isSuperset(of: ["headTopCenter", "headTopPair"])
            && Set(rigTargets).isSuperset(of: ["horn_L", "horn_R"])
            && silhouetteRule == "roundedNonSharp"
            && !visibleInPortrait
            && !generatedGeometry
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartHornBaseSocketSpecReadinessSummary(isReady: Bool) -> String {
        "fixedPartHornBaseSocketSpecReady:\(isReady)"
    }

    public static func fixedPartHornBaseReferenceEvidenceHandoffSummary(
        sourceCue: String,
        requiredPanels: [String],
        socketIDs: [String],
        rigTargets: [String],
        silhouetteRule: String,
        manualVisualQAAccepted: Bool,
        evidenceRecorded: Bool,
        generatedGeometry: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        let panels = requiredPanels.isEmpty ? "none" : requiredPanels.joined(separator: "+")
        let sockets = socketIDs.isEmpty ? "none" : socketIDs.joined(separator: "+")
        let rig = rigTargets.isEmpty ? "none" : rigTargets.joined(separator: "+")
        return "fixedPartHornBaseReferenceEvidenceHandoff=v1;cue:\(sourceCue);panels:\(panels);sockets:\(sockets);rig:\(rig);silhouette:\(silhouetteRule);manualQA:\(manualVisualQAAccepted);evidenceRecorded:\(evidenceRecorded);geometryGenerated:\(generatedGeometry);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartHornBaseReferenceEvidenceHandoffFields(
        sourceCue: String,
        requiredPanels: [String],
        socketIDs: [String],
        rigTargets: [String],
        silhouetteRule: String,
        manualVisualQAAccepted: Bool,
        evidenceRecorded: Bool,
        generatedGeometry: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let requiredPanelSet = Set(requiredPanels)

        return sourceCue == "tinyRoundedHornBud"
            && requiredPanelSet.isSuperset(of: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram"])
            && Set(socketIDs).isSuperset(of: ["headTopCenter", "headTopPair"])
            && Set(rigTargets).isSuperset(of: ["horn_L", "horn_R"])
            && silhouetteRule == "roundedNonSharp"
            && manualVisualQAAccepted
            && !evidenceRecorded
            && !generatedGeometry
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartHornBaseReferenceEvidenceHandoffReady:\(isReady)"
    }

    public static func growthBeforeAfterPortraitSurfaceSummary(
        currentStage: String,
        nextStage: String,
        currentCue: String,
        nextCue: String,
        allowsMutation: Bool,
        widgetHandoffAllowed: Bool,
        assetOutputs: String
    ) -> String {
        "growthBeforeAfterPortraitSurface=current:\(currentStage),next:\(nextStage),currentCue:\(currentCue),nextCue:\(nextCue),allowsMutation:\(allowsMutation),widgetHandoffAllowed:\(widgetHandoffAllowed),assetOutputs:\(assetOutputs)"
    }

    public static func hasGrowthBeforeAfterPortraitSurfaceFields(
        currentStage: String,
        nextStage: String,
        currentCue: String,
        nextCue: String,
        allowsMutation: Bool,
        widgetHandoffAllowed: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !currentStage.isEmpty
            && !nextStage.isEmpty
            && !currentCue.isEmpty
            && !nextCue.isEmpty
            && !allowsMutation
            && !widgetHandoffAllowed
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func growthBeforeAfterPortraitSurfaceReadinessSummary(isReady: Bool) -> String {
        "growthBeforeAfterPortraitSurfaceReady:\(isReady)"
    }

    public static func growthBeforeAfterStageCuePairSummary(
        currentStage: String,
        currentScale: String,
        currentPosture: String,
        nextStage: String,
        nextScale: String,
        nextPosture: String,
        previewOnly: Bool,
        allowsMutation: Bool,
        assetOutputs: String
    ) -> String {
        "growthBeforeAfterStageCuePair=current:\(currentStage)+\(currentScale)+\(currentPosture),next:\(nextStage)+\(nextScale)+\(nextPosture),previewOnly:\(previewOnly),mutation:\(allowsMutation),assetOutputs:\(assetOutputs)"
    }

    public static func hasGrowthBeforeAfterStageCuePairFields(
        currentStage: String,
        currentScale: String,
        currentPosture: String,
        nextStage: String,
        nextScale: String,
        nextPosture: String,
        previewOnly: Bool,
        allowsMutation: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !currentStage.isEmpty
            && !currentScale.isEmpty
            && !currentPosture.isEmpty
            && !nextStage.isEmpty
            && !nextScale.isEmpty
            && !nextPosture.isEmpty
            && previewOnly
            && !allowsMutation
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func growthBeforeAfterStageCuePairReadinessSummary(isReady: Bool) -> String {
        "growthBeforeAfterStageCuePairReady:\(isReady)"
    }

    public static func spriteKitMotionGeneCueSummary(
        float: String,
        blink: String,
        tail: String,
        wing: String,
        wingFlutter: String,
        assetOutputs: String
    ) -> String {
        "spriteKitMotionGeneCue=float:\(float),blink:\(blink),tail:\(tail),wing:\(wing),wingFlutter:\(wingFlutter),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitMotionGeneCueFields(
        float: String,
        blink: String,
        tail: String,
        wing: String,
        wingFlutter: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !float.isEmpty
            && !blink.isEmpty
            && !tail.isEmpty
            && !wing.isEmpty
            && !wingFlutter.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func spriteKitMotionGeneCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitMotionGeneCueReady:\(isReady)"
    }

    public static func spriteKitSilhouetteCueSummary(
        face: String,
        body: String,
        wing: String,
        tail: String,
        visibleCueCount: Int
    ) -> String {
        "spriteKitSilhouetteCue=face:\(face),body:\(body),wing:\(wing),tail:\(tail),visibleCueCount:\(visibleCueCount)"
    }

    public static func hasSpriteKitSilhouetteCueFields(
        face: String,
        body: String,
        wing: String,
        tail: String,
        visibleCueCount: Int,
        summary: String
    ) -> Bool {
        !face.isEmpty
            && !body.isEmpty
            && !wing.isEmpty
            && !tail.isEmpty
            && visibleCueCount > 0
            && !summary.isEmpty
    }

    public static func spriteKitSilhouetteCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitSilhouetteCueMetadataReady:\(isReady)"
    }

    public static func spriteKitWingCueAccentSummary(
        wing: String,
        accent: String,
        socketChanged: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitWingCueAccent=wing:\(wing),accent:\(accent),socketChanged:\(socketChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitWingCueAccentFields(
        wing: String,
        accent: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !wing.isEmpty
            && !accent.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func spriteKitWingCueAccentReadinessSummary(isReady: Bool) -> String {
        "spriteKitWingCueAccentReady:\(isReady)"
    }

    public static func spriteKitBodyCueAccentSummary(
        body: String,
        accent: String,
        socketChanged: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitBodyCueAccent=body:\(body),accent:\(accent),socketChanged:\(socketChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitBodyCueAccentFields(
        body: String,
        accent: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !body.isEmpty
            && !accent.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func spriteKitBodyCueAccentReadinessSummary(isReady: Bool) -> String {
        "spriteKitBodyCueAccentReady:\(isReady)"
    }

    public static func spriteKitBodyProportionCueSummary(
        body: String,
        width: String,
        height: String,
        affection: String,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitBodyProportionCue=body:\(body),width:\(width),height:\(height),affection:\(affection),geometryGenerated:\(geometryGenerated),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitBodyProportionCueFields(
        body: String,
        width: String,
        height: String,
        affection: String,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !body.isEmpty
            && !width.isEmpty
            && !height.isEmpty
            && !affection.isEmpty
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitBodyProportionCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitBodyProportionCueReady:\(isReady)"
    }

    public static func spriteKitBodySilhouetteAccessoryCueSummary(
        body: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitBodySilhouetteAccessory=body:\(body),accessory:\(accessory),visible:\(visibleInPortrait),geometryGenerated:\(geometryGenerated),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitBodySilhouetteAccessoryCueFields(
        body: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let expectedAccessory = switch body {
        case "seedPetal":
            "softShoulderPetals"
        case "moonOval":
            "softMoonShoulderCrescents"
        case "leafBelly":
            "leafShoulderNubs"
        default:
            "none"
        }

        return !body.isEmpty
            && accessory == expectedAccessory
            && visibleInPortrait
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitBodySilhouetteAccessoryCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitBodySilhouetteAccessoryReady:\(isReady)"
    }

    public static func spriteKitFaceCueAccentSummary(
        face: String,
        accent: String,
        dotCount: Int,
        socketChanged: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitFaceCueAccent=face:\(face),accent:\(accent),dots:\(dotCount),socketChanged:\(socketChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitFaceCueAccentFields(
        face: String,
        accent: String,
        dotCount: Int,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !face.isEmpty
            && !accent.isEmpty
            && dotCount >= 0
            && dotCount <= 5
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func spriteKitFaceCueAccentReadinessSummary(isReady: Bool) -> String {
        "spriteKitFaceCueAccentReady:\(isReady)"
    }

    public static func spriteKitFaceSilhouetteAccessoryCueSummary(
        face: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "spriteKitFaceSilhouetteAccessory=face:\(face),accessory:\(accessory),visible:\(visibleInPortrait),geometryGenerated:\(geometryGenerated),assetOutputs:\(assetOutputs)"
    }

    public static func hasSpriteKitFaceSilhouetteAccessoryCueFields(
        face: String,
        accessory: String,
        visibleInPortrait: Bool,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let expectedAccessory = switch face {
        case "softDeer":
            "softEarNubs"
        case "softFeline":
            "softEarTips"
        default:
            "none"
        }

        return !face.isEmpty
            && accessory == expectedAccessory
            && visibleInPortrait
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func spriteKitFaceSilhouetteAccessoryCueReadinessSummary(isReady: Bool) -> String {
        "spriteKitFaceSilhouetteAccessoryReady:\(isReady)"
    }

    public static func genomeVariationSilhouetteCueSetAcceptanceSummary(
        surfaceID: String,
        faceReadiness: String,
        bodyReadiness: String,
        wingReadiness: String,
        tailReadiness: String,
        manualVisualQAPassing: Bool,
        snapshotReferenceRecorded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> String {
        "genomeVariationSilhouetteCueSetAcceptance=surface:\(surfaceID),face:\(faceReadiness),body:\(bodyReadiness),wing:\(wingReadiness),tail:\(tailReadiness),manualQA:\(manualVisualQAPassing),snapshotReference:\(snapshotReferenceRecorded),technicalMetadata:\(visibleTechnicalMetadata),appBehaviorChanged:\(appBehaviorChanged),assetOutputs:\(assetOutputs),ready:\(hasGenomeVariationSilhouetteCueSetAcceptanceFields(surfaceID: surfaceID, faceReadiness: faceReadiness, bodyReadiness: bodyReadiness, wingReadiness: wingReadiness, tailReadiness: tailReadiness, manualVisualQAPassing: manualVisualQAPassing, snapshotReferenceRecorded: snapshotReferenceRecorded, visibleTechnicalMetadata: visibleTechnicalMetadata, appBehaviorChanged: appBehaviorChanged, assetOutputs: assetOutputs))"
    }

    public static func hasGenomeVariationSilhouetteCueSetAcceptanceFields(
        surfaceID: String,
        faceReadiness: String,
        bodyReadiness: String,
        wingReadiness: String,
        tailReadiness: String,
        manualVisualQAPassing: Bool,
        snapshotReferenceRecorded: Bool,
        visibleTechnicalMetadata: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && faceReadiness == "spriteKitFaceSilhouetteAccessoryReady:true"
            && bodyReadiness == "spriteKitBodySilhouetteAccessoryReady:true"
            && wingReadiness == "spriteKitWingSilhouetteAccessoryReady:true"
            && tailReadiness == "spriteKitTailSilhouetteAccessoryReady:true"
            && manualVisualQAPassing
            && !snapshotReferenceRecorded
            && !visibleTechnicalMetadata
            && !appBehaviorChanged
            && assetOutputs == "none"
    }

    public static func genomeVariationSilhouetteCueSetAcceptanceReadinessSummary(isReady: Bool) -> String {
        "genomeVariationSilhouetteCueSetAcceptanceReady:\(isReady)"
    }

    public static func genomeVariationVisibleCueRestraintSummary(
        surfaceID: String,
        acceptedCue: String,
        affectionPurpose: String,
        addedVisibleCueCount: Int,
        maxVisibleCueDelta: Int,
        manualVisualQAPassing: Bool,
        imageReferenceUpdated: Bool,
        furtherVisibleCueBlocked: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> String {
        "genomeVariationVisibleCueRestraint=surface:\(surfaceID),cue:\(acceptedCue),purpose:\(affectionPurpose),added:\(addedVisibleCueCount),maxDelta:\(maxVisibleCueDelta),manualQA:\(manualVisualQAPassing),imageReference:\(imageReferenceUpdated),furtherVisibleCueBlocked:\(furtherVisibleCueBlocked),dependencyAdded:\(dependencyAdded),appBehaviorChanged:\(appBehaviorChanged),assetOutputs:\(assetOutputs),ready:\(hasGenomeVariationVisibleCueRestraintFields(surfaceID: surfaceID, acceptedCue: acceptedCue, affectionPurpose: affectionPurpose, addedVisibleCueCount: addedVisibleCueCount, maxVisibleCueDelta: maxVisibleCueDelta, manualVisualQAPassing: manualVisualQAPassing, imageReferenceUpdated: imageReferenceUpdated, furtherVisibleCueBlocked: furtherVisibleCueBlocked, dependencyAdded: dependencyAdded, appBehaviorChanged: appBehaviorChanged, assetOutputs: assetOutputs))"
    }

    public static func hasGenomeVariationVisibleCueRestraintFields(
        surfaceID: String,
        acceptedCue: String,
        affectionPurpose: String,
        addedVisibleCueCount: Int,
        maxVisibleCueDelta: Int,
        manualVisualQAPassing: Bool,
        imageReferenceUpdated: Bool,
        furtherVisibleCueBlocked: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && acceptedCue == "softWhiskerDots"
            && affectionPurpose == "kittenLikeSiblingFace"
            && addedVisibleCueCount == 1
            && maxVisibleCueDelta == 1
            && manualVisualQAPassing
            && imageReferenceUpdated
            && furtherVisibleCueBlocked
            && !dependencyAdded
            && !appBehaviorChanged
            && assetOutputs == "none"
    }

    public static func genomeVariationVisibleCueRestraintReadinessSummary(isReady: Bool) -> String {
        "genomeVariationVisibleCueRestraintReady:\(isReady)"
    }

    public static func genomeVariationVisibleCueSetStabilitySummary(
        surfaceID: String,
        silhouetteCueSetReadiness: String,
        visibleCueRestraintReadiness: String,
        acceptedImageReferenceName: String,
        authorizedNewVisibleCueCount: Int,
        futureVisibleCueRequiresManualReview: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> String {
        "genomeVariationVisibleCueSetStability=surface:\(surfaceID),silhouette:\(silhouetteCueSetReadiness),restraint:\(visibleCueRestraintReadiness),imageReference:\(acceptedImageReferenceName),authorizedNewVisibleCues:\(authorizedNewVisibleCueCount),futureManualReview:\(futureVisibleCueRequiresManualReview),dependencyAdded:\(dependencyAdded),appBehaviorChanged:\(appBehaviorChanged),assetOutputs:\(assetOutputs),ready:\(hasGenomeVariationVisibleCueSetStabilityFields(surfaceID: surfaceID, silhouetteCueSetReadiness: silhouetteCueSetReadiness, visibleCueRestraintReadiness: visibleCueRestraintReadiness, acceptedImageReferenceName: acceptedImageReferenceName, authorizedNewVisibleCueCount: authorizedNewVisibleCueCount, futureVisibleCueRequiresManualReview: futureVisibleCueRequiresManualReview, dependencyAdded: dependencyAdded, appBehaviorChanged: appBehaviorChanged, assetOutputs: assetOutputs))"
    }

    public static func hasGenomeVariationVisibleCueSetStabilityFields(
        surfaceID: String,
        silhouetteCueSetReadiness: String,
        visibleCueRestraintReadiness: String,
        acceptedImageReferenceName: String,
        authorizedNewVisibleCueCount: Int,
        futureVisibleCueRequiresManualReview: Bool,
        dependencyAdded: Bool,
        appBehaviorChanged: Bool,
        assetOutputs: String
    ) -> Bool {
        surfaceID == "genomeVariationQA"
            && silhouetteCueSetReadiness == "genomeVariationSilhouetteCueSetAcceptanceReady:true"
            && visibleCueRestraintReadiness == "genomeVariationVisibleCueRestraintReady:true"
            && acceptedImageReferenceName == "genome-variation-accepted"
            && authorizedNewVisibleCueCount == 0
            && futureVisibleCueRequiresManualReview
            && !dependencyAdded
            && !appBehaviorChanged
            && assetOutputs == "none"
    }

    public static func genomeVariationVisibleCueSetStabilityReadinessSummary(isReady: Bool) -> String {
        "genomeVariationVisibleCueSetStabilityReady:\(isReady)"
    }

    public static func observationCueLineReadabilityPreflightSummary(
        surfaceID: String,
        segmentCount: Int,
        maxSegments: Int,
        characterCount: Int,
        maxCharacters: Int,
        includesEyeGlint: Bool,
        includesMemoryCue: Bool,
        lineLimit: Int,
        minimumScaleFactor: String,
        appHostVisualQAPending: Bool,
        visibleCopyChanged: Bool,
        assetOutputs: String
    ) -> String {
        "observationCueLineReadabilityPreflight=surface:\(surfaceID),segments:\(segmentCount)/\(maxSegments),characters:\(characterCount)/\(maxCharacters),eyeGlint:\(includesEyeGlint),memoryCue:\(includesMemoryCue),lineLimit:\(lineLimit),minimumScale:\(minimumScaleFactor),appHostVisualQAPending:\(appHostVisualQAPending),visibleCopyChanged:\(visibleCopyChanged),assetOutputs:\(assetOutputs)"
    }

    public static func hasObservationCueLineReadabilityPreflightFields(
        surfaceID: String,
        segmentCount: Int,
        maxSegments: Int,
        characterCount: Int,
        maxCharacters: Int,
        includesEyeGlint: Bool,
        includesMemoryCue: Bool,
        lineLimit: Int,
        minimumScaleFactor: String,
        appHostVisualQAPending: Bool,
        visibleCopyChanged: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        surfaceID == "observationHome"
            && segmentCount > 0
            && segmentCount <= maxSegments
            && maxSegments == 6
            && characterCount > 0
            && characterCount <= maxCharacters
            && maxCharacters == 128
            && includesEyeGlint
            && includesMemoryCue
            && lineLimit == 3
            && minimumScaleFactor == "0.78"
            && appHostVisualQAPending
            && !visibleCopyChanged
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func observationCueLineReadabilityPreflightReadinessSummary(isReady: Bool) -> String {
        "observationCueLineReadabilityPreflightReady:\(isReady)"
    }

    public static func appHostVisualQARecoveryStateSummary(
        surfaceID: String,
        externalXcodeReady: Bool,
        externalArtifactsReady: Bool,
        dryRunResolved: Bool,
        simulatorID: String,
        targetedBuildCompleted: Bool,
        buildSilentStopped: Bool,
        watchdogTimedOut: Bool,
        timeoutSeconds: Int,
        sourceControlWorkersActive: Bool,
        visibleChangesAllowed: Bool,
        assetOutputs: String
    ) -> String {
        "appHostVisualQARecoveryState=surface:\(surfaceID),externalXcode:\(externalXcodeReady),externalArtifacts:\(externalArtifactsReady),dryRun:\(dryRunResolved),simulator:\(simulatorID),targetedBuild:\(targetedBuildCompleted),silentStopped:\(buildSilentStopped),watchdogTimeout:\(watchdogTimedOut),timeoutSeconds:\(timeoutSeconds),sourceControlWorkers:\(sourceControlWorkersActive),visibleChanges:\(visibleChangesAllowed),assetOutputs:\(assetOutputs)"
    }

    public static func hasAppHostVisualQARecoveryStateFields(
        surfaceID: String,
        externalXcodeReady: Bool,
        externalArtifactsReady: Bool,
        dryRunResolved: Bool,
        simulatorID: String,
        targetedBuildCompleted: Bool,
        buildSilentStopped: Bool,
        watchdogTimedOut: Bool,
        timeoutSeconds: Int,
        sourceControlWorkersActive: Bool,
        visibleChangesAllowed: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        surfaceID == "observationHome"
            && externalXcodeReady
            && externalArtifactsReady
            && dryRunResolved
            && simulatorID == "D1C8187C-29D0-4145-94C7-6F887207A27F"
            && !targetedBuildCompleted
            && buildSilentStopped
            && watchdogTimedOut
            && timeoutSeconds == 180
            && !sourceControlWorkersActive
            && !visibleChangesAllowed
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func appHostVisualQARecoveryStateReadinessSummary(isReady: Bool) -> String {
        "appHostVisualQARecoveryStateReady:\(isReady)"
    }

    public static func appHostVisualQAResumeGateSummary(
        surfaceID: String,
        sourceControlWorkersActive: Bool,
        visibleXcodebuildActive: Bool,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        lastSnapshotBuildTimedOut: Bool,
        visibleChangesAllowed: Bool,
        assetOutputs: String
    ) -> String {
        "appHostVisualQAResumeGate=surface:\(surfaceID),sourceControlWorkers:\(sourceControlWorkersActive),xcodebuild:\(visibleXcodebuildActive),dataFreeMB:\(dataVolumeFreeMegabytes),minDataFreeMB:\(minimumDataVolumeFreeMegabytes),lastSnapshotBuildTimedOut:\(lastSnapshotBuildTimedOut),visibleChanges:\(visibleChangesAllowed),assetOutputs:\(assetOutputs),resume:\(canResumeAppHostVisualQA(surfaceID: surfaceID, sourceControlWorkersActive: sourceControlWorkersActive, visibleXcodebuildActive: visibleXcodebuildActive, dataVolumeFreeMegabytes: dataVolumeFreeMegabytes, minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes, lastSnapshotBuildTimedOut: lastSnapshotBuildTimedOut, visibleChangesAllowed: visibleChangesAllowed, assetOutputs: assetOutputs))"
    }

    public static func canResumeAppHostVisualQA(
        surfaceID: String,
        sourceControlWorkersActive: Bool,
        visibleXcodebuildActive: Bool,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        lastSnapshotBuildTimedOut: Bool,
        visibleChangesAllowed: Bool,
        assetOutputs: String
    ) -> Bool {
        surfaceID == "observationHome"
            && !sourceControlWorkersActive
            && !visibleXcodebuildActive
            && dataVolumeFreeMegabytes >= minimumDataVolumeFreeMegabytes
            && minimumDataVolumeFreeMegabytes >= 2048
            && !lastSnapshotBuildTimedOut
            && !visibleChangesAllowed
            && assetOutputs == "none"
    }

    public static func hasAppHostVisualQAResumeGateFields(
        surfaceID: String,
        sourceControlWorkersActive: Bool,
        visibleXcodebuildActive: Bool,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        lastSnapshotBuildTimedOut: Bool,
        visibleChangesAllowed: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        surfaceID == "observationHome"
            && minimumDataVolumeFreeMegabytes >= 2048
            && dataVolumeFreeMegabytes >= 0
            && (sourceControlWorkersActive
                || visibleXcodebuildActive
                || dataVolumeFreeMegabytes < minimumDataVolumeFreeMegabytes
                || lastSnapshotBuildTimedOut)
            && !canResumeAppHostVisualQA(
                surfaceID: surfaceID,
                sourceControlWorkersActive: sourceControlWorkersActive,
                visibleXcodebuildActive: visibleXcodebuildActive,
                dataVolumeFreeMegabytes: dataVolumeFreeMegabytes,
                minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes,
                lastSnapshotBuildTimedOut: lastSnapshotBuildTimedOut,
                visibleChangesAllowed: visibleChangesAllowed,
                assetOutputs: assetOutputs
            )
            && !visibleChangesAllowed
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func appHostVisualQAResumeGateReadinessSummary(isReady: Bool) -> String {
        "appHostVisualQAResumeGateReady:\(isReady)"
    }

    public static func xctestDevicesExternalStorageGateSummary(
        surfaceID: String,
        xctestDevicesExternalized: Bool,
        xctestDevicesPath: String,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        externalVolumeFreeGigabytes: Int,
        minimumExternalVolumeFreeGigabytes: Int = 16,
        visibleChangesAllowed: Bool,
        assetOutputs: String
    ) -> String {
        "xctestDevicesExternalStorageGate=surface:\(surfaceID),externalized:\(xctestDevicesExternalized),path:\(xctestDevicesPath),dataFreeMB:\(dataVolumeFreeMegabytes),minDataFreeMB:\(minimumDataVolumeFreeMegabytes),externalFreeGB:\(externalVolumeFreeGigabytes),minExternalFreeGB:\(minimumExternalVolumeFreeGigabytes),visibleChanges:\(visibleChangesAllowed),assetOutputs:\(assetOutputs),resume:\(canResumeWithExternalXCTestDevicesStorage(surfaceID: surfaceID, xctestDevicesExternalized: xctestDevicesExternalized, xctestDevicesPath: xctestDevicesPath, dataVolumeFreeMegabytes: dataVolumeFreeMegabytes, minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes, externalVolumeFreeGigabytes: externalVolumeFreeGigabytes, minimumExternalVolumeFreeGigabytes: minimumExternalVolumeFreeGigabytes, visibleChangesAllowed: visibleChangesAllowed, assetOutputs: assetOutputs))"
    }

    public static func canResumeWithExternalXCTestDevicesStorage(
        surfaceID: String,
        xctestDevicesExternalized: Bool,
        xctestDevicesPath: String,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        externalVolumeFreeGigabytes: Int,
        minimumExternalVolumeFreeGigabytes: Int = 16,
        visibleChangesAllowed: Bool,
        assetOutputs: String
    ) -> Bool {
        surfaceID == "observationHome"
            && xctestDevicesExternalized
            && xctestDevicesPath.hasPrefix("/Volumes/")
            && dataVolumeFreeMegabytes >= minimumDataVolumeFreeMegabytes
            && externalVolumeFreeGigabytes >= minimumExternalVolumeFreeGigabytes
            && !visibleChangesAllowed
            && assetOutputs == "none"
    }

    public static func hasXCTestDevicesExternalStorageGateFields(
        surfaceID: String,
        xctestDevicesExternalized: Bool,
        xctestDevicesPath: String,
        dataVolumeFreeMegabytes: Int,
        minimumDataVolumeFreeMegabytes: Int,
        externalVolumeFreeGigabytes: Int,
        minimumExternalVolumeFreeGigabytes: Int = 16,
        visibleChangesAllowed: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        surfaceID == "observationHome"
            && xctestDevicesExternalized
            && xctestDevicesPath.hasPrefix("/Volumes/")
            && dataVolumeFreeMegabytes >= 0
            && minimumDataVolumeFreeMegabytes > 0
            && externalVolumeFreeGigabytes >= minimumExternalVolumeFreeGigabytes
            && dataVolumeFreeMegabytes < minimumDataVolumeFreeMegabytes
            && !visibleChangesAllowed
            && assetOutputs == "none"
            && !summary.isEmpty
            && !canResumeWithExternalXCTestDevicesStorage(
                surfaceID: surfaceID,
                xctestDevicesExternalized: xctestDevicesExternalized,
                xctestDevicesPath: xctestDevicesPath,
                dataVolumeFreeMegabytes: dataVolumeFreeMegabytes,
                minimumDataVolumeFreeMegabytes: minimumDataVolumeFreeMegabytes,
                externalVolumeFreeGigabytes: externalVolumeFreeGigabytes,
                minimumExternalVolumeFreeGigabytes: minimumExternalVolumeFreeGigabytes,
                visibleChangesAllowed: visibleChangesAllowed,
                assetOutputs: assetOutputs
            )
    }

    public static func xctestDevicesExternalStorageGateReadinessSummary(isReady: Bool) -> String {
        "xctestDevicesExternalStorageGateReady:\(isReady)"
    }

    public static func fixedPartVocabularyBridgeSummary(
        faceMappings: [String],
        upperBodyMappings: [String],
        wingMappings: [String],
        tailMappings: [String],
        assetOutputs: String,
        geometryChanged: Bool
    ) -> String {
        "fixedPartVocabularyBridge=v1;face:\(faceMappings.joined(separator: ","));upperBody:\(upperBodyMappings.joined(separator: ","));wing:\(wingMappings.joined(separator: ","));tail:\(tailMappings.joined(separator: ","));assetOutputs:\(assetOutputs);geometryChanged:\(geometryChanged)"
    }

    public static func hasFixedPartVocabularyBridgeFields(
        faceMappings: [String],
        upperBodyMappings: [String],
        wingMappings: [String],
        tailMappings: [String],
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !faceMappings.isEmpty
            && !upperBodyMappings.isEmpty
            && !wingMappings.isEmpty
            && !tailMappings.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPartVocabularyBridgeReadinessSummary(isReady: Bool) -> String {
        "fixedPartVocabularyBridgeMetadataReady:\(isReady)"
    }

    public static func fixedPart2DRecipeBridgeSummary(
        headRecipes: [String],
        bodyRecipes: [String],
        wingRecipes: [String],
        tailRecipes: [String],
        futureTargets: [String],
        assetOutputs: String,
        geometryChanged: Bool
    ) -> String {
        "fixedPart2DRecipeBridge=v1;head:\(headRecipes.joined(separator: ","));body:\(bodyRecipes.joined(separator: ","));wing:\(wingRecipes.joined(separator: ","));tail:\(tailRecipes.joined(separator: ","));futureTargets:\(futureTargets.joined(separator: ","));assetOutputs:\(assetOutputs);geometryChanged:\(geometryChanged)"
    }

    public static func hasFixedPart2DRecipeBridgeFields(
        headRecipes: [String],
        bodyRecipes: [String],
        wingRecipes: [String],
        tailRecipes: [String],
        futureTargets: [String],
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !headRecipes.isEmpty
            && !bodyRecipes.isEmpty
            && !wingRecipes.isEmpty
            && !tailRecipes.isEmpty
            && !futureTargets.isEmpty
            && headRecipes.allSatisfy { !$0.isEmpty }
            && bodyRecipes.allSatisfy { !$0.isEmpty }
            && wingRecipes.allSatisfy { !$0.isEmpty }
            && tailRecipes.allSatisfy { !$0.isEmpty }
            && futureTargets.allSatisfy { !$0.isEmpty }
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPart2DRecipeBridgeReadinessSummary(isReady: Bool) -> String {
        "fixedPart2DRecipeBridgeReady:\(isReady)"
    }

    public static func fixedPartAccessoryRecipeBridgeSummary(
        faceAccessories: [String],
        bodyAccessories: [String],
        wingAccessories: [String],
        tailAccessories: [String],
        futureTargets: [String],
        assetOutputs: String,
        geometryChanged: Bool
    ) -> String {
        "fixedPartAccessoryRecipeBridge=v1;face:\(faceAccessories.joined(separator: ","));body:\(bodyAccessories.joined(separator: ","));wing:\(wingAccessories.joined(separator: ","));tail:\(tailAccessories.joined(separator: ","));futureTargets:\(futureTargets.joined(separator: ","));assetOutputs:\(assetOutputs);geometryChanged:\(geometryChanged)"
    }

    public static func hasFixedPartAccessoryRecipeBridgeFields(
        faceAccessories: [String],
        bodyAccessories: [String],
        wingAccessories: [String],
        tailAccessories: [String],
        futureTargets: [String],
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !faceAccessories.isEmpty
            && !bodyAccessories.isEmpty
            && !wingAccessories.isEmpty
            && !tailAccessories.isEmpty
            && !futureTargets.isEmpty
            && faceAccessories.allSatisfy { !$0.isEmpty }
            && bodyAccessories.allSatisfy { !$0.isEmpty }
            && wingAccessories.allSatisfy { !$0.isEmpty }
            && tailAccessories.allSatisfy { !$0.isEmpty }
            && futureTargets.allSatisfy { !$0.isEmpty }
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryRecipeBridgeReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryRecipeBridgeReady:\(isReady)"
    }

    public static func fixedPartAccessoryReferenceAnnotationSummary(
        faceAnnotations: [String],
        bodyAnnotations: [String],
        wingAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        sourceBridgeReady: Bool,
        assetOutputs: String,
        generatedAssets: Bool
    ) -> String {
        "fixedPartAccessoryReferenceAnnotation=v1;face:\(faceAnnotations.joined(separator: ","));body:\(bodyAnnotations.joined(separator: ","));wing:\(wingAnnotations.joined(separator: ","));tail:\(tailAnnotations.joined(separator: ","));panels:\(requiredPanels.joined(separator: ","));sourceBridgeReady:\(sourceBridgeReady);assetOutputs:\(assetOutputs);generatedAssets:\(generatedAssets)"
    }

    public static func hasFixedPartAccessoryReferenceAnnotationFields(
        faceAnnotations: [String],
        bodyAnnotations: [String],
        wingAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        sourceBridgeReady: Bool,
        assetOutputs: String,
        generatedAssets: Bool,
        summary: String
    ) -> Bool {
        let panelSet = Set(requiredPanels)

        return !faceAnnotations.isEmpty
            && !bodyAnnotations.isEmpty
            && !wingAnnotations.isEmpty
            && !tailAnnotations.isEmpty
            && faceAnnotations.allSatisfy { !$0.isEmpty }
            && bodyAnnotations.allSatisfy { !$0.isEmpty }
            && wingAnnotations.allSatisfy { !$0.isEmpty }
            && tailAnnotations.allSatisfy { !$0.isEmpty }
            && panelSet.isSuperset(of: ["accessoryCue", "socketDiagram", "rigDiagram"])
            && sourceBridgeReady
            && assetOutputs == "none"
            && !generatedAssets
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryReferenceAnnotationReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryReferenceAnnotationReady:\(isReady)"
    }

    public static func fixedPartAccessoryReferenceSheetPreflightSummary(
        accessoryReferenceReady: Bool,
        manualChecklistReady: Bool,
        manualReviewStateReady: Bool,
        reviewEvidenceFieldsReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAccessoryReferenceSheetPreflight=v1;accessoryReferenceReady:\(accessoryReferenceReady);manualChecklistReady:\(manualChecklistReady);manualReviewStateReady:\(manualReviewStateReady);reviewEvidenceFieldsReady:\(reviewEvidenceFieldsReady);candidateExists:\(candidateExists);generationAllowed:\(generationAllowed);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartAccessoryReferenceSheetPreflightFields(
        accessoryReferenceReady: Bool,
        manualChecklistReady: Bool,
        manualReviewStateReady: Bool,
        reviewEvidenceFieldsReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        accessoryReferenceReady
            && manualChecklistReady
            && manualReviewStateReady
            && reviewEvidenceFieldsReady
            && !candidateExists
            && !generationAllowed
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryReferenceSheetPreflightReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryReferenceSheetPreflightReady:\(isReady)"
    }

    public static func fixedPartAccessoryReferenceSheetPanelNotesSummary(
        notes: [String],
        requiredPanels: [String],
        preflightReady: Bool,
        grayscaleOnly: Bool,
        noColorPatternGlow: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAccessoryReferenceSheetPanelNotes=v1;notes:\(notes.joined(separator: ","));panels:\(requiredPanels.joined(separator: ","));preflightReady:\(preflightReady);grayscaleOnly:\(grayscaleOnly);noColorPatternGlow:\(noColorPatternGlow);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartAccessoryReferenceSheetPanelNotesFields(
        notes: [String],
        requiredPanels: [String],
        preflightReady: Bool,
        grayscaleOnly: Bool,
        noColorPatternGlow: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let noteSet = Set(notes)
        let requiredNotes: Set<String> = [
            "softEarNubs:FaceBase.deer@headCenter:roundedEarNubs:secondarySilhouette",
            "softEarTips:FaceBase.feline@headCenter:softPetalEarTips:secondarySilhouette",
            "softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals:secondarySilhouette",
            "softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl:secondarySilhouette",
            "softForkFin:TailBase.fish@tailTip:softForkedFin:secondarySilhouette",
            "softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge:secondarySilhouette",
            "softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents:secondarySilhouette"
        ]
        let panelSet = Set(requiredPanels)
        let requiredPanelSet: Set<String> = [
            "frontView",
            "sideView",
            "threeQuarterView",
            "socketDiagram",
            "rigDiagram",
            "accessoryCue"
        ]

        return noteSet.isSuperset(of: requiredNotes)
            && panelSet.isSuperset(of: requiredPanelSet)
            && preflightReady
            && grayscaleOnly
            && noColorPatternGlow
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryReferenceSheetPanelNotesReady:\(isReady)"
    }

    public static func fixedPartAccessoryManualReviewChecklistSummary(
        reviewerRole: String,
        checklistItems: [String],
        preflightReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAccessoryManualReviewChecklist=v1;reviewer:\(reviewerRole);items:\(checklistItems.joined(separator: ","));preflightReady:\(preflightReady);manualArtReview:\(manualArtDirectionReviewed);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartAccessoryManualReviewChecklistFields(
        reviewerRole: String,
        checklistItems: [String],
        preflightReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let itemSet = Set(checklistItems)
        let requiredItems: Set<String> = [
            "softAccessoryScale",
            "socketOwnership",
            "silhouetteSecondary",
            "cuteReadability",
            "familyLikenessSafe",
            "grayscaleOnly",
            "noColorPatternGlow",
            "noGeneratedGeometry"
        ]

        return reviewerRole == "CreatureArtDirector"
            && itemSet.isSuperset(of: requiredItems)
            && preflightReady
            && !manualArtDirectionReviewed
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryManualReviewChecklistReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryManualReviewChecklistReady:\(isReady)"
    }

    public static func fixedPartAccessoryReviewEvidenceHandoffSummary(
        checklistReady: Bool,
        evidenceFields: [String],
        evidenceRecorded: Bool,
        evidencePath: String,
        reviewerNote: String,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAccessoryReviewEvidenceHandoff=v1;checklistReady:\(checklistReady);fields:\(evidenceFields.joined(separator: ","));evidenceRecorded:\(evidenceRecorded);evidencePath:\(evidencePath);reviewerNote:\(reviewerNote);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartAccessoryReviewEvidenceHandoffFields(
        checklistReady: Bool,
        evidenceFields: [String],
        evidenceRecorded: Bool,
        evidencePath: String,
        reviewerNote: String,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let fieldSet = Set(evidenceFields)
        let requiredFields: Set<String> = [
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "decisionReason",
            "affectionRisk",
            "revisionNotes"
        ]

        return checklistReady
            && fieldSet.isSuperset(of: requiredFields)
            && !evidenceRecorded
            && evidencePath.isEmpty
            && reviewerNote.isEmpty
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryReviewEvidenceHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryReviewEvidenceHandoffReady:\(isReady)"
    }

    public static func fixedPartAccessoryArtifactCandidateRecordSummary(
        artifactStem: String,
        relativePath: String,
        format: String,
        surface: String,
        evidenceHandoffReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAccessoryArtifactCandidateRecord=v1;stem:\(artifactStem);path:\(relativePath);format:\(format);surface:\(surface);evidenceHandoffReady:\(evidenceHandoffReady);candidateExists:\(candidateExists);generationAllowed:\(generationAllowed);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartAccessoryArtifactCandidateRecordFields(
        artifactStem: String,
        relativePath: String,
        format: String,
        surface: String,
        evidenceHandoffReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        artifactStem == "wipet_fixed_part_accessory_reference_sheet_v1"
            && relativePath == "docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png"
            && format == "png"
            && surface == "fixedPartAccessoryReferenceSheet"
            && evidenceHandoffReady
            && !candidateExists
            && !generationAllowed
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartAccessoryArtifactCandidateRecordReadinessSummary(isReady: Bool) -> String {
        "fixedPartAccessoryArtifactCandidateRecordReady:\(isReady)"
    }

    public static func fixedPartAssetSocketMappingSummary(
        faceMappings: [String],
        upperBodyMappings: [String],
        wingMappings: [String],
        tailMappings: [String],
        socketIDs: [String],
        assetOutputs: String,
        validated3DAssets: Bool
    ) -> String {
        "fixedPartAssetSocketMapping=v1;face:\(faceMappings.joined(separator: ","));upperBody:\(upperBodyMappings.joined(separator: ","));wing:\(wingMappings.joined(separator: ","));tail:\(tailMappings.joined(separator: ","));sockets:\(socketIDs.joined(separator: ","));assetOutputs:\(assetOutputs);validated3DAssets:\(validated3DAssets)"
    }

    public static func hasFixedPartAssetSocketMappingFields(
        faceMappings: [String],
        upperBodyMappings: [String],
        wingMappings: [String],
        tailMappings: [String],
        socketIDs: [String],
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !faceMappings.isEmpty
            && !upperBodyMappings.isEmpty
            && !wingMappings.isEmpty
            && !tailMappings.isEmpty
            && !socketIDs.isEmpty
            && faceMappings.allSatisfy { !$0.isEmpty }
            && upperBodyMappings.allSatisfy { !$0.isEmpty }
            && wingMappings.allSatisfy { !$0.isEmpty }
            && tailMappings.allSatisfy { !$0.isEmpty }
            && socketIDs.allSatisfy { !$0.isEmpty }
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPartAssetSocketMappingReadinessSummary(isReady: Bool) -> String {
        "fixedPartAssetSocketMappingReady:\(isReady)"
    }

    public static func fixedPartUpperBodyProportionHandoffSummary(
        mappings: [String],
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartUpperBodyProportionHandoff=v1;mappings:\(mappings.joined(separator: ","));socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartUpperBodyProportionHandoffFields(
        mappings: [String],
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let requiredBodies = [
            "UpperBody.aquarian",
            "UpperBody.sylphian",
            "UpperBody.crystalian",
            "UpperBody.lunarian",
            "UpperBody.verdant"
        ]

        return mappings.count >= requiredBodies.count
            && mappings.allSatisfy {
                !$0.isEmpty
                    && $0.contains("->")
                    && $0.contains("@bodyCenter")
                    && $0.contains("#proportionCue")
            }
            && requiredBodies.allSatisfy { body in
                mappings.contains { $0.contains(body) }
            }
            && socketID == "bodyCenter"
            && rigTarget == "body"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartUpperBodyProportionHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartUpperBodyProportionHandoffReady:\(isReady)"
    }

    public static func fixedPartTailFloatingHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartTailFloatingHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartTailFloatingHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("floatingRibbon")
            && mapping.contains("softTetherDot")
            && mapping.contains("->TailBase.floating@tailRoot#accessoryCue")
            && socketID == "tailRoot"
            && rigTarget == "tail_1"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "floatingRibbon+softTetherDot"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartTailFloatingHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartTailFloatingHandoffReady:\(isReady)"
    }

    public static func fixedPartTailDragonHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartTailDragonHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartTailDragonHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("longDrake")
            && mapping.contains("softDrakeRidge")
            && mapping.contains("->TailBase.dragon@tailRoot#accessoryCue")
            && socketID == "tailRoot"
            && rigTarget == "tail_1"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "longDrake+softDrakeRidge"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartTailDragonHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartTailDragonHandoffReady:\(isReady)"
    }

    public static func fixedPartTailFishHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartTailFishHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartTailFishHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("fishFin")
            && mapping.contains("softForkFin")
            && mapping.contains("->TailBase.fish@tailRoot#accessoryCue")
            && socketID == "tailRoot"
            && rigTarget == "tail_1"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "fishFin+softForkFin"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartTailFishHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartTailFishHandoffReady:\(isReady)"
    }

    public static func fixedPartTailPlantHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartTailPlantHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartTailPlantHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("leafSprout")
            && mapping.contains("softLeafVein")
            && mapping.contains("->TailBase.plant@tailRoot#accessoryCue")
            && socketID == "tailRoot"
            && rigTarget == "tail_1"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "leafSprout+softLeafVein"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartTailPlantHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartTailPlantHandoffReady:\(isReady)"
    }

    public static func fixedPartFaceDeerHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartFaceDeerHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartFaceDeerHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("softDeer")
            && mapping.contains("softEarNubs")
            && mapping.contains("->FaceBase.deer@headCenter#accessoryCue")
            && socketID == "headCenter"
            && rigTarget == "head"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "softDeer+softEarNubs"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartFaceDeerHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartFaceDeerHandoffReady:\(isReady)"
    }

    public static func fixedPartFaceFelineHandoffSummary(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartFaceFelineHandoff=v1;mapping:\(mapping);socket:\(socketID);rig:\(rigTarget);panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartFaceFelineHandoffFields(
        mapping: String,
        socketID: String,
        rigTarget: String,
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("softFeline")
            && mapping.contains("softEarTips")
            && mapping.contains("->FaceBase.feline@headCenter#accessoryCue")
            && socketID == "headCenter"
            && rigTarget == "head"
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "softFeline+softEarTips"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartFaceFelineHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartFaceFelineHandoffReady:\(isReady)"
    }

    public static func fixedPartFaceBaseReferenceEvidenceHandoffSummary(
        sourceCues: [String],
        faceBases: [String],
        requiredPanels: [String],
        socketID: String,
        rigTarget: String,
        silhouetteRule: String,
        manualVisualQAAccepted: Bool,
        evidenceRecorded: Bool,
        generatedGeometry: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        let cueSummary = sourceCues.isEmpty ? "none" : sourceCues.joined(separator: "|")
        let faceBaseSummary = faceBases.isEmpty ? "none" : faceBases.joined(separator: "+")
        let panelSummary = requiredPanels.isEmpty ? "none" : requiredPanels.joined(separator: "+")
        return "fixedPartFaceBaseReferenceEvidenceHandoff=v1;cues:\(cueSummary);faceBases:\(faceBaseSummary);panels:\(panelSummary);socket:\(socketID);rig:\(rigTarget);silhouette:\(silhouetteRule);manualQA:\(manualVisualQAAccepted);evidenceRecorded:\(evidenceRecorded);geometryGenerated:\(generatedGeometry);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartFaceBaseReferenceEvidenceHandoffFields(
        sourceCues: [String],
        faceBases: [String],
        requiredPanels: [String],
        socketID: String,
        rigTarget: String,
        silhouetteRule: String,
        manualVisualQAAccepted: Bool,
        evidenceRecorded: Bool,
        generatedGeometry: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let cueSet = Set(sourceCues)
        let panelSet = Set(requiredPanels)

        return cueSet.isSuperset(of: ["softDeer+softEarNubs", "softFeline+softEarTips"])
            && Set(faceBases).isSuperset(of: ["deer", "feline"])
            && panelSet.isSuperset(of: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "accessoryCue"])
            && socketID == "headCenter"
            && rigTarget == "head"
            && silhouetteRule == "secondarySoftEarAccessories"
            && manualVisualQAAccepted
            && !evidenceRecorded
            && !generatedGeometry
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartFaceBaseReferenceEvidenceHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartFaceBaseReferenceEvidenceHandoffReady:\(isReady)"
    }

    public static func fixedPartWingFairyHandoffSummary(
        mapping: String,
        socketIDs: [String],
        rigTargets: [String],
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartWingFairyHandoff=v1;mapping:\(mapping);sockets:\(socketIDs.joined(separator: "+"));rig:\(rigTargets.joined(separator: "+"));panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartWingFairyHandoffFields(
        mapping: String,
        socketIDs: [String],
        rigTargets: [String],
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("leafPair")
            && mapping.contains("softWingTipPearl")
            && mapping.contains("->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue")
            && socketIDs == ["leftWingRoot", "rightWingRoot"]
            && rigTargets == ["wing_L", "wing_R"]
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "leafPair+softWingTipPearl"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartWingFairyHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartWingFairyHandoffReady:\(isReady)"
    }

    public static func fixedPartWingDragonHandoffSummary(
        mapping: String,
        socketIDs: [String],
        rigTargets: [String],
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartWingDragonHandoff=v1;mapping:\(mapping);sockets:\(socketIDs.joined(separator: "+"));rig:\(rigTargets.joined(separator: "+"));panels:\(requiredPanels.joined(separator: "+"));acceptedCue:\(acceptedSpriteKitCue);generatedAssets:\(generatedAssets);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartWingDragonHandoffFields(
        mapping: String,
        socketIDs: [String],
        rigTargets: [String],
        requiredPanels: [String],
        acceptedSpriteKitCue: String,
        generatedAssets: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !mapping.isEmpty
            && mapping.contains("wideSail")
            && mapping.contains("softWingTipClaw")
            && mapping.contains("->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue")
            && socketIDs == ["leftWingRoot", "rightWingRoot"]
            && rigTargets == ["wing_L", "wing_R"]
            && requiredPanels.contains("frontView")
            && requiredPanels.contains("sideView")
            && requiredPanels.contains("threeQuarterView")
            && requiredPanels.contains("socketDiagram")
            && requiredPanels.contains("rigDiagram")
            && requiredPanels.contains("accessoryCue")
            && acceptedSpriteKitCue == "wideSail+softWingTipClaw"
            && !generatedAssets
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartWingDragonHandoffReadinessSummary(isReady: Bool) -> String {
        "fixedPartWingDragonHandoffReady:\(isReady)"
    }

    public static func fixedPart3DManifestSummary(
        assetStems: [String],
        formats: [String],
        rigName: String,
        requiredBones: [String],
        socketMappings: [String],
        grayscaleOnly: Bool,
        excludesColorPatternGlow: Bool,
        validatedAssets: Bool,
        generatedAssets: Bool
    ) -> String {
        "fixedPart3DManifest=v1;assets:\(assetStems.joined(separator: ","));formats:\(formats.joined(separator: ","));rig:\(rigName);bones:\(requiredBones.joined(separator: ","));sockets:\(socketMappings.joined(separator: ","));grayscaleOnly:\(grayscaleOnly);excludesColorPatternGlow:\(excludesColorPatternGlow);validatedAssets:\(validatedAssets);generatedAssets:\(generatedAssets)"
    }

    public static func hasFixedPart3DManifestFields(
        assetStems: [String],
        formats: [String],
        rigName: String,
        requiredBones: [String],
        socketMappings: [String],
        grayscaleOnly: Bool,
        excludesColorPatternGlow: Bool,
        validatedAssets: Bool,
        generatedAssets: Bool,
        summary: String
    ) -> Bool {
        !assetStems.isEmpty
            && assetStems.allSatisfy { !$0.isEmpty && $0.hasPrefix("wipet_") }
            && formats.contains("glb")
            && formats.contains("usd")
            && rigName == "CommonPetRig"
            && requiredBones.contains("root")
            && requiredBones.contains("body")
            && requiredBones.contains("head")
            && requiredBones.contains("wing_L")
            && requiredBones.contains("wing_R")
            && requiredBones.contains("tail_1")
            && socketMappings.contains("bodyCenter->body")
            && socketMappings.contains("headCenter->head")
            && socketMappings.contains("leftWingRoot->wing_L")
            && socketMappings.contains("rightWingRoot->wing_R")
            && socketMappings.contains("tailRoot->tail_1")
            && grayscaleOnly
            && excludesColorPatternGlow
            && !validatedAssets
            && !generatedAssets
            && !summary.isEmpty
    }

    public static func fixedPart3DManifestReadinessSummary(isReady: Bool) -> String {
        "fixedPart3DManifestReady:\(isReady)"
    }

    public static func fixedPart3DReferenceAcceptanceGateSummary(
        cueSetID: String,
        referenceSheetReady: Bool,
        panelLayoutReady: Bool,
        referenceAcceptanceReady: Bool,
        artifactNamingReady: Bool,
        manualReviewChecklistReady: Bool,
        childDraftGateReady: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPart3DReferenceAcceptanceGate=v1;cueSet:\(cueSetID);referenceSheetReady:\(referenceSheetReady);panelLayoutReady:\(panelLayoutReady);referenceAcceptanceReady:\(referenceAcceptanceReady);artifactNamingReady:\(artifactNamingReady);manualReviewChecklistReady:\(manualReviewChecklistReady);childDraftGateReady:\(childDraftGateReady);modelIODeferred:\(modelIODeferred);sceneKitDeferred:\(sceneKitDeferred);realityKitDeferred:\(realityKitDeferred);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPart3DReferenceAcceptanceGateFields(
        cueSetID: String,
        referenceSheetReady: Bool,
        panelLayoutReady: Bool,
        referenceAcceptanceReady: Bool,
        artifactNamingReady: Bool,
        manualReviewChecklistReady: Bool,
        childDraftGateReady: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        cueSetID == "softLineageCueSet"
            && referenceSheetReady
            && panelLayoutReady
            && referenceAcceptanceReady
            && artifactNamingReady
            && manualReviewChecklistReady
            && childDraftGateReady
            && modelIODeferred
            && sceneKitDeferred
            && realityKitDeferred
            && !generationAllowed
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPart3DReferenceAcceptanceGateReadinessSummary(isReady: Bool) -> String {
        "fixedPart3DReferenceAcceptanceGateReady:\(isReady)"
    }

    public static func fixedPartAssetPipelineResumeGateSummary(
        manifestReady: Bool,
        rigPreflightDeferredSafely: Bool,
        referenceAcceptanceGateReady: Bool,
        appHostVisualQAResumeReady: Bool,
        manualReferenceAccepted: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartAssetPipelineResumeGate=v1;manifestReady:\(manifestReady);rigPreflightDeferred:\(rigPreflightDeferredSafely);referenceGateReady:\(referenceAcceptanceGateReady);appHostResume:\(appHostVisualQAResumeReady);manualReferenceAccepted:\(manualReferenceAccepted);modelIODeferred:\(modelIODeferred);sceneKitDeferred:\(sceneKitDeferred);realityKitDeferred:\(realityKitDeferred);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs);resume:\(canResumeFixedPartAssetPipeline(manifestReady: manifestReady, rigPreflightDeferredSafely: rigPreflightDeferredSafely, referenceAcceptanceGateReady: referenceAcceptanceGateReady, appHostVisualQAResumeReady: appHostVisualQAResumeReady, manualReferenceAccepted: manualReferenceAccepted, modelIODeferred: modelIODeferred, sceneKitDeferred: sceneKitDeferred, realityKitDeferred: realityKitDeferred, generationAllowed: generationAllowed, runtimeLoaded: runtimeLoaded, generatedAssets: generatedAssets, assetOutputs: assetOutputs))"
    }

    public static func canResumeFixedPartAssetPipeline(
        manifestReady: Bool,
        rigPreflightDeferredSafely: Bool,
        referenceAcceptanceGateReady: Bool,
        appHostVisualQAResumeReady: Bool,
        manualReferenceAccepted: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> Bool {
        manifestReady
            && !rigPreflightDeferredSafely
            && referenceAcceptanceGateReady
            && appHostVisualQAResumeReady
            && manualReferenceAccepted
            && !modelIODeferred
            && !sceneKitDeferred
            && !realityKitDeferred
            && generationAllowed
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
    }

    public static func hasFixedPartAssetPipelineResumeGateFields(
        manifestReady: Bool,
        rigPreflightDeferredSafely: Bool,
        referenceAcceptanceGateReady: Bool,
        appHostVisualQAResumeReady: Bool,
        manualReferenceAccepted: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        manifestReady
            && rigPreflightDeferredSafely
            && referenceAcceptanceGateReady
            && !appHostVisualQAResumeReady
            && !manualReferenceAccepted
            && modelIODeferred
            && sceneKitDeferred
            && realityKitDeferred
            && !generationAllowed
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
            && !canResumeFixedPartAssetPipeline(
                manifestReady: manifestReady,
                rigPreflightDeferredSafely: rigPreflightDeferredSafely,
                referenceAcceptanceGateReady: referenceAcceptanceGateReady,
                appHostVisualQAResumeReady: appHostVisualQAResumeReady,
                manualReferenceAccepted: manualReferenceAccepted,
                modelIODeferred: modelIODeferred,
                sceneKitDeferred: sceneKitDeferred,
                realityKitDeferred: realityKitDeferred,
                generationAllowed: generationAllowed,
                runtimeLoaded: runtimeLoaded,
                generatedAssets: generatedAssets,
                assetOutputs: assetOutputs
            )
            && !summary.isEmpty
    }

    public static func fixedPartAssetPipelineResumeGateReadinessSummary(isReady: Bool) -> String {
        "fixedPartAssetPipelineResumeGateReady:\(isReady)"
    }

    public static func fixedPartAssetPipelineReadinessLedgerSummary(
        manifestReady: Bool,
        rigPreflightDeferredSafely: Bool,
        referenceAcceptanceGateReady: Bool,
        appHostVisualQAResumeReady: Bool,
        manualReferenceAccepted: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        let resume = canResumeFixedPartAssetPipeline(
            manifestReady: manifestReady,
            rigPreflightDeferredSafely: rigPreflightDeferredSafely,
            referenceAcceptanceGateReady: referenceAcceptanceGateReady,
            appHostVisualQAResumeReady: appHostVisualQAResumeReady,
            manualReferenceAccepted: manualReferenceAccepted,
            modelIODeferred: modelIODeferred,
            sceneKitDeferred: sceneKitDeferred,
            realityKitDeferred: realityKitDeferred,
            generationAllowed: generationAllowed,
            runtimeLoaded: runtimeLoaded,
            generatedAssets: generatedAssets,
            assetOutputs: assetOutputs
        )
        let nextAction = resume ? "beginModelIOValidation" : "waitForReferenceAndAppHostQA"

        return "fixedPartAssetPipelineReadinessLedger=v1;manifestReady:\(manifestReady);rigPreflightDeferred:\(rigPreflightDeferredSafely);referenceGateReady:\(referenceAcceptanceGateReady);appHostResume:\(appHostVisualQAResumeReady);manualReferenceAccepted:\(manualReferenceAccepted);modelIODeferred:\(modelIODeferred);sceneKitDeferred:\(sceneKitDeferred);realityKitDeferred:\(realityKitDeferred);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs);next:\(nextAction);resume:\(resume)"
    }

    public static func hasFixedPartAssetPipelineReadinessLedgerFields(
        manifestReady: Bool,
        rigPreflightDeferredSafely: Bool,
        referenceAcceptanceGateReady: Bool,
        appHostVisualQAResumeReady: Bool,
        manualReferenceAccepted: Bool,
        modelIODeferred: Bool,
        sceneKitDeferred: Bool,
        realityKitDeferred: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        manifestReady
            && rigPreflightDeferredSafely
            && referenceAcceptanceGateReady
            && !appHostVisualQAResumeReady
            && !manualReferenceAccepted
            && modelIODeferred
            && sceneKitDeferred
            && realityKitDeferred
            && !generationAllowed
            && !runtimeLoaded
            && !generatedAssets
            && assetOutputs == "none"
            && summary.contains("next:waitForReferenceAndAppHostQA")
            && summary.contains("resume:false")
    }

    public static func fixedPartAssetPipelineReadinessLedgerReadinessSummary(isReady: Bool) -> String {
        "fixedPartAssetPipelineReadinessLedgerReady:\(isReady)"
    }

    public static func fixedPartLineageCueReferenceAnnotationSummary(
        bodyAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        assetOutputs: String,
        generatedAssets: Bool
    ) -> String {
        "fixedPartLineageCueReferenceAnnotation=v1;body:\(bodyAnnotations.joined(separator: ","));tail:\(tailAnnotations.joined(separator: ","));panels:\(requiredPanels.joined(separator: ","));assetOutputs:\(assetOutputs);generatedAssets:\(generatedAssets)"
    }

    public static func hasFixedPartLineageCueReferenceAnnotationFields(
        bodyAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        assetOutputs: String,
        generatedAssets: Bool,
        summary: String
    ) -> Bool {
        let requiredPanelSet = Set(requiredPanels)

        return !bodyAnnotations.isEmpty
            && !tailAnnotations.isEmpty
            && bodyAnnotations.allSatisfy { !$0.isEmpty }
            && tailAnnotations.allSatisfy { !$0.isEmpty }
            && requiredPanelSet.isSuperset(of: ["lineageCue", "socketDiagram", "rigDiagram"])
            && assetOutputs == "none"
            && !generatedAssets
            && !summary.isEmpty
    }

    public static func fixedPartLineageCueReferenceAnnotationReadinessSummary(isReady: Bool) -> String {
        "fixedPartLineageCueReferenceAnnotationReady:\(isReady)"
    }

    public static func fixedPartChildDraftLineageCueReferenceSummary(
        faceAnnotations: [String],
        bodyAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        socketMappings: [String],
        sourceSurface: String,
        assetOutputs: String,
        generatedAssets: Bool
    ) -> String {
        "fixedPartChildDraftLineageCueReference=v1;face:\(faceAnnotations.joined(separator: ","));body:\(bodyAnnotations.joined(separator: ","));tail:\(tailAnnotations.joined(separator: ","));panels:\(requiredPanels.joined(separator: ","));sockets:\(socketMappings.joined(separator: ","));source:\(sourceSurface);assetOutputs:\(assetOutputs);generatedAssets:\(generatedAssets)"
    }

    public static func hasFixedPartChildDraftLineageCueReferenceFields(
        faceAnnotations: [String],
        bodyAnnotations: [String],
        tailAnnotations: [String],
        requiredPanels: [String],
        socketMappings: [String],
        sourceSurface: String,
        assetOutputs: String,
        generatedAssets: Bool,
        summary: String
    ) -> Bool {
        let requiredPanelSet = Set(requiredPanels)

        return faceAnnotations.contains("softDeer->FaceBase.deer@headCenter#lineageCue")
            && faceAnnotations.contains("forestDots->FaceBase.deer@headCenter#lineageCue")
            && bodyAnnotations.contains("softAncestralGlint->UpperBody.lunarian@bodyCenter#lineageCue")
            && bodyAnnotations.contains("softLineageMemoryThread->UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot#lineageCue")
            && tailAnnotations.contains("softTailMemoryDots->TailBase.floating@tailRoot#lineageCue")
            && requiredPanelSet.isSuperset(of: ["childDraftPortrait", "lineageCue", "socketDiagram", "rigDiagram"])
            && socketMappings.contains("headCenter->head")
            && socketMappings.contains("bodyCenter->body")
            && socketMappings.contains("tailRoot->tail_1")
            && sourceSurface == "genomeVariationChildDraft"
            && assetOutputs == "none"
            && !generatedAssets
            && !summary.isEmpty
    }

    public static func fixedPartChildDraftLineageCueReferenceReadinessSummary(isReady: Bool) -> String {
        "fixedPartChildDraftLineageCueReferenceReady:\(isReady)"
    }

    public static func fixedPartChildDraftLineageCueAcceptanceGateSummary(
        sourceSurface: String,
        childDraftReferenceReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        referenceImageAccepted: Bool,
        generatedAssets: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartChildDraftLineageCueAcceptanceGate=v1;source:\(sourceSurface);referenceReady:\(childDraftReferenceReady);manualArtReview:\(manualArtDirectionReviewed);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);referenceImageAccepted:\(referenceImageAccepted);generatedAssets:\(generatedAssets);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartChildDraftLineageCueAcceptanceGateFields(
        sourceSurface: String,
        childDraftReferenceReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        referenceImageAccepted: Bool,
        generatedAssets: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        sourceSurface == "genomeVariationChildDraft"
            && childDraftReferenceReady
            && !manualArtDirectionReviewed
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !referenceImageAccepted
            && !generatedAssets
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartChildDraftLineageCueAcceptanceGateReadinessSummary(isReady: Bool) -> String {
        "fixedPartChildDraftLineageCueAcceptanceGateReady:\(isReady)"
    }

    public static func fixedPartLineageCueSetReferenceSheetSummary(
        cueSetID: String,
        cueAnnotations: [String],
        requiredPanels: [String],
        socketMappings: [String],
        grayscaleOnly: Bool,
        excludesColorPatternGlow: Bool,
        geometryGenerated: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartLineageCueSetReferenceSheet=v1;cueSet:\(cueSetID);annotations:\(cueAnnotations.joined(separator: ","));panels:\(requiredPanels.joined(separator: ","));sockets:\(socketMappings.joined(separator: ","));grayscaleOnly:\(grayscaleOnly);excludesColorPatternGlow:\(excludesColorPatternGlow);geometryGenerated:\(geometryGenerated);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartLineageCueSetReferenceSheetFields(
        cueSetID: String,
        cueAnnotations: [String],
        requiredPanels: [String],
        socketMappings: [String],
        grayscaleOnly: Bool,
        excludesColorPatternGlow: Bool,
        geometryGenerated: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let panelSet = Set(requiredPanels)
        let annotationSummary = cueAnnotations.joined(separator: ",")

        return cueSetID == "softLineageCueSet"
            && cueAnnotations.count >= 3
            && cueAnnotations.allSatisfy { !$0.isEmpty && $0.contains("#lineageCue") }
            && annotationSummary.contains("softAncestralGlint")
            && annotationSummary.contains("softTailMemoryDots")
            && annotationSummary.contains("softLineageMemoryThread")
            && panelSet.isSuperset(of: ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "lineageCue"])
            && socketMappings.contains("bodyCenter->body")
            && socketMappings.contains("tailRoot->tail_1")
            && grayscaleOnly
            && excludesColorPatternGlow
            && !geometryGenerated
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartLineageCueSetReferenceSheetReadinessSummary(isReady: Bool) -> String {
        "fixedPartLineageCueSetReferenceSheetReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetPanelLayoutSummary(
        cueSetID: String,
        panelRoles: [String],
        readingOrder: [String],
        requiredCallouts: [String],
        generatedReferenceSheet: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetPanelLayout=v1;cueSet:\(cueSetID);panels:\(panelRoles.joined(separator: ","));order:\(readingOrder.joined(separator: ">"));callouts:\(requiredCallouts.joined(separator: ","));generatedReferenceSheet:\(generatedReferenceSheet);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetPanelLayoutFields(
        cueSetID: String,
        panelRoles: [String],
        readingOrder: [String],
        requiredCallouts: [String],
        generatedReferenceSheet: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let roleSet = Set(panelRoles)
        let requiredPanelSet: Set<String> = [
            "frontView:silhouette",
            "sideView:depth",
            "threeQuarterView:volume",
            "socketDiagram:bodyTailSockets",
            "rigDiagram:CommonPetRig",
            "lineageCue:softLineageCueSet"
        ]
        let calloutSet = Set(requiredCallouts)

        return cueSetID == "softLineageCueSet"
            && roleSet.isSuperset(of: requiredPanelSet)
            && readingOrder == ["frontView", "sideView", "threeQuarterView", "socketDiagram", "rigDiagram", "lineageCue"]
            && calloutSet.isSuperset(of: ["cuteSilhouette", "bodyCenter", "tailRoot", "CommonPetRig", "noColorPatternGlow", "noGeneratedGeometry"])
            && !generatedReferenceSheet
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetPanelLayoutReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetPanelLayoutReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetAcceptanceGateSummary(
        cueSetID: String,
        lineageReferenceReady: Bool,
        panelLayoutReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        generatedReferenceSheet: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetAcceptanceGate=v1;cueSet:\(cueSetID);lineageReferenceReady:\(lineageReferenceReady);panelLayoutReady:\(panelLayoutReady);manualArtReview:\(manualArtDirectionReviewed);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);generatedReferenceSheet:\(generatedReferenceSheet);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetAcceptanceGateFields(
        cueSetID: String,
        lineageReferenceReady: Bool,
        panelLayoutReady: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        generatedReferenceSheet: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        cueSetID == "softLineageCueSet"
            && lineageReferenceReady
            && panelLayoutReady
            && !manualArtDirectionReviewed
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !generatedReferenceSheet
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetAcceptanceGateReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetAcceptanceGateReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetArtifactNamingSummary(
        artifactStem: String,
        relativePath: String,
        format: String,
        surface: String,
        cueSetID: String,
        generatedReferenceSheet: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetArtifactNaming=v1;stem:\(artifactStem);path:\(relativePath);format:\(format);surface:\(surface);cueSet:\(cueSetID);generatedReferenceSheet:\(generatedReferenceSheet);manualArtReview:\(manualArtDirectionReviewed);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetArtifactNamingFields(
        artifactStem: String,
        relativePath: String,
        format: String,
        surface: String,
        cueSetID: String,
        generatedReferenceSheet: Bool,
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !artifactStem.isEmpty
            && artifactStem == "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
            && relativePath == "docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png"
            && format == "png"
            && surface == "fixedPartReferenceSheet"
            && cueSetID == "softLineageCueSet"
            && !generatedReferenceSheet
            && !manualArtDirectionReviewed
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetArtifactNamingReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetArtifactNamingReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetManualReviewChecklistSummary(
        artifactStem: String,
        reviewerRole: String,
        checklistItems: [String],
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetManualReviewChecklist=v1;stem:\(artifactStem);reviewer:\(reviewerRole);items:\(checklistItems.joined(separator: ","));manualArtReview:\(manualArtDirectionReviewed);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetManualReviewChecklistFields(
        artifactStem: String,
        reviewerRole: String,
        checklistItems: [String],
        manualArtDirectionReviewed: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let itemSet = Set(checklistItems)
        let requiredItems: Set<String> = [
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

        return artifactStem == "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
            && reviewerRole == "CreatureArtDirector"
            && itemSet.isSuperset(of: requiredItems)
            && !manualArtDirectionReviewed
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetManualReviewChecklistReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetManualReviewChecklistReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetManualReviewResultStateSummary(
        artifactStem: String,
        currentState: String,
        allowedStates: [String],
        reviewerRole: String,
        manualArtDirectionReviewed: Bool,
        revisionRequired: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetManualReviewResultState=v1;stem:\(artifactStem);state:\(currentState);allowed:\(allowedStates.joined(separator: ","));reviewer:\(reviewerRole);manualArtReview:\(manualArtDirectionReviewed);revisionRequired:\(revisionRequired);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetManualReviewResultStateFields(
        artifactStem: String,
        currentState: String,
        allowedStates: [String],
        reviewerRole: String,
        manualArtDirectionReviewed: Bool,
        revisionRequired: Bool,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let stateSet = Set(allowedStates)

        return artifactStem == "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
            && currentState == "notStarted"
            && stateSet.isSuperset(of: ["notStarted", "needsRevision", "accepted"])
            && reviewerRole == "CreatureArtDirector"
            && !manualArtDirectionReviewed
            && !revisionRequired
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetManualReviewResultStateReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetManualReviewResultStateReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetReviewEvidenceFieldsSummary(
        artifactStem: String,
        evidenceFields: [String],
        evidenceRecorded: Bool,
        evidencePath: String,
        reviewerNote: String,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetReviewEvidenceFields=v1;stem:\(artifactStem);fields:\(evidenceFields.joined(separator: ","));evidenceRecorded:\(evidenceRecorded);evidencePath:\(evidencePath);reviewerNote:\(reviewerNote);snapshotAccepted:\(snapshotReferenceAccepted);generationAllowed:\(generationAllowed);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetReviewEvidenceFields(
        artifactStem: String,
        evidenceFields: [String],
        evidenceRecorded: Bool,
        evidencePath: String,
        reviewerNote: String,
        snapshotReferenceAccepted: Bool,
        generationAllowed: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        let fieldSet = Set(evidenceFields)
        let requiredFields: Set<String> = [
            "artifactPath",
            "reviewerNote",
            "checkedItems",
            "visualQAImage",
            "snapshotReference",
            "decisionReason"
        ]

        return artifactStem == "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
            && fieldSet.isSuperset(of: requiredFields)
            && !evidenceRecorded
            && evidencePath.isEmpty
            && reviewerNote.isEmpty
            && !snapshotReferenceAccepted
            && !generationAllowed
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetReviewEvidenceFieldsReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetReviewEvidenceFieldsReady:\(isReady)"
    }

    public static func fixedPartReferenceSheetPNGCandidatePreflightSummary(
        artifactStem: String,
        artifactNamingReady: Bool,
        manualChecklistReady: Bool,
        manualReviewStateReady: Bool,
        reviewEvidenceFieldsReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String
    ) -> String {
        "fixedPartReferenceSheetPNGCandidatePreflight=v1;stem:\(artifactStem);artifactNamingReady:\(artifactNamingReady);manualChecklistReady:\(manualChecklistReady);manualReviewStateReady:\(manualReviewStateReady);reviewEvidenceFieldsReady:\(reviewEvidenceFieldsReady);candidateExists:\(candidateExists);generationAllowed:\(generationAllowed);snapshotAccepted:\(snapshotReferenceAccepted);runtimeLoaded:\(runtimeLoaded);assetOutputs:\(assetOutputs)"
    }

    public static func hasFixedPartReferenceSheetPNGCandidatePreflightFields(
        artifactStem: String,
        artifactNamingReady: Bool,
        manualChecklistReady: Bool,
        manualReviewStateReady: Bool,
        reviewEvidenceFieldsReady: Bool,
        candidateExists: Bool,
        generationAllowed: Bool,
        snapshotReferenceAccepted: Bool,
        runtimeLoaded: Bool,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        artifactStem == "wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1"
            && artifactNamingReady
            && manualChecklistReady
            && manualReviewStateReady
            && reviewEvidenceFieldsReady
            && !candidateExists
            && !generationAllowed
            && !snapshotReferenceAccepted
            && !runtimeLoaded
            && assetOutputs == "none"
            && !summary.isEmpty
    }

    public static func fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceSheetPNGCandidatePreflightReady:\(isReady)"
    }

    public static func fixedPartReferenceCoverageSummary(
        faceBases: [String],
        bodyBases: [String],
        wingBases: [String],
        tailBases: [String],
        optionalValidBases: [String],
        missingFaceBases: [String],
        missingWingBases: [String],
        missingTailBases: [String],
        missingUpperBodyIntent: String,
        missingHornIntent: String,
        missingEarIntent: String,
        missingCrystalIntent: String,
        missingGlowIntent: String
    ) -> String {
        "fixedPart2DReferenceCoverage=face:\(faceBases.count)/\(faceBases.count)(\(faceBases.joined(separator: ",")));body:\(bodyBases.count)/\(bodyBases.count)(\(bodyBases.joined(separator: ",")));wing:\(wingBases.count)/\(wingBases.count)(\(wingBases.joined(separator: ",")));tail:\(tailBases.count)/\(tailBases.count)(\(tailBases.joined(separator: ",")));optionalValid=\(optionalValidBases.joined(separator: ","));missingIntent=face(\(missingFaceBases.joined(separator: ",")));wing(\(missingWingBases.joined(separator: ",")));tail(\(missingTailBases.joined(separator: ",")));upperBody:\(missingUpperBodyIntent);horn:\(missingHornIntent);ear:\(missingEarIntent);crystal:\(missingCrystalIntent);glow:\(missingGlowIntent)"
    }

    public static func hasFixedPartReferenceCoverageFields(
        faceBases: [String],
        bodyBases: [String],
        wingBases: [String],
        tailBases: [String],
        optionalValidBases: [String],
        missingFaceBases: [String],
        missingWingBases: [String],
        missingTailBases: [String],
        missingUpperBodyIntent: String,
        missingHornIntent: String,
        missingEarIntent: String,
        missingCrystalIntent: String,
        missingGlowIntent: String,
        summary: String
    ) -> Bool {
        !faceBases.isEmpty
            && !bodyBases.isEmpty
            && !wingBases.isEmpty
            && !tailBases.isEmpty
            && !optionalValidBases.isEmpty
            && !missingUpperBodyIntent.isEmpty
            && !missingHornIntent.isEmpty
            && !missingEarIntent.isEmpty
            && !missingCrystalIntent.isEmpty
            && !missingGlowIntent.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPartReferenceCoverageReadinessSummary(isReady: Bool) -> String {
        "fixedPartReferenceCoverageMetadataReady:\(isReady)"
    }

    public static func fixedPartCatalogArtDirectionSummary(
        familyIDs: [String],
        silhouetteIntents: [String],
        affectionCues: [String],
        assetOutputs: String,
        geometryChanged: Bool
    ) -> String {
        "fixedPartCatalogArtDirection=families:\(familyIDs.joined(separator: ","));silhouette:\(silhouetteIntents.joined(separator: ","));affection:\(affectionCues.joined(separator: ","));assetOutputs:\(assetOutputs);geometryChanged:\(geometryChanged)"
    }

    public static func hasFixedPartCatalogArtDirectionFields(
        familyIDs: [String],
        silhouetteIntents: [String],
        affectionCues: [String],
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !familyIDs.isEmpty
            && familyIDs.count == silhouetteIntents.count
            && familyIDs.count == affectionCues.count
            && silhouetteIntents.allSatisfy { !$0.isEmpty }
            && affectionCues.allSatisfy { !$0.isEmpty }
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPartCatalogArtDirectionReadinessSummary(isReady: Bool) -> String {
        "fixedPartCatalogArtDirectionReady:\(isReady)"
    }

    public static func fixedPartLineageAffectionSummary(
        familyIDs: [String],
        affectionCues: [String],
        ancestorContext: String,
        assetOutputs: String,
        playerFacing: Bool
    ) -> String {
        "fixedPartLineageAffection=families:\(familyIDs.joined(separator: ","));affection:\(affectionCues.joined(separator: ","));ancestor:\(ancestorContext);assetOutputs:\(assetOutputs);playerFacing:\(playerFacing)"
    }

    public static func hasFixedPartLineageAffectionFields(
        familyIDs: [String],
        affectionCues: [String],
        ancestorContext: String,
        assetOutputs: String,
        summary: String
    ) -> Bool {
        !familyIDs.isEmpty
            && familyIDs.count == affectionCues.count
            && affectionCues.allSatisfy { !$0.isEmpty }
            && !ancestorContext.isEmpty
            && !assetOutputs.isEmpty
            && !summary.isEmpty
    }

    public static func fixedPartLineageAffectionReadinessSummary(isReady: Bool) -> String {
        "fixedPartLineageAffectionReady:\(isReady)"
    }
}
