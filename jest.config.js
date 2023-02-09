/** @type {import('jest').Config} */
const config = {
  testEnvironment: "jsdom",
  transform: {
    "^.+\\.svg$": "jest-transform-stub",
    "^.+\\.css$": "jest-transform-stub",
  },
};

module.exports = config;
