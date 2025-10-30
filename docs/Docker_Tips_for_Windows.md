# Docker Tips for Windows
These notes will help you avoid common issues when running Docker Desktop on Windows.

---

## 🧩 1. Backend Choice: WSL2 vs Hyper-V
Modern Docker Desktop uses **WSL2** (Windows Subsystem for Linux v2) by default.  
Older setups might still use **Hyper-V**, but WSL2 is faster and recommended.

**Tips:**
- Ensure WSL2 is installed and set as the default backend in Docker Desktop → *Settings → General*.
- Check with:
  ```bash
  wsl --list --verbose
  ```
  You should see your distro (e.g., Ubuntu) using version 2.

---

## 🧩 2. File Path and Mount Issues
Windows uses different path syntax than Linux, and Docker containers use Linux paths.

**Tips:**
- Work inside your **WSL2 filesystem** (e.g., `/home/student/webtech2/`), not `/mnt/c/...`.
- In `docker-compose.yml`, always use forward slashes `/`, not backslashes `\`.

---

## 🧩 3. Line Ending Conflicts
Windows uses `CRLF` line endings, while Linux expects `LF`. This causes shell scripts to fail with “exec format error.”

**Fix:**
Add this to `.gitattributes`:
```gitattributes
*.sh text eol=lf
```
Or set VS Code → **Files: Eol → LF**.

---

## 🧩 4. Port Conflicts and Firewall Prompts
Windows Firewall may block container ports on first use.

**Fix:**
- When prompted, allow Docker on both *Private* and *Public* networks.
- If a port is in use, check with:
  ```bash
  netstat -ano | findstr 5432
  ```
  and adjust the port mapping in `docker-compose.yml`.

---

## 🧩 5. Performance and Disk Usage
Docker stores data inside the WSL2 VM, which can grow large over time.

**Fix:**
- Clean periodically:
  ```bash
  docker system prune -a
  docker volume prune
  ```
- To release WSL2 memory:
  ```bash
  wsl --shutdown
  ```

---

## 🧩 6. Network Access Between Containers and Host
Inside a container, `localhost` refers to that container.

**Use:**
- For connections *between containers*: `db` (service name in `docker-compose.yml`)
- For access to the host machine: `host.docker.internal`

Example:
```env
DATABASE_URL=postgresql://student:devpass@host.docker.internal:5432/webtech2
```

---

## 🧩 7. VS Code Integration
Running Node or Docker commands from PowerShell (Windows) instead of WSL may cause path issues.

**Fix:**
- Install **VS Code Remote - WSL** extension.
- Open your project *inside* WSL using:
  ```bash
  code .
  ```

---

## ✅ Quick Recap
| Issue | Symptom | Fix |
|--------|----------|------|
| Docker won't start | Missing backend | Enable WSL2 |
| Can't mount folder | Path not found | Work inside WSL filesystem |
| Shell script fails | "exec format error" | Use LF endings |
| Port blocked | Container won't start | Allow firewall or change port |
| Slow performance | File lag | Keep DBs in volumes |
| No DB connection | "ECONNREFUSED" | Use correct host |
| npm errors | Path mismatch | Run inside WSL |

---
**Happy coding on Windows! 🚀**
