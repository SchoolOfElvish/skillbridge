<script lang="ts">
  import Layout from '$components/common/Layout.svelte';
  import type { PageData } from './$houdini';

  export let data: PageData;
  $: ({ RootQuery } = data)
</script>

<Layout viewer={$RootQuery?.data?.viewer}>
  {#if $RootQuery.fetching}
    <div>Loading...</div>
    {:else if $RootQuery.data}
    {$RootQuery.data.testField}
  {/if}
</Layout>
