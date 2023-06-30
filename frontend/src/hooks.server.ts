import { setSession } from '$houdini';
import { redirect, type Handle } from '@sveltejs/kit';
import { verifyAndDecodeToken } from '$utility/jwt';
import { setCookie } from '$utility/cookies';
import { apiRequest } from '$utility/api';
import { to } from '$utility/routes';

type ResponseData = {
  token: string;
  refreshToken: string;
};

export const handle: Handle = async ({ event, resolve }) => {
  const token = event.cookies.get('token');
  const refreshToken = event.cookies.get('refreshToken');

  if (token) {
    const decodedToken = verifyAndDecodeToken(token);
    if (!decodedToken) {
      if (refreshToken) {
        try {
          const body = await apiRequest<ResponseData>(event.fetch, to.api.refreshToken(), {
            refreshToken,
            token: token
          });

          if (body.token && body.refreshToken) {
            setCookie(event.cookies, 'token', body.token, false);
            setCookie(event.cookies, 'refreshToken', body.refreshToken, false);
          } else {
            event.cookies.delete('token');
            event.cookies.delete('refreshToken');
          }
        } catch (error) {
          console.error('Failed to refresh token:', error);
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

  // set the session information for this event
  setSession(event, { user: { token, refreshToken } });

  // pass the event onto the default handle
  return await resolve(event);
};
