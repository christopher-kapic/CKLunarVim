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
      -- Start hidden and wait for a key to be pressed before showing the popup
      -- Only used by enabled xo mapping modes.
      defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
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
        padding = { 2, 2 }, -- extra window padding [top/bottom, right/left]
        wo = {
          winblend = 0,
        },
      },
      layout = {
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      -- filter option replaces ignore_missing
      -- Set to nil to show all mappings (old ignore_missing = false)
      -- Or provide a function to filter mappings
      filter = nil,
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- Which-key automatically sets up triggers for your mappings.
      -- Using auto triggers for all modes (nixso)
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by default for Telescope
      disable = {
        bt = {},
        ft = { "TelescopePrompt" },
      },
    },
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    vmappings = {
      { "/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment toggle linewise (visual)" },
      { "l", group = "LSP" },
      { "la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "g", group = "Git" },
      { "gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
    },
    mappings = {
      { ";", "<cmd>Alpha<CR>", desc = "Dashboard" },
      { "w", "<cmd>w!<CR>", desc = "Save" },
      { "q", "<cmd>confirm q<CR>", desc = "Quit" },
      { "/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line" },
      { "c", "<cmd>BufferKill<CR>", desc = "Close Buffer" },
      { "f", "<cmd>lua require('lvim.core.telescope.custom-finders').find_project_files({ previewer = false })<cr>", desc = "Find File" },
      { "h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
      { "e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
      { "b", group = "Buffers" },
      { "bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
      { "bf", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find" },
      { "bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      { "bW", "<cmd>noautocmd w<cr>", desc = "Save without formatting (noautocmd)" },
      -- { "bw", "<cmd>BufferWipeout<cr>", desc = "Wipeout" }, -- TODO: implement this for bufferline
      { "be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
      { "bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
      { "bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
      { "bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
      { "bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
      { "d", group = "Debug" },
      { "dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
      { "dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
      { "dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
      { "dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
      { "di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
      { "do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
      { "du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
      { "dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
      { "dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
      { "ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
      { "dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
      { "dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
      { "p", group = "Plugins" },
      { "pi", "<cmd>Lazy install<cr>", desc = "Install" },
      { "ps", "<cmd>Lazy sync<cr>", desc = "Sync" },
      { "pS", "<cmd>Lazy clear<cr>", desc = "Status" },
      { "pc", "<cmd>Lazy clean<cr>", desc = "Clean" },
      { "pu", "<cmd>Lazy update<cr>", desc = "Update" },
      { "pp", "<cmd>Lazy profile<cr>", desc = "Profile" },
      { "pl", "<cmd>Lazy log<cr>", desc = "Log" },
      { "pd", "<cmd>Lazy debug<cr>", desc = "Debug" },

      -- " Available Debug Adapters:
      -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
      -- " Adapter configuration and installation instructions:
      -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      -- " Debug Adapter protocol:
      -- "   https://microsoft.github.io/debug-adapter-protocol/
      -- " Debugging
      { "g", group = "Git" },
      { "gg", "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", desc = "Lazygit" },
      { "gj", "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", desc = "Next Hunk" },
      { "gk", "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", desc = "Prev Hunk" },
      { "gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
      { "gL", "<cmd>lua require 'gitsigns'.blame_line({full=true})<cr>", desc = "Blame Line (full)" },
      { "gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
      { "gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
      { "gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
      { "gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
      { "gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
      { "go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
      { "gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      { "gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
      { "gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit(for current file)" },
      { "gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
      { "l", group = "LSP" },
      { "la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
      { "lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "lf", "<cmd>lua require('lvim.lsp.utils').format()<cr>", desc = "Format" },
      { "li", "<cmd>LspInfo<cr>", desc = "Info" },
      { "lI", "<cmd>Mason<cr>", desc = "Mason Info" },
      { "lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
      { "lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
      { "ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
      { "lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
      { "lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
      { "L", group = "LunarVim" },
      { "Lc", "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>", desc = "Edit config.lua" },
      { "Ld", "<cmd>LvimDocs<cr>", desc = "View LunarVim's docs" },
      { "Lf", "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", desc = "Find LunarVim files" },
      { "Lg", "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", desc = "Grep LunarVim files" },
      { "Lk", "<cmd>Telescope keymaps<cr>", desc = "View LunarVim's keymappings" },
      { "Li", "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", desc = "Toggle LunarVim Info" },
      { "LI", "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>", desc = "View LunarVim's changelog" },
      { "Ll", group = "logs" },
      { "Lld", "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>", desc = "view default log" },
      { "LlD", "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", desc = "Open the default logfile" },
      { "Lll", "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", desc = "view lsp log" },
      { "LlL", "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", desc = "Open the LSP logfile" },
      { "Lln", "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", desc = "view neovim log" },
      { "LlN", "<cmd>edit $NVIM_LOG_FILE<cr>", desc = "Open the Neovim logfile" },
      { "Lr", "<cmd>LvimReload<cr>", desc = "Reload LunarVim's configuration" },
      { "Lu", "<cmd>LvimUpdate<cr>", desc = "Update LunarVim" },
      { "s", group = "Search" },
      { "sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      { "sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
      { "sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "sH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups" },
      { "sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
      { "sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
      { "sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "sl", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
      { "sp", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview" },
      { "T", group = "Treesitter" },
      { "Ti", ":TSConfigInfo<cr>", desc = "Info" },
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

  -- Helper function to prepend leader prefix to mapping keys
  local function prepend_leader(mapping_table, mode)
    local result = {}
    for _, mapping in ipairs(mapping_table) do
      local new_mapping = vim.deepcopy(mapping)
      if type(new_mapping[1]) == "string" then
        new_mapping[1] = "<leader>" .. new_mapping[1]
      end
      if mode then
        new_mapping.mode = mode
      end
      table.insert(result, new_mapping)
    end
    return result
  end

  local mappings = lvim.builtin.which_key.mappings
  local vmappings = lvim.builtin.which_key.vmappings

  -- Add mappings with leader prefix prepended
  -- Normal mode mappings
  which_key.add(prepend_leader(mappings, "n"))
  -- Visual mode mappings
  which_key.add(prepend_leader(vmappings, "v"))

  if lvim.builtin.which_key.on_config_done then
    lvim.builtin.which_key.on_config_done(which_key)
  end
end

return M
