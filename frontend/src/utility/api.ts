import { PUBLIC_SERVER_HOST_URL } from '$env/static/public';

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
