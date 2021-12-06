const exportDefaultAnonymousAsync = async () => {
  console.log('Default Export Async');
  await getComments();
  console.log('Default Export Async');
};

export default exportDefaultAnonymousAsync;
