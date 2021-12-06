export default async () => {
  console.log('Default Export Async');
  await getComments();
  console.log('Default Export Async');
};