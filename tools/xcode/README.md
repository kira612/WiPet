# WiPet Xcode Helper

Use `tools/xcode/wipet-xcodebuild` for guarded local Xcode verification.

The helper keeps WiPet build gates small and repeatable:

- DerivedData defaults to `/tmp`.
- `WIPET_TMPDIR` can move default DerivedData and result bundles off the system
  Data volume.
- `WIPET_CLONED_SOURCE_PACKAGES_DIR` can move Xcode's SwiftPM checkout cache
  off the system Data volume.
- `xcodebuild` runs with a timeout so silent stalls do not leave the loop hanging.
- Timeout logs include the active DerivedData path, cloned source package cache
  path, their sizes when present, and a short related-process snapshot.
- Simulator builds avoid code signing and indexing by default.
- The helper kills only the child `xcodebuild` process it starts.

Examples:

```sh
tools/xcode/wipet-xcodebuild app-build
tools/xcode/wipet-xcodebuild snapshot-build
tools/xcode/wipet-xcodebuild snapshot-test \
  -only-testing:WiPetSnapshotTests/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness
tools/xcode/wipet-xcodebuild widget-build
tools/xcode/wipet-xcodebuild list
tools/xcode/wipet-xcodebuild doctor
tools/xcode/wipet-xcodebuild project-summary
```

Override defaults with environment variables:

```sh
WIPET_XCODEBUILD_TIMEOUT_SECONDS=600 \
WIPET_TMPDIR="/Volumes/WD_BLACK SN770 500GB Media/WiPetBuildArtifacts/tmp" \
WIPET_DERIVED_DATA_PATH="/Volumes/WD_BLACK SN770 500GB Media/WiPetBuildArtifacts/WiPetCustomDerived" \
WIPET_CLONED_SOURCE_PACKAGES_DIR="/Volumes/WD_BLACK SN770 500GB Media/WiPetBuildArtifacts/SourcePackages" \
tools/xcode/wipet-xcodebuild snapshot-build
```

For `doctor`, `WIPET_MIN_DATA_VOLUME_FREE_MB` can override the storage resume
threshold. The default is `2048`, matching the Core visual-QA gates.

`snapshot-build` and `snapshot-test` use a concrete available iOS Simulator by
default, because generic simulator destinations can stall after Simulator data
migration. Set `WIPET_SIMULATOR_ID` to pin both commands, or
`WIPET_SNAPSHOT_BUILD_DESTINATION` to override only the build destination.

`snapshot-test` runs an already-built `WiPetSnapshotTests` `.xctestrun` with
`test-without-building`. It defaults result bundles to `$TMPDIR` and uses the same
timeout guard as the build commands. Set `WIPET_TMPDIR` when the system Data
volume is tight. Run `snapshot-build` first, or set
`WIPET_XCTESTRUN_PATH` explicitly.

```sh
WIPET_DERIVED_DATA_PATH=/tmp/WiPetDerivedData \
WIPET_RESULT_BUNDLE_PATH=/tmp/WiPetGenomeVariationQA.xcresult \
tools/xcode/wipet-xcodebuild snapshot-test \
  -only-testing:WiPetSnapshotTests/SnapshotHostGenomeVariationTests/testGenomeVariationSnapshotHostExposesTargetEntryReadiness
```

Use `WIPET_XCODEBUILD_DRY_RUN=1` to print the resolved command without running
Xcode.

`doctor` is read-only. It reports visible Xcode source-control git churn,
visible `xcodebuild` processes, `.git/index.lock`, the selected Xcode, system
Data volume space, the external WiPet volume, XCTestDevices storage, and
whether storage and process quietness are ready to resume app-host visual QA.
It also reports available simulator runtimes. It does not kill processes or
modify Simulator/XCTestDevices data.

`project-summary` is also read-only. It lints `project.pbxproj`, lints shared
schemes, and prints targets/schemes without invoking `xcodebuild -list`.
