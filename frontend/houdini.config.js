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
  },
  scalars: {
    ISO8601Date: {
      type: 'Date',
      unmarshal(val) {
        return val ? new Date(val) : null
      },
      marshal(date) {
        return date && date.getTime()
      }
    }
  }
};

export default config;
