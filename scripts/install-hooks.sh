#!/usr/bin/env bash
# Active les hooks versionnes du depot.
git config core.hooksPath scripts/hooks
echo "Hooks actives (core.hooksPath = scripts/hooks)."
