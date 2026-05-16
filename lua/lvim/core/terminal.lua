local M = {}
local Log = require "lvim.core.log"

M.config = function()
  lvim.builtin["terminal"] = {
    active = true,
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- Make newline work in terminal TUIs: maps <S-CR>/<M-CR> to send a real
    -- newline, and passes Ctrl+J (literal newline, ASCII LF) through to the
    -- program instead of CKLunarVim's terminal-mode <C-j> window-nav map.
    -- Lets AI agents / REPLs insert a line break instead of submitting (or
    -- closing a floating terminal). Set to false to opt out for all terminals.
    newline_mapping = true,
    shell = nil, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = false,
    },
    -- Add executables on the config.lua
    -- { cmd, keymap, description, direction, size }
    -- lvim.builtin.terminal.execs = {...} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    -- TODO: pls add mappings in which key and refactor this
    execs = {
      { nil, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
      { nil, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
      { nil, "<M-3>", "Float Terminal", "float", nil },
    },
  }
end

--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
local function get_dynamic_terminal_size(direction, size)
  size = size or lvim.builtin.terminal.size
  if direction ~= "float" and tostring(size):find(".", 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = get_buf_size()
    local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end

--- Send a literal newline (\n) to the terminal job in the current buffer.
--- Works around Neovim sending <CR> for both Enter and Shift+Enter, which
--- interactive TUIs (REPLs, AI agents, ...) interpret as "submit".
local function send_terminal_newline()
  local job = vim.b.terminal_job_id
  if job then
    vim.fn.chansend(job, "\n")
  end
end

--- Make newline work in terminal TUIs (REPLs, AI agents, ...) for the given
--- buffer: <S-CR>/<M-CR> send a real newline, and <C-j> (literal newline,
--- ASCII LF) is passed straight through to the program. The <C-j> map
--- shadows the global term_mode <C-j> window-nav map (lua/lvim/keymappings.lua)
--- for this buffer only, so Ctrl+J inserts a newline instead of leaving
--- terminal mode and closing a floating terminal.
---@param bufnr integer
local function set_newline_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, desc = "Send newline to terminal" }
  vim.keymap.set("t", "<S-CR>", send_terminal_newline, opts)
  vim.keymap.set("t", "<M-CR>", send_terminal_newline, opts)
  vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = bufnr, silent = true })
end

--- Make a terminal buffer friendly to interactive TUIs: the newline keys
--- (see set_newline_keymaps) plus pass the remaining Ctrl-h/k/l straight
--- through to the program instead of letting the global term_mode window-nav
--- maps (lua/lvim/keymappings.lua) leave terminal mode and hide a float.
---@param bufnr integer
local function set_ai_keymaps(bufnr)
  set_newline_keymaps(bufnr)
  for _, key in ipairs { "<C-h>", "<C-k>", "<C-l>" } do
    vim.keymap.set("t", key, key, { buffer = bufnr, silent = true })
  end
end

M.init = function()
  for i, exec in pairs(lvim.builtin.terminal.execs) do
    local direction = exec[4] or lvim.builtin.terminal.direction

    local opts = {
      cmd = exec[1] or lvim.builtin.terminal.shell or vim.o.shell,
      keymap = exec[2],
      label = exec[3],
      -- NOTE: unable to consistently bind id/count <= 9, see #2146
      count = i + 100,
      direction = direction,
      size = function()
        return get_dynamic_terminal_size(direction, exec[5])
      end,
    }

    M.add_exec(opts)
  end

  -- Registered here (in init, which lazy.nvim always runs at startup) rather
  -- than in M.setup, so it applies to every terminal -- including plain
  -- :terminal buffers -- regardless of toggleterm's lazy loading. The flag is
  -- read when a terminal opens, so user overrides in config.lua still apply.
  local group = vim.api.nvim_create_augroup("LvimTerminalNewline", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    pattern = "*",
    callback = function(args)
      if lvim.builtin.terminal.newline_mapping then
        set_newline_keymaps(args.buf)
      end
    end,
    desc = "Send newline on <S-CR>/<M-CR> in terminals",
  })
end

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(lvim.builtin.terminal)

  if lvim.builtin.terminal.on_config_done then
    lvim.builtin.terminal.on_config_done(terminal)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    Log:debug("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  vim.keymap.set({ "n", "t" }, opts.keymap, function()
    M._exec_toggle { cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() }
  end, { desc = opts.label, noremap = true, silent = true })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(opts.size, opts.direction)
end

---Toggles a log viewer according to log.viewer.layout_config
---@param logfile string the fullpath to the logfile
M.toggle_log_view = function(logfile)
  local log_viewer = lvim.log.viewer.cmd
  if vim.fn.executable(log_viewer) ~= 1 then
    log_viewer = "less +F"
  end
  Log:debug("attempting to open: " .. logfile)
  log_viewer = log_viewer .. " " .. logfile
  local term_opts = vim.tbl_deep_extend("force", lvim.builtin.terminal, {
    cmd = log_viewer,
    open_mapping = lvim.log.viewer.layout_config.open_mapping,
    direction = lvim.log.viewer.layout_config.direction,
    -- TODO: this might not be working as expected
    size = lvim.log.viewer.layout_config.size,
    float_opts = lvim.log.viewer.layout_config.float_opts,
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local log_view = Terminal:new(term_opts)
  log_view:toggle()
end

M.lazygit_toggle = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
      zindex = 200,
    },
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
    on_close = function(_) end,
    count = 99,
  }
  lazygit:toggle()
end

--- Toggle a floating terminal running an interactive AI agent (or any
--- command), with keymaps tuned for agent TUIs: <S-CR>/<M-CR> insert a
--- newline, and Ctrl-h/j/k/l pass through to the agent instead of hiding
--- the float. CKLunarVim is intentionally unopinionated about which agent;
--- pass the command and bind it from your config.lua, e.g.:
---   vim.keymap.set({ "n", "t" }, "<C-a>", function()
---     require("lvim.core.terminal").ai_terminal_toggle "opencode"
---   end, { desc = "AI agent terminal" })
---@param cmd string the agent command to run (e.g. "claude", "opencode", "aider")
M.ai_terminal_toggle = function(cmd)
  if type(cmd) ~= "string" or cmd == "" then
    Log:error "ai_terminal_toggle: expected a non-empty command string"
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local agent = Terminal:new {
    cmd = cmd,
    hidden = true,
    direction = "float",
    float_opts = {
      border = lvim.builtin.terminal.float_opts.border,
    },
    on_open = function(term)
      vim.cmd "startinsert!"
      set_ai_keymaps(term.bufnr)
    end,
    on_close = function(_) end,
    count = 98,
  }
  agent:toggle()
end

return M
