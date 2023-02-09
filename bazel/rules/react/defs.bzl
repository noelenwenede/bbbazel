load("@aspect_rules_js//js:defs.bzl", "js_run_devserver", "js_library", "js_test")
load("@npm//:react-scripts/package_json.bzl", cra_bin = "bin")
load("@jest//:defs.bzl", "jest_test")

ASSET_PATTERNS = [
    "public/**/*"
]

SRC_PATTERNS = [
    "src/**/*"
]

# Filename conventions described at
# https://create-react-app.dev/docs/running-tests#filename-conventions
TEST_PATTERNS = [
    "src/**/*.test.js*",
    "src/**/*.test.ts*",
    "src/**/*.spec.js*",
    "src/**/*.spec.ts*"
]


def react_app(
        npm_deps,
        visibility = ["//visibility:public"]):
    """
    Builds a React app using webpack.
    Args:
        npm_deps: node_module targets
        visibility: List of labels of visibility to be provided to the compiler.
    """

    ts_deps = [
        "//:tsconfig.react",
        "tsconfig.json",
        "package.json",
        "//:package_json"
    ]

    srcs = native.glob(
        include = SRC_PATTERNS + ASSET_PATTERNS,
        exclude = TEST_PATTERNS,
    ) + native.glob([".env*"]) + npm_deps + ts_deps

    test_srcs = native.glob(
        include = TEST_PATTERNS,
    ) + ["tsconfig.spec.json", 'jest.config.js'] + srcs

    cra_bin.react_scripts(
        # Note: If you want to change the name make sure you update BUILD_PATH below accordingly
        # https://create-react-app.dev/docs/advanced-configuration/
        name = "build",
        args = ["build"],
        srcs = srcs,
        env = {"BUILD_PATH": "./dist"},
        out_dirs = ["dist"],
        chdir = native.package_name()
    )

    js_run_devserver(
        name = "dev",
        args = [ "start" ],
        chdir = native.package_name(),
        command = "/".join([".."] * len(native.package_name().split("/"))) + "/node_modules/.bin/react-scripts",
        data = srcs,
    )


    js_run_devserver(
        name = "prod",
        args = [
            "--port 3000",
            "--proxy http://localhost:3000?",
            "./dist",
        ],
        chdir = native.package_name(),
        command = "/".join([".."] * len(native.package_name().split("/"))) + "/node_modules/.bin/http-server",
        data = [
            ":build",
            "//:node_modules/http-server",
        ],
    )

    js_library(
        name = "jest_config",
        srcs = ["jest.config.js"],
        visibility = ["//visibility:public"],
    )

    jest_test(
        name = "test",
        config = ":jest_config",
        data = [
            "//:node_modules/@testing-library/jest-dom",
            "//:node_modules/@testing-library/react",
            "//:node_modules/@testing-library/user-event",
            "//:node_modules/jest-watch-typeahead",
            "//:node_modules/babel-preset-react-app"
        ] + test_srcs
    )
