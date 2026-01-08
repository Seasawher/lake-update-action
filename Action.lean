module

import Action.DetectLakePackage
import Action.Input
import Action.RunCmd
import Action.TryBuild

/-- エントリーポイント -/
public def main (_ : List String) : IO UInt32 := do
  let isLakePackage ← detectLakePackage
  if ! isLakePackage then
    IO.println "指定されたディレクトリはlakeパッケージではありません。"
    return 1

  let _ ← tryBuild

  -- gh コマンドがインストールできているか確認する
  let _ ← runCmd #["gh", "--version"] none

  return 0
