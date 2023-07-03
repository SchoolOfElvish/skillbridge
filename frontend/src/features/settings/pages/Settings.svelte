<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import Input from '$features/settings/components/Input.svelte';
  import DatePicker from '$features/settings/components/Datepicker.svelte';
  import { formatDate } from '$utility/formatDate';

  import { fragment, graphql } from '$houdini';

  import type { Settings_viewer$data as User, Settings_viewer as UserFragment } from '$houdini';

  export let viewer: UserFragment;

  $: user = fragment(
    viewer,
    graphql`
      fragment Settings_viewer on User {
        email
        firstName
        lastName
        birthdate
        about
      }
    `
  );

  let birthdate = '';

  let { firstName, lastName, email, about }: Omit<User, 'birthdate'> = {
    firstName: '',
    lastName: '',
    email: '',
    about: ''
  };

  let isDataLoaded = false;

  $: if ($user && !isDataLoaded) {
    firstName = $user.firstName;
    lastName = $user.lastName;
    email = $user.email;
    about = $user.about || '';
    birthdate = ($user.birthdate && formatDate($user.birthdate)) || '';
    isDataLoaded = true;
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
            <Input
              label="First Name"
              id="first-name"
              name="first-name"
              bind:value={firstName}
              autocomplete="given-name"
            />
            <Input
              label="Last Name"
              id="last-name"
              name="last-name"
              bind:value={lastName}
              autocomplete="family-name"
            />
            <Input
              label="Email Address"
              id="email-address"
              name="email-address"
              bind:value={email}
              autocomplete="email"
            />
            <DatePicker
              label="Birthdate"
              id="party"
              name="party"
              bind:value={birthdate}
              min="1900-01-01"
              max="2099-01-01"
              required
            />
            <!-- Datapicker -->

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
