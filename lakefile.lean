import Lake
open Lake DSL

package "Action" where
  version := v!"0.1.0"

@[default_target]
lean_lib «Action» where
  -- add library configuration options here
