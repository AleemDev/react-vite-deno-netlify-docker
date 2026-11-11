#!/bin/sh
set -e

# ##### CUSTOMERS #####

# 1. Check if the project is already initialized (e.g., looking for a core file)
if [ ! -f "package.json" ]; then
    echo "No package.json found. Initializing new project files..."
    
    # Run your scaffolding command here. 
    # Because of the volume mount, these files will be created directly on your host machine.
    # deno run -A npm:create-vite@latest . --template react-ts
    
    # (Optional) Fix permissions if you are on Linux so the host user owns the generated files
    # chown -R 1000:1000 .

    #  -- 

    # Scaffold into a temporary subfolder to bypass the "directory not empty" prompt
    deno run -A npm:create-vite@latest _temp_app --template react-ts
    
    # Move all generated files (including hidden ones) up to /app
    mv _temp_app/* .
    mv _temp_app/.* . 2>/dev/null || true
    rmdir _temp_app
else
    echo "Project files found. Skipping initialization."
fi

# 2. Configure Vite for Docker
cat /setup/_vite.config.ts > /app/vite.config.ts

# 3. Add Netlify Configuration Files
cp /setup/_netlify.toml /app/netlify.toml
cp /setup/_netlify_redirects /app/public/_redirects

# 4. Install dependencies (creates node_modules/deno.lock on the host)
echo "Installing dependencies..."
deno install

# 5. Hand over to the CMD to start the server
echo "Starting the main application..."
exec "$@"