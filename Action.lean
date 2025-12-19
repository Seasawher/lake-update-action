module

import Action.Input
import Action.Output

/-- エントリーポイント -/
public def main (_ : List String) : IO UInt32 := do
  let lakePackageDirectory ← Input.lakePackageDirectory

  let toolchainPath : System.FilePath := lakePackageDirectory / "lean-toolchain"

  let lakePackageExists ← toolchainPath.pathExists

  setOutput "lake_package_exists" (toString lakePackageExists)

  return 0
