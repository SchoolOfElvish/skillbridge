<script lang="ts">
  import {
    Disclosure,
    DisclosureButton,
    DisclosurePanel,
    Menu,
    MenuButton,
    MenuItem,
    MenuItems,
    Transition
  } from '@rgossiaux/svelte-headlessui';
  /* import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/vue/24/outline' */
  import Icon from '$components/icons/Icon.svelte';

  const user = {
    name: 'Tom Cook',
    email: 'tom@example.com',
    imageUrl:
      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'
  };

  const navigation = [
    { name: 'Dashboard', href: '#', current: true },
    { name: 'Team', href: '#', current: false },
    { name: 'Projects', href: '#', current: false },
    { name: 'Calendar', href: '#', current: false },
    { name: 'Reports', href: '#', current: false }
  ];

  const userNavigation = [
    { name: 'Your Profile', href: '#' },
    { name: 'Settings', href: '#' },
    { name: 'Sign out', href: '#' }
  ];
</script>

<div class="min-h-full">
  <Disclosure as="nav" class="bg-gray-800" let:open>
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="flex h-16 items-center justify-between">
        <div class="flex items-center">
          <div class="flex-shrink-0">
            <img
              class="h-8 w-8"
              src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500"
              alt="Your Company"
            />
          </div>
          <div class="hidden md:block">
            <div class="ml-10 flex items-baseline space-x-4">
              {#each navigation as item (item.name)}
                <a
                  href={item.href}
                  class="rounded-md px-3 py-2 text-sm font-medium"
                  class:bg-gray-900={item.current}
                  class:text-white={item.current}
                  class:text-gray-300={!item.current}
                  class:hover:bg-gray-700={!item.current}
                  class:hover:text-white={!item.current}
                  aria-current={item.current ? 'page' : undefined}
                >
                  {item.name}
                </a>
              {/each}
            </div>
          </div>
        </div>
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
            <Menu as="div" class="relative ml-3">
              <div>
                <MenuButton
                  class="flex max-w-xs items-center rounded-full bg-gray-800 text-sm text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
                >
                  <span class="sr-only">Open user menu</span>
                  <img class="h-8 w-8 rounded-full" src={user.imageUrl} alt="" />
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
      <div class="space-y-1 px-2 pb-3 pt-2 sm:px-3">
        {#each navigation as item (item.name)}
          <!-- <DisclosureButton as="a" href={item.href} class="block rounded-md px-3 py-2 text-base font-medium"  -->
          <!--   class:bg-gray-900={item.current}  -->
          <!--   class:text-white={item.current}  -->
          <!--   class:text-gray-300={!item.current}  -->
          <!--   class:hover:bg-gray-700={!item.current}  -->
          <!--   class:hover:text-white={!item.current}  -->
          <!--   aria-current={item.current ? 'page' : undefined}> -->
          <!--   {item.name} -->
          <!-- </DisclosureButton> -->
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
            <img class="h-10 w-10 rounded-full" src={user.imageUrl} alt="" />
          </div>
          <div class="ml-3">
            <div class="text-base font-medium text-white">{user.name}</div>
            <div class="text-sm font-medium text-gray-400">{user.email}</div>
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
    </DisclosurePanel>
  </Disclosure>
</div>
