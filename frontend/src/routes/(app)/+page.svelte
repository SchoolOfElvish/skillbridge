<script lang="ts">
  import type { PageData } from './$houdini';

  export let data: PageData;
  $: ({ LayoutQuery } = data)
</script>

{#if $LayoutQuery.fetching}
  <div>Loading...</div>
{:else if $LayoutQuery.data}
  {$LayoutQuery.data.testField}
{/if}
