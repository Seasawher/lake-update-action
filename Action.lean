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

  let buildResult ← tryBuild
  if buildResult.isFailure then
    IO.println "lakeパッケージのビルドが失敗しました。"

    -- gh コマンドでイシューを作成できるかどうか確認する
    let _ ← runCmd #["gh", "issue", "create", "--title", "Test", "--body", "this is test"] none
    return 0

  return 0
