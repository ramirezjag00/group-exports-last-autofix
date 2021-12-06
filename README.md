# **Export fixes** for `eslint-plugin-import` using `Bash`

## Why? 🤔
- You're dealing with thousands of js/ts files with these syntaxes and just want to make things prettier by putting exports at the bottom but there's no autofix yet

## Rules to fix
- [import/exports-last](https://github.com/import-js/eslint-plugin-import/blob/v2.25.3/docs/rules/exports-last.md)
- [import/no-anonymous-default-export](https://github.com/import-js/eslint-plugin-import/blob/v2.25.3/docs/rules/no-anonymous-default-export.md)
- [import/group-exports](https://github.com/import-js/eslint-plugin-import/blob/v2.25.3/docs/rules/group-exports.md)
- [import/prefer-default-export](https://github.com/import-js/eslint-plugin-import/blob/main/docs/rules/prefer-default-export.md)

### Before
  - ```js
    export const foo = 'foo'
    export const bar = 'bar'
    ```
  - ```js
    export default () => { // file name: HelloComponent.js
      console.log('Hello World!');
    };
    ```
  - ```js
    import { one, two, three } from './number';

    export default { // file name: numbers.js
      1: one,
      2: two,
      3: three,
    };
    ```
  - ```js
    export { default as HelloWorld } from '../HelloWorld';
    export { default as FooBar } from '../../FooBar';
    export { default as FizzBuzz } from '../../../FizzBuzz';
    ```

### After
<img src="./assets/exportNamed.png" width="450"  />
<img src="./assets/exportDefaultAnonymous.png" width="450"  />
<img src="./assets/exportDefaultObject.png" width="450"  />
<img src="./assets/exportDefaultAggregate.png" width="450"  />

## Usage / Testing

### for a single file
- ```bash
  ./export_fix.sh ./examples/src/exportNamed.js # check other files available
  ```
- ```bash
  ./export_fix.sh ./examples/src/sampleDir/mixedExports1.js  # check other files available
  ```

### for all files in a directory
- ```bash
  ./export_fix_all.sh ./examples/src/sampleDir  # check other files available
  ```

### note
- if permission denied: `chmod 777 ./export_fix_all.sh` OR `chmod 777 ./export_fix.sh` which are the two files you only need for your codebase
- if available, execute prettier in your js/ts codebase after running the script for additional 💅

### to reset

- to reset **examples/src/*** files after overwriting: `./reset.sh`
- just don't mess with the files from **examples/backup/*** 🤷


## For enhancement
- [x] export_fix.sh [.js,jsx,ts,tsx] extension only checks [#1](https://github.com/ramirezjag00/export-sanitize-script/pull/1)
- [ ] running `./export_fix_all.sh ./examples/src` will skip `./examples/sampleDir/*` files, but all js/ts files in /src will be sanitized