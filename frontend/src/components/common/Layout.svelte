<script lang="ts">
  import Header from '$components/common/Header.svelte';
  import SkeletonHeader from '$components/common/SkeletonHeader.svelte';
  import { fragment, graphql } from '$houdini';
  import type { Layout_viewer } from '$houdini';

  export let viewer: Layout_viewer | undefined;

  $: user = fragment(viewer, graphql`
    fragment Layout_viewer on User {
      ...Header_user
    }
  `);
</script>

{#if $user}
  <Header user={$user} />
{:else}
  <SkeletonHeader isUserAuthenticated={false} />
{/if}

<main>
  <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
    <slot />
  </div>
</main>
