import type { Actions } from './$types';
import { redirect } from '@sveltejs/kit';
import { setCookie } from '$utility/cookies';
import { apiRequest } from '$utility/api';
import { to } from '$utility/routes';

type ResponseData = {
  token: string;
  refresh_token: string;
};

export const actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const email = form.get('email');
    const password = form.get('password');
    const remember = Boolean(form.get('remember-me')) == true;

    const body = await apiRequest<ResponseData>(fetch, to.signIn(), { email, password });

    setCookie(cookies, 'token', body.token, remember);
    setCookie(cookies, 'refreshToken', body.refresh_token, remember);

    throw redirect(302, to.root());
  }
} satisfies Actions;
