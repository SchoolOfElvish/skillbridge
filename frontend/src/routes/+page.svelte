<script lang="ts">
  import type { PageData } from './$houdini'

  export let data: PageData
  $:({ TestQuery } = data)
</script>
{#if $TestQuery?.fetching}
  <p>Loading...</p>
{:else}
  {$TestQuery.data?.testField}
{/if}
