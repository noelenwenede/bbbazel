/** @type {import('@remix-run/dev').AppConfig} */
module.exports = {
  ignoredRouteFiles: ["**/.*"],
  appDirectory: "app",
  assetsBuildDirectory: "public/build",
  serverBuildPath: "build/index.js",
  publicPath: "/build/",
  /**
   * The path to the entry.client file, relative to `config.appDirectory`.
   */
  entryClientFile: "/entry.client.tsx",
  /**
   * The path to the entry.server file, relative to `config.appDirectory`.
   */
  entryServerFile: "/entry.server.tsx",
};
