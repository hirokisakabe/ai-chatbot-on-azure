import Redis from 'ioredis'

export const redis = new Redis({
  port: parseInt(process.env.REDIS_PORT || ''),
  host: process.env.REDIS_HOST || '',
  username: 'default',
  password: process.env.REDIS_PASSWORD || ''
})
