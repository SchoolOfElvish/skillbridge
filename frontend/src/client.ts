import { HoudiniClient } from '$houdini';
import { browser } from '$app/environment';

const url = browser ? 'http://localhost:3000/graphql' : 'http://backend:3000/graphql';

export default new HoudiniClient({
    url: url

    // uncomment this to configure the network call (for things like authentication)
    // for more information, please visit here: https://www.houdinigraphql.com/guides/authentication
    // fetchParams({ session }) { 
    //     return { 
    //         headers: {
    //             Authentication: `Bearer ${session.token}`,
    //         }
    //     }
    // }
})
