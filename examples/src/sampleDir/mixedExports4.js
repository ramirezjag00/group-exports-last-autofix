// anon
export default () => {
  console.log('Default Export');
};

// aggregated
export { default as HelloWorld } from '../HelloWorld';
export { default as FooBar } from '../../FooBar';
export { default as FizzBuzz } from '../../../FizzBuzz';