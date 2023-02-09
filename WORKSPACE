workspace(name = "bazel_onboarding")


load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_js",
    sha256 = "2868c450aaa83ec19ee172015c6445264b6422d6d0d61da6af47ec8a159b0e5a",
    strip_prefix = "rules_js-1.17.0",
    url = "https://github.com/aspect-build/rules_js/releases/download/v1.17.0/rules_js-v1.17.0.tar.gz",
)

http_archive(
    name = "aspect_rules_ts",
    sha256 = "94f7a43a3b40b3dd6ea7562363512524e1d50802da0ab469a12895a9dfcfad96",
    strip_prefix = "rules_ts-1.2.1",
    url = "https://github.com/aspect-build/rules_ts/archive/refs/tags/v1.2.1.tar.gz",
)

http_archive(
    name = "aspect_rules_jest",
    sha256 = "9f327ea58950c88274ea7243419256c74ae29a55399d2f5964eb7686c7a5660d",
    strip_prefix = "rules_jest-0.15.0",
    url = "https://github.com/aspect-build/rules_jest/archive/refs/tags/v0.15.0.tar.gz",
)

http_archive(
    name = "aspect_rules_swc",
    sha256 = "c35e633c2c90a4cd6796e66d66bcf37d31a81737afc76030201a9ef8599abc58",
    strip_prefix = "rules_swc-0.21.3",
    url = "https://github.com/aspect-build/rules_swc/archive/refs/tags/v0.21.3.tar.gz",
)

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_ts//ts:repositories.bzl", "rules_ts_dependencies")

rules_ts_dependencies(ts_version_from = "//:package.json")

load("@aspect_rules_jest//jest:dependencies.bzl", "rules_jest_dependencies")

rules_jest_dependencies()

load("@aspect_rules_jest//jest:repositories.bzl", "jest_repositories")

jest_repositories(name = "jest")

load("@jest//:npm_repositories.bzl", jest_npm_repositories = "npm_repositories")

jest_npm_repositories()

load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = DEFAULT_NODE_VERSION,
)


load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock", "pnpm_repository")


npm_translate_lock(
    name = "npm",
    bins = {
        "react-scripts": {
            "react-scripts": "./bin/react-scripts.js",
        },
        "http-server": {
            "http-server": "./bin/http-server",
        },
        "next": {
            "next": "./dist/bin/next",
        },
        "@remix-run": {
            "@remix-run": "./dev/dist/cli.js",
        },
        "@remix-serve": {
            "@remix-run": "./serve/dist/cli.js",
        },
        "node-gyp": {
            "node-gyp": "./bin/node-gyp.js",
        },
        "@nestjs": {
            "@nestjs": "./cli/bin/nest.js",
        }
    },
    lifecycle_hooks = {"deasync": []},
    npmrc = "//:.npmrc",
    pnpm_lock = "//:pnpm-lock.yaml",
    public_hoist_packages = {
        "eslint-config-react-app": [""],
        "eslint": [""],
    },
    verify_node_modules_ignored = "//:.bazelignore",
)

load("@npm//:repositories.bzl", "npm_repositories")

npm_repositories()

pnpm_repository(name = "pnpm")
load("@aspect_rules_swc//swc:dependencies.bzl", "rules_swc_dependencies")

rules_swc_dependencies()

load("@aspect_rules_swc//swc:repositories.bzl", "swc_register_toolchains", LATEST_SWC_VERSION = "LATEST_VERSION")

swc_register_toolchains(
    name = "swc",
    swc_version = LATEST_SWC_VERSION,
)
