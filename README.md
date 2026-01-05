![lunarvim_logo_dark](https://user-images.githubusercontent.com/59826753/159940098-54284f26-f1da-4481-8b03-1deb34c57533.png)

<div align="center"><p>
    <a href="https://github.com/christopher-kapic/CKLunarVim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/christopher-kapic/CKLunarVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/christopher-kapic/CKLunarVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/christopher-kapic/CKLunarVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/christopher-kapic/CKLunarVim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/christopher-kapic/CKLunarVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/christopher-kapic/CKLunarVim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/christopher-kapic/CKLunarVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/christopher-kapic/CKLunarVim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/christopher-kapic/CKLunarVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/christopher-kapic/CKLunarVim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/christopher-kapic/CKLunarVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>

  <p align="center">
    <img src="https://stars.medv.io/christopher-kapic/CKLunarVim.svg", title="commits"/>
  </p>

## ⚠️ Fork Notice

**CKLunarVim is a fork of [LunarVim](https://github.com/LunarVim/LunarVim).**

This fork is **shamelessly vibecoded** and maintained independently. If there are ever updates to upstream LunarVim, **no effort will be made to reconcile with them**. From this point forward, CKLunarVim should be considered its own project.

This fork has been updated to work with **Neovim 0.11.5** and the latest versions of all packages, while the upstream LunarVim distribution does not work with Neovim versions after 0.9.5.

---

An IDE layer for Neovim with sane defaults. Completely free and community driven.

</div>

---

## Installation

### Prerequisites

- **Neovim 0.11.5 or higher** (required)
- Git
- A C compiler (for building some plugins)
- Make (for building some plugins)

### Quick Install

#### Linux / macOS

```bash
bash <(curl -s https://raw.githubusercontent.com/christopher-kapic/CKLunarVim/master/utils/installer/install.sh)
```

Or download and run the installer:

```bash
git clone https://github.com/christopher-kapic/CKLunarVim.git
cd CKLunarVim
bash utils/installer/install.sh
```

#### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -Command "& { irm https://raw.githubusercontent.com/christopher-kapic/CKLunarVim/master/utils/installer/install.ps1 | iex }"
```

Or download and run the installer:

```powershell
git clone https://github.com/christopher-kapic/CKLunarVim.git
cd CKLunarVim
powershell -ExecutionPolicy Bypass -File utils/installer/install.ps1
```

### After Installation

Once installed, you can start CKLunarVim by running:

```bash
lvim
```

The executable name remains `lvim` for compatibility with existing configurations and workflows.

### Configuration

Your configuration file will be located at:
- **Linux/macOS**: `~/.config/lvim/config.lua`
- **Windows**: `%LOCALAPPDATA%\lvim\config.lua`

Example configurations can be found in the repository at `utils/installer/config.example.lua`.

---

## Showcase

![demo3](https://user-images.githubusercontent.com/29136904/191626246-ce0cc0c5-4b41-49e3-9cb7-4b1867ab0dcb.png)
![info](https://user-images.githubusercontent.com/29136904/191624942-3d75ef87-35cf-434d-850e-3e7cd5ce2ad0.png)

---

## Features

- Modern IDE features for Neovim
- LSP support with automatic server installation
- Beautiful UI with customizable themes
- Extensive plugin ecosystem
- Optimized for Neovim 0.11.5+

---

## Updating

To update CKLunarVim, run:

```bash
lvim +LvimUpdate
```

Or manually pull the latest changes:

```bash
cd ~/.local/share/lunarvim/lvim  # or your LUNARVIM_BASE_DIR
git pull
```

---

## Uninstalling

### Linux / macOS

```bash
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File %LOCALAPPDATA%\lunarvim\lvim\utils\installer\uninstall.ps1
```

---

## Differences from Upstream LunarVim

- **Neovim 0.11.5+ support**: Works with the latest Neovim versions
- **Updated plugin versions**: All plugins updated to latest compatible versions
- **Independent development**: No synchronization with upstream

---

## Contributing

Contributions are welcome! Please note that this is an independent fork, so contributions should align with the direction of this project rather than upstream LunarVim.

---

## License

This project is licensed under the GPL-3.0 license - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

CKLunarVim is a fork of [LunarVim](https://github.com/LunarVim/LunarVim), which is an excellent Neovim distribution. This fork exists to provide support for newer Neovim versions and maintain an independent development path.

---

## Thanks to all contributors

<a href="https://github.com/christopher-kapic/CKLunarVim/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=christopher-kapic/CKLunarVim" />
</a>
