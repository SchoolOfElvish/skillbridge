import { graphql } from '$houdini'
import { fail } from '@sveltejs/kit'
import type { Actions } from './$types'

export const actions = {
  default: async (event) => {
    const data = await event.request.formData()

    const firstName = data.get('first-name')?.toString()

    if (!firstName) {
      return fail(406, { name: '*' })
    }

    const actionMutation = graphql(`
      mutation SettingsPageUserUpdate($firstName: String!) {
        updateUser(input: {
          userId: "Z2lkOi8vc2tpbGxicmlkZ2UvVXNlci84NQ",
          firstName: $firstName,
        }) {
          user {
            id
            lastName
            firstName
          }
        }
      }
    `)

    return await actionMutation.mutate({ firstName }, { event })
  }
} satisfies Actions;
