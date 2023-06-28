// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare global {
  namespace App {
    // interface Error {}
    interface Locals {
      user?: {
        isAuthenticated: boolean;
        id: string | null;
      };
    }
    // interface PageData {}
    // interface Platform {}
    interface Session {
      user?: {
        token?: string;
        refreshToken?: string;
      };
    }
  }
}

export {};
