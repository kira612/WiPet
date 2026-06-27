# WiPet SwiftPM Helper

Use `tools/swift/wipet-swift-test` for guarded SwiftPM verification.

The helper keeps Core test runs repeatable while the system Data volume is
tight:

- `swift test` runs with a timeout so silent stalls do not leave the loop
  hanging.
- `WIPET_SWIFTPM_SCRATCH_PATH` can move SwiftPM's `.build` scratch path off the
  system Data volume.
- After SwiftPM exits, the helper reports whether a workspace `.build` directory
  is absent or present. Treat a present workspace `.build` as generated local
  state unless a task explicitly asks to commit build artifacts.
- Extra arguments are passed through to `swift test`.

Example:

```sh
WIPET_SWIFT_TEST_TIMEOUT_SECONDS=300 \
WIPET_SWIFTPM_SCRATCH_PATH="/Volumes/WD_BLACK SN770 500GB Media/WiPetBuildArtifacts/SwiftPMBuild" \
tools/swift/wipet-swift-test --quiet
```

Use `WIPET_SWIFT_TEST_DRY_RUN=1` to print the resolved command without running
SwiftPM.
