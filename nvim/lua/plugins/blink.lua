return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.snippets = opts.snippets or {}
      opts.snippets.preset = "luasnip"

      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      if not vim.tbl_contains(opts.sources.default, "snippets") then
        table.insert(opts.sources.default, "snippets")
      end
    end,
  },
}
