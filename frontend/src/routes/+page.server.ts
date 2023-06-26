import { TestQueryStore, graphql } from '$houdini'
import type { PageServerLoad } from './$houdini'

export const _houdini_load = graphql`
  query TestQuery {
    testField
  }
`

export const load: PageServerLoad = async (event) => {
  const myQuery = new TestQueryStore()
  const { data } = await myQuery.fetch({ event })
  return { data }
}
