module

open IO Process System

/-- コマンドを実行するための補助的な関数 -/
public def runCmd (command : String) (cwd : Option FilePath) (stdin : Option String := none) :
    IO String := do
  let cmdList := command.splitOn " "
  let cmd := cmdList.head!
  let args := cmdList.tail |>.toArray
  let out ← IO.Process.output
    (args := {cmd := cmd, args := args, cwd := cwd})
    (input? := stdin)

  unless out.exitCode = 0 do
    throw <| IO.userError s!"Failed to execute: {command}\n{out.stderr}"

  let output := out.stdout.trimAscii.copy
  if ! output.isEmpty then
    IO.println output
  return output
