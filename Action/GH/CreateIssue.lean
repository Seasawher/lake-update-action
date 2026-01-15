module

import Action.RunCmd

namespace GH

/-- `gh issue create` で issue を作成する -/
public def createIssue (title body : String) : IO Unit := do
  match (← IO.getEnv "GITHUB_REPOSITORY") with
  | some repo =>
    let _ ← runCmd #["gh", "issue", "create", "--repo", repo, "--title", title, "--body", body] none
    pure ()
  | none =>
    throw <| IO.userError "環境変数 GITHUB_REPOSITORY が設定されていません。"

end GH
