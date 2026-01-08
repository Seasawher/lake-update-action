module

open IO Process System

/-- コマンドを実行するための補助的な関数 -/
public def runCmd (command : Array String) (cwd : Option FilePath) (stdin : Option String := none) :
    IO String := do
  let cmd := command[0]!
  let args := command.drop 1
  let out ← IO.Process.output
    (args := {cmd := cmd, args := args, cwd := cwd})
    (input? := stdin)

  unless out.exitCode = 0 do
    throw <| IO.userError out.stderr

  let output := out.stdout
  if ! output.isEmpty then
    IO.print output
  return output
