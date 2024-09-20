---@diagnostic disable: undefined-global
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local function inside_env(
  args, -- string[][]
  old_state, --
  parent, -- parent snippet or parent node
  user_args -- user_args from opts.user_args
)
  local env2command = { enumerate = 'item', itemize = 'item', questions = 'question', parts = 'part' }
  for env, command in pairs(env2command) do
    if args[1][1] == env then
      local suffix = t ' '
      if env == 'questions' or env == 'parts' then
        -- add an arg to command
        suffix = sn(1, fmta('[<>] ', { i(1, '1') }))
      end
      return sn(nil, { t('\\' .. command), suffix })
    end
  end
  -- found no special envs
  return sn(nil, t '')
end

return {
  s(
    { trig = 'beg', name = 'Insert env', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{<>}
        <><>
      \end{<>}
      ]],
      { c(1, { i(1, "nom de l'env"), t 'align*', t 'solution', t 'itemize', t 'enumerate', t 'questions' }), d(2, inside_env, { 1 }, {}), i(3), rep(1) }
    )
  ),
  s(
    { trig = 'tabvar', name = 'Tableau de variation par la dérivée', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{center}
      \begin{tikzpicture}
    \tkzTab{$<>$/0.6, Signe de $<>'$/1.2, Variations de $<>$/1.2}
    {$<>$, <>, $<>$}
    {<>}
    {<>}
      \end{tikzpicture}
      \end{center}
    ]],
      { i(1, 'x'), i(2, 'f'), rep(2), i(3, 'a'), i(5, 'fill'), i(4, 'b'), i(6), i(7) }
    )
  ),
  s(
    { trig = 'tabtab', name = 'Tableau de variation/signe', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{center}
      \begin{tikzpicture}
    \tkzTabInit{$<>$/0.6, $<>$/1.2}{$<>$, <>, $<>$}
    <>
      \end{tikzpicture}
      \end{center}
    ]],
      {
        i(1, 'x'),
        i(2, 'f'),
        i(3, 'a'),
        i(5, 'fill'),
        i(4, 'b'),
        c(6, { fmta('\\tkzTabVar{<>}', { i(1) }), fmta('\\tkzTabLine{<>}', { i(1) }) }),
      }
    )
  ),
}
