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
  import Navigation from './Header/Navigation.svelte';

  export let isUserAuthenticated = false;

  const navigation: NavigationItem[] = [
    { name: 'Dashboard', href: '#', current: true },
    { name: 'Team', href: '#', current: false },
    { name: 'Projects', href: '#', current: false },
    { name: 'Calendar', href: '#', current: false },
    { name: 'Reports', href: '#', current: false }
  ];
</script>

<nav class="bg-gray-800">
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
    <div class="flex h-16 items-center justify-between">
      {#if isUserAuthenticated}
        <Navigation {navigation} />
      {:else}
        <div class="hidden md:block">
          <div class="ml-4 flex items-center md:ml-6">
            <a
              href={'/sign-in'}
              class="relative inline-flex items-center rounded-md px-4 py-2 text-sm font-medium shadow-sm text-gray-300 hover:text-white focus:outline-none"
            >
              <span>
                {'navbar.sign_in'}
              </span>
            </a>
            <a
              href={'/sign-up'}
              class="relative inline-flex items-center rounded-md border border-transparent bg-indigo-500 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-800"
            >
              <span>
                {'navbar.sign_up'}
              </span>
            </a>
          </div>
        </div>
      {/if}
    </div>
  </div>
</nav>
