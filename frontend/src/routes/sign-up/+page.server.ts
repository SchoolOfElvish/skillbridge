import type { Actions } from './$types';
import { redirect } from '@sveltejs/kit';
import { setCookie } from '$utility/cookies';
import { apiRequest } from '$utility/api';
import { to } from '$utility/routes';

type ResponseData = {
  token?: string;
  refreshToken?: string;
  error?: string;
};

export const actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const email = form.get('email');
    const password = form.get('password');
    const remember = Boolean(form.get('remember-me')) == true;
    let body;

    try {
      body = await apiRequest<ResponseData>(fetch, to.api.signIn(), { email, password });
      console.log(body);
    } catch (error) {
      console.error('Failed to sign in:', error);
    }

    if (body?.token && body?.refreshToken) {
      setCookie(cookies, 'token', body.token, remember);
      setCookie(cookies, 'refreshToken', body.refreshToken, remember);

      throw redirect(302, to.root());
    }

    if (body?.error) {
      return {
        status: 400,
        body: body.error
      };
    }
  }
} satisfies Actions;
