<script lang="ts">
  import Settings from '$features/settings/pages/Settings.svelte';

  import type { PageData } from './$houdini';
  export let data: PageData;

  $: ({ SettingsPageQuery } = data);

  $: viewer = $SettingsPageQuery?.data?.viewer;
</script>

{#if $SettingsPageQuery.fetching}
  Loading...
{:else if viewer}
<Settings viewer={viewer} />
{:else}
  Something went wrong
{/if}
