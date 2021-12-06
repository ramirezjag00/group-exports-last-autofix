export default async () => {
  console.log('Default Export Async');
  await getComments();
  console.log('Default Export Async');
};

export { default as HelloWorld } from '../HelloWorld';
export { default as FooBar } from '../../FooBar';
export { default as FizzBuzz } from '../../../FizzBuzz';