local keymap = vim.keymap

-- General Keymaps
keymap.set("n", "<Leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window Management
keymap.set("n", "<Leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<Leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<Leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<Leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- nvim-tree
keymap.set("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<Leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- Telescope
keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<Leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
keymap.set("n", "<Leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })

-- Ctrl+P (Quick Open, like VS Code Cmd+P)
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Quick Open" })
-- Ctrl+G (Global Search, like VS Code Cmd+Shift+F)
keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<CR>", { desc = "Global Search" })

-- Markdown preview
keymap.set("n", "<Leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })

