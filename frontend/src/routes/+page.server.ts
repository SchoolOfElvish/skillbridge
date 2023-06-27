import { TestQueryStore, graphql } from '$houdini';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$houdini';

export const _houdini_load = graphql`
  query TestQuery {
    testField
  }
`;

export const load: PageServerLoad = async (event) => {
  const myQuery = new TestQueryStore();
  const { data, errors } = await myQuery.fetch({ event });
  if (errors) {
    throw error(403, errors.join(', '));
  }

  return {
    query: data,
  };
};
