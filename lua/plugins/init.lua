return { 
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = make },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smat_case",
					},
					path_display = { "truncate" },
					mappings = {
						i = {
							["<C-n>"] = require("telescope.actions").cycle_history_next,
							["<C-p>"] = require("telescope.actions").cycle_history_prev,
							["<C-c>"] = require("telescope.actions").close,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("lspconfig").jdtls.setup {
				cmd = { "jdtls" },
				root_dir = require("lspconfig").util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
			}
			require("lspconfig").clangd.setup {}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path", 
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn then vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path"},
				}),
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
					}),
					documentation = cmp.config.window.bordered({
						border = "single",
					}),
				},
			}
		end,
	},
	-- Syntax highlighting plugin
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = { "java", "c" },
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end,
	},

	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("neo-tree").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				-- customize settings here
				check_ts = true, -- enable treesitter integration
			})
		end,
	},
	"folke/neodev.nvim",
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
}
