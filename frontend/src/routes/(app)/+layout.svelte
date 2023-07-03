<script lang="ts">
  import type { LayoutData } from './$houdini';
  import Layout from '$components/common/Layout.svelte';

  export let data: LayoutData;
  $: ({ LayoutQuery } = data);
</script>

<Layout viewer={$LayoutQuery?.data?.viewer}>
  <slot />
</Layout>
