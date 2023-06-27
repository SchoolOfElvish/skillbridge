import { HoudiniClient } from '$houdini';
import { browser } from '$app/environment';
import { PUBLIC_CLIENT_HOST_URL, PUBLIC_SERVER_HOST_URL } from '$env/static/public';

const url = browser ? PUBLIC_CLIENT_HOST_URL : PUBLIC_SERVER_HOST_URL;

export default new HoudiniClient({
  url: `${url}/graphql`,
  fetchParams({ session }) {
    return {
      headers: {
        Authorization: `Bearer ${session?.user?.token}`
      }
    };
  }
});
