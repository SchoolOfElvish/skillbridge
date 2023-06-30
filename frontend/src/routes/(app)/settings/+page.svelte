<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import type { PageData } from './$houdini';
  import type { SettingsPageQuery$result as QueryResult } from '$houdini';

  type User = QueryResult['viewer'];

  export let data: PageData;
  $: ({ SettingsPageQuery } = data);

  let birthdate = '2020-01-01'

  let { firstName, lastName, email, about }: Omit<User, 'birthdate'> = {
    firstName: '',
    lastName: '',
    email: '',
    about: '',
  };

  let dataLoaded = false;

  $: if ($SettingsPageQuery.data?.viewer && !dataLoaded) {
    const { viewer } = $SettingsPageQuery.data;
    firstName = viewer.firstName;
    lastName = viewer.lastName;
    email = viewer.email;
    about = viewer.about || '';
    dataLoaded = true;
  }
</script>

<!-- https://tailwindui.com/components/application-ui/forms/form-layouts -->
<div class="lg:grid lg:grid-cols-12 lg:gap-x-5 mt-2 max-w-screen-xl container mx-auto">
  <aside class="py-6 px-2 sm:px-6 lg:col-span-3 lg:py-0 lg:px-0">
    <nav class="space-y-1">
      <a
        href="/"
        class="bg-gray-200 text-indigo-700 hover:bg-white hover:text-indigo-700 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
        aria-current="page"
      >
        <Icon name="UserCircle" />
        <span class="truncate">
          {`pages.users.me.account`}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="Key" />
        <span class="truncate">
          {`pages.users.me.password`}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="CreditCard" />
        <span class="truncate">
          {`pages.users.me.billing_plan`}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="UserGroup" />
        <span class="truncate">
          {`pages.users.me.team`}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="SquaresPlus" />
        <span class="truncate">
          {`pages.users.me.integrations`}
        </span>
      </a>
    </nav>
  </aside>

  <div class="space-y-6 sm:px-6 lg:col-span-9 lg:px-0">
    <form action="#" method="POST">
      <div class="shadow sm:overflow-hidden sm:rounded-md">
        <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
          <div>
            <h3 class="text-base font-semibold leading-6 text-gray-900">
              {`pages.users.me.personal_information`}
            </h3>
            <p class="mt-1 text-sm text-gray-500">
              {`pages.users.me.use_permament_email`}
            </p>
          </div>

          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3 ">
              <label for="first-name" class="block text-sm font-medium text-gray-700"
                >{`pages.users.me.first_name`}</label
              >
              <input
                bind:value={firstName}
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="given-name"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label for="last-name" class="block text-sm font-medium text-gray-700"
                >{`pages.users.me.last_name`}</label
              >
              <input
                bind:value={lastName}
                type="text"
                name="last-name"
                id="last-name"
                autocomplete="family-name"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label for="email-address" class="block text-sm font-medium text-gray-700"
                >{`pages.users.me.email`}</label
              >
              <input
                bind:value={email}
                type="text"
                name="email-address"
                id="email-address"
                autocomplete="email"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <!-- Datapicker -->

            <div class="col-span-4 sm:col-span-3 sm:col-start-1 sm:col-end-3">
              <label for="postal-code" class="block text-sm font-medium text-gray-700"
                >{`pages.users.me.input_birthdate`}</label
              >
              <div class="date-picker">
                <input
                  bind:value={birthdate}
                  class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
                  type="date"
                  id="party"
                  name="party"
                  min="1900-01-01"
                  max="2099-01-01"
                  required
                />
              </div>
            </div>
            <!--BIO-->
            <div class="col-span-6 sm:col-span-4 sm:col-start-1 sm:col-end-5">
              <label for="bio" class="block text-sm font-medium text-gray-700">
                {`pages.users.me.about_me`}</label
              >
              <div class="mt-1">
                <textarea
                  bind:value={about}
                  id="bio"
                  name="bio"
                  class=" shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
                  style="height: 90px;"
                />
              </div>
            </div>
          </div>
        </div>

        <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
          <button
            type="button"
            class="inline-flex justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
          >
            {`pages.users.me.save`}
          </button>
        </div>
      </div>
    </form>
  </div>
</div>
