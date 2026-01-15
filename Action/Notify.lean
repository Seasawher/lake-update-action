module

public import Action.Input
public import Action.TryBuild
import Action.GH.CreateIssue

open Input

/-- ビルド結果に基づいてユーザに通知を出す -/
public def notify (way : WayToNotify) (result : BuildResult) : IO Unit := do
  match way with
  | .silent => pure ()
  | .issue =>
    match result with
    | .success => pure ()
    | .failure errorMsg =>
      GH.createIssue "ビルド失敗" errorMsg
