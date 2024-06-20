import { PUBLIC_SERVER_HOST_URL } from '$env/static/public';
import { redirect, type RequestEvent } from '@sveltejs/kit';
import { verifyAndDecodeToken } from '$utility/jwt';
import { setCookie } from '$utility/cookies';
import { to } from '$utility/routes';

type ResponseData = {
  token: string;
  refreshToken: string;
};

export const apiRequest = async <T>(
  fetch: typeof window.fetch,
  url: string,
  params: Record<string, FormDataEntryValue | null>
) => {
  const response = await fetch(`${PUBLIC_SERVER_HOST_URL}${url}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(params)
  });

  if (!response.ok) {
    throw new Error('Failed to fetch');
  }

  return (await response.json()) as T;
};

export const authenticateUser = async (event: RequestEvent) => {
  const token = event.cookies.get('token');
  const refreshToken = event.cookies.get('refreshToken');

  if (!token || !refreshToken) {
    throw redirect(302, to.signIn());
  }

  const parsedToken = await verifyAndDecodeToken(token).catch(() => null);

  if (!parsedToken) {
    const { token: newToken, refreshToken: newRefreshToken } = await apiRequest<ResponseData>(
      event.fetch,
      to.api.refreshToken(),
      { token, refreshToken }
    ).catch(() => ({ token: null, refreshToken: null }));

    console.log('Received new token and refresh token', newToken, newRefreshToken);
    if (newToken && newRefreshToken) {
      setCookie(event.cookies, 'token', newToken);
      setCookie(event.cookies, 'refreshToken', newRefreshToken);
    }

    if (!newToken || !newRefreshToken) {
      throw redirect(302, to.signIn());
    }
    console.log('Returning new token and refresh token', newToken, newRefreshToken);

    return { token: newToken, refreshToken: newRefreshToken };
  }

  return { token, refreshToken };
};
