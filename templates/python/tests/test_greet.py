from python_project import greet


def test_greet_returns_greeting() -> None:
    assert greet("dev") == "hello dev"
