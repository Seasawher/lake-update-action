import Lake
open Lake DSL

package "Hello" where
  version := v!"0.1.0"

@[default_target]
lean_lib «Hello» where
  -- add library configuration options here
  globs := #[.submodules `Hello]
