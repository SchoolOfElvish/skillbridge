<script lang="ts">
  import Header from '$components/common/Header.svelte';
  import SkeletonHeader from '$components/common/SkeletonHeader.svelte';

  import type { LayoutData } from './$houdini';
  export let data: LayoutData;

  $: ({ LayoutQuery } = data)
</script>

{#if $LayoutQuery.fetching}
  <SkeletonHeader isUserAuthenticated={true} />
  <div>Loading...</div>
{:else if $LayoutQuery.errors}
  <SkeletonHeader isUserAuthenticated={true} />
  <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
    <ul>
      {#each $LayoutQuery.errors as error}
        <li>{error.message}</li>
      {/each}
    </ul>
  </div>
{:else if $LayoutQuery.data}
  <Header user={$LayoutQuery.data?.viewer} />
{/if}

<main>
  <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
    <slot />
  </div>
</main>
