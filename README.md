# Kubernetes Dashboard Shortcuts (`kube`)

A collection of convenient shell scripts to manage Kubernetes Dashboard operations across different operating systems and shells.

## Contents

- `kube.bat`: Windows Command Prompt version
- `pwsh`: PowerShell function for Windows, macOS, and Linux
- `.zshrc`: Zsh function snippet to append to your own `~/.zshrc`
- `CHANGELOG.md`: Timeline of updates pulled from git history (see newest notes there)

## 📋 Overview

This repository provides platform-specific scripts that implement the same `kube` command with multiple subcommands for managing the Kubernetes Dashboard and kubectl contexts. Choose the appropriate file based on your operating system and shell environment.

See `CHANGELOG.md` for a quick view of what has changed between updates.

## 🎯 Available Commands

All versions support the following commands:

### Admin Commands

| Command                    | Description                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------- |
| `kube admin start`         | Start port-forwarding for the Kubernetes Dashboard (localhost:8443 → dashboard:443) |
| `kube admin token`         | Generate an authentication token for the admin-user service account                 |
| `kube admin token <name>`  | Generate an authentication token for a custom service account name                  |
| `kube admin install`       | Install the Kubernetes Dashboard using Helm                                         |
| `kube admin user`          | Create admin-user service account in kubernetes-dashboard namespace                 |
| `kube admin user <name>`   | Create a custom-named service account in kubernetes-dashboard namespace             |
| `kube admin fix-forbidden` | Fix 403 Forbidden errors by creating cluster role binding for admin-user            |

### Context Commands

| Command                 | Description                           |
| ----------------------- | ------------------------------------- |
| `kube list`             | List all available kubectl contexts   |
| `kube switch <context>` | Switch to a different kubectl context |

### Help

| Command     | Description                            |
| ----------- | -------------------------------------- |
| `kube help` | Display help message with all commands |

## 🖥️ Platform-Specific Files

### Windows (Command Prompt)

**File:** `kube.bat`

**Use when:**

- Running on Windows operating system
- Using Command Prompt (cmd.exe)
- Not using PowerShell

**Installation:**

1. Copy `kube.bat` to a directory in your PATH (e.g., `C:\Windows\System32` or a custom bin folder)
2. Alternatively, run from the current directory: `.\kube.bat <command> <subcommand>`

**Usage:**

```cmd
kube admin start
kube admin token
kube admin install
kube admin user
kube admin fix-forbidden
kube list
kube switch my-context
kube help
```

---

### Windows/macOS/Linux (PowerShell)

**File:** `pwsh`

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
kube admin start
kube admin token
kube admin token my-custom-user
kube admin install
kube admin user
kube admin user my-custom-user
kube admin fix-forbidden
kube list
kube switch production-cluster
kube help
```

---

### macOS/Linux (Zsh)

**File:** `.zshrc`

**Use when:**

- Using Zsh shell (default on macOS since Catalina)
- Running on macOS or Linux with Zsh installed
- You have a `.zshrc` configuration file

**Installation:**

> [!IMPORTANT]
> **Do NOT replace your existing `.zshrc` file.** Copy only the `kube()` function from this repository’s `.zshrc` and append it to your own config.

1. Open your existing `.zshrc` file:
   ```bash
   nano ~/.zshrc
   # or
   vim ~/.zshrc
   # or
   code ~/.zshrc
   ```
2. Copy the `kube()` function from this repository’s `.zshrc`
3. Paste it at the end of your own `~/.zshrc`
4. Save and reload your shell:
   ```bash
   source ~/.zshrc
   ```

**Usage:**

```bash
kube admin start
kube admin token
kube admin token my-custom-user
kube admin install
kube admin user
kube admin user my-custom-user
kube admin fix-forbidden
kube list
kube switch staging-cluster
kube help
```

---

## 🚀 Quick Start Guide

### First Time Setup

1. **Choose your script** based on the table below:

| Operating System | Shell/Environment | File to Use               |
| ---------------- | ----------------- | ------------------------- |
| Windows          | Command Prompt    | `kube.bat`                |
| Windows          | PowerShell        | `pwsh`                    |
| macOS            | Zsh (default)     | `.zshrc`                  |
| macOS            | PowerShell        | `pwsh`                    |
| Linux            | Zsh               | `.zshrc`                  |
| Linux            | Bash              | `.zshrc` (adapt for bash) |
| Linux            | PowerShell        | `pwsh`                    |

2. **Install the Kubernetes Dashboard:**

   ```bash
   kube admin install
   ```

3. **Create an admin user service account:**

   ```bash
   kube admin user
   ```

4. **Start the dashboard service:**

   ```bash
   kube admin start
   ```

   > This command runs in the foreground. Keep the terminal open while using the dashboard.

5. **Get your access token:**

   Open a new terminal window and run:

   ```bash
   kube admin token
   ```

   Copy the token output.

6. **Access the dashboard:**

   Open your browser to `https://localhost:8443` and paste the token from step 5 to log in.

### Troubleshooting

If you encounter 403 Forbidden errors when accessing the dashboard:

```bash
kube admin fix-forbidden
```

This creates a cluster role binding that grants cluster-admin privileges to the admin-user service account.

### Working with Multiple Contexts

To switch between different Kubernetes contexts:

```bash
# List available contexts
kube list

# Switch to a specific context
kube switch my-cluster-context
```

## 📝 Prerequisites

All scripts require the following tools to be installed:

- `kubectl` - Kubernetes command-line tool
- `helm` - Kubernetes package manager (v3+)
- An active Kubernetes cluster context

## 🔐 Security Note

> [!CAUTION]
> The `fix-forbidden` command grants cluster-admin privileges to the dashboard service account. This is convenient for development but should **NOT** be used in production environments. Always follow the principle of least privilege in production.

> [!WARNING]
> The `admin user` command creates a service account without any permissions by default. You'll need to either use `fix-forbidden` to grant cluster-admin rights, or create a more restrictive role binding for production use.

## 💡 Tips & Best Practices

- **Custom Service Accounts**: Use the `<name>` parameter to create multiple service accounts with different permission levels

  ```bash
  kube admin user read-only-user
  kube admin token read-only-user
  ```

- **Multiple Clusters**: Use `kube switch` to quickly change between development, staging, and production clusters

- **Token Expiration**: Tokens are temporary and expire based on your cluster configuration. Simply run `kube admin token` again to generate a new one

- **Port Forwarding**: The dashboard is only accessible while `kube admin start` is running. Consider using a terminal multiplexer like tmux or screen to keep it running in the background

## 📖 Additional Notes

- The `start` command runs in the foreground and must remain active for the dashboard to be accessible
- Press `Ctrl+C` to stop the port-forwarding
- The dashboard will be accessible at `https://localhost:8443` (note: HTTPS, you may need to accept a self-signed certificate warning in your browser)
- All commands that modify cluster resources (user, fix-forbidden) require appropriate kubectl permissions

## 🤝 Contributing

Feel free to:

- Adapt these scripts for other shells (Bash, Fish, etc.)
- Add new subcommands or features
- Improve error handling and user feedback
- Submit pull requests with improvements

## 📄 License

Free to use and modify as needed.
