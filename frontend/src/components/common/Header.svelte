<script context="module" lang="ts">
  export type NavigationItem = {
    name: string;
    href: string;
    current: boolean;
  };

  export type UserNavigationItem = {
    name: string;
    href: string;
  };
</script>

<script lang="ts">
  import { Disclosure, DisclosureButton, DisclosurePanel } from '@rgossiaux/svelte-headlessui';
  import Icon from '$components/icons/Icon.svelte';
  import Mobile from './Header/Mobile.svelte';
  import Navigation from './Header/Navigation.svelte';
  import { to } from '$utility/routes';

  import { fragment, graphql, type Header_user } from '$houdini';
  import Dropdown from './Header/Dropdown.svelte';

  export let user: Header_user;

  $: userData = fragment(
    user,
    graphql`
      fragment Header_user on User {
        imageUrl
        ...Mobile_user
        ...Dropdown_user
      }
    `
  );

  const navigation: NavigationItem[] = [{ name: 'Dashboard', href: to.root(), current: false }];

  const userNavigation: UserNavigationItem[] = [
    { name: 'Settings', href: to.settings() },
    { name: 'Sign out', href: to.signOut() }
  ];
</script>

<Disclosure as="nav" class="bg-gray-800" let:open>
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
    <div class="flex h-16 items-center justify-between">
      <Navigation {navigation} />
      <div class="hidden md:block">
        <div class="ml-4 flex items-center md:ml-6">
          <button
            type="button"
            class="rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
          >
            <span class="sr-only">View notifications</span>
            <Icon name="Bell" classes="h-6 w-6" />
          </button>

          <!-- Profile dropdown -->
          <Dropdown {userNavigation} user={$userData} />
        </div>
      </div>
      <div class="-mr-2 flex md:hidden">
        <!-- Mobile menu button -->
        <DisclosureButton
          class="inline-flex items-center justify-center rounded-md bg-gray-800 p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
        >
          <span class="sr-only">Open main menu</span>
          {#if !open}
            <Icon name="Bars3" classes="block h-6 w-6" />
          {:else}
            <Icon name="XMark" classes="block h-6 w-6" />
          {/if}
        </DisclosureButton>
      </div>
    </div>
  </div>

  <DisclosurePanel class="md:hidden">
    <Mobile {navigation} {userNavigation} user={$userData} />
  </DisclosurePanel>
</Disclosure>
