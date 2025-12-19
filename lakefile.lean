import Lake
open Lake DSL

package "Action" where
  leanOptions := #[
    ⟨`linter.missingDocs, true⟩
  ]

@[default_target]
lean_lib «Action» where
  globs := #[.submodules `Action]

lean_exe action where
  root := `Action
