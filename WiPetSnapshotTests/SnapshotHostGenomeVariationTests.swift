import SnapshotTesting
import UIKit
import XCTest

final class SnapshotHostGenomeVariationTests: XCTestCase {
    @MainActor
    func testHornBudPreviewHostExposesVisibleRoundedBudCue() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-horn-bud"]
        app.launch()

        let readiness = app.staticTexts["observationSpriteKitGrowthHornBudCueReadinessSummary"]
        XCTAssertTrue(readiness.waitForExistence(timeout: 12))
        XCTAssertEqual(readiness.label, "spriteKitGrowthHornBudCueReady:true")

        let summary = app.staticTexts["observationSpriteKitGrowthHornBudCueSummary"]
        XCTAssertTrue(summary.waitForExistence(timeout: 2))
        XCTAssertTrue(summary.label.contains("gene:hornGrowth"))
        XCTAssertTrue(summary.label.contains("bud:tinyRoundedBud"))
        XCTAssertTrue(summary.label.contains("softness:rounded"))
        XCTAssertTrue(summary.label.contains("visible:true"))
        XCTAssertTrue(summary.label.contains("assetOutputs:none"))

        let detailReadiness = app.staticTexts["observationGrowthHornBudDetailRecipeCoverageReadinessSummary"]
        XCTAssertTrue(detailReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(detailReadiness.label, "growthHornBudDetailRecipeCoverageReady:true")

        let detailSummary = app.staticTexts["observationGrowthHornBudDetailRecipeCoverageSummary"]
        XCTAssertTrue(detailSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(detailSummary.label.contains("tinyRoundedHornBud"))
        XCTAssertTrue(detailSummary.label.contains("catalog:true"))

        let screenshot = app.windows.firstMatch.screenshot().image
        XCTAssertGreaterThan(screenshot.size.width, 0)
        XCTAssertGreaterThan(screenshot.size.height, 0)
        try assertReferenceDeviceImageSnapshot(
            of: screenshot.croppingStatusBarForSnapshot(),
            named: "horn-bud-preview-reference"
        )
    }

    @MainActor
    func testCrescentHornBudPreviewHostExposesGrownRoundedBudCue() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-crescent-horn-bud"]
        app.launch()

        let readiness = app.staticTexts["observationSpriteKitGrowthHornBudCueReadinessSummary"]
        XCTAssertTrue(readiness.waitForExistence(timeout: 12))
        XCTAssertEqual(readiness.label, "spriteKitGrowthHornBudCueReady:true")

        let summary = app.staticTexts["observationSpriteKitGrowthHornBudCueSummary"]
        XCTAssertTrue(summary.waitForExistence(timeout: 2))
        XCTAssertTrue(summary.label.contains("gene:hornGrowth"))
        XCTAssertTrue(summary.label.contains("bud:softCrescentBud"))
        XCTAssertTrue(summary.label.contains("stage:adult"))
        XCTAssertTrue(summary.label.contains("softness:rounded"))
        XCTAssertTrue(summary.label.contains("visible:true"))
        XCTAssertTrue(summary.label.contains("assetOutputs:none"))

        let detailReadiness = app.staticTexts["observationGrowthHornBudDetailRecipeCoverageReadinessSummary"]
        XCTAssertTrue(detailReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(detailReadiness.label, "growthHornBudDetailRecipeCoverageReady:true")

        let detailSummary = app.staticTexts["observationGrowthHornBudDetailRecipeCoverageSummary"]
        XCTAssertTrue(detailSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(detailSummary.label.contains("tinyRoundedHornBud"))
        XCTAssertTrue(detailSummary.label.contains("catalog:true"))

        let screenshot = app.windows.firstMatch.screenshot().image
        XCTAssertGreaterThan(screenshot.size.width, 0)
        XCTAssertGreaterThan(screenshot.size.height, 0)
    }

    @MainActor
    func testGrowthCeremonyHornBudPreviewUsesSpecificNoticedLineWithoutCommitting() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-growth-ceremony-horn-bud-preview"]
        app.launch()

        let hornBudCue = app.staticTexts["observationSpriteKitGrowthHornBudCueSummary"]
        XCTAssertTrue(hornBudCue.waitForExistence(timeout: 12))
        XCTAssertTrue(hornBudCue.label.contains("bud:tinyRoundedBud"))
        XCTAssertTrue(hornBudCue.label.contains("visible:true"))

        let pendingLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertFalse(pendingLine.exists)

        let comparisonLine = app.staticTexts["growthBeforeAfterComparisonVisibleLine"]
        XCTAssertTrue(comparisonLine.waitForExistence(timeout: 2))
        XCTAssertEqual(comparisonLine.label, "Watch the soft crescent buds before deciding together.")

        let acknowledgementButton = app.buttons["growthObservationAcknowledgementButton"]
        XCTAssertTrue(acknowledgementButton.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgementButton.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgementButton.label.contains("mutation:false"))
        tapElementWhenVisible(acknowledgementButton, in: app, fallbackLabel: "Notice together")

        let noticedLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertTrue(noticedLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            noticedLine.label,
            "The tiny rounded bud can wait here as a quiet growth memory."
        )

        let noticedSummary = app.staticTexts["growthNoticedMemoryLineSummary"]
        XCTAssertTrue(noticedSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(noticedSummary.label.contains("acknowledged:true"))
        XCTAssertTrue(noticedSummary.label.contains("display:true"))
        XCTAssertTrue(noticedSummary.label.contains("write:false"))
        XCTAssertTrue(noticedSummary.label.contains("mutation:false"))
        XCTAssertTrue(noticedSummary.label.contains("widget:false"))
        XCTAssertTrue(noticedSummary.label.contains("discovery:false"))

        let persistenceSummary = app.staticTexts["growthPersistenceBoundarySummary"]
        XCTAssertTrue(persistenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(persistenceSummary.label.contains("write:false"))
        XCTAssertTrue(persistenceSummary.label.contains("mutatesCreature:false"))
        XCTAssertTrue(persistenceSummary.label.contains("widget:false"))
    }

    @MainActor
    func testGrowthCeremonyCrescentHornPreviewUsesSpecificNoticedLineWithoutCommitting() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-growth-ceremony-crescent-horn-preview"]
        app.launch()

        let hornBudCue = app.staticTexts["observationSpriteKitGrowthHornBudCueSummary"]
        XCTAssertTrue(hornBudCue.waitForExistence(timeout: 12))
        XCTAssertTrue(hornBudCue.label.contains("bud:softCrescentBud"))
        XCTAssertTrue(hornBudCue.label.contains("stage:elder"))
        XCTAssertTrue(hornBudCue.label.contains("visible:true"))

        let pendingLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertFalse(pendingLine.exists)

        let comparisonLine = app.staticTexts["growthBeforeAfterComparisonVisibleLine"]
        XCTAssertTrue(comparisonLine.waitForExistence(timeout: 2))
        XCTAssertEqual(comparisonLine.label, "Watch the soft crescent buds before deciding together.")

        let acknowledgementButton = app.buttons["growthObservationAcknowledgementButton"]
        XCTAssertTrue(acknowledgementButton.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgementButton.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgementButton.label.contains("mutation:false"))
        tapElementWhenVisible(acknowledgementButton, in: app, fallbackLabel: "Notice together")

        let acknowledgedButton = app.buttons["growthObservationAcknowledgementButton"]
        XCTAssertTrue(acknowledgedButton.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedButton.label.contains("noted:true"))
        XCTAssertTrue(acknowledgedButton.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgedButton.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("persistence:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("discovery:false"))

        let noticedLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertTrue(noticedLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            noticedLine.label,
            "The soft crescent buds can wait here as a quiet growth memory."
        )

        let noticedSummary = app.staticTexts["growthNoticedMemoryLineSummary"]
        XCTAssertTrue(noticedSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(noticedSummary.label.contains("acknowledged:true"))
        XCTAssertTrue(noticedSummary.label.contains("display:true"))
        XCTAssertTrue(noticedSummary.label.contains("write:false"))
        XCTAssertTrue(noticedSummary.label.contains("mutation:false"))
        XCTAssertTrue(noticedSummary.label.contains("widget:false"))
        XCTAssertTrue(noticedSummary.label.contains("discovery:false"))

        let prioritySummary = app.staticTexts["growthNoticedMemoryPrioritySummary"]
        XCTAssertTrue(prioritySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(prioritySummary.label.contains("selected:softCrescentBud"))
        XCTAssertTrue(prioritySummary.label.contains("candidates:softCrescentBud+softTailTipGlint+crescentBelly"))
        XCTAssertTrue(prioritySummary.label.contains("visibleCopyChanged:false"))

        let persistenceSummary = app.staticTexts["growthPersistenceBoundarySummary"]
        XCTAssertTrue(persistenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(persistenceSummary.label.contains("write:false"))
        XCTAssertTrue(persistenceSummary.label.contains("mutatesCreature:false"))
        XCTAssertTrue(persistenceSummary.label.contains("widget:false"))

        let ceremonySnapshot = """
            GrowthCeremonyCrescentHornSurface
            hornBudCue:\(hornBudCue.label)
            comparisonLine:\(comparisonLine.label)
            acknowledgement:\(acknowledgedButton.label)
            noticedMemoryLine:\(noticedLine.label)
            \(noticedSummary.label)
            \(prioritySummary.label)
            \(persistenceSummary.label)
            """ + "\n"

        assertSnapshot(
            of: ceremonySnapshot,
            as: .lines,
            named: "growth-ceremony-crescent-horn-surface"
        )

        try assertReferenceDeviceImageSnapshot(
            of: app.windows.firstMatch.screenshot().image.croppingStatusBarForSnapshot(),
            named: "growth-ceremony-crescent-horn-reference"
        )
    }

    @MainActor
    func testGenomeVariationSnapshotHostExposesTargetEntryReadiness() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-genome-variation"]
        app.launch()

        let readiness = app.staticTexts["snapshotAppTargetEntryReadinessSummary"]
        XCTAssertTrue(readiness.waitForExistence(timeout: 12))
        XCTAssertEqual(readiness.label, "snapshotAppTargetEntryReady:true")

        let summary = app.staticTexts["snapshotAppTargetEntrySummary"]
        XCTAssertTrue(summary.waitForExistence(timeout: 2))
        XCTAssertTrue(summary.label.contains("target:WiPetSnapshotTests"))
        XCTAssertTrue(summary.label.contains("referenceImage:false"))
        XCTAssertTrue(summary.label.contains("imageAssertion:false"))

        let recipeReadiness = app.staticTexts["fixedPartShapeRecipeCoverageReadinessSummary"]
        XCTAssertTrue(recipeReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(recipeReadiness.label, "fixedPartShapeRecipeCoverageReady:true")

        let recipeSummary = app.staticTexts["fixedPartShapeRecipeCoverageSummary"]
        XCTAssertTrue(recipeSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(recipeSummary.label.contains("softLunarWing"))
        XCTAssertTrue(recipeSummary.label.contains("softLeafWing"))
        XCTAssertTrue(recipeSummary.label.contains("child{shapeRecipeCoverage=recipes:softLeafWing,softLeafWing"))
        XCTAssertTrue(recipeSummary.label.contains("softLeafWing,softLeafWing,fishTaperTail"))
        XCTAssertTrue(recipeSummary.label.contains("softDeerHead"))
        XCTAssertTrue(recipeSummary.label.contains("catalog:true"))

        let detailReadiness = app.staticTexts["fixedPartDetailRecipeCoverageReadinessSummary"]
        XCTAssertTrue(detailReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(detailReadiness.label, "fixedPartDetailRecipeCoverageReady:true")

        let detailSummary = app.staticTexts["fixedPartDetailRecipeCoverageSummary"]
        XCTAssertTrue(detailSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(detailSummary.label.contains("crescentBelly"))
        XCTAssertTrue(detailSummary.label.contains("softVein"))
        XCTAssertTrue(detailSummary.label.contains("child{detailRecipeCoverage=recipes:softVein,softWingTipPearl"))
        XCTAssertTrue(detailSummary.label.contains("softWingTipPearl,fishFin,softForkFin"))
        XCTAssertTrue(detailSummary.label.contains("softForkFin"))
        XCTAssertTrue(detailSummary.label.contains("softWhiskerDots"))
        XCTAssertTrue(detailSummary.label.contains("forestDots"))
        XCTAssertTrue(detailSummary.label.contains("softCatchlight"))
        XCTAssertTrue(detailSummary.label.contains("catalog:true"))

        let accessoryBridgeReadiness = app.staticTexts["fixedPartAccessoryRecipeBridgeReadinessSummary"]
        XCTAssertTrue(accessoryBridgeReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(accessoryBridgeReadiness.label, "fixedPartAccessoryRecipeBridgeReady:true")

        let accessoryBridgeSummary = app.staticTexts["fixedPartAccessoryRecipeBridgeSummary"]
        XCTAssertTrue(accessoryBridgeSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("softWingTipPearl"))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("softForkFin"))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("softDrakeRidge"))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("futureTargets:FaceAccessory,UpperBodyAccessory,WingAccessory,TailAccessory"))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("assetOutputs:none"))
        XCTAssertTrue(accessoryBridgeSummary.label.contains("geometryChanged:false"))

        let accessoryReferenceReadiness = app.staticTexts["fixedPartAccessoryReferenceAnnotationReadinessSummary"]
        XCTAssertTrue(accessoryReferenceReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(accessoryReferenceReadiness.label, "fixedPartAccessoryReferenceAnnotationReady:true")

        let accessoryReferenceSummary = app.staticTexts["fixedPartAccessoryReferenceAnnotationSummary"]
        XCTAssertTrue(accessoryReferenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(accessoryReferenceSummary.label.contains("softWingTipPearl->WingBase.fairy@wingTip#accessoryCue"))
        XCTAssertTrue(accessoryReferenceSummary.label.contains("softForkFin->TailBase.fish@tailTip#accessoryCue"))
        XCTAssertTrue(accessoryReferenceSummary.label.contains("softDrakeRidge->TailBase.dragon@tailTip#accessoryCue"))
        XCTAssertTrue(accessoryReferenceSummary.label.contains("panels:accessoryCue,socketDiagram,rigDiagram"))
        XCTAssertTrue(accessoryReferenceSummary.label.contains("generatedAssets:false"))

        let accessoryPreflightReadiness = app.staticTexts["fixedPartAccessoryReferenceSheetPreflightReadinessSummary"]
        XCTAssertTrue(accessoryPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(accessoryPreflightReadiness.label, "fixedPartAccessoryReferenceSheetPreflightReady:true")

        let accessoryPreflightSummary = app.staticTexts["fixedPartAccessoryReferenceSheetPreflightSummary"]
        XCTAssertTrue(accessoryPreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(accessoryPreflightSummary.label.contains("accessoryReferenceReady:true"))
        XCTAssertTrue(accessoryPreflightSummary.label.contains("generationAllowed:false"))
        XCTAssertTrue(accessoryPreflightSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(accessoryPreflightSummary.label.contains("assetOutputs:none"))

        let accessoryPanelNotesReadiness = app.staticTexts["fixedPartAccessoryReferenceSheetPanelNotesReadinessSummary"]
        XCTAssertTrue(accessoryPanelNotesReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(accessoryPanelNotesReadiness.label, "fixedPartAccessoryReferenceSheetPanelNotesReady:true")

        let accessoryPanelNotesSummary = app.staticTexts["fixedPartAccessoryReferenceSheetPanelNotesSummary"]
        XCTAssertTrue(accessoryPanelNotesSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softEarNubs:FaceBase.deer@headCenter:roundedEarNubs"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softEarTips:FaceBase.feline@headCenter:softPetalEarTips"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softShoulderPetals:UpperBody.sylphian@bodyCenter:pairedSoftShoulderPetals"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softWingTipPearl:WingBase.fairy@wingTip:tinyRoundedPearl"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softForkFin:TailBase.fish@tailTip:softForkedFin"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softDrakeRidge:TailBase.dragon@tailTip:softRoundedRidge"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("softMoonShoulderCrescents:UpperBody.lunarian@bodyCenter:pairedShoulderCrescents"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("frontView,sideView,threeQuarterView,socketDiagram,rigDiagram,accessoryCue"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("grayscaleOnly:true"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("noColorPatternGlow:true"))
        XCTAssertTrue(accessoryPanelNotesSummary.label.contains("generatedAssets:false"))

        let screenshot = app.windows.firstMatch.screenshot().image

        let glowReadiness = app.staticTexts["glowAmbientRecipeCoverageReadinessSummary"]
        XCTAssertTrue(glowReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(glowReadiness.label, "glowAmbientRecipeCoverageReady:true")

        let glowSummary = app.staticTexts["glowAmbientRecipeCoverageSummary"]
        XCTAssertTrue(glowSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(glowSummary.label.contains("softGlowRing"))
        XCTAssertTrue(glowSummary.label.contains("quietGlowMotes"))
        XCTAssertTrue(glowSummary.label.contains("catalog:true"))

        let patternReadiness = app.staticTexts["patternRecipeCoverageReadinessSummary"]
        XCTAssertTrue(patternReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(patternReadiness.label, "patternRecipeCoverageReady:true")

        let patternSummary = app.staticTexts["patternRecipeCoverageSummary"]
        XCTAssertTrue(patternSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(patternSummary.label.contains("softBellyDapples"))
        XCTAssertTrue(patternSummary.label.contains("catalog:true"))

        let patternCueSummary = app.staticTexts["spriteKitPatternMarkingCueSummary"]
        XCTAssertTrue(patternCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(patternCueSummary.label.contains("spread:"))
        XCTAssertTrue(patternCueSummary.label.contains("assetOutputs:none"))

        let coreImagePreflightReadiness = app.staticTexts["coreImagePatternGenerationPreflightReadinessSummary"]
        XCTAssertTrue(coreImagePreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(coreImagePreflightReadiness.label, "coreImagePatternGenerationPreflightReady:true")

        let coreImagePreflightSummary = app.staticTexts["coreImagePatternGenerationPreflightSummary"]
        XCTAssertTrue(coreImagePreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("surface:GenomeVariation"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("candidate:CoreImage"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("inputs:mask+glow+noise+cppnPrecursor"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("handmadeVocabulary:true"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("snapshotBaseline:true"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("preservesSilhouette:true"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("externalDependency:false"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("packageEdited:false"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("projectEdited:false"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("rendererChanged:false"))
        XCTAssertTrue(coreImagePreflightSummary.label.contains("assetOutputs:none"))

        let bodyProportionReadiness = app.staticTexts["spriteKitBodyProportionCueReadinessSummary"]
        XCTAssertTrue(bodyProportionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(bodyProportionReadiness.label, "spriteKitBodyProportionCueReady:true")

        let bodyProportionSummary = app.staticTexts["spriteKitBodyProportionCueSummary"]
        XCTAssertTrue(bodyProportionSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(bodyProportionSummary.label.contains("body:moonOval"))
        XCTAssertTrue(bodyProportionSummary.label.contains("width:moonBalanced"))
        XCTAssertTrue(bodyProportionSummary.label.contains("height:quietOval"))
        XCTAssertTrue(bodyProportionSummary.label.contains("affection:familiarMoonBelly"))
        XCTAssertTrue(bodyProportionSummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(bodyProportionSummary.label.contains("assetOutputs:none"))

        let growthStageCueReadiness = app.staticTexts["spriteKitGrowthStageCueReadinessSummary"]
        XCTAssertTrue(growthStageCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(growthStageCueReadiness.label, "spriteKitGrowthStageCueReady:true")

        let growthStageCueSummary = app.staticTexts["spriteKitGrowthStageCueSummary"]
        XCTAssertTrue(growthStageCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(growthStageCueSummary.label.contains("stage:juvenile"))
        XCTAssertTrue(growthStageCueSummary.label.contains("scale:familiar"))
        XCTAssertTrue(growthStageCueSummary.label.contains("posture:soft"))
        XCTAssertTrue(growthStageCueSummary.label.contains("assetOutputs:none"))

        let siblingBodyProportionReadiness = app.staticTexts["genomeVariationSiblingBodyProportionCueReadinessSummary"]
        XCTAssertTrue(siblingBodyProportionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingBodyProportionReadiness.label, "spriteKitBodyProportionCueReady:true")

        let siblingBodyProportionSummary = app.staticTexts["genomeVariationSiblingBodyProportionCueSummary"]
        XCTAssertTrue(siblingBodyProportionSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("body:seedPetal"))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("width:petalSlim"))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("height:tallSprout"))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("affection:lightFairySeed"))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(siblingBodyProportionSummary.label.contains("assetOutputs:none"))

        let baselineFaceAccentReadiness = app.staticTexts["genomeVariationBaselineFaceAccentReadinessSummary"]
        XCTAssertTrue(baselineFaceAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(baselineFaceAccentReadiness.label, "spriteKitFaceCueAccentReady:true")

        let baselineFaceAccentSummary = app.staticTexts["genomeVariationBaselineFaceAccentSummary"]
        XCTAssertTrue(baselineFaceAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(baselineFaceAccentSummary.label.contains("face:faceted"))
        XCTAssertTrue(baselineFaceAccentSummary.label.contains("accent:softFacet"))
        XCTAssertTrue(baselineFaceAccentSummary.label.contains("dots:0"))
        XCTAssertTrue(baselineFaceAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(baselineFaceAccentSummary.label.contains("assetOutputs:none"))

        let siblingFaceAccentReadiness = app.staticTexts["genomeVariationSiblingFaceAccentReadinessSummary"]
        XCTAssertTrue(siblingFaceAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingFaceAccentReadiness.label, "spriteKitFaceCueAccentReady:true")

        let siblingFaceAccentSummary = app.staticTexts["genomeVariationSiblingFaceAccentSummary"]
        XCTAssertTrue(siblingFaceAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingFaceAccentSummary.label.contains("face:softFeline"))
        XCTAssertTrue(siblingFaceAccentSummary.label.contains("accent:kittenGleam"))
        XCTAssertTrue(siblingFaceAccentSummary.label.contains("dots:0"))
        XCTAssertTrue(siblingFaceAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(siblingFaceAccentSummary.label.contains("assetOutputs:none"))

        let siblingBodyAccentReadiness = app.staticTexts["genomeVariationSiblingBodyAccentReadinessSummary"]
        XCTAssertTrue(siblingBodyAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingBodyAccentReadiness.label, "spriteKitBodyCueAccentReady:true")

        let siblingBodyAccentSummary = app.staticTexts["genomeVariationSiblingBodyAccentSummary"]
        XCTAssertTrue(siblingBodyAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingBodyAccentSummary.label.contains("body:seedPetal"))
        XCTAssertTrue(siblingBodyAccentSummary.label.contains("accent:petalChest"))
        XCTAssertTrue(siblingBodyAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(siblingBodyAccentSummary.label.contains("assetOutputs:none"))

        let siblingWingAccentReadiness = app.staticTexts["genomeVariationSiblingWingAccentReadinessSummary"]
        XCTAssertTrue(siblingWingAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingWingAccentReadiness.label, "spriteKitWingCueAccentReady:true")

        let siblingWingAccentSummary = app.staticTexts["genomeVariationSiblingWingAccentSummary"]
        XCTAssertTrue(siblingWingAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingWingAccentSummary.label.contains("wing:leafPair"))
        XCTAssertTrue(siblingWingAccentSummary.label.contains("accent:softVein"))
        XCTAssertTrue(siblingWingAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(siblingWingAccentSummary.label.contains("assetOutputs:none"))

        let baselineBodyAccentReadiness = app.staticTexts["genomeVariationBaselineBodyAccentReadinessSummary"]
        XCTAssertTrue(baselineBodyAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(baselineBodyAccentReadiness.label, "spriteKitBodyCueAccentReady:true")

        let baselineBodyAccentSummary = app.staticTexts["genomeVariationBaselineBodyAccentSummary"]
        XCTAssertTrue(baselineBodyAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(baselineBodyAccentSummary.label.contains("body:moonOval"))
        XCTAssertTrue(baselineBodyAccentSummary.label.contains("accent:crescentBelly"))
        XCTAssertTrue(baselineBodyAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(baselineBodyAccentSummary.label.contains("assetOutputs:none"))

        let baselineBodyAccessoryReadiness = app.staticTexts["genomeVariationBaselineBodySilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(baselineBodyAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(baselineBodyAccessoryReadiness.label, "spriteKitBodySilhouetteAccessoryReady:true")

        let baselineBodyAccessorySummary = app.staticTexts["genomeVariationBaselineBodySilhouetteAccessorySummary"]
        XCTAssertTrue(baselineBodyAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(baselineBodyAccessorySummary.label.contains("body:moonOval"))
        XCTAssertTrue(baselineBodyAccessorySummary.label.contains("accessory:softMoonShoulderCrescents"))
        XCTAssertTrue(baselineBodyAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(baselineBodyAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(baselineBodyAccessorySummary.label.contains("assetOutputs:none"))

        let siblingFaceAccessoryReadiness = app.staticTexts["genomeVariationSiblingFaceSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(siblingFaceAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingFaceAccessoryReadiness.label, "spriteKitFaceSilhouetteAccessoryReady:true")

        let siblingFaceAccessorySummary = app.staticTexts["genomeVariationSiblingFaceSilhouetteAccessorySummary"]
        XCTAssertTrue(siblingFaceAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingFaceAccessorySummary.label.contains("face:softFeline"))
        XCTAssertTrue(siblingFaceAccessorySummary.label.contains("accessory:softEarTips"))
        XCTAssertTrue(siblingFaceAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(siblingFaceAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(siblingFaceAccessorySummary.label.contains("assetOutputs:none"))

        let siblingBodyAccessoryReadiness = app.staticTexts["genomeVariationSiblingBodySilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(siblingBodyAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingBodyAccessoryReadiness.label, "spriteKitBodySilhouetteAccessoryReady:true")

        let siblingBodyAccessorySummary = app.staticTexts["genomeVariationSiblingBodySilhouetteAccessorySummary"]
        XCTAssertTrue(siblingBodyAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingBodyAccessorySummary.label.contains("body:seedPetal"))
        XCTAssertTrue(siblingBodyAccessorySummary.label.contains("accessory:softShoulderPetals"))
        XCTAssertTrue(siblingBodyAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(siblingBodyAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(siblingBodyAccessorySummary.label.contains("assetOutputs:none"))

        let siblingWingAccessoryReadiness = app.staticTexts["genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(siblingWingAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingWingAccessoryReadiness.label, "spriteKitWingSilhouetteAccessoryReady:true")

        let siblingWingAccessorySummary = app.staticTexts["genomeVariationSiblingWingSilhouetteAccessorySummary"]
        XCTAssertTrue(siblingWingAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingWingAccessorySummary.label.contains("wing:leafPair"))
        XCTAssertTrue(siblingWingAccessorySummary.label.contains("accessory:softWingTipPearl"))
        XCTAssertTrue(siblingWingAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(siblingWingAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(siblingWingAccessorySummary.label.contains("assetOutputs:none"))

        let siblingTailAccessoryReadiness = app.staticTexts["genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(siblingTailAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(siblingTailAccessoryReadiness.label, "spriteKitTailSilhouetteAccessoryReady:true")

        let siblingTailAccessorySummary = app.staticTexts["genomeVariationSiblingTailSilhouetteAccessorySummary"]
        XCTAssertTrue(siblingTailAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(siblingTailAccessorySummary.label.contains("tail:fishFin"))
        XCTAssertTrue(siblingTailAccessorySummary.label.contains("accessory:softForkFin"))
        XCTAssertTrue(siblingTailAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(siblingTailAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(siblingTailAccessorySummary.label.contains("assetOutputs:none"))

        let baselineTailAccessoryReadiness = app.staticTexts["genomeVariationBaselineTailSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(baselineTailAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(baselineTailAccessoryReadiness.label, "spriteKitTailSilhouetteAccessoryReady:true")

        let baselineTailAccessorySummary = app.staticTexts["genomeVariationBaselineTailSilhouetteAccessorySummary"]
        XCTAssertTrue(baselineTailAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(baselineTailAccessorySummary.label.contains("tail:floatingRibbon"))
        XCTAssertTrue(baselineTailAccessorySummary.label.contains("accessory:softTetherDot"))
        XCTAssertTrue(baselineTailAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(baselineTailAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(baselineTailAccessorySummary.label.contains("assetOutputs:none"))

        let dragonTailAccessoryReadiness = app.staticTexts["genomeVariationDragonTailSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(dragonTailAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(dragonTailAccessoryReadiness.label, "spriteKitTailSilhouetteAccessoryReady:true")

        let dragonTailAccessorySummary = app.staticTexts["genomeVariationDragonTailSilhouetteAccessorySummary"]
        XCTAssertTrue(dragonTailAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(dragonTailAccessorySummary.label.contains("tail:longDrake"))
        XCTAssertTrue(dragonTailAccessorySummary.label.contains("accessory:softDrakeRidge"))
        XCTAssertTrue(dragonTailAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(dragonTailAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(dragonTailAccessorySummary.label.contains("assetOutputs:none"))

        let ancestorBodyAccessoryReadiness = app.staticTexts["genomeVariationAncestorBodySilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(ancestorBodyAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(ancestorBodyAccessoryReadiness.label, "spriteKitBodySilhouetteAccessoryReady:true")

        let ancestorBodyAccessorySummary = app.staticTexts["genomeVariationAncestorBodySilhouetteAccessorySummary"]
        XCTAssertTrue(ancestorBodyAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(ancestorBodyAccessorySummary.label.contains("body:leafBelly"))
        XCTAssertTrue(ancestorBodyAccessorySummary.label.contains("accessory:leafShoulderNubs"))
        XCTAssertTrue(ancestorBodyAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(ancestorBodyAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(ancestorBodyAccessorySummary.label.contains("assetOutputs:none"))

        let ancestorTailAccessoryReadiness = app.staticTexts["genomeVariationAncestorTailSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(ancestorTailAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(ancestorTailAccessoryReadiness.label, "spriteKitTailSilhouetteAccessoryReady:true")

        let ancestorTailAccessorySummary = app.staticTexts["genomeVariationAncestorTailSilhouetteAccessorySummary"]
        XCTAssertTrue(ancestorTailAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(ancestorTailAccessorySummary.label.contains("tail:leafSprout"))
        XCTAssertTrue(ancestorTailAccessorySummary.label.contains("accessory:softLeafVein"))
        XCTAssertTrue(ancestorTailAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(ancestorTailAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(ancestorTailAccessorySummary.label.contains("assetOutputs:none"))

        let motionCueReadiness = app.staticTexts["spriteKitMotionGeneCueReadinessSummary"]
        XCTAssertTrue(motionCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(motionCueReadiness.label, "spriteKitMotionGeneCueReady:true")

        let motionCueSummary = app.staticTexts["spriteKitMotionGeneCueSummary"]
        XCTAssertTrue(motionCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(motionCueSummary.label.contains("float:"))
        XCTAssertTrue(motionCueSummary.label.contains("blink:"))
        XCTAssertTrue(motionCueSummary.label.contains("tail:"))
        XCTAssertTrue(motionCueSummary.label.contains("wing:"))
        XCTAssertTrue(motionCueSummary.label.contains("assetOutputs:none"))

        let blinkCueReadiness = app.staticTexts["personalityBlinkCueReadinessSummary"]
        XCTAssertTrue(blinkCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(blinkCueReadiness.label, "personalityBlinkCueReady:true")

        let blinkCueSummary = app.staticTexts["personalityBlinkCueSummary"]
        XCTAssertTrue(blinkCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(blinkCueSummary.label.contains("softQuickBlink"))
        XCTAssertTrue(blinkCueSummary.label.contains("softClose"))
        XCTAssertTrue(blinkCueSummary.label.contains("shortHold"))
        XCTAssertTrue(blinkCueSummary.label.contains("assetOutputs:none"))

        let sleepinessIdleReadiness = app.staticTexts["personalitySleepinessIdleCueReadinessSummary"]
        XCTAssertTrue(sleepinessIdleReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(sleepinessIdleReadiness.label, "personalitySleepinessIdleCueReady:true")

        let sleepinessIdleSummary = app.staticTexts["personalitySleepinessIdleCueSummary"]
        XCTAssertTrue(sleepinessIdleSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(sleepinessIdleSummary.label.contains("cozyRest"))
        XCTAssertTrue(sleepinessIdleSummary.label.contains("softBreath"))
        XCTAssertTrue(sleepinessIdleSummary.label.contains("quietPace"))
        XCTAssertTrue(sleepinessIdleSummary.label.contains("assetOutputs:none"))

        let hornBudReadiness = app.staticTexts["spriteKitGrowthHornBudCueReadinessSummary"]
        XCTAssertTrue(hornBudReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(hornBudReadiness.label, "spriteKitGrowthHornBudCueReady:true")

        let hornBudSummary = app.staticTexts["spriteKitGrowthHornBudCueSummary"]
        XCTAssertTrue(hornBudSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(hornBudSummary.label.contains("gene:hornGrowth"))
        XCTAssertTrue(hornBudSummary.label.contains("bud:dormantBud"))
        XCTAssertTrue(hornBudSummary.label.contains("softness:rounded"))
        XCTAssertTrue(hornBudSummary.label.contains("visible:false"))
        XCTAssertTrue(hornBudSummary.label.contains("assetOutputs:none"))

        let tailTipReadiness = app.staticTexts["spriteKitGrowthTailTipCueReadinessSummary"]
        XCTAssertTrue(tailTipReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(tailTipReadiness.label, "spriteKitGrowthTailTipCueReady:true")

        let tailTipSummary = app.staticTexts["spriteKitGrowthTailTipCueSummary"]
        XCTAssertTrue(tailTipSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(tailTipSummary.label.contains("gene:tailGrowth"))
        XCTAssertTrue(tailTipSummary.label.contains("cue:softTailTipGlint"))
        XCTAssertTrue(tailTipSummary.label.contains("tail:floatingRibbon"))
        XCTAssertTrue(tailTipSummary.label.contains("placement:tailTip"))
        XCTAssertTrue(tailTipSummary.label.contains("visible:true"))
        XCTAssertTrue(tailTipSummary.label.contains("assetOutputs:none"))

        let eyeCueReadiness = app.staticTexts["personalityEyeCueReadinessSummary"]
        XCTAssertTrue(eyeCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(eyeCueReadiness.label, "personalityEyeCueMetadataReady:true")

        let eyeCueSummary = app.staticTexts["personalityEyeCueSummary"]
        XCTAssertTrue(eyeCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(eyeCueSummary.label.contains("openness:"))
        XCTAssertTrue(eyeCueSummary.label.contains("softness:"))
        XCTAssertTrue(eyeCueSummary.label.contains("sparkle:"))

        let eyeGazeReadiness = app.staticTexts["personalityEyeGazeCueReadinessSummary"]
        XCTAssertTrue(eyeGazeReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(eyeGazeReadiness.label, "personalityEyeGazeCueReady:true")

        let eyeGazeSummary = app.staticTexts["personalityEyeGazeCueSummary"]
        XCTAssertTrue(eyeGazeSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(eyeGazeSummary.label.contains("attentiveRightGaze"))
        XCTAssertTrue(eyeGazeSummary.label.contains("assetOutputs:none"))

        let eyeDetailReadiness = app.staticTexts["personalityEyeDetailReadinessSummary"]
        XCTAssertTrue(eyeDetailReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(eyeDetailReadiness.label, "personalityEyeDetailReady:true")

        let eyeDetailSummary = app.staticTexts["personalityEyeDetailSummary"]
        XCTAssertTrue(eyeDetailSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(eyeDetailSummary.label.contains("catchlight:"))
        XCTAssertTrue(eyeDetailSummary.label.contains("placement:"))
        XCTAssertTrue(eyeDetailSummary.label.contains("assetOutputs:none"))

        let cheekWarmthReadiness = app.staticTexts["personalityCheekWarmthCueReadinessSummary"]
        XCTAssertTrue(cheekWarmthReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(cheekWarmthReadiness.label, "personalityCheekWarmthCueReady:true")

        let cheekWarmthSummary = app.staticTexts["personalityCheekWarmthCueSummary"]
        XCTAssertTrue(cheekWarmthSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(cheekWarmthSummary.label.contains("warmth:"))
        XCTAssertTrue(cheekWarmthSummary.label.contains("placement:"))
        XCTAssertTrue(cheekWarmthSummary.label.contains("assetOutputs:none"))

        let mouthCueReadiness = app.staticTexts["personalityMouthCueReadinessSummary"]
        XCTAssertTrue(mouthCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(mouthCueReadiness.label, "personalityMouthCueReady:true")

        let mouthCueSummary = app.staticTexts["personalityMouthCueSummary"]
        XCTAssertTrue(mouthCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(mouthCueSummary.label.contains("softGreetingMouth"))
        XCTAssertTrue(mouthCueSummary.label.contains("settledEnergy"))
        XCTAssertTrue(mouthCueSummary.label.contains("softWidth"))
        XCTAssertTrue(mouthCueSummary.label.contains("assetOutputs:none"))

        let postureCueReadiness = app.staticTexts["personalityPostureCueReadinessSummary"]
        XCTAssertTrue(postureCueReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(postureCueReadiness.label, "personalityPostureCueReady:true")

        let postureCueSummary = app.staticTexts["personalityPostureCueSummary"]
        XCTAssertTrue(postureCueSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(postureCueSummary.label.contains("attentiveLean"))
        XCTAssertTrue(postureCueSummary.label.contains("steadyPresence"))
        XCTAssertTrue(postureCueSummary.label.contains("rightListeningLean"))
        XCTAssertTrue(postureCueSummary.label.contains("assetOutputs:none"))

        let glowAuraReadiness = app.staticTexts["spriteKitGlowAuraCueReadinessSummary"]
        XCTAssertTrue(glowAuraReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(glowAuraReadiness.label, "spriteKitGlowAuraCueReady:true")

        let glowAuraSummary = app.staticTexts["spriteKitGlowAuraCueSummary"]
        XCTAssertTrue(glowAuraSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(glowAuraSummary.label.contains("glow:"))
        XCTAssertTrue(glowAuraSummary.label.contains("aura:"))
        XCTAssertTrue(glowAuraSummary.label.contains("pulse:"))
        XCTAssertTrue(glowAuraSummary.label.contains("motes:"))
        XCTAssertTrue(glowAuraSummary.label.contains("assetOutputs:none"))

        let mysticismAuraReadiness = app.staticTexts["personalityMysticismAuraCueReadinessSummary"]
        XCTAssertTrue(mysticismAuraReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(mysticismAuraReadiness.label, "personalityMysticismAuraCueReady:true")

        let mysticismAuraSummary = app.staticTexts["personalityMysticismAuraCueSummary"]
        XCTAssertTrue(mysticismAuraSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(mysticismAuraSummary.label.contains("moonlitAura"))
        XCTAssertTrue(mysticismAuraSummary.label.contains("deepMysticHalo"))
        XCTAssertTrue(mysticismAuraSummary.label.contains("assetOutputs:none"))

        let ancestralGlintReadiness = app.staticTexts["spriteKitAncestralGlintCueReadinessSummary"]
        XCTAssertTrue(ancestralGlintReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(ancestralGlintReadiness.label, "spriteKitAncestralGlintCueReady:true")

        let ancestralGlintSummary = app.staticTexts["spriteKitAncestralGlintCueSummary"]
        XCTAssertTrue(ancestralGlintSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(ancestralGlintSummary.label.contains("softAncestralGlint"))
        XCTAssertTrue(ancestralGlintSummary.label.contains("placement:upperChest"))
        XCTAssertTrue(ancestralGlintSummary.label.contains("glints:2"))
        XCTAssertTrue(ancestralGlintSummary.label.contains("ancestryLinked:true"))
        XCTAssertTrue(ancestralGlintSummary.label.contains("assetOutputs:none"))

        let childDraftGlintSummary = app.staticTexts["lineageChildDraftAncestralGlintCueSummary"]
        XCTAssertTrue(childDraftGlintSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftGlintSummary.label.contains("softAncestralGlint"))
        XCTAssertTrue(childDraftGlintSummary.label.contains("glints:3"))
        XCTAssertTrue(childDraftGlintSummary.label.contains("active:true"))
        XCTAssertTrue(childDraftGlintSummary.label.contains("assetOutputs:none"))

        let faceLineageEchoReadiness = app.staticTexts["spriteKitFaceLineageEchoCueReadinessSummary"]
        XCTAssertTrue(faceLineageEchoReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(faceLineageEchoReadiness.label, "spriteKitFaceLineageEchoCueReady:true")

        let faceLineageEchoSummary = app.staticTexts["spriteKitFaceLineageEchoCueSummary"]
        XCTAssertTrue(faceLineageEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("softForeheadMemoryDots"))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("face:faceted"))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("placement:forehead"))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("dots:2"))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("ancestryLinked:true"))
        XCTAssertTrue(faceLineageEchoSummary.label.contains("assetOutputs:none"))

        let childDraftFaceLineageEchoSummary = app.staticTexts["lineageChildDraftFaceLineageEchoCueSummary"]
        XCTAssertTrue(childDraftFaceLineageEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("softForeheadMemoryDots"))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("face:softDeer"))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("placement:forehead"))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("dots:2"))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("active:true"))
        XCTAssertTrue(childDraftFaceLineageEchoSummary.label.contains("assetOutputs:none"))

        let childDraftWingLineageEchoSummary = app.staticTexts["lineageChildDraftWingLineageEchoCueSummary"]
        XCTAssertTrue(childDraftWingLineageEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("softWingMemoryTips"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("wing:leafPair"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("accessory:softWingTipPearl"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("placement:wingTips"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("ancestryLinked:true"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("active:true"))
        XCTAssertTrue(childDraftWingLineageEchoSummary.label.contains("assetOutputs:none"))

        let childDraftWingLineageEchoReadiness = app.staticTexts["lineageChildDraftWingLineageEchoCueReadinessSummary"]
        XCTAssertTrue(childDraftWingLineageEchoReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftWingLineageEchoReadiness.label, "spriteKitWingLineageEchoCueReady:true")

        let childDraftWingletVisual = app.staticTexts["lineageChildDraftInheritedWingletVisualSummary"]
        XCTAssertTrue(childDraftWingletVisual.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftWingletVisual.label.contains("baseWing:none"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("renderWing:leafPair"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("accessory:softWingTipPearl"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("inheritedFrom:Mira"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("previewOnly:true"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("persistence:false"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("widget:false"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("breeding:false"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("controls:false"))
        XCTAssertTrue(childDraftWingletVisual.label.contains("assetOutputs:none"))

        let childDraftWingletVisualReadiness = app.staticTexts["lineageChildDraftInheritedWingletVisualReadinessSummary"]
        XCTAssertTrue(childDraftWingletVisualReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftWingletVisualReadiness.label, "lineageChildDraftInheritedWingletVisualReady:true")

        let childDraftTailFinVisual = app.staticTexts["lineageChildDraftInheritedTailFinVisualSummary"]
        XCTAssertTrue(childDraftTailFinVisual.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("baseTail:floatingRibbon"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("renderTail:fishFin"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("accessory:softForkFin"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("inheritedFrom:Mira"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("previewOnly:true"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("persistence:false"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("widget:false"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("breeding:false"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("controls:false"))
        XCTAssertTrue(childDraftTailFinVisual.label.contains("assetOutputs:none"))

        let childDraftTailFinVisualReadiness = app.staticTexts["lineageChildDraftInheritedTailFinVisualReadinessSummary"]
        XCTAssertTrue(childDraftTailFinVisualReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftTailFinVisualReadiness.label, "lineageChildDraftInheritedTailFinVisualReady:true")

        let childDraftVisualPolicy = app.staticTexts["lineageChildDraftInheritedVisualCuePolicySummary"]
        XCTAssertTrue(childDraftVisualPolicy.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("source:genomeVariationQA"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("wing:fairy"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("tail:fish"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("inheritedFrom:Mira"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("previewOnly:true"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("persistence:false"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("widget:false"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("breeding:false"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("controls:false"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("assetOutputs:none"))
        XCTAssertTrue(childDraftVisualPolicy.label.contains("playerFacing:false"))

        let childDraftVisualPolicyReadiness = app.staticTexts["lineageChildDraftInheritedVisualCuePolicyReadinessSummary"]
        XCTAssertTrue(childDraftVisualPolicyReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftVisualPolicyReadiness.label, "lineageChildDraftInheritedVisualCuePolicyReady:true")

        let lineageThreadReadiness = app.staticTexts["spriteKitLineageMemoryThreadReadinessSummary"]
        XCTAssertTrue(lineageThreadReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(lineageThreadReadiness.label, "spriteKitLineageMemoryThreadReady:true")

        let lineageThreadSummary = app.staticTexts["spriteKitLineageMemoryThreadSummary"]
        XCTAssertTrue(lineageThreadSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(lineageThreadSummary.label.contains("softLineageMemoryThread"))
        XCTAssertTrue(lineageThreadSummary.label.contains("body:softAncestralGlint"))
        XCTAssertTrue(lineageThreadSummary.label.contains("tail:softTailMemoryDots"))
        XCTAssertTrue(lineageThreadSummary.label.contains("placement:bodyToTail"))
        XCTAssertTrue(lineageThreadSummary.label.contains("assetOutputs:none"))

        let childDraftThreadSummary = app.staticTexts["lineageChildDraftLineageMemoryThreadSummary"]
        XCTAssertTrue(childDraftThreadSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftThreadSummary.label.contains("softLineageMemoryThread"))
        XCTAssertTrue(childDraftThreadSummary.label.contains("active:true"))
        XCTAssertTrue(childDraftThreadSummary.label.contains("assetOutputs:none"))

        let tailEchoReadiness = app.staticTexts["spriteKitTailLineageEchoCueReadinessSummary"]
        XCTAssertTrue(tailEchoReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(tailEchoReadiness.label, "spriteKitTailLineageEchoCueReady:true")

        let tailEchoSummary = app.staticTexts["spriteKitTailLineageEchoCueSummary"]
        XCTAssertTrue(tailEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(tailEchoSummary.label.contains("softTailMemoryDots"))
        XCTAssertTrue(tailEchoSummary.label.contains("tail:floatingRibbon"))
        XCTAssertTrue(tailEchoSummary.label.contains("placement:tailTip"))
        XCTAssertTrue(tailEchoSummary.label.contains("dots:3"))
        XCTAssertTrue(tailEchoSummary.label.contains("ancestryLinked:true"))
        XCTAssertTrue(tailEchoSummary.label.contains("assetOutputs:none"))

        let childDraftTailEchoSummary = app.staticTexts["lineageChildDraftTailLineageEchoCueSummary"]
        XCTAssertTrue(childDraftTailEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftTailEchoSummary.label.contains("softTailMemoryDots"))
        XCTAssertTrue(childDraftTailEchoSummary.label.contains("active:true"))
        XCTAssertTrue(childDraftTailEchoSummary.label.contains("dots:4"))
        XCTAssertTrue(childDraftTailEchoSummary.label.contains("assetOutputs:none"))

        let childDraftFaceAccentReadiness = app.staticTexts["lineageChildDraftFaceAccentReadinessSummary"]
        XCTAssertTrue(childDraftFaceAccentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftFaceAccentReadiness.label, "spriteKitFaceCueAccentReady:true")

        let childDraftFaceAccentSummary = app.staticTexts["lineageChildDraftFaceAccentSummary"]
        XCTAssertTrue(childDraftFaceAccentSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftFaceAccentSummary.label.contains("face:softDeer"))
        XCTAssertTrue(childDraftFaceAccentSummary.label.contains("accent:forestDots"))
        XCTAssertTrue(childDraftFaceAccentSummary.label.contains("dots:4"))
        XCTAssertTrue(childDraftFaceAccentSummary.label.contains("socketChanged:false"))
        XCTAssertTrue(childDraftFaceAccentSummary.label.contains("assetOutputs:none"))

        let childDraftFaceAccessoryReadiness = app.staticTexts["lineageChildDraftFaceSilhouetteAccessoryReadinessSummary"]
        XCTAssertTrue(childDraftFaceAccessoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftFaceAccessoryReadiness.label, "spriteKitFaceSilhouetteAccessoryReady:true")

        let childDraftFaceAccessorySummary = app.staticTexts["lineageChildDraftFaceSilhouetteAccessorySummary"]
        XCTAssertTrue(childDraftFaceAccessorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftFaceAccessorySummary.label.contains("face:softDeer"))
        XCTAssertTrue(childDraftFaceAccessorySummary.label.contains("accessory:softEarNubs"))
        XCTAssertTrue(childDraftFaceAccessorySummary.label.contains("visible:true"))
        XCTAssertTrue(childDraftFaceAccessorySummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(childDraftFaceAccessorySummary.label.contains("assetOutputs:none"))

        let childDraftInheritedFaceEchoSummary = app.staticTexts["lineageChildDraftInheritedFaceEchoSummary"]
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("ancestor:Ori"))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("face:softDeer"))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("accent:forestDots"))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("dots:4"))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("persistence:false"))
        XCTAssertTrue(childDraftInheritedFaceEchoSummary.label.contains("breeding:false"))

        let ancestorPortraitCueLine = app.staticTexts["genomeVariationAncestorPortraitCueLine"]
        XCTAssertTrue(ancestorPortraitCueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(ancestorPortraitCueLine.label, "soft deer face")

        let childDraftCueSetSummary = app.staticTexts["lineageChildDraftLineageCueSetSummary"]
        XCTAssertTrue(childDraftCueSetSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(childDraftCueSetSummary.label.contains("wing:leafPair"))
        XCTAssertTrue(childDraftCueSetSummary.label.contains("wingAccessory:softWingTipPearl"))
        XCTAssertTrue(childDraftCueSetSummary.label.contains("activeCueCount:5"))
        XCTAssertTrue(childDraftCueSetSummary.label.contains("controls:false"))
        XCTAssertTrue(childDraftCueSetSummary.label.contains("assetOutputs:none"))

        let childDraftCueSetReadiness = app.staticTexts["lineageChildDraftLineageCueSetReadinessSummary"]
        XCTAssertTrue(childDraftCueSetReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(childDraftCueSetReadiness.label, "spriteKitChildDraftLineageCueSetReady:true")

        let referenceSheetPNGPreflightSummary = app.staticTexts["fixedPartReferenceSheetPNGCandidatePreflightSummary"]
        XCTAssertTrue(referenceSheetPNGPreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("artifactNamingReady:true"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("manualChecklistReady:true"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("manualReviewStateReady:true"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("reviewEvidenceFieldsReady:true"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("candidateExists:false"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("generationAllowed:false"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("snapshotAccepted:false"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(referenceSheetPNGPreflightSummary.label.contains("assetOutputs:none"))

        let referenceSheetPNGPreflightReadiness = app.staticTexts["fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary"]
        XCTAssertTrue(referenceSheetPNGPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(referenceSheetPNGPreflightReadiness.label, "fixedPartReferenceSheetPNGCandidatePreflightReady:true")

        let fixedPart3DManifestSummary = app.staticTexts["fixedPart3DManifestSummary"]
        XCTAssertTrue(fixedPart3DManifestSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("assets:wipet_face_round_head_v001"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("wipet_face_deer_head_v001"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("wipet_upperbody_aquarian_baby_v001"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("wipet_wing_plant_pair_v001"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("wipet_tail_floating_tail_v001"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("formats:glb,usd"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("rig:CommonPetRig"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("bones:root,body,spine_1,spine_2,neck,head,wing_L,wing_R,tail_1"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("sockets:bodyCenter->body,headCenter->head,leftWingRoot->wing_L,rightWingRoot->wing_R,tailRoot->tail_1"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("grayscaleOnly:true"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("excludesColorPatternGlow:true"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("validatedAssets:false"))
        XCTAssertTrue(fixedPart3DManifestSummary.label.contains("generatedAssets:false"))

        let fixedPart3DManifestReadiness = app.staticTexts["fixedPart3DManifestReadinessSummary"]
        XCTAssertTrue(fixedPart3DManifestReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(fixedPart3DManifestReadiness.label, "fixedPart3DManifestReady:true")

        let fixedPart3DReferenceGateSummary = app.staticTexts["fixedPart3DReferenceAcceptanceGateSummary"]
        XCTAssertTrue(fixedPart3DReferenceGateSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("cueSet:softLineageCueSet"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("referenceSheetReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("panelLayoutReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("referenceAcceptanceReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("artifactNamingReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("manualReviewChecklistReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("childDraftGateReady:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("modelIODeferred:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("sceneKitDeferred:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("realityKitDeferred:true"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("generationAllowed:false"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("generatedAssets:false"))
        XCTAssertTrue(fixedPart3DReferenceGateSummary.label.contains("assetOutputs:none"))

        let fixedPart3DReferenceGateReadiness = app.staticTexts["fixedPart3DReferenceAcceptanceGateReadinessSummary"]
        XCTAssertTrue(fixedPart3DReferenceGateReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(fixedPart3DReferenceGateReadiness.label, "fixedPart3DReferenceAcceptanceGateReady:true")

        let rigSocketMapSummary = app.staticTexts["commonPetRigSocketMapSummary"]
        XCTAssertTrue(rigSocketMapSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(rigSocketMapSummary.label.contains("rig:CommonPetRig"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("FaceBase:headCenter->head"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("UpperBody:bodyCenter->body"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("WingBase:leftWingRoot+rightWingRoot->wing_L+wing_R"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("TailBase:tailRoot->tail_1"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("assetOutputs:none"))
        XCTAssertTrue(rigSocketMapSummary.label.contains("validated3DAssets:false"))

        let rigSocketMapReadiness = app.staticTexts["commonPetRigSocketMapReadinessSummary"]
        XCTAssertTrue(rigSocketMapReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(rigSocketMapReadiness.label, "commonPetRigSocketMapReady:true")

        let rigAssetValidationPreflightSummary = app.staticTexts["commonPetRigAssetValidationPreflightSummary"]
        XCTAssertTrue(rigAssetValidationPreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("rig:CommonPetRig"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("socketMapReady:true"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("referenceArtifact:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("assetCandidate:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("modelIO:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("sceneKit:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("realityKit:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("validationAllowed:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("deferredSafely:true"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(rigAssetValidationPreflightSummary.label.contains("assetOutputs:none"))

        let rigAssetValidationPreflightReadiness = app.staticTexts["commonPetRigAssetValidationPreflightReadinessSummary"]
        XCTAssertTrue(rigAssetValidationPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(rigAssetValidationPreflightReadiness.label, "commonPetRigAssetValidationPreflightReady:true")

        let hornBaseEvidenceSummary = app.staticTexts["fixedPartHornBaseReferenceEvidenceHandoffSummary"]
        XCTAssertTrue(hornBaseEvidenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("cue:tinyRoundedHornBud"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("sockets:headTopCenter+headTopPair"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("rig:horn_L+horn_R"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("silhouette:roundedNonSharp"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("manualQA:true"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("evidenceRecorded:false"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("geometryGenerated:false"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("snapshotAccepted:false"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(hornBaseEvidenceSummary.label.contains("assetOutputs:none"))

        let hornBaseEvidenceReadiness = app.staticTexts["fixedPartHornBaseReferenceEvidenceHandoffReadinessSummary"]
        XCTAssertTrue(hornBaseEvidenceReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(hornBaseEvidenceReadiness.label, "fixedPartHornBaseReferenceEvidenceHandoffReady:true")

        let upperBodyHandoffSummary = app.staticTexts["fixedPartUpperBodyProportionHandoffSummary"]
        XCTAssertTrue(upperBodyHandoffSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("waterDrop|wideSoft|roundedBelly|gentleWaterPuff->UpperBody.aquarian@bodyCenter#proportionCue"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("moonOval|moonBalanced|quietOval|familiarMoonBelly->UpperBody.lunarian@bodyCenter#proportionCue"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("leafBelly|leafWide|lowSprout|softLeafBelly->UpperBody.verdant@bodyCenter#proportionCue"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("socket:bodyCenter"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("rig:body"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("generatedAssets:false"))
        XCTAssertTrue(upperBodyHandoffSummary.label.contains("assetOutputs:none"))

        let upperBodyHandoffReadiness = app.staticTexts["fixedPartUpperBodyProportionHandoffReadinessSummary"]
        XCTAssertTrue(upperBodyHandoffReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(upperBodyHandoffReadiness.label, "fixedPartUpperBodyProportionHandoffReady:true")

        let tailFloatingHandoffSummary = app.staticTexts["fixedPartTailFloatingHandoffSummary"]
        XCTAssertTrue(tailFloatingHandoffSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("socket:tailRoot"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("rig:tail_1"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("panels:frontView+sideView+threeQuarterView+socketDiagram+rigDiagram+accessoryCue"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("acceptedCue:floatingRibbon+softTetherDot"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("generatedAssets:false"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("runtimeLoaded:false"))
        XCTAssertTrue(tailFloatingHandoffSummary.label.contains("assetOutputs:none"))

        let tailFloatingHandoffReadiness = app.staticTexts["fixedPartTailFloatingHandoffReadinessSummary"]
        XCTAssertTrue(tailFloatingHandoffReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(tailFloatingHandoffReadiness.label, "fixedPartTailFloatingHandoffReady:true")

        let targetEntrySnapshot = """
            SnapshotAppTargetEntry
            \(readiness.label)
            \(summary.label)
            \(recipeReadiness.label)
            \(recipeSummary.label)
            \(detailReadiness.label)
            \(detailSummary.label)
            \(accessoryBridgeReadiness.label)
            \(accessoryBridgeSummary.label)
            \(accessoryReferenceReadiness.label)
            \(accessoryReferenceSummary.label)
            \(accessoryPreflightReadiness.label)
            \(accessoryPreflightSummary.label)
            \(accessoryPanelNotesReadiness.label)
            \(accessoryPanelNotesSummary.label)
            \(glowReadiness.label)
            \(glowSummary.label)
            \(patternReadiness.label)
            \(patternSummary.label)
            \(patternCueSummary.label)
            \(coreImagePreflightReadiness.label)
            \(coreImagePreflightSummary.label)
            \(bodyProportionReadiness.label)
            \(bodyProportionSummary.label)
            \(siblingBodyProportionReadiness.label)
            \(siblingBodyProportionSummary.label)
            \(baselineFaceAccentReadiness.label)
            \(baselineFaceAccentSummary.label)
            \(siblingFaceAccentReadiness.label)
            \(siblingFaceAccentSummary.label)
            \(siblingBodyAccentReadiness.label)
            \(siblingBodyAccentSummary.label)
            \(siblingWingAccentReadiness.label)
            \(siblingWingAccentSummary.label)
            \(baselineBodyAccentReadiness.label)
            \(baselineBodyAccentSummary.label)
            \(baselineBodyAccessoryReadiness.label)
            \(baselineBodyAccessorySummary.label)
            \(baselineTailAccessoryReadiness.label)
            \(baselineTailAccessorySummary.label)
            \(dragonTailAccessoryReadiness.label)
            \(dragonTailAccessorySummary.label)
            \(ancestorBodyAccessoryReadiness.label)
            \(ancestorBodyAccessorySummary.label)
            \(ancestorTailAccessoryReadiness.label)
            \(ancestorTailAccessorySummary.label)
            \(siblingFaceAccessoryReadiness.label)
            \(siblingFaceAccessorySummary.label)
            \(siblingBodyAccessoryReadiness.label)
            \(siblingBodyAccessorySummary.label)
            \(siblingWingAccessoryReadiness.label)
            \(siblingWingAccessorySummary.label)
            \(siblingTailAccessoryReadiness.label)
            \(siblingTailAccessorySummary.label)
            \(motionCueReadiness.label)
            \(motionCueSummary.label)
            \(blinkCueReadiness.label)
            \(blinkCueSummary.label)
            \(sleepinessIdleReadiness.label)
            \(sleepinessIdleSummary.label)
            \(hornBudReadiness.label)
            \(hornBudSummary.label)
            \(tailTipReadiness.label)
            \(tailTipSummary.label)
            \(eyeCueReadiness.label)
            \(eyeCueSummary.label)
            \(eyeGazeReadiness.label)
            \(eyeGazeSummary.label)
            \(eyeDetailReadiness.label)
            \(eyeDetailSummary.label)
            \(cheekWarmthReadiness.label)
            \(cheekWarmthSummary.label)
            \(mouthCueReadiness.label)
            \(mouthCueSummary.label)
            \(postureCueReadiness.label)
            \(postureCueSummary.label)
            \(glowAuraReadiness.label)
            \(glowAuraSummary.label)
            \(mysticismAuraReadiness.label)
            \(mysticismAuraSummary.label)
            \(ancestralGlintReadiness.label)
            \(ancestralGlintSummary.label)
            \(childDraftGlintSummary.label)
            \(faceLineageEchoReadiness.label)
            \(faceLineageEchoSummary.label)
            \(childDraftFaceLineageEchoSummary.label)
            \(childDraftWingLineageEchoSummary.label)
            \(childDraftWingLineageEchoReadiness.label)
            \(childDraftWingletVisual.label)
            \(childDraftWingletVisualReadiness.label)
            \(childDraftTailFinVisual.label)
            \(childDraftTailFinVisualReadiness.label)
            \(childDraftVisualPolicy.label)
            \(childDraftVisualPolicyReadiness.label)
            \(lineageThreadReadiness.label)
            \(lineageThreadSummary.label)
            \(childDraftThreadSummary.label)
            \(tailEchoReadiness.label)
            \(tailEchoSummary.label)
            \(childDraftTailEchoSummary.label)
            \(childDraftFaceAccentReadiness.label)
            \(childDraftFaceAccentSummary.label)
            \(childDraftFaceAccessoryReadiness.label)
            \(childDraftFaceAccessorySummary.label)
            \(childDraftInheritedFaceEchoSummary.label)
            \(ancestorPortraitCueLine.label)
            \(childDraftCueSetSummary.label)
            \(childDraftCueSetReadiness.label)
            \(referenceSheetPNGPreflightSummary.label)
            \(referenceSheetPNGPreflightReadiness.label)
            \(fixedPart3DManifestSummary.label)
            \(fixedPart3DManifestReadiness.label)
            \(fixedPart3DReferenceGateSummary.label)
            \(fixedPart3DReferenceGateReadiness.label)
            \(rigSocketMapSummary.label)
            \(rigSocketMapReadiness.label)
            \(rigAssetValidationPreflightSummary.label)
            \(rigAssetValidationPreflightReadiness.label)
            \(hornBaseEvidenceSummary.label)
            \(hornBaseEvidenceReadiness.label)
            \(upperBodyHandoffSummary.label)
            \(upperBodyHandoffReadiness.label)
            \(tailFloatingHandoffSummary.label)
            \(tailFloatingHandoffReadiness.label)
            """ + "\n"

        assertSnapshot(
            of: targetEntrySnapshot,
            as: .lines,
            named: "snapshot-app-target-entry"
        )

        try assertReferenceDeviceImageSnapshot(
            of: screenshot.croppingStatusBarForSnapshot(),
            named: "genome-variation-first-reference"
        )
    }

    @MainActor
    func testObservationHomePortraitAccessibilityDescribesGenomeCues() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Luma's portrait"))
        XCTAssertTrue(portrait.label.contains("faceted face"))
        XCTAssertTrue(portrait.label.contains("moon oval body"))
        XCTAssertTrue(portrait.label.contains("no visible winglets"))
        XCTAssertTrue(portrait.label.contains("floating ribbon tail"))
        XCTAssertTrue(portrait.label.contains("Juvenile stage"))
        XCTAssertTrue(portrait.label.contains("family echo: soft forehead memory dots, soft ancestral glint, and soft tail memory dots"))
        XCTAssertFalse(portrait.label.contains("soft lunar form"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Faceted face  |  moon oval body  |  floating ribbon tail  |  warm eye glint  |  forehead memory")
    }

    @MainActor
    func testObservationHomeMiraHostDescribesSiblingGenomeCues() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home-mira"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Mira's portrait"))
        XCTAssertTrue(portrait.label.contains("soft feline face"))
        XCTAssertTrue(portrait.label.contains("seed petal body"))
        XCTAssertTrue(portrait.label.contains("leaf-pair winglets"))
        XCTAssertTrue(portrait.label.contains("fish fin tail"))
        XCTAssertTrue(portrait.label.contains("Juvenile stage"))
        XCTAssertTrue(portrait.label.contains("family echo: soft forehead memory dots, soft wing memory tips, soft ancestral glint, and soft tail memory dots"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Soft feline face  |  seed petal body  |  leaf-pair winglets  |  fish fin tail  |  curious eye glint  |  forehead memory")
    }

    @MainActor
    func testObservationHomeOriHostDescribesAncestorGenomeCues() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home-ori"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Ori's portrait"))
        XCTAssertTrue(portrait.label.contains("soft deer face"))
        XCTAssertTrue(portrait.label.contains("leaf belly body"))
        XCTAssertTrue(portrait.label.contains("sprout-leaf winglets"))
        XCTAssertTrue(portrait.label.contains("leaf sprout tail"))
        XCTAssertTrue(portrait.label.contains("Elder stage"))
        XCTAssertTrue(portrait.label.contains("family echo: soft forehead memory dots, soft ancestral glint, and soft tail memory dots"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Soft deer face  |  leaf belly body  |  sprout-leaf winglets  |  leaf sprout tail  |  warm eye glint  |  forehead memory")
    }

    @MainActor
    func testObservationHomeAxolotlHostDescribesWideFaceVariation() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home-axolotl"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Nalu's portrait"))
        XCTAssertTrue(portrait.label.contains("wide axolotl face"))
        XCTAssertTrue(portrait.label.contains("water drop body"))
        XCTAssertTrue(portrait.label.contains("soft bell winglets"))
        XCTAssertTrue(portrait.label.contains("fish fin tail"))
        XCTAssertTrue(portrait.label.contains("Juvenile stage"))
        XCTAssertTrue(portrait.label.contains("family echo: soft forehead memory dots, soft ancestral glint, and soft tail memory dots"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Wide axolotl face  |  water drop body  |  soft bell winglets  |  fish fin tail  |  curious eye glint  |  forehead memory")

        let readability = app.staticTexts["observationCueLineReadabilityPreflightSummary"]
        XCTAssertTrue(readability.waitForExistence(timeout: 2))
        XCTAssertTrue(readability.label.contains("surface:observationHome"))
        XCTAssertTrue(readability.label.contains("segments:6/6"))
        XCTAssertTrue(readability.label.contains("characters:120/128"))
        XCTAssertTrue(readability.label.contains("eyeGlint:true"))
        XCTAssertTrue(readability.label.contains("memoryCue:true"))
        XCTAssertTrue(readability.label.contains("lineLimit:3"))
        XCTAssertTrue(readability.label.contains("minimumScale:0.78"))
        XCTAssertTrue(readability.label.contains("appHostVisualQAPending:true"))
        XCTAssertTrue(readability.label.contains("visibleCopyChanged:false"))
        XCTAssertTrue(readability.label.contains("assetOutputs:none"))

        let readabilityReady = app.staticTexts["observationCueLineReadabilityPreflightReadinessSummary"]
        XCTAssertTrue(readabilityReady.waitForExistence(timeout: 2))
        XCTAssertEqual(readabilityReady.label, "observationCueLineReadabilityPreflightReady:true")
    }

    @MainActor
    func testObservationHomeForeheadMemoryCueMatrixMatchesSnapshot() throws {
        let matrix = [
            try observationHomeForeheadMemoryCueLine(
                route: "--wipet-snapshot-host-observation-home",
                id: "luma"
            ),
            try observationHomeForeheadMemoryCueLine(
                route: "--wipet-snapshot-host-observation-home-mira",
                id: "mira"
            ),
            try observationHomeForeheadMemoryCueLine(
                route: "--wipet-snapshot-host-observation-home-ori",
                id: "ori"
            ),
            try observationHomeForeheadMemoryCueLine(
                route: "--wipet-snapshot-host-observation-home-axolotl",
                id: "nalu"
            ),
            try observationHomeForeheadMemoryCueLine(
                route: "--wipet-snapshot-host-observation-home-selection-mira",
                id: "selectionMira"
            )
        ].joined(separator: "\n")

        assertSnapshot(
            of: "ObservationHomeForeheadMemoryCueMatrix\n\(matrix)\n",
            as: .lines,
            named: "observation-home-forehead-memory-cue-matrix"
        )
    }

    @MainActor
    func testObservationHomeLocalSelectionHostSelectsMiraWithoutPublishing() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home-selection-mira"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Mira's portrait"))
        XCTAssertFalse(portrait.label.contains("Luma's portrait"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Soft feline face  |  seed petal body  |  leaf-pair winglets  |  fish fin tail  |  curious eye glint  |  forehead memory")

        let selectionSummary = app.staticTexts["observationHomeSelectionSummary"]
        XCTAssertTrue(selectionSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(selectionSummary.label.contains("selected:mira"))
        XCTAssertTrue(selectionSummary.label.contains("selectedName:Mira"))
        XCTAssertTrue(selectionSummary.label.contains("candidates:luma+mira+ori"))
        XCTAssertTrue(selectionSummary.label.contains("roles:current+sibling+ancestor"))
        XCTAssertTrue(selectionSummary.label.contains("mutation:false"))
        XCTAssertTrue(selectionSummary.label.contains("persistence:false"))
        XCTAssertTrue(selectionSummary.label.contains("widget:false"))
        XCTAssertTrue(selectionSummary.label.contains("normalEntry:false"))

        let selectionReadiness = app.staticTexts["observationHomeSelectionReadinessSummary"]
        XCTAssertTrue(selectionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(selectionReadiness.label, "observationHomeSelectionReady:true,selectedExists:true,uniqueCandidates:true")

        let handoffPolicy = app.staticTexts["observationHomeSelectionHandoffPolicySummary"]
        XCTAssertTrue(handoffPolicy.waitForExistence(timeout: 2))
        XCTAssertTrue(handoffPolicy.label.contains("selected:mira"))
        XCTAssertTrue(handoffPolicy.label.contains("publishOnSelection:false"))
        XCTAssertTrue(handoffPolicy.label.contains("publishAfterObservationMoment:true"))
        XCTAssertTrue(handoffPolicy.label.contains("snapshotHostPublish:false"))
        XCTAssertTrue(handoffPolicy.label.contains("persistence:false"))
        XCTAssertTrue(handoffPolicy.label.contains("widgetPayloadSchemaChanged:false"))

        let handoffPolicyReadiness = app.staticTexts["observationHomeSelectionHandoffPolicyReadinessSummary"]
        XCTAssertTrue(handoffPolicyReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(handoffPolicyReadiness.label, "observationSelectionHandoffPolicyReady:true,selectedExists:true,publishOnSelection:false,publishAfterObservationMoment:true")

        let observationMoment = app.staticTexts["observationHomeSelectionMomentSummary"]
        XCTAssertTrue(observationMoment.waitForExistence(timeout: 2))
        XCTAssertTrue(observationMoment.label.contains("selected:mira"))
        XCTAssertTrue(observationMoment.label.contains("acknowledged:false"))
        XCTAssertTrue(observationMoment.label.contains("publishReady:false"))
        XCTAssertTrue(observationMoment.label.contains("widgetPublished:false"))

        let observationMomentReadiness = app.staticTexts["observationHomeSelectionMomentReadinessSummary"]
        XCTAssertTrue(observationMomentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(observationMomentReadiness.label, "observationSelectionMomentReady:false,acknowledged:false,selectedExists:true,widgetPublished:false,persistence:false")

        let payloadContract = app.staticTexts["observationHomeSelectionWidgetPayloadContractSummary"]
        XCTAssertTrue(payloadContract.waitForExistence(timeout: 2))
        XCTAssertTrue(payloadContract.label.contains("selected:mira"))
        XCTAssertTrue(payloadContract.label.contains("acknowledged:false"))
        XCTAssertTrue(payloadContract.label.contains("ready:false"))
        XCTAssertTrue(payloadContract.label.contains("schema:none"))
        XCTAssertTrue(payloadContract.label.contains("write:false"))
        XCTAssertTrue(payloadContract.label.contains("reload:false"))

        let payloadContractReadiness = app.staticTexts["observationHomeSelectionWidgetPayloadContractReadinessSummary"]
        XCTAssertTrue(payloadContractReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(payloadContractReadiness.label, "observationSelectionWidgetPayloadContractReady:false,schema:0,expectedSchema:1,key:widget.currentObservation.json,widgetKind:WiPetWidget,write:false,reload:false")

        let publishPreflight = app.staticTexts["observationHomeSelectionWidgetPublishPreflightSummary"]
        XCTAssertTrue(publishPreflight.waitForExistence(timeout: 2))
        XCTAssertTrue(publishPreflight.label.contains("selected:mira"))
        XCTAssertTrue(publishPreflight.label.contains("acknowledged:false"))
        XCTAssertTrue(publishPreflight.label.contains("payloadReady:false"))
        XCTAssertTrue(publishPreflight.label.contains("finalGuardReady:false"))
        XCTAssertTrue(publishPreflight.label.contains("expectedResult:widgetHandoffPublished:true,reloadedWidgetKind:WiPetWidget"))
        XCTAssertTrue(publishPreflight.label.contains("resultSummaryReady:true"))
        XCTAssertTrue(publishPreflight.label.contains("wouldWrite:false"))
        XCTAssertTrue(publishPreflight.label.contains("wouldReload:false"))
        XCTAssertTrue(publishPreflight.label.contains("write:false"))
        XCTAssertTrue(publishPreflight.label.contains("reload:false"))
        XCTAssertTrue(publishPreflight.label.contains("snapshotHostPublish:false"))
        XCTAssertTrue(publishPreflight.label.contains("persistence:false"))
        XCTAssertTrue(publishPreflight.label.contains("normalEntry:false"))

        let publishPreflightReadiness = app.staticTexts["observationHomeSelectionWidgetPublishPreflightReadinessSummary"]
        XCTAssertTrue(publishPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(publishPreflightReadiness.label, "observationSelectionWidgetPublishPreflightReady:false,expectedResultReady:true,schema:0,expectedSchema:1,wouldWrite:false,wouldReload:false,write:false,reload:false")
    }

    @MainActor
    func testObservationHomeLocalSelectionMomentAcknowledgementAllowsFuturePublishGate() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-observation-home-selection-mira-observed"]
        app.launch()

        let portrait = app.otherElements["observationHomeCreaturePortrait"]
        XCTAssertTrue(portrait.waitForExistence(timeout: 12))
        XCTAssertTrue(portrait.label.contains("Mira's portrait"))
        XCTAssertFalse(portrait.label.contains("Luma's portrait"))

        let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
        XCTAssertTrue(cueLine.waitForExistence(timeout: 2))
        XCTAssertEqual(cueLine.label, "Soft feline face  |  seed petal body  |  leaf-pair winglets  |  fish fin tail  |  forehead memory")

        let observationMoment = app.staticTexts["observationHomeSelectionMomentSummary"]
        XCTAssertTrue(observationMoment.waitForExistence(timeout: 2))
        XCTAssertTrue(observationMoment.label.contains("selected:mira"))
        XCTAssertTrue(observationMoment.label.contains("acknowledged:true"))
        XCTAssertTrue(observationMoment.label.contains("selectedExists:true"))
        XCTAssertTrue(observationMoment.label.contains("publishReady:true"))
        XCTAssertTrue(observationMoment.label.contains("publishOnSelection:false"))
        XCTAssertTrue(observationMoment.label.contains("widgetPublished:false"))
        XCTAssertTrue(observationMoment.label.contains("persistence:false"))
        XCTAssertTrue(observationMoment.label.contains("mutation:false"))

        let observationMomentReadiness = app.staticTexts["observationHomeSelectionMomentReadinessSummary"]
        XCTAssertTrue(observationMomentReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(observationMomentReadiness.label, "observationSelectionMomentReady:true,acknowledged:true,selectedExists:true,widgetPublished:false,persistence:false")

        let handoffPolicy = app.staticTexts["observationHomeSelectionHandoffPolicySummary"]
        XCTAssertTrue(handoffPolicy.waitForExistence(timeout: 2))
        XCTAssertTrue(handoffPolicy.label.contains("publishOnSelection:false"))
        XCTAssertTrue(handoffPolicy.label.contains("snapshotHostPublish:false"))
        XCTAssertTrue(handoffPolicy.label.contains("widgetPayloadSchemaChanged:false"))

        let payloadContract = app.staticTexts["observationHomeSelectionWidgetPayloadContractSummary"]
        XCTAssertTrue(payloadContract.waitForExistence(timeout: 2))
        XCTAssertTrue(payloadContract.label.contains("selected:mira"))
        XCTAssertTrue(payloadContract.label.contains("acknowledged:true"))
        XCTAssertTrue(payloadContract.label.contains("ready:true"))
        XCTAssertTrue(payloadContract.label.contains("schema:1"))
        XCTAssertTrue(payloadContract.label.contains("key:widget.currentObservation.json"))
        XCTAssertTrue(payloadContract.label.contains("widgetKind:WiPetWidget"))
        XCTAssertTrue(payloadContract.label.contains("name:Mira"))
        XCTAssertTrue(payloadContract.label.contains("species:Sylphian"))
        XCTAssertTrue(payloadContract.label.contains("stage:Juvenile"))
        XCTAssertTrue(payloadContract.label.contains("generation:3"))
        XCTAssertTrue(payloadContract.label.contains("mood:Dreamy"))
        XCTAssertTrue(payloadContract.label.contains("age:12 days"))
        XCTAssertTrue(payloadContract.label.contains("discovery:Mira's glow echoes Luma's moonlit tail."))
        XCTAssertTrue(payloadContract.label.contains("memoryCue:Juvenile inherited memory"))
        XCTAssertTrue(payloadContract.label.contains("lineageCue:Echoes an ancestor"))
        XCTAssertTrue(payloadContract.label.contains("write:false"))
        XCTAssertTrue(payloadContract.label.contains("reload:false"))

        let payloadContractReadiness = app.staticTexts["observationHomeSelectionWidgetPayloadContractReadinessSummary"]
        XCTAssertTrue(payloadContractReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(payloadContractReadiness.label, "observationSelectionWidgetPayloadContractReady:true,schema:1,expectedSchema:1,key:widget.currentObservation.json,widgetKind:WiPetWidget,write:false,reload:false")

        let publishPreflight = app.staticTexts["observationHomeSelectionWidgetPublishPreflightSummary"]
        XCTAssertTrue(publishPreflight.waitForExistence(timeout: 2))
        XCTAssertTrue(publishPreflight.label.contains("selected:mira"))
        XCTAssertTrue(publishPreflight.label.contains("acknowledged:true"))
        XCTAssertTrue(publishPreflight.label.contains("payloadReady:true"))
        XCTAssertTrue(publishPreflight.label.contains("finalGuardReady:true"))
        XCTAssertTrue(publishPreflight.label.contains("expectedResult:widgetHandoffPublished:true,reloadedWidgetKind:WiPetWidget"))
        XCTAssertTrue(publishPreflight.label.contains("resultSummaryReady:true"))
        XCTAssertTrue(publishPreflight.label.contains("wouldWrite:true"))
        XCTAssertTrue(publishPreflight.label.contains("wouldReload:true"))
        XCTAssertTrue(publishPreflight.label.contains("write:false"))
        XCTAssertTrue(publishPreflight.label.contains("reload:false"))
        XCTAssertTrue(publishPreflight.label.contains("snapshotHostPublish:false"))
        XCTAssertTrue(publishPreflight.label.contains("persistence:false"))
        XCTAssertTrue(publishPreflight.label.contains("normalEntry:false"))

        let publishPreflightReadiness = app.staticTexts["observationHomeSelectionWidgetPublishPreflightReadinessSummary"]
        XCTAssertTrue(publishPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(publishPreflightReadiness.label, "observationSelectionWidgetPublishPreflightReady:true,expectedResultReady:true,schema:1,expectedSchema:1,wouldWrite:true,wouldReload:true,write:false,reload:false")
    }

    @MainActor
    func testGrowthCeremonyPreviewProtectsVisibleDryRunSurface() throws {
        var app = XCUIApplication()
        app.launchArguments = ["--wipet-growth-ceremony-preview"]
        app.launch()

        let previewLabel = app.staticTexts["growthCeremonyPreviewAccessibilityLabel"]
        XCTAssertTrue(previewLabel.waitForExistence(timeout: 12))
        XCTAssertTrue(previewLabel.label.contains("Growth ceremony preview:"))
        XCTAssertTrue(previewLabel.label.contains("growthPersistenceBoundary"))
        XCTAssertTrue(previewLabel.label.contains("growthWidgetHandoffPreflight"))
        XCTAssertTrue(previewLabel.label.contains("growthLineageAffectionCopyReady:true"))
        XCTAssertTrue(previewLabel.label.contains("growthInheritedVisualMemoryBridgeReady:true"))
        XCTAssertTrue(previewLabel.label.contains("growthInheritedVisualVisiblePromotionGateReady:true"))
        XCTAssertTrue(previewLabel.label.contains("growthInheritedVisualPromotionDeferralReady:true"))
        XCTAssertTrue(previewLabel.label.contains("promote:false"))
        XCTAssertTrue(previewLabel.label.contains("Luma's growth preview can remember firstAncestor's floating tail."))
        XCTAssertTrue(previewLabel.label.contains("Luma's family memories can stay with the grown shape."))

        let visibleLine = app.staticTexts["growthLineageAffectionVisibleLine"]
        XCTAssertTrue(visibleLine.waitForExistence(timeout: 2))
        XCTAssertFalse(visibleLine.label.isEmpty)

        let continuityLine = app.staticTexts["growthContinuityVisibleLine"]
        XCTAssertTrue(continuityLine.waitForExistence(timeout: 2))
        XCTAssertEqual(continuityLine.label, "Adult Luma can still feel like the same Luma.")

        let familyMemoryLine = app.staticTexts["growthFamilyMemoryAccessibilityLine"]
        XCTAssertTrue(familyMemoryLine.waitForExistence(timeout: 2))
        XCTAssertEqual(familyMemoryLine.label, "Luma's family memories can stay with the grown shape.")

        let inheritedVisualMemoryLine = app.staticTexts["growthInheritedVisualMemoryLine"]
        XCTAssertTrue(inheritedVisualMemoryLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            inheritedVisualMemoryLine.label,
            "Luma's growth preview can remember firstAncestor's floating tail."
        )

        let inheritedVisualMemorySummary = app.staticTexts["growthInheritedVisualMemoryBridgeSummary"]
        XCTAssertTrue(inheritedVisualMemorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("source:observationHomeGrowthCeremony"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("creature:Luma"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("ancestor:firstAncestor"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("wing:none"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("tail:floating"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("previewOnly:true"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("mutation:false"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("persistence:false"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("widget:false"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("discovery:false"))
        XCTAssertTrue(inheritedVisualMemorySummary.label.contains("playerFacing:false"))

        let inheritedVisualMemoryReadiness = app.staticTexts["growthInheritedVisualMemoryBridgeReadinessSummary"]
        XCTAssertTrue(inheritedVisualMemoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(inheritedVisualMemoryReadiness.label, "growthInheritedVisualMemoryBridgeReady:true")

        let inheritedVisualPromotionGate = app.staticTexts["growthInheritedVisualVisiblePromotionGateSummary"]
        XCTAssertTrue(inheritedVisualPromotionGate.waitForExistence(timeout: 2))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("bridgeReady:true"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("copyReview:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("appHostVisualQA:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("snapshotReview:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("layoutRoom:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("quietTone:true"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("promote:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("mutation:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("persistence:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("widget:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("discovery:false"))
        XCTAssertTrue(inheritedVisualPromotionGate.label.contains("playerFacing:false"))

        let inheritedVisualPromotionReadiness = app.staticTexts["growthInheritedVisualVisiblePromotionGateReadinessSummary"]
        XCTAssertTrue(inheritedVisualPromotionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(inheritedVisualPromotionReadiness.label, "growthInheritedVisualVisiblePromotionGateReady:true")

        let inheritedVisualPromotionDeferral = app.staticTexts["growthInheritedVisualPromotionDeferralSummary"]
        XCTAssertTrue(inheritedVisualPromotionDeferral.waitForExistence(timeout: 2))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("gateReady:true"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("copyReview:true"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("appHostVisualQA:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("snapshotReview:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("layoutRoom:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("reason:appHostVisualQAPending"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("defers:true"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("mutation:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("persistence:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("widget:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("discovery:false"))
        XCTAssertTrue(inheritedVisualPromotionDeferral.label.contains("playerFacing:false"))

        let inheritedVisualPromotionDeferralReadiness = app.staticTexts["growthInheritedVisualPromotionDeferralReadinessSummary"]
        XCTAssertTrue(inheritedVisualPromotionDeferralReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(inheritedVisualPromotionDeferralReadiness.label, "growthInheritedVisualPromotionDeferralReady:true")

        let comparisonLine = app.staticTexts["growthBeforeAfterComparisonVisibleLine"]
        XCTAssertTrue(comparisonLine.waitForExistence(timeout: 2))
        XCTAssertEqual(comparisonLine.label, "Watch the tail glow before deciding together.")

        let beforeAfterSummary = app.staticTexts["growthBeforeAfterPortraitSurfaceSummary"]
        XCTAssertTrue(beforeAfterSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(beforeAfterSummary.label.contains("allowsMutation:false"))
        XCTAssertTrue(beforeAfterSummary.label.contains("widgetHandoffAllowed:false"))
        XCTAssertTrue(beforeAfterSummary.label.contains("assetOutputs:none"))

        let beforeAfterStageCuePairSummary = app.staticTexts["growthBeforeAfterStageCuePairSummary"]
        XCTAssertTrue(beforeAfterStageCuePairSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(beforeAfterStageCuePairSummary.label.contains("current:juvenile+familiar+soft"))
        XCTAssertTrue(beforeAfterStageCuePairSummary.label.contains("next:adult+grown+settled"))
        XCTAssertTrue(beforeAfterStageCuePairSummary.label.contains("previewOnly:true"))
        XCTAssertTrue(beforeAfterStageCuePairSummary.label.contains("mutation:false"))
        XCTAssertTrue(beforeAfterStageCuePairSummary.label.contains("assetOutputs:none"))

        let beforeAfterStageCuePairReadiness = app.staticTexts["growthBeforeAfterStageCuePairReadinessSummary"]
        XCTAssertTrue(beforeAfterStageCuePairReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(beforeAfterStageCuePairReadiness.label, "growthBeforeAfterStageCuePairReady:true")

        let hornBudPreviewSummary = app.staticTexts["growthHornBudCeremonyPreviewSummary"]
        XCTAssertTrue(hornBudPreviewSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("current:dormantBud"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("next:dormantBud"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("visible:false"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("allowsMutation:false"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("widgetHandoffAllowed:false"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("discoveryAppend:false"))
        XCTAssertTrue(hornBudPreviewSummary.label.contains("assetOutputs:none"))

        let hornBudPreviewReadiness = app.staticTexts["growthHornBudCeremonyPreviewReadinessSummary"]
        XCTAssertTrue(hornBudPreviewReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(hornBudPreviewReadiness.label, "growthHornBudCeremonyPreviewReady:true")

        let acknowledgementButton = app.buttons["growthObservationAcknowledgementButton"]
        XCTAssertTrue(acknowledgementButton.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgementButton.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgementButton.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgementButton.label.contains("widget:false"))

        let persistenceSummary = app.staticTexts["growthPersistenceBoundarySummary"]
        XCTAssertTrue(persistenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(persistenceSummary.label.contains("dryRun:true"))
        XCTAssertTrue(persistenceSummary.label.contains("write:false"))
        XCTAssertTrue(persistenceSummary.label.contains("mutatesCreature:false"))
        XCTAssertTrue(persistenceSummary.label.contains("widget:false"))

        let widgetPreflightSummary = app.staticTexts["growthWidgetHandoffPreflightSummary"]
        XCTAssertTrue(widgetPreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(widgetPreflightSummary.label.contains("schema:1"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("key:widget.currentObservation.json"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("widgetKind:WiPetWidget"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("payloadPrepared:true"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("previewOnly:true"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("write:false"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("reload:false"))
        XCTAssertTrue(widgetPreflightSummary.label.contains("publish:false"))

        let widgetPreflightReadiness = app.staticTexts["growthWidgetHandoffPreflightReadinessSummary"]
        XCTAssertTrue(widgetPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(widgetPreflightReadiness.label, "growthWidgetHandoffPreflightReady:true")

        let gateSummary = app.staticTexts["growthAcknowledgementGateSummary"]
        XCTAssertTrue(gateSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(gateSummary.label.contains("acknowledged:false"))
        XCTAssertTrue(gateSummary.label.contains("allowsCommit:false"))

        let surfaceSummary = app.staticTexts["growthAcknowledgementSurfaceSummary"]
        XCTAssertTrue(surfaceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(surfaceSummary.label.contains("acknowledged:false"))
        XCTAssertTrue(surfaceSummary.label.contains("allowsCommit:false"))

        let affectionReadiness = app.staticTexts["growthLineageAffectionCopyReadinessSummary"]
        XCTAssertTrue(affectionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(affectionReadiness.label, "growthLineageAffectionCopyReady:true")

        let pendingNoticedMemoryLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertFalse(pendingNoticedMemoryLine.exists)

        let noticedMemorySummary = app.staticTexts["growthNoticedMemoryLineSummary"]
        XCTAssertTrue(noticedMemorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(noticedMemorySummary.label.contains("acknowledged:false"))
        XCTAssertTrue(noticedMemorySummary.label.contains("display:false"))
        XCTAssertTrue(noticedMemorySummary.label.contains("write:false"))
        XCTAssertTrue(noticedMemorySummary.label.contains("mutation:false"))
        XCTAssertTrue(noticedMemorySummary.label.contains("widget:false"))
        XCTAssertTrue(noticedMemorySummary.label.contains("discovery:false"))

        let noticedMemoryReadiness = app.staticTexts["growthNoticedMemoryLineReadinessSummary"]
        XCTAssertTrue(noticedMemoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(noticedMemoryReadiness.label, "growthNoticedMemoryLineReady:false")

        let bodyAccentCatalogSummary = app.staticTexts["growthBodyAccentNoticedMemoryCatalogSummary"]
        XCTAssertTrue(bodyAccentCatalogSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("cue:crescentBelly"))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("trait:bodyAccent"))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("write:false"))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("mutation:false"))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("widget:false"))
        XCTAssertTrue(bodyAccentCatalogSummary.label.contains("discovery:false"))

        let bodyAccentCatalogReadiness = app.staticTexts["growthBodyAccentNoticedMemoryCatalogReadinessSummary"]
        XCTAssertTrue(bodyAccentCatalogReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(bodyAccentCatalogReadiness.label, "growthNoticedMemoryCatalogReady:true")

        let prioritySummary = app.staticTexts["growthNoticedMemoryPrioritySummary"]
        XCTAssertTrue(prioritySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(prioritySummary.label.contains("selected:softTailTipGlint"))
        XCTAssertTrue(prioritySummary.label.contains("candidates:softTailTipGlint+crescentBelly"))
        XCTAssertTrue(prioritySummary.label.contains("visibleCopyChanged:false"))
        XCTAssertTrue(prioritySummary.label.contains("write:false"))
        XCTAssertTrue(prioritySummary.label.contains("mutation:false"))
        XCTAssertTrue(prioritySummary.label.contains("widget:false"))
        XCTAssertTrue(prioritySummary.label.contains("discovery:false"))

        let priorityReadiness = app.staticTexts["growthNoticedMemoryPriorityReadinessSummary"]
        XCTAssertTrue(priorityReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(priorityReadiness.label, "growthNoticedMemoryPriorityReady:true")

        let ceremonySnapshot = """
            GrowthCeremonyPreviewAppSurface
            visibleLine:\(visibleLine.label)
            continuityLine:\(continuityLine.label)
            familyMemoryLine:\(familyMemoryLine.label)
            inheritedVisualMemoryLine:\(inheritedVisualMemoryLine.label)
            \(inheritedVisualMemorySummary.label)
            \(inheritedVisualMemoryReadiness.label)
            \(inheritedVisualPromotionGate.label)
            \(inheritedVisualPromotionReadiness.label)
            \(inheritedVisualPromotionDeferral.label)
            \(inheritedVisualPromotionDeferralReadiness.label)
            comparisonLine:\(comparisonLine.label)
            \(beforeAfterSummary.label)
            \(beforeAfterStageCuePairSummary.label)
            \(beforeAfterStageCuePairReadiness.label)
            \(hornBudPreviewSummary.label)
            \(hornBudPreviewReadiness.label)
            acknowledgement:\(acknowledgementButton.label)
            \(gateSummary.label)
            \(surfaceSummary.label)
            \(noticedMemorySummary.label)
            \(noticedMemoryReadiness.label)
            \(bodyAccentCatalogSummary.label)
            \(bodyAccentCatalogReadiness.label)
            \(prioritySummary.label)
            \(priorityReadiness.label)
            \(persistenceSummary.label)
            \(widgetPreflightSummary.label)
            \(widgetPreflightReadiness.label)
            \(affectionReadiness.label)
            """ + "\n"

        assertSnapshot(
            of: ceremonySnapshot,
            as: .lines,
            named: "growth-ceremony-preview-app-surface"
        )

        try assertReferenceDeviceImageSnapshot(
            of: app.windows.firstMatch.screenshot().image.croppingStatusBarForSnapshot(),
            named: "growth-ceremony-preview-first-reference"
        )

        app.terminate()
        app = XCUIApplication()
        app.launchArguments = ["--wipet-growth-ceremony-acknowledged-preview"]
        app.launch()

        let acknowledgedPreviewLabel = app.staticTexts["growthCeremonyPreviewAccessibilityLabel"]
        XCTAssertTrue(acknowledgedPreviewLabel.waitForExistence(timeout: 12))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("growthObservationAcknowledgement=noted:true"))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("growthInheritedVisualMemoryBridgeReady:true"))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("growthInheritedVisualVisiblePromotionGateReady:true"))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("growthInheritedVisualPromotionDeferralReady:true"))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("promote:false"))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("Luma's growth preview can remember firstAncestor's floating tail."))
        XCTAssertTrue(acknowledgedPreviewLabel.label.contains("Luma's family memories can stay with the grown shape."))

        let acknowledgedFamilyMemoryLine = app.staticTexts["growthFamilyMemoryAccessibilityLine"]
        XCTAssertTrue(acknowledgedFamilyMemoryLine.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedFamilyMemoryLine.label, "Luma's family memories can stay with the grown shape.")

        let acknowledgedInheritedVisualMemoryLine = app.staticTexts["growthInheritedVisualMemoryLine"]
        XCTAssertTrue(acknowledgedInheritedVisualMemoryLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            acknowledgedInheritedVisualMemoryLine.label,
            "Luma's growth preview can remember firstAncestor's floating tail."
        )

        let acknowledgedInheritedVisualMemorySummary = app.staticTexts["growthInheritedVisualMemoryBridgeSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("source:observationHomeGrowthCeremony"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("creature:Luma"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("ancestor:firstAncestor"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("tail:floating"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("persistence:false"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedInheritedVisualMemorySummary.label.contains("discovery:false"))

        let acknowledgedInheritedVisualMemoryReadiness = app.staticTexts["growthInheritedVisualMemoryBridgeReadinessSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualMemoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedInheritedVisualMemoryReadiness.label, "growthInheritedVisualMemoryBridgeReady:true")

        let acknowledgedInheritedVisualPromotionGate = app.staticTexts["growthInheritedVisualVisiblePromotionGateSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("bridgeReady:true"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("copyReview:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("appHostVisualQA:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("snapshotReview:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("layoutRoom:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("promote:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionGate.label.contains("discovery:false"))

        let acknowledgedInheritedVisualPromotionReadiness = app.staticTexts["growthInheritedVisualVisiblePromotionGateReadinessSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualPromotionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(
            acknowledgedInheritedVisualPromotionReadiness.label,
            "growthInheritedVisualVisiblePromotionGateReady:true"
        )

        let acknowledgedInheritedVisualPromotionDeferral = app.staticTexts["growthInheritedVisualPromotionDeferralSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("gateReady:true"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("copyReview:true"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("reason:appHostVisualQAPending"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("defers:true"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferral.label.contains("discovery:false"))

        let acknowledgedInheritedVisualPromotionDeferralReadiness = app.staticTexts["growthInheritedVisualPromotionDeferralReadinessSummary"]
        XCTAssertTrue(acknowledgedInheritedVisualPromotionDeferralReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(
            acknowledgedInheritedVisualPromotionDeferralReadiness.label,
            "growthInheritedVisualPromotionDeferralReady:true"
        )

        let acknowledgedButton = app.buttons["growthObservationAcknowledgementButton"]
        XCTAssertTrue(acknowledgedButton.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedButton.label.contains("noted:true"))
        XCTAssertTrue(acknowledgedButton.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgedButton.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("persistence:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedButton.label.contains("discovery:false"))

        let acknowledgedBeforeAfterSummary = app.staticTexts["growthBeforeAfterPortraitSurfaceSummary"]
        XCTAssertTrue(acknowledgedBeforeAfterSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedBeforeAfterSummary.label.contains("allowsMutation:false"))
        XCTAssertTrue(acknowledgedBeforeAfterSummary.label.contains("widgetHandoffAllowed:false"))

        let acknowledgedBeforeAfterStageCuePairSummary = app.staticTexts["growthBeforeAfterStageCuePairSummary"]
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.label.contains("current:juvenile+familiar+soft"))
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.label.contains("next:adult+grown+settled"))
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairSummary.label.contains("assetOutputs:none"))

        let acknowledgedBeforeAfterStageCuePairReadiness = app.staticTexts["growthBeforeAfterStageCuePairReadinessSummary"]
        XCTAssertTrue(acknowledgedBeforeAfterStageCuePairReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedBeforeAfterStageCuePairReadiness.label, "growthBeforeAfterStageCuePairReady:true")

        let acknowledgedHornBudPreviewSummary = app.staticTexts["growthHornBudCeremonyPreviewSummary"]
        XCTAssertTrue(acknowledgedHornBudPreviewSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedHornBudPreviewSummary.label.contains("visible:false"))
        XCTAssertTrue(acknowledgedHornBudPreviewSummary.label.contains("allowsMutation:false"))
        XCTAssertTrue(acknowledgedHornBudPreviewSummary.label.contains("widgetHandoffAllowed:false"))
        XCTAssertTrue(acknowledgedHornBudPreviewSummary.label.contains("discoveryAppend:false"))

        let acknowledgedHornBudPreviewReadiness = app.staticTexts["growthHornBudCeremonyPreviewReadinessSummary"]
        XCTAssertTrue(acknowledgedHornBudPreviewReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedHornBudPreviewReadiness.label, "growthHornBudCeremonyPreviewReady:true")

        let acknowledgedComparisonLine = app.staticTexts["growthBeforeAfterComparisonVisibleLine"]
        XCTAssertTrue(acknowledgedComparisonLine.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedComparisonLine.label, "Watch the tail glow before deciding together.")

        let acknowledgedPersistenceSummary = app.staticTexts["growthPersistenceBoundarySummary"]
        XCTAssertTrue(acknowledgedPersistenceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedPersistenceSummary.label.contains("write:false"))
        XCTAssertTrue(acknowledgedPersistenceSummary.label.contains("mutatesCreature:false"))
        XCTAssertTrue(acknowledgedPersistenceSummary.label.contains("widget:false"))

        let acknowledgedWidgetPreflightSummary = app.staticTexts["growthWidgetHandoffPreflightSummary"]
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("schema:1"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("key:widget.currentObservation.json"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("widgetKind:WiPetWidget"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("payloadPrepared:true"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("previewOnly:true"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("write:false"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("reload:false"))
        XCTAssertTrue(acknowledgedWidgetPreflightSummary.label.contains("publish:false"))

        let acknowledgedWidgetPreflightReadiness = app.staticTexts["growthWidgetHandoffPreflightReadinessSummary"]
        XCTAssertTrue(acknowledgedWidgetPreflightReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedWidgetPreflightReadiness.label, "growthWidgetHandoffPreflightReady:true")

        let acknowledgedGateSummary = app.staticTexts["growthAcknowledgementGateSummary"]
        XCTAssertTrue(acknowledgedGateSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedGateSummary.label.contains("acknowledged:true"))
        XCTAssertTrue(acknowledgedGateSummary.label.contains("allowsCommit:false"))

        let acknowledgedSurfaceSummary = app.staticTexts["growthAcknowledgementSurfaceSummary"]
        XCTAssertTrue(acknowledgedSurfaceSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedSurfaceSummary.label.contains("acknowledged:true"))
        XCTAssertTrue(acknowledgedSurfaceSummary.label.contains("allowsCommit:false"))

        let acknowledgedNoticedMemoryLine = app.staticTexts["growthNoticedMemoryVisibleLine"]
        XCTAssertTrue(acknowledgedNoticedMemoryLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            acknowledgedNoticedMemoryLine.label,
            "Soft tail-tip glow will wait here as a quiet memory."
        )

        let acknowledgedNoticedMemorySummary = app.staticTexts["growthNoticedMemoryLineSummary"]
        XCTAssertTrue(acknowledgedNoticedMemorySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("acknowledged:true"))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("display:true"))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("write:false"))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedNoticedMemorySummary.label.contains("discovery:false"))

        let acknowledgedNoticedMemoryReadiness = app.staticTexts["growthNoticedMemoryLineReadinessSummary"]
        XCTAssertTrue(acknowledgedNoticedMemoryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedNoticedMemoryReadiness.label, "growthNoticedMemoryLineReady:true")

        let acknowledgedBodyAccentCatalogSummary = app.staticTexts["growthBodyAccentNoticedMemoryCatalogSummary"]
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("cue:crescentBelly"))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("trait:bodyAccent"))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("write:false"))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedBodyAccentCatalogSummary.label.contains("discovery:false"))

        let acknowledgedBodyAccentCatalogReadiness = app.staticTexts["growthBodyAccentNoticedMemoryCatalogReadinessSummary"]
        XCTAssertTrue(acknowledgedBodyAccentCatalogReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedBodyAccentCatalogReadiness.label, "growthNoticedMemoryCatalogReady:true")

        let acknowledgedPrioritySummary = app.staticTexts["growthNoticedMemoryPrioritySummary"]
        XCTAssertTrue(acknowledgedPrioritySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("selected:softTailTipGlint"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("candidates:softTailTipGlint+crescentBelly"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("visibleCopyChanged:false"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("write:false"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("mutation:false"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("widget:false"))
        XCTAssertTrue(acknowledgedPrioritySummary.label.contains("discovery:false"))

        let acknowledgedPriorityReadiness = app.staticTexts["growthNoticedMemoryPriorityReadinessSummary"]
        XCTAssertTrue(acknowledgedPriorityReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(acknowledgedPriorityReadiness.label, "growthNoticedMemoryPriorityReady:true")

        let acknowledgedSnapshot = """
            GrowthCeremonyPreviewAcknowledgedSurface
            acknowledgement:\(acknowledgedButton.label)
            noticedMemoryLine:\(acknowledgedNoticedMemoryLine.label)
            familyMemoryLine:\(acknowledgedFamilyMemoryLine.label)
            inheritedVisualMemoryLine:\(acknowledgedInheritedVisualMemoryLine.label)
            \(acknowledgedInheritedVisualMemorySummary.label)
            \(acknowledgedInheritedVisualMemoryReadiness.label)
            \(acknowledgedInheritedVisualPromotionGate.label)
            \(acknowledgedInheritedVisualPromotionReadiness.label)
            \(acknowledgedInheritedVisualPromotionDeferral.label)
            \(acknowledgedInheritedVisualPromotionDeferralReadiness.label)
            comparisonLine:\(acknowledgedComparisonLine.label)
            \(acknowledgedBeforeAfterSummary.label)
            \(acknowledgedBeforeAfterStageCuePairSummary.label)
            \(acknowledgedBeforeAfterStageCuePairReadiness.label)
            \(acknowledgedHornBudPreviewSummary.label)
            \(acknowledgedHornBudPreviewReadiness.label)
            \(acknowledgedGateSummary.label)
            \(acknowledgedSurfaceSummary.label)
            \(acknowledgedNoticedMemorySummary.label)
            \(acknowledgedNoticedMemoryReadiness.label)
            \(acknowledgedBodyAccentCatalogSummary.label)
            \(acknowledgedBodyAccentCatalogReadiness.label)
            \(acknowledgedPrioritySummary.label)
            \(acknowledgedPriorityReadiness.label)
            \(acknowledgedPersistenceSummary.label)
            \(acknowledgedWidgetPreflightSummary.label)
            \(acknowledgedWidgetPreflightReadiness.label)
            \(affectionReadiness.label)
            """ + "\n"

        assertSnapshot(
            of: acknowledgedSnapshot,
            as: .lines,
            named: "growth-ceremony-preview-acknowledged-surface"
        )

        try assertReferenceDeviceImageSnapshot(
            of: app.windows.firstMatch.screenshot().image.croppingStatusBarForSnapshot(),
            named: "growth-ceremony-preview-acknowledged-reference"
        )
    }

    @MainActor
    func testLineageMemorySheetShowsGenerationLineReadOnly() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-lineage-memory-sheet-preview"]
        app.launch()

        let sheet = app.otherElements["lineageObservationMemorySheet"]
        XCTAssertTrue(sheet.waitForExistence(timeout: 12))

        let generationLine = app.staticTexts["lineageObservationFamilyTreeEntryGenerationLine"]
        XCTAssertTrue(generationLine.waitForExistence(timeout: 2))
        XCTAssertEqual(generationLine.label, "First ancestor is the first memory this line knows.")

        let householdLine = app.staticTexts["lineageObservationMemorySheetHouseholdLine"]
        XCTAssertTrue(householdLine.waitForExistence(timeout: 2))
        XCTAssertEqual(householdLine.label, "This echo now belongs to this family's quiet line.")

        let sheetSummary = app.staticTexts["lineageObservationMemorySheetSummary"]
        XCTAssertTrue(sheetSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(sheetSummary.label.contains("householdLine:true"))
        XCTAssertTrue(sheetSummary.label.contains("readOnly:true"))
        XCTAssertTrue(sheetSummary.label.contains("graphNavigation:false"))
        XCTAssertTrue(sheetSummary.label.contains("persistence:false"))
        XCTAssertTrue(sheetSummary.label.contains("breeding:false"))
        XCTAssertTrue(sheetSummary.label.contains("optimization:false"))

        let entrySummary = app.staticTexts["lineageObservationFamilyTreeEntrySummary"]
        XCTAssertTrue(entrySummary.waitForExistence(timeout: 2))
        XCTAssertTrue(entrySummary.label.contains("generationLine:true"))
        XCTAssertTrue(entrySummary.label.contains("readOnly:true"))
        XCTAssertTrue(entrySummary.label.contains("graphNavigation:false"))
        XCTAssertTrue(entrySummary.label.contains("persistence:false"))
        XCTAssertTrue(entrySummary.label.contains("breeding:false"))
        XCTAssertTrue(entrySummary.label.contains("optimization:false"))

        let entryReadiness = app.staticTexts["lineageObservationFamilyTreeEntryReadinessSummary"]
        XCTAssertTrue(entryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(entryReadiness.label, "lineageObservationFamilyTreeEntryReady:true")
    }

    @MainActor
    func testLineageFamilyQASnapshotHostProtectsReadOnlyFamilyMemorySurface() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-snapshot-host-lineage-family"]
        app.launch()

        let hostEntry = app.staticTexts["lineageSnapshotHostEntrySummary"]
        XCTAssertTrue(hostEntry.waitForExistence(timeout: 12))
        XCTAssertTrue(hostEntry.label.contains("surface:lineageFamilyQA"))
        XCTAssertTrue(hostEntry.label.contains("appHost:true"))
        XCTAssertTrue(hostEntry.label.contains("referenceImage:false"))

        let familyTree = app.staticTexts["lineageFamilyTreeTeaserSurfaceSummary"]
        XCTAssertTrue(familyTree.waitForExistence(timeout: 2))
        XCTAssertTrue(familyTree.label.contains("childDraft:ready"))
        XCTAssertTrue(familyTree.label.contains("navigation:false"))
        XCTAssertTrue(familyTree.label.contains("persistence:false"))
        XCTAssertTrue(familyTree.label.contains("breeding:false"))
        XCTAssertTrue(familyTree.label.contains("optimization:false"))

        let branch = app.staticTexts["lineageFamilyBranchPreviewSummary"]
        XCTAssertTrue(branch.waitForExistence(timeout: 2))
        XCTAssertTrue(branch.label.contains("generations:3"))
        XCTAssertTrue(branch.label.contains("nodes:4"))
        XCTAssertTrue(branch.label.contains("edges:3"))
        XCTAssertTrue(branch.label.contains("navigation:false"))
        XCTAssertTrue(branch.label.contains("persistence:false"))
        XCTAssertTrue(branch.label.contains("breeding:false"))
        XCTAssertTrue(branch.label.contains("optimization:false"))

        let branchReadiness = app.staticTexts["lineageFamilyBranchPreviewReadinessSummary"]
        XCTAssertTrue(branchReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(branchReadiness.label, "lineageFamilyBranchPreviewReady:true")

        let readOnlyTextReadiness = app.staticTexts["lineageReadOnlyPreviewSurfaceTextReadinessSummary"]
        XCTAssertTrue(readOnlyTextReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(readOnlyTextReadiness.label, "lineageReadOnlyPreviewSurfaceTextReady:true")

        let readOnlyTextSummary = app.staticTexts["lineageReadOnlyPreviewSurfaceTextSummary"]
        XCTAssertTrue(readOnlyTextSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(readOnlyTextSummary.label.contains("lines:5"))
        XCTAssertTrue(readOnlyTextSummary.label.contains("readOnly:true"))
        XCTAssertTrue(readOnlyTextSummary.label.contains("hiddenRandomDetails:false"))

        let readOnlyTextSnapshot = app.staticTexts["lineageReadOnlyPreviewSurfaceTextSnapshot"]
        XCTAssertTrue(readOnlyTextSnapshot.waitForExistence(timeout: 2))
        XCTAssertTrue(readOnlyTextSnapshot.label.contains("Family preview"))
        XCTAssertTrue(readOnlyTextSnapshot.label.contains("A quiet look at what this line may remember."))
        XCTAssertTrue(readOnlyTextSnapshot.label.contains("This draft stays closest to Luma."))
        XCTAssertTrue(readOnlyTextSnapshot.label.contains("Mira may lend a"))
        XCTAssertTrue(readOnlyTextSnapshot.label.contains("Family resemblance stays stronger than the surprise."))
        XCTAssertFalse(readOnlyTextSnapshot.label.lowercased().contains("seed"))
        XCTAssertFalse(readOnlyTextSnapshot.label.lowercased().contains("random"))

        let branchCaptionReadiness = app.staticTexts["lineageBranchCaptionTextReadinessSummary"]
        XCTAssertTrue(branchCaptionReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(branchCaptionReadiness.label, "lineageBranchCaptionTextReady:true")

        let branchCaptionSummary = app.staticTexts["lineageBranchCaptionTextSummary"]
        XCTAssertTrue(branchCaptionSummary.waitForExistence(timeout: 2))
        XCTAssertTrue(branchCaptionSummary.label.contains("ancestor:Ori"))
        XCTAssertTrue(branchCaptionSummary.label.contains("members:Luma+Mira"))
        XCTAssertTrue(branchCaptionSummary.label.contains("draft:Draft memory"))
        XCTAssertTrue(branchCaptionSummary.label.contains("lines:2"))
        XCTAssertTrue(branchCaptionSummary.label.contains("readOnly:true"))
        XCTAssertTrue(branchCaptionSummary.label.contains("hiddenRandomDetails:false"))

        let branchCaptionSnapshot = app.staticTexts["lineageBranchCaptionTextSnapshot"]
        XCTAssertTrue(branchCaptionSnapshot.waitForExistence(timeout: 2))
        XCTAssertTrue(branchCaptionSnapshot.label.contains("Ori's line holds Luma and Mira close while Draft memory waits as a quiet memory."))
        XCTAssertTrue(branchCaptionSnapshot.label.contains("Family resemblance stays stronger than the surprise."))
        XCTAssertFalse(branchCaptionSnapshot.label.lowercased().contains("seed"))
        XCTAssertFalse(branchCaptionSnapshot.label.lowercased().contains("random"))

        let familyMemoryContinuityLine = app.staticTexts["lineageFamilyMemoryContinuityLine"]
        XCTAssertTrue(familyMemoryContinuityLine.waitForExistence(timeout: 2))
        XCTAssertEqual(
            familyMemoryContinuityLine.label,
            "Luma's family memories can stay with the grown shape."
        )

        let familyMemoryContinuity = app.staticTexts["lineageFamilyMemoryContinuitySummary"]
        XCTAssertTrue(familyMemoryContinuity.waitForExistence(timeout: 2))
        XCTAssertTrue(familyMemoryContinuity.label.contains("source:growthCeremony"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("readOnly:true"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("navigation:false"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("persistence:false"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("breeding:false"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("optimization:false"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("widget:false"))
        XCTAssertTrue(familyMemoryContinuity.label.contains("playerFacing:false"))

        let familyMemoryContinuityReadiness = app.staticTexts["lineageFamilyMemoryContinuityReadinessSummary"]
        XCTAssertTrue(familyMemoryContinuityReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(familyMemoryContinuityReadiness.label, "lineageFamilyMemoryContinuityReady:true")

        let ancestorMemoryCard = app.staticTexts["lineageAncestorPortraitMemoryCardSummary"]
        XCTAssertTrue(ancestorMemoryCard.waitForExistence(timeout: 2))
        XCTAssertTrue(ancestorMemoryCard.label.contains("ancestor:Ori"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("portrait:Ori portrait"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("changed:face"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("inheritedCue:fairy winglets"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("changedCue:soft deer-face echo"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("readOnly:true"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("seed:false"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("persistence:false"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("breeding:false"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("optimization:false"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("widget:false"))
        XCTAssertTrue(ancestorMemoryCard.label.contains("playerFacing:false"))

        let ancestorMemoryCardReadiness = app.staticTexts["lineageAncestorPortraitMemoryCardReadinessSummary"]
        XCTAssertTrue(ancestorMemoryCardReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(ancestorMemoryCardReadiness.label, "lineageAncestorPortraitMemoryCardReady:true")

        let evidence = app.staticTexts["lineageDraftMemoryEvidenceReviewSurfaceSummary"]
        XCTAssertTrue(evidence.waitForExistence(timeout: 2))
        XCTAssertTrue(evidence.label.contains("persistence:false"))
        XCTAssertTrue(evidence.label.contains("createsChild:false"))

        let acknowledgement = app.staticTexts["lineageDraftMemoryAcknowledgementReviewSurfaceSummary"]
        XCTAssertTrue(acknowledgement.waitForExistence(timeout: 2))
        XCTAssertTrue(acknowledgement.label.contains("commit:false"))
        XCTAssertTrue(acknowledgement.label.contains("persistence:false"))

        let intent = app.staticTexts["lineageDraftMemoryExplicitIntentGateSummary"]
        XCTAssertTrue(intent.waitForExistence(timeout: 2))
        XCTAssertTrue(intent.label.contains("intent:false"))
        XCTAssertTrue(intent.label.contains("commit:false"))

        let persistence = app.staticTexts["lineageDraftMemoryPersistenceBoundarySummary"]
        XCTAssertTrue(persistence.waitForExistence(timeout: 2))
        XCTAssertTrue(persistence.label.contains("swiftData:false"))
        XCTAssertTrue(persistence.label.contains("appGroup:false"))
        XCTAssertTrue(persistence.label.contains("createsChild:false"))
        XCTAssertTrue(persistence.label.contains("futureWrite:false"))

        let dryRun = app.staticTexts["lineageDraftMemoryPersistenceDryRunAdapterSummary"]
        XCTAssertTrue(dryRun.waitForExistence(timeout: 2))
        XCTAssertTrue(dryRun.label.contains("dryRun:true"))
        XCTAssertTrue(dryRun.label.contains("write:false"))
        XCTAssertTrue(dryRun.label.contains("createsChild:false"))

        let confirmation = app.staticTexts["lineageDraftMemoryConfirmationCeremonySummary"]
        XCTAssertTrue(confirmation.waitForExistence(timeout: 2))
        XCTAssertTrue(confirmation.label.contains("commit:false"))
        XCTAssertTrue(confirmation.label.contains("persistence:false"))
        XCTAssertTrue(confirmation.label.contains("createsChild:false"))

        let graph = app.staticTexts["lineageFamilyGraphLayoutAdoptionSummary"]
        XCTAssertTrue(graph.waitForExistence(timeout: 2))
        XCTAssertTrue(graph.label.contains("adopt:false"))
        XCTAssertTrue(graph.label.contains("playerFacing:false"))

        let graphLibrary = app.staticTexts["lineageFamilyGraphLayoutLibraryReviewSummary"]
        XCTAssertTrue(graphLibrary.waitForExistence(timeout: 2))
        XCTAssertTrue(graphLibrary.label.contains("candidate:SwiftAlgorithmsCollections"))
        XCTAssertTrue(graphLibrary.label.contains("purpose:branchTraversalAndOrdering"))
        XCTAssertTrue(graphLibrary.label.contains("manualPreferred:true"))
        XCTAssertTrue(graphLibrary.label.contains("adoptGate:false"))
        XCTAssertTrue(graphLibrary.label.contains("dependencyAdded:false"))
        XCTAssertTrue(graphLibrary.label.contains("packageChanged:false"))
        XCTAssertTrue(graphLibrary.label.contains("appBehaviorChanged:false"))
        XCTAssertTrue(graphLibrary.label.contains("playerFacing:false"))

        let graphLibraryReadiness = app.staticTexts["lineageFamilyGraphLayoutLibraryReviewReadinessSummary"]
        XCTAssertTrue(graphLibraryReadiness.waitForExistence(timeout: 2))
        XCTAssertEqual(graphLibraryReadiness.label, "lineageFamilyGraphLayoutLibraryReviewReady:true")

        let snapshotProposal = app.staticTexts["snapshotTestingDependencyProposalSummary"]
        XCTAssertTrue(snapshotProposal.waitForExistence(timeout: 2))
        XCTAssertTrue(snapshotProposal.label.contains("proposalReady:true"))

        let snapshot = """
            LineageFamilyQAAppSurface
            \(hostEntry.label)
            \(familyTree.label)
            \(branch.label)
            \(branchReadiness.label)
            \(readOnlyTextReadiness.label)
            \(readOnlyTextSummary.label)
            \(readOnlyTextSnapshot.label)
            \(branchCaptionReadiness.label)
            \(branchCaptionSummary.label)
            \(branchCaptionSnapshot.label)
            \(familyMemoryContinuityLine.label)
            \(familyMemoryContinuity.label)
            \(familyMemoryContinuityReadiness.label)
            \(ancestorMemoryCard.label)
            \(ancestorMemoryCardReadiness.label)
            \(evidence.label)
            \(acknowledgement.label)
            \(intent.label)
            \(persistence.label)
            \(dryRun.label)
            \(confirmation.label)
            \(graph.label)
            \(graphLibrary.label)
            \(graphLibraryReadiness.label)
            \(snapshotProposal.label)
            """ + "\n"

        assertSnapshot(
            of: snapshot,
            as: .lines,
            named: "lineage-family-qa-app-surface"
        )
    }

    @MainActor
    func testWidgetQAPreviewProtectsSelectiveCompactLineageCue() throws {
        let app = XCUIApplication()
        app.launchArguments = ["--wipet-widget-qa-preview"]
        app.launch()

        let widgetQA = app.scrollViews.firstMatch
        XCTAssertTrue(widgetQA.waitForExistence(timeout: 12))

        let readiness = widgetQA.identifier
        XCTAssertTrue(readiness.contains("widgetPreviewQAReady:true"))
        XCTAssertTrue(readiness.contains("longAncestorFixture:true"))
        XCTAssertTrue(readiness.contains("shortAncestorFixture:true"))
        XCTAssertTrue(readiness.contains("ordinaryDiscoveryFixture:true"))
        XCTAssertTrue(readiness.contains("growthAdvancementFixture:true"))
        XCTAssertTrue(readiness.contains("longSelectiveCue:hidden"))
        XCTAssertTrue(readiness.contains("shortSelectiveCue:Family line"))
        XCTAssertTrue(readiness.contains("ordinarySelectiveCue:hidden"))
        XCTAssertTrue(readiness.contains("growthAdvancementSelectiveCue:hidden"))
        XCTAssertTrue(readiness.contains("longObservationWindowLabel:WiPet observation window. Luma - Lunarian - Gen 3"))
        XCTAssertTrue(readiness.contains("The floating tail shimmer resembles the first ancestor. Juvenile inherited memory"))
        XCTAssertTrue(readiness.contains("shortObservationWindowLabel:WiPet observation window. Luma - Lunarian - Gen 3"))
        XCTAssertTrue(readiness.contains("Tail echoes Nana. Juvenile inherited memory. Family line"))
        XCTAssertTrue(readiness.contains("ordinaryObservationWindowLabel:WiPet observation window. Miri - Sylphian - Gen 1"))
        XCTAssertTrue(readiness.contains("growthAdvancementObservationWindowLabel:WiPet observation window. Luma - Lunarian - Gen 3"))
        XCTAssertTrue(readiness.contains("loadedSource:loaded"))
        XCTAssertTrue(readiness.contains("fallbackSource:fallbackRequired"))

        let snapshot = """
            WidgetQAPreviewSelectiveCompactLineage
            \(readiness)
            """ + "\n"

        assertSnapshot(
            of: snapshot,
            as: .lines,
            named: "widget-qa-selective-compact-lineage"
        )
    }
}

private func assertReferenceDeviceImageSnapshot(
    of image: UIImage,
    named name: String,
    testFilePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line
) throws {
    let referenceURL = imageReferenceURL(
        named: name,
        testFilePath: String(describing: testFilePath),
        testName: testName
    )

    guard let reference = UIImage(contentsOfFile: referenceURL.path),
          let referenceImage = reference.cgImage,
          let capturedImage = image.cgImage
    else {
        assertSnapshot(
            of: image,
            as: .image(precision: 0.99, perceptualPrecision: 0.45),
            named: name,
            testName: testName,
            line: line
        )
        return
    }

    let capturedSize = CGSize(width: capturedImage.width, height: capturedImage.height)
    let referenceSize = CGSize(width: referenceImage.width, height: referenceImage.height)
    guard capturedSize == referenceSize else {
        throw XCTSkip(
            """
            Skipping image snapshot '\(name)' because the cropped screenshot is \
            \(Int(capturedSize.width))x\(Int(capturedSize.height)) px, while the accepted \
            reference is \(Int(referenceSize.width))x\(Int(referenceSize.height)) px. \
            Semantic app-host assertions already ran; rerun on the reference simulator geometry \
            for pixel comparison.
            """
        )
    }

    assertSnapshot(
        of: image,
        as: .image(precision: 0.99, perceptualPrecision: 0.45),
        named: name,
        testName: testName,
        line: line
    )
}

private func imageReferenceURL(
    named name: String,
    testFilePath: String,
    testName: String
) -> URL {
    let testMethodName = testName.split(separator: "(").first.map(String.init) ?? testName
    return URL(fileURLWithPath: testFilePath)
        .deletingLastPathComponent()
        .appendingPathComponent("__Snapshots__")
        .appendingPathComponent("SnapshotHostGenomeVariationTests")
        .appendingPathComponent("\(testMethodName).\(name).png")
}

@MainActor
private func observationHomeForeheadMemoryCueLine(
    route: String,
    id: String,
    file: StaticString = #filePath,
    line: UInt = #line
) throws -> String {
    let app = XCUIApplication()
    app.launchArguments = [route]
    app.launch()
    defer { app.terminate() }

    let portrait = app.otherElements["observationHomeCreaturePortrait"]
    XCTAssertTrue(portrait.waitForExistence(timeout: 12), file: file, line: line)
    XCTAssertTrue(portrait.label.contains("soft forehead memory dots"), file: file, line: line)
    XCTAssertTrue(portrait.label.contains("soft ancestral glint"), file: file, line: line)
    XCTAssertTrue(portrait.label.contains("soft tail memory dots"), file: file, line: line)

    if id == "mira" || id == "selectionMira" {
        XCTAssertTrue(portrait.label.contains("soft wing memory tips"), file: file, line: line)
    } else {
        XCTAssertFalse(portrait.label.contains("soft wing memory tips"), file: file, line: line)
    }

    let cueLine = app.staticTexts["observationHomeCreatureCueLine"]
    XCTAssertTrue(cueLine.waitForExistence(timeout: 2), file: file, line: line)
    XCTAssertTrue(cueLine.label.contains("forehead memory"), file: file, line: line)

    return "\(id)=cue:\(cueLine.label);portrait:\(portrait.label)"
}

@MainActor
private func tapElementWhenVisible(
    _ element: XCUIElement,
    in app: XCUIApplication,
    fallbackLabel: String? = nil,
    maxSwipes: Int = 5,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let scrollView = app.scrollViews.firstMatch
    for _ in 0..<maxSwipes where !element.isHittable {
        if scrollView.exists {
            scrollView.swipeUp()
        } else {
            app.swipeUp()
        }
    }

    if let fallbackLabel {
        let fallback = app.staticTexts[fallbackLabel]
        if fallback.exists {
            fallback.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
            return
        }
    }

    guard element.isHittable else {
        XCTFail("Expected element to be hittable after scrolling: \(element)", file: file, line: line)
        return
    }

    element.tap()
}

private extension UIImage {
    func croppingStatusBarForSnapshot() -> UIImage {
        let topInset: CGFloat = 64
        let cropRect = CGRect(
            x: 0,
            y: topInset * scale,
            width: size.width * scale,
            height: (size.height - topInset) * scale
        )

        guard let croppedImage = cgImage?.cropping(to: cropRect) else {
            return self
        }

        return UIImage(cgImage: croppedImage, scale: scale, orientation: imageOrientation)
    }
}
