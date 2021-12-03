// object
import { one, two, three } from './number';

export default {
  1: one,
  2: two,
  3: three,
};

// aggregated
export { default as HelloWorld } from '../HelloWorld';
export { default as FooBar } from '../../FooBar';
export { default as FizzBuzz } from '../../../FizzBuzz';