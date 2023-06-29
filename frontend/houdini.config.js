/// <references types="houdini-svelte">

/** @type {import('houdini').ConfigFile} */
const config = {
  watchSchema: {
    url: 'http://backend:3000/graphql',
    interval: 100000,
    headers: {
      'X-Introspection': 'true',
    }
  },
  plugins: {
    'houdini-svelte': {}
  }
};

export default config;
