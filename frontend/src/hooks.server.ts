import { setSession } from '$houdini';
import type { Handle } from '@sveltejs/kit';

export const handle: Handle = async ({ event, resolve }) => {
  // get the user information however you want
  const user = {
    token:
      'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJqdGkiOiJkYTc0NzcwMWMwYzAwYTYyMjkxMTMyZWVhZGNhNjhlNCIsImlhdCI6MTY4NzgwMzM1NSwiZXhwIjoxNjg3ODEwNTU1fQ.h2RvjoBkq-qrhGXHw9ZSvIz0lOqbBQ8U49T-0jPE6ak'
  };

  // set the session information for this event
  setSession(event, { user });

  // pass the event onto the default handle
  return await resolve(event);
};
