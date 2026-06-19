from typing import Any, Dict

import requests

DEFAULT_TIMEOUT = 30


def _request(method: str, url: str, **kwargs) -> requests.Response:
    headers = kwargs.pop("headers", {}) or {}
    headers.setdefault("accept", "application/json")
    headers.setdefault("Content-Type", "application/x-www-form-urlencoded")

    return requests.request(
        method=method,
        url=url,
        headers=headers,
        timeout=DEFAULT_TIMEOUT,
        **kwargs,
    )


def _json(response: requests.Response) -> Dict[str, Any]:
    try:
        return response.json()
    except ValueError as exc:
        raise AssertionError(
            f"Expected JSON response, got status {response.status_code}: {response.text[:500]}"
        ) from exc


def _assert_status(response: requests.Response, expected_statuses: tuple[int, ...]) -> Dict[str, Any]:
    body = _json(response)
    if response.status_code not in expected_statuses:
        raise AssertionError(
            f"Unexpected API status {response.status_code}. Expected {expected_statuses}. Body: {body}"
        )
    return body


def register_user_through_api(api_url: str, name: str, email: str, password: str) -> Dict[str, Any]:
    payload = {"name": name, "email": email, "password": password}
    response = _request("POST", f"{api_url}/users/register", data=payload)

    if response.status_code == 409:
        return _json(response)

    return _assert_status(response, (200, 201))


def login_user_through_api(api_url: str, email: str, password: str) -> str:
    payload = {"email": email, "password": password}
    response = _request("POST", f"{api_url}/users/login", data=payload)
    body = _assert_status(response, (200,))

    token = body.get("data", {}).get("token")
    if not token:
        raise AssertionError(f"Login response did not include token. Body: {body}")

    return token


def create_note_through_api(
    api_url: str,
    token: str,
    title: str,
    description: str,
    category: str,
) -> str:
    payload = {"title": title, "description": description, "category": category}
    response = _request(
        "POST",
        f"{api_url}/notes",
        data=payload,
        headers={"X-Auth-Token": token},
    )
    body = _assert_status(response, (200, 201))

    note_id = body.get("data", {}).get("id")
    if not note_id:
        raise AssertionError(f"Create note response did not include note id. Body: {body}")

    return note_id


def update_note_through_api(
    api_url: str,
    token: str,
    note_id: str,
    title: str,
    description: str,
    category: str,
    completed: bool,
) -> Dict[str, Any]:
    payload = {
        "title": title,
        "description": description,
        "category": category,
        "completed": str(bool(completed)).lower(),
    }
    response = _request(
        "PUT",
        f"{api_url}/notes/{note_id}",
        data=payload,
        headers={"X-Auth-Token": token},
    )
    return _assert_status(response, (200,))


def get_note_through_api(api_url: str, token: str, note_id: str) -> Dict[str, Any]:
    response = _request(
        "GET",
        f"{api_url}/notes/{note_id}",
        headers={"X-Auth-Token": token},
    )
    return _assert_status(response, (200,))


def delete_note_through_api(api_url: str, token: str, note_id: str) -> Dict[str, Any]:
    response = _request(
        "DELETE",
        f"{api_url}/notes/{note_id}",
        headers={"X-Auth-Token": token},
    )
    if response.status_code in (200, 204, 404):
        return _json(response) if response.text else {"status": response.status_code}
    return _assert_status(response, (200, 204, 404))
