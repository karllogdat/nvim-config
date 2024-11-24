require("config.lazy")
require("lazy").setup("plugins")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {desc = "Help Tags" })