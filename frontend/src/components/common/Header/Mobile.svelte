<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { DisclosureButton } from '@rgossiaux/svelte-headlessui';
  import type { NavigationItem, UserNavigationItem } from '../Header.svelte';
  import { fragment, graphql, type Mobile_user } from '$houdini';

  export let navigation: NavigationItem[] = [];
  export let userNavigation: UserNavigationItem[] = [];
  export let user: Mobile_user;

  $: userData = fragment(
    user,
    graphql`
      fragment Mobile_user on User {
        imageUrl
        firstName
        lastName
        email
      }
    `
  );
</script>

<div class="space-y-1 px-2 pb-3 pt-2 sm:px-3">
  {#each navigation as item (item.name)}
    <DisclosureButton
      as="a"
      href={item.href}
      class="block rounded-md px-3 py-2 text-base font-medium {item.current
        ? 'bg-gray-900 text-white'
        : 'text-gray-300 hover:bg-gray-700 hover:text-white'}"
      aria-current={item.current ? 'page' : undefined}
    >
      {item.name}
    </DisclosureButton>
  {/each}
</div>
<div class="border-t border-gray-700 pb-3 pt-4">
  <div class="flex items-center px-5">
    <div class="flex-shrink-0">
      <img class="h-10 w-10 rounded-full" src={$userData.imageUrl} alt="" />
    </div>
    <div class="ml-3">
      <div class="text-base font-medium text-white">{$userData.firstName} {$userData.lastName}</div>
      <div class="text-sm font-medium text-gray-400">{$userData.email}</div>
    </div>
    <button
      type="button"
      class="ml-auto flex-shrink-0 rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
    >
      <span class="sr-only">View notifications</span>
      <Icon name="Bell" classes="h-6 w-6" />
    </button>
  </div>
  <div class="mt-3 space-y-1 px-2">
    {#each userNavigation as item (item.name)}
      <DisclosureButton
        as="a"
        href={item.href}
        class="block rounded-md px-3 py-2 text-base font-medium text-gray-400 hover:bg-gray-700 hover:text-white"
      >
        {item.name}
      </DisclosureButton>
    {/each}
  </div>
</div>
