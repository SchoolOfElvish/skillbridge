import { HoudiniClient } from '$houdini';
import { browser } from '$app/environment';
import { PUBLIC_CLIENT_HOST_URL, PUBLIC_SERVER_HOST_URL } from '$env/static/public';
import { redirect } from '@sveltejs/kit';

const url = browser ? PUBLIC_CLIENT_HOST_URL : PUBLIC_SERVER_HOST_URL;

export default new HoudiniClient({
  url: `${url}/graphql`,
  throwOnError: {
    // can be any combination of
    // query, mutation, subscription, and all
    operations: ['query', 'subscription'],
    // the function to call
    error: (errors) => {
      if (errors[0].message === 'Not authenticated') {
        return redirect(302, '/sign-in');
      }
    }
  },
  fetchParams({ session }) {
    return {
      headers: {
        Authorization: `Bearer ${session?.user?.token}`
      }
    };
  }
});
