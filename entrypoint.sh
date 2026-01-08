#!/usr/bin/env bash
set -euo pipefail

git config --global --add safe.directory /github/workspace

lake exe action
