{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pytestCheckHook
, pytest-asyncio
, pretend
, freezegun
, hatch-fancy-pypi-readme
, hatch-vcs
, hatchling
, simplejson
, typing-extensions
, pythonAtLeast
}:

buildPythonPackage rec {
  pname = "structlog";
  version = "23.1.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "hynek";
    repo = "structlog";
    rev = "refs/tags/${version}";
    hash = "sha256-0zHvBMiZB4cGntdYXA7C9V9+FfnDB6sHGuFRYAo/LJw=";
  };

  nativeBuildInputs = [
    hatch-fancy-pypi-readme
    hatch-vcs
    hatchling
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  propagatedBuildInputs = lib.optionals (pythonOlder "3.8") [
    typing-extensions
  ];

  pythonImportsCheck = [
    "structlog"
  ];

  nativeCheckInputs = [
    freezegun
    pretend
    pytest-asyncio
    pytestCheckHook
    simplejson
  ];

  meta = with lib; {
    description = "Painless structural logging";
    homepage = "https://github.com/hynek/structlog";
    changelog = "https://github.com/hynek/structlog/blob/${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
