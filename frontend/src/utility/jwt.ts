// import jwt from 'jsonwebtoken';
import * as jose from 'jose';
import { JWT_SECRET } from '$env/static/private';

type User = {
  email: string;
  id: string;
  exp: number;
};

// export const verifyAndDecodeToken = (token: string) => {
//   try {
//     return jwt.verify(token, JWT_SECRET) as User;
//   } catch {
//     return null;
//   }
// };

const secret = new TextEncoder().encode(JWT_SECRET);

export const verifyAndDecodeToken = (token: string) => {
  return jose.jwtVerify<User>(token, secret);
};
