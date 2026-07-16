local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

vim.cmd("colorscheme catppuccin")

-- Open nvim-tree on startup
local function open_nvim_tree(data)
  local real_file = vim.fn.filereadable(data.file) == 1
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  local is_dir = vim.fn.isdirectory(data.file) == 1

  if is_dir then
    vim.cmd.cd(data.file)
  elseif not real_file and not no_name then
    return
  end

  require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
