module

import Action.GH.CreateIssue
import Action.DetectLakePackage
import Action.Input
import Action.RunCmd
import Action.TryBuild

def issueTitle := "ビルド失敗"

/-- エントリーポイント -/
public def main (_ : List String) : IO UInt32 := do
  let isLakePackage ← detectLakePackage
  if ! isLakePackage then
    IO.println "指定されたディレクトリはlakeパッケージではありません。"
    return 1

  let buildResult ← tryBuild

  match buildResult with
  | .failure errorMsg => GH.createIssue issueTitle errorMsg
  | .success => pure ()

  return 0
