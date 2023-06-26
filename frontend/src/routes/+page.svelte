<script lang="ts">
  import type { PageServerData } from './$houdini'

  export let data: PageServerData
</script>
{ data.data?.testField }
