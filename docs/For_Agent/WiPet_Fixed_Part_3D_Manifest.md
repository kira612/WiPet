# WiPet Fixed Part 3D Manifest

This document defines the first tracked bridge from the current SpriteKit fixed-part vocabulary to future grayscale GLB/USD assets.

The goal is not to start 3D production yet. The goal is to make every future asset name, socket, and rig expectation boringly predictable before any modeling work begins.

Core question:

> 本当に愛着が湧くか？

## Library Decision

Handwritten complexity:

- WiPet-specific part names, cute silhouette intent, socket roles, and rig expectations.

Apple framework candidates:

- ModelIO, SceneKit, and RealityKit are good future candidates for GLB/USD import, preview, and socket validation.
- They are not needed for this manifest because no real 3D asset files are introduced in this slice.

External library candidates:

- None for this loop.

Decision:

- Keep this as docs plus deterministic Core metadata.
- Do not add ModelIO, SceneKit, RealityKit, package changes, Xcode project changes, generated assets, reference images, or GLB/USD files yet.

Future replacement point:

- When the first GLB/USD file exists, this manifest becomes the checklist for a ModelIO/SceneKit/RealityKit validation loop.

## File Stem Rule

Future fixed-part asset stems use:

`wipet_<part-domain>_<base-id>_<stage-or-role>_v001`

Examples:

- `wipet_face_round_head_v001`
- `wipet_face_deer_head_v001`
- `wipet_upperbody_aquarian_baby_v001`
- `wipet_upperbody_aquarian_adult_v001`
- `wipet_wing_plant_pair_v001`
- `wipet_tail_floating_tail_v001`

Every production asset should export both:

- `.glb`
- `.usd`

## Material Rule

Fixed-part library assets are grayscale only.

They must not include:

- final color
- final pattern
- final glow

Color, pattern, and glow remain genome-driven runtime expression layers.

## Rig Rule

All assets must connect to `CommonPetRig`.

Required bones:

- `root`
- `body`
- `spine_1`
- `spine_2`
- `neck`
- `head`
- `eye_L`
- `eye_R`
- `ear_L`
- `ear_R`
- `horn_L`
- `horn_R`
- `wing_L`
- `wing_R`
- `tail_1`
- `tail_2`
- `tail_3`

## Socket Rule

Current SpriteKit sockets map to future rig targets:

- `bodyCenter` -> `body`
- `headCenter` -> `head`
- `leftWingRoot` -> `wing_L`
- `rightWingRoot` -> `wing_R`
- `tailRoot` -> `tail_1`

The code-backed contract for this mapping is `CommonPetRigSocketMap` in
`Sources/WiPetCore/Parts.swift`. Future PNG, GLB, USD, ModelIO, SceneKit, or
RealityKit validation must use that typed map as the source of truth before
claiming a fixed part is socket-compatible.

Future ear, horn, crystal, and glow sockets must be added only after the 2D creature remains readable with the current Face/UpperBody/Wing/Tail set.

## Current Manifest Scope

This manifest covers current Face, UpperBody, Wing, and Tail bases.

It does not create:

- GLB files
- USD files
- PNG reference sheets
- ModelIO import code
- SceneKit preview code
- RealityKit preview code
- CommonPetRig asset files

Those are future loops.

## Lineage Cue Reference Annotations

Current SpriteKit lineage cues should become reference-sheet annotations before they become 3D geometry, textures, particles, or generated assets.

These annotations are not grayscale mesh details yet. They tell future modelers where the family-memory cue is allowed to be documented on a PNG reference sheet:

- `softAncestralGlint` -> `UpperBody.lunarian@bodyCenter`, panel `lineageCue`
- `softTailMemoryDots` -> `TailBase.floating@tailRoot`, panel `lineageCue`
- `softLineageMemoryThread` -> `UpperBody.lunarian@bodyCenter+TailBase.floating@tailRoot`, panel `lineageCue`

Required reference panels for these cues:

- `lineageCue`
- `socketDiagram`
- `rigDiagram`

When the three cues are reviewed as one lineage cue set, the future PNG reference sheet must include:

- `frontView`
- `sideView`
- `threeQuarterView`
- `socketDiagram`
- `rigDiagram`
- `lineageCue`

Cue set socket notes:

- `softAncestralGlint` anchors to `bodyCenter` -> `body`
- `softLineageMemoryThread` spans `bodyCenter` -> `body` and `tailRoot` -> `tail_1`
- `softTailMemoryDots` anchors to `tailRoot` -> `tail_1`

Child draft lineage cue reference:

- `softDeer` anchors to `headCenter` -> `head`
- `forestDots` anchors to `headCenter` -> `head`
- `softAncestralGlint` anchors to `bodyCenter` -> `body`
- `softLineageMemoryThread` spans `bodyCenter` -> `body` and `tailRoot` -> `tail_1`
- `softTailMemoryDots` anchors to `tailRoot` -> `tail_1`
- This reference is a child-draft art-direction handoff only; it does not create a new mesh, texture, particle, PNG, GLB, or USD output.

Child draft lineage cue acceptance gate:

- Child draft reference metadata must be ready.
- Manual art-direction review is not complete.
- Snapshot reference is not accepted.
- Reference image is not accepted.
- Generation remains disabled.
- Generated assets remain false.
- Asset outputs remain `none`.

Accessory reference annotations:

- `softEarNubs` -> `FaceBase.deer@headCenter`, panel `accessoryCue`; future asset handoff anchors the deer face at `headCenter` -> `head`
- `softEarTips` -> `FaceBase.feline@headCenter`, panel `accessoryCue`
- `softShoulderPetals` -> `UpperBody.sylphian@bodyCenter`, panel `accessoryCue`
- `softMoonShoulderCrescents` -> `UpperBody.lunarian@bodyCenter`, panel `accessoryCue`
- `leafShoulderNubs` -> `UpperBody.verdant@bodyCenter`, panel `accessoryCue`
- `softWingTipPearl` -> `WingBase.fairy@wingTip`, panel `accessoryCue`; future asset handoff anchors the fairy wing pair at `leftWingRoot+rightWingRoot` -> `wing_L+wing_R`
- `softWingTipClaw` -> `WingBase.dragon@wingTip`, panel `accessoryCue`; future asset handoff anchors the dragon wing pair at `leftWingRoot+rightWingRoot` -> `wing_L+wing_R`
- `softForkFin` -> `TailBase.fish@tailTip`, panel `accessoryCue`; future asset handoff anchors the fish tail base at `tailRoot` -> `tail_1`
- `softTetherDot` -> `TailBase.floating@tailTip`, panel `accessoryCue`
- `softDrakeRidge` -> `TailBase.dragon@tailTip`, panel `accessoryCue`; future asset handoff anchors the dragon tail base at `tailRoot` -> `tail_1`
- `softLeafVein` -> `TailBase.plant@tailTip`, panel `accessoryCue`; future asset handoff anchors the plant tail base at `tailRoot` -> `tail_1`

Accessory reference annotation rules:

- The accessory recipe bridge must be ready before accessory annotations can be used for future reference sheets.
- Required panels are `accessoryCue`, `socketDiagram`, and `rigDiagram`.
- Accessory annotations are reference-sheet language only; they do not create mesh, texture, particle, PNG, GLB, or USD output.
- `softShoulderPetals` must remain paired, small, and shoulder-owned for the Sylphian body; it supports sibling recognition but is not a detachable flower prop or generated ornament.
- `softMoonShoulderCrescents` must remain small shoulder silhouette language for the Lunarian body; it is not a glow effect, rarity mark, or detachable accessory.
- Keep accessory cues soft, readable, and secondary to the pet's cute silhouette.

Accessory reference-sheet preflight:

- Accessory reference annotations must be ready.
- Fixed-part manual review checklist metadata must be ready.
- Fixed-part manual review result state metadata must be ready.
- Fixed-part review evidence fields metadata must be ready.
- Candidate PNG does not exist yet.
- Generation remains disabled.
- Snapshot/reference acceptance remains false.
- Runtime loading remains false.
- Asset outputs remain `none`.

Accessory manual review checklist:

- `softAccessoryScale`: accessories remain small and secondary to the pet's face/body silhouette.
- `socketOwnership`: every accessory clearly belongs to the intended face, body, wing, or tail socket.
- `silhouetteSecondary`: the accessory never overpowers the base part silhouette.
- `cuteReadability`: the accessory reads as gentle and friendly, not sharp, realistic, or uncanny.
- `familyLikenessSafe`: the accessory can support lineage memory without becoming a rarity/stat badge.
- `grayscaleOnly`: the fixed-part reference remains shape-only.
- `noColorPatternGlow`: color, pattern, and glow stay outside fixed-part geometry.
- `noGeneratedGeometry`: the checklist does not authorize mesh, texture, particle, PNG, GLB, or USD generation.

Accessory review evidence handoff:

- Accessory manual review checklist metadata must be ready.
- Evidence fields are `reviewerNote`, `checkedItems`, `visualQAImage`, `decisionReason`, `affectionRisk`, and `revisionNotes`.
- Evidence is not recorded yet.
- Evidence path is empty.
- Reviewer note is empty.
- Snapshot/reference acceptance remains false.
- Generation remains disabled.
- Runtime loading remains false.
- Generated assets remain false.
- Asset outputs remain `none`.

Accessory artifact candidate record:

- Accessory review evidence handoff metadata must be ready.
- Artifact stem is `wipet_fixed_part_accessory_reference_sheet_v1`.
- Relative path is `docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png`.
- Format is `png`.
- Surface is `fixedPartAccessoryReferenceSheet`.
- Candidate file does not exist yet.
- Generation remains disabled.
- Snapshot/reference acceptance remains false.
- Runtime loading remains false.
- Generated assets remain false.
- Asset outputs remain `none`.
- This record reserves the future review target only; it does not create PNG, GLB, USD, mesh, texture, particle, or runtime asset output.

Panel layout guidance:

- `frontView`: preserve the cute silhouette and readable face/body/tail proportions.
- `sideView`: show depth and tail attachment without adding new anatomy.
- `threeQuarterView`: show volume relationships between body, head, wings, and tail.
- `socketDiagram`: label `bodyCenter` and `tailRoot` clearly for the lineage cue set.
- `rigDiagram`: show `CommonPetRig`, especially `body` and `tail_1`.
- `lineageCue`: annotate `softLineageCueSet` as family-memory review language only.

Required callouts:

- `cuteSilhouette`
- `bodyCenter`
- `tailRoot`
- `CommonPetRig`
- `noColorPatternGlow`
- `noGeneratedGeometry`

Reference-sheet acceptance gate:

- `fixedPartLineageCueSetReferenceSheetReady` must be true.
- `fixedPartReferenceSheetPanelLayoutReady` must be true.
- Manual art-direction review is still required before any generated PNG is accepted.
- Snapshot/reference acceptance is still required before any generated PNG can become a regression reference.
- Generation remains disabled until review and acceptance are recorded in a separate loop.

First PNG artifact naming:

- Artifact stem: `wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1`
- Relative path: `docs/For_Agent/reference_sheets/wipet_fixed_part_soft_lineage_cue_set_reference_sheet_v1.png`
- Format: `png`
- Surface: `fixedPartReferenceSheet`
- Cue set: `softLineageCueSet`
- Status: not generated, not accepted, not snapshot-validated, not runtime-loaded.

Manual review checklist fields:

- `cuteSilhouette`
- `panelCompleteness`
- `bodyCenter`
- `tailRoot`
- `CommonPetRig`
- `softLineageCueSet`
- `grayscaleOnly`
- `noColorPatternGlow`
- `noGeneratedGeometry`

Review role:

- `CreatureArtDirector`

Manual review result states:

- `notStarted`: no PNG candidate exists, so review is open and no approval can be implied.
- `needsRevision`: future state for a generated PNG that preserves traceability but fails one or more checklist fields.
- `accepted`: future state for a generated PNG that passes art direction and can move toward snapshot/reference validation.

Current review result:

- `notStarted`

Review evidence fields:

- `artifactPath`
- `reviewerNote`
- `checkedItems`
- `visualQAImage`
- `snapshotReference`
- `decisionReason`

Current review evidence:

- Evidence is not recorded.
- Evidence path is empty.
- Reviewer note is empty.
- Snapshot reference is not accepted.

PNG candidate generation preflight:

- Artifact naming metadata must be ready.
- Manual review checklist metadata must be ready.
- Manual review result state must be `notStarted`.
- Review evidence fields metadata must be ready.
- Candidate PNG does not exist yet.
- Generation remains disabled.

App QA exposure:

- Genome Variation snapshot-host hidden QA must expose `fixedPartReferenceSheetPNGCandidatePreflightSummary`.
- Genome Variation snapshot-host hidden QA must expose `fixedPartReferenceSheetPNGCandidatePreflightReadinessSummary`.
- The exposed summary must keep `candidateExists:false`, `generationAllowed:false`, `snapshotAccepted:false`, `runtimeLoaded:false`, and `assetOutputs:none`.
- Exposing this metadata does not authorize a PNG candidate, image baseline update, GLB/USD output, or runtime asset load.

Rules:

- Do not bake final color, glow, or pattern into fixed-part meshes.
- Do not create GLB/USD files from these annotations alone.
- Do not generate a PNG reference sheet until the panel layout contract is accepted.
- Do not add ModelIO, SceneKit, or RealityKit validation until there is an actual asset or reference sheet to validate.
- Keep the annotation tied to affection and family memory, not rarity, stats, breeding, or optimization.
- Treat `softLineageMemoryThread` as a cross-part annotation that documents a gentle family-memory thread between body and tail sockets; do not turn it into standalone geometry before the 2D cue feels stable.
- Treat `softLineageCueSet` as a reference-sheet review grouping only; it is not a generated asset, texture atlas, particle system, or mesh family.
- Treat child draft `softDeer` + `forestDots` as face-memory reference language only until a manually accepted child draft reference image exists.
- Treat accessory annotations as socket and panel labels only until a manually accepted accessory reference sheet exists.
- Treat the accessory reference-sheet preflight as a closed gate; it connects annotations to review metadata but does not authorize candidate generation.
- Treat the accessory manual review checklist as art-direction criteria, not as generated geometry or collectible decoration rules.
- Treat accessory review evidence handoff as empty slots only until a real Creature Art Director review records evidence.
- Treat the accessory artifact candidate record as a reserved future PNG path only until generation is explicitly authorized in a later loop.
- Treat the Horn Base reference evidence handoff as metadata only: it links the accepted `tinyRoundedHornBud` SpriteKit cue to future review panels, sockets, and rig labels, but it does not record final evidence or authorize generation.

Horn Base socket art-direction gate:

- Horn Base remains an art-direction and socket contract only; it does not authorize visible horn geometry yet.
- Accepted early variants are `dormantBud`, `tinyRoundedBud`, and `softCrescentBud`.
- Socket labels are `headTopCenter` for single-bud reading and `headTopPair` for paired future rig placement.
- Future rig targets are `horn_L` and `horn_R` on `CommonPetRig`.
- Silhouette rule is `roundedNonSharp`.
- Horn buds must read as growth, not weaponry, rarity, combat, or optimization.
- The dormant baseline portrait remains hidden for Horn Base geometry; the accepted `tinyRoundedBud` QA surface is the only current visible handoff source.
- Generated geometry remains disabled.
- Asset outputs remain `none`.

Horn Base reference-sheet requirements:

- Future PNG reference sheets must include `frontView`, `sideView`, `threeQuarterView`, `socketDiagram`, and `rigDiagram` before any GLB/USD work.
- The `socketDiagram` must label `headTopCenter` and `headTopPair`.
- The `rigDiagram` must label `horn_L` and `horn_R`.
- The reference sheet must preserve a cute face-first silhouette; horn buds are secondary growth cues.

SpriteKit visible Horn Base cue:

- `dormantBud` remains hidden.
- `tinyRoundedBud` may render as a single small rounded head-top bud after manual visual QA.
- `softCrescentBud` may render as a tiny paired rounded bud after manual visual QA.
- The visible SpriteKit bud is a handmade 2D cue only; it does not create GLB, USD, PNG, mesh, texture, particle, or runtime asset output.
- The cue must remain secondary to the face and must be removed or revised if it reads as sharp, aggressive, rare, collectible, or stat-like.

Horn Base reference evidence handoff:

- Source cue is `tinyRoundedHornBud`.
- Required future panels are `frontView`, `sideView`, `threeQuarterView`, `socketDiagram`, and `rigDiagram`.
- Required socket labels remain `headTopCenter` and `headTopPair`.
- Required rig targets remain `horn_L` and `horn_R`.
- Manual visual QA may be marked accepted for the current 2D cue, but final reference-sheet evidence remains unrecorded until a real artifact path and reviewer note exist.
- Generated geometry, runtime loading, snapshot acceptance, and asset outputs remain disabled.

Face Base reference evidence handoff:

- Source cues are `softDeer+softEarNubs` and `softFeline+softEarTips`.
- Required future panels are `frontView`, `sideView`, `threeQuarterView`, `socketDiagram`, `rigDiagram`, and `accessoryCue`.
- Required socket label remains `headCenter`.
- Required rig target remains `head`.
- Silhouette rule is `secondarySoftEarAccessories`.
- Manual visual QA may be marked accepted for the current 2D cues, but final reference-sheet evidence remains unrecorded until a real artifact path and reviewer note exist.
- The Deer and Feline face accessories must stay soft, secondary, and recognizable as family-safe face language; they must not become rarity marks, stats, detachable props, or sharp/realistic anatomy.
- Generated geometry, runtime loading, snapshot acceptance, and asset outputs remain disabled.

## Upper Body Proportion Handoff

`BodyProportionCue` labels are the SpriteKit art-direction bridge for future Upper Body Base assets. They preserve the handmade body silhouette vocabulary before any grayscale mesh exists.

Current handoff mappings:

- `waterDrop|wideSoft|roundedBelly|gentleWaterPuff` -> `UpperBody.aquarian@bodyCenter#proportionCue`
- `seedPetal|petalSlim|tallSprout|lightFairySeed` -> `UpperBody.sylphian@bodyCenter#proportionCue`
- `pebbleGem|gemBalanced|tallFacet|softPebbleGem` -> `UpperBody.crystalian@bodyCenter#proportionCue`
- `moonOval|moonBalanced|quietOval|familiarMoonBelly` -> `UpperBody.lunarian@bodyCenter#proportionCue`
- `leafBelly|leafWide|lowSprout|softLeafBelly` -> `UpperBody.verdant@bodyCenter#proportionCue`

Socket and rig rules:

- All Upper Body proportion handoff mappings anchor to `bodyCenter`.
- Future rig target is `body` on `CommonPetRig`.
- The handoff is a naming and art-direction contract only; it does not create a mesh, texture, PNG, GLB, USD, or runtime asset.

Required future reference panels:

- `frontView`
- `sideView`
- `threeQuarterView`
- `socketDiagram`
- `rigDiagram`

Acceptance rules:

- Preserve a cute, readable body silhouette for each Upper Body base.
- Keep body proportion language connected to affection, not stats, rarity, or optimization.
- Keep final color, pattern, and glow outside fixed-part geometry.
- Do not add ModelIO, SceneKit, or RealityKit validation until an actual reference sheet, GLB, or USD exists.
- Generated assets remain disabled and asset outputs remain `none` until a later dedicated asset-pipeline loop.

## CommonPetRig Asset Validation Preflight

`CommonPetRigAssetValidationPreflight` in `Sources/WiPetCore/Parts.swift` is the code-backed gate between this manifest and future Apple 3D framework adoption.

Default state:

- The `CommonPetRigSocketMap` must be ready.
- No accepted reference artifact is recorded yet.
- No GLB/USD or socket-preview asset candidate is recorded yet.
- ModelIO, SceneKit, and RealityKit remain disabled.
- Generated geometry remains disabled.
- Runtime asset loading remains disabled.
- Asset outputs remain `none`.

Validation may be reopened only after:

- A real manually accepted reference sheet or asset candidate exists.
- ModelIO is explicitly enabled in a dedicated asset-validation loop.
- SceneKit or RealityKit preview is justified separately after import validation.
- The loop still preserves grayscale-only fixed parts and keeps color, pattern, and glow outside the mesh.

This gate exists to protect affection and art direction: a part is not "validated" because a framework can load it; it is validated only when the asset still feels cute, readable, and connected to the WiPet family language.

## Fixed Part Asset Pipeline Resume Gate

`RendererMetadataSummary.fixedPartAssetPipelineResumeGateSummary` is the Core metadata gate for deciding when future fixed-part GLB/USD production may resume.

Current blocked state:

- The fixed-part 3D manifest may be ready.
- `CommonPetRigAssetValidationPreflight` remains safely deferred.
- The fixed-part 3D reference acceptance gate may be ready as a no-asset contract.
- App-host visual QA resume is not ready.
- Manual reference artifact acceptance is false.
- ModelIO, SceneKit, and RealityKit remain deferred.
- Asset generation is disabled.
- Runtime asset loading is disabled.
- Generated assets remain false.
- Asset outputs remain `none`.

Resume may be considered only after:

- The manifest is ready.
- The rig preflight is no longer a safe deferral because accepted evidence exists.
- The reference acceptance gate is ready.
- App-host visual QA is ready again.
- A manual reference artifact has been accepted.
- ModelIO, SceneKit, and RealityKit are no longer marked deferred in a dedicated asset-validation loop.
- Generation is explicitly allowed for that loop.
- Runtime loading remains disabled until validation has passed.
- Generated assets remain false before the new loop starts writing artifacts.
- Asset outputs remain `none` at the resume decision point.

This gate keeps 3D production subordinate to affection: WiPet should not create a mesh just because the tooling is available. The reference first has to prove the part still feels cute, family-safe, and readable.
