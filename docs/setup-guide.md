# Web Technologies 2 – Development Environment Setup Guide

This guide walks you through setting up your environment for the Web Technologies 2 course.
You’ll use **Node.js**, **Docker**, **PostgreSQL**, and **VS Code** to build and test your projects.

---

## 🧰 1. Install Required Software

| Tool | Version (minimum) | Notes |
|------|-------------------|-------|
| **Node.js** | 20.x LTS | Includes `npm`; verify with `node -v` |
| **Git** | Latest | Required for managing assignments |
| **Docker Desktop** | 4.x or newer | Runs PostgreSQL and pgAdmin containers |
| **VS Code** | Latest | Recommended IDE |

---

## 💻 2. Install Recommended VS Code Extensions

Install these extensions from the VS Code Marketplace:

- **ESLint** (`dbaeumer.vscode-eslint`)
- **Prettier – Code Formatter** (`esbenp.prettier-vscode`)
- **Docker** (`ms-azuretools.vscode-docker`)
- **REST Client** (`humao.rest-client`)
- **Prisma** (`Prisma.prisma`)

---

## 🐘 3. Start PostgreSQL and pgAdmin via Docker

Be sure that Docker Desktop is running.
💡 Note: You do not need a Docker Hub account to use Docker Desktop for this course.
When prompted, click “Skip sign in.”

Open a command-line interface and navigate to your repository.

From the root of your course repository, run:

```bash
docker compose up -d
```

This starts:
- **PostgreSQL** at `localhost:5432`
- **pgAdmin** at [http://localhost:5050](http://localhost:5050)

To stop:
```bash
docker compose down
```

To reset everything (including databases):
```bash
docker compose down -v
```

---

## ⚙️ 4. Verify Database Connectivity

Use pgAdmin or `psql` to test your connection.

### Option 1: Using pgAdmin
1. Open [http://localhost:5050](http://localhost:5050)
2. Log in using:
   - Email: `student@example.com`
   - Password: `admin`
3. Create a new server connection:
   - **Host:** `db`
   - **Port:** `5432`
   - **Username:** `student`
   - **Password:** `devpass`

### Option 2: Using psql CLI
```bash
docker exec -it webtech2-db psql -U student -d webtech2
```

Then run:
```sql
SELECT NOW();
```
You should see a timestamp if connected successfully.

---

## 🧩 5. Environment Variables

At the repo root, copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

This file defines your database credentials, ports, and secrets.
Applications automatically read these variables when running.

---

## 🚀 6. Run a Test API

Create a simple server in any week’s folder to verify Node + Express setup:

```bash
npm init -y
npm install express
```

Create `index.js`:

```js
import express from "express";
const app = express();
app.get("/", (req, res) => res.send("Server is running!"));
app.listen(process.env.PORT || 3000, () => console.log("Server started."));
```

Run it:
```bash
node index.js
```
Then visit [http://localhost:3000](http://localhost:3000).

---

## 🧽 7. Maintenance Commands

| Action | Command |
|--------|----------|
| View running containers | `docker ps` |
| View logs for a service | `docker logs webtech2-db` |
| Stop all containers | `docker compose down` |
| Clean unused data | `docker system prune -a` |
| Remove all volumes | `docker volume prune` |

---

## 🧠 8. Troubleshooting

If you encounter problems:

- **On macOS:** see `common/Docker_Tips_for_macOS.md`
- **On Windows:** see `common/Docker_Tips_for_Windows.md`
- **Docker fails to start:** ensure WSL2 (Windows) or virtualization (Mac) is enabled
- **Port already in use:** edit `docker-compose.yml` and change port mappings
- **Permission errors:** run `sudo chown -R $USER:$USER .` on macOS/Linux

---

✅ Once everything above is working, you’re ready to begin **Week 1: Server-Side JavaScript Fundamentals.**
Happy coding!
