#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-QA1}"

if [ -d ".venv" ]; then
  # shellcheck source=/dev/null
  source .venv/bin/activate
fi

if [ -z "${ANDROID_HOME:-}" ] && [ -z "${ANDROID_SDK_ROOT:-}" ]; then
  echo "ERROR: ANDROID_HOME or ANDROID_SDK_ROOT is not configured."
  echo "Install Android Studio/SDK and export, for example:"
  echo "export ANDROID_HOME=\$HOME/Android/Sdk"
  echo "export ANDROID_SDK_ROOT=\$ANDROID_HOME"
  echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/emulator:\$ANDROID_HOME/cmdline-tools/latest/bin"
  exit 1
fi

echo "Running mobile tests for ${ENVIRONMENT}"
robot -d "results/mobile/${ENVIRONMENT}" -v ENV:"${ENVIRONMENT}" tests/mobile
