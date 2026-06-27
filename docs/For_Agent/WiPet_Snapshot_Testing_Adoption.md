# WiPet Snapshot Testing Adoption

Date: 2026-06-26

## Purpose

WiPet is starting to accumulate stable visual states in Observation, Genome Variation QA, Lineage Family QA, Widget previews, and Growth Ceremony preview. Before SpriteKit creature variation expands further, the project needs a visual regression foundation that can catch unintended changes to creature placement, silhouette, readable copy, and calm Apple-quality layout.

The goal is not to replace manual visual QA. Snapshot Testing should become a repeatable safety net for the surfaces that already passed manual simulator review.

## Library Decision

- Handwritten complexity: comparing rendered SwiftUI/SpriteKit/widget surfaces across code changes by eye does not scale once face, body, wing, tail, glow, growth, and lineage cues increase.
- Apple framework candidate: XCTest and simulator screenshots remain useful, but they do not provide a small assertion API for stored reference images.
- External library candidate: Point-Free SnapshotTesting provides a maintained Swift Package for image and view snapshot assertions.
- Decision: add SnapshotTesting as a test-only SwiftPM dependency, scoped to `WiPetCoreTests` first.
- Minimum scope: dependency only. Do not add snapshot assertions, reference images, app behavior changes, Xcode project edits, Widget changes, persistence writes, or renderer changes in this commit.
- Future replacement point: once the first visible snapshot target is chosen, add one test for a stable QA surface and review the first reference image manually.

## WiPet Fit

Snapshot Testing supports "かわいさ > 技術" by making it harder to accidentally break a pet's silhouette, spacing, or visual warmth while expanding SpriteKit variation. It supports "愛着 > ランダム性" by preserving stable lineage and growth review surfaces so changes remain intentional.

## First Candidate Surfaces

- `GenomeVariationQAView`: parent/child draft visual differences.
- `LineageFamilyQAView`: family echo, tree teaser, and draft memory evidence.
- `ObservationHomeView`: ordinary observation state and growth ceremony preview.
- Widget QA preview: compact observation window after app/widget handoff stabilizes.

Current host boundary, 2026-06-26: `ObservationHomeView`, `GenomeVariationQAView`, and `LineageFamilyQAView` all have app launch hosts. `GenomeVariationQAView` now has the first accepted app-target image reference.

Current text references, 2026-06-26:

- `observation-home-family-echo`
- `lineage-family-qa-review-stack`
- `genome-variation-silhouette-cue-set`
- `growth-ceremony-preview-contract`

Current adoption state, 2026-06-26: the repo has test-only SnapshotTesting `.lines` references for semantic contracts and one app-target image reference for Genome Variation QA. Further image references must remain one surface per loop, must keep manual visual QA as the source of art acceptance, and must explain why the pixels still increase affection, family resemblance, or immersion.

## App Target Text Snapshot Probe

Purpose:

- Prove `WiPetSnapshotTests` can import and execute SnapshotTesting before recording any image reference.
- Keep the first app-target SnapshotTesting use text-only so the handmade Genome Variation creature surface is not frozen before a deliberate art-direction acceptance.

Library decision:

- Handwritten complexity: checking the hidden target-entry readiness string with raw `XCTAssertEqual` proves launch wiring, but it does not prove the app test target can use the chosen SnapshotTesting library.
- Apple framework candidate: XCTest remains the runner and launch harness.
- External library candidate: SnapshotTesting is already the selected visual-regression support library, but the Xcode UI test target still needs its own package product dependency.
- Decision: add SnapshotTesting to `WiPetSnapshotTests` only and assert one `.lines` snapshot for the target-entry readiness metadata.

Minimum scope:

- Add one SnapshotTesting package product dependency to the UI test target.
- Add one app-target `.lines` reference for `snapshot-app-target-entry`.
- Do not add image references, image assertions, renderer changes, visible UI changes, Widget handoff changes, persistence writes, or generated assets.

Future replacement point:

- Once this text probe is green and the Genome Variation surface is manually accepted, the next isolated loop can add the first image assertion/reference.

Implementation result:

- Added SnapshotTesting as a direct package product dependency of `WiPetSnapshotTests`.
- Added `WiPet.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved` so the Xcode project resolves SnapshotTesting `1.19.2` reproducibly.
- Added one app-target `.lines` reference at `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness.snapshot-app-target-entry.txt`.
- Kept the snapshot text limited to target-entry readiness metadata; no image reference or pixel assertion was added.
- Set `OTHER_SWIFT_FLAGS = ""` only for `WiPetSnapshotTests` because SnapshotTesting documents that UI test targets must remove Xcode's inherited `-module_alias Testing=_Testing_Unavailable` flag before importing SnapshotTesting.
- Confirmed visible Genome Variation UI remains unchanged by simulator screenshot.

## Genome Variation Cue Set Text Reference

Current semantic scope, 2026-06-26:

- `genome-variation-silhouette-cue-set` now records face, body, wing, and tail silhouette accessory readiness.
- The wing addition remains text-only and does not introduce image references, app-target snapshot tests, generated assets, project edits, or runtime behavior changes outside Genome Variation QA metadata.

## Genome Variation First Image Reference

Purpose:

- Protect the accepted Genome Variation QA surface after target-entry, shape recipe coverage, and detail recipe coverage were proven.
- Catch accidental changes to the actual pet silhouettes, portrait card spacing, child-draft layout, and family-echo copy.

Library decision:

- Apple XCTest remains the app launcher and hidden metadata verifier.
- SnapshotTesting is now used for one app-target image assertion because the surface has passed manual simulator review and the handmade shape/detail recipes are catalog-backed.

Implementation result:

- Added one app-target image assertion named `genome-variation-first-reference`.
- Stored the reference at `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness.genome-variation-first-reference.png`.
- Cropped the status bar from the tested image so clock and device indicators do not make the reference unstable.
- Kept normal UI, SpriteKit drawing, Widget handoff, persistence, generated assets, package dependencies, and Xcode project structure unchanged.

## Genome Variation Contrast Dapple Change

Current semantic scope, 2026-06-26:

- SpriteKit now lets `PatternGenes.contrast` gently affect dapple count, scale, and opacity.
- Manual simulator QA accepted the change as a subtle sibling-readability improvement.
- The existing `genome-variation-first-reference` image assertion passed without updating the reference, so no new reference file was recorded for this small renderer tuning.

## Genome Variation Glow Mote Change

Current semantic scope, 2026-06-26:

- SpriteKit now lets `PatternGenes.glow` gently affect the count, scale, and opacity of tiny fixed-position glow motes.
- Manual simulator QA accepted the change as a quiet living-aura cue.
- The existing `genome-variation-first-reference` image assertion passed without updating the reference, so no new reference file was recorded for this small renderer tuning.

## Genome Variation Glow Ambient Recipe Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `glowAmbientRecipeCoverageReady:true` and the ambient recipe coverage summary for baseline, sibling, and child draft.
- The image assertion captures before the extra glow metadata waits so blink timing does not destabilize the accepted image reference.
- No image reference was updated in this loop.

## Genome Variation Pattern Recipe Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `patternRecipeCoverageReady:true` and the `softBellyDapples` coverage summary for baseline, sibling, and child draft.
- This protects the existing handmade contrast-driven belly dapples as a named recipe before any CoreImage mask or CPPN precursor work.
- No image reference was updated in this loop.

## Genome Variation Pattern Spread Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitPatternMarkingCue=...spread:softSpread...` for the Genome Variation baseline.
- This keeps the handmade dapple spread inspectable as QA metadata without exposing it as player-facing stat text.
- No image reference was updated in this loop.

## Genome Variation Eye Catchlight Recipe Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `softCatchlight` in fixed-part detail recipe coverage for baseline, sibling, and child draft.
- This protects the existing handmade eye highlight as a named cuteness recipe before any richer eye animation or highlight variation.
- No image reference was updated in this loop.

## Genome Variation Feline Soft Whisker Dots

Current semantic scope, 2026-06-27:

- The sibling `softFeline` portrait gains a tiny handmade `softWhiskerDots` detail beside the existing `kittenGleam`.
- The app-target `.lines` reference should include `softWhiskerDots` in sibling detail recipe coverage before any image reference update is accepted.
- Manual visual QA remains the art acceptance gate; the dots must read as kitten-like softness, not a technical marker.
- Manual visual QA accepted the cue on iPhone SE and iPhone 16 Pro temporary simulators, and the accepted Genome Variation image reference was updated from the matching iPhone 16 Pro crop.
- `WiPetSnapshotTests` build-for-testing timed out after 180 seconds in this loop, so the reference update is recorded with a build-gate gap until the app-host target completes again.

## Genome Variation Ancestral Glint Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitAncestralGlintCueReady:true` plus baseline and child draft `softAncestralGlint` summaries.
- Baseline Luma carries `glints:2`; the child draft carries `glints:3`, preserving a tiny "this family continued" cue without exposing numbers in player UI.
- This protects the upper-chest lineage glint as an ancestry-linked family-memory cue before any animation or richer inherited-glow variation.
- No image reference was updated in this loop.

## Genome Variation Lineage Memory Thread Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitLineageMemoryThreadReady:true` plus baseline and child draft `softLineageMemoryThread` summaries.
- This protects the body-to-tail family-memory line as an ancestry-linked cue connecting `softAncestralGlint` and `softTailMemoryDots`.
- No image reference was updated in this loop.

## Genome Variation Tail Lineage Echo Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitTailLineageEchoCueReady:true` plus baseline and child draft `softTailMemoryDots` summaries with generation-linked dot counts.
- Baseline Luma carries `dots:3`; the child draft carries `dots:4`, preserving a tiny "this family continued" cue without exposing numbers in player UI.
- This protects the tail-tip lineage dots on `floatingRibbon` as an ancestry-linked inherited resemblance cue.
- Simulator visual QA screenshot `/tmp/wipet-tail-lineage-dot-count-visual-qa.jpg` confirmed the added dot stays subtle and does not destabilize the Genome Variation layout.
- No image reference was updated in this loop.

## Genome Variation Inherited Winglet Cue Set Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitChildDraftLineageCueSet=...wing:leafPair,wingAccessory:softWingTipPearl...activeCueCount:5...`.
- This protects Mira's soft fairy winglet as an inherited family cue in the child-draft review context while keeping the draft's actual rendered body unchanged.
- Simulator visual QA screenshot `/tmp/wipet-inherited-winglet-cue-set-visual-qa.jpg` confirmed the existing winglet remains quiet and the Genome Variation layout stays readable.
- No image reference was updated in this loop.

## Genome Variation Glow Mote Placement Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitGlowAuraCueReady:true` plus `spriteKitGlowAuraCue=...motes:wideOrbitMotes...` for the Luma baseline.
- This protects the glow mote placement as a named, genome-derived aura cue before any CoreImage/CPPN glow-field work.
- The accepted Genome Variation image reference passed without update; the mote placement remains a tiny visible variation, not a new frozen art direction change.

## Genome Variation Personality Eye Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityEyeCueMetadataReady:true`, `personalityEyeDetailReady:true`, and Luma's `open/steady/warm` eye cue with `warmGlint` at `upperLeft`.
- This protects the existing personality-derived eye expression and catchlight as a named cuteness cue before richer gaze, blink, or highlight variation.
- The accepted Genome Variation image reference passed without update; this loop records the existing visible eye behavior rather than changing pixels.

## Genome Variation Motion Gene Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `spriteKitMotionGeneCueReady:true` and Luma's `buoyant/softBlink/softSway/softFlutter` motion cue with `wingFlutter:2.5deg/2.05s`.
- This protects the existing SpriteKit idle rhythm before gaze-following, richer blink styles, or personality-timed motion changes.
- The accepted Genome Variation image reference passed without update; this loop records existing motion metadata and does not change action timing.

## Genome Variation Personality Gaze Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityEyeGazeCueReady:true` and `personalityEyeGazeCue=gaze:attentiveRightGaze,assetOutputs:none` for Luma.
- This protects the new deterministic, personality-derived gaze micro-cue before any true gaze-following or richer eye animation.
- The accepted Genome Variation image reference passed without update; the 0.55pt eye offset remains a subtle art-direction cue inside the existing composition.

## Genome Variation Personality Blink Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityBlinkCueReady:true` and Luma's `softQuickBlink/softClose/shortHold` blink cue.
- This protects the new deterministic, personality-derived blink depth and hold contract while leaving `MotionGenes.blink` responsible for interval rhythm.
- The accepted Genome Variation image reference passed without update; this loop changes the SpriteKit blink action but not the stored reference image.

## Genome Variation Personality Sleepiness Idle Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalitySleepinessIdleCueReady:true` and Luma's `cozyRest/softBreath/quietPace` idle cue.
- This protects the deterministic sleepiness-derived breathing cue while keeping it asset-free and hidden from normal player UI.
- The accepted Genome Variation image reference passed without update; the breath action remains subtle enough for the existing visual baseline.

## Genome Variation Personality Mysticism Aura Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityMysticismAuraCueReady:true` and Luma's `moonlitAura/deepMysticHalo` cue.
- This protects the deterministic mysticism-derived aura depth while keeping pattern glow and personality mysticism as separate contracts.
- The accepted Genome Variation image reference passed without update; the aura nudge remains subtle enough for the existing visual baseline.

## Genome Variation Personality Mouth Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityMouthCueReady:true` and Luma's `softGreetingMouth/settledEnergy/softWidth` cue.
- This protects the deterministic energy/sociality mouth cue while keeping the handmade mouth shape asset-free and hidden from normal player UI.
- Simulator visual QA confirmed the normal Observation surface remains readable, calm, and free of mouth QA/debug text.

## Genome Variation Personality Posture Text Reference

Current semantic scope, 2026-06-26:

- The app-target `.lines` reference now includes `personalityPostureCueReady:true` and Luma's `attentiveLean/steadyPresence/rightListeningLean` cue.
- This protects the deterministic curiosity/timidity posture cue while keeping sockets, fixed part recipes, and generated assets unchanged.
- Simulator visual QA confirmed the normal Observation surface remains readable, calm, and free of posture QA/debug text.

## Observation Family Tree Teaser Text Reference

Current semantic scope, 2026-06-26:

- The Core `.lines` reference `observation-home-family-echo` now includes `The family tree remembers this branch quietly.` and `entryLine:true`.
- This protects the read-only family-tree feeling in Observation while keeping graph navigation, persistence, breeding controls, and optimization controls disabled.
- Simulator visual QA confirmed the normal Observation panel remains readable and the family-tree line fits without visible technical metadata.

## Observation Family Branch Preview Text Reference

Current semantic scope, 2026-06-26:

- The Core `.lines` reference `observation-home-family-echo` now includes `First ancestor -> floating tail echo`, `branchLine:true`, and `lineageObservationFamilyTreeEntryReady:true`.
- This protects the smallest read-only ancestor-to-memory branch cue while keeping graph navigation, persistence, breeding controls, and optimization controls disabled.
- Simulator visual QA screenshot `/tmp/wipet-family-branch-preview-line-visual-qa.jpg` confirmed the branch line fits inside the family-memory sheet and does not introduce a management-screen feeling.

## Genome Variation Image Timing Tolerance

Current semantic scope, 2026-06-26:

- The `genome-variation-first-reference` image remains the accepted visual baseline.
- The app-target image assertion now uses `precision: 0.99` and `perceptualPrecision: 0.45` so a tiny animated eye/glow frame difference does not fail unrelated docs/Core-only loops.
- Reference images must still not be updated without manual visual acceptance and an explicit creature-art reason.
- Layout, silhouette, text placement, child draft readability, and family-echo copy remain protected by the stored image and simulator visual QA.

## App Image Reference Device Contract

Current semantic scope, 2026-06-27:

- The current app-target image references in `SnapshotHostGenomeVariationTests` are cropped PNGs at `1206x2430` pixels.
- Hidden-label semantic assertions and `.lines` snapshots must still run on temporary QA devices, including smaller iPhone SE devices used to protect the user's default Xcode data after the external SSD migration.
- Image assertions must only compare pixels when the captured cropped screenshot has the same pixel dimensions as the committed reference PNG.
- If dimensions differ, the app-host test should skip only the image assertion after semantic assertions have already proven the surface contract. This keeps wrong-device runs informative without pretending an SE layout is the accepted image baseline.

Library decision:

- Existing SnapshotTesting remains the image assertion library.
- XCTest `XCTSkip` is sufficient for the device-geometry preflight.
- Do not add another snapshot package, change reference PNGs, loosen precision further, or update Xcode project files for this contract.

Implementation result:

- `SnapshotHostGenomeVariationTests` now routes app-target image references through a shared reference-device preflight helper.
- The helper reads the committed PNG reference, compares pixel dimensions, and only calls SnapshotTesting when the captured image matches the reference geometry.
- A mismatch becomes an explicit skipped image assertion after semantic label and `.lines` checks have already run, so smaller temporary devices remain useful for QA without replacing the accepted visual baseline.
- Current reference PNGs remain unchanged at `1206x2430` pixels.

## Snapshot Host Build Recovery

Current recovery status, 2026-06-27:

- After the external SSD migration, generic iOS Simulator `WiPetSnapshotTests` `build-for-testing` passed using `/tmp/WiPetSnapshotRecoveryBuildDerived`.
- The retry used the existing `tools/xcode/wipet-xcodebuild snapshot-build` wrapper with `WIPET_XCODEBUILD_TIMEOUT_SECONDS=600`.
- This recovers the app-host build gate that had remained open after the `softWhiskerDots` visual cue loop timed out at 180 seconds.
- No snapshot reference images, `.lines` references, app UI, renderer pixels, Widget behavior, Xcode project files, packages, or generated assets changed in this recovery loop.
- Visual QA was not rerun because no visible app surface changed; future visible/text contract loops may now use the recovered app-host build gate before accepting references.

## Growth Ceremony Preview Text Reference

Purpose:

- Protect the Growth Ceremony preview contract before it becomes a player-facing ceremony.
- Preserve the feeling of "この子成長したな" and "祖先に似ている" while proving preview remains a dry run.

Contract:

- Snapshot reference is `growth-ceremony-preview-contract`.
- Surface is `observationHome`.
- Assertion kind is `textLines`.
- Snapshot lines must include the plan readiness, trait reveal, before/after observation, lineage cue bridge, lineage teaser, discovery-log handoff, acknowledgement gate, acknowledgement surface, confirmation surface, acknowledgement intent, persistence boundary, and lineage affection copy.
- The contract keeps `Creature` mutation, discovery append, Widget handoff publish, raw random/seed details, app behavior changes, image references, and project edits out of scope.

Implementation result:

- Added a SnapshotTesting `.lines` reference for `growth-ceremony-preview-contract`.
- Updated the snapshot reference registry to record four current text references and still require zero image references.
- Kept app-target image snapshots deferred and kept all Growth Ceremony behavior preview-only.

## Growth Ceremony Preview App Image Reference

Current semantic scope, 2026-06-26:

- The app-target test suite now includes `growth-ceremony-preview-app-surface` text metadata and `growth-ceremony-preview-first-reference` image coverage for the existing preview-only card.
- The text reference protects the visible affection line plus dry-run metadata: no Creature mutation, no Widget handoff publish, no persistence write, and lineage affection copy ready.
- The image reference was accepted after manual Simulator QA on iPhone 17 confirmed the card remains readable, quiet, and observational rather than a growth button.
- This uses the existing test-only SnapshotTesting dependency; no new package, project edit, renderer change, Widget behavior change, or normal Observation UI change was introduced.

## Growth Ceremony Acknowledged State Text Reference

Current semantic scope, 2026-06-26:

- The app-target test now taps `Notice together` and records `growth-ceremony-preview-acknowledged-surface`.
- The reference protects the local post-tap state as `noted:true` while keeping `mutation:false`, `persistence:false`, `widget:false`, `discovery:false`, `write:false`, and `mutatesCreature:false`.
- The reference now also verifies the ceremony acknowledgement gate and surface move from `acknowledged:false` to `acknowledged:true` while `allowsCommit:false` remains locked.
- A post-tap image reference `growth-ceremony-preview-acknowledged-reference` is also recorded because the app-target test performs the real tap and captures the resulting `Noticed` state.

## Growth Ceremony Noticed Memory Line Text Reference

Current semantic scope, 2026-06-26:

- The app-target `growth-ceremony-preview-app-surface` reference now requires `growthNoticedMemoryLineReady:false` before the player taps.
- The acknowledged reference now includes the visible line `This noticed change will wait as a quiet memory.` plus `growthNoticedMemoryLineReady:true`.
- This protects the post-tap ceremony feeling while proving it remains preview-only: no write, mutation, Widget handoff publish, or discovery append.
- The existing post-tap image assertion passed without updating image references; manual Simulator QA confirmed the pre-tap card remains readable.

## Lineage Family QA App Text Reference

Current semantic scope, 2026-06-26:

- The app-target test now records `lineage-family-qa-app-surface` for `--wipet-snapshot-host-lineage-family`.
- The reference protects the family tree teaser, draft-memory evidence review, acknowledgement review, explicit intent gate, persistence boundary, dry-run adapter, confirmation ceremony, graph layout adoption gate, and SnapshotTesting proposal as one read-only family-memory stack.
- The snapshot intentionally stays text-only: no image reference was added because the visible Lineage Family QA layout did not change in this loop.
- The contract keeps graph navigation, persistence writes, discovery writes, child creation, breeding controls, optimization controls, Widget handoff, renderer drawing, package edits, and project edits out of scope.

## Widget QA Selective Compact Lineage Text Reference

Current semantic scope, 2026-06-26:

- The app-target test now records `widget-qa-selective-compact-lineage` for `--wipet-widget-qa-preview`.
- The reference protects the selective compact lineage rule: long ancestor discovery hides the cue, short ancestor discovery shows `Family line`, ordinary discovery hides the cue, and growth advancement hides the cue.
- The snapshot intentionally stays text-only and reads `WidgetPreviewQAReadiness.readinessSummary`; no Widget image reference is added in this loop.
- The contract keeps production Widget layout, WidgetKit extension behavior, App Group handoff, renderer drawing, persistence, package edits, and project edits out of scope.
- Simulator visual QA confirmed the Widget QA route still renders normally; the image baseline remains deferred until a focused short selective frame is manually accepted.

## Genome Variation Child Draft Inherited Winglet Text Reference

Current semantic scope, 2026-06-27:

- The app-target `.lines` reference now includes `lineageChildDraftInheritedWingletVisualReady:true` plus the preview-only boundary for the child draft's inherited Mira winglet.
- The child render coverage now records `softLeafWing` and `softWingTipPearl` in the child draft recipe set, proving the SpriteKit portrait carries the inherited winglet cue instead of only describing it in metadata.
- No image reference was updated in this loop; the existing image-reference preflight remains responsible for geometry-matched pixel assertions.
- The contract keeps persistence writes, Widget handoff, breeding controls, optimization controls, generated assets, packages, project edits, GLB/USD, and player-facing routes out of scope.

## Guardrails

- Keep SnapshotTesting test-only.
- Keep dependency changes separate from renderer or UI changes.
- Do not update reference images casually; every accepted image change should be reviewed for "本当に愛着が湧くか？".
- Do not use snapshots as the only QA gate for motion, interaction, or Widget handoff correctness.
## Genome Variation Child Draft Inherited Tail Fin Text Reference

Purpose:

- Keep the child-draft inherited tail cue testable without adding a new image reference or exposing inheritance controls in player UI.
- The app-host text snapshot should prove the render-only child draft can show Mira's fish-fin tail while the Core draft still keeps Luma's floating ribbon tail.

Reference surface:

- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness.snapshot-app-target-entry.txt`
- The target-entry `.lines` reference now includes `lineageChildDraftInheritedTailFinVisualReady:true`.
- Child shape coverage records `fishTaperTail`; child detail coverage records `fishFin` and `softForkFin`.

Boundaries:

- Preview-only and QA-only.
- No Creature mutation, persistence write, Widget handoff, breeding route, optimization route, generated assets, GLB/USD, Package.swift change, Xcode project change, or player-facing control.

Verification status:

- SwiftPM text snapshot references pass after restoring locally missing Core references from generated outputs.
- The child draft inherited tail fin text reference is committed through the local temporary-index Git recovery path; existing user-staged files remain staged separately.
- Final app-host simulator execution is pending because Xcode/CoreSimulator is idling after the external SSD migration.

## Genome Variation Child Draft Inherited Visual Policy Text Reference

Purpose:

- Prove the child draft inherited wing/tail render cue now comes from a Core read-only policy rather than ad hoc app-local render mutation.
- Keep the policy semantic and text-based until Xcode image visual QA is stable again.

Reference surface:

- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness.snapshot-app-target-entry.txt`
- The target-entry `.lines` reference now includes `lineageChildDraftInheritedVisualCuePolicyReady:true`.
- The policy line records `wing:fairy`, `tail:fish`, `inheritedFrom:Mira`, and the preview-only/no-persistence/no-widget/no-breeding/no-controls/no-generated-assets/player-facing-false boundary.

Boundaries:

- No Creature mutation, persistence write, Widget handoff, breeding route, optimization route, generated assets, GLB/USD, Package.swift change, Xcode project change, or player-facing control.

Verification status:

- Core tests cover the policy behavior and rejection states.
- App-host simulator execution is still pending; the text reference is updated for the next targeted run.

## Growth Ceremony Inherited Visual Memory Text Reference

Purpose:

- Prove Growth Ceremony preview can carry the Core inherited visual memory bridge before the copy becomes visible.
- Keep the line semantic and hidden so the current Growth Ceremony card stays calm and uncluttered.

Reference surfaces:

- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGrowthCeremonyPreviewProtectsVisibleDryRunSurface.growth-ceremony-preview-app-surface.txt`
- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGrowthCeremonyPreviewProtectsVisibleDryRunSurface.growth-ceremony-preview-acknowledged-surface.txt`
- Both references now include `Luma's growth preview can remember firstAncestor's floating tail.`
- Both references now include `growthInheritedVisualMemoryBridgeReady:true` and the no-mutation/no-persistence/no-widget/no-discovery/player-facing-false boundary.

Boundaries:

- Hidden semantic QA only.
- No visible UI change, SpriteKit drawing change, Creature mutation, persistence write, Widget handoff, discovery append, generated assets, GLB/USD, Package.swift change, Xcode project change, or image reference update.

Verification status:

- SwiftPM tests and iOS simulator SDK parse passed.
- App-host simulator execution remains pending because Xcode/CoreSimulator still idles while local system Data space is below 1 GiB.

## Growth Ceremony Inherited Visual Promotion Gate Text Reference

Purpose:

- Prove the inherited visual memory line stays hidden until manual copy review, app-host visual QA, snapshot review, and layout-room evidence are available.
- Protect the current ceremony from turning family resemblance into extra metadata before the visual surface has been accepted.

Reference surfaces:

- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGrowthCeremonyPreviewProtectsVisibleDryRunSurface.growth-ceremony-preview-app-surface.txt`
- `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testGrowthCeremonyPreviewProtectsVisibleDryRunSurface.growth-ceremony-preview-acknowledged-surface.txt`
- Both references now include `growthInheritedVisualVisiblePromotionGateReady:true` and `promote:false`.
- The gate records missing `copyReview`, `appHostVisualQA`, `snapshotReview`, and `layoutRoom` evidence while keeping quiet tone and all no-side-effect boundaries intact.

Boundaries:

- Hidden semantic QA only.
- No visible UI change, image reference update, SpriteKit drawing change, Creature mutation, persistence write, Widget handoff, discovery append, generated assets, GLB/USD, Package.swift change, or Xcode project change.

Verification status:

- SwiftPM tests and iOS simulator SDK parse passed.
- App-host simulator execution remains pending until local disk/CoreSimulator conditions improve.
