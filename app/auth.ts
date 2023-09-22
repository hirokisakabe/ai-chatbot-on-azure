import NextAuth, { getServerSession, type DefaultSession } from 'next-auth'

declare module 'next-auth' {
  interface Session {
    user: {
      /** The user's id. */
      id: string
    } & DefaultSession['user']
  }
}

import GithubProvider from 'next-auth/providers/github'

export const authOptions = {
  providers: [
    GithubProvider({
      clientId: process.env.AUTH_GITHUB_ID || '',
      clientSecret: process.env.AUTH_GITHUB_SECRET || ''
    })
  ],
  callbacks: {
    jwt({ token, user }: any) {
      if (user) {
        token = { ...token, user: { id: user?.id } }
      }
      return token
    },
    session({ session, token }: any) {
      session.user.id = token?.user?.id

      return session
    },
    authorized({ auth }: any) {
      return !!auth?.user // this ensures there is a logged in user for -every- request
    }
  }
}

export const auth = async () => {
  return getServerSession(authOptions)
}
