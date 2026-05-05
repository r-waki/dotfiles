local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function now_uid()
  return { os.date("%Y%m%d%H%M%S") }
end

local function now_date()
  return { os.date("%Y-%m-%d %H:%M:%S") }
end

return {
  s(";mkh", {
    t({
      "---",
      "uid: ",
    }),
    f(now_uid, {}),
    t({
      "",
      "aliases: []",
      "date: ",
    }),
    f(now_date, {}),
    t({
      "",
      "update: ",
    }),
    f(now_date, {}),
    t({
      "",
      "tags: []",
      "draft: false",
      "---",
      "",
      "# ",
    }),
    i(1),
    t({
      "",
      "## Link",
      "",
    }),
  }),
}
