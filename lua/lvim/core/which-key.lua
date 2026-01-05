local M = {}
M.config = function()
  lvim.builtin.which_key = {
    ---@usage disable which-key completely [not recommended]
    active = true,
    on_config_done = nil,
    setup = {
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,
          suggestions = 20,
        }, -- use which-key for spelling hints
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      defer = { gc = "Comments" },
      replace = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = lvim.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
        separator = lvim.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
        group = lvim.icons.ui.Plus, -- symbol prepended to a group
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      win = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      -- filter option replaces ignore_missing
      -- Set to nil to show all mappings (old ignore_missing = false)
      -- Or provide a function to filter mappings
      filter = nil,
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- triggers must be a table (not "auto" string)
      triggers = { "<leader>" }, -- automatically setup triggers for <leader>
      -- Note: triggers_blacklist is deprecated in favor of triggers
      -- The blacklist functionality may need to be configured differently in the new API
      -- For now, we'll rely on the default behavior
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    },

    opts = {
      mode = "n", -- NORMAL mode
      -- Options like nowait, remap, silent are specified in each mapping entry
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    },
    vopts = {
      mode = { "v" }, -- VISUAL mode
      -- Options like nowait, remap, silent are specified in each mapping entry
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    },
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    vmappings = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment toggle linewise (visual)", nowait = true, remap = false },
      { "<leader>l", group = "LSP", nowait = true, remap = false },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
      { "<leader>g", group = "Git", nowait = true, remap = false },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk", nowait = true, remap = false },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk", nowait = true, remap = false },
    },
    mappings = {
      { "<leader>;", "<cmd>Alpha<CR>", desc = "Dashboard", nowait = true, remap = false },
      { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
      { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit", nowait = true, remap = false },
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line", nowait = true, remap = false },
      { "<leader>c", "<cmd>BufferKill<CR>", desc = "Close Buffer", nowait = true, remap = false },
      { "<leader>f", "<cmd>lua require('lvim.core.telescope.custom-finders').find_project_files({ previewer = false })<cr>", desc = "Find File", nowait = true, remap = false },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer", nowait = true, remap = false },
      { "<leader>b", group = "Buffers", nowait = true, remap = false },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump", nowait = true, remap = false },
      { "<leader>bf", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find", nowait = true, remap = false },
      { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous", nowait = true, remap = false },
      { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next", nowait = true, remap = false },
      { "<leader>bW", "<cmd>noautocmd w<cr>", desc = "Save without formatting (noautocmd)", nowait = true, remap = false },
      -- { "<leader>bw", "<cmd>BufferWipeout<cr>", desc = "Wipeout", nowait = true, remap = false }, -- TODO: implement this for bufferline
      { "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close", nowait = true, remap = false },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left", nowait = true, remap = false },
      { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right", nowait = true, remap = false },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory", nowait = true, remap = false },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language", nowait = true, remap = false },
      { "<leader>d", group = "Debug", nowait = true, remap = false },
      { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = true, remap = false },
      { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = true, remap = false },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
      { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", nowait = true, remap = false },
      { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = true, remap = false },
      { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = true, remap = false },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
      { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
      { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", nowait = true, remap = false },
      { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
      { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = true, remap = false },
      { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = true, remap = false },
      { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI", nowait = true, remap = false },
      { "<leader>p", group = "Plugins", nowait = true, remap = false },
      { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
      { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
      { "<leader>pS", "<cmd>Lazy clear<cr>", desc = "Status", nowait = true, remap = false },
      { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean", nowait = true, remap = false },
      { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },
      { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile", nowait = true, remap = false },
      { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log", nowait = true, remap = false },
      { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug", nowait = true, remap = false },

      -- " Available Debug Adapters:
      -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
      -- " Adapter configuration and installation instructions:
      -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      -- " Debug Adapter protocol:
      -- "   https://microsoft.github.io/debug-adapter-protocol/
      -- " Debugging
      { "<leader>g", group = "Git", nowait = true, remap = false },
      { "<leader>gg", "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", desc = "Lazygit", nowait = true, remap = false },
      { "<leader>gj", "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", desc = "Next Hunk", nowait = true, remap = false },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", desc = "Prev Hunk", nowait = true, remap = false },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
      { "<leader>gL", "<cmd>lua require 'gitsigns'.blame_line({full=true})<cr>", desc = "Blame Line (full)", nowait = true, remap = false },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
      { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
      { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit(for current file)", nowait = true, remap = false },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", nowait = true, remap = false },
      { "<leader>l", group = "LSP", nowait = true, remap = false },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
      { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics", nowait = true, remap = false },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", nowait = true, remap = false },
      { "<leader>lf", "<cmd>lua require('lvim.lsp.utils').format()<cr>", desc = "Format", nowait = true, remap = false },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info", nowait = true, remap = false },
      { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", nowait = true, remap = false },
      { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
      { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix", nowait = true, remap = false },
      { "<leader>L", group = "LunarVim", nowait = true, remap = false },
      { "<leader>Lc", "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>", desc = "Edit config.lua", nowait = true, remap = false },
      { "<leader>Ld", "<cmd>LvimDocs<cr>", desc = "View LunarVim's docs", nowait = true, remap = false },
      { "<leader>Lf", "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", desc = "Find LunarVim files", nowait = true, remap = false },
      { "<leader>Lg", "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", desc = "Grep LunarVim files", nowait = true, remap = false },
      { "<leader>Lk", "<cmd>Telescope keymaps<cr>", desc = "View LunarVim's keymappings", nowait = true, remap = false },
      { "<leader>Li", "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", desc = "Toggle LunarVim Info", nowait = true, remap = false },
      { "<leader>LI", "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>", desc = "View LunarVim's changelog", nowait = true, remap = false },
      { "<leader>Ll", group = "logs", nowait = true, remap = false },
      { "<leader>Lld", "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>", desc = "view default log", nowait = true, remap = false },
      { "<leader>LlD", "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", desc = "Open the default logfile", nowait = true, remap = false },
      { "<leader>Lll", "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", desc = "view lsp log", nowait = true, remap = false },
      { "<leader>LlL", "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", desc = "Open the LSP logfile", nowait = true, remap = false },
      { "<leader>Lln", "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", desc = "view neovim log", nowait = true, remap = false },
      { "<leader>LlN", "<cmd>edit $NVIM_LOG_FILE<cr>", desc = "Open the Neovim logfile", nowait = true, remap = false },
      { "<leader>Lr", "<cmd>LvimReload<cr>", desc = "Reload LunarVim's configuration", nowait = true, remap = false },
      { "<leader>Lu", "<cmd>LvimUpdate<cr>", desc = "Update LunarVim", nowait = true, remap = false },
      { "<leader>s", group = "Search", nowait = true, remap = false },
      { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
      { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups", nowait = true, remap = false },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
      { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
      { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text", nowait = true, remap = false },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
      { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Resume last search", nowait = true, remap = false },
      { "<leader>sp", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview", nowait = true, remap = false },
      { "<leader>T", group = "Treesitter", nowait = true, remap = false },
      { "<leader>Ti", ":TSConfigInfo<cr>", desc = "Info", nowait = true, remap = false },
    },
  }
end

M.setup = function()
  -- Ensure leader is set before which-key setup
  -- This must happen before which-key processes mappings
  if not vim.g.mapleader then
    vim.g.mapleader = (lvim.leader == "space" and " ") or (lvim.leader or " ")
  end
  -- Also set maplocalleader if not set
  if not vim.g.maplocalleader then
    vim.g.maplocalleader = "\\"
  end

  local which_key = require "which-key"

  which_key.setup(lvim.builtin.which_key.setup)

  local opts = lvim.builtin.which_key.opts
  local vopts = lvim.builtin.which_key.vopts

  local mappings = lvim.builtin.which_key.mappings
  local vmappings = lvim.builtin.which_key.vmappings

  -- Register mappings - which-key will expand <leader> automatically
  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)

  if lvim.builtin.which_key.on_config_done then
    lvim.builtin.which_key.on_config_done(which_key)
  end
end

return M
