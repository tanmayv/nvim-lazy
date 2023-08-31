return {
 {
   "rcarriga/nvim-notify",
   config = function(_, opt)
     require("notify").setup(opt)
     vim.notify = require("notify")
   end
 },
 {
   "stevearc/dressing.nvim"
 }
}
