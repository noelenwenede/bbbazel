# Fleet Monorepo

This repository houses all source code related to Fleet.

Example applications can be found in `examples` directory.

## Getting Started

1. [Install pnpm](https://pnpm.io/installation)
2. [Install Bazel](https://bazel.build/install)
3. Install node_modules

   ```bash
   pnpm install
   ```

4. Run an example app

   ```bash
   ibazel run //examples/react:dev
   ```

5. Run failed build command

   ```bash
   bazel build //examples/remix:build
   ```
