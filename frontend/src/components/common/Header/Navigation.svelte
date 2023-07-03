<script lang="ts">
  import type { NavigationItem } from '../Header.svelte';

  export let navigation: NavigationItem[];
</script>

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
