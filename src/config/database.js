import 'dotenv/config';
import { neon, neonConfig } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';

// In development, optionally route via Neon Local when USE_NEON_LOCAL=true.
// In production, connect directly to Neon Cloud via DATABASE_URL.
//let connectionString = process.env.DATABASE_URL;

if (process.env.NODE_ENV === 'development' ) {
  // The host name "neon-local" must match the Docker Compose service name.
  neonConfig.fetchEndpoint = 'http://neon-local:5432/sql';
  neonConfig.poolQueryViaFetch = true;
  neonConfig.useSecureWebSocket = false;

  // Default dev connection string for Neon Local; can be overridden via env.
  // connectionString =
  //   process.env.NEON_LOCAL_DATABASE_URL || 'postgres://user:password@neon-local:5432/dbname';
}

const sql = neon(process.env.DATABASE_URL);

const db = drizzle(sql);

export { db, sql };
