module

open System

namespace Input

public section

/-- 指定された名前の入力を取得する -/
protected def get (name : String) : IO String := do
  match (← IO.getEnv (s!"INPUT_{name.toUpper}")) with
  | some input => return input
  | none =>
    throw <| IO.userError s!"入力 '{name}' が渡されていません。"

/-- 更新するべきLakeパッケージが存在するディレクトリ。 -/
protected def lake_package_directory : IO FilePath := do
  let dirStr ← Input.get "lake_package_directory"
  return FilePath.mk dirStr

/-- ユーザへの通知方法 -/
inductive WayToNotify where
  /-- issue を作成する -/
  | issue
  /-- 通知しない -/
  | silent
export WayToNotify (issue silent)

/-- 更新後のチェックが失敗した場合にどのようにしてユーザに通知するか。 -/
protected def on_update_fails : IO WayToNotify := do
  let way ← Input.get "on_update_fails"
  if way = "issue" then
    return WayToNotify.issue
  else if way = "silent" then
    return WayToNotify.silent
  else
    throw <| IO.userError s!"on_update_fails に不正な入力値 '{way}' が渡されました。"

end

end Input
