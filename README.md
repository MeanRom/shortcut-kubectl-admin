# kubectl-admin Shortcuts

A collection of convenient shell scripts to manage Kubernetes Dashboard operations across different operating systems and shells.

## 📋 Overview

This repository provides platform-specific scripts that implement the same `kubectl-admin` command with multiple subcommands for managing the Kubernetes Dashboard. Choose the appropriate file based on your operating system and shell environment.

## 🎯 Available Commands

All versions support the following commands:

| Command                       | Description                                                                         |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| `kubectl-admin start`         | Start port-forwarding for the Kubernetes Dashboard (localhost:8443 → dashboard:443) |
| `kubectl-admin token`         | Generate an authentication token for the admin-user service account                 |
| `kubectl-admin install`       | Install the Kubernetes Dashboard using Helm                                         |
| `kubectl-admin fix-forbidden` | Fix 403 Forbidden errors by creating cluster role binding for admin-user            |
| `kubectl-admin help`          | Display help message with available commands                                        |

## 🖥️ Platform-Specific Files

### Windows (Command Prompt)

**File:** [`kubectl-admin.bat`](file:///Users/thomasmoerman/Documents/plugins/shortcut-kubectl-admin/kubectl-admin.bat)

**Use when:**

- Running on Windows operating system
- Using Command Prompt (cmd.exe)
- Not using PowerShell

**Installation:**

1. Copy `kubectl-admin.bat` to a directory in your PATH (e.g., `C:\Windows\System32` or a custom bin folder)
2. Alternatively, run from the current directory: `.\kubectl-admin.bat <command>`

**Usage:**

```cmd
kubectl-admin start
kubectl-admin token
kubectl-admin install
kubectl-admin fix-forbidden
```

---

### Windows/macOS/Linux (PowerShell)

**File:** [`pwsh`](file:///Users/thomasmoerman/Documents/plugins/shortcut-kubectl-admin/pwsh)

**Use when:**

- Using PowerShell on any platform (Windows PowerShell or PowerShell Core 7+)
- You prefer PowerShell scripting environment
- Cross-platform PowerShell environment

**Installation:**

1. Open your PowerShell profile:
   ```powershell
   notepad $PROFILE
   ```
   Or on macOS/Linux:
   ```powershell
   code $PROFILE
   ```
2. Copy the entire contents of the `pwsh` file into your PowerShell profile
3. Save and reload your profile:
   ```powershell
   . $PROFILE
   ```

**Usage:**

```powershell
kubectl-admin start
kubectl-admin token
kubectl-admin install
kubectl-admin fix-forbidden
kubectl-admin help
```

---

### macOS/Linux (Zsh)

**File:** [`.zshrc`](file:///Users/thomasmoerman/Documents/plugins/shortcut-kubectl-admin/.zshrc)

**Use when:**

- Using Zsh shell (default on macOS since Catalina)
- Running on macOS or Linux with Zsh installed
- You have a `.zshrc` configuration file

**Installation:**

> [!IMPORTANT] > **Do NOT replace your existing `.zshrc` file!** Only append the function to your existing configuration.

1. Open your existing `.zshrc` file:
   ```bash
   nano ~/.zshrc
   # or
   vim ~/.zshrc
   # or
   code ~/.zshrc
   ```
2. Scroll to the end of the file
3. Copy lines 10-47 from the `.zshrc` file in this repository (the `kubectl-admin()` function)
4. Paste at the end of your `.zshrc`
5. Save and reload your shell:
   ```bash
   source ~/.zshrc
   ```

**Usage:**

```bash
kubectl-admin start
kubectl-admin token
kubectl-admin install
kubectl-admin fix-forbidden
kubectl-admin help
```

---

## 🚀 Quick Start Guide

### First Time Setup

1. **Choose your script** based on the table below:

| Operating System | Shell/Environment | File to Use               |
| ---------------- | ----------------- | ------------------------- |
| Windows          | Command Prompt    | `kubectl-admin.bat`       |
| Windows          | PowerShell        | `pwsh`                    |
| macOS            | Zsh (default)     | `.zshrc`                  |
| macOS            | PowerShell        | `pwsh`                    |
| Linux            | Zsh               | `.zshrc`                  |
| Linux            | Bash              | `.zshrc` (adapt for bash) |
| Linux            | PowerShell        | `pwsh`                    |

2. **Install the Kubernetes Dashboard:**

   ```bash
   kubectl-admin install
   ```

3. **Start the dashboard service:**

   ```bash
   kubectl-admin start
   ```

4. **Get your access token:**
   Open a new terminal window and run:

   ```bash
   kubectl-admin token
   ```

5. **Access the dashboard:**
   Open your browser to `https://localhost:8443` and use the token from step 4

### Troubleshooting

If you encounter 403 Forbidden errors when accessing the dashboard:

```bash
kubectl-admin fix-forbidden
```

## 📝 Prerequisites

All scripts require the following tools to be installed:

- `kubectl` - Kubernetes command-line tool
- `helm` - Kubernetes package manager
- An active Kubernetes cluster context

## 🔐 Security Note

> [!CAUTION]
> The `fix-forbidden` command grants cluster-admin privileges to the dashboard service account. This is convenient for development but should **NOT** be used in production environments. Always follow the principle of least privilege in production.

## 📖 Additional Notes

- The `start` command runs in the foreground and must remain active for the dashboard to be accessible
- Press `Ctrl+C` to stop the port-forwarding
- Tokens generated with `token` are temporary and expire based on your cluster's configuration
- The dashboard will be accessible at `https://localhost:8443` (note: HTTPS, you may need to accept a self-signed certificate)

## 🤝 Contributing

Feel free to adapt these scripts for other shells (Bash, Fish, etc.) or improve existing functionality.

## 📄 License

Free to use and modify as needed.
