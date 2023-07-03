<script lang="ts">
  import Layout from '$components/common/Layout.svelte';
  import Settings from '$features/settings/pages/Settings.svelte';

  import type { PageData } from './$houdini';
  export let data: PageData;

  $: ({ SettingsPageQuery } = data);

  $: viewer = $SettingsPageQuery?.data?.viewer;
</script>

<Layout {viewer}>
  {#if viewer}
    <Settings viewer={viewer} />
  {:else}
    Loading...
  {/if}
</Layout>
