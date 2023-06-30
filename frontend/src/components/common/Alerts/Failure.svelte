<script lang="ts">
    import Icon from "$components/icons/Icon.svelte";
</script>

<div class="rounded-md bg-red-50 p-4">
  <div class="flex">
    <div class="flex-shrink-0">
      <Icon name="XMark" classes="h-5 w-5 text-red-400" />
    </div>
    <div class="ml-3">
      <h3 class="text-sm font-medium text-red-800">There were 2 errors with your submission</h3>
      <div class="mt-2 text-sm text-red-700">
        <ul class="list-disc space-y-1 pl-5">
          <slot/>
        </ul>
      </div>
    </div>
  </div>
</div>
