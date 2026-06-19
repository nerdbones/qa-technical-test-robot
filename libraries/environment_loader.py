from pathlib import Path
from typing import Any, Dict

import yaml


def _resolve_config_path(config_path: str) -> Path:
    path = Path(config_path)
    if path.exists():
        return path

    project_root = Path(__file__).resolve().parents[1]
    resolved = project_root / config_path
    if resolved.exists():
        return resolved

    raise FileNotFoundError(f"Config file not found: {config_path}")


def get_environment_config(environment: str, config_path: str = "config/environments.yaml") -> Dict[str, Any]:
    """Return the full configuration for a given environment."""
    path = _resolve_config_path(config_path)

    with path.open("r", encoding="utf-8") as file:
        configs = yaml.safe_load(file) or {}

    if environment not in configs:
        available = ", ".join(configs.keys())
        raise ValueError(
            f"Environment '{environment}' not found. Available environments: {available}"
        )

    return configs[environment]


def get_environment_value(environment: str, key: str, config_path: str = "config/environments.yaml") -> Any:
    """Robot keyword: Get Environment Value."""
    config = get_environment_config(environment, config_path)

    if key not in config:
        raise KeyError(f"Key '{key}' not found for environment '{environment}'")

    return config[key]
