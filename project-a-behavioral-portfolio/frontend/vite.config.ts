import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// Dev server on 5181; API on :8000 via frontend/.env
export default defineConfig({
  plugins: [react()],
  server: { port: 5181, strictPort: true },
  preview: { port: 5181 },
  build: { chunkSizeWarningLimit: 1200 },
})
