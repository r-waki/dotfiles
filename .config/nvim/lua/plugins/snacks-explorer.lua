return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc(-1) == 0 and vim.api.nvim_buf_get_name(0) == "" then
            Snacks.explorer.open({ cwd = LazyVim.root() })
          end
        end,
      })
    end,
  },
}
