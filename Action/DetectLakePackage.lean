module

import Action.Input
import Action.Output

/-- 入力で指定されたディレクトリがlakeパッケージであるか判定する -/
public def detectLakePackage : IO Bool := do
  let lakePackageDirectory ← Input.lake_package_directory
  let toolchainPath : System.FilePath := lakePackageDirectory / "lean-toolchain"
  let lakePackageExists ← toolchainPath.pathExists
  setOutput "lake_package_exists" (toString lakePackageExists)
  return lakePackageExists
