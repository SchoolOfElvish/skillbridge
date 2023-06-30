import buildPath from './routes/buildPath';

export type Route = (params?: { [x: string]: string | number }) => string;

export type Routes = {
  root: Route;
  signUp: Route;
  signIn: Route;
  signOut: Route;
  settings: Route;
  api: {
    refreshToken: Route;
  };
};

export const to: Routes = {
  root: buildPath('/'),
  signUp: buildPath('/sign-up'),
  signIn: buildPath('/sign-in'),
  signOut: buildPath('/sign-out'),
  settings: buildPath('/settings'),
  api: {
    refreshToken: buildPath('/api/refresh-token'),
  }
};
