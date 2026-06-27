# WiPet Library Adoption Strategy

WiPet uses libraries only when they protect affection, lineage feeling, visual quality, or testability without taking over the creature's handmade identity.

Core question:

> 本当に愛着が湧くか？

## Standing Decision Checklist

Before implementation, record:

- What handwritten complexity this task owns.
- Which Apple standard framework can replace or support that complexity.
- Which external Swift Package is a candidate, if any.
- Why the candidate is adopted or rejected.
- The smallest reversible adoption scope.
- The future replacement point if the task proceeds without a dependency.

## Priority Order

1. Prefer Apple frameworks when they fit WiPet's stack and can stay small.
2. Consider maintained Swift Packages only after the Apple framework option is clear.
3. Keep WiPet's cuteness, silhouette judgement, growth ceremony language, lineage copy, and quiet UX handmade.
4. Use external libraries as support rails, not as the expressive core.

## Current Candidates

### GameplayKit

Status: adopted in Core for deterministic lineage planning.

Scope:

- `LineageMutationPlanner`
- `LineageGenomePreviewPlanner`
- deterministic parent-order-stable seed generation
- `GKLinearCongruentialRandomSource`
- `GKRandomDistribution`
- `GKGaussianDistribution`

Decision:

- Keep GameplayKit as the first Apple-framework foundation for lineage randomness.
- Use it to make children feel mostly ancestral with a gentle difference.
- Do not let it choose creature cuteness, final silhouettes, ceremony language, or persistence writes.
- Keep it Core-only and testable.

Affection rule:

- Randomness must explain family resemblance first and surprise second.
- A plan is healthy only when resemblance stays stronger than mutation.

### SnapshotTesting

Status: adopted test-only, gated before image reference expansion.

Decision:

- Keep SnapshotTesting as visual regression support.
- Do not replace manual simulator visual QA.
- Add visible image references only after a surface is manually reviewed and emotionally stable.

### CoreImage

Status: future candidate.

Decision:

- Consider for procedural masks, glow, noise, and CPPN precursor pattern generation.
- Do not use it before the handmade 2D creature vocabulary is stable.
- Require a small preflight gate before any renderer or project change: handmade SpriteKit vocabulary accepted, at least one image snapshot baseline accepted, no external dependency, and no package/project churn.

### ModelIO / SceneKit / RealityKit

Status: future 3D candidate.

Decision:

- Consider for GLB/USD import/export, fixed-part previews, and socket verification.
- Do not begin full 3D production before SpriteKit genome-driven variation is readable and affectionate.

## Current Loop: GameplayKit Adoption Gate

Handwritten complexity:

- Deciding whether deterministic mutation planning supports "祖先に似ているが少し違う" without turning the pet into a random-stat object.

Apple framework candidate:

- GameplayKit is already the best fit because it is part of Apple's frameworks, works with deterministic random sources, and does not add package/project complexity.

External library candidate:

- None for this loop. External random libraries would not improve affection, iOS integration, or reversibility.

Decision:

- Add a small Core adoption gate around the existing GameplayKit lineage planner.
- The gate checks that the planner is Core-only in intent, deterministic, mutation stays gentle, resemblance is stronger than mutation, and no player-facing randomness or persistence writes are introduced.

Minimum scope:

- Add a value-level adoption summary/readiness helper in Core.
- Add tests around an existing `LineageMutationPlan`.
- Do not change Creature public initialization, renderer drawing, Widget handoff, SwiftData, Package.swift, or Xcode project files.

Future replacement point:

- If inheritance and mutation become more complex, keep this gate as the boundary before adding a richer planner or additional deterministic distributions.

## Current Loop: GameplayKit Lineage Distribution Sample

Handwritten complexity:

- Checking whether a short run of mutation plans still feels like family resemblance first and variation second.

Apple framework candidate:

- Continue using GameplayKit through the existing deterministic planner. The current task benefits from sampling the planner, not from replacing it.

External library candidate:

- None. Additional random libraries would add complexity without making the lineage feel more affectionate or easier to test.

Decision:

- Add a Core-only `LineageMutationDistributionSample` around existing GameplayKit plans.
- Keep SpriteKit rendering, Widget handoff, SwiftData, Package.swift, and Xcode project files unchanged.
- Require every sampled plan to use GameplayKit, remain gentle, and keep resemblance above mutation.

Minimum scope:

- Add a value-level sample/readiness helper in Core.
- Add tests for deterministic replay, parent-order stability, missing inputs, empty ranges, and weak/manual plan rejection.

Future replacement point:

- If future trait weighting, Gaussian tuning, or inheritance rules become richer, this sample should stay as the regression boundary before the planner grows.

## Current Loop: GameplayKit Preferred Mutation Preview Search

Handwritten complexity:

- Choosing when a visible child draft should show a specific family echo, such as a deer face, without making the player see or control randomness.

Apple framework candidate:

- Continue using the existing GameplayKit-backed lineage planner and search deterministic salts for a matching mutation trait and optional variation parent.

External library candidate:

- None. A random-search or graph package would not improve cuteness, lineage feeling, or maintainability for this small QA-only preview.

Decision:

- Add a Core-only preferred preview search helper on top of the existing GameplayKit planner.
- Keep the actual deer face drawing handmade in SpriteKit.
- Keep Package.swift, Xcode project files, Widget handoff, persistence, and reference images unchanged.

Future replacement point:

- Before real child creation or breeding becomes player-facing, this helper must remain gated by ceremony, discovery, Widget handoff, and persistence boundaries.

## Current Loop: GameplayKit Preview Adoption Gate

Handwritten complexity:

- Deciding whether a child genome preview can use deterministic randomness while still feeling like "祖先に似ているが少し違う" instead of a random cosmetic roll.

Apple framework candidate:

- Continue using GameplayKit through the existing deterministic lineage preview planner. The value to protect is not drawing or UI, but repeatable parent/trait selection that tests can replay.

External library candidate:

- None. A random or inheritance package would add dependency risk without improving affection, iOS integration, or the ability to tune WiPet-specific family echoes.

Decision:

- Add a Core-only preview adoption gate around `LineageGenomePreview`.
- The gate must require GameplayKit source, a changed trait that matches the mutation plan, inherited and variation parents that belong to the provided family, Core-only scope, no player-facing randomness, no persistence write, no breeding controls, and no external dependency.
- Keep Creature initialization, SpriteKit drawing, Widget handoff, SnapshotTesting references, Package.swift, and Xcode project files unchanged.

Future replacement point:

- Before real child creation, breeding, or persisted lineage writes become player-facing, this gate should be joined with ceremony acknowledgement and persistence boundaries.

## Current Loop: GameplayKit Mutation Affection Profile

Handwritten complexity:

- Translating a deterministic mutation plan into an attachment-safe contract without exposing seeds, random rolls, optimization language, or persistence side effects.

Apple framework candidate:

- Keep GameplayKit as the source of the underlying deterministic plan. The new work should not add another random engine; it should make the existing GameplayKit plan safer to summarize.

External library candidate:

- None. A copy-generation or rules package would black-box WiPet's affection language and would not improve iOS integration or reversibility.

Decision:

- Add a Core-only `LineageMutationAffectionProfile` around `LineageMutationPlan`.
- The profile is ready only when the plan is GameplayKit-backed, resemblance beats mutation, seed details stay hidden, raw randomness is not exposed, no persistence write is allowed, and the profile is not directly player-facing yet.
- Keep Creature, renderer drawing, Widget handoff, SnapshotTesting references, Package.swift, and Xcode project files unchanged.

Future replacement point:

- When Growth Ceremony or Lineage surfaces want to show family-memory language, they can consume this profile only after a separate player-facing copy contract is documented.

## Current Loop: Fixed Part Asset Pipeline Resume Gate

Handwritten complexity:

- Deciding when future grayscale fixed-part GLB/USD work may resume without bypassing art review, app-host visual QA, or the handmade SpriteKit creature vocabulary.
- The risk is letting ModelIO, SceneKit, RealityKit, or generated assets make the creature feel like an asset pipeline before it feels like "うちの子".

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the correct Apple-framework candidates for future GLB/USD import, socket validation, and preview.
- They are not adopted in this loop because there is no manually accepted reference artifact and app-host visual QA is still gated.

External library candidate:

- None. A 3D asset package or graph/validation dependency would not improve affection or reversibility before accepted art evidence exists.

Decision:

- Add a dependency-free Core resume gate for the fixed-part asset pipeline.
- The current state stays blocked while the rig preflight is safely deferred, manual reference acceptance is false, app-host visual QA resume is false, ModelIO/SceneKit/RealityKit are deferred, generation is disabled, runtime loading is disabled, generated assets are false, and `assetOutputs:none`.
- Keep SpriteKit drawing, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated PNG/GLB/USD files, ModelIO, SceneKit, and RealityKit unchanged.

Minimum scope:

- Add Core metadata helpers and tests only.
- Record the resume boundary in the fixed-part 3D manifest and implementation plan.

Future replacement point:

- When app-host visual QA is stable and a manual reference artifact is accepted, run a dedicated smallest-possible ModelIO validation loop before any SceneKit or RealityKit preview work.

## Current Loop: GameplayKit Affection Profile Planner Helper

Handwritten complexity:

- Preventing UI and ceremony surfaces from reaching for seed-bearing mutation plans when they only need attachment-safe lineage language.

Apple framework candidate:

- Continue using GameplayKit through `LineageMutationPlanner`; the helper should wrap the existing deterministic plan rather than introduce another random source.

External library candidate:

- None. A separate random/inheritance package would add risk and would not improve the feeling that a child is mostly ancestral with a small difference.

Decision:

- Add a Core-only `LineageMutationPlanner.affectionProfile` helper.
- The helper returns a ready `LineageMutationAffectionProfile` and keeps seed details out of the summary consumed by app QA.
- Keep Creature initialization, Genome mutation, SpriteKit drawing, Widget handoff, SnapshotTesting references, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- If Growth Ceremony or Lineage UI later becomes player-facing, consume this helper through a separate ceremony copy contract rather than exposing raw plans or seeds.

## Current Loop: GameplayKit Growth Ceremony Affection Copy

Handwritten complexity:

- Turning deterministic lineage randomness into ceremony-safe words without leaking seed details, raw random-roll language, or optimization framing.

Apple framework candidate:

- Continue using GameplayKit only through `LineageMutationPlanner.affectionProfile`; Growth Ceremony should consume the seed-hidden profile, not the raw plan.

External library candidate:

- None. Copy safety, affection language, and ceremony boundaries are WiPet-specific and should remain handmade.

Decision:

- Add a Core `GrowthCeremonyLineageAffectionCopy` contract that consumes `LineageMutationAffectionProfile`.
- Expose it only through Growth Ceremony preview QA metadata in this loop.
- Keep visible UI, Creature mutation, `advanceGrowthStage()`, Widget handoff, persistence, SpriteKit drawing, SnapshotTesting references, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- A later Growth Ceremony UI pass may render this copy, but only after visual QA confirms it feels like family memory rather than a random result.

## Current Loop: GameplayKit Mutation Planning Proof

Handwritten complexity:

- Keeping the existing deterministic lineage random helpers aligned so future UI code does not accidentally consume seed-bearing plans, weak mutation weights, or persistence-ready child creation.

Apple framework candidate:

- Continue using GameplayKit through the existing `LineageMutationPlanner` helpers. `GKLinearCongruentialRandomSource`, `GKRandomDistribution`, and `GKGaussianDistribution` already provide deterministic, testable variation without adding package or project complexity.

External library candidate:

- None. A random/inheritance package would not improve affection, would add dependency risk, and could make WiPet's "祖先に似ているが少し違う" tuning harder to inspect.

Decision:

- Add a Core-only planning proof that joins the existing adoption gate, seed-hidden affection profile, and gentle distribution sample.
- The proof is ready only when GameplayKit is the source, replay and parent-order stability hold, resemblance beats mutation, distribution remains gentle, player-facing randomness stays off, persistence stays off, and no external dependency is needed.
- Keep Creature public initialization, SpriteKit drawing, Widget handoff, SwiftData, SnapshotTesting references, `Package.swift`, and Xcode project files unchanged.

Minimum scope:

- Add a value-level `LineageMutationPlanningProof` plus `LineageMutationPlanner.planningProof`.
- Add Core tests for deterministic replay, parent-order stability, seed-hidden affection safety, missing parent rejection, and unsafe flag rejection.

Future replacement point:

- If lineage inheritance later grows into trait weighting, richer Gaussian tuning, or persisted child creation, this proof should remain the boundary that proves the library supports attachment instead of becoming visible randomness.

Result:

- Adopted no new dependency; reused Apple GameplayKit already present in Core.
- Added a small Core proof helper instead of changing renderer, Widget, persistence, package, or project files.
- Verification confirmed the normal player UI remains free of GameplayKit, seed, random-roll, or planning-proof wording.

## Current Loop: Genome Variation Sibling Body Proportion Contract

Handwritten complexity:

- The visible sibling body difference is already handmade in SpriteKit: Luma reads as a quiet moon oval while Mira reads as a slimmer fairy seed. The risk is not missing pixels; it is losing the sibling-recognition contract while adding more QA metadata.

Apple framework candidate:

- SpriteKit remains the renderer for the handmade silhouette. SnapshotTesting is already present as the test-only regression layer for Genome Variation QA.

External library candidate:

- None. No drawing, layout, graph, random, or image-processing dependency improves this small contract.

Decision:

- Expose Mira's existing `seedPetal/petalSlim/tallSprout/lightFairySeed` body proportion cue through hidden Genome Variation QA metadata.
- Update the existing app-target text reference rather than adding new pixels or image references.
- Keep `PartAssembler`, SpriteKit drawing, Widget handoff, persistence, packages, project files, generated assets, and normal player UI unchanged.

Future replacement point:

- If later SpriteKit work adds a true visible proportion nudge, this sibling contract becomes the baseline proving the difference was already intentional and family-readable.

Result:

- No new dependency was added; existing SnapshotTesting app-target `.lines` coverage now protects Mira's sibling body proportion cue.
- The accepted visual surface stayed unchanged: the contract is hidden QA metadata, not new player-facing technical text.
- External-SSD CoreSimulator was restored before commit, and no extra Xcode/Simulator work was run during the user's `XCTestDevices` storage migration.

## Current Loop: Growth Ceremony Visible Affection Line

## Current Loop: SpriteKit Contrast Dapple Variation

Handwritten complexity:

- Making `PatternGenes.contrast` visible enough that two related pets feel individually recognizable without turning handmade markings into procedural noise.

Apple framework candidate:

- SpriteKit remains the right renderer for this slice because the current work is art-direction tuning of existing hand-placed belly dapples.
- CoreImage is a future candidate for generated masks, glow fields, and CPPN precursor texture work, but adopting it now would add machinery before the handmade creature vocabulary is stable.

External library candidate:

- None. A drawing or texture package would not improve cuteness, affection, or testability for three to four small hand-placed marks.

Decision:

- Keep the dapple marks handmade in `PartAssembler`.
- Add the smallest renderer profile vocabulary so contrast controls dapple count, scale, and opacity.
- Do not add dependencies, project edits, persistence writes, Widget handoff changes, or Growth Ceremony behavior changes.

Minimum scope:

- Add read-only `PatternMarking` drawing values derived from `PatternGenes.contrast`.
- Keep the existing metadata summary shape stable.
- Update the accepted Genome Variation image reference only after simulator visual QA confirms the change still feels warm and creature-like.

Future replacement point:

- When pattern generation becomes more than a few hand-placed family marks, evaluate CoreImage as the first Apple-framework step before CPPN.

Implementation result:

- Added contrast-derived dapple count, scale, and opacity to the existing SpriteKit renderer profile.
- Kept dapple placement handmade and kept metadata summaries stable.
- Simulator visual QA accepted the change as a subtle sibling-readability improvement.
- The existing Genome Variation image snapshot passed without a reference update, so the accepted composition remains stable.

## Current Loop: SpriteKit Glow Mote Variation

Handwritten complexity:

- Making `PatternGenes.glow` feel like a soft living aura rather than a numeric brightness value or a generic particle effect.

Apple framework candidate:

- SpriteKit remains the best fit because the current glow cue is already an `SKShapeNode` ring and the next improvement is a few hand-placed motes around that ring.
- CoreImage can support future generated glow masks and CPPN-adjacent luminous textures, but it is too heavy for a small readability pass.

External library candidate:

- None. A particle or effects package would add dependency risk and reduce art-direction control for a cue that should stay quiet and pet-specific.

Decision:

- Keep glow handmade in `PartAssembler`.
- Add profile-derived mote count, opacity, and scale from `PatternGenes.glow`.
- Do not add dependencies, project edits, persistence writes, Widget handoff changes, or Growth Ceremony behavior changes.

Minimum scope:

- Render a small number of fixed-position glow motes as children of the existing glow ring.
- Keep existing glow metadata summary strings stable.
- Update image references only if manual visual QA accepts an intentional composition change.

Future replacement point:

- If glow becomes a procedural texture, mask, or animated field, evaluate CoreImage before any external effect library.

Implementation result:

- Added glow-derived mote count, opacity, and scale to the existing SpriteKit renderer profile.
- Rendered fixed-position motes as children of the existing glow ring.
- Simulator visual QA accepted the cue as a quiet living-glow detail.
- The existing Genome Variation image snapshot passed without a reference update, so the accepted composition remains stable.

## Current Loop: Glow Mote Recipe Coverage

Handwritten complexity:

- Keeping glow motes as named WiPet art-direction recipes instead of letting them become anonymous effects or a future black-box particle layer.

Apple framework candidate:

- SpriteKit remains the rendering support rail; XCTest/SnapshotTesting can verify hidden metadata without changing visible UI.
- CoreImage remains a later candidate for generated glow masks, but this loop only names the current handmade recipe.

External library candidate:

- None. Recipe naming and coverage checks are project-specific docs/code alignment, not a place for dependency adoption.

Decision:

- Add a small ambient recipe catalog for the existing glow ring and glow motes.
- Expose snapshot-host-only readiness metadata so the accepted image baseline knows the glow effect is intentional.
- Keep drawing paths, normal UI, Widget handoff, persistence, package files, and project files unchanged.

Minimum scope:

- Add `CreatureAmbientRecipeID` and catalog/readiness helpers.
- Add hidden Genome Variation QA text and update the app-target text snapshot.
- Do not update image references unless visible QA requires it.

Future replacement point:

- If glow recipes become procedural fields, migrate the ambient recipe catalog to cover CoreImage mask recipes before introducing CPPN.

Implementation result:

- Added ambient recipe IDs for the current handmade glow ring and glow motes.
- Added hidden Genome Variation QA readiness metadata and protected it with the existing app-target text snapshot.
- Kept image references stable by capturing the image before the added metadata waits.
- Simulator visual QA confirmed no visible layout or readability change.

## Current Loop: CoreImage Pattern Generation Adoption Gate

Handwritten complexity:

- Deciding when handmade SpriteKit dapples and glow cues should graduate into generated masks, glow fields, noise, or CPPN precursor textures without losing WiPet's cute silhouette control.

Apple framework candidate:

- CoreImage is the first Apple-framework candidate for future pattern and glow generation because it supports masks, filters, noise, and image processing without adding a Swift package.
- SpriteKit remains the active renderer in this loop.

External library candidate:

- None. A texture, particle, or image-processing package would add dependency risk before CoreImage's built-in path is tested.

Decision:

- Add a Core-only preflight metadata gate for CoreImage pattern generation.
- The gate is ready only when the handmade SpriteKit vocabulary is accepted, an image snapshot baseline exists, CoreImage is the candidate, no external dependency is required, package/project files stay untouched, renderer drawing stays unchanged, and no asset output is generated.
- Do not import CoreImage, change `PartAssembler`, change SpriteKit drawing, update image references, edit package/project files, or alter Widget handoff in this loop.

Minimum scope:

- Add value-level summary/readiness helpers to `RendererMetadataSummary`.
- Add Core tests for the accepted future gate and rejection cases.
- Keep the app visually unchanged and use simulator visual QA only to confirm no layout/readability regression.

Future replacement point:

- When pattern generation grows beyond hand-placed family marks, this gate becomes the required boundary before CoreImage masks, glow fields, or CPPN precursor textures can be implemented.

Result:

- Added Core-only CoreImage pattern-generation preflight summary/readiness helpers to `RendererMetadataSummary`.
- Added tests proving the gate accepts CoreImage only after handmade vocabulary and an image baseline are accepted, and rejects external packages, package/project edits, renderer changes, missing inputs, generated asset output, and silhouette takeover.
- Kept CoreImage unimported, SpriteKit drawing unchanged, Widget handoff unchanged, persistence unchanged, Package.swift unchanged, Xcode project files unchanged, and image references unchanged.
- Tightened the existing app-target image snapshot tolerance for tiny animated eye/glow timing variance without updating the reference image.
- Simulator visual QA confirmed Genome Variation remains readable, quiet, and family-like.

## Current Loop: CoreImage Pattern Generation QA Surface Handoff

Handwritten complexity:

- The Core-only CoreImage pattern-generation preflight exists, but Genome Variation QA does not yet expose that future library boundary through the app-host text surface.
- Without this bridge, later renderer work could begin CoreImage mask/noise/glow experiments without proving handmade SpriteKit dapples and glow cues remain the accepted affection vocabulary.

Apple framework candidate:

- CoreImage remains the future Apple-framework candidate for generated masks, glow fields, noise, and CPPN precursor textures.
- It is not imported or executed in this loop; the task only hands the existing Core gate to hidden QA.

External library candidate:

- None. External texture or image-processing packages are still rejected because the current goal is to preserve WiPet's handmade cute silhouette control.

Decision:

- Expose the existing CoreImage pattern-generation preflight through hidden `GenomeVariationQAView` accessibility labels and the app-target `.lines` reference.
- Keep `candidate:CoreImage`, `inputs:mask+glow+noise+cppnPrecursor`, `handmadeVocabulary:true`, `snapshotBaseline:true`, `preservesSilhouette:true`, and all dependency/project/renderer/generated-asset flags closed.
- Do not import CoreImage, change `PartAssembler`, change SpriteKit drawing, update image references, edit package/project files, alter Widget handoff, or change visible UI.

Minimum scope:

- Add `coreImagePatternGenerationPreflightSummary` and readiness labels to the hidden Genome Variation QA surface.
- Add focused UI-test assertions and `.lines` snapshot entries.
- Use external SwiftPM scratch tests and iOS parse for verification; skip Simulator visual QA if local system storage is still below a safe threshold because this loop is hidden metadata only.

Future replacement point:

- When pattern generation becomes more than hand-placed family marks, this hidden QA handoff must stay green before any CoreImage mask, glow-field, noise, or CPPN precursor implementation changes renderer pixels.

Result:

- Added hidden Genome Variation QA labels for `coreImagePatternGenerationPreflightSummary` and `coreImagePatternGenerationPreflightReadinessSummary`.
- The app-target `.lines` snapshot now records `coreImagePatternGenerationPreflightReady:true` and the closed CoreImage candidate contract.
- Kept CoreImage unimported, SpriteKit drawing unchanged, visible UI unchanged, Widget handoff unchanged, persistence unchanged, Package.swift unchanged, Xcode project files unchanged, generated assets unchanged, and image references unchanged.

## Current Loop: Pattern Marking Recipe Coverage

Handwritten complexity:

- Keeping contrast-driven belly dapples as named handmade WiPet pattern recipes before any generated mask, CoreImage filter, CPPN precursor, or texture pipeline is introduced.

Apple framework candidate:

- SpriteKit remains the active renderer because this loop only catalogs the existing hand-placed dapple recipe.
- CoreImage remains a future support rail after the handmade pattern vocabulary is accepted.

External library candidate:

- None. SnapshotTesting is already available for the app-target text/image guardrail, and no new package improves a recipe-naming contract.

Decision:

- Add a small pattern recipe catalog for the existing `softDapples` marking.
- Expose snapshot-host-only readiness metadata so the accepted Genome Variation image baseline knows the belly markings are intentional.
- Keep drawing paths, normal Observation UI, Widget handoff, persistence, package files, project files, CoreImage imports, generated assets, and image references unchanged.

Minimum scope:

- Add `CreaturePatternRecipeID` and catalog/readiness helpers.
- Add hidden Genome Variation QA text and update the existing app-target `.lines` snapshot.
- Do not update image references unless visual QA confirms an intentional visible change.

Future replacement point:

- If patterns become generated masks, procedural fields, or CPPN outputs, migrate this pattern recipe catalog to cover CoreImage-backed mask recipes before changing pixels.

Result:

- Added `CreaturePatternRecipeID.softBellyDapples` and a pattern recipe catalog entry for the existing contrast-driven handmade dapples.
- Added pattern recipe coverage/readiness helpers derived from `CreatureRenderProfile.PatternMarking`.
- Exposed hidden Genome Variation QA metadata and extended the app-target `.lines` snapshot with `patternRecipeCoverageReady:true`.
- Kept SpriteKit drawing paths, normal UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, CoreImage imports, and image references unchanged.
- Simulator visual QA confirmed the hidden metadata does not shift the Genome Variation layout.

## Current Loop: SpriteKit Pattern Spread Variation

Handwritten complexity:

- Making related pets feel subtly different through handmade belly-mark placement without turning the pattern system into procedural texture generation.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is a tiny art-directed placement adjustment in the existing `softBellyDapples` recipe.
- CoreImage remains deferred until patterns need generated masks, noise, filters, or CPPN precursor textures.

External library candidate:

- None. SnapshotTesting already guards the accepted Genome Variation image, and no external drawing or texture package would improve a small placement cue.

Decision:

- Keep the existing dapple recipe handmade in `PartAssembler`.
- Add the smallest renderer profile value so `PatternGenes.contrast` also affects dapple spread, not only count, scale, and opacity.
- Keep normal UI, Widget handoff, persistence, generated assets, CoreImage imports, package files, and project files unchanged.

Minimum scope:

- Add read-only `spotSpread` to `CreatureRenderProfile.PatternMarking`.
- Apply it only to existing fixed dapple anchor positions.
- Let the existing Genome Variation image snapshot prove whether the accepted composition remains stable; update the reference only after visual QA accepts the visible difference.

Future replacement point:

- If mark placement becomes more complex than a few fixed anchors, evaluate CoreImage masks before adding CPPN or external texture tooling.

Implementation result:

- Added `spotSpread` to the existing `CreatureRenderProfile.PatternMarking`.
- Applied the spread only to the existing hand-placed dapple anchors in `PartAssembler`.
- Kept the visible change subtle enough that the accepted Genome Variation image snapshot passed without updating the reference.
- Kept normal UI, Widget handoff, persistence, generated assets, CoreImage imports, package files, and project files unchanged.
- Simulator visual QA accepted the cue as a gentle sibling-readability improvement.

## Current Loop: Pattern Spread Metadata Contract

Handwritten complexity:

- Making the newly added handmade dapple spread inspectable without exposing it as a player-facing stat or moving it into procedural texture tooling.

Apple framework candidate:

- SpriteKit remains the active renderer and XCTest/SnapshotTesting remain the verification supports.
- CoreImage is still not needed because this loop does not generate masks, filters, noise, or texture assets.

External library candidate:

- None. The existing SnapshotTesting `.lines` and image references are sufficient to guard metadata and visible stability.

Decision:

- Extend the existing SpriteKit pattern-marking metadata with a `spread` label derived from `PatternGenes.contrast`.
- Keep the spread label QA-only and not visible in normal UI.
- Keep drawing, Widget handoff, persistence, generated assets, CoreImage imports, package files, and project files unchanged.

Minimum scope:

- Add `spread` to `RendererMetadataSummary.spriteKitPatternMarkingCueSummary`.
- Add Core tests for the spread field and rejection behavior.
- Do not update image references unless visible QA shows an intentional pixel change.

Future replacement point:

- If spread becomes a generated mask or CPPN parameter, this metadata contract should become the bridge into a CoreImage-backed pattern recipe.

Result:

- Extended `RendererMetadataSummary.spriteKitPatternMarkingCueSummary` with a QA-only `spread` field.
- Added `CreatureRenderProfile.PatternMarking.spreadLabel` derived from `PatternGenes.contrast`.
- Updated Core tests and the Genome Variation app-target `.lines` snapshot to verify `spread:softSpread`.
- Kept visible UI, SpriteKit drawing, Widget handoff, persistence, generated assets, CoreImage imports, package files, project files, and image references unchanged.
- Simulator visual QA confirmed no visible layout shift.

## Current Loop: GameplayKit Growth Ceremony Affection Factory

Handwritten complexity:

- Growth Ceremony needs family-memory language that feels affectionate, not random, and should not expose seed details, random-roll wording, optimization framing, mutation controls, persistence writes, or Widget publication.

Apple framework candidate:

- GameplayKit remains the right Apple-framework support rail because `LineageMutationPlanner.affectionProfile` already produces deterministic, parent-order-stable, seed-hidden lineage profiles.

External library candidate:

- None. Copy safety and ceremony wording are WiPet-specific and should stay handmade.

Decision:

- Add a small Core factory on `GrowthCeremonyLineageAffectionCopy` that consumes parent IDs through the existing GameplayKit-backed affection profile helper.
- Keep the factory preview-only and return nil when parent IDs are missing or the profile is not attachment-safe.
- Replace app-local profile assembly with the Core factory.

Minimum scope:

- Add `GrowthCeremonyLineageAffectionCopy.preview(plan:parentIDs:generation:salt:)`.
- Add Core tests for deterministic output, parent-order stability, seed/raw-random hiding, empty-parent rejection, and no mutation/persistence/Widget side effects.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, `advanceGrowthStage()`, generated assets, package files, project files, and snapshot references unchanged unless tests prove a semantic line must update.

Future replacement point:

- If Growth Ceremony later commits a real lineage event, this factory must stay on the preview side and feed a separate persistence-boundary contract before any write occurs.

## Current Loop: Lineage Multi-Generation Branch Preview

Handwritten complexity:

- Showing "Ori -> Luma/Mira -> draft memory" as a family-memory branch without turning the surface into a graph editor, breeding screen, optimization tool, or persistence workflow.

Apple framework candidate:

- SwiftUI is enough for the current read-only branch surface.
- GameplayKit is already used behind the child draft preview, so no new randomness framework is needed.
- A graph/tree layout helper is deferred because the branch has only four visible nodes and three edges.

External library candidate:

- None. Graph layout and tree packages would add dependency risk before the family-memory language is accepted.

Decision:

- Add a Core `LineageFamilyBranchPreview` contract that joins an ancestor node, the existing family preview, and a child draft node.
- Require three-generation depth, read-only behavior, no navigation, no persistence write, no breeding controls, no optimization controls, and no player-facing graph state.
- Render only a calm QA line and hidden semantic metadata in the Lineage Family QA surface.

Minimum scope:

- Add Core summary/readiness tests for ready and unsafe branch previews.
- Add a small visible branch preview surface to `LineageFamilyQAView`.
- Extend the existing Lineage Family app-target `.lines` snapshot.
- Keep graph layout libraries, package files, project files, Widget handoff, persistence, Creature mutation, renderer drawing, and generated assets unchanged.

Future replacement point:

- If the lineage surface grows beyond a readable four-node branch or needs stable automatic layout, revisit Swift Algorithms/Collections or a graph layout package behind a dedicated adoption gate.

## Current Loop: Lineage Draft Memory Teaser Copy Polish

Handwritten complexity:

- The Family tree teaser must make a draft descendant feel like a remembered family possibility, not an internal label or repeated technical state.

Apple framework candidate:

- Swift value copy is enough. No Apple layout, graph, random, image, or persistence framework improves this wording.

External library candidate:

- None. Family-memory wording is WiPet's expressive core and should stay handmade.

Decision:

- Replace the default child-draft status line with a softer sentence that avoids repeating "draft memory".
- Keep `childDraft` as an internal readiness key and keep graph layout, SnapshotTesting, Widget handoff, persistence, renderer drawing, package files, and project files unchanged.

Minimum scope:

- Update `LineageFamilyTreeTeaserSurfaceCopy.defaultStatusLine`.
- Update Core tests.
- Use simulator visual QA to confirm the visible Lineage Family teaser reads warmly and remains read-only.

Future replacement point:

- If Family tree becomes player-facing navigation, move these strings into a small lineage copy catalog before adding localization or richer state.

## Current Loop: Eye Catchlight Recipe Coverage

Handwritten complexity:

- Treating the tiny eye catchlight as an intentional WiPet cuteness recipe rather than an incidental shape node.

Apple framework candidate:

- SpriteKit remains the renderer; the task catalogs an existing `SKShapeNode` catchlight without changing drawing.
- No Apple image-processing framework is needed because no mask, texture, or generated asset is created.

External library candidate:

- None. SnapshotTesting already guards app-target metadata and image stability.

Decision:

- Add a fixed-part detail recipe for the existing soft eye catchlight.
- Extend detail recipe coverage and the app-target `.lines` snapshot so eye sparkle is protected as a named recipe.
- Keep visible UI, SpriteKit drawing paths, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add `softCatchlight` to `CreatureDetailRecipeID`.
- Return the recipe for eye assembly items and catalog it under `softEye`.
- Extend `WiPetSnapshotTests` to assert the recipe appears in Genome Variation detail coverage.

Future replacement point:

- If eye rendering gains multiple catchlight styles or animated highlights, keep this recipe as the catalog boundary before adding more visible eye variation.

Result:

- Added `CreatureDetailRecipeID.softCatchlight` as a named recipe for the existing soft eye highlight.
- Returned the recipe from eye assembly items and cataloged it under the `softEye` fixed part.
- Extended the Genome Variation app-target `.lines` reference so baseline, sibling, and child draft detail coverage includes `softCatchlight`.
- Confirmed the change is metadata/catalog-only: no SpriteKit path, color, socket, blink timing, visible UI text, Widget handoff, persistence, generated asset, package file, project file, or image reference changed.
- Simulator visual QA confirmed the Genome Variation host remains readable and emotionally quiet; the catchlight stays a tiny "かわいい" cue rather than a technical label.

Handwritten complexity:

- Choosing one gentle player-facing line that makes a deterministic lineage profile feel like family memory instead of a generated random outcome.

Apple framework candidate:

- GameplayKit remains behind `LineageMutationPlanner.affectionProfile`; no additional framework is needed for copy tone or SwiftUI placement.

External library candidate:

- None. Text tone, ceremony pacing, and affection judgment are WiPet's expressive core.

Decision:

- Render one short `GrowthCeremonyLineageAffectionCopy` line in the preview-only Growth Ceremony card.
- Keep the line derived from seed-hidden Core copy, not raw plan summaries.
- Keep normal Observation, Creature mutation, `advanceGrowthStage()`, Widget handoff, persistence, SpriteKit drawing, SnapshotTesting references, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- If the line becomes stable through visual QA, SnapshotTesting can later protect it in an app-target visual reference.

## Current Loop: SpriteKit Lineage Memory Thread

Handwritten complexity:

- Adding one tiny embodied family-memory cue without turning lineage into a badge, score, particle effect, or collectible marker.

Apple framework candidate:

- SpriteKit `SKShapeNode` remains the right support rail because the existing pet renderer is handmade SpriteKit and this cue needs precise art-direction control.

External library candidate:

- None. CoreImage, particle systems, and visual-effect packages would be excessive for a single soft line and would reduce the ability to tune cuteness by hand.

Decision:

- Add one handmade `softLineageMemoryThread` curve inside the body only when both body and tail lineage cues are active.
- Keep CoreImage, SnapshotTesting image references, package files, Xcode project files, Widget handoff, persistence, graph navigation, breeding controls, optimization controls, and 3D assets unchanged.

Future replacement point:

- If the cue becomes visually stable, it can be mapped to future 3D reference-sheet annotations and protected later by app-target snapshot testing.

## Current Loop: Fixed Part Lineage Memory Thread Reference Annotation

Handwritten complexity:

- Deciding whether the new family-memory thread should become future mesh geometry now, or stay as an art-direction annotation until the 2D cue proves affectionate.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit can later validate GLB/USD assets and socket previews, but there is no asset in this loop.

External library candidate:

- None. A package would add no affection, stability, or test value for a metadata-only reference-sheet annotation.

Decision:

- Add `softLineageMemoryThread` to the existing fixed-part lineage cue reference annotations as a body-to-tail reference-sheet cue.
- Keep generated assets, GLB/USD, ModelIO, SceneKit, RealityKit, SpriteKit drawing changes, Creature mutation, Widget handoff, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When PNG reference sheets or GLB/USD fixed parts exist, ModelIO plus SceneKit or RealityKit can validate the annotated sockets in a dedicated asset-pipeline commit.

## Current Loop: Child Draft Inherited Face Echo Metadata

Handwritten complexity:

- Naming the existing deer-face draft cue as family memory without adding a new visual gimmick or exposing mutation mechanics.

Apple framework candidate:

- GameplayKit already selects the deterministic deer-face draft through `LineageGenomePreviewPlanner`; SpriteKit already renders the handmade `forestDots` face accent.

External library candidate:

- None. SnapshotTesting may later protect the surface, but adding it here would mix infrastructure with a tiny affection contract.

Decision:

- Add a Core child-draft inherited face echo contract that references the existing `softDeer`/`forestDots` visible cue in Genome Variation QA.
- Keep SpriteKit drawing, CoreImage, SnapshotTesting references, packages, Xcode project files, Creature mutation, persistence, Widget handoff, breeding controls, and optimization controls unchanged.

Future replacement point:

- If the cue remains visually stable, SnapshotTesting can protect the Genome Variation QA child draft in a separate app-host commit.

## Current Loop: Observation Family Tree Memory Line

Handwritten complexity:

- Adding enough ancestor-memory context inside the read-only sheet without making it feel like a management screen.

Apple framework candidate:

- SwiftUI is already sufficient for the local sheet row; no new Apple framework is needed.

External library candidate:

- None. Graph/tree layout libraries remain premature because graph navigation is still disabled.

Decision:

- Render the existing `LineageObservationFamilyTreeEntryCopy.memoryLine` inside the Observation family-memory sheet entry.
- Keep graph navigation, persistence writes, breeding controls, optimization controls, Widget handoff, SnapshotTesting references, packages, and Xcode project files unchanged.

Future replacement point:

- If the read-only sheet grows into a real multi-generation tree, revisit Swift Algorithms/Collections or a graph layout helper in a dedicated design and dependency commit.

## Current Loop: Observation Named Ancestor Display Copy

Handwritten complexity:

- Keeping internal lineage labels deterministic while making player-facing memory copy feel like a remembered ancestor instead of an identifier.

Apple framework candidate:

- SwiftUI does not need a new framework; the change belongs in Core copy so all Observation/Growth surfaces share the safer display name.

External library candidate:

- None. Naming and family-memory tone are WiPet-specific and should not be delegated.

Decision:

- Use the existing `LineageFamilyNodeCopy.displayName(for:)` mapping when `LineageVisibleCueObservationCopy` builds its default observation line.
- Keep raw internal labels in metadata summaries, and keep graph navigation, persistence writes, breeding controls, optimization controls, Widget handoff, packages, and Xcode project files unchanged.

Future replacement point:

- When user-authored ancestor names exist, introduce a small ancestor-name resolver with tests before any persistence or graph-layout dependency work.

## Current Loop: Lineage Ancestor Naming Policy

Handwritten complexity:

- Deciding when an ancestor may use a proper name like `Ori` without letting the app invent names or expose raw identifiers as affectionate copy.

Apple framework candidate:

- No new Apple framework is useful. This is domain copy and safety policy, not data storage or layout.

External library candidate:

- None. Name tone, naming permission, and family-memory semantics are WiPet-specific.

Decision:

- Add a Core `LineageAncestorNamingPolicy` that classifies `LineageFamilyNodeCopy` as either `genericDisplayLabel` or `properName`.
- Proper names must be explicitly supplied, not auto-generated, and naming remains read-only with no persistence, rename UI, graph navigation, breeding, or optimization controls.

Future replacement point:

- If player-authored ancestor names become real data, introduce a SwiftData-backed resolver in a separate persistence-gated loop.

## Current Loop: SpriteKit Lineage Cue Set Contract

Handwritten complexity:

- Deciding whether the existing body glint, tail memory dots, and body-to-tail thread read as one family resemblance cue instead of separate decorative marks.

Apple framework candidate:

- Continue using SpriteKit as the handmade renderer foundation. No new Apple framework is needed because this loop records and verifies existing cues rather than generating new texture, glow, or geometry.

External library candidate:

- SnapshotTesting can later protect accepted visual references, but adding snapshot image assertions here would mix infrastructure with a small renderer contract.

Decision:

- Add a Core renderer metadata contract for the current SpriteKit lineage cue set.
- Expose the cue set only as hidden QA metadata in Observation while leaving visible rendering, Widget handoff, persistence, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Future replacement point:

- If this cue set remains visually stable, a later SnapshotTesting app-host commit can record image references for Observation Home or Genome Variation QA.

## Current Loop: Fixed Part Lineage Cue Set Reference Sheet

Handwritten complexity:

- Turning the accepted SpriteKit lineage cue set into future reference-sheet requirements without prematurely creating mesh geometry, textures, particles, or generated assets.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for validating real GLB/USD files and socket previews, but there is no asset to import or inspect in this loop.

External library candidate:

- None. A diagram or asset package would not improve affection or testability for a metadata-only reference-sheet contract.

Decision:

- Add a deterministic Core metadata contract for the lineage cue set reference sheet.
- Expose it only through Genome Variation QA hidden metadata.
- Keep SpriteKit rendering, Widget handoff, persistence, `Package.swift`, `WiPet.xcodeproj`, GLB/USD files, PNG reference sheets, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When actual PNG reference sheets or GLB/USD assets exist, use this contract as the validation checklist for a dedicated ModelIO plus SceneKit or RealityKit loop.

## Current Loop: Fixed Part Reference Sheet Panel Layout

Handwritten complexity:

- Deciding what each future reference-sheet panel must communicate so modelers preserve cuteness, sockets, and family-memory cues without adding premature assets.

Apple framework candidate:

- No new Apple framework is useful yet. ModelIO, SceneKit, and RealityKit should wait until an actual PNG, GLB, or USD artifact exists.

External library candidate:

- None. Diagramming or layout libraries would not improve this docs-and-metadata contract.

Decision:

- Add a deterministic Core metadata contract for per-panel reference-sheet layout guidance.
- Expose it only through Genome Variation QA hidden metadata.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When reference-sheet PNGs are generated, this contract becomes the checklist for visual/snapshot validation before 3D asset validation.

## Current Loop: Fixed Part Reference Sheet Acceptance Gate

Handwritten complexity:

- Preventing the first reference-sheet PNG or 3D asset from being generated just because metadata exists.
- Keeping the gate affection-first: cute silhouette, family-memory cue set, socket clarity, and manual visual review must come before asset output.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the right future candidates for inspecting GLB/USD files and socket previews.
- They are not useful in this loop because there is still no generated PNG, GLB, or USD artifact to import, render, or validate.

External library candidate:

- SnapshotTesting can later protect an accepted PNG reference sheet, but it should not be mixed into this pre-generation gate.
- No diagramming or asset package improves the current docs-and-metadata decision.

Decision:

- Add a deterministic Core metadata contract for the reference-sheet acceptance gate.
- The gate may report that lineage reference metadata and panel layout metadata are ready.
- The gate must still keep generation disabled until manual art-direction review and snapshot/reference acceptance exist in a later loop.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When a real PNG reference sheet exists, this gate should flip through a separate review loop that records the accepted artifact and then introduces visual/snapshot validation.

## Current Loop: Fixed Part Reference Sheet Artifact Naming

Handwritten complexity:

- Naming the first future PNG reference sheet so it stays tied to the accepted lineage cue set, panel layout, and grayscale fixed-part rules without implying the asset already exists.
- Avoiding ambiguous ad hoc filenames that would make future visual QA, snapshot references, or 3D handoff harder to trace.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for validating generated assets, but naming an uncreated PNG artifact does not need them.

External library candidate:

- SnapshotTesting can later protect the accepted PNG, but it should wait until a real image exists and manual art direction has accepted it.

Decision:

- Add a deterministic Core metadata contract for the first future PNG reference-sheet artifact name.
- Keep the artifact ungenerated, unaccepted, unvalidated, and outside app runtime output.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When the first PNG reference sheet is created, this naming contract becomes the source of truth for where snapshot/reference validation and 3D asset handoff should look.

## Current Loop: Fixed Part Reference Sheet Manual Review Checklist

Handwritten complexity:

- Defining what a human art-direction pass must judge before the named PNG reference sheet can be accepted.
- Keeping the checklist focused on affection, cute silhouette, family-memory readability, sockets, rig clarity, and no premature color/pattern/glow or geometry claims.

Apple framework candidate:

- No new Apple framework is useful before an actual PNG, GLB, or USD exists.
- ModelIO, SceneKit, and RealityKit stay deferred until there is an artifact to inspect.

External library candidate:

- SnapshotTesting remains future support after manual review accepts a rendered PNG.
- A checklist library would not improve WiPet-specific art direction or affection judgement.

Decision:

- Add a deterministic Core metadata contract for manual review checklist fields.
- Keep the review incomplete, snapshot acceptance false, generation disabled, and runtime loading false.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When a real PNG exists, this checklist becomes the acceptance evidence before snapshot references or 3D handoff can begin.

## Current Loop: Fixed Part Reference Sheet Manual Review Result States

Handwritten complexity:

- Defining review result states before a real PNG exists, without accidentally treating an unreviewed artifact as accepted.
- Keeping the state machine small enough to protect future art direction while avoiding premature workflow tooling.

Apple framework candidate:

- No new Apple framework is useful yet. There is no image, 3D file, or persisted review record to inspect.

External library candidate:

- SnapshotTesting remains future validation only after a PNG is manually accepted.
- Workflow/state-machine packages are unnecessary for this small docs-and-metadata contract.

Decision:

- Add a deterministic Core metadata contract for manual review result states.
- Keep the current result `notStarted`; `needsRevision` and `accepted` are documented future states, not active outcomes.
- Keep snapshot acceptance false, generation disabled, runtime loading false, and asset outputs none.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When a PNG candidate exists, this state contract should become the handoff point for recording `needsRevision` or `accepted` alongside review evidence.

## Current Loop: Fixed Part Reference Sheet Review Evidence Fields

Handwritten complexity:

- Defining what evidence must be attached to a future manual review without pretending such evidence already exists.
- Keeping evidence human-readable and affection-focused rather than turning review into a technical artifact dump.

Apple framework candidate:

- No new Apple framework is useful before a generated PNG or persisted review record exists.
- ModelIO, SceneKit, and RealityKit remain future asset validators, not evidence fields.

External library candidate:

- SnapshotTesting remains future support after manual art direction accepts a PNG.
- No evidence-management package is needed for this small metadata contract.

Decision:

- Add a deterministic Core metadata contract for review evidence fields.
- Require the field names but keep evidence recorded false, evidence path empty, reviewer note empty, snapshot acceptance false, generation disabled, and runtime loading false.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When a PNG candidate exists, these fields become the required evidence slots for `needsRevision` or `accepted`.

## Current Loop: Fixed Part Reference Sheet PNG Candidate Generation Preflight

Handwritten complexity:

- Deciding when the named PNG reference sheet is allowed to become a generated candidate without skipping manual review boundaries.
- Keeping generation closed until naming, checklist, result-state, and evidence-field contracts are all ready.

Apple framework candidate:

- No new Apple framework is useful because this loop still does not create or inspect a PNG.
- ModelIO, SceneKit, and RealityKit remain future asset validators after there is a real artifact.

External library candidate:

- SnapshotTesting remains future visual-regression support after a PNG candidate is generated and manually accepted.
- No generation or preflight package is needed for this metadata-only gate.

Decision:

- Add a deterministic Core metadata contract for PNG candidate generation preflight.
- Require the naming, checklist, result-state, and evidence-field metadata to be ready.
- Keep candidate existence false, generation disabled, snapshot acceptance false, runtime loading false, and asset output none.
- Keep visible UI, SpriteKit rendering, Widget handoff, persistence, package/project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When generation is intentionally opened, this preflight should become the final gate before producing the first PNG candidate.

## Current Loop: Child Draft Visible Lineage Cue Set

Handwritten complexity:

- Making the Genome Variation child draft visibly feel related to Ori without adding new random controls, new marks, or a technical badge.
- Keeping the cue small enough that the deer face remains cute and the portrait still reads as a child draft.

Apple framework candidate:

- GameplayKit already selects the deterministic child draft and preferred deer-face variation.
- SpriteKit already renders the handmade face accent, body glint, tail memory dots, and memory thread.
- No new Apple framework is needed for this loop.

External library candidate:

- SnapshotTesting can later protect the child draft surface after the visual cue is accepted.
- CoreImage or drawing packages would take over too much of the handmade creature-expression surface for a small cue connection.

Decision:

- Reuse the existing SpriteKit lineage cue set on the Genome Variation child draft by giving the draft a QA-only inherited-resemblance discovery.
- Add deterministic Core metadata for the child draft visible lineage cue set.
- Keep Creature mutation, persistence, Widget handoff, breeding controls, optimization controls, generated assets, Package.swift, Xcode project files, CoreImage, and SnapshotTesting references unchanged.

Future replacement point:

- If this child draft cue remains readable in visual QA, protect Genome Variation QA in a focused SnapshotTesting app-host loop.

## Current Loop: Fixed Part Child Draft Lineage Cue Reference

Handwritten complexity:

- Carrying the accepted child draft deer-face echo into future reference-sheet language without turning it into generated mesh, texture, or particle output.
- Keeping `softDeer` and `forestDots` as cute face-memory cues rather than optimization or rarity markers.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future options after a PNG, GLB, or USD exists.
- No Apple framework helps this metadata-only reference handoff today.

External library candidate:

- SnapshotTesting can later protect an accepted Genome Variation QA reference image.
- A drawing, graph, or asset package would not improve the current docs-to-code traceability.

Decision:

- Add a deterministic Core metadata contract for the child draft lineage cue reference handoff.
- Include the face cue `softDeer->FaceBase.deer@headCenter#lineageCue`, the face accent `forestDots->FaceBase.deer@headCenter#lineageCue`, and the existing body/tail/thread lineage annotations.
- Keep generated assets, PNG reference sheets, GLB/USD, ModelIO, SceneKit, RealityKit, SnapshotTesting references, visible UI, persistence, Widget handoff, Package.swift, and Xcode project files unchanged.

Future replacement point:

- When a child draft reference sheet or snapshot host reference image is intentionally accepted, this handoff becomes the checklist source for the face + body + tail lineage cue set.

## Current Loop: Fixed Part Child Draft Reference Acceptance Gate

Handwritten complexity:

- Preventing the accepted-looking child draft cue handoff from being mistaken for a manually reviewed reference image or generated asset.
- Keeping the next step emotionally grounded: art direction must still judge whether the child draft feels cute, family-like, and not over-marked.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future validators after a real PNG, GLB, or USD exists.
- No Apple framework is needed for this gate because it records process state, not asset content.

External library candidate:

- SnapshotTesting remains future support after a reference image is deliberately accepted.
- A workflow/state-machine package would not improve this small acceptance boundary.

Decision:

- Add a deterministic Core metadata contract for the child draft reference acceptance gate.
- Require child draft reference metadata to be ready while keeping manual art review, snapshot acceptance, generation permission, generated assets, and asset outputs closed.
- Keep visible UI, SpriteKit drawing, persistence, Widget handoff, Package.swift, Xcode project files, generated PNGs, GLB/USD, ModelIO, SceneKit, RealityKit, and SnapshotTesting references unchanged.

Future replacement point:

- When a child draft reference image exists, this gate should become the handoff for recording `needsRevision` or `accepted` with review evidence before any snapshot reference is added.

## Current Loop: Genome Variation Family Echo Copy

Handwritten complexity:

- Writing the Genome Variation QA comparison line so it helps the viewer notice family resemblance instead of reading the child draft as random output.
- Naming inherited and changed visible cues without exposing seeds, random rolls, breeding controls, persistence, or optimization language.

Apple framework candidate:

- GameplayKit already creates the deterministic child draft preview.
- SpriteKit already renders the visible parent and child portraits.
- No new Apple framework is needed for this copy-only bridge.

External library candidate:

- SnapshotTesting can later protect the Genome Variation QA surface after this copy is visually accepted.
- A text-generation or templating package would reduce WiPet-specific tone control and is not needed for one affectionate comparison line.

Decision:

- Add a small Core copy contract for `lineageGenomeVariationFamilyEchoCopy`.
- Use it in Genome Variation QA to replace the generic resemblance sentence with a deterministic family-echo line.
- Keep SpriteKit drawing, normal Observation UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, SnapshotTesting, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When Genome Variation QA becomes snapshot-protected, this copy contract should be part of the accepted app-host surface so lineage wording cannot drift back into random or optimization framing.

## Current Loop: SpriteKit Face Silhouette Accessory Cue

Handwritten complexity:

- Making deer and feline face bases readable at small portrait size without making the creature look sharp, realistic, or over-marked.
- Keeping the accessory as part of the cute handmade silhouette rather than a future 3D ear/horn asset claim.

Apple framework candidate:

- SpriteKit is already the renderer and is the right place for this tiny handmade shape addition.
- GameplayKit remains the source of deterministic child draft selection but does not affect drawing.
- CoreImage, ModelIO, SceneKit, and RealityKit are not needed for a 2D silhouette accessory.

External library candidate:

- No drawing or icon package is needed; using one would reduce local creature-art control.
- SnapshotTesting remains future support after the Genome Variation QA surface is manually accepted.

Decision:

- Add a small SpriteKit face silhouette accessory cue for deer and feline faces.
- Add deterministic Core metadata for the cue so tests can prove the accessory remains a silhouette-only, no-asset-output change.
- Keep normal Observation behavior, Widget handoff, persistence, package/project files, generated assets, CoreImage, ModelIO, SceneKit, RealityKit, and SnapshotTesting unchanged.

Future replacement point:

- When fixed 3D FaceBase assets begin, this accessory cue should become a reference note for deer/feline face-base socket and silhouette review, not a generated mesh by itself.

## Current Loop: SpriteKit Body Silhouette Accessory Cue

Handwritten complexity:

- Making sylphian and verdant body bases easier to recognize at small portrait size while keeping them plush, soft, and handmade.
- Avoiding a decorative overload: the accessory should support silhouette reading, not become a badge, score, or generated asset.

Apple framework candidate:

- SpriteKit remains the correct renderer for tiny handmade 2D body accessory shapes.
- GameplayKit is unrelated to this drawing slice except that it already produces deterministic QA creatures.
- CoreImage, ModelIO, SceneKit, and RealityKit are not needed because no texture, 3D asset, or generated output is created.

External library candidate:

- No shape, icon, or drawing package is useful for this small creature-art adjustment.
- SnapshotTesting remains future support after the Genome Variation QA surface is manually accepted.

Decision:

- Add a small SpriteKit body silhouette accessory cue for sylphian and verdant body bases.
- Add deterministic Core metadata for the cue so tests can prove it remains a portrait-visible, no-asset-output change.
- Keep normal Observation behavior, Widget handoff, persistence, package/project files, generated assets, CoreImage, ModelIO, SceneKit, RealityKit, and SnapshotTesting unchanged.

Future replacement point:

- When fixed 3D UpperBody assets begin, this accessory cue should become a reference note for sylphian/verdant body-base silhouette review, not a generated mesh by itself.

## Current Loop: SpriteKit Tail Silhouette Accessory Cue

Handwritten complexity:

- Making fish and floating tails easier to read at small portrait size while keeping tail details soft and affectionate.
- Avoiding feature creep: this is a handmade 2D silhouette cue, not a generated tail mesh or physics system.

Apple framework candidate:

- SpriteKit remains the correct renderer for this tiny 2D tail accessory.
- GameplayKit is unrelated to this drawing slice except for deterministic QA fixture selection.
- CoreImage, ModelIO, SceneKit, and RealityKit are not needed because no texture, 3D asset, or generated output is created.

External library candidate:

- No shape, icon, physics, or animation package is useful for this small static silhouette cue.
- SnapshotTesting remains future support after the Genome Variation QA surface is manually accepted.

Decision:

- Add a small SpriteKit tail silhouette accessory cue for fish and floating tails.
- Add deterministic Core metadata for the cue so tests can prove it remains a portrait-visible, no-asset-output change.
- Keep normal Observation behavior, Widget handoff, persistence, package/project files, generated assets, CoreImage, ModelIO, SceneKit, RealityKit, and SnapshotTesting unchanged.

Future replacement point:

- When fixed 3D TailBase assets begin, this accessory cue should become a reference note for fish/floating tail-base silhouette review, not a generated mesh by itself.

## Current Loop: Genome Variation Silhouette Cue Set Acceptance Gate

Handwritten complexity:

- Judging whether the accepted face, body, and tail silhouette cues feel like family resemblance rather than random decoration.
- Keeping the cue set small enough that Mira and the child draft still feel soft and pet-like at portrait size.

Apple framework candidate:

- SpriteKit remains the handmade renderer for the cues.
- XCTest/Core metadata are enough to validate readiness fields before image snapshots.
- GameplayKit already provides the deterministic Genome Variation QA family draft; no new random framework use is needed.

External library candidate:

- SnapshotTesting is already the future protection path, but this task should not add an app test target, image reference, or new Xcode project edit.
- No additional drawing, layout, graph, or image-processing package is needed.

Decision:

- Add a Core-only acceptance gate for the Genome Variation QA silhouette cue set.
- Require child draft face, sibling body, and sibling tail cue readiness, manual visual QA, no visible technical metadata, no app behavior change, and no generated asset output.
- Expose the gate only as hidden Genome Variation QA metadata so the next SnapshotTesting app-host loop has a single acceptance signal to protect.

Future replacement point:

- When SnapshotTesting image references are added, this acceptance gate should become the precondition for recording the Genome Variation QA reference image.

## Current Loop: Genome Variation Cue Set Lines Snapshot

Handwritten complexity:

- Preserving the accepted Genome Variation cue-set contract without pretending a text snapshot replaces visual review.
- Keeping the protected lines focused on affection/readiness signals rather than implementation internals.

Apple framework candidate:

- Swift Testing remains the assertion runner, but it does not provide stored reference comparison on its own.
- Simulator screenshots remain the manual visual QA source for the actual portraits.

External library candidate:

- SnapshotTesting is already installed as a test-only dependency and is appropriate for a small `.lines` reference.
- Image snapshots and an app test target are still deferred because they would require project-file/reference-image workflow changes.

Decision:

- Add one SnapshotTesting `.lines` reference for the accepted Genome Variation silhouette cue-set metadata.
- Extend the snapshot reference assertion contract to allow `genomeVariationQA` + `genome-variation-silhouette-cue-set` text references.
- Do not add image snapshots, app test targets, Xcode project edits, generated assets, runtime UI changes, Widget changes, persistence writes, or new dependencies.

Future replacement point:

- When app-target image snapshots are added, this `.lines` reference should remain as the semantic precondition while the image reference protects layout and creature placement.

## Current Loop: Snapshot Reference Registry

Handwritten complexity:

- Keeping the snapshot adoption state honest as text references and app hosts accumulate.
- Avoiding a jump to image snapshots before the current reference surface inventory is explicit and testable.

Apple framework candidate:

- Swift Testing can validate a pure registry contract.
- Simulator screenshots remain the visual QA source for app-host surfaces.

External library candidate:

- SnapshotTesting is already installed and has three text references in the repo.
- No new SnapshotTesting feature, image assertion, app test target, or project-file edit is needed for a registry contract.

Decision:

- Add a Core-only snapshot reference registry summary for current text references and app-host surfaces.
- Require exactly the accepted text references, all current app hosts, no image references, no app-target image snapshot, no project edit for image snapshots, and no runtime behavior change.
- Update snapshot adoption docs so they describe the actual current state before any image snapshot work begins.

Future replacement point:

- When app-target image snapshots are introduced, this registry should grow deliberately to record the first image reference and the project-file change that enabled it.

## Current Loop: Growth Ceremony Preview Lines Snapshot

Handwritten complexity:

- Preserving the Growth Ceremony preview as an attachment-safe ceremony contract rather than a hidden growth button.
- Keeping the snapshot focused on family memory, before/after observation, acknowledgement, dry-run persistence, and Widget handoff boundaries.
- Protecting the rule that preview must not mutate `Creature`, append discovery logs, publish Widget handoff, or expose raw random/seed details.

Apple framework candidate:

- Swift Testing remains the assertion runner for the semantic contract.
- Simulator screenshots remain the source of visual QA for `ObservationHomeView`.
- No new Apple framework is needed because this task does not change random planning, drawing, persistence, or Widget delivery.

External library candidate:

- SnapshotTesting is already installed as a test-only dependency and is appropriate for a small `.lines` reference.
- Image snapshots remain deferred because this loop does not add an app test target, reference image workflow, or Xcode project edit.

Decision:

- Add one SnapshotTesting `.lines` reference for the Growth Ceremony preview semantic contract.
- Extend the snapshot reference assertion and registry allow-lists to include `growth-ceremony-preview-contract`.
- Keep visible UI, `advanceGrowthStage()`, Creature mutation, discovery writes, Widget handoff publishing, SpriteKit drawing, generated assets, dependencies, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When Growth Ceremony becomes a player-facing interaction, this text reference should remain the semantic guard while a separate app-target image snapshot protects layout and portrait composition.

Result:

- Adopted the existing SnapshotTesting `.lines` path for one Growth Ceremony preview semantic reference.
- Did not introduce a new library, image snapshot, app test target, project edit, renderer change, Widget change, or persistence behavior.
- Confirmed this supports affection by preserving the dry-run ceremony boundary and family-echo copy before adding more visible ceremony UI.

## Current Loop: Growth Ceremony Preview App Snapshot

Handwritten complexity:

- Preserving the preview-only Growth Ceremony card as a quiet observation moment, not a growth execution button.
- Keeping the visible family-memory line, before/after portraits, and acknowledgement affordance readable without changing normal Observation.
- Proving that preview still does not mutate `Creature`, call `advanceGrowthStage()`, publish Widget handoff, write persistence, or append discovery logs.

Apple framework candidate:

- XCTest remains the app-target launcher and UI metadata verifier.
- Simulator visual QA remains required because this is an emotional surface, not only a pixel contract.

External library candidate:

- SnapshotTesting is already installed test-only and can protect one accepted app-target image after manual review.
- No new dependency is justified; ceremony language, layout density, and cuteness judgment remain WiPet-authored.

Decision:

- Add one app-target SnapshotTesting image reference for the existing Growth Ceremony preview surface.
- Add a small app-target text reference that captures visible/dry-run readiness metadata from the launched app.
- Keep `Package.swift`, `WiPet.xcodeproj`, Creature mutation, `advanceGrowthStage()`, Widget handoff behavior, persistence, SpriteKit drawing, generated assets, and normal Observation UI unchanged.

Future replacement point:

- If Growth Ceremony becomes a multi-step player-facing ceremony, this snapshot should remain a first-screen visual guard while interaction-specific tests protect each acknowledged step.

Result:

- Added an app-target Growth Ceremony preview `.lines` reference and one accepted image reference using the existing SnapshotTesting dependency.
- Verified the launched app keeps `allowsMutation:false`, `widgetHandoffAllowed:false`, `write:false`, `mutatesCreature:false`, and `growthLineageAffectionCopyReady:true`.
- Manual Simulator QA accepted the card as readable and calm on iPhone 17.
- No new dependency, project edit, renderer change, normal Observation behavior change, Widget handoff change, persistence write, discovery append, or Creature mutation was introduced.

## Current Loop: Growth Ceremony Acknowledged State Snapshot

Handwritten complexity:

- The acknowledgement tap should feel like noticing a change together, not confirming a mutation or committing growth.
- The local `Noticed` state must stay preview-only and must not become an accidental bridge to persistence, discovery append, Widget handoff publish, or `advanceGrowthStage()`.

Apple framework candidate:

- XCTest remains the correct app interaction driver because the task is a real tap on the launched preview surface.
- SwiftUI state remains sufficient for the local acknowledgement flag; no new observation framework is needed.

External library candidate:

- SnapshotTesting is already installed test-only and can store the post-tap semantic lines.
- A new UI automation or snapshot package would not improve affection, safety, or reversibility here.

Decision:

- Extend the app-target Growth Ceremony preview test with post-tap text and image references for the acknowledged state.
- Accept one additional image reference because XcodeBuildMCP runtime snapshot did not expose a tappable target, while the XCTest path performs the real tap and captures the resulting UI.
- Keep visible normal Observation, Creature mutation, `advanceGrowthStage()`, Widget handoff, persistence, discovery append, generated assets, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Future replacement point:

- When the real Growth Ceremony flow advances beyond preview, this post-tap contract must remain the gate before any commit-capable confirmation is introduced.

Result:

- Added post-tap Growth Ceremony app-target text and image references using the existing SnapshotTesting dependency.
- Confirmed `noted:true` remains paired with `mutation:false`, `persistence:false`, `widget:false`, `discovery:false`, `write:false`, and `mutatesCreature:false`.
- Accepted the `Noticed` visual state after manual image review; it reads as shared observation, not a growth execution control.
- No new dependency, project edit, normal Observation change, SpriteKit renderer change, Widget handoff change, persistence write, discovery append, or Creature mutation was introduced.

## Current Loop: Growth Ceremony Acknowledged Gate Bridge

Handwritten complexity:

- The local `Noticed` state should reach the ceremony gate as emotional acknowledgement, while still refusing growth commit because discovery, Widget handoff, and persistence evidence are not prepared.
- The subtle product line is "I noticed this change" rather than "advance this pet now".

Apple framework candidate:

- SwiftUI local state remains the correct owner for preview-only acknowledgement.
- XCTest remains sufficient for verifying the tapped app state; no new Apple framework is needed.

External library candidate:

- Existing SnapshotTesting app-target `.lines` and image references are enough to protect the state transition.
- No new dependency is adopted because this is state wiring, not animation, graph layout, persistence, or image generation.

Decision:

- Pass `ObservationHomeState.hasNotedGrowthCeremonyObservation` into `GrowthCeremonyPlayerAcknowledgementGatePreview`.
- Extend the app-target post-tap snapshot text to include acknowledgement gate and surface summaries.
- Keep `allowsCommit:false`, Creature mutation, `advanceGrowthStage()`, Widget handoff, persistence, discovery append, generated assets, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Future replacement point:

- When a real commit-capable Growth Ceremony is designed, this bridge must remain paired with mutation proof, discovery handoff, Widget handoff, and persistence readiness gates before any write path is enabled.

Result:

- Wired local `hasNotedGrowthCeremonyObservation` into `GrowthCeremonyPlayerAcknowledgementGatePreview`.
- Extended app-target text references so pre-tap stays `acknowledged:false` and post-tap becomes `acknowledged:true`, with `allowsCommit:false` preserved in both gate and surface summaries.
- Confirmed visual preview remains unchanged and calm; the bridge is hidden ceremony state wiring, not a new growth action.
- No new dependency, project edit, visible normal Observation change, Creature mutation, `advanceGrowthStage()` call, Widget handoff change, persistence write, discovery append, or generated asset was introduced.

## Current Loop: SpriteKit Wing Silhouette Accessory Cue

Handwritten complexity:

- Making wing bases readable as part of "この子は他の子と違う" without overdecorating the pet.
- Keeping the cue cute and soft enough that fairy, dragon, crystal, jellyfish, plant, and lunar wings still feel like WiPet parts rather than icon badges.

Apple framework candidate:

- SpriteKit remains the correct renderer because this is a tiny hand-art-directed silhouette cue on existing `SKShapeNode` wing parts.
- No GameplayKit/CoreImage/ModelIO/SceneKit/RealityKit use is needed in this loop.

External library candidate:

- None. A drawing or geometry package would not improve cuteness, reversibility, or iOS integration for two small handmade wing-tip marks.

Decision:

- Add a small handmade SpriteKit wing silhouette accessory cue for fairy and dragon wings.
- Add Core metadata/readiness for the wing accessory and extend Genome Variation cue-set acceptance to face/body/wing/tail.
- Keep normal Observation UI, Widget handoff, persistence, Growth Ceremony behavior, `Package.swift`, Xcode project files, generated assets, SnapshotTesting references, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- If wing variation grows beyond tiny marks, move the shape vocabulary into a small part-catalog/DSL before adding generated textures or 3D assets.

Result:

- Added the wing accessory with handmade SpriteKit nodes and Core metadata only.
- Extended the Genome Variation cue-set gate to face/body/wing/tail.
- Confirmed no new dependency, generated asset, project edit, Widget handoff, persistence write, Growth Ceremony behavior, CoreImage, ModelIO, SceneKit, or RealityKit was introduced.

## Current Loop: Fixed Part Accessory Recipe Bridge

Handwritten complexity:

- The accepted face/body/wing/tail silhouette accessories now have tiny handmade SpriteKit shapes, but their recipe names should not remain hidden inside renderer implementation.
- The bridge must preserve art-direction language without moving cuteness decisions into a library or generated asset pipeline.

Apple framework candidate:

- Swift Testing and hidden QA metadata are enough for this contract.
- SpriteKit remains the renderer, but this loop should not change drawing.

External library candidate:

- None. A catalog, schema, or drawing dependency would add weight without improving affection, lineage feeling, or reversibility.

Decision:

- Add a Core/App metadata bridge for current 2D accessory recipe names across face, body, wing, and tail.
- Keep it text-only and QA-only: no visible UI, no SpriteKit drawing change, no generated PNG/GLB/USD, no CoreImage, no ModelIO/SceneKit/RealityKit, no package/project edit.

Future replacement point:

- When fixed-part reference sheets or 3D assets are generated, this bridge should become the naming source for accessory annotations before asset output is allowed.

Result:

- Added the accessory recipe bridge as text metadata only.
- Confirmed the current face/body/wing/tail recipe vocabulary is explicit: `softEarNubs`, `softEarTips`, `softShoulderPetals`, `leafShoulderNubs`, `softWingTipPearl`, `softWingTipClaw`, `softForkFin`, and `softTetherDot`.
- Confirmed `assetOutputs:none` and `geometryChanged:false`, so this loop did not alter SpriteKit drawing, visible UI, Widget handoff, persistence, generated assets, dependencies, `Package.swift`, or Xcode project files.
- Kept the bridge aligned with affection goals by making part language traceable before asset output, without replacing WiPet's handmade cuteness decisions with a library.

## Current Loop: Fixed Part Accessory Reference Annotations

Handwritten complexity:

- The current face/body/wing/tail accessories need reference-sheet annotation language, socket ownership, and review panels before any PNG or 3D asset pipeline can treat them as fixed parts.
- This must stay as art-direction metadata so accessory cuteness remains adjustable in SpriteKit and does not become prematurely frozen as generated geometry.

Apple framework candidate:

- Swift Testing and hidden QA metadata are enough to validate the annotation contract.
- SpriteKit remains the renderer, but this loop should not change drawing, animation, or layout.

External library candidate:

- None for this loop. SnapshotTesting image references, CoreImage, ModelIO, SceneKit, and RealityKit would be premature because there is no accepted PNG, GLB, USD, texture, or socket asset to validate.

Decision:

- Add a Core/App metadata contract for current accessory reference-sheet annotations across face, body, wing, and tail.
- Require the existing accessory recipe bridge to be ready, require `accessoryCue`, `socketDiagram`, and `rigDiagram` panels, and keep generated assets disabled.
- Keep generated PNG/GLB/USD, CoreImage, ModelIO, SceneKit, RealityKit, SnapshotTesting image references, visible UI, Widget handoff, persistence, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When the first accessory reference sheet or 3D asset candidate exists, this annotation contract should become the checklist source for manual art review and later visual/snapshot validation.

Result:

- Added accessory reference annotations as text metadata only.
- Confirmed face/body/wing/tail accessory recipes map to future reference-sheet socket labels and the `accessoryCue`, `socketDiagram`, and `rigDiagram` panels.
- Confirmed the annotation contract depends on the accessory recipe bridge readiness and keeps `assetOutputs:none` and `generatedAssets:false`.
- Confirmed no new dependency, image snapshot, generated PNG/GLB/USD, renderer change, visible UI change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: Fixed Part Accessory Reference Sheet Preflight

Handwritten complexity:

- Accessory annotations are ready, but they must not imply that a PNG reference sheet, 3D asset, or snapshot reference may be generated.
- The preflight needs to connect accessory annotations to the existing manual-review gates while preserving the closed generation boundary.

Apple framework candidate:

- Swift Testing and hidden QA metadata are enough for a deterministic preflight contract.
- SpriteKit remains the renderer, but this loop should not change drawing, animation, layout, or runtime behavior.

External library candidate:

- None for this loop. SnapshotTesting image references, CoreImage, ModelIO, SceneKit, and RealityKit remain deferred until a manually accepted reference artifact exists.

Decision:

- Add a metadata-only accessory reference-sheet preflight that requires accessory annotation readiness plus the existing fixed-part manual checklist, manual review state, and evidence-field gates.
- Require candidate existence, generation, snapshot acceptance, runtime loading, and asset outputs to remain closed.
- Keep generated PNG/GLB/USD, image snapshots, CoreImage, ModelIO, SceneKit, RealityKit, visible UI, Widget handoff, persistence, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When a real accessory reference sheet candidate exists, this preflight should split into candidate review, visual QA evidence capture, and later snapshot/asset validation.

Result:

- Added the accessory reference-sheet preflight as text metadata only.
- Confirmed accessory annotation readiness is connected to the existing fixed-part manual checklist, manual review state, and review evidence field gates.
- Confirmed the preflight stays closed with `candidateExists:false`, `generationAllowed:false`, `snapshotAccepted:false`, `runtimeLoaded:false`, and `assetOutputs:none`.
- Confirmed no new dependency, image snapshot, generated PNG/GLB/USD, renderer change, visible UI change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: Fixed Part Accessory Manual Review Checklist

Handwritten complexity:

- The general fixed-part checklist protects panels, sockets, grayscale rules, and generation boundaries, but accessory cues need a more specific art-direction checklist.
- The checklist must preserve the feeling that accessories are small, soft, secondary to the pet's silhouette, and not a stats-like collectible decoration.

Apple framework candidate:

- Swift Testing and hidden QA metadata are sufficient for a deterministic checklist contract.
- SpriteKit remains the renderer, but this loop should not change drawing, animation, layout, or runtime behavior.

External library candidate:

- None. A design-token, schema, image snapshot, CoreImage, ModelIO, SceneKit, or RealityKit dependency would not improve the accessory cuteness review before a real reference artifact exists.

Decision:

- Add a metadata-only accessory manual review checklist extension that depends on accessory reference-sheet preflight readiness.
- Require review items for soft scale, socket ownership, silhouette secondary priority, cute readability, family likeness safety, grayscale/no-color-pattern-glow, and no generated geometry.
- Keep generated PNG/GLB/USD, image snapshots, CoreImage, ModelIO, SceneKit, RealityKit, visible UI, Widget handoff, persistence, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When a real accessory reference sheet candidate exists, this checklist should become part of the Creature Art Director acceptance evidence before visual/snapshot validation.

Result:

- Added the accessory manual review checklist as text metadata only.
- Confirmed the checklist depends on accessory reference-sheet preflight readiness and keeps manual review, snapshot acceptance, generation, runtime loading, and asset outputs closed.
- Confirmed review items cover soft scale, socket ownership, secondary silhouette priority, cute readability, family likeness safety, grayscale-only, no color/pattern/glow, and no generated geometry.
- Confirmed no new dependency, image snapshot, generated PNG/GLB/USD, renderer change, visible UI change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: Fixed Part Accessory Review Evidence Handoff

Handwritten complexity:

- The accessory checklist now defines what a Creature Art Director must judge, but future review evidence needs named slots before any artifact can be accepted.
- The handoff must make room for affection-specific notes without implying that review has happened or that image/asset generation is allowed.

Apple framework candidate:

- Swift Testing and hidden QA metadata are enough for deterministic evidence-slot validation.
- SpriteKit remains the renderer, but this loop should not change drawing, animation, layout, or runtime behavior.

External library candidate:

- None. SnapshotTesting image references, CoreImage, ModelIO, SceneKit, RealityKit, and document/report libraries are premature because no accessory reference artifact or recorded review evidence exists.

Decision:

- Add a metadata-only accessory review evidence handoff that depends on the accessory manual review checklist readiness.
- Define empty evidence slots for reviewer note, checked items, visual QA image, decision reason, affection risk, and revision notes.
- Keep evidence unrecorded, generation closed, snapshot acceptance false, runtime loading false, generated assets absent, and asset outputs `none`.

Future replacement point:

- When a Creature Art Director actually reviews an accessory reference artifact, this handoff should be replaced by recorded evidence and linked visual QA/snapshot validation in a separate commit.

Result:

- Added the accessory review evidence handoff as text metadata only.
- Confirmed the handoff depends on accessory manual review checklist readiness and exposes empty slots for reviewer note, checked items, visual QA image, decision reason, affection risk, and revision notes.
- Confirmed evidence remains unrecorded with empty path/note, snapshot acceptance false, generation disabled, runtime loading false, generated assets false, and `assetOutputs:none`.
- Confirmed no new dependency, document/report output, image snapshot, generated PNG/GLB/USD, renderer change, visible UI change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: Fixed Part Accessory Artifact Candidate Record

Handwritten complexity:

- The accessory evidence handoff now names future review slots, but a future reference artifact also needs one stable candidate stem/path before any generated image or asset appears.
- The record must make the future review target traceable while keeping generation closed so the team does not accidentally treat an unreviewed PNG as accepted WiPet art.

Apple framework candidate:

- Swift Testing and hidden accessibility probes are sufficient for this metadata-only candidate record.
- SpriteKit remains the renderer, but this loop should not change drawing, animation, layout, runtime behavior, or asset loading.

External library candidate:

- None. SnapshotTesting image references, CoreImage, ModelIO, SceneKit, RealityKit, and file-generation libraries remain deferred until a real reference artifact candidate exists and manual art direction is ready to review it.

Decision:

- Add a metadata-only accessory artifact candidate record that depends on accessory review evidence handoff readiness.
- Reserve `wipet_fixed_part_accessory_reference_sheet_v1` at `docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png` for a future PNG reference sheet.
- Keep candidate existence false, generation disabled, snapshot acceptance false, runtime loading false, generated assets false, and asset outputs `none`.
- Keep generated PNG/GLB/USD, image snapshots, CoreImage, ModelIO, SceneKit, RealityKit, visible UI, Widget handoff, persistence, `Package.swift`, and Xcode project files unchanged.

Future replacement point:

- When the first accessory reference sheet is intentionally created, this record should become the source of truth for the generated candidate path before Creature Art Director review and visual/snapshot validation happen in separate commits.

Result:

- Added the accessory artifact candidate record as text metadata only.
- Confirmed the record depends on accessory review evidence handoff readiness and reserves `wipet_fixed_part_accessory_reference_sheet_v1`.
- Confirmed the future path is `docs/For_Agent/reference_sheets/wipet_fixed_part_accessory_reference_sheet_v1.png`.
- Confirmed candidate existence remains false, generation disabled, snapshot acceptance false, runtime loading false, generated assets false, and `assetOutputs:none`.
- Confirmed no new dependency, image snapshot, generated PNG/GLB/USD, renderer change, visible UI change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: SnapshotTesting Genome Variation Image Candidate Readiness

Handwritten complexity:

- Genome Variation QA now has an app-host launch path and text snapshot references, but the first image reference must not be recorded until the visual surface is deliberately accepted.
- The readiness contract must protect affection-facing visuals from accidental snapshot freezing, especially while creature silhouettes and family echoes are still being tuned by hand.

Apple framework candidate:

- XCTest/Swift Testing plus the existing SnapshotTesting package are enough for a metadata-only image candidate readiness gate.
- SwiftUI/SpriteKit app-host rendering remains the visual source, but this loop does not add an image assertion or change rendering.

External library candidate:

- SnapshotTesting is already adopted as a test-only dependency, but this loop should not add a new image reference yet.
- No additional library is needed; image assertion setup, app test target wiring, or Xcode project edits must happen in a separate focused commit.

Decision:

- Add a Core/App metadata contract for `genomeVariationQA` image snapshot candidate readiness.
- Require the existing snapshot host entry to be ready, manual visual QA to pass, technical metadata to stay hidden, no reference image to be recorded, no image assertion to be added, and no app behavior change.
- Keep generated images, SnapshotTesting image references, app test target changes, `Package.swift`, Xcode project files, SpriteKit drawing, Widget handoff, and persistence unchanged.

Future replacement point:

- When Genome Variation QA is manually accepted as emotionally stable, this readiness gate should become the precondition for recording the first SnapshotTesting image reference in an isolated app-target commit.

Result:

- Added the Genome Variation image snapshot candidate readiness gate as metadata only.
- Confirmed the gate depends on the existing snapshot host entry and manual visual QA.
- Confirmed reference image recording, image assertion, app target addition, Xcode project edits, visible technical metadata, app behavior changes, and Widget behavior changes remain false.
- Confirmed no new image reference, generated asset, renderer change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: SnapshotTesting App Target Isolation Plan

Handwritten complexity:

- The project currently has app and widget targets but no app test target for image snapshots.
- Adding a SnapshotTesting image assertion will require Xcode project editing, target wiring, and reference image management, which must not be mixed with unrelated renderer, Widget, or docs work.

Apple framework candidate:

- XCTest is the Apple-standard test harness for a future app-target image snapshot.
- SwiftUI/SpriteKit remain the rendering source; no drawing code should move into a test-only helper.

External library candidate:

- SnapshotTesting is already available through `Package.swift` and remains the right support library for image regression.
- This loop should not add another dependency, record a reference image, or edit the Xcode project yet.

Decision:

- Add a metadata-only isolation plan for a future `WiPetSnapshotTests` app test target.
- Require the existing Genome Variation image candidate to be ready, existing project targets to remain `WiPet` and `WiPetWidget`, SnapshotTesting package availability to be true, and all project/image/assertion/runtime changes to remain false.
- Keep `Package.swift`, Xcode project files, image references, SpriteKit drawing, visible UI, Widget handoff, and persistence unchanged.

Future replacement point:

- The next image snapshot implementation may edit `WiPet.xcodeproj` only in a dedicated commit that creates the app test target and records or intentionally declines the first reference image with visual QA evidence.

Result:

- Added the SnapshotTesting app target isolation plan as metadata only.
- Confirmed current Xcode project targets are `WiPet` and `WiPetWidget`, with no app test target currently present.
- Reserved `WiPetSnapshotTests` as the future app test target name for Genome Variation image snapshots.
- Confirmed SnapshotTesting package availability and XCTest harness intent while keeping app target addition, Xcode project edits, reference image recording, image assertion, renderer changes, and Widget changes false.
- Confirmed no new image reference, generated asset, renderer change, Widget handoff, persistence write, `Package.swift`, or Xcode project edit was introduced.

## Current Loop: WiPetSnapshotTests Target Entry

Handwritten complexity:

- The project needs a real app-level test entry before SnapshotTesting image references can be introduced safely.
- The first target commit must prove the snapshot host can launch and expose readiness probes without freezing an image or changing creature rendering.

Apple framework candidate:

- XCTest UI testing is the smallest Apple-standard harness for launching the app with `--wipet-snapshot-host-genome-variation`.
- SwiftUI/SpriteKit rendering stays inside the app; the test only confirms the host surface and hidden readiness metadata.

External library candidate:

- SnapshotTesting remains the selected image-regression library, but this target-entry loop should not add an image assertion or reference file yet.
- No additional package is needed because `Package.swift` already contains SnapshotTesting for existing package tests.

Decision:

- Add an isolated `WiPetSnapshotTests` UI test target to `WiPet.xcodeproj`.
- Add one XCTest that launches Genome Variation snapshot host and asserts the target-entry readiness probe.
- Update runtime metadata from "future isolation plan" to "target entry present" while keeping reference image recording and image assertion false.
- Keep SpriteKit drawing, visible UI, Widget handoff, persistence, generated assets, and image references unchanged.

Future replacement point:

- The next SnapshotTesting loop can add the first image assertion/reference only after visual QA accepts the Genome Variation surface and the new target entry remains green.

Result:

- Added the isolated `WiPetSnapshotTests` UI test target and shared `WiPetSnapshotTests` / `WiPet` schemes.
- Added one XCTest that launches `--wipet-snapshot-host-genome-variation` and asserts `snapshotAppTargetEntryReady:true`.
- Confirmed the target-entry summary includes `target:WiPetSnapshotTests`, `referenceImage:false`, and `imageAssertion:false`.
- Updated snapshot-host metadata from future isolation plan to current target-entry state.
- Confirmed no SnapshotTesting image assertion, reference image, renderer change, Widget handoff, persistence write, generated asset, or `Package.swift` change was introduced.
- Intentionally changed `WiPet.xcodeproj` only for the isolated app UI test target entry.

## Current Loop: SnapshotTesting App Target Text Probe

Handwritten complexity:

- `WiPetSnapshotTests` currently proves the app host launches through XCTest, but does not yet prove the SnapshotTesting library can run inside the app UI test target.
- Moving straight to an image reference would freeze a handmade creature surface before the project has accepted the first visual baseline.

Apple framework candidate:

- XCTest stays responsible for launching the app with `--wipet-snapshot-host-genome-variation`.
- Raw `XCTAssert` remains useful for readiness booleans, but it does not exercise the selected snapshot library path.

External library candidate:

- SnapshotTesting is already adopted for package-level `.lines` references and remains the chosen support library.
- The Xcode UI test target needs a direct test-only package product dependency before image snapshots can be added safely.

Decision:

- Add SnapshotTesting to `WiPetSnapshotTests` only.
- Add one `.lines` app-target reference for target-entry metadata.
- Keep image references, image assertions, visible UI, SpriteKit drawing, Widget handoff, persistence, generated assets, and `Package.swift` unchanged.

Future replacement point:

- After this text probe passes, the first image snapshot can be introduced in a separate loop with manual visual acceptance evidence.

Result:

- Added SnapshotTesting to `WiPetSnapshotTests` as a direct Xcode package product dependency.
- Added the Xcode workspace SwiftPM `Package.resolved` file for reproducible app-target package resolution.
- Added one `.lines` app-target reference for `snapshot-app-target-entry`.
- Kept the existing UI launch/readiness assertions and added SnapshotTesting coverage for the same target-entry metadata.
- Fixed the initial UI test target import conflict by clearing `OTHER_SWIFT_FLAGS` only on `WiPetSnapshotTests`, matching SnapshotTesting's UI test target guidance for the inherited `Testing` module alias.
- Confirmed no image reference, image assertion, renderer change, Widget handoff change, persistence write, visible UI change, generated asset, or `Package.swift` change was introduced.

## Current Loop: Fixed Part Shape Recipe Coverage

Handwritten complexity:

- `PartAssembler` already uses handmade wing, tail, body, and head shape recipes, but catalog validation only proves family, layer, and socket coverage.
- Before freezing a Genome Variation image snapshot, the project should prove the current handmade shapes are catalog-described so future visual changes stay intentional.

Apple framework candidate:

- SpriteKit remains the renderer and XCTest remains the verification harness.
- No Apple framework replaces the small shape vocabulary because the recipe names are WiPet-specific art direction.

External library candidate:

- SnapshotTesting is now ready in `WiPetSnapshotTests`, but image assertions should wait until the shape vocabulary is explicitly covered.
- No new external library is useful for this slice.

Decision:

- Add internal shape recipe IDs to fixed-part catalog entries.
- Add a read-only assembly-plan coverage check proving selected visible parts map to catalog recipe IDs.
- Expose the result only as hidden Genome Variation QA metadata and a text snapshot extension.
- Keep SpriteKit paths, colors, sockets, motion, visible UI, Widget handoff, persistence, image references, and package/project dependencies unchanged.

Future replacement point:

- Once shape recipe coverage is green, an image snapshot can freeze a creature surface with clearer evidence that its handmade forms are intentional.

Result:

- Added internal `CreatureShapeRecipeID` values for the current wing, tail, body, head, eye, and mouth recipes.
- Extended `CreatureFixedPartCatalogEntry` with `shapeRecipeIDs`.
- Added `CreatureAssemblyItem.shapeRecipeID`, `CreatureAssemblyPlan.hasCatalogShapeRecipeCoverage(in:)`, and `shapeRecipeValidationSummary(in:)`.
- Strengthened `CreatureAssemblyPlan.isFullyCatalogBacked(in:)` so catalog-backed now also requires recipe coverage.
- Exposed hidden Genome Variation QA recipe coverage metadata for baseline, sibling, and child draft.
- Extended the `WiPetSnapshotTests` app-target `.lines` snapshot to verify `fixedPartShapeRecipeCoverageReady:true`.
- Confirmed no SpriteKit path, color, socket, z-order, motion, visible UI, Widget handoff, persistence, image reference, package dependency, or project dependency changed.

## Current Loop: Fixed Part Detail Recipe Coverage

Handwritten complexity:

- Naming the handmade SpriteKit accent/accessory marks that make one pet feel different from another before freezing a Genome Variation image reference.

Apple framework candidate:

- Keep SpriteKit and `SKAction` as-is. The task catalogs existing hand-shaped details; it does not need GameplayKit, CoreImage, ModelIO, SceneKit, or RealityKit.

External library candidate:

- Keep using the existing SnapshotTesting app-target text probe only. Do not add image references or new packages in this loop.

Decision:

- Add typed detail recipe IDs to the fixed-part catalog for face/body/wing/tail accents and silhouette accessories.
- Expose coverage only as hidden Genome Variation snapshot-host metadata and extend the existing `.lines` reference.
- Keep `PartAssembler` drawing paths unchanged because the small soft marks are WiPet cuteness art direction, not generic rendering logic.

Minimum scope:

- Add metadata/readiness helpers for detail recipe coverage.
- Assert baseline, sibling, and child draft coverage in `WiPetSnapshotTests`.
- Do not change normal Observation Home, Widget handoff, SpriteKit geometry, package dependencies, project structure, or image snapshots.

Future replacement point:

- If a later image snapshot is recorded, require both shape and detail recipe coverage so the frozen pixels are backed by named catalog intent.

Result:

- Added internal `CreatureDetailRecipeID` values for current face/body/wing/tail accent and silhouette-accessory recipes.
- Extended `CreatureFixedPartCatalogEntry` with `detailRecipeIDs` without changing drawing paths.
- Added `CreatureAssemblyItem.detailRecipeIDs`, `CreatureAssemblyPlan.hasCatalogDetailRecipeCoverage(in:)`, and `detailRecipeValidationSummary(in:)`.
- Strengthened `CreatureAssemblyPlan.isFullyCatalogBacked(in:)` so catalog-backed now also requires detail recipe coverage.
- Exposed hidden Genome Variation QA metadata for baseline, sibling, and child draft detail coverage.
- Extended the `WiPetSnapshotTests` app-target `.lines` snapshot to verify `fixedPartDetailRecipeCoverageReady:true`.
- Confirmed no SpriteKit path, color, socket, z-order, motion, visible UI, Widget handoff, persistence, image reference, package dependency, or project dependency changed.

## Current Loop: SnapshotTesting Genome Variation First Image Reference

Handwritten complexity:

- The Genome Variation QA surface is now manually reviewed and catalog-backed, but visual regressions can still slip through text metadata because the actual cute silhouettes, spacing, and family-copy layout are pixels.

Apple framework candidate:

- XCTest UI testing remains the Apple-standard launcher for the app-host surface, and Simulator screenshot review remains the human visual QA source.
- Apple frameworks do not provide a small stored-reference image assertion for this target.

External library candidate:

- SnapshotTesting is already adopted and app-target-ready. It is the appropriate support library for the first stored image reference, as long as it protects rather than replaces manual art direction.

Decision:

- Add one app-target SnapshotTesting image assertion for the accepted Genome Variation snapshot host.
- Require the existing target-entry, shape coverage, and detail coverage readiness probes before recording pixels.
- Keep SpriteKit drawing, visible UI, Widget handoff, persistence, generated assets, package dependencies, and Xcode project structure unchanged.

Minimum scope:

- Extend `SnapshotHostGenomeVariationTests` with one image assertion from the launched app screenshot.
- Store the first reference image under the existing `WiPetSnapshotTests/__Snapshots__` tree.
- Do not broaden to Observation Home, Widget, Growth Ceremony, or SpriteKit renderer changes in this loop.

Future replacement point:

- Later visual variation work must update this image only after docs record the creature-art reason and visual QA confirms the new pixels still feel affectionate and family-like.

Result:

- Added one app-target SnapshotTesting image assertion for Genome Variation QA.
- Recorded the first accepted Genome Variation reference image under `WiPetSnapshotTests/__Snapshots__`.
- Cropped status bar pixels from the asserted image so the clock and device indicators do not make the reference unstable.
- Verified the reference preserves the title, baseline/sibling portraits, child draft, and family echo copy.
- Confirmed normal UI, SpriteKit drawing, Widget handoff, persistence, generated assets, package dependencies, and Xcode project structure stayed unchanged.

## Current Loop: SpriteKit Ancestral Glint Cue Text Contract

Handwritten complexity:

- The small upper-chest ancestral glint is a WiPet-specific family-memory cue; it should feel like "祖先に似ている" rather than a generic glow particle.

Apple framework candidate:

- Keep SpriteKit as the renderer. The cue already uses existing `SKShapeNode` dots and does not need CoreImage, SceneKit, RealityKit, or ModelIO.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` reference only. Do not add packages or image references in this loop.

Decision:

- Expose the existing ancestral glint readiness in the Genome Variation hidden QA surface.
- Extend the app-target text snapshot so baseline and child draft glint contracts remain active, ancestry-linked, asset-free, and non-mutating.
- Keep visible UI, SpriteKit drawing paths, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add a hidden `spriteKitAncestralGlintCueReadinessSummary` text probe.
- Assert and snapshot `spriteKitAncestralGlintCueSummary`, its readiness, and the child draft glint summary in `WiPetSnapshotTests`.
- Do not alter creature geometry, colors, motion, normal Observation Home, or Widget behavior.

Future replacement point:

- If ancestral glint later gains animation or multiple inherited styles, keep this text contract as the gate before changing the accepted Genome Variation image reference.

Result:

- Added a hidden `spriteKitAncestralGlintCueReadinessSummary` probe to the Genome Variation QA host.
- Extended `WiPetSnapshotTests` assertions and the app-target `.lines` reference with baseline readiness, baseline glint summary, and child draft glint summary.
- Verified both baseline and child draft carry `softAncestralGlint` at `upperChest` with `ancestryLinked:true`, `active:true`, and `assetOutputs:none`.
- Kept SpriteKit drawing, geometry, color, motion, visible UI, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.
- Simulator visual QA confirmed the Genome Variation host remains readable and calm.

## Current Loop: SpriteKit Lineage Memory Thread Text Contract

Handwritten complexity:

- The body-to-tail `softLineageMemoryThread` is a WiPet-specific family-memory line; it should read as "うちの家系だ" rather than a decorative curve.

Apple framework candidate:

- Keep SpriteKit as the renderer. The cue already uses a handmade `SKShapeNode` path and does not need CoreImage, SceneKit, RealityKit, ModelIO, or GameplayKit changes.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` reference only. No new package, image reference, or snapshot target is needed.

Decision:

- Expose the existing lineage memory thread readiness in the Genome Variation hidden QA surface.
- Extend the app-target text snapshot so baseline and child draft thread contracts remain active, ancestry-linked, body-to-tail, asset-free, and non-mutating.
- Keep visible UI, SpriteKit drawing paths, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add hidden `spriteKitLineageMemoryThreadSummary` and `spriteKitLineageMemoryThreadReadinessSummary` probes for the baseline.
- Add a hidden child draft lineage memory thread summary probe.
- Assert and snapshot the three labels in `WiPetSnapshotTests`.

Future replacement point:

- If the memory thread later gains animation or different inherited-route styles, keep this text contract as the gate before changing pixels or recording a new image reference.

Result:

- Added hidden Genome Variation QA probes for baseline `spriteKitLineageMemoryThreadSummary`, baseline readiness, and child draft memory thread summary.
- Extended `WiPetSnapshotTests` assertions and the app-target `.lines` reference with the three memory-thread contract lines.
- Verified both baseline and child draft carry `softLineageMemoryThread` from `softAncestralGlint` to `softTailMemoryDots` at `bodyToTail` with `ancestryLinked:true`, `active:true`, and `assetOutputs:none`.
- Kept SpriteKit drawing paths, geometry, color, motion, visible UI, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.
- Simulator visual QA confirmed the Genome Variation host remains readable and calm; the screenshot captured Mira blinking, which is expected motion.

## Current Loop: SpriteKit Tail Lineage Echo Text Contract

Handwritten complexity:

- The `softTailMemoryDots` cue is a handmade tail detail that makes inherited resemblance visible without turning lineage into a stat.

Apple framework candidate:

- Keep SpriteKit as the renderer. The cue already uses small `SKShapeNode` dots attached to the tail and does not need CoreImage, SceneKit, RealityKit, ModelIO, or GameplayKit changes.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` reference only. No new package, image reference, or snapshot target is needed.

Decision:

- Expose the existing tail lineage echo readiness in the Genome Variation hidden QA surface.
- Extend the app-target text snapshot so baseline and child draft tail dot contracts remain active, ancestry-linked, tail-tip placed, asset-free, and non-mutating.
- Keep visible UI, SpriteKit drawing paths, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add hidden `spriteKitTailLineageEchoCueSummary` and `spriteKitTailLineageEchoCueReadinessSummary` probes for the baseline.
- Add a hidden child draft tail lineage echo summary probe.
- Assert and snapshot the three labels in `WiPetSnapshotTests`.

Future replacement point:

- If tail memory dots later gain animation, count variation, or inherited tail-style variants, keep this text contract as the gate before changing pixels or recording a new image reference.

Result:

- Added hidden Genome Variation QA probes for baseline `spriteKitTailLineageEchoCueSummary`, baseline readiness, and child draft tail lineage echo summary.
- Extended `WiPetSnapshotTests` assertions and the app-target `.lines` reference with the three tail lineage echo contract lines.
- Verified both baseline and child draft carry `softTailMemoryDots` on `floatingRibbon` at `tailTip` with `ancestryLinked:true`, `active:true`, and `assetOutputs:none`.
- Kept SpriteKit drawing paths, geometry, color, motion, visible UI, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.
- Simulator visual QA confirmed the Genome Variation host remains readable and layout-stable.

## Current Loop: SpriteKit Glow Mote Placement Variation

Handwritten complexity:

- The glow motes are a tiny handmade aura detail that should make two related pets feel subtly different without becoming random sparkle noise.
- The complexity is not rendering math; it is preserving a cute, quiet, creature-like placement language that can later become a bloodline cue.

Apple framework candidate:

- Keep SpriteKit as the renderer. Existing `SKShapeNode` motes already provide the right amount of direct art-direction control.
- CoreImage is not adopted here because the task is positional micro-variation, not procedural masks, glow textures, or CPPN precursor imagery.
- GameplayKit is not needed in this loop because no new inheritance or mutation planning is introduced; the variation comes from existing deterministic genome values.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` and image guardrails. No new package is adopted.
- A particle or animation library would reduce WiPet-specific placement control and would not improve affection, family resemblance, or testability at this scale.

Decision:

- Add a read-only glow mote placement value derived from `PatternGenes.glow`.
- Apply only a very small fixed offset to the existing mote positions so the aura feels more individual while the accepted Genome Variation composition remains stable.
- Extend hidden QA metadata with the placement label so the visual cue is named, testable, asset-free, and not player-facing.

Minimum scope:

- Add placement metadata to `CreatureRenderProfile.GlowAura`.
- Offset existing `PartAssembler` glow motes using the profile value.
- Extend Core metadata tests and the Genome Variation app-target text snapshot.
- Do not add dependencies, generated assets, project edits, Widget changes, persistence changes, normal UI copy, or new player controls.

Future replacement point:

- If glow motes later become procedural family-pattern fields, migrate this placement label into a CoreImage/CPPN mask recipe contract before changing the accepted image reference.

Result:

- Added `motePlacementLabel` and `moteOffset` to `CreatureRenderProfile.GlowAura`.
- Derived close/soft/wide mote placement from existing `PatternGenes.glow` without adding new randomness, dependencies, player-facing labels, Widget behavior, or persistence changes.
- Offset existing SpriteKit glow motes by a tiny fixed amount so the aura reads as slightly more individual while keeping the accepted Genome Variation image reference unchanged.
- Extended `RendererMetadataSummary.spriteKitGlowAuraCueSummary` with `motes:` and added readiness validation for the placement label.
- Exposed hidden Genome Variation QA metadata for `spriteKitGlowAuraCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- The app-target image snapshot passed without reference updates, preserving the accepted composition.
- Simulator visual QA confirmed Genome Variation remains readable, quiet, and family-like.

## Current Loop: Personality Eye Cue Text Contract

Handwritten complexity:

- The eye openness, softness, sparkle, and catchlight placement are tiny handmade "かわいい" signals that make a pet feel like a personality, not a stat sheet.
- The complexity is preserving emotional readability while avoiding player-facing technical labels.

Apple framework candidate:

- Keep SpriteKit as the renderer. The eyes and catchlights already render as simple `SKShapeNode` parts with personality-derived scale, alpha, size, and offset.
- No CoreImage, GameplayKit, SceneKit, RealityKit, or ModelIO change is needed because this loop does not generate textures, mutate lineage, or touch 3D assets.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` guardrail. No new package is adopted.
- A snapshot text contract is enough here because the visible drawing already exists and the first Genome Variation image reference is already protected.

Decision:

- Expose the existing personality eye cue and catchlight detail summaries in the Genome Variation hidden QA surface.
- Add readiness probes so the baseline eye expression remains named, asset-free, and not player-facing.
- Keep SpriteKit drawing, visible UI, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add hidden Genome Variation QA labels for `personalityEyeCueSummary`, readiness, `personalityEyeDetailSummary`, and readiness.
- Extend `WiPetSnapshotTests` assertions and the app-target `.lines` reference.
- Do not change eye geometry, colors, blink timing, normal Observation Home, Widget behavior, or Growth Ceremony preview.

Future replacement point:

- If eyes later gain multiple catchlight styles, animated highlights, or gaze-following variants, keep this text contract as the gate before updating the accepted image reference.

Result:

- Exposed hidden Genome Variation QA metadata for `personalityEyeCueSummary`, `personalityEyeCueReadinessSummary`, `personalityEyeDetailSummary`, and `personalityEyeDetailReadinessSummary`.
- Protected Luma's baseline eye contract as `openness:open`, `softness:steady`, `sparkle:warm`, and `catchlight:warmGlint` at `upperLeft`.
- Extended `WiPetSnapshotTests` assertions and the app-target `.lines` reference.
- Kept SpriteKit drawing, eye geometry, catchlight placement math, blink timing, visible UI, Widget handoff, persistence, generated assets, dependencies, project files, and image references unchanged.
- The app-target image snapshot passed without reference updates.
- Simulator visual QA confirmed Genome Variation remains readable, quiet, and family-like.

## Current Loop: SpriteKit Motion Gene Text Contract

Handwritten complexity:

- The float, blink, tail sway, and wing flutter labels describe how a pet feels alive; they must stay affectionate motion cues rather than raw animation parameters.
- The complexity is preserving "this child's rhythm" before adding richer gaze-following or blink personality variation.

Apple framework candidate:

- Keep SpriteKit and `SKAction` as the motion layer. The existing idle motion already uses deterministic genome-derived timing and amplitude values.
- GameplayKit is not needed because this loop does not add random motion variation or inheritance planning.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no generated texture, physics engine, or 3D asset pipeline changes are introduced.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` guardrail. No new animation or snapshot package is adopted.
- An external animation library would not improve the tiny existing idle cues and would reduce direct tuning control.

Decision:

- Expose the existing SpriteKit motion gene readiness in the Genome Variation hidden QA surface.
- Extend the app-target `.lines` snapshot with Luma's baseline float, blink, tail, wing, and wing-flutter cue.
- Keep SpriteKit drawing, SKAction timings, visible UI, Widget handoff, persistence, generated assets, package files, project files, and image references unchanged.

Minimum scope:

- Add hidden Genome Variation QA text for `spriteKitMotionGeneCueReadinessSummary`.
- Assert and snapshot the existing `spriteKitMotionGeneCueSummary` and readiness.
- Do not change blink duration, float amplitude, tail/wing motion, normal Observation Home, Widget behavior, or Growth Ceremony preview.

Future replacement point:

- If gaze-following, richer blink styles, or personality-timed idle loops are added later, keep this text contract as the gate before changing pixels or action timing.

Result:

- Added hidden Genome Variation QA metadata for `spriteKitMotionGeneCueReadinessSummary`.
- Protected Luma's baseline motion contract as `float:buoyant`, `blink:softBlink`, `tail:softSway`, `wing:softFlutter`, and `wingFlutter:2.5deg/2.05s`.
- Extended `WiPetSnapshotTests` assertions and the app-target `.lines` reference.
- Kept SpriteKit drawing, `SKAction` timing, blink duration, float amplitude, tail/wing motion, visible UI, Widget handoff, persistence, generated assets, dependencies, project files, and image references unchanged.
- The app-target image snapshot passed without reference updates.
- Simulator visual QA confirmed Genome Variation remains readable, quiet, and family-like.

## Current Loop: Personality Eye Gaze Micro-Cue

Handwritten complexity:

- The gaze cue is a tiny creature-art adjustment: it should make Luma feel attentive without making the portrait look cross-eyed, uncanny, or mechanically animated.
- The complexity is emotional tuning, not math; this is WiPet-specific cuteness and should remain hand-directed.

Apple framework candidate:

- Keep SpriteKit as the renderer. The existing eye nodes are already `SKShapeNode` parts with personality-derived scale and catchlight values.
- No GameplayKit is needed because the cue is deterministic from existing `PersonalityGenes`, not random inheritance or mutation planning.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no generated texture, image processing, or 3D asset pipeline is introduced.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` and image guardrails. No new package is adopted.
- An animation or eye-tracking package would overfit the task and reduce direct creature-art control.

Decision:

- Add a tiny read-only gaze offset and named gaze label derived from `PersonalityGenes.curiosity` and `PersonalityGenes.timidity`.
- Apply the offset directly to existing SpriteKit eye nodes, keeping the movement under one point so the accepted Genome Variation composition should remain stable.
- Expose a hidden QA summary so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add `gazeOffset` and `gazeLabel` to `CreatureRenderProfile.Expression`.
- Apply `gazeOffset` in `PartAssembler.eyeNode`.
- Add a Core metadata summary/readiness helper and extend the Genome Variation app-target `.lines` snapshot.
- Do not change blink timing, catchlight math, mouth, Widget handoff, persistence, generated assets, dependencies, project files, or Growth Ceremony preview.

Future replacement point:

- If true gaze-following is added later, keep this deterministic micro-cue as the baseline contract before introducing pointer/device tracking or richer eye animation.

Result:

- Added `gazeOffset` and `gazeLabel` to `CreatureRenderProfile.Expression`.
- Derived Luma's baseline gaze as `attentiveRightGaze` from existing `PersonalityGenes.curiosity` and `PersonalityGenes.timidity`.
- Applied a 0.55pt horizontal eye offset in `PartAssembler.eyeNode`, keeping the cue subtle enough to avoid uncanny or cross-eyed portraits.
- Added `RendererMetadataSummary.personalityEyeGazeCueSummary` and readiness helpers with Core tests.
- Exposed hidden Genome Variation QA metadata for `personalityEyeGazeCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept blink timing, catchlight math, mouth, Widget handoff, persistence, generated assets, dependencies, project files, and image references unchanged.
- The app-target image snapshot passed without reference updates.
- Simulator visual QA confirmed the gaze remains cute, quiet, and layout-stable.

## Current Loop: Personality Blink Micro-Cue

Handwritten complexity:

- Blink depth and hold time are tiny life signals; they should make Luma feel softly present without becoming twitchy or mechanical.
- The complexity is creature-art timing, not generic animation, so the cue should remain hand-tuned and deterministic.

Apple framework candidate:

- Keep SpriteKit `SKAction` as the animation layer. The existing blink sequence is simple, stable, and already tied to `MotionGenes.blink` for interval rhythm.
- No GameplayKit is needed because this cue is deterministic from existing `PersonalityGenes`, not random mutation or inheritance planning.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no texture, 3D asset, or generated output is introduced.

External library candidate:

- Keep using the existing SnapshotTesting app-target `.lines` and image guardrails. No new package is adopted.
- An animation package would add complexity without improving the small hand-tuned blink cue.

Decision:

- Add read-only blink style, closed-depth, and hold labels derived from `PersonalityGenes.sociality` and `PersonalityGenes.timidity`.
- Use those values in the existing SpriteKit blink `SKAction` sequence while leaving `MotionGenes.blink` responsible for blink interval.
- Expose hidden QA metadata so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add blink depth/hold values and labels to `CreatureRenderProfile.Motion`.
- Use the new values in `CreatureNode.startIdleMotion()`.
- Add a Core metadata summary/readiness helper and extend the Genome Variation app-target `.lines` snapshot.
- Do not change gaze, catchlight math, mouth, Widget handoff, persistence, generated assets, dependencies, project files, or Growth Ceremony preview.

Future replacement point:

- If richer blink styles or sleepiness-driven eyelids are added later, keep this deterministic micro-cue as the baseline contract before changing the accepted image reference.

Result:

- Added personality-derived blink closed scale, hold duration, and blink labels to `CreatureRenderProfile.Motion`.
- Kept `MotionGenes.blink` responsible for blink interval while `PersonalityGenes.sociality` and `PersonalityGenes.timidity` now tune the tiny blink style.
- Updated `CreatureNode.startIdleMotion()` to use the profile-derived closed scale and hold duration in the existing SpriteKit `SKAction` sequence.
- Protected Luma's baseline blink as `softQuickBlink`, `softClose`, and `shortHold`.
- Added `RendererMetadataSummary.personalityBlinkCueSummary` and readiness helpers with Core tests.
- Exposed hidden Genome Variation QA metadata for `personalityBlinkCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept gaze, catchlight math, mouth, Widget handoff, persistence, generated assets, dependencies, project files, and image references unchanged.
- The app-target image snapshot passed without reference updates.
- Simulator visual QA confirmed the blink cue remains quiet and does not disturb the Genome Variation layout.

## Current Loop: GameplayKit Adoption Gate Helper

Handwritten complexity:

- Every development loop now needs a quick way to confirm that GameplayKit is helping lineage feel inherited, not turning WiPet into raw random output.
- The value judgment remains handmade: resemblance must stay stronger than mutation, and seeds must stay out of player-facing experience.

Apple framework candidate:

- Keep GameplayKit as the deterministic lineage support rail through the existing `LineageMutationPlanner`.
- `GKLinearCongruentialRandomSource`, `GKRandomDistribution`, and `GKGaussianDistribution` already provide the reproducible random stream; this loop should not add another random engine.

External library candidate:

- None. A random package would add dependency risk without improving iOS integration, reproducibility, or attachment.

Decision:

- Add a tiny Core-only helper that builds `LineageRandomnessLibraryAdoptionGate` from parent IDs and generation.
- The helper must replay the same plan and reverse the parent order internally so tests and future QA code can audit determinism without duplicating setup.

Minimum scope:

- Add `LineageMutationPlanner.libraryAdoptionGate(parentIDs:generation:salt:)`.
- Add Core tests that the helper is ready for valid parents, rejects empty parents, and preserves the existing summary/readiness contract.
- Do not change `LineageMutationPlanner.plan`, `LineageGenomePreviewPlanner`, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, or `WiPet.xcodeproj`.

Future replacement point:

- If future inheritance needs more distributions or trait weighting, keep this helper as the first guardrail before any new randomness reaches preview, ceremony, or family-tree surfaces.

Result:

- Added `LineageMutationPlanner.libraryAdoptionGate(parentIDs:generation:salt:)`.
- The helper now constructs the plan, repeated plan, and reversed-parent plan internally, then returns the existing adoption gate.
- Added Core tests for a ready GameplayKit adoption gate helper and empty-parent rejection.
- Kept `LineageMutationPlanner.plan`, `LineageGenomePreviewPlanner`, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, and `WiPet.xcodeproj` unchanged.
- Visual QA confirmed normal Observation shows Luma without GameplayKit, seed, or random-roll technical text.

## Current Loop: Personality Sleepiness Idle Cue

Handwritten complexity:

- Sleepiness should read as a tiny living rhythm, not a tired status meter or noisy animation.
- The cuteness judgment is WiPet-specific: a sleepy pet should feel quietly present and touchable, while preserving the accepted calm portrait composition.

Apple framework candidate:

- Keep SpriteKit `SKAction` as the motion layer. The existing idle float, blink, tail sway, wing flutter, and glow pulse already use small deterministic actions.
- GameplayKit is not needed because this cue is deterministic from `PersonalityGenes.sleepiness`, not random inheritance or mutation planning.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no texture, 3D asset, or generated output is introduced.

External library candidate:

- Keep existing SnapshotTesting app-target `.lines` and image guardrails. No new package is adopted.
- An animation package would add dependency risk without improving this tiny hand-tuned breathing cue.

Decision:

- Add a small personality sleepiness idle cue derived from `PersonalityGenes.sleepiness`.
- Use a relative SpriteKit breathing action on the existing body node so the cue is visible but does not replace growth-stage scale.
- Expose hidden QA metadata so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add sleepiness breath scale/duration labels to `CreatureRenderProfile.Motion`.
- Use the values in `CreatureNode.startIdleMotion()` as a subtle relative `SKAction`.
- Add Core metadata summary/readiness helpers and extend the Genome Variation app-target `.lines` snapshot.
- Do not change Genome values, Creature mutation, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, or player-facing controls.

Future replacement point:

- If later motion blending becomes more complex, keep this deterministic sleepiness cue as the baseline before adopting a motion catalog or richer animation scheduler.

Result:

- Added `RendererMetadataSummary.personalitySleepinessIdleCueSummary` and readiness helpers with Core tests.
- Added sleepiness-derived breath scale, duration, style, breath, and pace labels to `CreatureRenderProfile.Motion`.
- Ran a subtle relative SpriteKit body-breath action keyed as `sleepinessBreath`, preserving existing growth-stage scale.
- Exposed hidden Genome Variation QA metadata for `personalitySleepinessIdleCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept Genome values, Creature mutation, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, and player-facing controls unchanged.
- Simulator visual QA confirmed normal Observation remains readable, calm, and free of debug text.

## Current Loop: Personality Mysticism Aura Cue

Handwritten complexity:

- Mysticism should deepen the feeling that Luma is a gentle fantasy creature, not add flashy VFX or a numeric magic stat.
- The cue must stay quiet enough that the pet remains cute and inspectable, with the accepted portrait composition intact.

Apple framework candidate:

- Keep SpriteKit as the renderer. The existing glow ring, outer aura, motes, and pulse already provide the right hand-tuned surface.
- CoreImage is deferred because no procedural texture, mask, or noise field is needed for this small aura cue.
- GameplayKit is not needed because this cue is deterministic from `PersonalityGenes.mysticism`, not inheritance or mutation planning.

External library candidate:

- None. A particle/VFX package would add dependency and timing risk while reducing direct creature-art control.
- Keep SnapshotTesting as the existing test-only guardrail.

Decision:

- Add a personality mysticism aura cue derived from `PersonalityGenes.mysticism`.
- Apply only a tiny outer aura alpha/scale nudge through the existing SpriteKit glow ring path.
- Expose hidden QA metadata so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add mysticism aura labels to `CreatureRenderProfile.GlowAura`.
- Add Core metadata summary/readiness helpers and app-target hidden QA probes.
- Do not change pattern glow genes, Creature mutation, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, or player-facing controls.

Future replacement point:

- If CPPN/CoreImage glow masks arrive later, keep this deterministic mysticism cue as the baseline emotional contract before introducing generated textures.

Result:

- Added `RendererMetadataSummary.personalityMysticismAuraCueSummary` and readiness helpers with Core tests.
- Added mysticism style/depth labels to `CreatureRenderProfile.GlowAura`.
- Passed `PersonalityGenes.mysticism` into the glow aura builder and applied only a tiny outer aura scale/alpha nudge through the existing SpriteKit glow ring.
- Exposed hidden Genome Variation QA metadata for `personalityMysticismAuraCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept pattern glow genes, Creature mutation, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, and player-facing controls unchanged.
- Simulator visual QA confirmed normal Observation remains readable, calm, and free of mysticism QA/debug text.

## Current Loop: Personality Energy Social Mouth Cue

Handwritten complexity:

- The mouth is part of the first attachment surface; a tiny change can make Luma feel more responsive, but too much becomes uncanny or cartoonishly expressive.
- Energy and sociality should read as a quiet willingness to respond, not a mood meter.

Apple framework candidate:

- Keep SpriteKit and the existing handmade mouth node. The current rounded mouth shape is simple, stable, and directly art-directable.
- GameplayKit is not needed because this cue is deterministic from `PersonalityGenes.energy` and `PersonalityGenes.sociality`, not inheritance or mutation planning.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no generated texture, 3D asset, or external render pipeline is introduced.

External library candidate:

- None. An expression/animation package would reduce direct creature-art control and add dependency risk.
- Keep SnapshotTesting as the existing test-only guardrail.

Decision:

- Add a tiny personality mouth cue derived from `PersonalityGenes.energy` and `PersonalityGenes.sociality`.
- Apply only a small mouth-width nudge through the existing `PartAssembler.mouthNode`.
- Expose hidden QA metadata so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add mouth labels and a tiny width adjustment to `CreatureRenderProfile.Expression`.
- Add Core metadata summary/readiness helpers and app-target hidden QA probes.
- Do not change mouth socket position, eye sockets, blink timing, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, or player-facing controls.

Future replacement point:

- If richer facial expressions arrive later, keep this deterministic mouth cue as the baseline before adding curved-mouth shapes or expression animation.

Result:

- Added `RendererMetadataSummary.personalityMouthCueSummary` and readiness helpers with Core tests.
- Added energy/sociality mouth labels to `CreatureRenderProfile.Expression`.
- Applied only a tiny mouth-width adjustment through the existing `PartAssembler.mouthNode` path.
- Exposed hidden Genome Variation QA metadata for `personalityMouthCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept mouth socket position, eye sockets, blink timing, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, and player-facing controls unchanged.
- Simulator visual QA confirmed normal Observation remains readable, calm, and free of mouth QA/debug text.

## Current Loop: Personality Curiosity Timidity Posture Cue

Handwritten complexity:

- Curiosity and timidity should feel like Luma is paying attention, not like a numeric stat or exaggerated pose.
- The visible change must stay small enough that the accepted body/head/eye composition still reads as the same pet.

Apple framework candidate:

- Keep SpriteKit as the motion/render layer. A tiny deterministic node rotation is enough for an attention posture cue.
- GameplayKit is not needed because no random inheritance or mutation planning is introduced.
- CoreImage, SceneKit, RealityKit, and ModelIO are not relevant because no texture, 3D asset, physics, or generated output is introduced.

External library candidate:

- None. A pose or animation package would add dependency risk and reduce direct creature-art control.
- Keep SnapshotTesting as the existing test-only semantic guardrail.

Decision:

- Add a small posture cue derived from `PersonalityGenes.curiosity` and `PersonalityGenes.timidity`.
- Apply only a sub-degree body-group tilt through the existing `CreatureNode` hierarchy.
- Expose hidden QA metadata so the cue is named, asset-free, and not player-facing.

Minimum scope:

- Add posture labels and a tiny rotation value to `CreatureRenderProfile`.
- Apply the rotation to the existing internal body group, preserving growth-stage scale and sleepiness breath.
- Add Core metadata summary/readiness helpers and app-target hidden QA probes.
- Do not change sockets, fixed part recipes, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, or player-facing controls.

Future replacement point:

- If richer pose blending arrives later, keep this deterministic attention posture as the baseline before adopting a fuller motion scheduler.

Result:

- Added `RendererMetadataSummary.personalityPostureCueSummary` and readiness helpers with Core tests.
- Added `CreatureRenderProfile.PersonalityPosture` labels and a tiny deterministic rotation derived from `PersonalityGenes.curiosity` and `PersonalityGenes.timidity`.
- Applied the rotation only to `CreatureNode`'s existing internal body group so fixed parts keep their sockets and relative alignment.
- Exposed hidden Genome Variation QA metadata for `personalityPostureCueSummary` and readiness, then protected it in the app-target `.lines` snapshot.
- Kept sockets, fixed part recipes, Widget handoff, persistence, generated assets, dependencies, project files, Growth Ceremony preview, and player-facing controls unchanged.
- Simulator visual QA confirmed normal Observation remains readable, calm, and free of posture QA/debug text.

## Current Loop: Observation Family Tree Teaser Line

Handwritten complexity:

- The Observation memory teaser should make the player feel "this belongs to our family line" before they open a sheet.
- The copy must stay warm and read-only, not become navigation-heavy genealogy management.

Apple framework candidate:

- SwiftUI remains sufficient for this small line of visible copy.
- No graph/tree layout framework is needed because this loop does not draw a family graph.
- GameplayKit is not needed because no inheritance or mutation planning changes are introduced.

External library candidate:

- None. A tree-layout or navigation package would add dependency risk without improving this one-line emotional cue.
- Keep existing SnapshotTesting `.lines` coverage for the semantic contract.

Decision:

- Add a family-tree entry line to `LineageObservationMemoryTeaserCopy`.
- Surface it in the existing Observation memory teaser, still inside the current read-only button/sheet flow.
- Keep persistence, breeding controls, graph navigation, Widget handoff, Growth Ceremony preview, generated assets, package files, and project files unchanged.

Minimum scope:

- Add `entryLine` to the teaser copy model, readiness, summary, Core tests, and Observation Home family echo `.lines` snapshot.
- Render the line under the teaser status line with small rounded text.
- Preserve existing sheet behavior and hidden QA probes.

Future replacement point:

- If a full family tree screen arrives later, this entry line becomes the copy contract for the first read-only family-tree entry point.

Result:

- Added `entryLine` to `LineageObservationMemoryTeaserCopy`.
- Updated readiness and summary coverage so the line is required while navigation, persistence, breeding, and optimization controls remain disabled.
- Rendered the line in the existing Observation memory teaser under the status line.
- Updated Core tests and the `observation-home-family-echo` `.lines` snapshot.
- Kept graph navigation, persistence, breeding controls, Widget handoff, Growth Ceremony preview, generated assets, dependencies, package files, and project files unchanged.
- Simulator visual QA confirmed normal Observation remains readable and the family-tree line fits without visible debug text.

## Current Loop: Observation Family Branch Preview Line

Handwritten complexity:

- The family-memory sheet should show a tiny branch preview so the player can feel a remembered line without entering a management screen.
- The copy must stay symbolic and read-only, not imply an editable genealogy graph.

Apple framework candidate:

- SwiftUI is sufficient for one small branch line inside the existing sheet.
- A graph/tree layout framework is still premature because no family graph is being drawn yet.
- GameplayKit is not needed because no inheritance, mutation, or random planning changes are introduced.

External library candidate:

- None. A graph layout package would add dependency and design weight before the emotional copy contract is stable.
- Keep SnapshotTesting `.lines` as the current semantic guardrail.

Decision:

- Add a read-only `branchLine` to `LineageObservationFamilyTreeEntryCopy`.
- Render the line inside the existing family-memory sheet section.
- Keep graph navigation, persistence, breeding controls, Widget handoff, Growth Ceremony preview, generated assets, package files, and project files unchanged.

Minimum scope:

- Add `branchLine` to the family-tree entry copy model, readiness, summary, Core tests, and Observation Home family echo `.lines` snapshot.
- Render the line as small rounded text in the existing `lineageObservationFamilyTreeEntry` section.
- Preserve existing sheet presentation, close behavior, hidden probes, and no-control guardrails.

Future replacement point:

- If a full read-only family tree screen arrives later, this branch line becomes the minimum copy contract for the first ancestor-to-memory edge.

Result:

- Added `branchLine` to `LineageObservationFamilyTreeEntryCopy`.
- Updated readiness and summary coverage so the branch preview is required while graph navigation, persistence, breeding, and optimization controls remain disabled.
- Rendered the line inside the existing Observation family-memory sheet without adding buttons, navigation, persistence writes, Widget handoff changes, or Growth Ceremony behavior.
- Updated Core tests and the `observation-home-family-echo` `.lines` snapshot.
- Kept external graph layout libraries, SnapshotTesting dependency changes, package files, and project files unchanged.
- Simulator visual QA confirmed the branch line reads as a small family-memory hint and does not turn the sheet into a management screen.

## Current Loop: SpriteKit Tail Lineage Dot Count Variation

Handwritten complexity:

- The tail lineage echo should feel like a tiny inherited family mark, not decorative sparkle.
- The dot count must stay gentle and deterministic so deeper generations feel remembered without exposing raw numbers to the player.

Apple framework candidate:

- SpriteKit remains the correct renderer because the existing cue is already handmade from small `SKShapeNode` dots and needs art-directed placement.
- CoreImage is deferred because no texture, mask, glow field, or CPPN precursor is needed for a two-to-four-dot tail mark.
- GameplayKit is not needed because no mutation planning or random inheritance changes are introduced; generation depth is already deterministic Core state.

External library candidate:

- None. SnapshotTesting stays as the existing semantic/image guardrail, but this loop should not add or change dependencies.

Decision:

- Add a deterministic `dotCount` to `CreatureRenderProfile.TailLineageEcho`.
- Derive the count from creature generation only when the ancestry-linked echo is active.
- Render that count in the existing SpriteKit tail echo node with handmade dot positions.
- Extend the existing Core/app-target summaries so tests can prove the cue remains ancestry-linked, asset-free, and non-mutating.

Minimum scope:

- Update `RendererMetadataSummary.spriteKitTailLineageEchoCueSummary` and readiness validation with `dotCount`.
- Update the SpriteKit tail echo drawing to render the profile's count while preserving the current soft placement.
- Update tests and the app-target `.lines` reference.

Future replacement point:

- If the tail echo later becomes animated or pattern-driven, this dot-count contract remains the gate before introducing CoreImage, particle systems, or new snapshot image references.

Result:

- Added `dotCount` to `CreatureRenderProfile.TailLineageEcho`.
- Derived active tail lineage dots from generation depth, capped to a gentle two-to-four-dot range.
- Updated `PartAssembler.tailLineageEchoNode(in:)` so baseline Luma renders three soft tail-memory dots and the child draft renders four.
- Extended `RendererMetadataSummary.spriteKitTailLineageEchoCueSummary`, readiness validation, Core tests, app-target assertions, and the Genome Variation `.lines` reference with `dots:3` and `dots:4`.
- Kept CoreImage, particle systems, GameplayKit changes, external packages, project files, generated assets, Widget handoff, persistence, and normal UI copy unchanged.
- Simulator visual QA confirmed the extra dot reads as a quiet family-memory mark rather than visual noise.

## Current Loop: Child Draft Inherited Winglet Cue Set

Handwritten complexity:

- The Genome Variation screen already tells the player that Mira keeps soft fairy winglets in the family.
- The renderer should preserve that wing inheritance as part of the child draft's family cue set without turning it into a stat or adding extra controls.

Apple framework candidate:

- SpriteKit remains the right renderer because the `softWingTipPearl` accessory already exists as handmade `SKShapeNode` art.
- GameplayKit is not needed because the existing `LineageGenomePreview` already chose the inherited wing; this loop does not change mutation planning.
- CoreImage, particle systems, SceneKit, RealityKit, and ModelIO are deferred because no generated texture, animation system, 3D asset, or socket preview is introduced.

External library candidate:

- None. This is a semantic contract and QA surface update over existing handmade wing art.

Decision:

- Extend the child draft lineage cue set with `wingCue` and `wingAccessory`.
- Use the existing child draft `CreatureRenderProfile` values so the cue remains tied to actual SpriteKit-rendered winglets.
- Keep visible UI copy, drawing paths, Widget handoff, persistence, Growth Ceremony behavior, packages, and project files unchanged.

Minimum scope:

- Update `RendererMetadataSummary.spriteKitChildDraftLineageCueSetSummary` and readiness validation.
- Pass `profile.silhouetteCue.wing` and `profile.wingSilhouetteAccessory.accessoryCue` from the Genome Variation QA host.
- Update Core tests, app-target assertions, and the `.lines` reference.

Future replacement point:

- If inherited winglets later gain their own animation or richer visual mark, this cue-set contract should remain the guardrail before changing pixels.

Result:

- Extended `RendererMetadataSummary.spriteKitChildDraftLineageCueSetSummary` with `wingCue` and `wingAccessory`.
- Populated those fields from Mira's inherited wing profile, so the cue set now records `wing:leafPair` and `wingAccessory:softWingTipPearl` without pretending the child draft body has grown wings.
- Updated readiness validation, Core tests, app-target assertions, and the Genome Variation `.lines` reference.
- Kept SpriteKit drawing paths, normal UI copy, Widget handoff, persistence, Growth Ceremony behavior, CoreImage, GameplayKit changes, external packages, project files, and generated assets unchanged.
- Simulator visual QA confirmed Mira's winglets remain subtle and the child draft/family echo copy stays readable.

## Current Loop: Growth Ceremony Noticed Memory Line

Handwritten complexity:

- After the player notices the previewed growth moment, the ceremony should feel like a remembered observation rather than a button press.
- The line must say "this will wait as memory" without implying growth has happened, a discovery was appended, or Widget handoff was published.

Apple framework candidate:

- SwiftUI remains sufficient because this is one preview-only text line controlled by local observation state.
- SpriteKit is already rendering the before/after portraits and does not need animation changes for this slice.
- GameplayKit is not needed because lineage randomness and mutation planning are unchanged.

External library candidate:

- None. The wording, pacing, and safety boundary are WiPet-specific ceremony design.
- Existing XCTest and SnapshotTesting references are the right guardrails; no dependency or project-file change is warranted.

Decision:

- Add a preview-only noticed memory line to the Growth Ceremony teaser after local acknowledgement.
- Reuse the existing discovery handoff preview as the source of memory wording, but keep `allowsWrite:false`.
- Keep normal Observation, `advanceGrowthStage()`, Creature mutation, persistence, discovery append, Widget handoff publish, SpriteKit drawing, packages, and project files unchanged.

Minimum scope:

- Add a small Core copy contract that requires an acknowledged local state, a safe discovery handoff, and no writes.
- Surface the line only when `ObservationHomeState.hasNotedGrowthCeremonyObservation` is true.
- Update Core tests, app-target `.lines` references, and visual QA.

Future replacement point:

- When a real commit-capable ceremony exists, this line should become the pre-write memory confirmation copy before SwiftData/App Group writes and Widget handoff are enabled.

Result:

- Added Core `GrowthCeremonyNoticedMemoryLineCopy` as a preview-only copy contract.
- The copy requires local acknowledgement, a safe discovery handoff, `allowsWrite:false`, no Creature mutation, no Widget handoff publish, and no discovery append.
- `ObservationHomeState` now exposes the noticed-memory summary and passes the copy into `GrowthCeremonyTeaserViewModel`.
- `ObservationHomeView` renders the line only after `hasNotedGrowthCeremonyObservation` is true.
- Updated Core tests, Growth Ceremony app-target assertions, and `.lines` references.
- Kept normal Observation, `advanceGrowthStage()`, Creature mutation, persistence, discovery append, Widget handoff publish, SpriteKit drawing, packages, project files, and generated assets unchanged.
- Simulator visual QA confirmed the pre-tap card remains readable; app-target snapshot test taps the acknowledgement and proves the post-tap line stays preview-only.

## Current Loop: SpriteKit Ancestral Glint Generation Echo

Handwritten complexity:

- The upper-chest ancestral glint should feel like a soft family-memory mark, not a collectible badge or stat.
- Generation depth can make the mark feel inherited, but it must remain tiny, warm, and visually quiet.

Apple framework candidate:

- SpriteKit remains the right renderer because the existing glint is handmade `SKShapeNode` art with precise placement.
- CoreImage and particle systems are deferred because no generated texture, mask, free-floating sparkle field, or CPPN precursor is needed.
- GameplayKit is not needed because this cue uses deterministic generation depth and an existing inherited resemblance discovery, not mutation planning.

External library candidate:

- None. SnapshotTesting continues as the existing semantic/app-target guardrail, but this loop should not add dependencies.

Decision:

- Add a deterministic `glintCount` to the existing `AncestralGlint` profile.
- Derive it from creature generation only when an inherited resemblance discovery is active.
- Render up to three tiny handmade glints inside the current upper-chest placement.
- Extend Core/app-target metadata so tests can prove the cue remains ancestry-linked, asset-free, and non-mutating.

Minimum scope:

- Update `RendererMetadataSummary.spriteKitAncestralGlintCueSummary` and readiness validation with `glints`.
- Update the SpriteKit ancestral glint drawing to use the profile count while preserving the current soft placement.
- Update tests and the app-target `.lines` reference.

Future replacement point:

- If ancestral glint later becomes animated or texture-driven, this count contract remains the gate before introducing CoreImage, particles, or new image references.

Result:

- Added `glintCount` to `CreatureRenderProfile.AncestralGlint`.
- Derived active ancestral glints from generation depth, capped to a gentle one-to-three-glint range.
- Updated `PartAssembler.ancestralGlintNode(in:)` so baseline Luma records/renders `glints:2` and the child draft records/renders `glints:3`.
- Extended `RendererMetadataSummary.spriteKitAncestralGlintCueSummary`, readiness validation, Core tests, app-target assertions, and the Genome Variation `.lines` reference.
- Kept CoreImage, particle systems, GameplayKit changes, external packages, project files, generated assets, Widget handoff, persistence, Growth Ceremony behavior, and normal UI copy unchanged.
- Simulator visual QA confirmed the extra glint reads as a quiet inherited family mark and does not destabilize the Genome Variation layout.

## Current Loop: Fixed Part Reference Sheet PNG Preflight QA Exposure

Handwritten complexity:

- The first lineage-cue reference sheet has a future PNG path, but accepting or generating that artifact too early would freeze creature art before the affection review is real.
- The QA surface must prove the candidate remains closed: no generated PNG, no runtime load, no snapshot acceptance, and no asset outputs.

Apple framework candidate:

- SwiftUI hidden QA probes and XCTest are enough to expose and verify the existing preflight metadata.
- ModelIO, SceneKit, and RealityKit remain future candidates after a real GLB/USD or fixed-part preview asset exists.
- CoreImage is unrelated because this slice does not generate textures, masks, patterns, or glow.

External library candidate:

- SnapshotTesting is already installed and useful as the text/image regression harness.
- No new dependency is adopted; the existing `.lines` snapshot is enough for this metadata-only gate.

Decision:

- Reuse the existing Core `fixedPartReferenceSheetPNGCandidatePreflight` contract and expose it through the Genome Variation app-target QA snapshot.
- Keep candidate generation disabled and keep the accepted Genome Variation image reference unchanged.

Minimum scope:

- Assert the hidden app QA labels for reference-sheet PNG preflight summary/readiness.
- Add the labels to the existing app-target `.lines` reference.
- Do not edit `Package.swift`, `WiPet.xcodeproj`, SpriteKit drawing, Widget handoff, persistence, GLB/USD/PNG assets, or runtime UI.

Future replacement point:

- When a Creature Art Director review produces a real reference sheet candidate, this preflight should become the gate before ModelIO/SceneKit/RealityKit validation or image snapshot acceptance is allowed.

Result:

- Reused the existing Core `fixedPartReferenceSheetPNGCandidatePreflight` metadata without adding a dependency.
- Added app-target assertions and `.lines` coverage for the closed PNG candidate preflight.
- Kept the accepted Genome Variation image reference, visible UI, SpriteKit drawing, project files, packages, generated assets, GLB/USD/PNG output, Widget handoff, and persistence unchanged.
- Simulator visual QA confirmed the QA surface remains readable and unchanged while the hidden metadata proves generation is still closed.

## Current Loop: Child Draft Forest Dot Echo

Handwritten complexity:

- Ori's soft deer-face echo should feel like a small inherited mark on the child draft, not a random pattern roll or collectible rarity.
- The forest dots need hand-tuned placement so the child remains cute and readable in the small draft portrait.

Apple framework candidate:

- SpriteKit remains the right renderer because `forestDots` are already handmade `SKShapeNode` marks on the deer face.
- GameplayKit is not needed because the lineage preview has already selected the inherited face; this loop only expresses that preview visually.
- CoreImage is deferred because this is not a procedural texture, mask, noise field, or CPPN precursor.

External library candidate:

- None. Existing SnapshotTesting `.lines` and image coverage are sufficient guardrails.

Decision:

- Add a deterministic forest-dot count to `CreatureRenderProfile.FaceAccent`.
- Derive the extra dot only for ancestry-linked deer-face echoes, using generation depth with a restrained cap.
- Render the dots through the existing handmade SpriteKit face-accent node.

Minimum scope:

- Update face-accent metadata with `dots`.
- Update the child draft inherited face echo metadata to record the dot count.
- Update Core tests and app-target snapshot coverage.
- Keep Widget handoff, persistence, Growth Ceremony behavior, GameplayKit planning, CoreImage, generated assets, packages, and project files unchanged.

Future replacement point:

- If deer-face markings later become CPPN/CoreImage-generated, this dot-count contract remains the art-direction gate for preserving the soft inherited face memory.

Result:

- Added `dotCount` to the SpriteKit face accent profile and kept it bounded to a soft 0...5 range.
- The child draft deer-face echo now carries `forestDots,dots:4` in Core/app metadata and renders through the existing handmade SpriteKit dot node.
- Existing SnapshotTesting `.lines` and image coverage remained sufficient; no new dependency, package edit, or project edit was needed.
- Kept GameplayKit mutation planning, CoreImage, generated assets, Widget handoff, persistence, and Growth Ceremony behavior unchanged.

## Current Loop: Growth Ceremony Before/After Comparison Line

Handwritten complexity:

- The ceremony should feel like observing a living change together, not pressing a growth button.
- The copy needs to guide the player to compare the current and next portrait without implying that growth has happened.

Apple framework candidate:

- SwiftUI is sufficient for one visible line in the existing teaser band.
- SpriteKit already renders the before/after portraits and does not need a rendering or animation change.
- GameplayKit is unrelated because no lineage planning, mutation, or inheritance randomness changes are introduced.

External library candidate:

- None. Existing SnapshotTesting `.lines` and image references are enough to guard the visible text surface.

Decision:

- Surface the existing `GrowthCeremonyBeforeAfterObservation.comparisonLine` as preview-only ceremony copy.
- Keep `advanceGrowthStage()`, Creature mutation, persistence, discovery append, Widget handoff, generated assets, packages, and project files unchanged.

Minimum scope:

- Pass the comparison line through `GrowthCeremonyTeaserViewModel`.
- Render it in the teaser with a stable accessibility identifier.
- Update app-target assertions and text references.

Future replacement point:

- When a real ceremony flow exists, this line can become the observation step before any commit-capable confirmation appears.

Result:

- Passed the existing before/after comparison line through the teaser view model and rendered it as preview-only ceremony copy.
- Kept the surface SwiftUI-only; no GameplayKit, CoreImage, new external dependency, package edit, or project edit was needed.
- App-target snapshot coverage now proves the line remains visible before and after acknowledgement while the ceremony still forbids mutation, persistence writes, discovery append, and Widget handoff.
- Simulator visual QA confirmed the line reads as quiet observation, not as a normal growth command.

## Current Loop: SpriteKit Sociality Cheek Warmth Cue

Handwritten complexity:

- Sociality should read as "this one feels friendly" through a tiny face warmth cue, not as a stat badge or random cosmetic.
- The cheek placement and opacity need hand tuning so the creature stays cute and calm in both normal observation and small QA portraits.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is two soft `SKShapeNode` ellipses placed inside the existing head node.
- SwiftUI only hosts the portrait and hidden QA metadata; no new UI framework is needed.
- GameplayKit is unrelated because no inheritance, mutation planning, or seeded random selection changes in this loop.
- CoreImage is deferred because this is not a generated mask, noise field, texture, or CPPN precursor.

External library candidate:

- None. Existing SnapshotTesting text/image coverage is enough to protect the small visible cue.

Decision:

- Add a deterministic sociality-derived cheek warmth cue to `CreatureRenderProfile.Expression`.
- Render it as a separate handmade SpriteKit face warmth layer, keeping fixed-part sockets, face accent recipes, and catalog IDs unchanged.
- Expose a Core/app metadata summary so the cue remains testable without adding player-facing copy.

Minimum scope:

- Add cheek warmth labels, alpha, and scale to the expression profile.
- Add `RendererMetadataSummary` helpers and tests for the new personality cue contract.
- Add hidden QA text and app-target assertions.
- Keep Widget handoff, persistence, Growth Ceremony behavior, GameplayKit planning, CoreImage, generated assets, packages, and project files unchanged.

Future replacement point:

- If cheek warmth later becomes a CoreImage/CPPN soft mask, this summary remains the art-direction contract for warmth, placement, and asset-output boundaries.

Result:

- Added a sociality-derived cheek warmth cue to the expression profile and rendered it through two handmade SpriteKit ellipses inside the head node.
- Added Core metadata helpers and tests for `personalityCheekWarmthCue`, keeping the cue deterministic and snapshot-testable.
- Kept the implementation SpriteKit-only; no GameplayKit, CoreImage, external dependency, package edit, project edit, generated asset, Widget handoff, persistence, or Growth Ceremony change was needed.
- Visual QA confirmed the normal Observation portrait now has a subtle friendly cheek warmth without overpowering the creature's calm face.

## Current Loop: Lineage Observation Ancestor Entry Line

Handwritten complexity:

- The Observation family teaser should feel like a remembered branch from an ancestor, not a generic navigation row.
- The copy needs to name the remembered ancestor softly while keeping the family tree read-only and non-command-like.

Apple framework candidate:

- Swift and SwiftUI are enough because this is copy/state metadata on an existing Observation teaser.
- GameplayKit is not relevant because no inheritance, mutation planning, seeded randomness, or child draft generation changes are introduced.
- SpriteKit stays unchanged because this loop changes family memory wording, not creature drawing.
- CoreImage, ModelIO, SceneKit, and RealityKit are not relevant.

External library candidate:

- None. Existing Core tests and `.lines` snapshots are sufficient.

Decision:

- Derive the default `LineageObservationMemoryTeaserCopy.entryLine` from the ancestor display label.
- Keep navigation, persistence, breeding controls, optimization controls, Widget handoff, SpriteKit drawing, generated assets, packages, and project files unchanged.

Minimum scope:

- Change only the default entry line copy.
- Update Core expectations and the Observation Home family echo text snapshot.
- Verify with normal Observation visual QA.

Future replacement point:

- When a real family tree surface exists, this line can become the ancestor branch preview before opening a richer read-only tree.

Result:

- `LineageObservationMemoryTeaserCopy.entryLine` now defaults to the ancestor display label, so the Observation teaser can say `First ancestor is remembered in this branch.` without adding a command-like family-tree control.
- Core expectations and the Observation Home family echo text snapshot protect the copy contract.
- No library, dependency, Widget handoff, persistence, SpriteKit renderer, generated asset, package, or project-file change was needed.
- Visual QA confirmed the normal Observation panel stays calm, readable, and read-only while naming the remembered branch.

## Current Loop: Lineage Observation Generation Memory Line

Handwritten complexity:

- The family-tree entry should quietly say that the memory belongs to a generation, not only to a trait label.
- The copy must deepen "うちの家系" without turning Observation into a navigable graph, breeding screen, or optimization surface.

Apple framework candidate:

- Swift value types and the existing `.lines` snapshot are enough for this read-only copy contract.
- GameplayKit is not needed because no seeded inheritance, mutation planning, or parent selection changes are introduced.
- SpriteKit is not touched because this is family memory wording, not creature rendering.
- CoreImage, ModelIO, SceneKit, and RealityKit are not relevant.

External library candidate:

- Graph/tree layout packages are deferred until there is an actual family-tree surface to lay out.
- SnapshotTesting already covers the text reference; no new dependency is needed.

Decision:

- Add a default `generationLine` to `LineageObservationFamilyTreeEntryCopy`.
- Derive it from the ancestor display label and keep it purely read-only.
- Keep navigation, persistence, breeding controls, optimization controls, Widget handoff, SpriteKit drawing, generated assets, packages, and project files unchanged.

Minimum scope:

- Add the line to Core copy, readiness, summary, tests, and the Observation Home family echo text snapshot.
- Verify that the extra line remains calm and non-command-like in normal Observation visual QA.

Future replacement point:

- When the real family-tree surface exists, `generationLine` can become the small caption beside an ancestor branch marker before any graph navigation is enabled.

Result:

- Added `generationLine` to `LineageObservationFamilyTreeEntryCopy`, with readiness and summary coverage.
- Rendered the line inside the existing read-only family memory sheet, not the normal Observation card, so the home view does not become denser.
- Added app-target coverage for `--wipet-lineage-memory-sheet-preview` to prove the line is visible and still read-only.
- Kept the implementation Swift/SwiftUI-only; no GameplayKit, graph layout package, Widget handoff, persistence, SpriteKit drawing, generated asset, package, or project-file change was needed.
- Visual QA confirmed the sheet shows `First ancestor is the first memory this line knows.` clearly enough while preserving the quiet family-memory tone.

## Current Loop: Lineage Observation Household Memory Line

Handwritten complexity:

- The family memory sheet should hint that a discovered echo is becoming part of "this household line", not just a detached trait note.
- The line must stay warm and quiet, avoiding a collection, pedigree-management, breeding, or optimization tone.

Apple framework candidate:

- Swift value types and SwiftUI text rendering are enough because this is a copy/state addition on the existing sheet.
- GameplayKit is not relevant because no deterministic inheritance, mutation, or child draft planning changes.
- Graph/tree layout is not needed because no family graph navigation is introduced.
- SpriteKit, CoreImage, ModelIO, SceneKit, and RealityKit are not relevant.

External library candidate:

- None. Existing Core tests, `.lines` snapshots, and app-target sheet coverage are sufficient.

Decision:

- Add a default `householdLine` to `LineageObservationMemorySheetCopy`.
- Render it in the read-only family memory sheet with a quiet household icon.
- Keep normal Observation density, Widget handoff, persistence, breeding controls, optimization controls, SpriteKit drawing, generated assets, packages, and project files unchanged.

Minimum scope:

- Add Core copy, readiness, summary, tests, text reference, and app-target assertion for the household line.
- Verify the sheet remains readable and non-command-like in visual QA.

Future replacement point:

- When a richer family tree exists, `householdLine` can become the emotional caption for the current lineage branch without changing storage or graph behavior.

Result:

- Added `householdLine` to `LineageObservationMemorySheetCopy`, defaulting to `This echo now belongs to this family's quiet line.`
- Rendered the line in the existing read-only family memory sheet and protected it with Core tests, text snapshot coverage, and app-target sheet assertions.
- Switched the lineage memory sheet to the large detent after visual QA showed the medium detent clipped the title once the household line was visible.
- Kept normal Observation density, Widget handoff, persistence, graph navigation, breeding controls, optimization controls, SpriteKit drawing, generated assets, packages, and project files unchanged.
- Visual QA confirmed the full sheet now presents the household line, family-tree entry, and read-only status without clipped text or command-like controls.

## Current Loop: Widget Family Line Compact Cue

Handwritten complexity:

- The Widget should hint at lineage without adding another row, long wording, or family-tree controls.
- The compact cue must feel like an observation-window whisper, not a management label.

Apple framework candidate:

- WidgetKit and Swift value types are already enough; this loop only changes the compact lineage cue copy.
- GameplayKit is not relevant because no mutation or inheritance planning changes.
- SwiftUI rendering stays unchanged except for existing text flowing through the Widget view.
- CoreImage, ModelIO, SceneKit, and RealityKit are not relevant.

External library candidate:

- None. Existing Core tests and Widget QA preview are enough.

Decision:

- Change the Widget compact lineage cue from `Family echo` to `Family line`.
- Keep full lineage cue, Widget layout, handoff schema, persistence, App Groups, packages, project files, and renderer unchanged.
- Preserve the selective compact display rule so the cue only appears when the discovery text fits.

Minimum scope:

- Update `WidgetPetSnapshotText`, Core tests, payload expectations, and Widget QA visual confirmation.
- Verify the Widget still feels like an observation window with no extra density.

Future replacement point:

- If the Widget later gets a dedicated family-memory variant, `Family line` can become the compact caption while full details remain in-app.

Result:

- Changed `WidgetPetSnapshotText.lineageCueCompactLine` from `Family echo` to `Family line` when a lineage cue exists.
- Kept the full lineage cue, selective compact display rule, Widget layout, handoff payload schema, App Group behavior, packages, project files, and renderer unchanged.
- Updated Core and Widget QA readiness expectations so the compact cue remains testable.
- Visual QA confirmed the small and medium Widget QA previews show `Family line` without adding a row or crowding the observation-window layout.

## Current Loop: Family Tree Graph Layout Adoption Gate

Handwritten complexity:

- Deciding when a future family tree stops being a quiet, hand-authored memory surface and starts needing a graph/tree layout helper.
- The risk is not layout math alone; it is making lineage feel like a management screen before the player has enough family memory to care.

Apple framework candidate:

- SwiftUI remains enough for the current Lineage Family QA state because the surface is static, read-only, and below true tree complexity.
- A custom SwiftUI `Layout` can be reconsidered before any external graph package if the tree grows but still needs WiPet-specific restraint.

External library candidate:

- A graph/tree layout package is deferred until the visible tree has at least three generations, five visible nodes, four edges, deterministic placement needs, and proven manual-layout insufficiency.
- Swift Algorithms or Swift Collections may help future data traversal, but they are not needed for this visual adoption gate.

Decision:

- Do not add a graph/tree dependency, package edit, project-file edit, or visible family-tree navigation in this loop.
- Keep the existing `LineageFamilyGraphLayoutAdoptionGate` as the Core contract that makes the "not yet" decision testable.
- Keep normal Observation, Widget handoff, persistence, discovery writes, breeding controls, optimization controls, and visible Lineage Family QA layout unchanged.

Minimum scope:

- Document the adoption threshold in the library strategy.
- Rely on the existing Core tests and hidden Lineage Family QA metadata to prove the current QA state is below the dependency threshold.

Future replacement point:

- When acknowledged/persisted family memories create a real multi-generation tree, use this gate to choose between handmade SwiftUI layout, a custom SwiftUI `Layout`, or a dedicated graph/tree helper in a separate dependency-only commit.

Result:

- Library strategy now records why graph/tree layout remains deferred even though the Core adoption gate exists.
- The current implementation preserves affection-first lineage: family memory can grow toward "うちの家系" without prematurely becoming a graph-control surface.

Verification:

- `swift test --quiet` passed with 359 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- App and Widget simulator builds passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- Visual QA confirmed the normal Observation screen does not expose graph layout metadata, and Lineage Family QA remains a quiet read-only family memory surface with no visible graph controls.
- XcodeBuildMCP runtime text lookup did not expose the hidden 1px QA metadata in this pass; Core tests remain the source of truth for the hidden `lineageFamilyGraphLayoutAdoption` summary/readiness contract.

## Current Loop: Lineage Family QA App Text Snapshot

Handwritten complexity:

- The Lineage Family QA surface now carries several hidden contracts around family-tree teaser, draft-memory evidence, persistence boundaries, graph layout deferral, and SnapshotTesting readiness.
- Checking those contracts only by scattered XCTest assertions makes it easy to miss whether the whole QA stack still says "read-only family memory" instead of "management graph" or "breeding flow".

Apple framework candidate:

- XCTest remains the app launcher and UI metadata reader.
- SwiftUI remains the visible surface; no new Apple framework is needed because the task records semantic text rather than changing layout or rendering.

External library candidate:

- SnapshotTesting is already adopted as a test-only dependency and is the right support rail for a `.lines` semantic reference.
- A new image reference is intentionally deferred because the visible Lineage Family QA layout did not change in this loop.

Decision:

- Add one app-target SnapshotTesting `.lines` reference for `LineageFamilyQAView`.
- Include only stable, affection-preserving contracts: tree teaser readiness, evidence review, acknowledgement review, intent gate, persistence boundary, dry-run adapter, confirmation ceremony, graph layout deferral, and SnapshotTesting proposal readiness.
- Do not add or update image references, package dependencies, project files, renderer drawing, Widget handoff, persistence writes, discovery writes, breeding controls, optimization controls, or visible UI.

Minimum scope:

- Extend the existing `WiPetSnapshotTests` app-target test file with one `--wipet-snapshot-host-lineage-family` semantic snapshot.
- Store one `.txt` reference under the existing SnapshotTesting reference directory.

Future replacement point:

- If Lineage Family QA later gets a manually accepted image state, add that image reference in a separate visual QA loop after confirming it increases family resemblance and affection rather than freezing incidental spacing.

Result:

- Added one app-target SnapshotTesting `.lines` reference named `lineage-family-qa-app-surface`.
- The reference records the host entry, family tree teaser, draft-memory evidence review, acknowledgement review, explicit intent gate, persistence boundary, dry-run adapter, confirmation ceremony, graph layout adoption gate, and SnapshotTesting proposal as a single read-only lineage QA contract.
- Kept the loop text-only: no image reference, package edit, project edit, renderer change, Widget handoff, persistence write, discovery write, child creation, breeding control, optimization control, or visible UI change was introduced.

Verification:

- `swift test --quiet` passed with 359 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- App and Widget simulator builds passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_651cf3d3-c71d-4367-800e-a9258f01ccb3.jpg` confirmed the visible Lineage Family QA surface remains calm, readable, and free of graph controls or management-screen density.
- XcodeBuildMCP runtime text lookup again did not expose text elements for this host; the new app-target XCTest/SnapshotTesting reference is the stronger metadata proof for the hidden read-only contract.

## Current Loop: Widget QA Compact Lineage Text Snapshot

Handwritten complexity:

- The Widget should whisper lineage only when the discovery line is short enough; otherwise the observation window becomes crowded and stops feeling quiet.
- The important contract is selective restraint: long ancestor text hides the lineage row, short ancestor text shows `Family line`, and ordinary/growth fixtures stay hidden.

Apple framework candidate:

- WidgetKit and SwiftUI remain the rendering surfaces.
- XCTest can launch the app-hosted Widget QA route, but a raw assertion alone does not preserve the whole compact-lineage readiness string as a reviewable artifact.

External library candidate:

- SnapshotTesting is already adopted test-only and fits a `.lines` semantic reference for the Widget QA readiness summary.
- A Widget image snapshot is deferred because the visible Widget QA surface is tall, scrollable, and already covered by manual Simulator review; freezing all pixels would be too brittle for this small restraint contract.

Decision:

- Add one app-target SnapshotTesting `.lines` reference for `--wipet-widget-qa-preview`.
- Record the existing `WidgetPreviewQAReadiness.readinessSummary`, especially `longSelectiveCue:hidden`, `shortSelectiveCue:Family line`, `ordinarySelectiveCue:hidden`, and `growthAdvancementSelectiveCue:hidden`.
- Do not add image references, WidgetKit extension changes, renderer changes, App Group handoff changes, persistence writes, package edits, project edits, or visible UI changes.

Minimum scope:

- Add one `WiPetSnapshotTests` method that reads the Widget QA root readiness identifier and snapshots it as text.
- Keep production Widget behavior unchanged: compact lineage still appears only through the existing selective display mode.

Future replacement point:

- If Widget QA gets a manually accepted compact visual baseline, add a separate image reference focused on one small/medium frame instead of the entire scrollable QA page.

Result:

- Added one app-target SnapshotTesting `.lines` reference named `widget-qa-selective-compact-lineage`.
- The reference records `WidgetPreviewQAReadiness.readinessSummary`, including `longSelectiveCue:hidden`, `shortSelectiveCue:Family line`, `ordinarySelectiveCue:hidden`, and `growthAdvancementSelectiveCue:hidden`.
- Kept production Widget behavior unchanged and avoided image references, WidgetKit extension changes, renderer changes, App Group handoff changes, persistence writes, package edits, project edits, and visible UI changes.

Verification:

- `swift test --quiet` passed with 359 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- App and Widget simulator builds passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_b55e3ebe-cc88-4e48-8b97-08f114d6a573.jpg` confirmed the Widget QA route renders normally and the long ancestor preview remains readable without overlap.

## Current Loop: GameplayKit Preview Adoption Gate Helper

Handwritten complexity:

- `LineageGenomePreviewLibraryAdoptionGate` already captures the affection-first rules for child draft previews, but callers still have to manually assemble the preview and parent ID context.
- The risky part is not randomness math; it is letting a child draft feel like a roll result instead of "祖先に似ているが少し違う".

Apple framework candidate:

- Keep GameplayKit as the deterministic lineage support rail through the existing `LineageGenomePreviewPlanner`.
- `GKLinearCongruentialRandomSource`, `GKRandomDistribution`, and `GKGaussianDistribution` remain appropriate because they are Apple-standard, deterministic, testable, and require no package/project edits.

External library candidate:

- None. A random or inheritance package would add dependency and maintenance risk without improving affection, iOS integration, or reversibility.
- SnapshotTesting is not needed in this loop because no UI or rendered reference changes.

Decision:

- Add a tiny Core-only helper that builds `LineageGenomePreviewLibraryAdoptionGate` from parent genomes and generation.
- The helper must keep the existing preview planner untouched, reject empty parent lists through the existing preview path, and stay non-mutating, non-player-facing, non-persistent, and free of breeding controls.

Minimum scope:

- Add `LineageGenomePreviewPlanner.libraryAdoptionGate(parents:generation:salt:)`.
- Add Core tests that the helper is ready for valid parents, deterministic under parent order changes, and nil without parents.
- Do not change `LineageMutationPlanner.plan`, preview output, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, or `WiPet.xcodeproj`.

Future replacement point:

- Before any child draft becomes a player-facing ceremony, persisted lineage write, or family-tree entry, route it through this helper plus ceremony acknowledgement and persistence-boundary gates.

Result:

- Added `LineageGenomePreviewPlanner.libraryAdoptionGate(parents:generation:salt:)`.
- The helper wraps the existing GameplayKit-backed preview planner and returns `LineageGenomePreviewLibraryAdoptionGate` with sorted parent IDs.
- Added Core tests for ready helper output, deterministic replay, parent-order stability, and empty-parent nil.
- Kept planner distributions, preview output, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Verification:

- `swift test --quiet` passed with 361 tests.
- `WiPetSnapshotTests` initially had a simulator timing failure in `testGenomeVariationSnapshotHostExposesTargetEntryReadiness`; the targeted rerun passed, then the full suite rerun passed.
- Widget simulator build, `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP `build_run_sim` passed for normal WiPet.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_219c6b22-bbf9-4549-9efb-db2710d54d2a.jpg` confirmed normal Observation remains calm and does not expose GameplayKit, seed, or random-roll technical text.

## Current Loop: SpriteKit Growth Horn Bud Text Contract

Handwritten complexity:

- `GrowthGenes.hornGrowth` needs a cute growth-language boundary before it becomes visible geometry.
- The risky part is making horns feel sharp, aggressive, or optimization-like. For WiPet, the first contract should read as a soft bud of growth, not a combat stat.

Apple framework candidate:

- Keep SpriteKit as the renderer because the current creature portrait is assembled from handmade, tweakable `SKShapeNode` parts.
- XCTest and the existing app-target SnapshotTesting `.lines` reference are enough to protect the hidden semantic contract.

External library candidate:

- None. CoreImage, ModelIO, SceneKit, RealityKit, and external drawing libraries are not needed because this loop does not generate textures, meshes, particles, GLB/USD, or visible horn art.
- GameplayKit is not needed because the cue is deterministic from an existing growth gene, not inheritance or mutation planning.

Decision:

- Add a metadata-only `softHornBud` cue derived from `GrowthGenes.hornGrowth`.
- Keep the cue hidden from normal UI and avoid visible drawing until Creature Art Direction accepts a rounded, non-sharp bud silhouette.
- Do not change SpriteKit pixels, sockets, generated assets, Widget handoff, persistence, growth advancement, `Package.swift`, or `WiPet.xcodeproj`.

Minimum scope:

- Add `RendererMetadataSummary.spriteKitGrowthHornBudCueSummary` and readiness validation.
- Add `CreatureRenderProfile.GrowthHornBudCue` and hidden Genome Variation QA text probes.
- Extend Core tests and the existing Genome Variation `.lines` snapshot with the cue.

Future replacement point:

- After this text contract is stable, a separate visual loop may draw a tiny rounded bud in SpriteKit for high `hornGrowth`, then manually review whether it increases "この子成長したな" without making the creature look sharp.

Result:

- Added `RendererMetadataSummary.spriteKitGrowthHornBudCueSummary` and readiness validation.
- Added `CreatureRenderProfile.GrowthHornBudCue`, deriving `dormantBud`, `tinyRoundedBud`, or `softCrescentBud` from `GrowthGenes.hornGrowth`.
- Exposed hidden Genome Variation QA labels for `spriteKitGrowthHornBudCueSummary` and readiness, then protected them in the existing app-target `.lines` snapshot.
- Kept the cue metadata-only: no SpriteKit horn drawing, sockets, generated assets, Widget handoff, persistence, growth advancement, `Package.swift`, or `WiPet.xcodeproj` changes.

Verification:

- `swift test --quiet` passed with 363 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP `build_run_sim` passed for normal WiPet.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_aa36aa2c-92f2-44d7-a8c1-35bfaef8b91a.jpg` confirmed normal Observation remains visually unchanged and does not show horn geometry or technical metadata.

## Current Loop: Growth Ceremony Horn Bud Preview Contract

Handwritten complexity:

- The Growth Ceremony can now see a `hornGrowth` bud cue, but it must not turn that cue into a visible horn, a growth button, or a premature discovery.
- The affection judgment remains handmade: a dormant or tiny bud should feel like a quiet growth possibility, not a combat/stat reveal.

Apple framework candidate:

- SwiftUI remains enough for the preview surface and hidden QA probes.
- SpriteKit remains the renderer, but this loop only reads existing metadata and does not draw new geometry.

External library candidate:

- SnapshotTesting is already adopted and can protect the semantic `.lines` contract.
- No new library is needed; CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, and external animation packages do not help a hidden ceremony safety boundary.

Decision:

- Add a hidden Growth Ceremony contract that bridges current and next `spriteKitGrowthHornBudCue` summaries.
- The contract must require `visible:false`, `allowsMutation:false`, `widgetHandoffAllowed:false`, `assetOutputs:none`, and no discovery append.
- Do not render a new visible line yet because Luma's current cue is `dormantBud` and the art-direction pass has not accepted visible horn buds.

Minimum scope:

- Add Core summary/readiness helpers for `growthHornBudCeremonyPreview`.
- Add an `ObservationHomeState` hidden probe and app-target `.lines` snapshot coverage.
- Keep normal Observation UI, Growth Ceremony visible copy, Widget handoff, persistence, SpriteKit drawing, generated assets, package files, and project files unchanged.

Future replacement point:

- If a later creature has `tinyRoundedBud` or `softCrescentBud`, a separate Growth Ceremony UI pass can choose a visible copy line after manual visual QA confirms it increases "この子成長したな".

Result:

- Added `RendererMetadataSummary.growthHornBudCeremonyPreviewSummary` and readiness validation.
- Added hidden `ObservationHomeView` probes for `growthHornBudCeremonyPreviewSummary` and readiness during Growth Ceremony preview.
- The contract bridges current and next `GrowthHornBudCue` labels while requiring hidden display, no mutation, no Widget handoff, no discovery append, and `assetOutputs:none`.
- Extended Growth Ceremony app-target assertions and both pre-acknowledgement and acknowledged `.lines` references.
- Kept visible Growth Ceremony copy, normal Observation UI, SpriteKit drawing, Widget handoff, persistence, generated assets, packages, and project files unchanged.

Verification:

- `swift test --quiet` passed with 365 tests.
- Targeted Growth Ceremony app-target snapshot test passed.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP `build_run_sim` passed for normal WiPet.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_ce6d20f4-6ef3-4b60-9ad8-7389dcc99b9d.jpg` confirmed normal Observation remains unchanged and does not show horn geometry or technical metadata.

## Current Loop: Horn Base Socket Art Direction Gate

Handwritten complexity:

- Horn Base needs a socket and rig contract before any visible bud or 3D asset exists.
- The affection risk is high: a horn can quickly read as sharp, aggressive, or collectible. WiPet needs a rounded growth bud that preserves the face-first cuteness of the pet.

Apple framework candidate:

- SpriteKit remains the eventual handmade 2D renderer for a tiny bud, but this loop does not draw pixels.
- ModelIO, SceneKit, and RealityKit remain future candidates for GLB/USD import, socket preview, and fixed-part validation after an accepted reference sheet or asset exists.

External library candidate:

- None. SnapshotTesting image references, CoreImage, 3D frameworks, and external drawing libraries are premature because there is no visible horn artwork, generated texture, PNG, GLB, or USD asset to validate.

Decision:

- Add a Core metadata gate for Horn Base socket art direction.
- Require `dormantBud`, `tinyRoundedBud`, and `softCrescentBud`, sockets `headTopCenter` and `headTopPair`, rig targets `horn_L` and `horn_R`, silhouette `roundedNonSharp`, hidden portrait visibility, no generated geometry, and `assetOutputs:none`.
- Keep SpriteKit drawing, Widget handoff, persistence, SnapshotTesting references, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Minimum scope:

- Add value-level summary/readiness helpers to `RendererMetadataSummary`.
- Add Core tests that reject missing variants, missing sockets, missing rig targets, sharp silhouette language, visible portrait output, generated geometry, and asset outputs.
- Update docs to record the art-direction gate before implementation.

Future replacement point:

- When a tiny rounded SpriteKit bud is manually accepted, this gate becomes the prerequisite for the visible drawing loop.
- When PNG/GLB/USD assets exist, ModelIO plus SceneKit or RealityKit can validate actual socket placement in a dedicated asset-pipeline commit.

Result:

- Added `RendererMetadataSummary.fixedPartHornBaseSocketSpecSummary`, readiness validation, and readiness summary.
- Added Core tests for rounded Horn Base variants, head-top sockets, `CommonPetRig` horn targets, non-sharp silhouette, hidden portrait state, disabled generated geometry, and `assetOutputs:none`.
- Updated the fixed-part manifest with Horn Base socket and reference-sheet requirements.
- Kept SpriteKit drawing, normal Observation UI, Widget handoff, persistence, SnapshotTesting references, generated assets, packages, and project files unchanged.

Verification:

- `swift test --quiet` passed with 367 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP `build_run_sim` passed for normal WiPet.
- Visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_538ebad4-315d-4ba9-9b2c-52eca124ef6a.jpg` confirmed normal Observation remains unchanged and does not show horn geometry, socket labels, rig labels, or technical metadata.

## Current Loop: SpriteKit Tiny Rounded Horn Bud

Handwritten complexity:

- The first visible Horn Base cue must preserve the pet's face-first cuteness and read as a small sign of growth, not a weapon, stat, rarity, or collectible upgrade.
- The shape should remain easy to tune by hand because the emotional threshold is visual and creature-specific.

Apple framework candidate:

- SpriteKit remains the right tool because the current portrait is handmade from `SKShapeNode` layers and this loop only needs tiny rounded geometry.
- ModelIO, SceneKit, RealityKit, and CoreImage remain deferred; there is no GLB/USD, reference sheet, texture, mask, or generated asset in this loop.

External library candidate:

- None. A drawing or procedural-geometry package would black-box the cute silhouette judgment and add dependency risk without improving the current tiny bud.

Decision:

- Draw only non-dormant horn buds in SpriteKit as small rounded shapes attached to the existing head layer.
- Keep baseline Luma dormant and visually unchanged.
- Add a horn-bud QA launch surface for manual visual review without exposing controls or technical text in normal Observation.
- Keep Widget handoff, persistence, growth advancement, generated assets, packages, and project files unchanged.

Minimum scope:

- Let `GrowthHornBudCue.visibleInPortrait` become true only for `tinyRoundedBud` and `softCrescentBud`.
- Add a small `PartAssembler` head child for the visible bud.
- Add `PreviewFixtures.hornBudLuma` plus a snapshot-host launch argument for QA.
- Add Core/app-target coverage for dormant-hidden and non-dormant-visible metadata.

Future replacement point:

- If manual visual QA accepts the tiny bud, Growth Ceremony copy may mention it in a later loop.
- If reference sheets or 3D assets become real, the previous Horn Base socket art gate remains the bridge to ModelIO/SceneKit/RealityKit validation.

Result:

- Updated `spriteKitGrowthHornBudCue` readiness so `dormantBud` must stay hidden while `tinyRoundedBud` and `softCrescentBud` must be visible in portrait.
- Added handmade SpriteKit head-top bud rendering in `PartAssembler`.
- Added `PreviewFixtures.hornBudLuma` and the `--wipet-snapshot-host-horn-bud` QA launch surface.
- Added hidden ObservationHome horn-bud probes and app-target coverage for `tinyRoundedBud`, `visible:true`, and `assetOutputs:none`.
- Kept baseline Luma dormant and visually unchanged.
- Kept Widget handoff, persistence, growth advancement, generated assets, packages, and project files unchanged.

Verification:

- `swift test --quiet` passed with 367 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP normal Observation build/run passed; screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_0dad7d5f-cadd-45fd-8ea8-d94a129fc0c7.jpg` confirmed baseline Luma remains unchanged and hornless.
- XcodeBuildMCP horn-bud QA build/run passed; first screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_1cff6e8a-60af-4b4c-9e33-a3edc4f39cbf.jpg` showed the bud was too faint, so it was adjusted.
- Final horn-bud QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_1ee8cd1d-16b7-43cc-aa91-d89ccb0928ca.jpg` accepted the rounded tiny bud as visible but still secondary to the face.

## Current Loop: Growth Ceremony Horn Bud Noticed Line

Handwritten complexity:

- Once a rounded horn bud is visible, the Growth Ceremony acknowledgement copy should help the player feel "this child has grown a little" without implying the growth was committed.
- The words must stay gentle and observation-led; they must not turn the bud into a reward, stat, rarity, or command.

Apple framework candidate:

- SwiftUI local state and the existing Core `GrowthCeremonyNoticedMemoryLineCopy` are enough.
- SpriteKit already renders the bud; no animation, CoreImage, ModelIO, SceneKit, RealityKit, GameplayKit, or new package is needed.

External library candidate:

- None. The copy is WiPet-specific ceremony language and should stay handmade.

Decision:

- Reuse `GrowthCeremonyNoticedMemoryLineCopy` but pass a horn-bud-specific memory line when the preview portrait has a visible non-dormant horn bud.
- Add a horn-bud Growth Ceremony QA launch surface so the normal Luma ceremony remains unchanged.
- Keep mutation, persistence, discovery append, Widget handoff, growth advancement, generated assets, packages, and project files unchanged.

Minimum scope:

- Add an app-side helper that derives the noticed memory line from `CreatureRenderProfile.growthHornBudCue`.
- Add `--wipet-growth-ceremony-horn-bud-preview`.
- Extend app-target coverage to tap the acknowledgement and verify the horn-bud line stays preview-only.

Future replacement point:

- If a future ceremony commits growth, this copy can become pre-write confirmation text only after discovery, persistence, Widget handoff, and mutation proofs are explicitly opened.

Result:

- Added `--wipet-growth-ceremony-horn-bud-preview` using `PreviewFixtures.hornBudLuma`.
- Added an ObservationHomeState helper that supplies a horn-bud-specific noticed memory line only when the portrait has a visible non-dormant horn bud.
- Reused `GrowthCeremonyNoticedMemoryLineCopy`, so the line remains preview-only and continues to reject mutation, persistence, Widget handoff, and discovery append.
- Added app-target coverage that taps the horn-bud ceremony acknowledgement and verifies the specific line plus safety metadata.
- Kept the generic Luma Growth Ceremony noticed line unchanged.

Verification:

- `swift test --quiet` passed with 367 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP horn-bud ceremony pre-tap screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_014906f4-664d-40ad-b6c1-dedf82c752e7.jpg` confirmed the ceremony card remains readable with the visible rounded bud.
- XcodeBuildMCP normal Observation screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_629dc62d-68f6-40ca-a36f-10fdfbb259df.jpg` confirmed baseline Luma remains unchanged and hornless.
- Post-tap behavior is covered by the app-target test because the currently exposed XcodeBuildMCP simulator tools in this session do not include UI tap; the test performs the real tap and verifies the horn-bud line plus `write:false`, `mutation:false`, `widget:false`, and `discovery:false`.

## Current Loop: SnapshotTesting Horn Bud Image Reference

Handwritten complexity:

- The tiny rounded horn bud has passed manual visual QA, so the remaining risk is accidental pixel drift: too faint, too sharp, too large, or no longer secondary to the face.
- The visual judgment stays handmade; the snapshot only protects the accepted state.

Apple framework candidate:

- SpriteKit remains the renderer. No new Apple framework is needed because the surface already renders.

External library candidate:

- SnapshotTesting is already adopted test-only and is appropriate for one focused image reference.
- No new package, project file, renderer, Widget, persistence, or generated asset change is needed.

Decision:

- Add one app-target SnapshotTesting image reference for `--wipet-snapshot-host-horn-bud`.
- Keep the existing hidden metadata assertions and add pixel regression only after the manual QA acceptance from the previous loop.

Minimum scope:

- Extend `testHornBudPreviewHostExposesVisibleRoundedBudCue()` with one `.image` assertion named `horn-bud-preview-reference`.
- Record the reference image in the existing snapshot directory.
- Keep normal Observation, Growth Ceremony, Widget handoff, persistence, packages, project files, and SpriteKit pixels unchanged.

Future replacement point:

- If the horn bud art changes, update this reference only after docs record the creature-art reason and visual QA confirms the new pixels still feel like a soft growth bud.

Result:

- Added one app-target SnapshotTesting image assertion named `horn-bud-preview-reference`.
- Recorded `WiPetSnapshotTests/__Snapshots__/SnapshotHostGenomeVariationTests/testHornBudPreviewHostExposesVisibleRoundedBudCue.horn-bud-preview-reference.png`.
- Kept SpriteKit pixels, normal Observation, Growth Ceremony, Widget handoff, persistence, packages, and project files unchanged.

Verification:

- Targeted horn-bud snapshot test passed after reference recording.
- `swift test --quiet` passed with 367 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP horn-bud QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_7be80b7e-64d0-4807-9d5c-26a9b8ad2651.jpg` confirmed the reference still protects a tiny rounded bud that stays secondary to Luma's face.

## Current Loop: Horn Bud Detail Recipe Catalog Bridge

Handwritten complexity:

- The tiny rounded horn bud is an accepted handmade SpriteKit shape. The risk is that it stays visually present but remains outside the fixed-part recipe catalog, making later PNG/3D reference-sheet work less traceable.
- The art judgment remains handmade; this loop only names the accepted bud as a cataloged detail recipe.

Apple framework candidate:

- SpriteKit remains the correct renderer and no drawing code needs to change.
- ModelIO, SceneKit, and RealityKit remain deferred because this is a 2D catalog bridge, not GLB/USD/socket validation.

External library candidate:

- None. A new dependency would not improve a single recipe label.
- Existing SnapshotTesting remains useful as verification that the accepted horn-bud image reference does not change.

Decision:

- Add `tinyRoundedHornBud` as a growth-detail recipe separate from always-visible head detail recipes, so dormant creatures are not mislabeled as having a visible horn.
- Keep the SpriteKit geometry, normal Observation, Growth Ceremony, Widget handoff, persistence, packages, and project files unchanged.

Minimum scope:

- Extend `CreatureDetailRecipeID`, `CreatureFixedPartCatalog.currentLuma`, and a read-only growth-detail coverage helper.
- Include the new recipe in horn-bud app-target coverage assertions.
- Let existing horn-bud image snapshot prove no pixel change.

Future replacement point:

- When Horn Base reference sheets or 3D fixed parts start, this detail recipe can become the naming bridge to `horn_L` / `horn_R` sockets and manual review evidence without changing the current 2D shape.

Result:

- Added `tinyRoundedHornBud` to `CreatureDetailRecipeID`.
- Added `growthDetailRecipeIDs` to the fixed-part catalog and registered `tinyRoundedHornBud` without changing head-family detail recipes.
- Added a growth-horn-bud detail recipe coverage helper that reports `none` for dormant portraits and `tinyRoundedHornBud` only when the accepted bud is visible.
- Exposed hidden ObservationHome coverage probes and app-target assertions for the horn-bud QA surface.
- Kept SpriteKit drawing, normal Observation, Growth Ceremony, Widget handoff, persistence, package files, project files, and image references unchanged.

Verification:

- Targeted horn-bud snapshot test passed and the existing horn-bud image reference did not require an update.
- `swift test --quiet` passed with 367 tests.
- `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP horn-bud visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_fa9bfa56-c8f9-48cd-964b-e8c3efc996d9.jpg` confirmed the metadata bridge adds no visible technical text and leaves the bud gentle.

## Current Loop: Horn Base Reference Evidence Handoff

Handwritten complexity:

- The accepted `tinyRoundedHornBud` now has a catalog recipe, but Horn Base reference-sheet work still needs an evidence handoff that says which future panels, sockets, rig targets, and manual art review fields must prove the bud remains cute and secondary.
- The risky part is pretending a visible SpriteKit bud is already a 3D asset. This loop keeps it as evidence metadata only.

Apple framework candidate:

- Swift and existing SpriteKit metadata are sufficient.
- ModelIO, SceneKit, and RealityKit remain deferred because there is still no GLB/USD, generated mesh, or reference PNG to inspect.

External library candidate:

- None for implementation. Existing SnapshotTesting app-host coverage can verify the hidden metadata without adding dependencies.

Decision:

- Add a metadata-only Horn Base reference evidence handoff linking `tinyRoundedHornBud` to future `frontView`, `sideView`, `threeQuarterView`, `socketDiagram`, and `rigDiagram` review evidence.
- Require `headTopCenter`, `headTopPair`, `horn_L`, `horn_R`, `roundedNonSharp`, manual visual QA accepted, no generated geometry, no runtime loading, no snapshot acceptance, and `assetOutputs:none`.

Minimum scope:

- Add Core summary/readiness helpers and tests.
- Expose the summary only through Genome Variation QA hidden metadata and app-target assertions.
- Keep SpriteKit drawing, normal Observation, Growth Ceremony, Widget handoff, persistence, packages, project files, generated assets, and image references unchanged.

Future replacement point:

- When a real Horn Base reference sheet candidate exists, this handoff can be replaced by recorded review evidence with an artifact path, reviewer note, and accepted/needs-revision state.

Result:

- Added `fixedPartHornBaseReferenceEvidenceHandoff` Core summary/readiness metadata.
- Linked the accepted `tinyRoundedHornBud` cue to future `frontView`, `sideView`, `threeQuarterView`, `socketDiagram`, and `rigDiagram` evidence slots.
- Required `headTopCenter`, `headTopPair`, `horn_L`, `horn_R`, `roundedNonSharp`, accepted manual QA, no recorded final evidence, no generated geometry, no snapshot acceptance, no runtime loading, and `assetOutputs:none`.
- Exposed the handoff only through Genome Variation QA hidden metadata and app-target assertions.
- Updated the fixed-part manifest to clarify that dormant baseline horns remain hidden and the accepted 2D bud is only a handoff source.
- Kept SpriteKit drawing, normal Observation, Growth Ceremony, Widget handoff, persistence, packages, project files, generated assets, and image references unchanged.

Verification:

- `swift test --quiet` passed with 369 tests.
- Targeted Genome Variation app-host snapshot test passed.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP Genome Variation visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_37f2216b-a8c7-42e4-9492-d7408868baea.jpg` confirmed the handoff stays hidden and the QA surface remains readable.

## Current Loop: SpriteKit Tail Growth Tip Glint

Handwritten complexity:

- `tailGrowth` already changes tail scale, but the player-facing cue can still feel technical. A tiny tail-tip glint can make growth feel observed and affectionate without adding a stat, button, or collectible mark.
- The cue must stay secondary to the creature's face and must not read as rarity sparkle or loot.

Apple framework candidate:

- SpriteKit is already rendering the handmade tail, so a small `SKShapeNode` glint is the smallest reversible implementation.
- CoreImage is not needed because this is not procedural texture or mask generation.

External library candidate:

- None for implementation. Existing SnapshotTesting can verify the accepted Genome Variation surface after visual QA.

Decision:

- Add a handmade SpriteKit tail-tip growth glint derived from `GrowthGenes.tailGrowth`.
- Keep the cue deterministic, tiny, and tied to growth language rather than optimization language.

Minimum scope:

- Add a read-only `GrowthTailTipCue` to `CreatureRenderProfile`.
- Draw one subtle tail-tip glint only when `tailGrowth` is high enough.
- Expose hidden Genome Variation metadata and app-target assertions.
- Update image reference only if visual QA accepts the changed pixels.

Future replacement point:

- If CoreImage later owns pattern/glow generation, this cue can become a mask/glow input after the handmade silhouette remains loved and stable.

Result:

- Added `spriteKitGrowthTailTipCue` Core summary/readiness metadata for `GrowthGenes.tailGrowth`.
- Added `CreatureRenderProfile.GrowthTailTipCue` so the renderer can describe a resting, soft, or bright tail-tip cue without mutating `Creature`.
- Drew one tiny handmade SpriteKit tail-tip glint for visible `tailGrowth` portraits.
- Exposed the cue only through Genome Variation QA hidden metadata and app-target assertions.
- Kept normal Observation text, Widget handoff, persistence, Growth Ceremony, packages, project files, generated assets, 3D pipeline, and the Genome Variation image reference unchanged.

Verification:

- `swift test --quiet` passed with 371 tests.
- Targeted Genome Variation app-host snapshot test passed.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP Genome Variation visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_8db41f1c-cc5d-4062-9b99-d78fa25b0cb9.jpg` confirmed the glint stays subtle, no technical metadata leaks into the visible surface, and the card layout remains readable.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: continue small genome-driven visual differences, prioritizing silhouette or posture cues that make siblings easier to recognize.
- Lane B Growth Ceremony UI: reuse the local preview state to make growth feel observed before any real mutation/write path.
- Lane C Snapshot Strategy: decide whether the accepted tail cue needs a dedicated lower-threshold visual baseline before broader pet variation work.

## Current Loop: Growth Ceremony Tail Glint Noticed Memory

Handwritten complexity:

- The preview already lets the player mark a growth observation as noticed, but the default memory line can still feel generic.
- Now that `tailGrowth` has a subtle visible glint, the ceremony should remember the observed cue in language: the player noticed the tail light, not an abstract stage change.
- The line must remain preview-only and must not become a write, Widget handoff, discovery append, or `advanceGrowthStage()` path.

Apple framework candidate:

- SwiftUI local state and the existing Core `GrowthCeremonyNoticedMemoryLineCopy` are sufficient.
- No new Apple framework is needed because this is copy selection from existing render profile metadata, not persistence, graph layout, image processing, or animation timing.

External library candidate:

- None. SnapshotTesting is already present and can guard the acknowledged preview surface.

Decision:

- Reuse `GrowthCeremonyNoticedMemoryLineCopy`.
- Prefer a tail-glint-specific noticed memory line when the next-stage preview portrait has a visible `GrowthTailTipCue`.
- Keep horn-bud-specific copy as a higher-priority override when a visible bud is present.

Minimum scope:

- Add an app-side tail-glint memory line helper in `ObservationHomeState`.
- Pass that line into the existing noticed memory copy without changing Core persistence or mutation contracts.
- Update app-target snapshot expectations and manual visual QA only for the Growth Ceremony preview surface.

Future replacement point:

- If Growth Ceremony later gains a richer discovery draft, this copy selection can move into a small trait-memory catalog shared by discovery logs and Widget handoff preparation.

Result:

- Reused the existing `GrowthCeremonyNoticedMemoryLineCopy` contract.
- Added an app-side `growthTailTipNoticedMemoryLine` helper that names the visible tail-tip glow after the player marks the preview observation as noticed.
- Kept horn-bud-specific memory copy as the higher-priority override.
- Updated the Growth Ceremony preview app-target assertion and acknowledged `.lines` snapshot.
- Kept normal Observation, `advanceGrowthStage()`, Creature mutation, persistence, discovery append, Widget handoff publish, SpriteKit pixels, packages, project files, generated assets, and image references unchanged.

Verification:

- `swift test --quiet` passed with 371 tests.
- Targeted `testGrowthCeremonyPreviewProtectsVisibleDryRunSurface` passed.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP Growth Ceremony preview screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_e6aa89c6-abda-464f-956d-6d53f334e973.jpg` confirmed the initial preview remains readable and the noticed-memory line remains hidden before acknowledgement; the targeted app-host test confirmed the acknowledged copy becomes `Soft tail-tip glow will wait here as a quiet memory.` while mutation/write/widget/discovery flags stay false.

Next parallel lanes:

- Lane A Growth Ceremony UI: consider a small visual emphasis on the acknowledged memory line only if it does not make the card feel like a task checklist.
- Lane B SpriteKit Pet Variation: continue sibling-recognition cues, preferably posture or silhouette rather than more sparkle.
- Lane C Snapshot Strategy: decide whether Growth Ceremony acknowledged copy needs a narrower text-only contract for trait-specific memory lines.

## Current Loop: Growth Ceremony Acknowledged Memory Emphasis

Handwritten complexity:

- The acknowledged memory line now names the tail-tip glow, but it still appears as plain copy.
- The next step should make the line feel gently kept without turning the preview card into a task checklist, reward badge, or commit action.
- The visual treatment must remain preview-only and must not imply growth is persisted.

Apple framework candidate:

- SwiftUI `Image(systemName:)`, typography, and layout are enough for one small inline cue.
- No new Apple framework is needed because this is not animation timing, persistence, image processing, graph layout, or renderer logic.

External library candidate:

- None. Existing SnapshotTesting covers the acknowledged surface image and text contract.

Decision:

- Add a tiny inline check-seal cue beside the noticed memory line only after local acknowledgement.
- Do not add a new button, card, sheet, dependency, or state machine.

Minimum scope:

- Extract the noticed memory line into a small SwiftUI helper.
- Keep the text accessibility identifier on the line so existing tests continue to prove the copy.
- Update the acknowledged Growth Ceremony image reference only after visual QA accepts the subtler remembered-state treatment.

Future replacement point:

- If Growth Ceremony later gains a full confirmation ceremony, this inline cue can become part of a shared memory-state row style.

Result:

- Extracted the noticed memory line into a small SwiftUI helper.
- Added a tiny inline `checkmark.seal.fill` cue beside the line only after the preview observation is acknowledged.
- Kept `growthNoticedMemoryVisibleLine` on the text itself, so existing app-target checks still prove the copy.
- Kept normal Observation, `advanceGrowthStage()`, Creature mutation, persistence, discovery append, Widget handoff publish, SpriteKit pixels, packages, project files, generated assets, and snapshot image references unchanged.

Verification:

- `swift test --quiet` passed with 371 tests.
- Targeted `testGrowthCeremonyPreviewProtectsVisibleDryRunSurface` passed without snapshot reference updates.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, and `git diff --check` passed.
- XcodeBuildMCP Growth Ceremony preview screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_d1aa65f1-17bb-46c7-90b5-e0cb35272230.jpg` confirmed the initial preview remains readable and the acknowledged-only cue does not leak before the tap.
- `xcodebuild -list -project WiPet.xcodeproj` was attempted twice in this loop but hung before printing project info; it was interrupted to avoid leaving live processes. The project/plist/scheme lint and full build/test gates still completed successfully.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: posture or silhouette variation for sibling recognition, avoiding additional sparkle-first cues.
- Lane B Growth Ceremony Copy Catalog: factor trait-specific noticed memory copy into a tiny catalog if another trait needs language.
- Lane C Tooling Health: investigate why `xcodebuild -list` intermittently hangs after long UI-test runs.

## Current Loop: Growth Ceremony Noticed Memory Copy Catalog

Handwritten complexity:

- Tail-tip and horn-bud noticed memory lines are WiPet-specific emotional copy, so they should not be generated randomly or spread across view state.
- The copy must keep saying "we noticed this" without implying persistence, discovery append, Widget handoff, or `advanceGrowthStage()`.

Apple framework candidate:

- Plain Swift value types are enough. This is not UI layout, persistence, random mutation, graph layout, image processing, or animation.

External library candidate:

- None. A localization/copy package would add overhead and would not improve the current small set of hand-authored lines.

Decision:

- Add a tiny Core catalog for Growth Ceremony noticed memory copy.
- The app maps render cue labels into catalog cue IDs, then feeds the selected line into the existing `GrowthCeremonyNoticedMemoryLineCopy`.

Minimum scope:

- Move the existing horn-bud and tail-tip memory lines into Core as deterministic catalog entries.
- Add Core tests for known cue IDs, unknown cues, and side-effect-free readiness.
- Keep visible UI, SpriteKit pixels, Widget handoff, persistence, discovery append, packages, project files, and snapshot references unchanged.

Future replacement point:

- When localization or a richer discovery draft arrives, this catalog can become the shared source for Growth Ceremony, discovery preview, and Widget handoff preparation copy.

Result:

- Added Core `GrowthCeremonyNoticedMemoryCatalogEntry` and `GrowthCeremonyNoticedMemoryCatalog`.
- Moved known horn-bud and tail-tip noticed memory lines into the Core catalog with trait IDs and preview-only side-effect flags.
- Updated `ObservationHomeState` to map render cue labels into catalog entries while preserving the existing horn-first, then tail-tip, then generic fallback priority.
- Kept visible UI text, SpriteKit pixels, Widget handoff, persistence, discovery append, packages, project files, generated assets, and snapshot references unchanged.

Verification:

- `swift test --quiet` passed with 373 tests.
- Targeted `testGrowthCeremonyPreviewProtectsVisibleDryRunSurface` passed.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- `xcodebuild -quiet -project WiPet.xcodeproj -scheme WiPetWidget -configuration Debug -sdk iphonesimulator build CODE_SIGNING_ALLOWED=NO ARCHS=arm64 ONLY_ACTIVE_ARCH=NO` passed.
- `plutil -lint WiPet.xcodeproj/project.pbxproj WiPetWidget/Info.plist` passed.
- `xmllint --noout WiPet.xcodeproj/xcshareddata/xcschemes/WiPet.xcscheme WiPet.xcodeproj/xcshareddata/xcschemes/WiPetSnapshotTests.xcscheme` passed.
- `xcodebuild -list -project WiPet.xcodeproj` passed and confirmed `WiPet`, `WiPetCore`, `WiPetSnapshotTests`, and `WiPetWidget` schemes.
- `git diff --check` passed.
- XcodeBuildMCP Growth Ceremony preview screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_0ab0fc37-1041-479f-be69-3720d7fbf26f.jpg` confirmed the initial preview remains readable and the noticed-memory line remains hidden before acknowledgement.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: add posture or silhouette sibling-recognition cues before adding more sparkle/glow cues.
- Lane B Growth Ceremony Copy Catalog: add the next trait line only through the Core catalog so emotional copy does not scatter back into view state.
- Lane C Tooling Health: keep the guarded `xcodebuild -list` pattern available if simulator-heavy runs make Xcode metadata commands hang again.

## Current Loop: SpriteKit Body Proportion Cue Contract

Handwritten complexity:

- Body family silhouettes already differ in handmade SpriteKit shape recipes and rect proportions, but their affection intent is easy to lose during future renderer cleanup or 3D asset migration.
- The next sibling-recognition step should protect quiet body proportion differences rather than adding more glow, particles, or debug-visible UI.

Apple framework candidate:

- SpriteKit remains the correct renderer. Existing `SKShapeNode` recipes already express the body silhouette.
- No additional Apple framework is needed because this loop does not require physics, graph layout, procedural images, or 3D import/export.

External library candidate:

- None. SnapshotTesting already protects the Genome Variation QA surface and semantic `.lines` output.

Decision:

- Add a body proportion cue contract around the existing handmade SpriteKit body silhouette.
- Keep `PartAssembler` drawing unchanged for this loop; the new contract records width, height, and affection labels so body shape differences can be tested and preserved.

Minimum scope:

- Add Core renderer metadata helpers for `spriteKitBodyProportionCue`.
- Add `CreatureRenderProfile.BodyProportionCue` derived from `BodyBase` and existing `BodyStyle` proportions.
- Expose the cue in Genome Variation QA hidden metadata and app-target snapshot lines.
- Keep visible UI, SpriteKit pixels, Widget handoff, persistence, package files, project files, generated assets, and image references unchanged unless visual QA proves an update is needed.

Future replacement point:

- If a later loop changes actual body geometry or migrates body parts to GLB/USD, this cue becomes the acceptance contract that each body family still reads as a distinct, affectionate silhouette.

Result:

- Added Core `spriteKitBodyProportionCue` summary/readiness helpers.
- Added `CreatureRenderProfile.BodyProportionCue`, derived from the existing handmade `BodyStyle` rect family labels.
- Exposed the cue in Genome Variation QA hidden metadata and protected it in the app-target `.lines` snapshot.
- Kept `PartAssembler`, visible UI, SpriteKit pixels, Widget handoff, persistence, packages, project files, generated assets, and image references unchanged.

Verification:

- `swift test --quiet` passed with 375 tests.
- Targeted `testGenomeVariationSnapshotHostExposesTargetEntryReadiness` passed after the semantic `.lines` reference was intentionally updated with the new body proportion cue lines.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, guarded `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP Genome Variation preview screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_9b6a4edb-6339-4115-9c29-db1008e2157d.jpg` confirmed the visible QA surface remains calm, readable, and free of technical metadata.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: move from protected body proportion metadata to one small visible body-family silhouette nudge only if manual QA shows it increases "うちの子" recognition.
- Lane B 3D Fixed Parts Docs: map body proportion cue labels into future Upper Body Base naming before GLB/USD production.
- Lane C Snapshot Strategy: consider whether body proportion cue should join the Core text-only silhouette cue-set snapshot once another proportion cue is added.

## Current Loop: Upper Body Proportion 3D Handoff

Handwritten complexity:

- `BodyProportionCue` labels are art-direction language, not mesh generation instructions.
- Future Upper Body Base assets need stable names, sockets, and review panels so the handmade SpriteKit body silhouette does not get flattened during 3D migration.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the right future candidates for GLB/USD import, socket preview, and validation.
- They are still premature in this loop because there is no generated PNG, GLB, USD, mesh, or CommonPetRig asset to inspect.

External library candidate:

- None. This is a deterministic naming and handoff contract.

Decision:

- Add a Core metadata handoff from body proportion cue labels to future `UpperBody` asset names.
- Keep this as docs plus testable metadata only. Do not generate assets, edit project/package files, or change SpriteKit drawing.

Minimum scope:

- Document the `BodyProportionCue -> UpperBody.<base>@bodyCenter` mapping in the fixed-part 3D manifest.
- Add Core metadata helpers and tests that require all five current upper-body mappings, `bodyCenter`, `body`, required review panels, disabled generated assets, and `assetOutputs:none`.
- Expose the handoff in Genome Variation QA hidden metadata.
- Keep visible UI, SpriteKit pixels, Widget handoff, persistence, generated PNG/GLB/USD assets, ModelIO, SceneKit, RealityKit, package files, project files, and image references unchanged.

Future replacement point:

- When the first Upper Body reference sheet or GLB/USD asset exists, this handoff becomes the preflight checklist for ModelIO plus SceneKit/RealityKit socket validation.

Result:

- Added Core `fixedPartUpperBodyProportionHandoff` summary/readiness helpers.
- Added `CreatureRenderProfile.fixedPartUpperBodyProportionHandoff*` mappings from current `BodyProportionCue` labels to future `UpperBody.<base>@bodyCenter#proportionCue` names.
- Updated the fixed-part 3D manifest with Upper Body proportion handoff mappings, `bodyCenter` socket, `body` rig target, required panels, and generation-disabled rules.
- Exposed the handoff in Genome Variation QA hidden metadata and protected it in the app-target `.lines` snapshot.
- Kept visible UI, SpriteKit pixels, Widget handoff, persistence, generated PNG/GLB/USD assets, ModelIO, SceneKit, RealityKit, package files, project files, and image references unchanged.

Verification:

- `swift test --quiet` passed with 377 tests.
- Targeted `testGenomeVariationSnapshotHostExposesTargetEntryReadiness` passed after the semantic `.lines` reference was intentionally updated with the new Upper Body handoff lines.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, guarded `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP Genome Variation preview screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_c157622b-de79-42e2-bcb8-1c8070dbdbcf.jpg` confirmed the visible QA surface remains calm, readable, and free of technical metadata.

Next parallel lanes:

- Lane A 3D Fixed Parts Docs: add a similar preflight bridge for Face/Wing/Tail proportion or accessory handoffs only when an existing SpriteKit cue needs asset naming protection.
- Lane B SpriteKit Pet Variation: consider one tiny visible body-family silhouette nudge if it increases "うちの子" recognition in visual QA.
- Lane C Snapshot Strategy: consider moving Upper Body handoff into a narrower Core text snapshot if more 3D preflight handoffs accumulate.

## Current Loop: GameplayKit Affection Weight Helper

Handwritten complexity:

- The existing GameplayKit lineage planner already produces deterministic mutation plans, but the affection rule "祖先に似ているが少し違う" is repeated across adoption gates, profiles, and distribution samples.
- That repeated check is WiPet-specific: randomness is acceptable only when ancestral resemblance stays clearly stronger than mutation.

Apple framework candidate:

- GameplayKit remains adopted through `LineageMutationPlanner`.
- `GKLinearCongruentialRandomSource`, `GKRandomDistribution`, and `GKGaussianDistribution` remain the right Apple-standard support rail because they are deterministic, testable, and require no project/package changes.

External library candidate:

- None. A random or statistics package would not improve affection, iOS fit, or reversibility for this slice.

Decision:

- Keep GameplayKit and add only a tiny Core helper on `LineageMutationPlan` that names the affection-weight rule.
- Reuse that helper from existing readiness gates so the rule remains consistent before any plan reaches preview, copy, or future persistence.

Minimum scope:

- Add `resemblanceAdvantage` and `keepsAncestralResemblance(minimumAdvantage:)`.
- Update existing Core readiness checks to call the helper.
- Add focused Core tests for accepted and weak plans.
- Do not change planner distributions, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, or `WiPet.xcodeproj`.

Future replacement point:

- If lineage planning expands to weighted trait inheritance or multi-generation ancestor scoring, keep this helper as the public affection boundary around any richer GameplayKit planner.

Result:

- Added `LineageMutationPlan.resemblanceAdvantage`.
- Added `LineageMutationPlan.keepsAncestralResemblance(minimumAdvantage:)` and routed the GameplayKit adoption gate, mutation affection profile, and distribution sample through it.
- Added Core tests proving a healthy GameplayKit plan keeps ancestry ahead of variation and a weak manual plan fails the affection-weight rule.
- Kept GameplayKit distributions, Creature mutation, renderer drawing, Widget handoff, persistence, visible UI, generated assets, `Package.swift`, and `WiPet.xcodeproj` unchanged.

Verification:

- `swift test --quiet` passed with 378 tests.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, guarded `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP normal WiPet visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_c67fd178-3c21-481d-be62-f1de289d841c.jpg` confirmed no GameplayKit, seed, random-roll, or adoption-gate text appears in the player UI.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: return to a tiny visible genome-driven cue only if it increases "この子は違う" without visual noise.
- Lane B Lineage UI Design: design a read-only family preview before graph layout adoption.
- Lane C Snapshot Strategy: keep SnapshotTesting as support, but avoid adding visual baselines for lineage helpers until a player-facing surface exists.

## Current Loop: Lineage Preview Affection Gate

Handwritten complexity:

- The child preview must preserve WiPet's affection rule: a future child should feel inherited first and surprising second.
- The repeated risk is treating a deterministic GameplayKit preview as sufficient even when mutation weight is too close to family resemblance.

Apple framework candidate:

- GameplayKit remains the correct Apple-standard support rail through the existing `LineageMutationPlanner`.
- No additional Apple framework is needed because the task is a Core readiness rule, not drawing, persistence, or device UI.

External library candidate:

- None. A random/statistics package would add complexity without improving "祖先に似ているが少し違う".

Decision:

- Reuse the existing `LineageMutationPlan.keepsAncestralResemblance()` helper inside `LineageGenomePreviewLibraryAdoptionGate`.
- Keep the implementation Core-only with focused Swift tests while `~/Library/Developer/XCTestDevices` is being moved to external SSD storage.

Minimum scope:

- Add `resemblanceBeatsMutation` to the preview adoption gate.
- Include it in readiness and the summary string.
- Add a weak manual-preview test that fails the gate when mutation erodes the family resemblance advantage.
- Do not change SpriteKit drawing, Widget handoff, persistence, package files, project files, generated assets, or visible UI.

Result:

- No new dependency was added; the existing GameplayKit-backed planner remains the source of deterministic child preview variation.
- `LineageGenomePreviewLibraryAdoptionGate` now requires `resemblanceBeatsMutation`, reusing the shared WiPet affection helper instead of duplicating random-safety logic.
- Core tests prove the gate accepts healthy GameplayKit previews and rejects a weak GameplayKit-sourced manual preview.
- Simulator and app-target visual QA were intentionally skipped because this loop is Core-only and `~/Library/Developer/XCTestDevices` is being moved to external SSD storage.

## Current Loop: Lineage Read-Only Preview Copy

Handwritten complexity:

- The next family-preview language must feel like observation, not breeding, stat planning, or random-output disclosure.
- The copy needs to preserve affection-safe preview context while hiding seeds and raw randomness.

Apple framework candidate:

- GameplayKit remains indirectly used through `LineageGenomePreviewPlanner` and the adoption gate.
- No new Apple framework is needed because this is copy/safety modeling, not rendering, graph layout, persistence, or visual QA.

External library candidate:

- None. A copy, graph, or random package would not improve this small read-only boundary.

Decision:

- Add a Core read-only preview copy value that consumes `LineageGenomePreviewLibraryAdoptionGate`.
- Require no persistence write, no breeding controls, no Widget handoff, no seed details, no raw randomness, and no player-facing exposure yet.
- Keep the work Core-only while external Xcode device storage is moving.

Minimum scope:

- Add the copy value and summary/readiness strings.
- Add Core tests for healthy copy and unsafe flag rejection.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, package files, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewCopy` without adding dependencies.
- The copy reuses the GameplayKit-backed, affection-safe preview gate and exposes only quiet inherited/variation/safety lines.
- Core tests prove the copy hides seed/raw randomness and rejects persistence, breeding, Widget handoff, empty text, and premature player-facing exposure.
- Visual QA was intentionally skipped because this loop is Core-only and external Xcode device storage may still be moving.

## Current Loop: Lineage Read-Only Preview Copy Factory

Handwritten complexity:

- Future UI should not know how to assemble lineage gates; it should receive already-safe family-preview copy.
- The copy tone stays handmade, while deterministic parent/trait selection remains behind GameplayKit.

Apple framework candidate:

- GameplayKit remains used through `LineageGenomePreviewPlanner`.
- No additional Apple framework is needed because this loop only names a Core composition boundary.

External library candidate:

- None. A factory around existing Core values is too small for a package and must stay transparent.

Decision:

- Add a `LineageReadOnlyPreviewCopy.preview(...)` factory that consumes parent genomes through the existing GameplayKit-backed preview adoption gate.
- Keep all copy safeguards local: no seed details, raw randomness, persistence write, breeding controls, Widget handoff, or premature player-facing exposure.

Minimum scope:

- Add the factory.
- Add Core tests for deterministic output, parent-order stability, empty-parent rejection, and safety flags.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewCopy.preview(...)` without adding dependencies.
- The factory keeps GameplayKit behind the preview planner and returns copy only when the adoption gate remains affection-safe.
- Core tests prove deterministic repeatability, parent-order stability, empty-parent nil, seed/raw-random hiding, and no persistence, breeding, Widget handoff, or player-facing exposure.
- Visual QA was intentionally skipped because this is Core-only and does not change visible UI or renderer output.

## Current Loop: Lineage Read-Only Preview Surface Contract

Handwritten complexity:

- The future family preview surface must feel like an observation window and not a management screen.
- The contract should keep graph navigation, breeding controls, optimization controls, persistence, and Widget handoff out until there is an accepted visual surface.

Apple framework candidate:

- No new Apple framework is needed because this is a Core surface contract, not SwiftUI rendering or graph layout.

External library candidate:

- None. A graph/tree layout package should be considered only after a visible family-tree surface exists.

Decision:

- Add a small Core surface contract around `LineageReadOnlyPreviewCopy`.
- Keep the contract read-only and non-player-facing until a hidden QA host is ready.

Minimum scope:

- Add the surface contract and summary/readiness strings.
- Add Core tests for healthy surface copy and unsafe flag rejection.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewSurface` without adding dependencies.
- The contract wraps safe read-only preview copy and keeps the future surface observational instead of managerial.
- Core tests prove the surface rejects persistence, breeding controls, graph navigation, optimization controls, Widget handoff, empty text, and premature player-facing exposure.
- Visual QA was intentionally skipped because this is Core-only and does not change visible UI or renderer output.

## Current Loop: Lineage Read-Only Preview Surface Factory

Handwritten complexity:

- Future UI should ask Core for one safe read-only surface instead of composing planners, gates, copy, and surface flags itself.
- The surface still needs handmade tone and strict side-effect boundaries.

Apple framework candidate:

- GameplayKit remains indirectly used through the existing preview planner and copy factory.
- No new Apple framework is needed because this is Core composition, not rendering or layout.

External library candidate:

- None. Graph/tree layout and snapshot libraries are not useful until the surface is visible.

Decision:

- Add a `LineageReadOnlyPreviewSurface.preview(...)` factory that consumes parent genomes through the existing copy factory.
- Keep all read-only constraints local and tested before SwiftUI wiring.

Minimum scope:

- Add the factory.
- Add Core tests for deterministic output, parent-order stability, empty-parent nil, and read-only flags.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewSurface.preview(...)` without adding dependencies.
- The factory keeps GameplayKit behind the preview/copy path and returns only a ready read-only surface.
- Core tests prove deterministic repeatability, parent-order stability, empty-parent nil, GameplayKit-backed affection safety, and no persistence, breeding, graph navigation, optimization controls, Widget handoff, or player-facing exposure.
- Visual QA was intentionally skipped because this is Core-only and does not change visible UI or renderer output.

## Current Loop: Lineage Read-Only Preview Surface Text Contract

Handwritten complexity:

- The future QA host needs stable lines that feel like quiet observation copy, not debug output.
- Text must hide seeds and raw randomness while still making the read-only surface contract testable.

Apple framework candidate:

- No new Apple framework is needed because this is pure Core text formatting.

External library candidate:

- SnapshotTesting is useful later when the SwiftUI host exists, but adopting or invoking it now would be premature.

Decision:

- Add a Core text contract for `LineageReadOnlyPreviewSurface`.
- Keep it dependency-free and covered by Swift tests before any app-target snapshot wiring.

Minimum scope:

- Add the text value.
- Add Core tests for stable line output and unsafe surface rejection.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewSurfaceText` without adding dependencies.
- The text contract provides stable title/subtitle/inherited/variation/safety lines for a future hidden QA host.
- Core tests prove line order, snapshot text assembly, seed/raw-random hiding, summary/readiness output, and unsafe-surface rejection.
- Visual QA was intentionally skipped because this is Core-only and does not change visible UI or renderer output.

## Current Loop: Lineage Read-Only Preview Surface Text Factory

Handwritten complexity:

- Future QA host code should not assemble lineage parents, surface, and text by hand.
- The generated text must remain quiet and hide seed/raw-random details.

Apple framework candidate:

- GameplayKit remains indirectly behind the preview and surface factories.
- No new Apple framework is needed because this is Core composition.

External library candidate:

- SnapshotTesting remains a later app-host concern, not a Core factory concern.

Decision:

- Add `LineageReadOnlyPreviewSurfaceText.preview(...)`.
- Keep it dependency-free and covered by Swift tests before SwiftUI wiring.

Minimum scope:

- Add the factory.
- Add Core tests for deterministic output, parent-order stability, empty-parent nil, stable lines, and hidden random details.
- Do not change SwiftUI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or visual snapshots.

Result:

- Added `LineageReadOnlyPreviewSurfaceText.preview(...)` without adding dependencies.
- The factory lets a future hidden QA host request stable text directly from parent genomes while keeping GameplayKit behind Core planning.
- Core tests prove deterministic repeatability, parent-order stability, GameplayKit-backed affection safety, stable line output, seed/raw-random hiding, and empty-parent nil.
- Visual QA was intentionally skipped because this is Core-only and does not change visible UI or renderer output.

## Current Loop: Lineage Read-Only Preview Surface Text Host

Handwritten complexity:

- The Lineage Family QA host should expose the new read-only preview text without turning the visible surface into a debug panel.
- The copy must stay quiet and hidden from normal app paths until a visible family-preview experience is accepted.

Apple framework candidate:

- SwiftUI remains the host surface; no new Apple framework is needed.

External library candidate:

- Existing SnapshotTesting is already present for app-target `.lines` snapshots and is enough for this guard.
- No package or project dependency should be added.

Decision:

- Expose the Core text contract through hidden `LineageFamilyQAView` metadata.
- Extend the existing Lineage Family app-target `.lines` reference.

Minimum scope:

- Add hidden text summary/readiness/snapshot probes.
- Update the existing app-target test and reference.
- Do not change visible UI, SpriteKit, WidgetKit, persistence, packages, project files, generated assets, or normal app behavior.

Result:

- Added hidden Lineage Family QA host metadata for read-only preview readiness, summary, and snapshot text.
- Reused existing SnapshotTesting `.lines` coverage instead of adding a package or new snapshot surface.
- Kept the visible Lineage Family surface unchanged; the affectionate preview copy is available only as hidden QA metadata.
- Preserved Widget handoff, persistence, SpriteKit drawing, package files, project files, and generated assets.

Verification:

- `swift test --quiet` passed with 396 Swift Testing tests.
- Generic simulator app build passed.
- `WiPetSnapshotTests` `build-for-testing` passed for generic iOS Simulator, proving the app-target test source compiles.
- Targeted app-target test execution stayed blocked because `xcodebuild` did not list the external-SSD CoreSimulator device set after migration.
- A temporary `/tmp/WiPetCoreSimulatorDevices` iPhone 17 was booted non-destructively for manual visual QA, and `/tmp/wipet-lineage-readonly-preview-host.png` confirmed the visible QA surface remained readable and unchanged.

## Current Loop: Lineage Branch Caption Text Contract

Handwritten complexity:

- The family branch needs one stable caption that names the ancestor, current members, and draft memory without exposing seed/random details or adding graph controls.
- The risky part is tone: the caption should feel like a remembered household line, not a management-tree label.

Apple framework candidate:

- No new Apple framework is needed. SwiftUI already hosts hidden QA metadata, and XCTest plus the existing SnapshotTesting `.lines` reference can protect the text contract.

External library candidate:

- Graph/tree layout packages remain deferred because no visible graph is drawn.
- A second snapshot package is unnecessary because SnapshotTesting is already adopted for app-target text coverage.

Decision:

- Add a dependency-free Core `LineageBranchCaptionText` value.
- Reuse existing Lineage Family QA hidden metadata and `.lines` snapshot coverage.
- Keep visible UI, SpriteKit, WidgetKit, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, and 3D runtime loading unchanged.

Minimum scope:

- Compose the caption from `LineageFamilyBranchPreview` and `LineageReadOnlyPreviewSurfaceText`.
- Reject unsafe navigation, persistence, breeding, optimization, player-facing state, and seed/random wording.
- Add Core tests and extend the existing Lineage Family app-target text snapshot.

Future replacement point:

- If the family tree later reaches the graph-layout adoption threshold, this caption becomes the branch label/caption input to that layout helper rather than being replaced by layout math.

Result:

- Added dependency-free Core `LineageBranchCaptionText`.
- Reused existing Lineage Family QA hidden metadata and SnapshotTesting `.lines` coverage.
- The branch caption names the ancestor, current members, and draft memory while keeping seed/random details hidden.
- No graph/tree layout package, new snapshot package, project edit, package edit, visible UI change, renderer change, Widget change, persistence write, generated asset, GLB/USD, or 3D runtime loading was introduced.

Verification:

- `swift test --quiet` passed with 421 Swift Testing tests.
- Generic `WiPetSnapshotTests` `build-for-testing` passed with `/tmp/WiPetLineageBranchCaptionSnapshotBuildDerived`.
- Targeted Lineage Family QA app-host `.lines` test passed on a temporary `/tmp/WiPetLineageBranchCaptionSimDevices` iPhone SE iOS 18.1 device set after updating the stale reference copy to the runtime `gentleVariation` wording.
- Manual visual QA screenshot `/tmp/wipet-lineage-branch-caption-visual-qa.png` confirmed the visible Lineage Echo QA surface stayed readable and hidden metadata did not leak.
- Graph layout dependencies remain deferred until the future family tree crosses the existing complexity gate.

## Current Loop: Observation Branch Caption Bridge

Handwritten complexity:

- Observation already has a player-facing family memory sheet while Lineage QA has a hidden branch caption.
- The next risk is inconsistent family wording: one surface may feel like a household memory while the other feels like a graph label.

Apple framework candidate:

- No new Apple framework is needed. This loop is a Core consistency contract and does not alter SwiftUI layout, WidgetKit, SpriteKit, or persistence.

External library candidate:

- Graph/tree layout packages remain deferred because this checks copy continuity, not node placement.
- SnapshotTesting is not needed in this slice because no app-host metadata or reference files change.

Decision:

- Add dependency-free Core `LineageObservationBranchCaptionBridge`.
- Require Observation entry copy and branch caption copy to be ready, read-only, seed/random-free, and aligned around family/branch/line language.

Minimum scope:

- Add the Core bridge value.
- Add focused Swift tests plus Core text snapshot coverage.
- Do not change visible UI, app-host snapshots, renderer pixels, Widget behavior, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, or 3D runtime loading.

Future replacement point:

- If a future read-only family tree screen renders both Observation memories and branch captions, this bridge becomes the shared copy contract for that screen before any graph layout helper is adopted.

Result:

- Added dependency-free Core `LineageObservationBranchCaptionBridge`.
- The bridge proves Observation family-tree entry copy and Lineage branch caption copy both stay ready, read-only, seed/random-free, and aligned around family/branch/line language.
- Updated only Core tests and the Core text snapshot reference.
- No graph/tree layout package, SnapshotTesting reference, app-host metadata, visible UI, renderer pixels, Widget behavior, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, or 3D runtime loading changed.

Verification:

- `swift test --quiet` passed with 423 Swift Testing tests.
- Generic `WiPetSnapshotTests` `build-for-testing` passed with `/tmp/WiPetObservationBranchBridgeSnapshotBuildDerived`.
- Visual QA was not rerun because the slice is Core-only and visible surfaces did not change.

## Current Loop: Observation Family Household Line Copy

Handwritten complexity:

- The family memory sheet has one player-facing household line. Its wording should feel like a belonging memory, not a pending technical state.

Apple framework candidate:

- SwiftUI already renders the line. No Apple framework changes are needed.

External library candidate:

- None. WiPet-specific family-memory language is a core affection surface and should stay hand-authored.

Decision:

- Keep dependencies unchanged and update only the authored household line copy.
- Verify with existing Core tests and the app-host sheet preview route.

Minimum scope:

- Change the default `LineageObservationMemorySheetCopy.householdLine`.
- Update tests/references that intentionally protect the player-facing line.
- Do not change renderer pixels, Widget behavior, persistence, graph navigation, controls, package/project files, generated assets, GLB/USD, or 3D runtime loading.

Result:

- Changed the default household line to `This echo now belongs to this family's quiet line.`
- Kept the copy hand-authored and dependency-free.
- Updated Core tests, the Core `.lines` reference, and the app-host sheet expectation.
- No renderer, Widget, persistence, graph navigation, control, package/project, generated asset, GLB/USD, or 3D runtime change was introduced.

Verification:

- `swift test --quiet` passed with 423 Swift Testing tests.
- Generic `WiPetSnapshotTests` `build-for-testing` passed with `/tmp/WiPetHouseholdLineCopySnapshotBuildDerived`.
- Targeted sheet app-host test passed on a temporary iPhone SE device set.
- Manual visual QA screenshot `/tmp/wipet-household-line-copy-visual-qa.png` confirmed the line remains readable and the sheet stays quiet/read-only.

## Current Loop: SpriteKit Lunarian Body Crescent Shoulders

Handwritten complexity:

- `lunarian` already has a body proportion cue and crescent belly mark, but its shoulder silhouette is quieter than sylphian and verdant body families.
- The cue must feel like a soft lunar family trait, not a collectible part, stat, sparkle reward, or 3D asset.

Apple framework candidate:

- SpriteKit remains the right renderer because this is a tiny handmade `SKShapeNode` silhouette cue.
- CoreImage is not needed because there is no texture, mask, noise, glow generation, or CPPN work.
- ModelIO, SceneKit, and RealityKit are not needed because this does not create or validate GLB/USD assets.

External library candidate:

- None. A drawing package would reduce local art-direction control and add maintenance cost without increasing affection.

Decision:

- Add a local `softMoonShoulderCrescents` body silhouette accessory for `lunarian`.
- Keep it as SpriteKit drawing plus testable metadata and catalog recipe coverage.
- Do not change Genome values, Creature mutation, Widget handoff, persistence, package files, project files, generated PNG/GLB/USD assets, or 3D pipeline.

Minimum scope:

- Add one detail recipe ID and body accessory mapping for `lunarianBody`.
- Draw a pair of soft crescent shoulder ovals behind the body.
- Add Core readiness expectations and tests.
- Expose baseline Genome Variation QA hidden metadata so Luma's new cue is protected without visible technical text.

Future replacement point:

- When Upper Body Base reference sheets or GLB/USD assets exist, `softMoonShoulderCrescents` becomes a reference-sheet note for `UpperBody.lunarian@bodyCenter#accessoryCue`.

Result:

- Added `softMoonShoulderCrescents` as the Lunarian body silhouette accessory.
- Added the detail recipe to `lunarianBody` catalog coverage and fixed-part accessory bridge metadata.
- Rendered paired soft crescent shoulder shapes behind the Lunarian body in SpriteKit.
- Exposed Luma baseline body accessory hidden metadata in Genome Variation QA and updated the semantic `.lines` snapshot.
- Kept Genome values, Creature mutation, Widget handoff, persistence, package files, project files, generated PNG/GLB/USD assets, and 3D pipeline unchanged.

Verification:

- `swift test --quiet` passed with 378 tests.
- Targeted `testGenomeVariationSnapshotHostExposesTargetEntryReadiness` passed after the semantic `.lines` reference was intentionally updated.
- Full `WiPetSnapshotTests` passed on the iPhone 17 simulator.
- Widget simulator build passed.
- `plutil`, `xmllint`, guarded `xcodebuild -list`, and `git diff --check` passed.
- XcodeBuildMCP normal WiPet visual QA screenshot `/var/folders/h5/41tg_r8d5lxb221v4x8cgprc0000gn/T/screenshot_optimized_9a5c1870-28b9-40d4-9fd5-67f8304438d4.jpg` confirmed the visible home remains quiet, readable, and free of technical metadata.

Next parallel lanes:

- Lane A SpriteKit Pet Variation: add the next visible cue only if it improves family recognition more than another hidden contract.
- Lane B Lineage UI Design: continue the read-only family preview surface before adopting graph layout.
- Lane C 3D Fixed Parts Docs: add Face or Tail handoff only where an accepted 2D cue needs asset naming protection.

## Current Loop: Genome Variation Sibling Tail Accessory Contract

Handwritten complexity:

- Mira's fish-tail fork fin should read as a soft sibling silhouette difference, not as a stat or collectible marker.
- The contract should protect an existing visible cue without turning the QA surface into player-facing technical text.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is already a tiny handmade `SKShapeNode` accessory.
- CoreImage is not needed because there is no pattern, mask, glow, or texture generation.
- ModelIO, SceneKit, and RealityKit are not needed because no GLB/USD asset is being created or validated.

External library candidate:

- Existing SnapshotTesting is enough for the app-host `.lines` guard.
- No new package should be added.

Decision:

- Add no dependency and no new pixels.
- Extend the existing Genome Variation app-host semantic snapshot to require Mira's `fishFin` tail and `softForkFin` accessory.

Minimum scope:

- Add app-target assertions for sibling tail accessory readiness and summary.
- Update the existing `.lines` reference.
- Do not change visible UI, SpriteKit drawing, Creature mutation, Widget handoff, persistence, packages, project files, generated assets, or 3D pipeline.

Result:

- Added app-target assertions for `genomeVariationSiblingTailSilhouetteAccessoryReadinessSummary`.
- Added app-target assertions for Mira's `tail:fishFin` and `accessory:softForkFin` summary.
- Updated the existing Genome Variation semantic `.lines` reference.
- Kept the existing handmade SpriteKit drawing and all runtime behavior unchanged.

Verification:

- `swift test --quiet` passed with 396 Swift Testing tests.
- Generic simulator app build passed.
- `WiPetSnapshotTests` `build-for-testing` passed for generic iOS Simulator.
- Manual visual QA on a temporary `/tmp/WiPetSiblingTailSimDevices` iPhone 17 confirmed the Genome Variation surface remains readable and visually unchanged.
- The default external-SSD CoreSimulator device set still was not available to `xcodebuild`, so targeted app-test execution remains pending until simulator recovery.

## Current Loop: Genome Variation Sibling Wing Accessory Contract

Handwritten complexity:

- Mira's soft wing-tip pearl should read as a small fairy-sibling detail, not as a reward badge or technical marker.
- The contract should protect an existing visible cue while keeping technical metadata hidden.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is already a small handmade `SKShapeNode` detail.
- CoreImage is not needed because this does not generate masks, textures, glow, or CPPN-style patterns.
- ModelIO, SceneKit, and RealityKit are not needed because no GLB/USD asset is being created or validated.

External library candidate:

- Existing SnapshotTesting is enough for the app-host `.lines` guard.
- No new package should be added.

Decision:

- Add no dependency and no new pixels.
- Extend the existing Genome Variation app-host semantic snapshot to require Mira's `leafPair` wing and `softWingTipPearl` accessory.

Minimum scope:

- Add app-target assertions for sibling wing accessory readiness and summary.
- Update the existing `.lines` reference.
- Do not change visible UI, SpriteKit drawing, Creature mutation, Widget handoff, persistence, packages, project files, generated assets, or 3D pipeline.

Result:

- Added app-target assertions for `genomeVariationSiblingWingSilhouetteAccessoryReadinessSummary`.
- Added app-target assertions for Mira's `wing:leafPair` and `accessory:softWingTipPearl` summary.
- Updated the existing Genome Variation semantic `.lines` reference.
- Kept the existing handmade SpriteKit drawing and all runtime behavior unchanged.

Verification:

- `swift test --quiet` passed with 396 Swift Testing tests.
- Generic simulator app build passed.
- `WiPetSnapshotTests` `build-for-testing` passed for generic iOS Simulator.
- Manual visual QA on a temporary `/tmp/WiPetSiblingWingSimDevices` iPhone 17 confirmed the Genome Variation surface remains readable and visually unchanged.
- The default external-SSD CoreSimulator device set still was not available to `xcodebuild`, so targeted app-test execution remains pending until simulator recovery.

## Current Loop: Fixed Part Accessory Reference Handoff App Guard

Handwritten complexity:

- Accepted 2D accessory cues need stable future fixed-part names, sockets, and review gates before any GLB/USD generation.
- The handoff must preserve WiPet's cute silhouette decisions while avoiding premature 3D pipeline work.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for GLB/USD import/export and socket validation.
- They are not needed here because this slice only protects hidden app-host metadata and generates no assets.

External library candidate:

- Existing SnapshotTesting is enough for the app-host `.lines` guard.
- No new package should be added.

Decision:

- Add no dependency, no assets, and no visible UI.
- Extend the existing Genome Variation app-host semantic snapshot to require fixed-part accessory bridge/reference/preflight metadata.

Minimum scope:

- Add app-target assertions for accessory recipe bridge readiness and summary.
- Add app-target assertions for accessory reference annotation readiness and summary.
- Add app-target assertions for accessory reference sheet preflight readiness and summary.
- Update the existing `.lines` reference.
- Do not change SpriteKit drawing, Creature mutation, Widget handoff, persistence, packages, project files, generated assets, or 3D pipeline.

Result:

- Added app-target assertions for fixed-part accessory recipe bridge, reference annotation, and reference sheet preflight metadata.
- Updated the Genome Variation semantic `.lines` reference with the hidden fixed-part accessory handoff rows.
- Kept the existing handmade SpriteKit drawing and all runtime behavior unchanged.
- Deferred ModelIO, SceneKit, RealityKit, GLB, USD, and generated reference-sheet artifacts.

Verification:

- `swift test --quiet` passed with 396 Swift Testing tests.
- Generic simulator app build passed.
- `WiPetSnapshotTests` `build-for-testing` passed for generic iOS Simulator.
- Manual visual QA on a temporary `/tmp/WiPetAccessoryHandoffSimDevices` iPhone 17 confirmed technical handoff metadata remains hidden and the Genome Variation surface stays readable.
- The default external-SSD CoreSimulator device set still was not available to `xcodebuild`, so targeted app-test execution remains pending until simulator recovery.

## Current Loop: Fixed Part Accessory Reference Sheet Panel Notes

Handwritten complexity:

- Accepted 2D accessory cues need panel notes that preserve cute scale, socket ownership, grayscale-only modeling, and family-likeness safety.
- The notes should guide future 3D/reference-sheet work without generating assets prematurely.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred because there is no GLB/USD import, export, preview, or socket validation in this slice.
- Swift value metadata is enough to protect the panel note contract.

External library candidate:

- Existing SnapshotTesting is enough for the app-host `.lines` guard.
- No new package should be added.

Decision:

- Add no dependency, no generated geometry, and no visible UI.
- Add a small panel-note metadata contract for `softWingTipPearl`, `softForkFin`, and `softMoonShoulderCrescents`.

Minimum scope:

- Add Core summary/readiness helpers for fixed-part accessory reference sheet panel notes.
- Add static `CreatureRenderProfile` panel notes and hidden Genome Variation QA labels.
- Update Core tests and the existing Genome Variation `.lines` reference.
- Do not change SpriteKit drawing, Creature mutation, Widget handoff, persistence, packages, project files, generated assets, GLB, USD, or 3D pipeline.

Result:

- Added no dependency and no generated asset pipeline.
- Used Swift value metadata plus the existing SnapshotTesting semantic `.lines` reference to protect panel-note readiness.
- Kept ModelIO, SceneKit, and RealityKit deferred until a real GLB/USD, socket-validation, or fixed-part preview task exists.
- Verified with Core tests, generic simulator builds, and manual temp-Simulator visual QA.

## Current Loop: Genome Variation Child Draft Face Accessory Contract

Handwritten complexity:

- The child draft's `softEarNubs` cue is a tiny face-silhouette decision that helps "Ori's soft deer-face echo" feel visible without making the pet look sharp or noisy.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no FaceAccessory GLB/USD or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, snapshot, graph, or random package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Protect the already-visible child draft `softEarNubs` face accessory through hidden Genome Variation QA labels and the existing `.lines` snapshot reference.

Result:

- Added no dependency and no new rendering framework.
- Reused existing SwiftUI hidden QA labels and SnapshotTesting `.lines` coverage.
- Kept the hand-authored SpriteKit face accessory shape as the source of WiPet cuteness.
- Verified with Core tests, generic simulator builds, and manual temp-Simulator visual QA.

Future replacement point:

- If this cue becomes a real FaceAccessory fixed part asset, revisit ModelIO/SceneKit/RealityKit only in a separate asset-validation loop with docs, manual art review, and GLB/USD boundaries.

## Current Loop: Genome Variation Sibling Face Accessory Contract

Handwritten complexity:

- Mira's `softEarTips` cue is a small feline face-silhouette decision that makes the sibling feel recognizable without adding visual noise.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not pattern, mask, glow, or texture generation.
- ModelIO, SceneKit, and RealityKit stay deferred because no FaceAccessory GLB/USD import, export, preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, snapshot, graph, or random package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Mira's already-visible `softEarTips` sibling face accessory.

Result:

- Added no dependency and no rendering framework change.
- Reused existing SwiftUI hidden labels and SnapshotTesting `.lines` coverage.
- Kept the handmade SpriteKit feline ear-tip shape as the source of the sibling's recognizable face silhouette.
- Verified with Core tests, generic simulator builds, and manual temp-Simulator visual QA.

Future replacement point:

- If sibling face accessories become a real fixed-part asset lane, revisit ModelIO/SceneKit/RealityKit only with a separate reference-sheet and socket-validation gate.

## Current Loop: Fixed Part Face Accessory Panel Notes

Handwritten complexity:

- Face accessories need art-direction notes that preserve rounded cute silhouettes, socket ownership, grayscale-only modeling, and family-likeness safety before any 3D work starts.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for GLB/USD import/export, fixed-part preview, and socket validation.
- They are not useful in this slice because no asset exists and no geometry is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new package should be added for metadata-only reference-sheet notes.

Decision:

- Add no dependency, no generated geometry, and no visible UI.
- Extend the existing fixed-part accessory panel-note contract to include `softEarNubs` and `softEarTips`.

Result:

- Added no dependency and no asset pipeline.
- Extended the Swift metadata contract and existing SnapshotTesting `.lines` guard with accepted face accessory panel notes.
- Kept ModelIO, SceneKit, and RealityKit deferred until real FaceAccessory GLB/USD candidates exist.
- Verified with Core tests, generic simulator builds, and manual temp-Simulator visual QA.

Future replacement point:

- When a FaceAccessory GLB/USD candidate exists, revisit ModelIO/SceneKit/RealityKit in a separate validation loop that checks sockets, CommonPetRig mapping, and manual Creature Art Director review evidence.

## Current Loop: Genome Variation Baseline Face Facet Contract

Handwritten complexity:

- Luma's `softFacet` face accent is a handmade crystal-face cue that should stay gentle and recognizable without turning into a hard technical gem mark.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no FaceBase crystal asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Luma's already-visible `softFacet` baseline face accent.

Result:

- Added no dependency and no renderer change.
- Reused existing SwiftUI hidden labels and SnapshotTesting `.lines` coverage.
- Kept Luma's handmade SpriteKit `softFacet` accent as the baseline identity cue.
- Verified with Core tests, generic simulator builds, and manual temp-Simulator visual QA.

Future replacement point:

- If the crystal FaceBase moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Genome Variation Sibling Face Gleam Contract

Handwritten complexity:

- Mira's `kittenGleam` accent is a small handmade face cue that should make the sibling feel distinct and friendly without adding visual noise.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no feline FaceBase asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Mira's already-visible `kittenGleam` sibling face accent.

Result:

- Added no dependency and no renderer change.
- Reused the existing SwiftUI hidden-label QA surface and SnapshotTesting `.lines` semantic guard.
- Kept Mira's handmade SpriteKit `kittenGleam` as the sibling face identity cue.
- Verified with Swift tests, generic iOS Simulator builds, and manual temporary-Simulator visual QA.

Future replacement point:

- If the feline FaceBase moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Genome Variation Child Face Forest Dots Readiness Contract

Handwritten complexity:

- The child draft's `forestDots` face accent is a small handmade inherited-face cue that should read as Ori's gentle echo without becoming random freckles or procedural texture.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no deer FaceBase asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA readiness coverage for the child draft's already-visible `forestDots` face accent.

Result:

- Added no dependency and no renderer change.
- Reused the existing SwiftUI hidden-label QA surface and SnapshotTesting `.lines` semantic guard.
- Kept the child draft's handmade SpriteKit `forestDots` as Ori's inherited face echo.
- Verified with Swift tests, generic iOS Simulator builds, and manual temporary-Simulator visual QA.
- Did not count targeted app-host `test-without-building` as passing because Xcode hung during finalization and the run was interrupted.

Future replacement point:

- If the deer FaceBase moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Genome Variation Sibling Body Petal Chest Contract

Handwritten complexity:

- Mira's `petalChest` body accent is a small handmade chest mark that should make the sibling feel distinct and gentle without becoming a noisy pattern.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no sylphian UpperBody asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Mira's already-visible `petalChest` body accent.

Result:

- Added no dependency and no renderer change.
- Reused the existing SwiftUI hidden-label QA surface and SnapshotTesting `.lines` semantic guard.
- Kept Mira's handmade SpriteKit `petalChest` as a quiet sibling body identity cue.
- Verified with Swift tests, generic iOS Simulator builds, and manual temporary-Simulator visual QA.

Future replacement point:

- If the sylphian UpperBody moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Genome Variation Sibling Wing Soft Vein Contract

Handwritten complexity:

- Mira's `softVein` wing accent is a small handmade leaf-wing cue that should make the sibling feel alive and distinct without becoming a hard technical line pattern.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no fairy WingBase asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Mira's already-visible `softVein` wing accent.

Result:

- Added no dependency and no renderer change.
- Reused the existing SwiftUI hidden-label QA surface and SnapshotTesting `.lines` semantic guard.
- Kept Mira's handmade SpriteKit `softVein` as a soft sibling wing identity cue.
- Verified with Swift tests, generic iOS Simulator builds, and manual temporary-Simulator visual QA.

Future replacement point:

- If the fairy WingBase moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Genome Variation Baseline Body Crescent Belly Contract

Handwritten complexity:

- Luma's `crescentBelly` body accent is a small handmade moon-belly cue that should make the baseline child feel recognizable without becoming symbol-heavy or noisy.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored shape.
- CoreImage is not useful because this is not procedural texture, mask, glow, or noise work.
- ModelIO, SceneKit, and RealityKit stay deferred because no lunarian UpperBody asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting is enough for the semantic app-host `.lines` guard.
- No new drawing, image-processing, graph, random, or snapshot package should be added.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Luma's already-visible `crescentBelly` body accent.

Result:

- Added no dependency and no renderer change.
- Reused the existing SwiftUI hidden-label QA surface and SnapshotTesting `.lines` semantic guard.
- Kept Luma's handmade SpriteKit `crescentBelly` as a soft baseline body identity cue.
- Verified with Swift tests, generic iOS Simulator builds, and manual temporary-Simulator visual QA.

Future replacement point:

- If the lunarian UpperBody moves into a reference-sheet or 3D asset lane, revisit CoreImage only for pattern/glow generation and ModelIO/SceneKit/RealityKit only for asset validation.

## Current Loop: Growth Ceremony Crescent Belly Memory Catalog

Handwritten complexity:

- The `crescentBelly` cue needs a small ceremony memory line that feels like the player noticed Luma's moon-belly mark, without turning the ceremony into a stats or mutation screen.

Apple framework candidate:

- GameplayKit is not useful in this loop because no deterministic random, inheritance, mutation planning, or distribution behavior changes.
- SpriteKit remains the handmade visual source for the cue; no redraw is needed.
- CoreImage, ModelIO, SceneKit, and RealityKit stay deferred because no texture, glow, asset, GLB/USD, or socket validation work is happening.

External library candidate:

- SnapshotTesting is not needed because this loop does not change an app-host, Widget, or visible UI surface.
- No new package should be added for WiPet-specific emotional copy.

Decision:

- Add no dependency.
- Reuse the existing Core `GrowthCeremonyNoticedMemoryCatalog`.
- Keep the new entry preview-only and side-effect-free so the player can notice a trait before any future ceremony commit path exists.

Result:

- Added no dependency.
- Kept SpriteKit, Widget handoff, persistence, and visible UI unchanged.
- Added the Core-only `crescentBelly` / `bodyAccent` catalog entry with tests proving it is preview-only, non-writing, non-mutating, non-widget-publishing, and non-discovery-appending.
- Verified with Swift tests, generic iOS Simulator app build, and generic `WiPetSnapshotTests` `build-for-testing`; manual visual QA was not applicable because no visible surface changed.

Future replacement point:

- If body-accent ceremony language expands into a larger authored catalog, consider a structured data file or generated validation, but keep the affection copy itself owned by WiPet docs and Core tests.

## Current Loop: Growth Ceremony Body Accent Preview Bridge

Handwritten complexity:

- `ObservationHomeView` needs to recognize the preview portrait's body accent as an available noticed-memory candidate while preserving the existing ceremony line priority and side-effect boundaries.

Apple framework candidate:

- SwiftUI local value state already owns the preview surface and is sufficient for the hidden contract metadata.
- SpriteKit remains the handmade source of the `crescentBelly` body accent metadata.
- GameplayKit is not needed because this bridge does not change deterministic random, inheritance, mutation, or planning behavior.

External library candidate:

- Existing SnapshotTesting app-host `.lines` coverage can guard the hidden summary.
- No new package should be added for a one-cue SwiftUI bridge.

Decision:

- Add no dependency.
- Reuse `ObservationHomeState`, `CreatureRenderProfile`, and the Core `GrowthCeremonyNoticedMemoryCatalog`.
- Keep the bridge preview-only and side-effect-free.

Result:

- Added no dependency and made no project-file or package-file changes.
- Reused SwiftUI local value state, existing SpriteKit render metadata, Core authored catalog entries, and existing SnapshotTesting app-host `.lines` coverage.
- Added hidden app-host metadata proving `crescentBelly` is available as a `bodyAccent` noticed-memory candidate with write, mutation, Widget, and discovery side effects disabled.
- Kept the visible ceremony line priority unchanged so tail glow remains the current Luma ceremony copy while the body-accent candidate waits behind it.
- Verified with Swift tests, generic iOS Simulator builds, manual visual QA, and the targeted iPhone 17 app-host snapshot test.

Future replacement point:

- If multiple body accents become authored ceremony candidates, consider a small ordered catalog API in Core, but keep player-facing priority choices explicit and tested in the app host.

## Current Loop: Growth Ceremony Noticed Memory Priority Contract

Handwritten complexity:

- The ceremony needs an authored priority rule so the visible card stays quiet: horn growth can lead when visible, Luma's tail glow remains the current noticed memory, and `crescentBelly` waits as a body-accent fallback.

Apple framework candidate:

- SwiftUI local value state and existing Core catalog entries are enough for this priority summary.
- GameplayKit is not useful because selection is not random, inherited, or mutation-planned in this loop.
- SpriteKit remains the visual metadata source; no renderer change is needed.

External library candidate:

- Existing SnapshotTesting `.lines` coverage is sufficient to protect ordering.
- No new priority, rules-engine, or collection package should be added for three authored ceremony candidates.

Decision:

- Add no dependency.
- Keep priority readable in `ObservationHomeState` and visible only through hidden QA labels.
- Do not add visible body-accent copy until design confirms it improves "この子成長したな" more than it increases card density.

Result:

- Added no dependency and made no project-file or package-file changes.
- Reused SwiftUI local value state, Core catalog entries, and SnapshotTesting `.lines` coverage.
- Added a hidden priority summary proving `softTailTipGlint` remains selected before `crescentBelly`, with visible copy unchanged and write/mutation/Widget/discovery side effects disabled.
- Verified with Swift tests, generic iOS Simulator builds, the targeted iPhone 17 app-host snapshot test, and manual visual QA.

Future replacement point:

- If the ceremony grows beyond a few candidates, move the ordering into a Core policy type with explicit tests, but keep the authored UX priority visible in docs.

## Current Loop: Genome Variation Baseline Tail Tether Contract

Handwritten complexity:

- Luma's `softTetherDot` floating-tail accessory is a small handmade cue that should make the tail feel uniquely familiar without turning into a technical socket marker.

Apple framework candidate:

- SpriteKit remains the renderer for the existing hand-authored tail accessory.
- CoreImage is not useful because this loop does not generate texture, mask, glow, or noise.
- ModelIO, SceneKit, and RealityKit stay deferred because no TailBase asset, GLB/USD preview, or socket validation is being generated.

External library candidate:

- Existing SnapshotTesting `.lines` coverage can guard the semantic app-host metadata.
- No new package should be added for one already-visible accessory cue.

Decision:

- Add no dependency, no new visible pixels, and no generated assets.
- Add hidden Genome Variation QA coverage for Luma's already-visible `softTetherDot` baseline tail accessory.

Result:

- Added no dependency and made no renderer, package, or project-file changes.
- Reused existing SpriteKit handmade geometry and SnapshotTesting `.lines` coverage.
- Added hidden Genome Variation QA coverage for `tail:floatingRibbon`, `accessory:softTetherDot`, `visible:true`, `geometryGenerated:false`, and `assetOutputs:none`.
- Verified with Swift tests, generic iOS Simulator builds, the targeted iPhone 17 app-host snapshot test, and manual temporary-Simulator visual QA.

Future replacement point:

- If the floating TailBase moves into a reference-sheet or 3D asset lane, revisit ModelIO/SceneKit/RealityKit only for asset validation and keep the final silhouette tuning handmade.

## Current Loop: TailBase Floating Reference Handoff

Handwritten complexity:

- The accepted `floatingRibbon` + `softTetherDot` cue needs TailBase floating reference-sheet language before any modeler or asset pipeline can treat it as a fixed part.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain deferred because this loop has no GLB/USD candidate, no 3D preview, and no socket-validation runtime.
- SpriteKit remains the accepted 2D source of truth.

External library candidate:

- Existing SnapshotTesting `.lines` coverage can guard the metadata contract.
- No package should be added for reference-sheet vocabulary.

Decision:

- Add no dependency, no generated assets, no GLB/USD, and no renderer change.
- Add a metadata-only TailBase floating handoff that keeps asset production closed while naming sockets, rig target, panels, and accepted silhouette cues.

Result:

- Added no dependency and made no package or project-file changes.
- Kept ModelIO, SceneKit, and RealityKit deferred because no GLB/USD candidate exists yet.
- Added a Core/app metadata contract for `floatingRibbon|softTetherDot->TailBase.floating@tailRoot#accessoryCue`.
- Guarded the contract with Core tests, hidden Genome Variation QA labels, and SnapshotTesting `.lines` coverage.
- Verified the normal Genome Variation first viewport by manual temporary-Simulator visual QA; hidden metadata stayed hidden and the accepted tail cue remained visible.

Future replacement point:

- When a TailBase floating GLB/USD candidate exists, revisit ModelIO/SceneKit/RealityKit for import/export and socket validation, but keep this handoff as the affection and panel checklist.

## Current Loop: Growth Horn Crescent Bud Preview Host

Handwritten complexity:

- The existing `softCrescentBud` needs to read as a gentle grown horn-bud cue, not a sharp combat horn or a collectible rarity marker.

Apple framework candidate:

- SpriteKit remains the right tool because the shape is already handmade in the renderer and must stay adjustable by art direction.
- CoreImage is not useful because this loop does not generate procedural masks, glow, noise, or texture.
- ModelIO, SceneKit, and RealityKit remain deferred because no GLB/USD asset or socket-validation runtime is being introduced.

External library candidate:

- None. Existing app-host XCTest and manual Simulator visual QA can cover the new visible QA host without package churn.

Decision:

- Add no dependency, no generated assets, no package/project changes, and no normal player UI change.
- Add a QA-only crescent horn-bud fixture and launch surface so the accepted SpriteKit cue can be visually reviewed.

Result:

- Added no dependency and made no package or project-file changes.
- Reused the existing SpriteKit handmade `softCrescentBud` drawing.
- Added a QA-only adult crescent horn-bud fixture and launch surface.
- Verified the app-host metadata with XCTest and manually reviewed the visible Simulator surface.
- Adjusted the QA fixture discovery copy after visual QA so the adult horn-bud surface supports immersion instead of showing juvenile wording.

Future replacement point:

- If the crescent bud graduates into HornBase GLB/USD production, revisit ModelIO/SceneKit/RealityKit for asset validation only after the handmade SpriteKit silhouette remains accepted.

## Current Loop: Growth Ceremony Crescent Horn Memory Preview

Handwritten complexity:

- The adult `softCrescentBud` ceremony line is WiPet-specific affection copy. It must feel like noticing growth, not unlocking a horn upgrade.

Apple framework candidate:

- SwiftUI local state already owns preview acknowledgement without persistence.
- SpriteKit already owns the visible crescent bud.
- GameplayKit is not needed because no random planning or inheritance changes.
- CoreImage, ModelIO, SceneKit, and RealityKit are not needed because no texture, 3D asset, or socket validation is introduced.

External library candidate:

- None. Existing XCTest app-host coverage and manual Simulator visual QA are sufficient.

Decision:

- Add no dependency, no generated assets, no package/project changes, and no normal player UI change.
- Use the existing preview-only Growth Ceremony boundary to show the crescent horn memory only after acknowledgement.

Result:

- Added no dependency and made no package or project-file changes.
- Reused SwiftUI local state for the non-persistent acknowledgement preview.
- Added app-host coverage for the crescent horn memory line and side-effect boundaries.
- Added a QA-only acknowledged launch path for manual visual QA.
- Visual QA drove a compact-height layout adjustment so the acknowledged memory line fits without clipping the confirmation controls.

Future replacement point:

- If Growth Ceremony memory priority grows beyond horn, tail, and body cues, consider a small Core policy type before adding any external dependency.

## Current Loop: Growth Ceremony Selected Cue Comparison Copy

Handwritten complexity:

- The ceremony comparison line must feel like Luma is being observed directly; when the selected memory is `softCrescentBud`, the player should be invited to watch that soft horn-bud cue.

Apple framework candidate:

- SwiftUI value flow already carries the preview view model.
- GameplayKit is not relevant because no random, lineage, or mutation planning changes.
- CoreImage, ModelIO, SceneKit, and RealityKit are not relevant because no visual generation or asset validation changes.

External library candidate:

- None. This is authored copy and app-host coverage, not a reusable library problem.

Decision:

- Add no dependency, no generated assets, no package/project changes, and no persistence or Widget behavior changes.
- Keep the copy rule inside the preview view model until ceremony priority becomes broad enough for a Core policy.

Result:

- Added no dependency and made no package or project-file changes.
- Kept the copy authored by hand inside the preview view model.
- Added app-host coverage for the selected `softCrescentBud` comparison line.
- Verified the standard tail-glow ceremony remains unchanged and the crescent horn ceremony remains readable in manual Simulator QA.

Future replacement point:

- If multiple selected cues need authored comparison copy, extract a small Core copy policy with explicit tests before adding any external package.

## Current Loop: Growth Ceremony Crescent Horn Text Snapshot

Handwritten complexity:

- The crescent horn ceremony must preserve a very specific feeling: "I noticed this soft bud" rather than "I pressed a growth button." The test should guard copy, cue priority, and dry-run boundaries without freezing visual art direction too early.

Apple framework candidate:

- XCTest is already the right driver for the app-host ceremony state.
- SwiftUI local state already owns acknowledgement, and no GameplayKit, CoreImage, ModelIO, SceneKit, or RealityKit concern is involved.

External library candidate:

- Existing SnapshotTesting is already installed for app-target `.lines` and image references.
- `.lines` is the right minimal support here because it verifies semantic labels while avoiding a premature image reference.

Decision:

- Reuse existing SnapshotTesting `.lines`.
- Add no dependency, no generated assets, no package/project changes, and no normal player UI change.
- Keep SpriteKit drawing, Creature mutation, Widget handoff, persistence, and Growth Ceremony image references unchanged.

Result:

- Reused existing SnapshotTesting `.lines` for a crescent horn ceremony semantic guard.
- Added no dependency and made no package or project-file changes.
- Kept the image snapshot surface deferred until another manual art-direction pass accepts it.

Future replacement point:

- If the crescent horn ceremony visual is manually accepted after another Simulator pass, add an image snapshot in a separate small commit.

## Current Loop: Growth Ceremony Crescent Horn Image Snapshot

Handwritten complexity:

- The accepted crescent horn ceremony image must protect an emotional surface, not merely pixels: soft bud wording, readable before/after portraits, and a `Noticed` acknowledgement that stays preview-only.

Apple framework candidate:

- XCTest remains the app launcher and interaction driver.
- Simulator visual QA remains required because Apple frameworks cannot judge whether the ceremony feels affectionate.

External library candidate:

- Existing SnapshotTesting `.image` is already used by app-target ceremony references.
- No new visual regression package is justified; adding one would increase maintenance without improving this small acceptance guard.

Decision:

- Reuse existing SnapshotTesting `.image`.
- Add one accepted crescent horn ceremony app-target image reference after the semantic `.lines` guard.
- Add no dependency, no package/project change, no renderer change, no generated asset, no Widget handoff change, no persistence write, and no normal player UI change.

Result:

- Reused the existing SnapshotTesting `.image` support and added a single PNG reference for the crescent horn acknowledged ceremony.
- No dependency, package, or Xcode project file changed.
- Visual QA found that the longer crescent-horn copy could crowd the acknowledged card on iPhone SE; the UI now condenses helper summaries only when an acknowledged memory has compact or long comparison copy.
- The standard tail-glow ceremony snapshot still passes, so the support-library usage protects the new affectionate memory surface without broadening normal player behavior.

Future replacement point:

- If the crescent horn ceremony becomes a multi-step player-facing flow, keep this image as the first accepted preview-state reference and add interaction-specific snapshots separately.

## Current Loop: Genome Variation Sibling Body Shoulder Petals Contract

Handwritten complexity:

- Mira's `softShoulderPetals` are a handmade sibling-body accessory cue. The risk is losing a small affectionate identifier while expanding Genome Variation metadata, not needing a procedural renderer.

Apple framework candidate:

- SpriteKit remains the renderer for the accepted handmade petals.
- XCTest remains enough to query the QA-only hidden labels.
- CoreImage, ModelIO, SceneKit, and RealityKit do not apply because no texture, generated asset, mesh, socket runtime, or GLB/USD validation changes in this loop.

External library candidate:

- Existing SnapshotTesting `.lines` support is sufficient for a semantic guard.
- A new snapshot or visual-regression package would add maintenance without improving this small sibling-recognition contract.

Decision:

- Reuse XCTest and existing SnapshotTesting `.lines`.
- Add no dependency, no package/project change, no renderer change, no image reference, no generated asset, no Widget handoff change, no persistence write, and no normal player UI change.

Result:

- Reused the existing Genome Variation app-host XCTest and semantic SnapshotTesting `.lines` reference.
- Added no dependency, package, project-file, renderer, image-reference, generated-asset, Widget handoff, persistence, or normal player UI change.
- Protected Mira's `body:seedPetal` + `accessory:softShoulderPetals` sibling body accessory as visible, handmade, non-generated, and asset-output-free.
- Manual visual QA confirmed the first viewport still reads as a calm sibling portrait surface and the hidden metadata stays hidden.

Future replacement point:

- If shoulder petals become generated body accessories or part of a 3D Upper Body asset, evaluate ModelIO/SceneKit/RealityKit only after an accepted reference sheet candidate exists.

## Current Loop: Soft Shoulder Petals Reference-Sheet Panel Note

Handwritten complexity:

- The accepted `softShoulderPetals` cue needs future reference-sheet wording that preserves Mira's gentle sibling identity without making the cue a detachable item, rarity mark, or generated mesh.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain deferred because there is no GLB/USD, runtime socket validation, or 3D preview candidate in this loop.
- SpriteKit remains the source of truth for the accepted 2D shoulder petals.

External library candidate:

- None. Existing SnapshotTesting `.lines` coverage can guard the hidden metadata row.

Decision:

- Add a metadata/docs-only panel note.
- Add no dependency, package/project edit, renderer change, generated asset, image reference, Widget handoff, persistence write, or normal player UI change.

Result:

- Added the panel note through existing metadata and semantic `.lines` coverage.
- Added no dependency, package/project edit, renderer change, generated asset, image reference, Widget handoff, persistence write, or normal player UI change.
- Kept ModelIO, SceneKit, and RealityKit deferred until a real UpperBody sylphian reference sheet or mesh candidate needs socket/rig validation.

Future replacement point:

- Revisit ModelIO/SceneKit/RealityKit only when an actual UpperBody sylphian reference sheet or mesh candidate exists and needs socket/rig validation.

## Current Loop: Observation Portrait Genome Cue Accessibility

Handwritten complexity:

- ObservationHome currently renders genome-driven SpriteKit differences, but the portrait accessibility label can collapse the pet back into a generic phrase. The small handmade language should name the visible face/body/wing/tail cues warmly.

Apple framework candidate:

- SwiftUI accessibility is the correct standard framework for the player-facing description.
- SpriteKit remains the visual renderer; no SceneKit, RealityKit, CoreImage, or GameplayKit change is needed.

External library candidate:

- None. XCTest can inspect the accessibility label directly, and image SnapshotTesting is unnecessary because pixels do not change.

Decision:

- Add a SwiftUI accessibility-label helper and app-host XCTest assertion only.
- Add no dependency, package/project edit, renderer shape change, generated asset, image reference, Widget handoff, persistence write, or normal visible text change.

Result:

- Used SwiftUI accessibility and existing XCTest only.
- Kept SpriteKit pixels, normal visible text, Widget handoff, persistence, generated assets, package/project files, and image references unchanged.
- Confirmed the ObservationHome portrait now names Luma's specific genome cues and lineage echo rather than a generic form.

Future replacement point:

- If portrait accessibility expands into localized creature narration, move the cue wording into a small catalog/localization table; keep the SpriteKit renderer handmade.

## Current Loop: Widget Observation Window Accessibility Cue

Handwritten complexity:

- Widget observation copy needs to feel like a single quiet window into the current pet, not a pile of unrelated labels. The emotional wording remains WiPet-specific: current identity, mood, age, discovery memory, and family cue.

Apple framework candidate:

- SwiftUI accessibility is the right standard layer for the Widget view.
- WidgetKit stays unchanged because the existing snapshot/handoff data already contains the needed observation text.

External library candidate:

- None. Existing XCTest plus SnapshotTesting `.lines` can guard the semantic label without adding a dependency or touching package/project files.

Decision:

- Add a small Core text helper and reuse SwiftUI accessibility.
- Add no dependency, package/project edit, visible layout change, renderer change, generated asset, App Group schema change, or Widget handoff publish behavior change.

Result:

- Used SwiftUI accessibility and the existing SnapshotTesting `.lines` guard only.
- Added no dependency, package/project edit, visible layout change, renderer change, generated asset, App Group schema change, Widget handoff publish behavior change, or image reference.
- Confirmed the Widget observation window can read Luma's long ancestor memory without showing the compact family cue, while the short ancestor memory includes `Family line` as the displayed cue.

Future replacement point:

- If Widget accessibility expands into localized narration or species-specific prose, move the helper into a localization-backed creature narration catalog while keeping the Widget view thin.

## Current Loop: Observation Portrait Visible Genome Cue Line

Handwritten complexity:

- The new line is not generic metadata. It is affectionate creature-observation language that should help the player notice Luma's specific face/body/tail and family echo.

Apple framework candidate:

- SwiftUI text and accessibility are sufficient.
- SpriteKit remains the handmade renderer and does not need a new drawing framework for this loop.

External library candidate:

- None. Existing XCTest can guard the visible copy; manual visual QA covers layout.

Decision:

- Add one SwiftUI visible cue line derived from existing `CreatureRenderProfile` cue data.
- Add no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or image reference.

Result:

- Reused SwiftUI text/accessibility and existing app-host XCTest only.
- Added no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or image reference.
- Confirmed visual QA on iPhone SE that the visible cue line reads as a quiet observation note rather than a stats panel.

Future replacement point:

- If multiple surfaces need the same creature-observation wording, move the copy into a small localized cue catalog while keeping final wording art-directed by WiPet.

## Current Loop: Observation Creature Cue Catalog Refactor

Handwritten complexity:

- Creature cue wording is a WiPet art-direction surface. The catalog should preserve affectionate terms without turning them into generic metadata.

Apple framework candidate:

- SwiftUI remains the display/accessibility layer.
- Foundation/localization can be revisited when these strings need real localization across app and Widget targets.

External library candidate:

- None. A package would add maintenance cost without improving the creature wording.

Decision:

- Keep the catalog local to `ObservationHomeView.swift` to avoid an Xcode project-file edit in this loop.
- Add no dependency, package/project edit, renderer change, generated asset, Widget handoff change, persistence write, or image reference.

Result:

- Used a local handwritten `ObservationCreatureCueCatalog` for face/body/wing/tail/lineage wording.
- Reused the catalog from the visible ObservationHome cue line and the portrait accessibility label.
- Added no dependency, package/project edit, renderer change, generated asset, Widget handoff change, persistence write, or image reference.
- Confirmed visual QA that the normal ObservationHome portrait and cue line remain unchanged and readable.

Future replacement point:

- Promote the local catalog to a shared app file only when another app surface needs it; promote to Core/localization only when Widget or multi-language copy needs the same wording.

## Current Loop: Observation Home Mira Variation Host

Handwritten complexity:

- The work is fixture routing plus affectionate cue wording for a sibling pet. It should prove that Mira can be observed as "うちの子" in the same home composition, without turning the screen into a QA dashboard.

Apple framework candidate:

- SwiftUI launch routing and existing XCTest UI assertions are enough for this loop.
- SpriteKit remains the renderer; no SceneKit, RealityKit, CoreImage, GameplayKit, or ModelIO change is needed because the pet shapes already exist.

External library candidate:

- Existing SnapshotTesting remains available for app-host tests, but no new dependency or image assertion is needed.

Decision:

- Add a Mira-only ObservationHome snapshot-host launch argument and focused UI assertion.
- Add no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or reference image.

Result:

- Used SwiftUI launch routing, the existing ObservationHome view, existing SpriteKit rendering, and focused XCTest UI assertions only.
- Added no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or reference image.
- Visual QA initially found Mira's longer cue line truncating on iPhone SE; the fix stayed in SwiftUI layout by allowing the cue text to wrap vertically instead of adding a package or image baseline.
- Confirmed Mira's ordinary ObservationHome host now shows the soft feline face, seed-petal body, fairy winglets, fish-fin tail, and family echo without cutting off the affectionate cue language.

Future replacement point:

- If Mira becomes a selectable normal player pet, move fixture routing into real observation state selection and consider an intentional image baseline only after the visible multi-pet behavior is accepted.

## Current Loop: Observation Home Ori Ancestor Variation Host

Handwritten complexity:

- The work is fixture routing plus WiPet-specific ancestor cue wording. It should make Ori feel like a remembered family branch, not a random alternate skin.

Apple framework candidate:

- SwiftUI launch routing and existing XCTest UI assertions are enough for this loop.
- SpriteKit remains the renderer; no SceneKit, RealityKit, CoreImage, GameplayKit, or ModelIO change is needed because Ori already uses existing face/body/wing/tail genes and handmade renderer cues.

External library candidate:

- Existing SnapshotTesting remains available, but no new dependency or image assertion is needed.

Decision:

- Add an Ori-only ObservationHome snapshot-host launch argument and focused UI assertion.
- Add no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or reference image.

Result:

- Used SwiftUI launch routing, the existing ObservationHome view, existing SpriteKit rendering, and focused XCTest UI assertions only.
- Added no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or reference image.
- Confirmed Ori's ObservationHome host can show ancestor-facing soft deer, leaf belly, sprout-leaf winglet, leaf-sprout tail, and family echo wording without turning the screen into a technical QA dashboard.

Future replacement point:

- If ancestor pets become selectable in the normal player flow, move snapshot-host routing into a real local observation selection model and add an accepted image baseline only after the family-observation composition is stable.

## Current Loop: Observation Home Local Selection State Gate

Handwritten complexity:

- The work is a small local selection owner for ObservationHome: stable candidate IDs, a selected ID, and proof that QA selection does not mutate a creature, persist anything, or publish Widget handoff.

Apple framework candidate:

- SwiftUI state is enough for the local owner.
- SwiftData is intentionally deferred until the player-facing persistence rule exists.
- WidgetKit remains unchanged because snapshot-host selection must not publish a handoff.

External library candidate:

- None. A state-management or collections package would add maintenance cost without improving affection, lineage feeling, or testability for three handmade candidates.

Decision:

- Add the local selection state by hand inside the ObservationHome boundary and protect it with focused XCTest UI assertions.
- Add no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or normal visible picker.

Result:

- Used a small app-local `ObservationHomeSelectionOption` plus `ObservationHomeState` selected-ID resolution.
- Used existing SwiftUI state and XCTest UI assertions only.
- Added no dependency, package/project edit, renderer shape change, generated asset, Widget handoff change, persistence write, or normal visible picker.
- Confirmed visual QA that Mira can be selected from a Luma-origin local state host while preserving the quiet ObservationHome composition.

Future replacement point:

- When normal player selection is designed, pair this local owner with SwiftData persistence rules, Widget handoff timing, and a visible ceremony-like selection affordance rather than a raw collection picker.

## Current Loop: Observation Selection Widget Handoff Timing Gate

Handwritten complexity:

- The work is a timing policy for selected observation pets: selection is not the same as an observed moment, so selecting a family member must not immediately publish Widget handoff data.

Apple framework candidate:

- WidgetKit remains the eventual publish surface, but the current handoff coordinator already owns the actual Widget reload path.
- SwiftData is deferred until the player-facing selection persistence rule is designed.
- SwiftUI hidden probes and XCTest UI assertions are enough for this gate.

External library candidate:

- None. Timing policy is WiPet-specific experience design and should stay readable rather than become a generic state-machine dependency.

Decision:

- Add hidden ObservationHome selection handoff policy metadata by hand.
- Add no dependency, package/project edit, Widget payload schema change, App Group write, Widget reload, persistence write, visible UI change, or renderer change.

Result:

- Used existing SwiftUI state, hidden accessibility probes, and focused XCTest UI assertions only.
- Confirmed the selected observation pet can carry an explicit `publishOnSelection:false` policy without mutating `Creature`, writing App Group data, reloading WidgetKit, or changing the normal visible ObservationHome surface.
- Kept WidgetKit and SwiftData as future integration points rather than adding a premature dependency for a WiPet-specific timing rule.

Future replacement point:

- When normal selection UI exists, this policy should become the guard between a transient family selection and the first real observation moment that is allowed to publish Widget handoff.

## Current Loop: Observation Selection Moment Acknowledgement Gate

Handwritten complexity:

- The work is a small local acknowledgement gate: a selected family member is not publish-ready until the app has recorded that the player actually observed them.

Apple framework candidate:

- SwiftUI local state and XCTest UI assertions are sufficient for this QA-only gate.
- WidgetKit remains the eventual handoff surface, but this loop must not call reload or write App Group payloads.
- SwiftData is deferred until the normal selection memory should survive relaunch.

External library candidate:

- None. A state-machine or workflow dependency would not improve affection, lineage feeling, or testability for this two-flag boundary.

Decision:

- Add the acknowledgement gate by hand inside `ObservationHomeState`.
- Add no dependency, package/project edit, Widget payload schema change, App Group write, Widget reload, persistence write, visible UI change, or renderer change.

Result:

- Used SwiftUI local state, hidden accessibility probes, and focused XCTest UI assertions only.
- Confirmed that selected Mira becomes future-publish-ready only after an acknowledged local observation moment.
- Confirmed the acknowledged route still does not mutate `Creature`, persist data, write App Group payloads, reload WidgetKit, or change the visible ObservationHome composition.
- Kept WidgetKit and SwiftData deferred until the real publish/persistence contract is written.

Future replacement point:

- When the visible observation moment is designed, this local acknowledgement should become the final guard before Widget handoff and optional SwiftData persistence.

## Current Loop: Observation Selection Widget Payload Contract Preview

Handwritten complexity:

- The work is a payload contract preview for an acknowledged selected pet: schema version, App Group key, Widget kind, selected identity, and proof that no write or reload happens yet.

Apple framework candidate:

- Reuse the existing `WidgetPetObservationTransferPayload`, `WidgetPetObservation`, `WidgetSharedDataKeys`, and XCTest coverage.
- Keep WidgetKit reload and App Group `UserDefaults` write disabled in this loop.
- Keep SwiftData deferred until selected/last-observed persistence is designed.

External library candidate:

- None. The existing Codable payload and focused tests provide enough stability without adding schema or snapshot tooling.

Decision:

- Add the payload contract preview by hand as hidden ObservationHome metadata and Core tests.
- Add no dependency, package/project edit, payload schema change, App Group write, Widget reload, persistence write, visible UI change, or renderer change.

Result:

- Reused the existing Codable Widget payload schema, `WidgetPetObservation`, and `WidgetSharedDataKeys`.
- Confirmed acknowledged Mira produces schema v1 payload preview with the expected Widget key, Widget kind, identity, discovery, memory cue, and lineage cue.
- Confirmed unacknowledged selection keeps payload readiness false.
- Added no dependency, package/project edit, payload schema change, App Group write, Widget reload, persistence write, visible UI change, or renderer change.

Future replacement point:

- When the visible observation moment can publish, this preview should become the preflight contract for the real `WidgetCurrentObservationDataWriter` call and WidgetKit reload.

## Current Loop: Observation Selection Widget Publish Preflight

Handwritten complexity:

- The work is a final publish-preflight summary for an acknowledged selected pet: payload readiness, expected coordinator result, would-write/would-reload intent, and proof that snapshot-host QA still performs no App Group write or WidgetKit reload.

Apple framework candidate:

- Reuse the existing WidgetKit-facing `WidgetCurrentObservationHandoffResult`, `WidgetPetObservationTransferPayload`, `WidgetPetObservation`, and `WidgetSharedDataKeys`.
- Keep real WidgetKit reload and App Group `UserDefaults` write disabled in this loop.

External library candidate:

- None. Snapshot testing remains a good future candidate, but deterministic hidden XCTest probes are enough for this preflight boundary.

Decision:

- Add the publish preflight by hand as hidden ObservationHome metadata and focused app-host UI assertions.
- Add no dependency, package/project edit, payload schema change, App Group write, Widget reload, persistence write, visible UI change, or renderer change.

Future replacement point:

- When the visible observation moment is player-facing, this preflight should become the final guard before calling `WidgetCurrentObservationDataWriter` and requesting the WiPet Widget timeline reload.

Result:

- Reused the existing Widget coordinator result seam and Codable payload contract.
- Confirmed the unacknowledged route remains not publish-ready.
- Confirmed the acknowledged route can resolve to a concrete would-write/would-reload preflight while snapshot-host QA still performs no App Group write or WidgetKit reload.
- Added no dependency, package/project edit, payload schema change, persistence write, visible UI change, or renderer change.

Future replacement point:

- When the visible observation moment is designed, the preflight metadata should become an injectable app-host test seam around the real selected-observation Widget handoff call.

## Current Loop: SpriteKit Dragon Tail Soft Ridge Cue

Handwritten complexity:

- The work is a tiny dragon-tail silhouette accessory: metadata labels, a soft handmade SpriteKit ridge shape, and tests that preserve the no-generated-assets contract.

Apple framework candidate:

- SpriteKit remains the correct renderer because the cue is a small 2D part detail already expressed through `PartAssembler` and `CreatureRenderProfile`.
- ModelIO/SceneKit/RealityKit are deferred; this does not need GLB/USD or socket validation beyond the existing tail accessory contract.

External library candidate:

- None. A drawing or vector package would not improve affection, testability, or maintainability for three soft ovals on an existing tail path.

Decision:

- Add the dragon-tail cue by hand as `softDrakeRidge`.
- Add no dependency, package/project edit, persistence write, Widget reload, payload schema change, generated asset, GLB/USD, or 3D runtime loading.

Future replacement point:

- When fixed tail parts move to 3D, map `longDrake|softDrakeRidge` to a TailBase dragon accessory panel and preserve the same soft, non-sharp silhouette intent.

Result:

- Kept the implementation handmade in SpriteKit and added no dependency.
- Confirmed the library decision still holds: `softDrakeRidge` is WiPet-specific creature silhouette tuning, so a drawing package would reduce direct cuteness control without improving stability.
- Verified Core metadata and fixed-part reference summaries can carry the cue forward without generated assets, GLB/USD, ModelIO, SceneKit, RealityKit, or package/project edits.

Verification note:

- The contract and visual checks passed through Swift tests, app build, snapshot build-for-testing, hidden label assertions, and manual screenshot QA.
- The existing image snapshot still needs a pinned reference device contract; the temporary SE run failed only because screenshot geometry did not match the committed reference, and a temporary iPhone 16 Pro retry stalled silently in `test-without-building`.

Future replacement point:

- If handmade tail accessories become numerous enough to duplicate layout/math, introduce a tiny internal catalog/DSL first.
- Consider external snapshot tooling or a stricter simulator fixture only after the reference-device contract is stable; do not add a package solely to work around device mismatch.

## Current Loop: Guarded Xcode Build Helper

Handwritten complexity:

- The work is an operational shell wrapper: keep known WiPet `xcodebuild` invocations small, timeout-bound, and pointed at `/tmp` DerivedData while Xcode source-control git processes may churn in the background.

Apple framework candidate:

- Continue using `xcodebuild`; this is the canonical Apple build entry point for app, widget, and UI-test target verification.
- Keep simulator device-set management outside this helper so visual QA can explicitly choose temporary devices per loop.

External library candidate:

- None. A task runner or build orchestration package would add dependency and maintenance risk for a tiny local command wrapper.

Decision:

- Add a repo-local helper script under `tools/xcode/`.
- Add no Swift package, Xcode project edit, app code change, renderer change, Widget behavior change, reference snapshot update, or generated asset.

Future replacement point:

- If the helper grows beyond a few stable subcommands, convert it into a documented Swift command-line tool or Makefile target. Until then, keep it transparent shell so every build flag remains visible.

Result:

- Added the helper as transparent shell, not a package dependency.
- Confirmed the timeout guard terminates only the child `xcodebuild` during the current source-control stall.
- Kept product code, renderer code, Widget code, Xcode project files, Package.swift, and snapshot references unchanged.

Verification note:

- Core Swift tests still passed.
- The guarded Xcode build/list commands currently time out because the desktop Xcode source-control state is still stalling; the helper prevents those stalls from leaving live WiPet build processes.

## Current Loop: Fixed Part Dragon Tail Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit dragon-tail cue to future fixed-part TailBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `longDrake|softDrakeRidge->TailBase.dragon@tailRoot#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When TailBase dragon reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for socket validation and manual creature-art acceptance.

Result:

- Added Core/app metadata for the TailBase dragon handoff.
- Kept `softDrakeRidge` as handmade SpriteKit silhouette language and did not introduce ModelIO, SceneKit, RealityKit, or any external package.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- Swift tests passed with the new handoff contract.
- App source parsing passed for `CreatureRenderProfile`.

## Current Loop: Fixed Part Fish Tail Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit fish-tail cue to future fixed-part TailBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `fishFin|softForkFin->TailBase.fish@tailRoot#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When TailBase fish reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for socket validation and manual creature-art acceptance.

Result:

- Added the fish-tail handoff as Core/app metadata, not a dependency.
- Kept `fishFin` and `softForkFin` as handmade SpriteKit silhouette language so the fish tail remains cute, soft, and family-recognizable.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- Swift tests passed with the new handoff contract.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: Fixed Part Deer Face Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit deer-face cue to future fixed-part FaceBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `softDeer|softEarNubs->FaceBase.deer@headCenter#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When FaceBase deer reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for socket validation and manual creature-art acceptance.

Result:

- Added the deer-face handoff as Core/app metadata, not a dependency.
- Kept `softDeer` and `softEarNubs` as handmade SpriteKit silhouette language so the deer face stays soft, familial, and art-directable.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- `git diff --check` passed for the touched files.
- Swift tests passed with 415 tests.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: Fixed Part Feline Face Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit feline-face cue to future fixed-part FaceBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `softFeline|softEarTips->FaceBase.feline@headCenter#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When FaceBase feline reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for socket validation and manual creature-art acceptance.

Result:

- Added the feline-face handoff as Core/app metadata, not a dependency.
- Kept `softFeline` and `softEarTips` as handmade SpriteKit silhouette language so the feline face stays gentle, petal-eared, and art-directable.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- `git diff --check` passed for the touched files.
- Swift tests passed with 417 tests.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: SpriteKit Feline Soft Whisker Dots

Handwritten complexity:

- The work is one tiny feline-only cheek detail that should make the sibling portrait read as watchful and kitten-like without adding a new system or noisy markings.

Apple framework candidate:

- SpriteKit remains the implementation surface because the cue is a few hand-placed dots in the existing face accent node.
- CoreImage stays deferred; this is not a procedural texture, glow, mask, or generated pattern task.

External library candidate:

- None. A vector drawing package or catalog dependency would not improve affection, testability, or reversibility for one handmade cue.

Decision:

- Add `softWhiskerDots` with local SpriteKit drawing and fixed-part detail recipe metadata.
- Add no dependency, package/project edit, persistence write, Widget handoff change, generated asset, GLB/USD, or 3D runtime loading.

Future replacement point:

- If face detail cues multiply, introduce a tiny internal face-detail catalog before considering any external drawing dependency.

Result:

- Added `softWhiskerDots` with local SpriteKit drawing and fixed-part detail recipe metadata, not a dependency.
- Kept the cue tiny and symmetric so Mira's feline face feels more kitten-like while staying calm and readable in Genome Variation QA.
- Updated the Genome Variation semantic `.lines` reference and accepted image reference after visual QA.

Verification note:

- Swift tests, app source parsing, project-summary fallback, generic app build, and manual temporary-simulator visual QA passed.
- Snapshot target build-for-testing timed out after 180 seconds; the helper terminated child `xcodebuild`, so this remains an unresolved app-host build gate rather than hidden success.

## Current Loop: Genome Variation Visible Cue Restraint Gate

Handwritten complexity:

- The work is an affection-first gate that prevents Genome Variation from accumulating visible marks just because adding small SpriteKit details is easy.

Apple framework candidate:

- None. SpriteKit rendered the accepted cue, but no Apple framework should decide whether another visible cue has enough emotional value.
- SnapshotTesting remains the existing regression layer; this loop does not add or change dependencies.

External library candidate:

- None. This is a product/art-direction rule and should stay readable in Core tests and docs.

Decision:

- Add a Core metadata helper for `genomeVariationVisibleCueRestraint`.
- Add no dependency, package/project edit, renderer pixel change, persistence write, Widget handoff change, generated asset, GLB/USD, or 3D runtime loading.

Future replacement point:

- If visible cue decisions become frequent, promote this gate into a tiny internal creature-art acceptance checklist before considering snapshot or design-tool automation.

Result:

- Added `genomeVariationVisibleCueRestraint` as Core metadata and tests, not a dependency.
- Kept the accepted `softWhiskerDots` cue constrained to one visible change with manual QA and image reference evidence.
- Made `furtherVisibleCueBlocked:true` part of the contract so WiPet does not drift into decoration-by-accumulation.

Verification note:

- Swift tests passed with 419 tests.
- Project summary fallback passed.
- Visual QA was skipped because this loop changes no renderer pixels and only records restraint for the previously accepted visual cue.

## Current Loop: SpriteKit Plant Tail Soft Leaf Vein

Handwritten complexity:

- The work is one rounded plant-tail vein path that should make a plant-tailed pet feel more botanical and alive without becoming realistic or busy.

Apple framework candidate:

- SpriteKit remains the implementation surface because this is a tiny child shape in the existing renderer.
- CoreImage stays deferred; this is not a procedural mask, glow, or pattern-generation task.
- ModelIO, SceneKit, and RealityKit stay deferred because this loop does not touch 3D assets.

External library candidate:

- None. A vector drawing dependency would not improve affection or testability for one handmade cue.

Decision:

- Add `softLeafVein` with local SpriteKit drawing and Core metadata.
- Add no dependency, package/project edit, persistence write, Widget handoff change, generated asset, GLB/USD, or 3D runtime loading.

Future replacement point:

- If plant-tail details multiply, introduce a tiny internal tail accessory catalog/DSL before considering any external drawing dependency.

Result:

- Added `softLeafVein` with local SpriteKit drawing and Core metadata, not a dependency.
- Kept the cue small and rounded so Plant tail reads as a living leaf while staying cute and readable.
- Updated the semantic fixed-part accessory vocabulary but did not generate assets, write persistence, change Widget handoff, or touch Package/Xcode project files.

Verification note:

- Swift tests, app source parsing, project-summary fallback, generic app build, and manual temporary-simulator visual QA passed.
- Snapshot target build-for-testing timed out after 120 seconds; the helper terminated the child `xcodebuild`, so this is recorded as an unresolved app-host build gate rather than hidden success.

## Current Loop: Fixed Part Plant Tail Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit plant-tail cue to future fixed-part TailBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `leafSprout|softLeafVein->TailBase.plant@tailRoot#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When TailBase plant reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for socket validation and manual creature-art acceptance.

Result:

- Added the plant-tail handoff as Core/app metadata, not a dependency.
- Kept `leafSprout` and `softLeafVein` as handmade SpriteKit silhouette language so plant tails remain soft, botanical, and readable.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- Swift tests passed with the new handoff contract.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: Fixed Part Dragon Wing Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit dragon-wing cue to future fixed-part WingBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `wideSail|softWingTipClaw->WingBase.dragon@leftWingRoot+rightWingRoot#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When WingBase dragon reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for paired socket validation and manual creature-art acceptance.

Result:

- Added the dragon-wing handoff as Core/app metadata, not a dependency.
- Kept `wideSail` and `softWingTipClaw` as handmade SpriteKit silhouette language so dragon wings stay readable without becoming sharp or combat-coded.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- Swift tests passed with the new handoff contract.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: Fixed Part Fairy Wing Handoff

Handwritten complexity:

- The work is a deterministic metadata bridge from the accepted SpriteKit fairy-wing cue to future fixed-part WingBase asset planning.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit stay deferred. This loop does not generate, import, preview, or validate a GLB/USD asset.

External library candidate:

- None. A schema package is unnecessary for one closed-gate handoff summary.

Decision:

- Add a Core/app metadata helper for `leafPair|softWingTipPearl->WingBase.fairy@leftWingRoot+rightWingRoot#accessoryCue`.
- Add no dependency, package/project edit, generated asset, runtime loading, visible UI change, Widget behavior change, or persistence write.

Future replacement point:

- When WingBase fairy reference sheets or GLB/USD assets exist, this handoff becomes the checklist source for paired socket validation and manual creature-art acceptance.

Result:

- Added the fairy-wing handoff as Core/app metadata, not a dependency.
- Kept `leafPair` and `softWingTipPearl` as handmade SpriteKit silhouette language so Mira's winglets remain light, soft, and recognizable.
- Kept all asset gates closed: no generated mesh, no runtime loading, and `assetOutputs:none`.

Verification note:

- Swift tests passed with the new handoff contract.
- App source parsing passed for `CreatureRenderProfile`.
- Project summary fallback passed without invoking full `xcodebuild -list`.
- Simulator visual QA was skipped because the loop did not change visible UI, renderer output, Widget output, or snapshot references.

## Current Loop: Fixed Part Face Base Reference Evidence Handoff

Handwritten complexity:

- The work is a deterministic evidence-slot contract for the accepted Deer/Feline FaceBase SpriteKit cues, not a new face renderer or generated asset.
- The judgment is WiPet-specific: `softEarNubs` and `softEarTips` must stay secondary, gentle, and family-recognizable rather than becoming collectible ornaments.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for validating actual GLB/USD assets and socket previews.
- They are not useful in this loop because no PNG reference sheet, GLB, USD, mesh, texture, or runtime asset exists yet.

External library candidate:

- SnapshotTesting can later protect an accepted FaceBase reference sheet, but adding it now would mix visual infrastructure with a metadata-only gate.
- No package improves affection, stability, or testability for this closed evidence-slot contract.

Decision:

- Add a Core-only FaceBase reference evidence handoff summary/readiness helper for `softDeer+softEarNubs` and `softFeline+softEarTips`.
- Require future panels, `headCenter` socket, `head` rig target, manual 2D visual QA acceptance, and closed asset gates.
- Keep generated geometry, runtime loading, snapshot/reference acceptance, package/project files, Widget handoff, visible UI, SpriteKit drawing, PNGs, GLB/USD, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When a real FaceBase reference-sheet PNG exists, this helper becomes the checklist before SnapshotTesting reference acceptance and later ModelIO/SceneKit/RealityKit validation.

Result:

- Added a Core-only FaceBase reference evidence handoff helper for `softDeer+softEarNubs` and `softFeline+softEarTips`.
- Kept FaceBase cue judgment hand-authored so the accepted ear cues remain soft, secondary, and family-safe rather than package-driven or asset-generated.
- Kept all asset gates closed: evidence is unrecorded, geometry generation is false, snapshot/reference acceptance is false, runtime loading is false, and `assetOutputs:none`.

Verification note:

- `swift test --quiet` passed with 425 Swift tests.
- `tools/xcode/wipet-xcodebuild project-summary` passed through the read-only fallback and confirmed project/scheme metadata.
- `swift build --quiet` was attempted after tests but was interrupted after it stayed silent in dependency checkout `git status`; the prior Swift test run had already completed the package build and test gate.
- Simulator visual QA was skipped because the loop changed only Core metadata helpers, Core tests, and docs; no visible SwiftUI, SpriteKit, Widget, app-host surface, PNG, GLB, USD, or runtime asset changed.

## Current Loop: Genome Variation Visible Cue Set Stability Gate

Handwritten complexity:

- The work is an art-direction guard that keeps the accepted Genome Variation visible cue set stable after `softWhiskerDots`.
- The goal is not to add another visible mark, but to preserve the current "Mira feels like herself" reading without drifting into decoration accumulation.

Apple framework candidate:

- SpriteKit remains the handmade renderer, but this loop does not change pixels.
- SnapshotTesting already protects accepted references and remains useful as evidence; no new Apple framework is needed.

External library candidate:

- None. Whether the cue set feels affectionate and restrained is WiPet product/art judgment, not a package concern.

Decision:

- Add a Core-only visible cue set stability summary/readiness helper that requires the existing silhouette cue-set acceptance and visible cue restraint gates to be ready.
- Require the accepted image reference to stay named, no new visible cues to be authorized, future visible work to require manual art review, no dependency, no app behavior change, and `assetOutputs:none`.
- Keep SpriteKit drawing, visible UI, Widget handoff, persistence, package/project files, generated assets, GLB/USD, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- If a future visible cue has a stronger affection reason than `softWhiskerDots`, this stability gate should be updated only after manual visual QA and image/reference evidence are refreshed in the same loop.

Result:

- Added a Core-only Genome Variation visible cue set stability helper that ties the accepted silhouette cue-set gate to the visible cue restraint gate.
- Kept authorized new visible cues at `0` so the current accepted pet variation remains stable until a stronger affection reason and fresh manual review exist.
- Kept SpriteKit pixels, visible UI, Widget handoff, persistence, package/project files, generated assets, GLB/USD, and runtime asset loading unchanged.

Verification note:

- `swift test --quiet` passed with 427 Swift tests.
- `tools/xcode/wipet-xcodebuild project-summary` passed through the read-only fallback and confirmed project/scheme metadata.
- `git diff --check` passed for the touched files.
- Simulator visual QA was skipped because this loop changed only Core metadata helpers, Core tests, and docs; no visible SwiftUI, SpriteKit, Widget, app-host surface, PNG, GLB, USD, or runtime asset changed.

## Current Loop: Growth Ceremony Widget Handoff Preflight Contract

Handwritten complexity:

- The work is a boundary contract: Growth Ceremony requires Widget handoff preparation before a real growth commit, but preview must not publish Widget data.
- The language must protect "I noticed this change" as a local ceremony moment rather than a hidden growth/Widget execution path.

Apple framework candidate:

- WidgetKit remains the eventual reload surface, but the current loop must not call WidgetKit or write App Group data.
- SwiftUI and the existing Core Widget payload schema are enough for this preflight contract.

External library candidate:

- None. A workflow/state-machine package would not improve affection or safety for a small dry-run handoff boundary.

Decision:

- Add a Core-only `GrowthCeremonyWidgetHandoffPreflightContract`.
- Require the existing Growth Ceremony plan to include `widgetHandoff`, the persistence boundary to be a safe dry run, the Widget payload schema/key/kind to be known, and preview write/reload/publish flags to remain false.
- Keep normal Observation UI, WidgetKit reloads, App Group writes, Creature mutation, `advanceGrowthStage()`, persistence, discovery append, generated assets, package/project files, and visible copy unchanged.

Future replacement point:

- When a commit-capable Growth Ceremony exists, this preflight should become the final checked gate before `WidgetCurrentObservationDataWriter` and WidgetKit timeline reload are allowed.

Result:

- Added a Core-only `GrowthCeremonyWidgetHandoffPreflightContract`.
- Required the Growth Ceremony plan to include `widgetHandoff`, the persistence boundary to remain a safe dry run, and the Widget payload schema/key/kind to match the current Core Widget handoff contract.
- Kept preview behavior closed: `write:false`, `reload:false`, `publish:false`, no Creature mutation, no discovery append, no persistence write, and no WidgetKit call.

Verification note:

- `swift test --quiet` passed with 429 Swift tests.
- `tools/xcode/wipet-xcodebuild project-summary` passed through the read-only fallback and confirmed project/scheme metadata.
- `git diff --check` passed for the touched files.
- Simulator visual QA was skipped because this loop changed only Core contracts, Core tests, and docs; no visible SwiftUI, SpriteKit, Widget, app-host surface, App Group write, WidgetKit reload, PNG, GLB, USD, or runtime asset changed.

## Current Loop: Growth Ceremony Widget Handoff Preflight App Bridge

Handwritten complexity:

- The work is a hidden ObservationHome bridge for the Widget preflight contract so app-host QA can prove the preview is prepared but still cannot publish.
- The visible ceremony should remain a quiet observation moment, not a Widget handoff status panel.

Apple framework candidate:

- SwiftUI hidden accessibility probes are enough for the app-host bridge.
- WidgetKit remains intentionally unused because preview must not reload Widget timelines.

External library candidate:

- Existing SnapshotTesting `.lines` references are enough for semantic regression; no dependency change is needed.

Decision:

- Expose `growthWidgetHandoffPreflightSummary` and readiness through `ObservationHomeState` and hidden `ObservationHomeView` probes.
- Extend Growth Ceremony text references/app-host assertions with the preflight line.
- Keep visible UI, WidgetKit reloads, App Group writes, Creature mutation, `advanceGrowthStage()`, persistence, discovery append, generated assets, package/project files, and image references unchanged.

Future replacement point:

- When Growth Ceremony becomes commit-capable, this hidden bridge should become the app-host seam that proves the real Widget handoff call is only enabled after persistence and discovery gates open.

Verification note:

- `swift test --quiet` passed 429 Core tests.
- `xcodebuild -quiet ... -scheme WiPet ... build` passed with `/tmp/WiPetGrowthWidgetPreflightAppBridgeAppBuildDerived`.
- `xcodebuild -quiet ... -scheme WiPetSnapshotTests ... build` passed with the same `/tmp` DerivedData path.
- Direct Simulator UI test execution on iPhone 17 confirmed `growthWidgetHandoffPreflightSummary` and readiness labels exist before acknowledgement.
- Full target UI test execution did not complete after the external SSD/XCTestDevices migration: the first attempt failed on an acknowledgement button visibility/tap issue, which was addressed by making the test scroll before tapping; follow-up `xcodebuild test` attempts then slept in the Xcode test runner before producing test output. No app-visible UI or Widget publish path was changed.

## Current Loop: SpriteKit Growth Stage Cue Observation Bridge

Handwritten complexity:

- The renderer already applies `growthStageCue.bodyScale` to the pet body, but normal ObservationHome QA cannot directly prove which stage cue is currently driving the visible portrait.
- The player-facing value is "この子成長したな"; the metadata must stay hidden and must not turn the observation screen into a technical stage panel.

Apple framework candidate:

- SpriteKit remains the correct renderer because the visible body scale is already implemented through the handmade creature node.
- SwiftUI hidden accessibility probes are enough to expose the current cue to app-host visual QA.

External library candidate:

- Existing SnapshotTesting and XCTest probes are sufficient. No new dependency is justified for a metadata bridge around an existing SpriteKit cue.

Decision:

- Expose the normal observation `spriteKitGrowthStageCueSummary` and readiness through `ObservationHomeState` and a hidden `ObservationHomeView` probe.
- Add app-host assertions for the current Luma cue: `stage:juvenile`, `scale:familiar`, `posture:soft`, and `assetOutputs:none`.
- Keep `PartAssembler`, SpriteKit pixels, Creature mutation, Widget handoff, persistence, package/project files, generated assets, GLB/USD, and visible UI unchanged.

Future replacement point:

- When growth ceremony becomes a player-visible ceremony, this bridge can prove the before/after portrait uses current vs next stage cues without exposing raw metadata to the player.

Verification note:

- `swift test --quiet` passed 429 Core tests.
- `git diff --check` passed for the touched files.
- `tools/xcode/wipet-xcodebuild project-summary` passed project and shared scheme lint.
- `xcrun swiftc -parse ... ObservationHomeView.swift` passed against the iPhone Simulator SDK for the app/core renderer files touched by the bridge.
- `tools/xcode/wipet-xcodebuild app-build` timed out after 120 seconds while `xcodebuild` slept after the external SSD/XCTestDevices migration. No compiler diagnostics were emitted before timeout.
- Visual QA scope: hidden metadata only. Visible SpriteKit pixels, layout, copy, Widget handoff, persistence, and image references were intentionally unchanged.

## Current Loop: Growth Ceremony Before After Stage Cue Pair

Handwritten complexity:

- Growth Ceremony preview already compares current and next portraits, but the QA metadata only exposes short scale labels (`familiar` to `grown`).
- The player-facing feeling should be "この子成長したな"; hidden QA should prove the current and next SpriteKit stage cues are paired without exposing technical labels.

Apple framework candidate:

- Swift structs and SwiftUI hidden probes are enough. SpriteKit remains unchanged because it already renders stage scale through `CreatureNode`.

External library candidate:

- No external library improves this small contract. SnapshotTesting/XCTest can assert the string once the app-host runner is stable.

Decision:

- Add a Core `growthBeforeAfterStageCuePair` metadata summary/readiness helper.
- Expose the pair from `ObservationHomeState` only when a Growth Ceremony preview exists.
- Assert the preview pair in app-host tests: current `juvenile/familiar/soft`, next `adult/grown/settled`, `previewOnly:true`, `mutation:false`, `assetOutputs:none`.
- Keep visible UI, SpriteKit drawing, Creature mutation, Widget handoff, persistence, package/project files, generated assets, GLB/USD, and image references unchanged.

Future replacement point:

- When the ceremony becomes commit-capable, this pair should remain the dry-run proof that the before/after view is observational until the player confirms.

Verification note:

- `swift test --quiet` passed 431 Core tests after one retry. The first attempt failed because `Tests/WiPetCoreTests/CreatureTests.swift` was modified during the build.
- `git diff --check` passed for the touched files.
- `tools/xcode/wipet-xcodebuild project-summary` passed project and shared scheme lint.
- `xcrun swiftc -parse ... ObservationHomeView.swift` passed against the iPhone Simulator SDK for the app/core renderer files touched by the bridge.
- `WIPET_DERIVED_DATA_PATH=/tmp/WiPetDerivedData WIPET_XCODEBUILD_TIMEOUT_SECONDS=300 tools/xcode/wipet-xcodebuild snapshot-build` passed.
- Visual QA scope: the hidden `growthBeforeAfterStageCuePairSummary` / readiness labels were added to the Growth Ceremony app-host test and `.lines` references. Direct `xcodebuild test-without-building` for the one UI test started on the booted iPhone 17 simulator, but the Xcode runner did not finish log finalization and was stopped after waiting. No visible UI, SpriteKit pixels, Widget publish path, persistence, generated assets, or package/project files changed.

## Current Loop: Growth Ceremony App Host QA Recovery

Handwritten complexity:

- The remaining risk is not creature drawing; it is proving the existing Growth Ceremony hidden labels can be read through the app-host runner after the XCTestDevices external SSD move.
- SpriteKit visible cue additions are intentionally restrained because the accepted Genome Variation cue set already has a stability gate.

Apple framework candidate:

- XCTest/XCUITest and Xcode's `test-without-building` remain the correct verification rail.
- SpriteKit, WidgetKit, SwiftData, GameplayKit, CoreImage, ModelIO, SceneKit, and RealityKit should not be touched for a runner recovery check.

External library candidate:

- None. SnapshotTesting `.lines` references and the existing app-host test are already present; adding a package would not improve affection, lineage feeling, or runner stability.

Decision:

- Rebuild the SnapshotTests target into `/tmp` DerivedData and rerun the single Growth Ceremony app-host test with the existing hidden-label assertions.
- Keep visible UI, SpriteKit drawing, Creature mutation, Widget handoff, persistence, generated assets, package/project files, and image references unchanged unless the test exposes a real product bug.

Future replacement point:

- If app-host UI tests keep hanging in Xcode log finalization, add a dedicated QA runner note or helper script in a separate loop instead of mixing test-infrastructure changes with creature or ceremony behavior.

Verification note:

- Rebuilt `WiPetSnapshotTests` into `/tmp/WiPetDerivedData`; build-for-testing passed.
- First `test-without-building` attempt without `-resultBundlePath` again started writing diagnostics under the default Xcode DerivedData logs, so it was stopped to avoid growing the home developer directory.
- Re-running with `-resultBundlePath /tmp/WiPetGrowthCeremonyAppHostQA-*.xcresult` made the runner return concrete failures instead of hanging.
- The failure was QA-only: the Growth Ceremony acknowledgement button existed and all preview hidden labels were readable, but XCUITest could not mark the bottom-edge SwiftUI button as hittable on iPhone 17.
- Added an app-host test helper that scrolls and, when necessary, taps the visible `Notice together` label by coordinate. This keeps the product UI unchanged while allowing the preview-only acknowledgement path to be verified.
- Targeted visual/app-host QA passed: `xcodebuild test-without-building ... -only-testing:WiPetSnapshotTests/SnapshotHostGenomeVariationTests/testGrowthCeremonyPreviewProtectsVisibleDryRunSurface -resultBundlePath /tmp/WiPetGrowthCeremonyAppHostQA-Coordinate-20260627085308.xcresult -derivedDataPath /tmp/WiPetDerivedData`.
- `swift test --quiet` passed 431 Core tests.
- `git diff --check` passed for the touched files.
- `tools/xcode/wipet-xcodebuild project-summary` passed project and shared scheme lint.

## Current Loop: Growth Ceremony Continuity Line

Handwritten complexity:

- Growth Ceremony needs one affectionate line that says the grown form is still "うちの子", not a technical stage transition or reward claim.
- The copy must stay preview-only and must not imply that growth has already committed, mutated the creature, written persistence, appended discovery, or published Widget data.

Apple framework candidate:

- Swift value types and SwiftUI text rendering are enough for this slice.
- WidgetKit, SwiftData, SpriteKit drawing, GameplayKit, CoreImage, ModelIO, SceneKit, and RealityKit do not improve a single authored continuity line.

External library candidate:

- None. Copy tone and ceremony pacing are WiPet's expressive core and should not be outsourced.

Decision:

- Add a tiny Core `GrowthCeremonyContinuityLineCopy` contract with summary/readiness coverage.
- Render the line in the existing preview-only Growth Ceremony teaser band and protect it in the app-host `.lines` snapshot.
- Keep SpriteKit drawing, normal UI entry, Creature mutation, `advanceGrowthStage()`, Widget handoff, persistence, generated assets, package/project files, and image references unchanged.

Future replacement point:

- If Growth Ceremony becomes commit-capable, this line should remain the emotional bridge before confirmation while a separate persistence-boundary contract controls real writes.

Verification note:

- Added the dependency-free `GrowthCeremonyContinuityLineCopy` contract and Core tests.
- Added the line to the preview-only Observation teaser and the app-host `.lines` snapshot.
- Added a QA-only acknowledged launch route for the same Luma Growth Ceremony preview so visual/app-host QA can verify the post-notice surface without depending on an unstable bottom-edge XCUITest tap.
- No library was added. No package/project settings changed.
- Passed `swift test --quiet` with 433 tests.
- Passed iOS parse, project summary, diff check, `/tmp` snapshot build, and targeted app-host visual QA with `/tmp` result bundles.

## Current Loop: Genome Variation Ancestor Plant Portrait

Handwritten complexity:

- The next visible pet value is not another random mark. It is letting the player see that the child draft's deer face comes from a specific, soft plantlike ancestor.
- The existing Ori fixture already carries `verdant` body, Plant wing, and Plant tail genes. Showing Ori in Genome Variation QA makes the existing handmade `leafShoulderNubs` and `softLeafVein` cues visible in context.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is a small handmade portrait composed from existing `CreatureRenderProfile` and `PartAssembler` recipes.
- SwiftUI is enough to place a compact ancestor memory strip in the QA surface.
- CoreImage, ModelIO, SceneKit, RealityKit, GameplayKit changes, and external drawing libraries do not improve this slice.

External library candidate:

- None. The affection value is art direction and lineage context, not image processing or layout math.

Decision:

- Add a small Genome Variation QA ancestor memory portrait for Ori using existing SpriteKit rendering.
- Expose hidden metadata for Ori's plant body/tail accessory cues and protect it in the app-host `.lines` reference.
- Keep normal Observation UI, Widget handoff, persistence, generated assets, package/project files, GLB/USD, and runtime asset loading unchanged.

Future replacement point:

- When the Lineage family tree becomes a player-facing surface, this ancestor portrait should move from QA into the family-memory UI instead of becoming another collection tile.

Verification note:

- Implemented the ancestor portrait with existing SpriteKit and SwiftUI only.
- No GameplayKit, CoreImage, ModelIO, SceneKit, RealityKit, external drawing library, package dependency, or Xcode project edit was added.
- The manual complexity stayed in WiPet's expressive core: choosing Ori as a readable ancestor memory and keeping the plant body/tail cues soft rather than random.
- Passed SwiftPM tests, iOS parse, diff check, and explicit iPhone 17 Simulator `build-for-testing` using `/tmp/WiPetDerivedData`.
- Visual QA passed on the snapshot-host Genome Variation screen. The small Ori portrait makes the child draft's deer-face echo feel inherited instead of arbitrary.
- Targeted app-host `test-without-building` remains blocked by Xcode worker/log finalization after Simulator migration. This is a QA infrastructure issue, not a reason to add a library to the renderer.

Future replacement point:

- Before the next UI-test-heavy loop, refresh XcodeBuildMCP session defaults or add a tiny documented runner that always uses an available Simulator and `/tmp` result bundles.

## Current Loop: Snapshot Test Runner Guardrail

Handwritten complexity:

- App-host tests need a repeatable local command that does not inherit stale XcodeBuildMCP simulator IDs and does not write result bundles into the default home DerivedData logs.
- The helper only needs to select an available Simulator, locate the built `.xctestrun`, write result bundles under `/tmp`, and let the existing timeout guard stop silent `xcodebuild` stalls.

Apple framework candidate:

- XCTest and `xcodebuild test-without-building` are still the correct runner for app-host QA.
- `xcrun simctl list devices --json` is enough to discover available Simulators without a new dependency.
- A concrete available Simulator destination is preferable to `generic/platform=iOS Simulator` for local snapshot builds after Simulator data migration.

External library candidate:

- None. This is local shell orchestration, not visual regression logic, graph layout, genome mutation, image processing, or a player-facing system.

Decision:

- Add a narrow `snapshot-test` command to `tools/xcode/wipet-xcodebuild`.
- Make `snapshot-build` use the same available Simulator resolution by default.
- Do not add a Swift Package, do not edit the Xcode project, and do not alter SnapshotTesting references in this infrastructure loop.

Future replacement point:

- If app-host testing remains flaky after the runner guardrail, investigate Simulator/device service health or refresh XcodeBuildMCP profiles in a separate loop.

Verification note:

- Implemented the guardrail as shell orchestration over Apple `xcodebuild`, XCTest, and `simctl`.
- No Swift Package, Xcode project edit, SnapshotTesting reference change, app behavior change, or visual asset change was introduced.
- Dry-run verification proves both `snapshot-build` and `snapshot-test` now resolve the available iPhone 17 Simulator and `/tmp` paths before launching Xcode.
- A real snapshot build still stalled inside Xcode after migration, but the helper timeout terminated the child process. This confirms the guardrail value while keeping the remaining environment issue separate from WiPet product work.

## Current Loop: Lineage Ancestor Portrait Memory Card Contract

Handwritten complexity:

- The next lineage step is not a graph algorithm yet. It is the wording and safety boundary for a small ancestor portrait memory card that can later sit inside the family tree.
- The card should make Ori's portrait feel like a remembered ancestor while hiding seeds, raw randomness, breeding controls, optimization, persistence, and Widget publication.

Apple framework candidate:

- Existing GameplayKit planning remains the deterministic source through `LineageGenomePreview`.
- Swift value types and tests are enough for the copy contract.

External library candidate:

- None. Graph/tree layout libraries should wait until the actual family tree layout is being built.

Decision:

- Add a dependency-free Core contract layered on the existing GameplayKit-backed family echo copy.
- Do not add packages, do not edit Xcode project files, and do not touch renderer/UI surfaces in this loop.

Future replacement point:

- When the family tree becomes visual, this contract can feed a SwiftUI card or graph node; graph layout libraries can be reconsidered then.

Verification note:

- Implemented `LineageAncestorPortraitMemoryCardCopy` without adding dependencies.
- Existing GameplayKit-backed lineage preview remains the deterministic source through the family echo copy; the new card adds no random path.
- SwiftPM tests passed with the updated text snapshot.
- Visual QA is intentionally deferred because no rendered UI changed.

## Current Loop: CommonPetRig Socket Map Core Contract

Handwritten complexity:

- Fixed-part socket rules are currently protected through string summaries and docs. Before GLB/USD work starts, the project needs a typed Core map that makes each socket and rig target predictable.
- This protects future modeling handoff without creating geometry or changing SpriteKit rendering.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for validating real assets and previews.
- They are not useful yet because there is no accepted GLB/USD/reference sheet artifact to inspect.

External library candidate:

- None. A dependency would not improve a small static socket map.

Decision:

- Add a dependency-free Core `CommonPetRigSocketMap` with typed socket and rig ids.
- Keep asset import/export frameworks, package files, Xcode project files, renderer code, and generated assets unchanged.

Future replacement point:

- When the first GLB/USD or accepted reference sheet exists, use this map as the validation source for ModelIO plus SceneKit or RealityKit.

Verification note:

- Implemented `CommonPetRigSocketMap` as a dependency-free Core type.
- The contract names Face/UpperBody/Wing/Tail sockets and rig targets without generating geometry or claiming 3D validation.
- SwiftPM tests and Core parse passed.
- ModelIO, SceneKit, and RealityKit remain deferred because no GLB/USD/reference artifact exists in this loop.

## Current Loop: CommonPetRig Asset Validation Preflight

Handwritten complexity:

- The project now has a typed `CommonPetRigSocketMap`, but future asset validation still needs a small gate that says when ModelIO, SceneKit, or RealityKit are allowed to participate.
- The gate must keep WiPet's handmade cuteness contract intact: no generated geometry, no runtime asset loading, no GLB/USD output claim, and no validation claim until a real accepted reference sheet or asset candidate exists.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit are the right future Apple-framework candidates for GLB/USD import, socket preview, and fixed-part validation.
- They are not adopted in this loop because there is no accepted PNG reference sheet, GLB, USD, or socket-preview asset to validate.

External library candidate:

- None. External 3D or graph packages would increase project risk without improving affection, lineage resemblance, or testability for this preflight.

Decision:

- Add a dependency-free Core `CommonPetRigAssetValidationPreflight` layered on `CommonPetRigSocketMap`.
- Require the socket map to be ready, require a real reference artifact or asset candidate before validation can be allowed, and keep every Apple 3D framework flag disabled by default.
- Do not edit `Package.swift`, Xcode project files, renderer code, Widget behavior, generated assets, or snapshot references.

Future replacement point:

- When a manually accepted reference sheet or GLB/USD candidate exists, this preflight can be reopened to allow ModelIO import first, then SceneKit or RealityKit preview in a separate small loop.

Verification note:

- Implemented `CommonPetRigAssetValidationPreflight` without adding dependencies.
- The default state is safely deferred: no accepted artifact, no asset candidate, no ModelIO/SceneKit/RealityKit usage, no generated geometry, no runtime loading, and `assetOutputs:none`.
- Validation becomes allowed only after artifact evidence exists and ModelIO is explicitly enabled, while runtime loading, generated geometry, and output claims remain blocked.
- SwiftPM tests and Core parse passed.
- Visual QA is intentionally not applicable because this loop changes only a Core asset-validation preflight contract.

## Current Loop: Genome Variation Ancestor Cue Label

Handwritten complexity:

- `GenomeVariationQAView` already shows Ori's small ancestor portrait beside the child draft, but the visible label only says `Ori`.
- The next affection gain is not another renderer primitive; it is a short visible cue that tells the reviewer which inherited resemblance to look for without exposing seeds, raw randomness, breeding controls, or stats.

Apple framework candidate:

- SwiftUI is the right layer for the small cue label because the portrait card already owns the layout and copy.
- SpriteKit remains the creature renderer, but no new SpriteKit node is needed for this copy-only cue.

External library candidate:

- None. Existing SnapshotTesting/XCTest app-host `.lines` coverage is enough for the semantic contract, and adding a UI or graph package would not increase affection.

Decision:

- Add a tiny SwiftUI cue label under Ori's ancestor portrait in `GenomeVariationQAView`.
- Add a hidden app-host probe for the same line so the existing snapshot host can assert it.
- Keep `PartAssembler`, `CreatureNode`, SpriteKit pixels, Widget handoff, persistence, packages, project files, generated assets, GLB/USD, and image references unchanged.

Future replacement point:

- When this graduates from QA to a player-facing family tree, the same cue line should be fed by the Core `LineageAncestorPortraitMemoryCardCopy` contract rather than hard-coded QA copy.

Verification note:

- Implemented the cue with SwiftUI only; `PartAssembler`, SpriteKit drawing, Widget handoff, persistence, packages, project files, generated assets, GLB/USD, and image references remain unchanged.
- SwiftPM tests passed.
- `git diff --check` passed for the touched files.
- Xcode `snapshot-build` passed using `/tmp/WiPetGenomeAncestorCueBuildDerived`.
- Targeted app-host visual QA passed with `snapshot-test` for `testGenomeVariationSnapshotHostExposesTargetEntryReadiness`, proving the visible cue label, the `.lines` reference, and the existing Genome Variation image reference still agree.
- The loop had to recover `.git/HEAD` after it became `dataless`; no source or user-staged file was rewritten for that recovery.

## Current Loop: Observation Axolotl Face Variation Host

Handwritten complexity:

- The renderer already has a handmade `wideAxolotl` face with `sideCheekDots`, but no current observation host lets QA see that face base as a distinct pet.
- The task is not to add a new drawing algorithm; it is to expose an existing cute face difference as a small observation fixture so "this child looks different" becomes reviewable.

Apple framework candidate:

- SpriteKit remains the right renderer because the cue is already handmade in `PartAssembler`.
- SwiftUI remains the right host layer because `ObservationHomeView` already exposes portrait accessibility and cue-line contracts.

External library candidate:

- None. SnapshotTesting/XCTest already cover app-host semantic and visual gates. CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, and package changes are unnecessary.

Decision:

- Add a small `PreviewFixtures.axolotlFriend` fixture and a snapshot-host launch route.
- Assert its ObservationHome portrait and cue line through the existing app-host test target.
- Keep `PartAssembler`, `CreatureNode`, renderer geometry, Widget handoff, persistence, generated assets, package/project files, GLB/USD, and image references unchanged.

Future replacement point:

- If this face becomes part of family-memory UI, route the cue through lineage copy contracts instead of adding more QA-only launch arguments.

Verification note:

- Implemented the axolotl host with the existing SwiftUI ObservationHome shell and handmade SpriteKit renderer.
- No package, project, CoreImage, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, Xcode `snapshot-build`, and targeted app-host visual QA passed.
- The app-host test proves the portrait and cue line expose `wide axolotl face`, `water drop body`, `soft bell winglets`, and `fish fin tail`.

## Current Loop: Lineage Ancestor Memory Card Surface

Handwritten complexity:

- The Core contract already describes an ancestor portrait memory card, but the LineageFamily QA surface does not yet show it.
- The work is emotional copy and quiet layout: make "Ori's soft deer-face echo is remembered here" visible without turning the family surface into a stats panel, breeding tool, or persistence path.

Apple framework candidate:

- SwiftUI is the right layer because the LineageFamily QA surface already owns the family portrait and read-only review stack.
- SpriteKit remains unchanged; the task does not require new creature drawing, physics, animation, or texture generation.

External library candidate:

- Graph/tree layout libraries remain deferred. The current surface has one ancestor card and two child portraits, so a dependency would not improve affection, stability, or testability.
- Existing SnapshotTesting/XCTest app-host coverage is sufficient for the semantic visual QA gate.

Decision:

- Reuse `LineageAncestorPortraitMemoryCardCopy` in `LineageFamilyQAView`.
- Add no package, project, graph layout, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, or generated asset changes.
- Keep the surface read-only: no seed details, random details, breeding controls, optimization controls, persistence writes, Widget handoff, or player-facing route.

Future replacement point:

- When a larger family tree arrives, reconsider a deterministic graph/tree layout helper only after manual layout cannot keep ancestor resemblance readable.

Verification note:

- Implemented the Lineage ancestor memory card with the existing SwiftUI QA surface and Core `LineageAncestorPortraitMemoryCardCopy`.
- No package, project, graph layout, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, project/scheme lint, Xcode `snapshot-build`, and targeted app-host visual QA passed.
- The app-host test proves the `Ori portrait` memory card surfaces `fairy winglets` and `soft deer-face echo` while remaining read-only with seed/random, persistence, breeding, optimization, Widget handoff, and player-facing routes disabled.

## Current Loop: SpriteKit Face Lineage Echo Cue

Handwritten complexity:

- The renderer already shows ancestry on the body and tail, but the face is where affection is felt first.
- The task is a tiny handmade forehead-memory mark that appears only when a creature has inherited resemblance discovery, without turning lineage into raw random metadata.

Apple framework candidate:

- SpriteKit remains the correct renderer because the cue is a small hand-tuned `SKShapeNode` detail.
- SwiftUI remains only the host/probe layer for visual QA.

External library candidate:

- None. CoreImage pattern generation and external drawing/snapshot packages are deferred; they would not improve this small forehead cue.

Decision:

- Add a dependency-free SpriteKit forehead lineage cue and a small Core metadata formatter.
- Do not add packages, project edits, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence changes, generated assets, GLB/USD, or image references.

Future replacement point:

- If lineage face marks become procedural patterns, evaluate CoreImage only after the handmade cue is accepted as cute and readable.

Verification note:

- Implemented the face lineage echo cue with a tiny handmade SpriteKit forehead dot cluster and Core metadata formatting.
- No package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted GenomeVariation app-host visual QA passed.
- The app-host test proves baseline and child-draft portraits expose `softForeheadMemoryDots` while preserving existing body/tail/thread lineage cues and controls-off behavior.

## Current Loop: ObservationHome Forehead Memory Cue Copy

Handwritten complexity:

- The face lineage echo is now rendered, but the normal ObservationHome cue line still collapses all ancestry into a generic `family echo`.
- The task is a tiny player-facing wording bridge: mention the forehead memory without exposing raw randomness, seeds, debug metadata, or extra controls.

Apple framework candidate:

- SwiftUI is the right layer because `ObservationHomeView` already owns the portrait cue line and accessibility label.
- SpriteKit remains unchanged; the rendered forehead dots already exist.

External library candidate:

- None. This is copy and accessibility wiring, not graph layout, snapshot infrastructure, or procedural texture generation.

Decision:

- Add a short handmade catalog label for `softForeheadMemoryDots`.
- Update only ObservationHome cue/accessibility copy and existing app-host assertions.
- Do not add packages, project edits, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence changes, generated assets, GLB/USD, or image references.

Future replacement point:

- If ObservationHome begins prioritizing many cues, add a small Core copy-priority contract before adding more visible text.

Verification note:

- Implemented the ObservationHome forehead memory cue copy with existing SwiftUI cue/accessibility surfaces.
- No SpriteKit geometry, package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted ObservationHome app-host visual QA passed.
- The app-host test proves Luma's visible cue line now says `forehead memory` and the portrait accessibility label names `soft forehead memory dots` alongside the existing body and tail family echoes.

## Current Loop: ObservationHome Forehead Memory Cue Matrix

Handwritten complexity:

- The forehead memory copy is now visible, but several ObservationHome host routes can drift independently if future edits only assert Luma.
- The task is a test/reference matrix, not new UI: preserve the same quiet copy across Luma, Mira, Ori, Nalu, and selection-host observation.

Apple framework candidate:

- XCTest plus existing SnapshotTesting `.lines` references are sufficient.
- SwiftUI and SpriteKit runtime behavior stay unchanged.

External library candidate:

- None. No new snapshot dependency is needed because the existing app-host text snapshot path already protects this kind of semantic surface.

Decision:

- Add one focused app-host `.lines` snapshot matrix for ObservationHome forehead memory copy.
- Do not add packages, project edits, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence changes, generated assets, GLB/USD, UI layout changes, or image references.

Future replacement point:

- If the matrix becomes slow or broad, split it into a lightweight Core copy contract plus one representative app-host route.

Verification note:

- Implemented the ObservationHome forehead memory cue matrix as one app-host `.lines` snapshot.
- No UI layout, SpriteKit geometry, package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted ObservationHome matrix app-host visual QA passed.
- The matrix covers Luma, Mira, Ori, Nalu, and selection-Mira so the visible `forehead memory` cue and portrait accessibility family echo cannot silently drift on one route.

## Current Loop: SpriteKit Wing Memory Cue Contract

Handwritten complexity:

- GenomeVariation already renders and reports inherited wing silhouette accessories, but the wing cue is not yet named as a lineage memory cue.
- The small task is to promote the existing visible wing-tip accessory into a testable family-memory contract without adding more dots, controls, or player-facing technical text.

Apple framework candidate:

- SpriteKit remains the right rendering layer because the visible wing-tip accessory is already an `SKShapeNode` detail.
- XCTest plus the existing app-host `.lines` snapshot path is enough to prove the semantic cue remains visible and read-only.

External library candidate:

- None. CoreImage, graph layout packages, and new snapshot infrastructure would not improve a contract around an existing hand-tuned wing accessory.

Decision:

- Add a dependency-free wing lineage cue contract around the existing wing-tip accessory.
- Do not add packages, project edits, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence changes, generated assets, GLB/USD, UI layout changes, or image references.

Future replacement point:

- If wing memories become procedural marks rather than fixed accessories, evaluate CoreImage only after the handmade wing cue reads as cute, inherited, and uncluttered.

Verification note:

- Implemented the wing memory cue contract as metadata around the existing `softWingTipPearl` wing-tip accessory.
- No new SpriteKit geometry, UI layout, package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted GenomeVariation app-host visual QA passed.
- The app-host snapshot now proves Mira's inherited `leafPair` wing accessory is also readable as `softWingMemoryTips` at `wingTips`, while remaining read-only and hidden from normal player controls.

## Current Loop: ObservationHome Wing Memory Accessibility Bridge

Handwritten complexity:

- `softWingMemoryTips` is now a renderer lineage cue, but ObservationHome's portrait accessibility family echo still lists only forehead, body, and tail memory.
- The task is copy/list composition: let accessible ObservationHome routes hear the inherited wing memory without adding another visible chip or crowding the capsule line.

Apple framework candidate:

- SwiftUI accessibility labels are the right player-surface bridge.
- XCTest plus the existing ObservationHome app-host `.lines` matrix can prove route-specific copy without adding new UI.

External library candidate:

- None. A list formatter or snapshot package change would not improve this small, WiPet-specific affection phrase.

Decision:

- Add a tiny local lineage-list formatter and include `softWingMemoryTips` only when the profile's wing lineage cue is active.
- Do not add packages, project edits, SpriteKit geometry, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence changes, generated assets, GLB/USD, UI layout changes, visible copy changes, or image references.

Future replacement point:

- If more family-memory cues become visible or localized, move the lineage phrase formatter into a small Core copy contract before adding translation support.

Verification note:

- Implemented the ObservationHome wing memory accessibility bridge with a tiny local lineage cue list formatter.
- No visible copy, UI layout, SpriteKit geometry, package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence, generated asset, GLB/USD, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted ObservationHome matrix app-host visual QA passed.
- The matrix proves Mira and selection-Mira now include `soft wing memory tips` in the portrait family echo, while Luma, Ori, and Nalu keep the quieter forehead/body/tail family echo.

## Current Loop: Growth Ceremony Family Memory Line

Handwritten complexity:

- Growth Ceremony preview already protects before/after growth and lineage affection copy, but it does not yet say that the small family memories stay with the grown form.
- The task is authored ceremony language: one quiet line should reinforce "grown, but still our line" without exposing raw cue IDs, direct growth controls, mutation, or Widget handoff.

Apple framework candidate:

- SwiftUI is enough for the teaser accessibility and hidden semantic QA line.
- XCTest plus the existing Growth Ceremony app-host `.lines` snapshot can prove the copy is present and preview-only.

External library candidate:

- None. This is not random planning, graph layout, texture generation, model import/export, or generalized localization.

Decision:

- Add a dependency-free `familyMemoryLine` to the Growth Ceremony teaser view model and keep it accessibility/semantic-only for now.
- Do not add packages, project edits, SpriteKit geometry, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence writes, generated assets, GLB/USD, direct growth controls, or image-reference changes unless the existing image gate requires updating.

Future replacement point:

- If several creature-specific ceremony lines accumulate, move them into a small Core copy policy before adding visible Growth Ceremony text.

Verification note:

- Implemented the Growth Ceremony family memory line as an accessibility/semantic QA line: `Luma's family memories can stay with the grown shape.`
- No visible layout, SpriteKit geometry, package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget, persistence write, generated asset, GLB/USD, direct growth control, or image-reference change was introduced.
- SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted Growth Ceremony app-host visual QA passed.
- The existing Growth Ceremony image references still passed, proving the new copy strengthens the ceremony contract without crowding the visible card.

## Current Loop: Lineage Family Memory Continuity Line

Handwritten complexity:

- Growth Ceremony now says that Luma's family memories can stay with the grown shape, but LineageFamily QA does not yet echo that wording inside the family surface.
- The task is one read-only family entry line that connects ceremony growth language to family-tree memory without turning lineage into navigation, breeding, or optimization UI.

Apple framework candidate:

- SwiftUI remains the right layer for this QA-only family entry.
- XCTest plus the existing LineageFamily app-host `.lines` snapshot can prove the line is visible and read-only.

External library candidate:

- None. Graph/tree layout libraries are still deferred; this change is emotional copy, not layout automation.

Decision:

- Add a dependency-free LineageFamily continuity line using the same family-memory wording as Growth Ceremony.
- Do not add packages, project edits, graph libraries, SpriteKit geometry, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget changes, persistence writes, generated assets, GLB/USD, navigation, breeding controls, optimization controls, or image references.

Future replacement point:

- If this wording becomes shared across real player-facing screens, move it into a small Core copy policy before adding localization or graph-layout support.

Implementation note:

- `LineageFamilyQAView` now shows the same family-memory sentence used by Growth Ceremony: `Luma's family memories can stay with the grown shape.`
- The app-host surface exposes a hidden continuity summary that marks the line as Growth Ceremony sourced, read-only, non-navigational, non-persistent, non-breeding, non-optimizing, non-widget, and not player-facing.

Verification note:

- Passed SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted LineageFamily app-host visual QA.
- The targeted visual QA asserts the visible `lineageFamilyMemoryContinuityLine` label exists and matches the Growth Ceremony wording.
- No package, project, Widget, persistence, random planning, SpriteKit geometry, generated asset, GLB/USD, graph library, navigation, breeding control, optimization control, or player-facing route change was introduced.

## Current Loop: SpriteKit Child Draft Inherited Winglet Visual

Handwritten complexity:

- Genome Variation QA already records that the child draft carries Mira's `leafPair` wing lineage cue, but the draft portrait still visually reads closest to Luma's lunar wing silhouette.
- The task is one small rendered cue: let the child draft show the inherited fairy winglet accessory so the player can notice "祖先に似ている / 親に似ている" from the pet itself, not only from metadata.

Apple framework candidate:

- SpriteKit remains the correct renderer because the handmade fixed-part catalog already owns the cute wing shape and `softWingTipPearl` accessory.
- XCTest plus the existing Genome Variation app-host `.lines` snapshot and image reference preflight can prove the cue is visible and route-contained.

External library candidate:

- None. CoreImage, procedural texture packages, graph layout, Snapshot Testing dependency changes, ModelIO, SceneKit, and RealityKit do not improve this tiny inherited winglet cue.

Decision:

- Reuse existing SwiftUI/SpriteKit code and add no dependency.
- Keep this as a QA-only child-draft visual variation; do not add packages, project edits, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget handoff, persistence writes, generated assets, GLB/USD, random details, breeding controls, optimization controls, or player-facing route changes.

Future replacement point:

- If child-draft inherited parts become more than a QA preview, move the visual override into a Core read-only preview policy before any persistence or player-facing ceremony uses it.

Implementation note:

- `GenomeVariationQAView` now keeps the Core `childDraftCreature` unchanged while rendering a QA-only `childDraftRenderCreature` with Mira's fairy winglet.
- The rendered child draft uses the existing SpriteKit `leafPair` wing and `softWingTipPearl` accessory, so the visible resemblance comes from the handmade fixed-part catalog rather than a new dependency or generated asset.
- The app-host snapshot records `lineageChildDraftInheritedWingletVisual=...baseWing:none,renderWing:leafPair,accessory:softWingTipPearl,...previewOnly:true,persistence:false,widget:false,breeding:false,controls:false`.

Verification note:

- Passed SwiftPM tests, iOS simulator SDK parse, `git diff --check`, Xcode `snapshot-build`, and targeted Genome Variation app-host visual QA.
- The targeted app-host QA asserts the inherited winglet visual summary, the updated child shape/detail recipe coverage, and the existing image-reference preflight path.
- No package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget handoff, persistence write, generated asset, GLB/USD, random-detail exposure, breeding control, optimization control, or player-facing route change was introduced.

## Current Loop: Xcode External Artifact Runner Support

Handwritten complexity:

- WiPet's app-host visual QA is blocked less by product code and more by local artifact placement: the system Data volume is nearly full while the external SSD has enough space.
- Repeating one-off `TMPDIR`, DerivedData, and SwiftPM checkout flags by hand makes the QA loop fragile and easy to forget.

Apple framework/tooling candidate:

- Use existing Xcode/xcodebuild options: `TMPDIR`, `-derivedDataPath`, and `-clonedSourcePackagesDirPath`.
- Keep the guarded runner and its timeout instead of introducing a new build system or package manager.

External library candidate:

- None. This is local Xcode orchestration, not a product dependency.

Decision:

- Add runner environment support for `WIPET_TMPDIR` and `WIPET_CLONED_SOURCE_PACKAGES_DIR`.
- Do not add dependencies, Xcode project edits, Package.swift changes, Simulator mutations, or product code changes.

Future replacement point:

- If the external-SSD path becomes shared team configuration, move the concrete path into a local untracked shell profile or CI-specific wrapper rather than committing machine-specific defaults.

Implementation note:

- `tools/xcode/wipet-xcodebuild` now exports `TMPDIR` from `WIPET_TMPDIR` and creates the directory before default DerivedData/result paths are resolved.
- `app-build`, `snapshot-build`, and `widget-build` now add `-clonedSourcePackagesDirPath` when `WIPET_CLONED_SOURCE_PACKAGES_DIR` is set.
- `doctor` reports the active artifact path environment values.

Verification note:

- Verified with shell syntax checks, direct whitespace/conflict-marker checks, dry-run command rendering, and `doctor` output.
- `doctor` confirmed the external SSD `TMPDIR`, DerivedData, and cloned source package paths are reported correctly.
- `doctor` also showed Xcode source-control git processes still visible, so exact-path Git operations remain the default.
- Heavy Xcode build/test and Simulator visual QA were intentionally not run in this loop because the system Data volume had less than 1 GiB free; the change is a tooling precondition for recovering those gates safely.

## Current Loop: SwiftPM External Scratch Test Runner

Handwritten complexity:

- Running `swift test` directly recreates `.build` in the workspace, which consumes the same system Data volume that is already blocking Xcode visual QA.
- Repeating `--scratch-path` by hand is easy to miss during autonomous loops, especially when the team is switching between Core tests and app-host QA.

Apple framework/tooling candidate:

- Use SwiftPM's standard `--scratch-path` option and a small timeout guard.
- Keep the helper as a local shell wrapper; do not change `Package.swift` or test code.

External library candidate:

- None. This is SwiftPM orchestration, not product logic.

Decision:

- Add `tools/swift/wipet-swift-test` with `WIPET_SWIFTPM_SCRATCH_PATH`, `WIPET_SWIFT_TEST_TIMEOUT_SECONDS`, and dry-run support.
- Do not add dependencies, package changes, Xcode project edits, product code, Simulator changes, or visual snapshot churn.

Future replacement point:

- If the external scratch path becomes team-wide, move the concrete path into local untracked environment setup or CI configuration rather than committing a machine-specific default.

Implementation note:

- The helper defaults to normal `swift test` behavior and only adds `--scratch-path` when `WIPET_SWIFTPM_SCRATCH_PATH` is set.
- The helper changes directory to the repository root before running SwiftPM so it can be invoked from any subdirectory.
- The watchdog now runs without a nested subshell so a completed SwiftPM child cannot leave only the timeout sleep process behind.

Verification note:

- Verified with shell syntax, direct whitespace/conflict-marker checks, and dry-run command rendering while system Data free space remains under 1 GiB.
- Dry-run output confirmed `swift test --scratch-path ... --quiet` is assembled when `WIPET_SWIFTPM_SCRATCH_PATH` is set.
- External scratch execution passed: `WIPET_SWIFTPM_SCRATCH_PATH=/Volumes/WD_BLACK SN770 500GB Media/WiPetBuildArtifacts/SwiftPMBuild tools/swift/wipet-swift-test --quiet` completed 442 tests.
- The workspace `.build` directory stayed absent while SwiftPM artifacts were placed under the external SSD build artifact area.

## Current Loop: Core Read-Only Inherited Visual Preview Policy

Handwritten complexity:

- The child draft currently gets inherited wing and tail render cues in `WiPetApp` local QA code.
- That improves family resemblance, but the rule itself belongs in Core so future read-only lineage surfaces can share the same "祖先に似ている, but no mutation/write" boundary.

Apple framework/tooling candidate:

- None needed for product logic. This is a Core data contract and should stay independent of SpriteKit/XCTest/Xcode project changes.
- SwiftPM external scratch testing is the verification gate for this Core-only loop.

External library candidate:

- None. GameplayKit already owns deterministic parent/trait planning; this loop does not add randomness or generation.

Decision:

- Add a small Core read-only inherited visual preview policy that overlays selected inherited morph cues for rendering without mutating the child draft genome.
- Keep SpriteKit drawing, Widget handoff, persistence, breeding controls, Xcode project files, Package.swift, and generated assets out of scope.

Future replacement point:

- If this policy becomes player-facing ceremony behavior, add explicit ceremony acknowledgement and persistence-boundary gates before any write or Widget publish is allowed.

Implementation note:

- Added `LineageChildDraftInheritedVisualCuePolicy` in Core.
- The policy renders a preview genome by overlaying selected inherited wing/tail morph cues while leaving the draft genome unchanged.
- `GenomeVariationQAView` now routes its child draft render genome through the Core policy instead of locally mutating a render copy by hand.
- The app-host surface exposes `lineageChildDraftInheritedVisualCuePolicy*` hidden labels so semantic QA can prove the read-only boundary.

Verification note:

- External scratch SwiftPM tests passed with 444 tests.
- iOS simulator SDK parse passed for Core, renderer, app, and targeted snapshot host sources.
- Direct whitespace/conflict-marker checks passed.
- Heavy Xcode build/test and simulator image visual QA remain pending until the system Data volume and CoreSimulator/Xcode resolver are stable enough.

## Current Loop: SpriteKit Child Draft Inherited Tail Fin Visual

Handwritten complexity:

- The child draft now visibly inherits Mira's winglet, but its tail still reads as Luma's floating ribbon in the QA portrait.
- The next body/tail recognizability step should stay small: add Mira's fish-fin tail as a read-only render cue so the draft looks more like a family child without exposing raw inheritance controls.

Apple framework candidate:

- SpriteKit remains the correct renderer because the handmade tail catalog already contains `fishFin` and `softForkFin`.
- XCTest plus the existing Genome Variation app-host `.lines` snapshot can prove this is preview-only and route-contained.

External library candidate:

- None. CoreImage, graph layout, new Snapshot Testing dependency work, ModelIO, SceneKit, RealityKit, and procedural generation do not improve this inherited tail cue.

Decision:

- Reuse the existing SpriteKit tail recipe and add no dependency.
- Keep the tail cue QA-only and preview-only; do not add packages, project edits, CoreImage, GameplayKit changes, ModelIO, SceneKit, RealityKit, Widget handoff, persistence writes, generated assets, GLB/USD, random-detail exposure, breeding controls, optimization controls, or player-facing route changes.

Future replacement point:

- If inherited render traits move beyond QA, replace the local render override with a Core read-only inherited-visual preview policy before any ceremony, persistence, or Widget surface consumes it.

Implementation note:

- `GenomeVariationQAView` now keeps the Core `childDraftCreature` unchanged while rendering a QA-only `childDraftRenderCreature` with Mira's fairy winglet and fish-fin tail.
- The tail cue uses the existing SpriteKit handmade `fishFin` silhouette and `softForkFin` accessory through `CreatureRenderProfile`, so the resemblance remains catalog-driven rather than random or generated.
- The app-host text snapshot records `lineageChildDraftInheritedTailFinVisual=...baseTail:floatingRibbon,renderTail:fishFin,accessory:softForkFin,...previewOnly:true,persistence:false,widget:false,breeding:false,controls:false`.

Verification note:

- Passed SwiftPM tests and iOS simulator SDK parse.
- Xcode `build-for-testing` reached real Swift compilation after package resolution was moved to the external SSD, caught a tail accessory access issue, and the code was corrected.
- Final Xcode build/test visual QA is blocked in this environment after the external SSD migration because `xcodebuild -resolvePackageDependencies` idles at 0% CPU while opening CoreSimulator/DeviceKit resources; this is an environment gate, not a WiPet code or package-resolution error.
- Git object health was partially recovered by backing up invalid `refs/heads/main 2` / `main 3` refs and orphaned missing-pack `.idx` / `.rev` files, then committing through a temporary index that excluded the existing user-staged files.
- `git diff --check` remained unreliable while old parent-history objects were missing, so whitespace/conflict-marker checks were run directly on touched files instead.
- No package, project, CoreImage, GameplayKit, ModelIO, SceneKit, RealityKit, Widget handoff, persistence write, generated asset, GLB/USD, random-detail exposure, breeding control, optimization control, or player-facing route change was introduced.

## Current Loop: Growth Ceremony Inherited Visual Memory Bridge

Handwritten complexity:

- Growth Ceremony should eventually say "this grown shape still remembers the family" without turning inherited wing/tail cues into a random-roll result, a breeding control, or a write.
- The existing Core inherited visual cue policy already protects render-only wing/tail resemblance. The missing piece is a Core ceremony bridge that can reference that policy without mutating the creature or publishing Widget handoff.

Apple framework candidate:

- No new Apple framework is needed. GameplayKit remains the deterministic lineage planning foundation, and this loop consumes an already-planned read-only policy.
- SwiftPM external scratch testing is the verification gate while Xcode/CoreSimulator remains unstable.

External library candidate:

- None. Copy safety, family-memory wording, and ceremony write boundaries are WiPet-specific and should stay handmade.

Decision:

- Add a small Core `GrowthCeremonyInheritedVisualMemoryBridge` contract.
- Keep it preview-only, non-writing, non-widget, non-discovery, non-player-facing, and dependent on `LineageChildDraftInheritedVisualCuePolicy.hasRequiredFields`.
- Do not change SpriteKit drawing, Observation UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, SnapshotTesting references, or image baselines.

Future replacement point:

- If Growth Ceremony later makes this line visible, route it through the local observation state owner and run app-host visual QA before allowing any player-facing copy.

## Current Loop: Growth Ceremony Inherited Visual Hidden QA Handoff

Handwritten complexity:

- The Core bridge now exists, but Growth Ceremony preview QA still cannot prove that ObservationHome is carrying the inherited visual memory contract.
- The task is not to show new copy yet. It is to expose a hidden semantic handoff so future ceremony UI work can safely decide whether the family-memory line deserves visible space.

Apple framework candidate:

- SwiftUI accessibility identifiers are sufficient for the hidden QA handoff.
- Existing SnapshotTesting `.lines` references are the right regression support when app-host execution is available.

External library candidate:

- None. Adding another UI/snapshot package would not improve affection, lineage feeling, or reversibility for this hidden contract.

Decision:

- Add dependency-free hidden Growth Ceremony inherited visual memory summaries in `ObservationHomeView`.
- Keep normal visible UI, SpriteKit drawing, Creature mutation, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, and image references unchanged.
- Record the bridge through existing semantic text paths before any visible ceremony copy is promoted.

Future replacement point:

- If the line becomes visible, require app-host visual QA and copy review for warmth, crowding, and "うちの家系だ" feeling before updating image references.

## Current Loop: Growth Ceremony Inherited Visual Visible Promotion Gate

Handwritten complexity:

- The inherited visual memory line is now available to hidden QA, but making it visible too early could crowd the ceremony card or make family resemblance feel like metadata.
- The task is to define the promotion rules before any visible UI change.

Apple framework candidate:

- No new framework is needed. This is a Core policy gate over existing SwiftUI/SnapshotTesting/manual QA evidence.
- SwiftPM external scratch testing remains the verification path while Xcode visual QA is blocked by local disk pressure.

External library candidate:

- None. A layout, snapshot, or copy-generation package would not decide whether this line genuinely increases affection.

Decision:

- Add a Core `GrowthCeremonyInheritedVisualVisiblePromotionGate`.
- Require a ready bridge, manual copy review, app-host visual QA, snapshot reference review, enough ceremony layout space, and no mutation/persistence/Widget/discovery/player-facing side effects.
- Keep Observation UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, and image references unchanged.

Future replacement point:

- When app-host visual QA is healthy, a later UI loop can consume this gate before rendering the inherited visual memory line visibly.

## Current Loop: Growth Ceremony Visible Promotion Hidden QA Handoff

Handwritten complexity:

- The visible-promotion gate exists in Core, but ObservationHome does not yet expose why the inherited visual memory line remains hidden.
- The task is to make the hidden QA contract explicit: the line is ready as a memory, but not visible until review, visual QA, snapshot review, and layout-room evidence are present.

Apple framework candidate:

- SwiftUI accessibility identifiers are sufficient for the hidden semantic handoff.
- Existing SnapshotTesting text references remain the correct regression surface.

External library candidate:

- None. Adding a UI testing or layout package would not improve the judgement of whether the ceremony stays warm and uncrowded.

Decision:

- Add dependency-free hidden promotion-gate summary/readiness labels in ObservationHome.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD, and image references unchanged.

Future replacement point:

- When local app-host visual QA is available, rerun the Growth Ceremony host and use this gate before any visible copy promotion.

## Current Loop: Fixed Part 3D Reference Acceptance Gate

Handwritten complexity:

- The fixed-part 3D library needs GLB/USD, sockets, rig diagrams, and grayscale-only asset rules, but starting ModelIO/SceneKit/RealityKit output before the reference sheet is accepted would optimize for technology before cuteness.
- The small task is to define when a reference sheet may unlock 3D asset planning, not to generate or load 3D assets.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the right Apple-framework candidates for later GLB/USD import, preview, socket validation, and fixed-part inspection.
- They are not adopted in this loop because no accepted PNG reference sheet, manual art review, or app-host visual QA evidence exists yet.

External library candidate:

- None. External GLB/USD helpers would add build and maintenance risk before WiPet has accepted silhouettes and sockets.

Decision:

- Add a dependency-free Core `fixedPart3DReferenceAcceptanceGate` contract that requires the soft lineage cue reference sheet, panel layout, reference-sheet acceptance gate, artifact naming, manual review checklist, and child-draft lineage cue gate to be ready.
- Keep ModelIO/SceneKit/RealityKit deferred, keep `generationAllowed:false`, and require `runtimeLoaded:false`, `generatedAssets:false`, `assetOutputs:none`, and no GLB/USD output.
- Do not change SpriteKit drawing, packages, project files, generated assets, GLB/USD files, Widget handoff, persistence, or visible UI.

Future replacement point:

- After a human-approved PNG reference sheet and visual QA evidence exist, use ModelIO/SceneKit/RealityKit in a separate smallest-possible commit to validate sockets and inspect grayscale fixed parts.

## Current Loop: Fixed Part 3D Gate QA Surface Handoff

Handwritten complexity:

- The Core 3D reference acceptance gate exists, but the QA host cannot yet prove that 3D remains deferred before any GLB/USD or Apple 3D framework work starts.
- The small task is a semantic handoff: expose the closed gate in `GenomeVariationQAView` so future visual and 3D loops can inspect the same contract.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for asset import, socket validation, and grayscale preview.
- They are not adopted in this loop because this is only a SwiftUI hidden-label handoff over existing Core metadata.

External library candidate:

- None. SnapshotTesting already owns the text reference surface; adding another package would not improve affection, recognizability, or 3D safety.

Decision:

- Add dependency-free `CreatureRenderProfile` static summaries for `fixedPart3DReferenceAcceptanceGate`.
- Expose them through hidden `GenomeVariationQAView` labels and the existing app-target `.lines` reference.
- Keep SpriteKit drawing, visible UI, Package.swift, Xcode project files, generated assets, GLB/USD files, Widget handoff, persistence, and player-facing copy unchanged.

Future replacement point:

- When reference sheet evidence is manually accepted, a later smallest-possible loop may flip from "deferred" to a ModelIO/SceneKit/RealityKit validation pass with visual QA.

## Current Loop: CommonPetRig Asset Validation QA Surface Handoff

Handwritten complexity:

- `CommonPetRigAssetValidationPreflight` already defines when ModelIO/SceneKit/RealityKit validation may begin, but Genome Variation QA does not yet expose that preflight beside the fixed-part 3D acceptance gate.
- Without this hidden surface, future GLB/USD work could start from an asset-loading mindset before accepted reference artifacts and asset candidates exist.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the right Apple-framework candidates for future GLB/USD import, socket validation, and grayscale preview.
- They are not adopted here because there is no accepted reference artifact or asset candidate.

External library candidate:

- None. External 3D import/export helpers would add dependency and maintenance risk before WiPet's fixed-part silhouettes are accepted.

Decision:

- Expose the existing Core `CommonPetRigAssetValidationPreflight` through hidden Genome Variation QA labels and the app-target `.lines` reference.
- Keep `referenceArtifact:false`, `assetCandidate:false`, `modelIO:false`, `sceneKit:false`, `realityKit:false`, `validationAllowed:false`, `deferredSafely:true`, `geometryGenerated:false`, `runtimeLoaded:false`, and `assetOutputs:none`.
- Do not import ModelIO/SceneKit/RealityKit, change package/project files, create GLB/USD/PNG assets, change SpriteKit drawing, alter Widget handoff, or change visible UI.

Future replacement point:

- After a manually accepted reference artifact and concrete asset candidate exist, use this preflight as the smallest gate before enabling ModelIO-based validation in a separate commit.

## Current Loop: CommonPetRig Socket Map QA Surface Handoff

Handwritten complexity:

- `CommonPetRigSocketMap` names the typed FaceBase, UpperBody, WingBase, and TailBase socket bindings, but Genome Variation QA currently exposes only the derived asset-validation preflight.
- The fixed-part pipeline needs the actual socket-to-rig mapping visible before any 3D asset validation work starts, so future ModelIO/SceneKit/RealityKit work can prove it is using the same handmade socket intent.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future validation candidates, but they are not needed to expose a typed Core socket map.

External library candidate:

- None. A graph, rig, or 3D helper package would add complexity before the fixed socket vocabulary is accepted in QA.

Decision:

- Expose `CommonPetRigSocketMap().summary` and readiness through hidden Genome Variation QA labels and the app-target `.lines` reference.
- Keep `geometryGenerated:false`, `runtimeLoaded:false`, `assetOutputs:none`, and `validated3DAssets:false`.
- Do not import ModelIO/SceneKit/RealityKit, change package/project files, create assets, change SpriteKit drawing, alter Widget handoff, or change visible UI.

Future replacement point:

- When GLB/USD candidates exist, use this exposed socket-map contract as the required baseline before framework-backed socket validation can run.

Result:

- Added hidden Genome Variation QA labels for `commonPetRigSocketMapSummary` and `commonPetRigSocketMapReadinessSummary`.
- The app-target `.lines` snapshot now records the FaceBase, UpperBody, WingBase, and TailBase socket-to-rig bindings before the asset-validation preflight.
- Kept ModelIO/SceneKit/RealityKit unimported, visible UI unchanged, SpriteKit drawing unchanged, Widget handoff unchanged, persistence unchanged, Package.swift unchanged, Xcode project files unchanged, generated assets unchanged, and GLB/USD output absent.

## Current Loop: Fixed Part 3D Manifest QA Surface Handoff

Handwritten complexity:

- `fixedPart3DManifest` names future GLB/USD stems, formats, CommonPetRig bones, and socket mappings, but Genome Variation QA does not yet expose that manifest beside the socket map and asset-validation preflight.
- The 3D pipeline should prove the manifest is present before any asset candidate or framework validation begins, so technical asset work stays downstream of cute silhouette and socket intent.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain future candidates for import, preview, and socket validation.
- They are not adopted here because this loop only surfaces the dependency-free manifest contract.

External library candidate:

- None. GLB/USD helper packages are not useful until WiPet has real asset candidates and accepted reference artifacts.

Decision:

- Expose `fixedPart3DManifestSummary` and readiness through hidden Genome Variation QA labels and the app-target `.lines` reference.
- Keep `formats:glb,usd`, `rig:CommonPetRig`, required bones and sockets, `grayscaleOnly:true`, `excludesColorPatternGlow:true`, `validatedAssets:false`, and `generatedAssets:false`.
- Do not import ModelIO/SceneKit/RealityKit, change package/project files, create assets, change SpriteKit drawing, alter Widget handoff, or change visible UI.

Future replacement point:

- When accepted PNG/GLB/USD candidates exist, this manifest must remain green before any framework-backed asset validation or preview is allowed.

Result:

- Added hidden Genome Variation QA labels for `fixedPart3DManifestSummary` and `fixedPart3DManifestReadinessSummary`.
- The app-target `.lines` snapshot now records future GLB/USD asset stems, `CommonPetRig`, required bones, socket mappings, grayscale-only/no-pattern-glow rules, and closed asset states before the 3D reference acceptance gate.
- Kept ModelIO/SceneKit/RealityKit unimported, visible UI unchanged, SpriteKit drawing unchanged, Widget handoff unchanged, persistence unchanged, Package.swift unchanged, Xcode project files unchanged, generated assets unchanged, and GLB/USD output absent.

## Current Loop: Observation Eye Glint Recognizability Cue

Handwritten complexity:

- The SpriteKit portrait already renders personality-driven catchlights, but the visible observation cue line does not yet help the player notice that eye detail as part of "うちの子" recognizability.
- The task is to surface an existing visual cue in a short, warm phrase without adding a new system, crowding the capsule, or implying a controllable stat.

Apple framework candidate:

- No new Apple framework is needed. SpriteKit already draws the catchlight; SwiftUI already owns the visible cue line.
- CoreImage remains a future candidate for procedural pattern/glow work, not for this small observation copy bridge.

External library candidate:

- None. A copy or UI library would not improve the handmade affection judgment here.

Decision:

- Add a tiny handwritten `ObservationCreatureCueCatalog.eyeGlint` mapping from existing `CreatureRenderProfile.Expression` labels.
- Append the eye glint to the observation cue line only, keeping SpriteKit drawing, packages, project files, generated assets, GLB/USD, Widget handoff, persistence, and hidden Core contracts unchanged.

Future replacement point:

- If cue-line text becomes crowded, promote this into a reviewed observation copy policy with app-host visual QA and snapshot image review.

## Current Loop: Observation Cue Line Readability Guard

Handwritten complexity:

- The observation cue line now carries face, body, wing/tail, eye glint, and memory cues. That improves recognizability, but it can hurt immersion if the capsule becomes a dense checklist.
- The task is to add a text-budget guard that proves the line remains short enough before adding any more visible cues.

Apple framework candidate:

- No new Apple framework is needed. SwiftUI already provides the visible capsule, line limit, and minimum scale factor.
- XCTest/SnapshotTesting text references are enough for the hidden semantic check until app-host visual QA can be rerun.

External library candidate:

- None. A text measurement package would be premature without a live app-host layout pass, and would not improve the affection wording itself.

Decision:

- Add a dependency-free Core `observationCueLineReadabilityPreflight` contract.
- Expose it through hidden ObservationHome labels and snapshot-host assertions.
- Keep visible copy, SpriteKit drawing, packages, project files, generated assets, Widget handoff, persistence, GLB/USD, and PNG references unchanged.

Future replacement point:

- When Simulator visual QA is healthy, replace the character/segment preflight with measured rendered width or snapshot image review if the capsule still feels crowded.

## Current Loop: Lineage Graph Layout Library Review

Handwritten complexity:

- WiPet needs a family-tree feeling, but jumping to an external graph layout before the read-only branch copy is accepted could make lineage feel technical instead of intimate.
- The current family preview is small enough to keep handmade: ancestor, parents/siblings, draft memory, and read-only relationship lines.

Apple framework candidate:

- No new Apple framework is needed. SwiftUI can host the current read-only branch preview, and SwiftData/App Groups remain future persistence surfaces.
- GameplayKit remains the deterministic lineage planning base, not a graph layout dependency.

External library candidate:

- Swift Algorithms / Collections could help if branch traversal, ordering, or cycle checks become complex.
- A graph/tree layout package is not adopted now because the current surface has only 3 generations, 4 nodes, and 3 edges, and the emotional copy needs manual control.

Decision:

- Add a dependency-free `LineageFamilyGraphLayoutLibraryReview` companion to the existing graph layout adoption gate.
- Require the existing branch preview gate to remain below adoption threshold before recording `SwiftAlgorithmsCollections` as a deferred candidate.
- Keep graph navigation, persistence, breeding controls, optimization controls, Widget handoff, packages, project files, generated assets, GLB/USD, and visible UI unchanged.

Future replacement point:

- Reconsider Swift Algorithms / Collections when branch count, traversal rules, or generation ordering can no longer stay readable with simple arrays.

## Current Loop: ObservationHome App-Host Visual QA Recovery Probe

Handwritten complexity:

- ObservationHome's visible cue line now includes eye-glint and family-memory wording, but the app-host visual QA rerun was deferred while local system storage and CoreSimulator were unstable after the external SSD migration.
- The task is not to add UI or a dependency; it is to determine whether the existing guarded Xcode/XCTest path can safely verify the visible ObservationHome surface again.

Apple framework candidate:

- XCTest, Xcode, and iOS Simulator remain the correct Apple tooling for app-host visual QA.
- No new Apple framework is needed in product code.

External library candidate:

- None. SnapshotTesting is already installed; adding a package would not fix Xcode worker health or improve the affection cue.

Decision:

- Use the existing `tools/xcode/wipet-xcodebuild` guardrail with external DerivedData/package-cache paths and a targeted ObservationHome app-host test.
- Do not change visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, or image references in this probe.

Future replacement point:

- If the targeted app-host path is healthy, resume player-visible SpriteKit/Observation improvements with visual QA in the normal loop. If it stalls, keep visible changes paused and continue Core/hidden QA work.

Result:

- `doctor` confirmed the external Xcode developer directory and external artifact paths, but still showed Xcode source-control git workers (`status`, `add -u`, `diff`) running against the WiPet repo.
- `snapshot-build` dry-run resolved the iOS Simulator destination and external DerivedData/package-cache paths.
- A real targeted ObservationHome `snapshot-build` remained silent for 90 seconds and was stopped before spending more Xcode/CoreSimulator time; no compiler or test failure was emitted.
- Kept product code, visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: ObservationHome App-Host Visual QA Recovery State Gate

Handwritten complexity:

- The current risk is not creature rendering logic; it is forgetting that visible ObservationHome changes must stay paused until app-host visual QA completes cleanly.
- A small handwritten Core summary can make that pause intentional, testable, and visible to hidden QA without adding product UI.

Apple framework candidate:

- XCTest, Xcode, and iOS Simulator remain the correct Apple tooling for the eventual visual QA rerun.
- No Apple framework is added to product code; this loop only records the current app-host recovery state as metadata.

External library candidate:

- None. SnapshotTesting is already present, and adding another package would not fix Xcode worker silence or improve the creature's affection cues.

Decision:

- Add dependency-free `RendererMetadataSummary` helpers for `appHostVisualQARecoveryState`.
- Expose the recovery state only as hidden ObservationHome snapshot-host labels.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, image references, and normal Widget publish behavior unchanged.

Future replacement point:

- When the targeted app-host path completes, flip this from a paused-state gate into a passing visual-QA evidence gate before resuming player-visible ObservationHome or SpriteKit recognizability work.

Result:

- Added dependency-free Core summary/readiness helpers for `appHostVisualQARecoveryState`.
- Added Core tests proving the current state is an intentional paused ObservationHome gate: external Xcode/artifacts and dry-run resolved, targeted build not completed, silent stop recorded, Xcode source-control workers still active, visible changes disallowed, and asset outputs `none`.
- Exposed hidden ObservationHome snapshot-host labels for the recovery state and readiness.
- Kept normal ObservationHome appearance, SpriteKit pixels, Widget handoff publishing, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: ObservationHome App-Host Recovery State Refresh

Handwritten complexity:

- After the external SSD migration finished, the app-host gate needed fresh evidence instead of carrying forward the older Xcode source-control worker diagnosis.
- The risk is resuming visible creature work from stale recovery metadata.

Apple framework candidate:

- Continue using Xcode/XCTest/Simulator through the guarded project helper. No new product framework is involved.

External library candidate:

- None. SnapshotTesting is already present; the current failure is a guarded Xcode build timeout, not a missing assertion library.

Decision:

- Re-run `doctor`, dry-run `snapshot-build`, then one guarded real `snapshot-build` on external DerivedData/package/tmp paths.
- Update the hidden recovery state to record that source-control workers are now absent, while the app-host build still fails by watchdog timeout.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Result:

- `doctor` passed with external Xcode/artifact paths and reported no visible Xcode source-control git workers.
- Dry-run `snapshot-build` resolved simulator `D1C8187C-29D0-4145-94C7-6F887207A27F` and external artifact paths.
- Real targeted `snapshot-build` remained silent until the helper terminated child `xcodebuild` at 180 seconds.
- Updated `appHostVisualQARecoveryState` to include `watchdogTimeout:true` and `sourceControlWorkers:false`, keeping `visibleChanges:false`.

## Current Loop: ObservationHome App-Host Recovery Evidence Detail

Handwritten complexity:

- The recovery state now says the app-host build timed out, but the hidden QA string does not yet record which simulator and watchdog window produced that evidence.
- Without those details, the next recovery attempt can accidentally compare unlike runs.

Apple framework candidate:

- Continue using the existing Xcode/XCTest/Simulator runner. No product framework or rendering framework is added.

External library candidate:

- None. A logging or diagnostics package would not improve the affection surface, and the needed evidence is a stable Core string.

Decision:

- Extend the dependency-free `appHostVisualQARecoveryState` metadata with `simulatorID` and `timeoutSeconds`.
- Keep the state hidden in ObservationHome snapshot-host mode only.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When the app-host build completes, replace the timeout evidence with passing build/test evidence and keep the simulator/timeout fields for auditability.

Result:

- Extended `appHostVisualQARecoveryState` with `simulator:D1C8187C-29D0-4145-94C7-6F887207A27F` and `timeoutSeconds:180`.
- Updated Core validation so the paused-state gate is tied to the exact recovery evidence, not only generic timeout booleans.
- Updated hidden ObservationHome snapshot-host labels without changing normal UI or Widget behavior.

## Current Loop: SwiftPM Workspace Build Artifact Diagnostics

Handwritten complexity:

- External SwiftPM scratch testing is meant to keep artifacts off the local system Data volume, but SwiftPM can still leave a 0B workspace `.build` directory tree.
- The risk is not product behavior; it is silently claiming the workspace stayed clean when a generated directory exists.

Apple framework candidate:

- Continue using SwiftPM's standard `--scratch-path` option. No Apple product framework is involved.

External library candidate:

- None. This is shell-tool diagnostics and does not need a package.

Decision:

- Keep `tools/swift/wipet-swift-test` dependency-free.
- After the SwiftPM child exits, report whether workspace `.build` is absent or present with its size.
- Do not auto-delete `.build` because removal attempts can stall in the current external-SSD/Xcode environment; keep cleanup a conscious operator step.

Future replacement point:

- If SwiftPM exposes a reliable no-local-stub mode or the deletion stall is understood, replace the warning with a safe cleanup mode.

## Current Loop: Xcode Timeout Artifact Diagnostics

Handwritten complexity:

- App-host recovery currently stops at a guarded `xcodebuild` timeout, but the timeout log only names the child pid.
- Without artifact and process context, each retry is harder to compare, and visible creature work stays paused without enough evidence about the environment failure mode.

Apple framework candidate:

- Continue using `xcodebuild`, XCTest, CoreSimulator, and the existing helper. No product framework is introduced.

External library candidate:

- None. A diagnostics package would be overkill for a shell timeout report.

Decision:

- Keep `tools/xcode/wipet-xcodebuild` dependency-free.
- On timeout, print the active DerivedData path, its size if present, the cloned source package cache path, and a short related-process snapshot before terminating the helper-started child `xcodebuild`.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- If app-host builds recover, keep the diagnostics as low-noise timeout-only evidence and resume visible work only after build/test visual QA passes.

## Current Loop: Growth Ceremony Inherited Visual Promotion Deferral

Handwritten complexity:

- Deciding when an inherited visual memory line is emotionally safe to promote from hidden QA evidence into a visible Growth Ceremony line.
- The risk is showing ancestry copy before app-host visual QA proves the ceremony has enough room and still feels quiet.

Apple framework candidate:

- Continue using existing Swift value contracts and the already-adopted Xcode/XCTest/Simulator QA path.
- No new Apple framework is needed for this Core-only deferral contract.

External library candidate:

- None. SnapshotTesting is already present, but this loop records a promotion boundary instead of adding image references or changing the rendered UI.

Decision:

- Add a dependency-free Core deferral contract that says manual copy review alone is not enough.
- The inherited visual memory line remains hidden until app-host visual QA, snapshot review, and layout room are all confirmed.
- Keep visible ObservationHome UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When app-host visual QA passes, replace this deferral evidence with a promotion evidence contract before making the line player-facing.

Result:

- Added dependency-free Core deferral evidence for inherited visual promotion.
- Kept manual copy review separate from app-host visual QA, snapshot review, and layout room confirmation.
- Exposed only hidden ObservationHome QA labels and text snapshot evidence.
- Verified with SwiftPM Core tests and iOS parse. App-host build completed once after migration, but targeted Simulator test/rebuild later timed out again, so visible promotion remains deferred.

## Current Loop: Xcode Timeout Diagnostics Smoke Test

Handwritten complexity:

- The timeout diagnostics were added but not yet exercised through a real helper timeout.
- A tiny smoke test can prove the guard emits DerivedData/cache/process context without spending another long app-host build.

Apple framework candidate:

- Use the existing `xcodebuild -list` path through `tools/xcode/wipet-xcodebuild`; no product framework is involved.

External library candidate:

- None. This is shell helper verification.

Decision:

- Run `tools/xcode/wipet-xcodebuild list` with `WIPET_XCODEBUILD_TIMEOUT_SECONDS=1` and external artifact paths.
- Record whether the helper prints timeout diagnostics and terminates only the helper-started child.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Result:

- The smoke test timed out with exit code 124 and printed `timeout diagnostics`.
- The log included the external DerivedData path, cloned source package cache path and size, and a related-process snapshot including the helper-started child `xcodebuild`.
- A follow-up process check found no lingering WiPet `xcodebuild` process from the smoke test.

## Current Loop: App-Host Concurrent Xcode Build Visibility

Handwritten complexity:

- App-host visual QA can time out even after Simulator shutdown when another `xcodebuild` is running in the same machine session.
- Without a preflight signal, retries look like WiPet failures instead of shared Xcode capacity contention.

Apple framework candidate:

- Continue using Xcode/XCTest/CoreSimulator through the existing helper and `ps` process inspection.
- No product framework is introduced.

External library candidate:

- None. A process-monitoring package would add dependency risk without improving affection, lineage feeling, or visual quality.

Decision:

- Keep `tools/xcode/wipet-xcodebuild` dependency-free.
- Extend `doctor` so it reports visible `xcodebuild` processes before app-host retries.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- If app-host visual QA becomes stable, keep this as a low-noise preflight check before visible creature work.

## Current Loop: App-Host Visual QA Resume Gate

Handwritten complexity:

- Deciding whether WiPet may resume visible ObservationHome/SpriteKit work while app-host build/test evidence is still unstable.
- The risk is letting visible creature changes advance without a reliable Simulator QA path, which can weaken affection by shipping crowded or unreadable surfaces.

Apple framework candidate:

- Continue using Xcode/XCTest/CoreSimulator evidence gathered through the existing helper.
- No product framework is added; this is a Core metadata contract.

External library candidate:

- None. A monitoring package or snapshot-library change would not make the blocked app-host path more trustworthy yet.

Decision:

- Add a dependency-free Core resume gate around the latest app-host evidence.
- The gate should only permit visible work when source-control workers are quiet, no unrelated `xcodebuild` is visible, local Data volume has enough free space, the last snapshot build did not time out, and no asset output or visible copy change is being introduced.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- Once app-host build/test completes reliably, this gate can flip from a pause contract into a preflight pass contract before visible creature work resumes.

## Current Loop: SpriteKit Recognizability Cue Candidate Gate

Handwritten complexity:

- Choosing the next genome-driven visual cue without adding more labels, glints, or lineage marks.
- The cue must make a pet feel recognizable at a glance through body or tail shape, while staying soft, handmade, and uncluttered.

Apple framework candidate:

- SpriteKit remains the renderer for the eventual cue because the existing handmade part vocabulary already owns body and tail silhouette language.
- GameplayKit is not needed because no new inheritance or mutation planning is introduced.
- CoreImage is not needed because this is not procedural texture, mask, glow, or CPPN precursor work.
- ModelIO, SceneKit, and RealityKit remain deferred because this is not a 3D asset loop.

External library candidate:

- None. A drawing, layout, or image-processing package would not decide the WiPet-specific affection value of a body/tail cue.

Decision:

- Add a dependency-free Core candidate gate before changing SpriteKit pixels.
- The current candidate remains proposal-only while app-host visual QA is not ready.
- Require the candidate to target body or tail recognizability, use existing handmade SpriteKit vocabulary, avoid label-only/copy-only/lineage-mark-only changes, avoid clutter, and keep persistence, Widget handoff, generated assets, and asset outputs disabled.

Minimum scope:

- Add a Core value contract plus tests.
- Update the implementation plan.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, SnapshotTesting references, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When app-host visual QA is healthy again, use this gate to pick the smallest actual body/tail SpriteKit cue and verify it visually before recording any new image reference.

## Current Loop: SpriteKit Recognizability Cue Selection Review

Handwritten complexity:

- Choosing the first concrete body/tail cue to implement after app-host visual QA recovers.
- The selected cue should be a real silhouette difference, not another label, copy line, glow, or lineage memory mark.

Apple framework candidate:

- SpriteKit remains the eventual renderer for the selected cue.
- GameplayKit is not needed because this loop does not change inheritance or mutation planning.
- CoreImage is not needed because the selected cue is a handmade silhouette/accessory, not a generated texture.
- ModelIO, SceneKit, and RealityKit remain deferred because no GLB/USD or socket-preview asset is produced.

External library candidate:

- None. This is an art-direction selection rule, not a generic rendering or testing problem.

Decision:

- Add a Core selection review that sits after `SpriteKitRecognizabilityCueCandidateGate`.
- Select the tail `fishFin+softForkFin` cue as the next proposal-only body/tail recognizability candidate because it is an existing handmade silhouette/accessory vocabulary, reads at a glance, and avoids adding more labels or memory marks.
- Keep the review proposal-only until manual art review and app-host visual QA are available.

Minimum scope:

- Add a Core value contract plus tests.
- Update the implementation plan.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, SnapshotTesting references, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When app-host visual QA resumes, use this selected tail cue as the first actual SpriteKit body/tail recognizability implementation candidate, then verify it before any image-reference update.

## Current Loop: SpriteKit Fish Tail Art Review Checklist

Handwritten complexity:

- Reviewing whether `fishFin+softForkFin` stays cute, soft, and readable enough to become the first actual body/tail recognizability cue.
- The danger is turning a family-recognition silhouette into a sharp fin, rarity mark, or decorative flourish.

Apple framework candidate:

- SpriteKit remains the eventual renderer, but this loop does not draw pixels.
- GameplayKit does not apply because the selected cue is already chosen and no random planning changes.
- CoreImage does not apply because this is not a texture, mask, glow, or pattern-generation task.
- ModelIO, SceneKit, and RealityKit remain deferred because this is not a 3D asset validation loop.

External library candidate:

- None. The checklist is WiPet-specific creature art direction and should stay readable in Core tests.

Decision:

- Add a dependency-free Core art-review checklist for the selected fish-tail cue.
- Keep the checklist open: manual art review false, app-host visual QA false, snapshot review false, visible pixels false, generated assets false, and `assetOutputs:none`.
- Require soft fork shape, secondary silhouette, at-a-glance readability, no sharp fin, no rarity/stat framing, and no lineage-mark-only behavior before later visible implementation can proceed.

Minimum scope:

- Add a Core value contract plus tests.
- Update the implementation plan.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, SnapshotTesting references, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When manual art review and app-host visual QA can run, this checklist becomes the evidence boundary before changing the SpriteKit fish-tail pixels or updating any image reference.

## Current Loop: SpriteKit Fish Tail Implementation Preflight

Handwritten complexity:

- Deciding when the selected `fishFin+softForkFin` cue may finally touch SpriteKit pixels.
- The preflight must protect normal UI, Widget handoff, persistence, and image references while the app-host visual QA path is still below the required evidence threshold.

Apple framework candidate:

- SpriteKit is the eventual renderer for the fish-tail cue.
- XCTest/SnapshotTesting remain future verification surfaces after app-host visual QA is healthy.
- GameplayKit, CoreImage, ModelIO, SceneKit, and RealityKit do not apply to this preflight.

External library candidate:

- None. No package should be added for a closed implementation gate.

Decision:

- Add a dependency-free Core implementation preflight.
- Keep it closed while Data/app-host visual QA is not ready, manual art review is not accepted, snapshot review is not accepted, and visible pixels remain unchanged.
- Require the fish-tail art-review checklist to be ready, but do not allow SpriteKit edits, Widget publish, persistence writes, image-reference updates, generated assets, or package/project changes in this loop.

Minimum scope:

- Add a Core value contract plus tests.
- Update the implementation plan.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, SnapshotTesting references, CoreImage, ModelIO, SceneKit, and RealityKit unchanged.

Future replacement point:

- When this preflight opens, the next loop may make the smallest SpriteKit fish-tail pixel change and must run app-host visual QA before commit.

## Current Loop: XCTestDevices External Storage Gate

Handwritten complexity:

- After the external SSD migration, `~/Library/Developer/XCTestDevices` can be externalized while the system Data volume is still below the app-host visual QA threshold.
- The risk is treating "XCTestDevices moved" as equivalent to "visible SpriteKit or ObservationHome work may resume"; WiPet needs both externalized test-device storage and enough remaining Data volume before changing pixels or player-facing copy.

Apple framework candidate:

- XCTest, Xcode, and iOS Simulator remain the correct app-host visual QA path.
- No new Apple product framework is needed; this loop records local storage evidence around Apple's existing XCTest device data.

External library candidate:

- None. A package cannot make the local Data volume safe or improve affection, lineage feeling, or renderer quality.

Decision:

- Add a dependency-free Core metadata gate that records whether XCTestDevices is externalized, how much system Data volume is free, and whether visible changes remain paused.
- Treat the current state as partial progress only: external XCTestDevices is good evidence, but Data volume under threshold keeps visible work closed.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- Once Data volume reaches the threshold and app-host build/test completes without timeout, this storage gate can become supporting evidence for reopening visible fish-tail or ObservationHome visual QA work.

Result:

- Added dependency-free Core metadata for `xctestDevicesExternalStorageGate`.
- Recorded the current partial recovery shape: XCTestDevices externalized to the external SSD, external volume has room, Data volume remains below the app-host visual QA threshold, and visible changes stay paused.
- Kept visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: Fish Tail Visible Work Resume Bridge

Handwritten complexity:

- The fish-tail implementation preflight and the storage gate now exist separately; the next risk is accidentally treating a ready-but-paused storage gate as permission to edit SpriteKit pixels.
- The bridge must keep the selected `fishFin+softForkFin` cue emotionally protected: no visible fish-tail change until storage, app-host QA, manual art review, and snapshot review are all aligned.

Apple framework candidate:

- SpriteKit remains the eventual rendering target.
- XCTest/Xcode/Simulator remain the eventual app-host visual QA path.
- No new Apple framework is needed for this Core-only bridge.

External library candidate:

- None. A package would not improve the affection decision or local QA readiness.

Decision:

- Add a dependency-free Core bridge that composes the fish-tail implementation preflight with external XCTestDevices storage and app-host resume evidence.
- Keep the current bridge blocked: preflight ready, storage evidence ready, storage cannot resume yet, app-host resume false, visible pixels false, image references false, persistence false, Widget handoff false, and `assetOutputs:none`.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When storage can resume and app-host visual QA is healthy, this bridge can become the final Core evidence before the smallest fish-tail SpriteKit pixel change.

Result:

- Added `SpriteKitFishTailVisibleWorkResumeBridge`.
- Connected the existing fish-tail implementation preflight to the external XCTestDevices storage evidence without allowing the partial storage recovery to open visible SpriteKit work.
- Kept visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: Xcode Doctor Storage Diagnostics

Handwritten complexity:

- The Core gates now record Data-volume and XCTestDevices evidence, but the read-only Xcode helper does not yet print that evidence in the same `doctor` output used before app-host visual QA retries.
- The risk is reattempting Xcode/Simulator visual QA from stale mental state instead of checking current local storage pressure and whether XCTestDevices is still externalized.

Apple framework candidate:

- Continue using Xcode/XCTest/CoreSimulator only through the existing guarded helper.
- No product framework is introduced; this is shell diagnostics around local Apple developer storage.

External library candidate:

- None. `df`, `ls`, and `readlink` are enough for read-only storage evidence.

Decision:

- Extend `tools/xcode/wipet-xcodebuild doctor` with read-only system Data volume, external volume, and XCTestDevices symlink diagnostics.
- Do not run Xcode build/test, do not launch Simulator, do not delete/move developer data, and do not change visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, or image references.

Future replacement point:

- If Data volume and Xcode process health recover, use the enriched `doctor` output as the first preflight before rerunning app-host visual QA.

Result:

- `tools/xcode/wipet-xcodebuild doctor` now prints a read-only storage preflight with system Data volume, the external WiPet volume, and XCTestDevices path/symlink/size evidence.
- Updated the Xcode helper README so `doctor`'s storage scope is explicit.
- Kept Xcode build/test, Simulator launch, visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: Xcode Doctor Storage Resume Verdict

Handwritten complexity:

- The `doctor` output now shows raw storage evidence, but the operator still has to mentally compare Data volume free space against the app-host visual QA threshold.
- The risk is missing that external XCTestDevices is healthy while Data volume remains far below the resume threshold, then retrying Xcode visual QA too early.

Apple framework candidate:

- Continue using the existing Xcode/XCTest/CoreSimulator helper only as a read-only preflight.
- No Apple product framework is introduced.

External library candidate:

- None. A small shell verdict based on `df` and the XCTestDevices symlink is enough.

Decision:

- Add a read-only `storageResumeReady` verdict to `tools/xcode/wipet-xcodebuild doctor`.
- Keep the threshold explicit at 2048MB for now so it matches the Core gates.
- Do not run Xcode build/test, do not launch Simulator, do not mutate storage, and do not change visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, or image references.

Future replacement point:

- If the threshold needs tuning, move it behind a documented helper environment variable and mirror that decision in the Core gate tests.

Result:

- `tools/xcode/wipet-xcodebuild doctor` now prints `WiPet storage resume gate` with Data free MB, minimum Data free MB, external volume availability/free MB, XCTestDevices externalization, and `storageResumeReady`.
- The current read-only verdict is `storageResumeReady:false` because Data volume is still far below 2048MB, even though XCTestDevices is externalized and the external volume has space.
- Updated the Xcode helper README with the storage-resume wording.

## Current Loop: Xcode Doctor Storage Threshold Override

Handwritten complexity:

- `doctor` now reports a storage resume verdict, but the minimum Data-volume threshold is hardcoded in the helper.
- The risk is changing the threshold later in an undocumented one-off edit instead of making the override explicit, visible, and still default-aligned with the Core gates.

Apple framework candidate:

- Continue using the existing helper as read-only shell tooling around Xcode/XCTest/CoreSimulator readiness.
- No product framework is introduced.

External library candidate:

- None. An environment variable is enough for an operator override.

Decision:

- Add `WIPET_MIN_DATA_VOLUME_FREE_MB` to `tools/xcode/wipet-xcodebuild doctor`.
- Keep the default threshold at 2048MB so the helper remains aligned with Core gate tests unless explicitly overridden.
- Keep the override visible in doctor output, and do not run Xcode build/test, launch Simulator, mutate storage, or change visible UI/SpriteKit/Widget/persistence/project/image assets.

Future replacement point:

- If Core gate tests adopt a different default threshold, update the helper default and docs in the same commit.

Result:

- Added `WIPET_MIN_DATA_VOLUME_FREE_MB` support to `tools/xcode/wipet-xcodebuild doctor`.
- The default remains 2048MB and invalid override values fall back to 2048MB.
- Updated the helper README with the override and default-threshold note.

## Current Loop: SpriteKit Fish Tail Recipe Intent

Handwritten complexity:

- The fish-tail cue has gates and fixed-part handoff metadata, but the smallest future SpriteKit pixel edit still needs an explicit handmade recipe intent.
- The recipe must preserve the cue as soft, cute, and motion-friendly rather than sharp, statistical, generated, or label-only.

Apple framework candidate:

- SpriteKit remains the eventual renderer, but this loop does not draw pixels.
- No new Apple framework is needed for a Core metadata contract.

External library candidate:

- None. The recipe intent is WiPet-specific creature art direction and should remain inspectable in tests.

Decision:

- Add a dependency-free Core renderer metadata helper for the fish-tail recipe intent.
- Require `fishTaper`, `softForkFin`, `tailTip`, `softForkedFin`, `secondarySilhouette`, and `cuteMotionRoom`.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When default storage/app-host QA gates recover, use this recipe intent as the direct reference before touching `PartAssembler` fish-tail pixels.

Result:

- Added dependency-free `spriteKitFishTailRecipeIntent` metadata.
- Locked the future fish-tail pixel recipe to `fishTaper`, `softForkFin`, `tailTip`, `secondarySilhouette`, and `cuteMotionRoom`.
- Kept the recipe non-sharp, non-label-only, non-generated, and non-asset-producing.

## Current Loop: SpriteKit Fish Tail Pixel Handoff Gate

Handwritten complexity:

- The fish-tail resume bridge and recipe intent now exist separately; the final pre-pixel handoff needs to prove both are present before `PartAssembler` is touched.
- The handoff must keep the cue affectionate and reversible: no image reference update, Widget handoff, persistence, package/project edit, or generated asset in the same gate.

Apple framework candidate:

- SpriteKit remains the eventual renderer, but this loop does not draw pixels.
- No new Apple framework is needed for the Core handoff contract.

External library candidate:

- None. This is a small safety contract, not rendering, visual regression, random generation, image processing, or 3D asset handling.

Decision:

- Add a dependency-free Core handoff gate that requires the visible-work resume bridge and fish-tail recipe intent before any future SpriteKit pixel edit.
- Keep the current state closed while recipe intent is ready but storage/app-host visual QA is not.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When storage/app-host QA gates recover, open this handoff immediately before the smallest `PartAssembler` fish-tail pixel edit.

Result:

- Added `SpriteKitFishTailPixelHandoffGate`.
- Connected the visible-work resume bridge and fish-tail recipe intent into a final Core gate before any future `PartAssembler` pixel edit.
- Kept the current handoff closed: recipe intent is ready, but `PartAssembler` is untouched, SpriteKit pixels are unchanged, and side effects remain disabled.

## Current Loop: SpriteKit Fish Tail Pixel Handoff QA Label

Handwritten complexity:

- The fish-tail handoff gate is ready, but future app-host visual QA still needs a stable hidden label contract before SpriteKit pixels are changed.
- The label must help QA confirm readiness without becoming player-facing copy, debug clutter, or a reason to mutate `Creature`, Widget handoff, persistence, image references, or generated assets.

Apple framework candidate:

- SpriteKit remains the eventual renderer and XCTest/Simulator remain future visual QA hosts.
- No new Apple framework is needed for this Core-only metadata label.

External library candidate:

- None. SnapshotTesting may later capture the hidden label, but this loop should not add or change snapshot references while app-host QA is still gated.

Decision:

- Add a dependency-free Core QA label around `SpriteKitFishTailPixelHandoffGate`.
- Current state stays hidden and blocked: handoff gate ready, hidden QA label present, no player-facing label, no SpriteKit pixel update, no image reference, no persistence, no Widget handoff, no package/project change, no generated assets, and `assetOutputs:none`.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, generated assets, GLB/USD output, SnapshotTesting references, and image references unchanged.

Future replacement point:

- When storage/app-host QA recovers, expose this exact hidden label in the smallest QA surface before opening the `PartAssembler` fish-tail pixel edit.

Result:

- Added `SpriteKitFishTailPixelHandoffQALabel`.
- Locked the future QA evidence label to hidden metadata, not normal player UI.
- Kept the current state closed: the handoff gate is ready, the label is present, but SpriteKit pixels, image references, persistence, Widget handoff, project files, and generated assets remain untouched.

## Current Loop: Xcode Doctor App-Host Visual QA Resume Verdict

Handwritten complexity:

- `doctor` reports storage and visible Xcode processes, but it does not yet combine them into one read-only app-host visual QA resume verdict.
- The risk is treating external XCTestDevices migration as enough while Data volume is still critically low or Xcode source-control/process churn is still active.

Apple framework candidate:

- Continue using the existing Xcode/XCTest/CoreSimulator helper as a read-only preflight.
- No product framework is introduced and no Xcode build/test is run.

External library candidate:

- None. Shell `df` and `ps` diagnostics are enough for this local readiness verdict.

Decision:

- Extend `tools/xcode/wipet-xcodebuild doctor` with `sourceControlProcessesQuiet`, `xcodebuildProcessesQuiet`, and `appHostVisualQAResumeReady`.
- The verdict is true only when storage is ready, source-control workers are quiet, and unrelated real `xcodebuild` processes are quiet.
- Keep the helper read-only; do not launch Simulator, run Xcode build/test, mutate storage, change visible UI/SpriteKit/Widget/persistence/project/image assets, or override the default storage threshold for real QA decisions.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, retry the smallest targeted app-host visual QA before touching `PartAssembler` fish-tail pixels.

Result:

- `tools/xcode/wipet-xcodebuild doctor` now prints `sourceControlProcessesQuiet`, `xcodebuildProcessesQuiet`, and `appHostVisualQAResumeReady`.
- The verdict stays false unless storage is ready and the app-host process lane is quiet.
- The helper remains read-only and no Xcode build/test or Simulator launch is performed.

## Current Loop: SpriteKit Fish Tail PartAssembler Edit Plan

Handwritten complexity:

- The fish-tail handoff now has QA labels, but the future visible edit still needs a narrow `PartAssembler` edit plan.
- The plan must keep the cue handmade and affectionate: soft fish taper, soft fork fin, tail-tip placement, motion room, and no broad renderer/profile/project churn.

Apple framework candidate:

- SpriteKit remains the eventual renderer and `PartAssembler` remains the handmade cute-shape control surface.
- No new Apple framework is needed because this loop does not create nodes or render pixels.

External library candidate:

- None. A drawing, geometry, snapshot, or asset library would not improve this pre-edit boundary and would risk black-boxing WiPet's creature silhouette judgement.

Decision:

- Add a dependency-free Core `SpriteKitFishTailPartAssemblerEditPlan`.
- Current state stays planned but closed: it names `PartAssembler.swift`, tail layer, `fishTaper`, `softForkFin`, hidden QA label, no SpriteKit pixel update, no image reference, no persistence, no Widget handoff, no package/project change, no generated assets, and `assetOutputs:none`.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, this edit plan should become the checklist immediately before the smallest real `PartAssembler` fish-tail pixel change.

Result:

- Added `SpriteKitFishTailPartAssemblerEditPlan`.
- Locked the future fish-tail pixel edit to `PartAssembler.swift`, the tail layer, `fishTaper`, `softForkFin`, `tailTip`, the hidden QA label, and motion room.
- Kept the current state closed: no `PartAssembler` edit, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Geometry Recipe

Handwritten complexity:

- The edit plan names where the future fish-tail change belongs, but the handmade geometry still needs affectionate proportions before pixels change.
- The risk is accidentally making the fish tail sharp, long, stat-like, or too stiff for tail motion when `PartAssembler` is finally edited.

Apple framework candidate:

- SpriteKit remains the future renderer, but this loop does not create `SKShapeNode` paths or run visual QA.
- No new Apple framework is needed for a Core geometry recipe contract.

External library candidate:

- None. A geometry or drawing package would not improve cuteness, and it would hide the tiny silhouette decisions that should stay handmade.

Decision:

- Add a dependency-free Core `SpriteKitFishTailGeometryRecipe`.
- Current state is recipe-ready but pixel-closed: short soft tail length, rounded taper, shallow fork, soft fork spread, motion room, no sharp tip, no generated path, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, no generated assets, and `assetOutputs:none`.
- Keep `PartAssembler`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When app-host visual QA resumes, use this geometry recipe as the parameter checklist for the smallest `PartAssembler` fish-tail path edit.

Result:

- Added `SpriteKitFishTailGeometryRecipe`.
- Locked the future fish-tail path proportions to a short rounded taper with shallow fork depth, soft fork spread, and motion room.
- Kept the current state recipe-ready but pixel-closed: no generated path, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Motion Room Recipe

Handwritten complexity:

- The fish-tail geometry is soft, but the future visible path also needs to stay friendly under the existing tail sway.
- The risk is making a cute still silhouette that becomes stiff, cramped, or sharp-looking once `MotionGenes.tailMotion` drives subtle movement.

Apple framework candidate:

- Keep SpriteKit and the existing `SKAction` motion path for the future renderer.
- No new Apple framework is needed because this loop does not change animation timing or run a SpriteKit scene.

External library candidate:

- None. A physics, tweening, or animation package would not improve this small pre-motion contract and would add dependency risk before visual QA can run.

Decision:

- Add a dependency-free Core `SpriteKitFishTailMotionRoomRecipe`.
- Current state stays motion-ready but pixel-closed: geometry recipe ready, tail motion gene range named, gentle sway degrees, anchor at tail root, no animation timing change, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When app-host visual QA resumes, use this recipe to verify the fish-tail path still has cute motion room under the existing tail sway.

Result:

- Added `SpriteKitFishTailMotionRoomRecipe`.
- Locked the future fish-tail motion room to the existing `MotionGenes.tailMotion` range, gentle sway degrees, stable tail-root anchor, existing `SKAction` timing, and no physics simulation.
- Kept the current state motion-ready but pixel-closed: no animation timing change, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Path Point Recipe

Handwritten complexity:

- The fish-tail geometry and motion room are defined, but the future `PartAssembler` edit still needs a small handmade path-point order.
- The risk is turning the visible implementation into a broad drawing experiment instead of a tiny affectionate tail silhouette change.

Apple framework candidate:

- SpriteKit remains the future renderer for the actual path.
- No new Apple framework is needed because this loop records the path recipe only and does not create `SKShapeNode` geometry.

External library candidate:

- None. A path or vector library would not improve this small point-order contract and would obscure the handmade cute silhouette judgement.

Decision:

- Add a dependency-free Core `SpriteKitFishTailPathPointRecipe`.
- Current state stays path-ready but pixel-closed: tail-root anchor, six-point soft fork order, rounded quadratic intent, no generated path, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When app-host visual QA resumes, copy this point order into the smallest `PartAssembler` path edit and verify the visible fish-tail cue.

Result:

- Added `SpriteKitFishTailPathPointRecipe`.
- Locked the future fish-tail path to a tail-root anchor, six-point soft fork order, rounded quadratic curve intent, closed path, and shallow notch.
- Kept the current state path-ready but pixel-closed: no generated path, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Style Recipe

Handwritten complexity:

- The fish-tail path recipe is ready, but the future visible edit still needs a soft style contract so the tail reads as an affectionate creature cue instead of a hard badge or stat marker.
- The style must preserve the existing tail palette, secondary silhouette, subtle alpha, and tiny line width while keeping SpriteKit pixels closed until app-host visual QA can run.

Apple framework candidate:

- SpriteKit remains the future renderer for fill/stroke application in `PartAssembler`.
- No new Apple framework is needed because this loop records style values only and does not create `SKShapeNode` pixels.

External library candidate:

- None. A styling, vector, or snapshot dependency would not improve this small pre-pixel contract and would risk hiding WiPet's handmade cute silhouette judgement.

Decision:

- Add a dependency-free Core `SpriteKitFishTailStyleRecipe`.
- Current state stays style-ready but pixel-closed: path recipe ready, existing tail palette required, soft fill/stroke names required, subtle alpha and line width ranges required, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When app-host visual QA resumes, use this style recipe as the fill/stroke checklist for the smallest `PartAssembler` fish-tail path edit.

Result:

- Added `SpriteKitFishTailStyleRecipe`.
- Locked the future fish-tail style to `tailFill`, `tailSoftRim`, subtle alpha ranges, small line width, the tail layer, existing tail palette reuse, and secondary silhouette preservation.
- Kept the current state style-ready but pixel-closed: no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Implementation Bundle

Handwritten complexity:

- The fish-tail edit plan, geometry, motion room, point order, and style now exist separately, but the future visible edit needs one final handoff bundle before `PartAssembler` is touched.
- The bundle must prove the affectionate fish-tail cue is complete, still pixel-closed, and limited to the smallest future SpriteKit edit.

Apple framework candidate:

- SpriteKit remains the future renderer and `PartAssembler` remains the handmade shape surface.
- No new Apple framework is needed because this loop only composes existing Core contracts and does not draw pixels.

External library candidate:

- None. SnapshotTesting can later verify rendered pixels, but this loop should not add references or a dependency while app-host visual QA is still gated.

Decision:

- Add a dependency-free Core `SpriteKitFishTailImplementationBundle`.
- Current state stays bundle-ready but pixel-closed: style recipe ready, target file `PartAssembler.swift`, renderer `SpriteKit`, scope `fishTailOnly`, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, use this bundle as the final preflight before the smallest visible `PartAssembler` fish-tail path/style edit.

Result:

- Added `SpriteKitFishTailImplementationBundle`.
- Composed the fish-tail edit plan, geometry, motion room, point order, and style into one final Core handoff for the future `PartAssembler` edit.
- Kept the current state implementation-bundle-ready but pixel-closed: no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Implementation Bundle QA Label

Handwritten complexity:

- The final implementation bundle exists, but future app-host visual QA still needs one stable hidden label to confirm the handoff without exposing technical checklist text to the player.
- The label must prove the bundle is ready and pixel-closed now, then confirm a future visible implementation only after the bundle itself opens.

Apple framework candidate:

- SpriteKit remains the future renderer and XCTest/app-host QA remains the future verification surface.
- No new Apple framework is needed because this loop only defines hidden Core QA metadata.

External library candidate:

- SnapshotTesting remains useful for future semantic/image evidence, but app-host visual QA is currently gated and this loop should not update snapshot references.
- No external dependency is added.

Decision:

- Add a dependency-free Core `SpriteKitFishTailImplementationBundleQALabel`.
- Current state stays hidden-label-ready but pixel-closed: implementation bundle ready, hidden QA metadata ready, no player-facing label, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, surface this hidden label in the smallest QA host before applying the visible `PartAssembler` fish-tail edit.

Result:

- Added `SpriteKitFishTailImplementationBundleQALabel`.
- Locked the future QA evidence label to hidden metadata for the final fish-tail implementation bundle.
- Kept the current state hidden-label-ready but pixel-closed: no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Implementation Bundle QA Surface Gate

Handwritten complexity:

- The hidden bundle label is ready, but surfacing it in an app-host QA view is still a UI/snapshot change and must wait for app-host visual QA to resume.
- The gate must separate "the hidden label contract is ready" from "it is safe to expose that label in a QA host".

Apple framework candidate:

- SwiftUI/XCTest remain the future QA host path and SpriteKit remains the future renderer.
- No new Apple framework is needed because this loop only defines the Core exposure gate.

External library candidate:

- SnapshotTesting remains the future semantic reference tool for the QA host, but references must not change while app-host visual QA is gated.
- No external dependency is added.

Decision:

- Add a dependency-free Core `SpriteKitFishTailImplementationBundleQASurfaceGate`.
- Current state stays surface-gate-ready but exposure-closed: hidden label ready, target QA host named, hidden accessibility identifier named, app-host visual QA resume required, no QA host label update, no snapshot reference update, no visible pixels, and no side effects.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, use this gate to add the hidden label to the smallest QA host and update only the matching semantic snapshot reference.

Result:

- Added `SpriteKitFishTailImplementationBundleQASurfaceGate`.
- Separated hidden label readiness from app-host QA surface exposure readiness.
- Kept the current state surface-gate-ready but exposure-closed: no QA host label update, no snapshot reference update, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Implementation Bundle QA Surface Patch Plan

Handwritten complexity:

- The QA surface gate names when exposure is safe, but the future patch still needs a narrow file-level plan so it does not spread into normal UI, renderer code, or unrelated snapshot references.
- The plan must keep the evidence hidden and semantic: one QA host, one hidden label identifier, one matching `.lines` reference, and no visible pixel changes.

Apple framework candidate:

- SwiftUI/XCTest remain the future QA host path.
- No new Apple framework is needed because this loop only defines the patch plan.

External library candidate:

- SnapshotTesting remains the future semantic evidence tool, but no reference is updated while app-host visual QA is gated.
- No external dependency is added.

Decision:

- Add a dependency-free Core `SpriteKitFishTailImplementationBundleQASurfacePatchPlan`.
- Current state stays patch-plan-ready but unapplied: QA surface gate ready, target file `GenomeVariationQAView.swift`, hidden label identifier `spriteKitFishTailImplementationBundle`, snapshot reference `SnapshotHostGenomeVariationTests.lines`, no QA host edit, no snapshot reference update, no visible pixels, and no side effects.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, use this patch plan to apply the hidden QA label and update only the matching semantic snapshot reference.

Result:

- Added `SpriteKitFishTailImplementationBundleQASurfacePatchPlan`.
- Locked the future hidden QA surface patch to `GenomeVariationQAView.swift`, hidden identifier `spriteKitFishTailImplementationBundle`, and semantic reference `SnapshotHostGenomeVariationTests.lines`.
- Kept the current state patch-plan-ready but unapplied: no QA host file update, no snapshot reference update, no SpriteKit pixels, no image reference, no persistence, no Widget handoff, no package/project change, and no generated assets.

## Current Loop: SpriteKit Fish Tail Implementation Readiness Ledger

Handwritten complexity:

- Fish-tail readiness is now split across bundle, hidden label, QA surface gate, and patch plan contracts.
- A small ledger is needed so future work can tell what is ready, what is still blocked by app-host QA, and what the next safe action is without reopening broad renderer or snapshot changes.

Apple framework candidate:

- SpriteKit, SwiftUI, XCTest, and SnapshotTesting remain the future implementation/verification path.
- No new Apple framework is needed because this loop only summarizes existing Core contracts.

External library candidate:

- No external dependency is added. SnapshotTesting remains future evidence after app-host visual QA resumes.

Decision:

- Add a dependency-free Core `SpriteKitFishTailImplementationReadinessLedger`.
- Current state reports bundle, hidden label, and patch plan readiness, while QA exposure and visible implementation remain blocked.
- Keep `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- When `appHostVisualQAResumeReady:true`, use the ledger to confirm the next action is hidden QA host exposure before any visible `PartAssembler` pixel edit.

Result:

- Added `SpriteKitFishTailImplementationReadinessLedger`.
- Aggregated bundle, hidden label, QA surface gate, and QA surface patch plan readiness into one Core status summary.
- Current next safe action is `waitForAppHostVisualQAResume`; visible fish-tail pixels remain blocked.
- Kept `PartAssembler`, `CreatureNode`, visible UI, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

## Current Loop: Fixed Part Asset Pipeline Readiness Ledger

Handwritten complexity:

- Fixed-part 3D readiness is split across the manifest, CommonPetRig preflight, reference acceptance gate, and asset-pipeline resume gate.
- A small ledger is needed so future 3D work can tell whether the next action is still reference/manual QA or whether ModelIO/SceneKit/RealityKit validation may resume.

Apple framework candidate:

- ModelIO, SceneKit, and RealityKit remain the right future Apple framework candidates for GLB/USD import, socket preview, and validation.
- They are not adopted in this loop because there is still no accepted reference artifact or real GLB/USD candidate.

External library candidate:

- No external 3D or validation package is adopted. Asset import/export remains a future Apple-framework lane first.

Decision:

- Add dependency-free Core metadata helpers for a `fixedPartAssetPipelineReadinessLedger`.
- Current state reports manifest/reference gates as ready, rig validation safely deferred, app-host/manual reference acceptance blocked, ModelIO/SceneKit/RealityKit deferred, and next action as `waitForReferenceAndAppHostQA`.
- Keep visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, generated PNG/GLB/USD output, ModelIO, SceneKit, RealityKit, and image references unchanged.

Future replacement point:

- When accepted reference artifacts and app-host QA are ready, use this ledger before opening a dedicated ModelIO validation loop.

Result:

- Added `fixedPartAssetPipelineReadinessLedger` Core metadata helpers.
- Added `RendererMetadataSummary.fixedPartAssetPipelineReadinessLedgerSummary`.
- Added readiness validation for the current blocked state and the future `beginModelIOValidation` next action.
- The ledger reports the current blocked state as `waitForReferenceAndAppHostQA` while ModelIO, SceneKit, RealityKit, generation, runtime loading, and asset outputs remain closed.
- Kept ModelIO, SceneKit, RealityKit, generated PNG/GLB/USD output, runtime asset loading, visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, and image references unchanged.

## Current Loop: SpriteKit Visible QA Environment Ledger

Handwritten complexity:

- Storage and Xcode tool lookup have recovered, but another `xcodebuild` is still visible, so the app-host visual QA gate is not quiet.
- Fish-tail visible implementation must not start merely because storage is ready; it also needs quiet Xcode processes and a runnable Simulator check.

Apple framework candidate:

- Xcode command line tools, `xcodebuild`, and CoreSimulator remain the required Apple tooling for visual QA.
- No new Apple framework is adopted in code; this loop only records the environment gate.

External library candidate:

- SnapshotTesting remains the future evidence tool after a simulator can run.
- No external dependency is added because a package cannot fix a missing Xcode developer directory.

Decision:

- Add a dependency-free Core `SpriteKitVisibleQAEnvironmentLedger`.
- Current state records storage, Xcode developer path, `xcodebuild`, and `simctl` as ready while the visible `xcodebuild` process keeps app-host visual QA blocked.
- Keep `PartAssembler`, `CreatureNode`, visible UI, SpriteKit drawing, Widget handoff, persistence, Package.swift, Xcode project files, SnapshotTesting references, generated assets, GLB/USD output, and image references unchanged.

Future replacement point:

- Once Xcode processes are quiet and the Simulator launch can be verified, use this ledger before exposing the hidden fish-tail QA surface or changing visible SpriteKit pixels.
