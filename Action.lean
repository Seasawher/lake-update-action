module

import Action.GH.CreateIssue
import Action.DetectLakePackage
import Action.Input
import Action.RunCmd
import Action.TryBuild
import Action.Notify

/-- エントリーポイント -/
public def main (_ : List String) : IO UInt32 := do
  let isLakePackage ← detectLakePackage
  if ! isLakePackage then
    IO.println "指定されたディレクトリはlakeパッケージではありません。"
    return 1

  let result ← tryBuild
  let way ← Input.on_update_fails
  notify way result

  return 0
