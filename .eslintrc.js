module.exports = {
  parser: "babel-eslint",
  extends: [
    "airbnb",
    "prettier",
    "plugin:prettier/recommended",
    "plugin:jest/recommended"
  ],
  globals: {
    document: false,
    fetch: false
  },
  settings: {
    "import/resolver": {
      node: {
        paths: ["./app/javascript/"]
      }
    }
  }
};
