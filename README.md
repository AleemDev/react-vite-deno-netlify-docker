# react-vite-deno-netlify-docker
A production-ready boilerplate for a front-end microservice built with React, Vite, and Deno, fully containerized with Docker and pre-configured for Netlify deployment.

## Project Overview

This repository provides a standalone, reusable starter kit for building a Single Page Application (SPA). It replaces the traditional Node.js runtime with Deno for native TypeScript support and optimized dependency management, while keeping local development entirely isolated within Docker.
Tech Stack

* Framework: React initialized via Vite.

* Runtime & Package Manager: Deno (utilizing native npm: specifier compatibility).

* Containerization: Docker & Docker Compose (using standard denoland/deno images).

* Deployment Target: Netlify.

## Core Architecture & Configuration

* Isolated Local Environment: The docker-compose.yml mounts the local directory as a volume (.:/app) and binds the server to port 5173, enabling instant Hot Module Replacement (HMR) without requiring Deno or Node.js to be installed on the host machine.

* Permission Management: The Docker configuration dynamically maps to the local host user ("${UID:-1000}:${GID:-1000}") and forces the Deno cache into a local .deno_cache/ directory. This prevents root ownership lockouts when generating files on Linux or WSL host machines.

* Netlify Integration: The boilerplate includes a netlify.toml file configured to execute deno task build natively during production deployments, alongside a public/_redirects file (/* /index.html 200) to ensure React Router and client-side routing function correctly on Netlify's edge CDN.