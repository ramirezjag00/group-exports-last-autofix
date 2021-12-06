export default async () => {
  console.log('Default Export Async');
  await getComments();
  console.log('Default Export Async');
};

export const foo = 'foo';
export const bar = 'bar';
export const fizz = 'fizz\n';
export const buzz = 'buzz';