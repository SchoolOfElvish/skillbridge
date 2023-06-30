import buildPath from './routes/buildPath';

export type Route = (params?: { [x: string]: string | number }) => string;

export type Routes = {
  root: Route;
  signUp: Route;
  signIn: Route;
  api: {
    refreshToken: Route;
  };
};

export const to: Routes = {
  root: buildPath('/'),
  signUp: buildPath('/sign-up'),
  signIn: buildPath('/sign-in'),
  api: {
    refreshToken: buildPath('/api/refresh-token'),
  }
};
