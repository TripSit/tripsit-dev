'use strict';

module.exports = {
  root: true,
  env: {
    node: true,
    // 'browser': true, // I had this set before but idk why
    // 'commonjs': true, // I had this set before but idk why
    es2022: true,
  },
  extends: [
    'airbnb-base',
    'plugin:sonarjs/recommended',
  ],
  plugins: [
    '@typescript-eslint',
    'sonarjs',
  ],
  ignorePatterns: ['.eslintrc.js', '*/repos/*.*.ts'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    sourceType: 'script',
    ecmaVersion: 2022,
  },
  rules: {
    // This enforces strict checks on .js files, it's not necessary for .ts files
    // https://www.w3schools.com/js/js_strict.asp
    strict: [2, 'global'],
    // Removes () around single parameter arrow functions
    'arrow-parens': [2, 'as-needed'],
    // This is a personal preference to enforce good code
    // '@typescript-eslint/no-non-null-assertion': 'warn',
    // Enforce max line length of 120
    'max-len': ['warn', { code: 120 }],
    // Allow allow any on objects, require definition of types
    '@typescript-eslint/no-explicit-any': 'warn',
    // Limit complexity to 50
    'sonarjs/cognitive-complexity': ['warn', 50],
  },
  overrides: [
    {
      files: ['**/*.ts'],
      extends: [
        'airbnb-base',
        'airbnb-typescript/base',
        'plugin:sonarjs/recommended',
      ],
      parserOptions: {
        project: '**/tsconfig.json',
      },
      rules: {
        // This enforces strict checks on .js files, it's not necessary for .ts files
        // https://www.w3schools.com/js/js_strict.asp
        strict: [2, 'global'],
        // Removes () around single parameter arrow functions
        'arrow-parens': [2, 'as-needed'],
        // This is a personal preference to enforce good code
        '@typescript-eslint/no-non-null-assertion': 'warn',
        // Enforce max line length of 120
        'max-len': ['warn', { code: 120 }],
        // Allow allow any on objects, require definition of types
        '@typescript-eslint/no-explicit-any': 'warn',
        // The following will show up as errors, just want to get this pushed for now
        'sonarjs/cognitive-complexity': ['warn', 50],
      },
    },
  ],
};
