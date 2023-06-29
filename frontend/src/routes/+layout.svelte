<script lang="ts">
  import '../app.css';
  import Header from '$components/common/Header.svelte';
  import type { PageData } from './$houdini';

  export let data: PageData;
  $: ({ LayoutQuery } = data)
</script>

{#if $LayoutQuery.fetching}
  <div>Loading...</div>
{:else if $LayoutQuery.errors}
  <div>Errors: {$LayoutQuery.errors.map((error) => error.message).join(',')}</div>
{:else if $LayoutQuery.data}
  <div class="min-h-full">
    <Header user={$LayoutQuery.data?.viewer} />
    <header class="bg-white shadow-sm">
      <div class="mx-auto max-w-7xl px-4 py-4 sm:px-6 lg:px-8">
        <h1 class="text-lg font-semibold leading-6 text-gray-900">Dashboard</h1>
      </div>
    </header>
    <main>
      <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
        <slot />
      </div>
    </main>
  </div>
{/if}
