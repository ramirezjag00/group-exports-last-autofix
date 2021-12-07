export function foo() {
  console.log('hello');
};

export function bar(hello = '') {
  console.log(hello);
};

export function fizz(
  hello = '',
  world = ''
) {
  console.log(`${hello} ${world}`);
};

export function buzz({
  hello = '',
  world = ''
}) {
  console.log(`${hello} ${world}`);
};
