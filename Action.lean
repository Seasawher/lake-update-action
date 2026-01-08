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

    -- gh コマンドのバージョン確認
    -- これは単なるインストール確認なので、後で削除する
    let _ ← runCmd "gh --version" "."
    return 0

  return 0
