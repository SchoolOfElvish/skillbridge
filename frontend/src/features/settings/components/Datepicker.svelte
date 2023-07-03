<script lang="ts">
  export let label: string;
  export let id: string;
  export let name: string;
  export let value: string;
  export let min: string;
  export let max: string;
  export let required: boolean;
</script>

<div class="col-span-4 sm:col-span-3 sm:col-start-1 sm:col-end-3">
  <label for={id} class="block text-sm font-medium text-gray-700">{label}</label>
  <div class="date-picker">
    <input
      bind:value={value}
      class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
      type="date"
      id={id}
      name={name}
      min={min}
      max={max}
      required={required}
    />
  </div>
</div>
