-- Boostrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

-- Settings
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ignore case if search for only lower case
-- Respect case if including upper case in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

-- Fix for bug https://github.com/neovim/neovim/issues/12970
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
	local text_document = text_document_edit.textDocument
	local bufnr = vim.uri_to_bufnr(text_document.uri)
	if offset_encoding == nil then
		vim.notify_once("apply_text_document_edit must be called with valid offset encoding", vim.log.levels.WARN)
	end

	vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end
