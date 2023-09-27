import NextAuth, {
  getServerSession,
  type DefaultSession,
  type AuthOptions
} from 'next-auth'

declare module 'next-auth' {
  interface Session {
    user: {
      /** The user's id. */
      id: string
    } & DefaultSession['user']
  }
}

import GithubProvider from 'next-auth/providers/github'

export const authOptions: AuthOptions = {
  providers: [
    GithubProvider({
      clientId: process.env.AUTH_GITHUB_ID || '',
      clientSecret: process.env.AUTH_GITHUB_SECRET || ''
    })
  ],
  callbacks: {
    jwt({ token, user }) {
      if (user) {
        token = { ...token, user: { id: user?.id } }
      }
      return token
    },
    session({ session, token }) {
      // @ts-ignore
      const userId = token?.user?.id

      if (typeof userId === 'string') {
        session.user.id = userId
      }

      return session
    }
  }
}

export const auth = async () => {
  return getServerSession(authOptions)
}
