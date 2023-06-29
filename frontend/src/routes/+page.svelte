<script lang="ts">
  import type { PageData } from './$houdini';

  export let data: PageData;
  $: ({ LayoutQuery } = data)
</script>

{#if $LayoutQuery.fetching}
  <div>Loading...</div>
{:else if $LayoutQuery.errors}
  Some errors occurred: {$LayoutQuery.errors.map((error) => error.message).join(',')}
{:else if $LayoutQuery.data}
  {$LayoutQuery.data.testField}
{/if}
