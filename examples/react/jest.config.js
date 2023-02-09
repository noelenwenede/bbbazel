const path = require("path");

/** @type {import('jest').Config} */
const config = {
  verbose: true,
  testEnvironment: "jsdom",
  rootDir: path.resolve(__dirname, 'src'),
  transform: {
    "^.+\\.[tj]sx?$": ["babel-jest", { presets: ["react-app"] }],
    '^.+\\.svg$': 'jest-transform-stub',
      '^.+\\.css$': 'jest-transform-stub',
  },
  testPathIgnorePatterns: ["node_modules"],
};

module.exports = config;
