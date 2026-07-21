-- Personal plugins layered on top of kickstart.
-- See `:help lazy.nvim-🔌-plugin-spec` for the spec format.

return {
  -- Tmux/nvim pane navigation (Ctrl+h/j/k/l), replaces kickstart's plain window nav
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>' },
    },
  },

  -- File explorer (keymaps <leader>e / <leader>ef live in init.lua)
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        view = {
          width = 40,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      }

      -- Open nvim-tree on startup (and cd into a directory argument)
      local function open_nvim_tree(data)
        local real_file = vim.fn.filereadable(data.file) == 1
        local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
        local is_dir = vim.fn.isdirectory(data.file) == 1

        if is_dir then
          vim.cmd.cd(data.file)
        elseif not real_file and not no_name then
          return
        end

        require('nvim-tree.api').tree.toggle { focus = true, find_file = true }
      end

      vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
    end,
    lazy = false,
  },

  -- Statusline (used instead of kickstart's mini.statusline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { options = { theme = 'catppuccin' } },
  },

  -- Markdown preview (browser, synced scrolling, mermaid + katex)
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
