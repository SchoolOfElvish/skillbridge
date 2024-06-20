import { setSession } from '$houdini';
import { redirect, type Handle, type RequestEvent } from '@sveltejs/kit';
import { to } from '$utility/routes';
import { authenticateUser } from '$utility/api';
import { deleteCookie } from '$utility/cookies';

function handleSignOut(event: RequestEvent): void {
  deleteCookie(event.cookies, 'token');
  deleteCookie(event.cookies, 'refreshToken');
  throw redirect(302, to.signIn());
}

export const handle: Handle = async ({ event, resolve }) => {
  if (event.url.pathname === to.signIn() || event.url.pathname === to.signUp()) {
    return await resolve(event);
  }

  const user = await authenticateUser(event);

  if (event.url.pathname === to.signOut()) {
    handleSignOut(event);
  }

  console.log('Setting session:', user);
  setSession(event, { user });

  return await resolve(event);
};
