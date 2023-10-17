local M = {}

M.n = {
  ["<leader>te"] = { function () require('neotest').summary.toggle() end, "Open test explorer"},
  ["<leader>tc"] = {"<CMD>lua require('neotest').run.run()<CR>", "Test current function"},
  ["<leader>tf"] = {"<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Test current file"},
  ["<leader>tp"] = {"<CMD>lua require('neotest').run.run(vim.fn.getcwd())<CR>", "Test project"},

  ["<leader>dt"] = {function () require('neotest').run.run({strategy = "dap"}) end, "Debug current test"}
}

return M
