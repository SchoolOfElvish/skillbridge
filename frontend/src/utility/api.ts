import { PUBLIC_SERVER_HOST_URL } from '$env/static/public';
import type { RequestEvent } from '@sveltejs/kit';
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

  return (await response.json()) as T;
};

export async function handleTokenVerification(event: RequestEvent, token: string, refreshToken: string | undefined): Promise<void> {
  const decodedToken = verifyAndDecodeToken(token);
  if (!decodedToken && refreshToken) {
    try {
      const body = await apiRequest<ResponseData>(event.fetch, to.api.refreshToken(), {
        refreshToken,
        token
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
