module

import Action.Input
import Action.Output
import Action.RunCmd

/-- ビルド結果 -/
public inductive BuildResult where
  /-- 成功 -/
  | success
  /-- 失敗 -/
  | failure (errorMsg : String)

/-- ビルドが失敗したかどうか -/
public def BuildResult.isFailure : BuildResult → Bool
  | .success => false
  | .failure _ => true

/-- `lake build` を試みる -/
public def tryBuild : IO BuildResult := do
  let lakePackageDirectory ← Input.lakePackageDirectory
  try
    let _ ← runCmd "lake build" (cwd := lakePackageDirectory)
    setOutput "lake_build_result" "success"
    return BuildResult.success
  catch e =>
    setOutput "lake_build_result" "failure"
    return BuildResult.failure e.toString
