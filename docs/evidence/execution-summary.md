# Execution Summary

## Web execution

The web suite is designed to run for the three configured environments:

```bash
robot -d results/web/QA1 -v ENV:QA1 tests/web
robot -d results/web/QA2 -v ENV:QA2 tests/web
robot -d results/web/QA3 -v ENV:QA3 tests/web
```

The same execution can be triggered with:

```bash
bash scripts/run_web_all_envs.sh
```

For each execution, Robot Framework generates:

- `log.html`
- `report.html`
- `output.xml`
- validation screenshots

## CI evidence

The GitHub Actions workflow runs the web suite in a matrix for QA1, QA2 and QA3 and uploads Robot Framework reports as workflow artifacts.

## Mobile execution

The mobile suite is available at:

```text
tests/mobile/mobile_equipment_flow.robot
```

It requires local Android infrastructure:

- Appium Server;
- Android SDK;
- `ANDROID_HOME` or `ANDROID_SDK_ROOT`;
- Android emulator or physical Android device;
- Chrome installed on the Android device.

If `adb devices` does not show a connected device with status `device`, the mobile suite cannot be executed locally.
