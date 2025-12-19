module

namespace Input

/-- 指定された名前の入力を取得する -/
public protected def get (name : String) : IO String := do
  match (← IO.getEnv (s!"INPUT_{name.toUpper}")) with
  | some input => return input
  | none =>
    throw <| IO.userError s!"入力 '{name}' が渡されていません。"

/-- 更新するべきLakeパッケージが存在するディレクトリ。 -/
public protected def lakePackageDirectory : IO System.FilePath := do
  let dirStr ← Input.get "lake_package_directory"
  return System.FilePath.mk dirStr

end Input
