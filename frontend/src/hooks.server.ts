import { setSession } from '$houdini';
import { redirect, type Handle, type RequestEvent } from '@sveltejs/kit';
import { to } from '$utility/routes';
import { handleTokenVerification } from '$utility/api';
import { deleteCookie } from '$utility/cookies';

function handleSignOut(event: RequestEvent): void {
  deleteCookie(event.cookies, 'token');
  deleteCookie(event.cookies, 'refreshToken');
  throw redirect(302, to.signIn());
}

export const handle: Handle = async ({ event, resolve }) => {
  const token = event.cookies.get('token');
  const refreshToken = event.cookies.get('refreshToken');

  if (token) {
    await handleTokenVerification(event, token, refreshToken);
  }

  if (event.url.pathname === '/sign-out') {
    handleSignOut(event);
  }

  // set the session information for this event
  setSession(event, { user: { token, refreshToken } });

  // pass the event onto the default handle
  return await resolve(event);
};
