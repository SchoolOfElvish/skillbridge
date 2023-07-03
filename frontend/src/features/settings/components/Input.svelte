<script lang="ts">
  export let label: string;
  export let id: string;
  export let name: string;
  export let value: string;
  export let autocomplete: string;
</script>

<div class="col-span-6 sm:col-span-3">
  <label for={id} class="block text-sm font-medium text-gray-700">{label}</label>
  <input
    bind:value={value}
    type="text"
    name={name}
    id={id}
    autocomplete={autocomplete}
    class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
  />
</div>
