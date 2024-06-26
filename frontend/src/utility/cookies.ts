import { dev } from '$app/environment';
import type { Cookies } from '@sveltejs/kit';

export const setCookie = (
  cookies: Cookies,
  name: string,
  value: string,
  remember: boolean = false
) => {
  const temporaryCookieOptions = { maxAge: 60 * 60 * 24 * 7 };

  cookies.set(name, value, {
    path: '/',
    httpOnly: true,
    sameSite: 'strict',
    secure: !dev,
    ...(remember && temporaryCookieOptions)
  });
};

export const deleteCookie = (cookies: Cookies, name: string) => {
  cookies.delete(name, { path: '/' });
};
