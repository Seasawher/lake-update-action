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

/-- ビルドが成功したかどうか -/
public def BuildResult.isSuccess : BuildResult → Bool
  | .success => true
  | .failure _ => false

/-- `lake build` を試みる -/
public def tryBuild : IO BuildResult := do
  let dir ← Input.lake_package_directory
  try
    let _ ← runCmd #["lake", "build"] (cwd := dir)
    setOutput "lake_build_result" "success"
    return BuildResult.success
  catch e =>
    setOutput "lake_build_result" "failure"
    return BuildResult.failure e.toString
