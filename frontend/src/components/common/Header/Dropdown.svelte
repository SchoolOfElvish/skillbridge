<script lang="ts">
  import {
    Menu,
    MenuButton,
    MenuItem,
    MenuItems,
    Transition
  } from '@rgossiaux/svelte-headlessui';
  import { fragment, graphql, type Dropdown_user } from '$houdini';
  import type { UserNavigationItem } from '$components/common/Header.svelte';

  export let user: Dropdown_user;

  export let userNavigation: UserNavigationItem[];

  $: userData = fragment(user, graphql`
    fragment Dropdown_user on User {
      imageUrl
    }
  `);
</script>

<Menu as="div" class="relative ml-3">
  <div>
    <MenuButton
      class="flex max-w-xs items-center rounded-full bg-gray-800 text-sm text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
    >
      <span class="sr-only">Open user menu</span>
      <img class="h-8 w-8 rounded-full" src={$userData.imageUrl} alt="" />
    </MenuButton>
  </div>
  <Transition
    enter="transition ease-out duration-100"
    enterFrom="transform opacity-0 scale-95"
    enterTo="transform opacity-100 scale-100"
    leave="transition ease-in duration-75"
    leaveFrom="transform opacity-100 scale-100"
    leaveTo="transform opacity-0 scale-95"
  >
    <MenuItems
      class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
    >
      {#each userNavigation as item (item.name)}
        <MenuItem let:active>
          <a
            href={item.href}
            class="block px-4 py-2 text-sm text-gray-700"
            class:bg-gray-100={active}
          >
            {item.name}
          </a>
        </MenuItem>
      {/each}
    </MenuItems>
  </Transition>
</Menu>
