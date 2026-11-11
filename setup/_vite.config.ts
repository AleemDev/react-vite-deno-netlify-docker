import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true, // Exposes server to the Docker host
    port: 5173,
    watch: {
      usePolling: true, // Ensures hot-reloading works in Docker
    }
  }
})