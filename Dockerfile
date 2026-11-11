FROM denoland/deno:debian

# FROM denoland/deno:alpine

# Bake environment variables directly into the image
ENV DENO_DIR=/deno-dir \
    VITE_HOST=0.0.0.0

WORKDIR /app

# Copy the script and set permissions as root
# COPY --chown=1000:1000 ./setup /setup
COPY setup/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# NEW: Create the directory and assign ownership to user 1000
RUN mkdir -p /deno-dir && chown -R 1000:1000 /deno-dir

# Switch to the non-root user for runtime execution
USER 1000:1000

EXPOSE 5173

ENTRYPOINT ["/entrypoint.sh"]
CMD ["deno", "task", "dev", "--host", "0.0.0.0"]