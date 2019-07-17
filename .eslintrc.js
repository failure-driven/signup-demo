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
  },
  settings: {
    "import/resolver": {
      node: {
        paths: ["./app/javascript/"]
      }
    }
  }
};
