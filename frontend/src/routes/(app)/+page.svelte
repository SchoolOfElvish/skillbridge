<script lang="ts">
  import type { PageData } from './$houdini';

  export let data: PageData;
  $: ({ RootQuery } = data);
</script>

{#if $RootQuery.fetching}
  <div>Loading...</div>
{:else if $RootQuery.data}
  {$RootQuery.data.testField}
{/if}
