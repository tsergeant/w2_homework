# Docker Tips for macOS
These notes will help you avoid common issues when running Docker on macOS.

---

## 🧩 1. File Sharing and Volume Performance
On macOS, Docker runs inside a lightweight Linux VM, which makes file sharing slower than on Windows or Linux.

**Tips:**
- Keep large data (like PostgreSQL) in Docker **volumes**, not shared folders.
- Avoid mounting the entire project directory unless needed.
- Use `nodemon --delay 200ms` to reduce lag in live-reload.

---

## 🧩 2. Network Access
Inside a container, `localhost` refers to that container — not your host machine.

**Use these connection strings:**
- **From your host:** `postgresql://student:devpass@localhost:5432/webtech2`
- **From another container:** `postgresql://student:devpass@db:5432/webtech2`

---

## 🧩 3. Port Conflicts
If ports like `5432` (PostgreSQL) or `5050` (pgAdmin) are busy, change them in `docker-compose.yml`:

```yaml
ports:
  - "5433:5432"
  - "5051:80"
```

---

## 🧩 4. Apple Silicon (M1/M2/M3) Compatibility
Most official images now support ARM. If you get an "exec format error," force x86_64 emulation:

```yaml
platform: linux/amd64
```

---

## 🧩 5. Disk Space Management
Docker stores all data inside a hidden VM, which can grow large.

**Clean up occasionally:**
```bash
docker system prune -a
docker volume prune
```

---

## 🧩 6. File Permissions
If you see permission errors with mounted folders:

```bash
sudo chown -R $USER:$USER .
```

---

## ✅ Quick Recap
| Issue | Symptom | Fix |
|--------|----------|------|
| Slow reloads | Changes not detected | Use volumes + debounce |
| Cannot connect to DB | "ECONNREFUSED" | Use `db` hostname |
| Port in use | Container won't start | Change ports |
| Image error | "exec format error" | Add `platform: linux/amd64` |
| Disk space low | Docker app huge | Run prune commands |

---
**Happy coding! 🚀**
