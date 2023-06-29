import { setSession } from '$houdini';
import { redirect, type Handle } from '@sveltejs/kit';
import { verifyAndDecodeToken } from '$utility/jwt';
import { setCookie } from '$utility/cookies';
import { apiRequest } from '$utility/api';

type ResponseData = {
  token: string;
  refresh_token: string;
};

export const handle: Handle = async ({ event, resolve }) => {
  const token = event.cookies.get('token');
  const refreshToken = event.cookies.get('refreshToken');

  const user = {
    token: token,
    refreshToken: refreshToken
  };

  let isAuthenticated = false;
  let id = null;

  if (token) {
    const decodedToken = verifyAndDecodeToken(token);
    if (decodedToken) {
      console.log('decodedToken', decodedToken);
      isAuthenticated = true;
      id = decodedToken.id;
    } else {
      console.log('no decodedToken');
      console.log('refreshToken', refreshToken);
      if (refreshToken) {
        const body = await apiRequest<ResponseData>(event.fetch, '/api/refresh-token', {
          refreshToken,
          token: token
        });

        if (body.token) {
          isAuthenticated = true;
          const decodedToken = verifyAndDecodeToken(body.token);
          if (decodedToken) {
            id = decodedToken.id;
          }

          setCookie(event.cookies, 'token', body.token, false);
          setCookie(event.cookies, 'refreshToken', body.refresh_token, false);
          user.token = body.token;
          user.refreshToken = body.refresh_token;
        } else {
          event.cookies.delete('token');
          event.cookies.delete('refreshToken');
        }
      }
    }
  }

  if (event.url.pathname == '/sign-out') {
    event.cookies.delete('token');
    event.cookies.delete('refreshToken');
    throw redirect(302, '/sign-in');
  }


  event.locals.user = {
    isAuthenticated: isAuthenticated,
    id: id
  };

  // set the session information for this event
  setSession(event, { user });

  // pass the event onto the default handle
  return await resolve(event);
};
