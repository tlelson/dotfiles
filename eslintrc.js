module.exports = {
  "extends": "airbnb",
  "plugins": [],
  "rules": {
    "semi": "off",
    "func-names": "off",
		"react/jsx-filename-extension": [1, { "extensions": [".js", ".jsx"] }],
		// Following fix for un-understood error
		"jsx-a11y/href-no-hash": "off",
    "jsx-a11y/anchor-is-valid": ["warn", { "aspects": ["invalidHref"] }],
    // doesn't work in node v4 :(
    "strict": "off",
    "prefer-rest-params": "off",
    "react/require-extension" : "off",
    "import/no-extraneous-dependencies" : "off"
  },
  "env": {
       "mocha": true
   }
};
