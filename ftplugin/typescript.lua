-- Auto compile
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.ts"},
  command = "call jobstart(['tsc'])",
})
