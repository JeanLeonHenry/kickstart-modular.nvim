local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
  ---@diagnostic disable: undefined-global
  -- symboles
  s({ trig = '>>', name = '≥', snippetType = 'autosnippet' }, { t '\\geq ' }, { condition = in_mathzone }),
  s({ trig = '<<', name = '≤', snippetType = 'autosnippet' }, { t '\\leq ' }, { condition = in_mathzone }),
  s({ trig = '->', name = 'to', snippetType = 'autosnippet' }, { t '\\to ' }),
  s({ trig = '=>', name = 'implies', snippetType = 'autosnippet' }, { t '\\implies ' }, { condition = in_mathzone }),
  s({ trig = 'iff', name = '⇔', snippetType = 'autosnippet' }, { t '\\iff ' }, { condition = in_mathzone }),
  s({ trig = '!>', name = 'mapsto', wordTrig = false, snippetType = 'autosnippet' }, { t '\\mapsto ' }),
  s({ trig = '!=', name = 'neq', wordTrig = false, snippetType = 'autosnippet' }, { t '\\neq ' }),
  s({ trig = 'oo', name = '∞', snippetType = 'autosnippet' }, fmta('<>\\infty', { c(1, { t '+', t '-' }) })),
  s({ trig = 'xx', name = 'times', snippetType = 'autosnippet' }, t '\\times '),
  s({ trig = 'vv', name = 'vector arrow', snippetType = 'autosnippet' }, fmta('\\vect{<>}', { i(1) })),
  s({ trig = '...', name = 'dots', snippetType = 'autosnippet' }, { t '\\dots ' }, { condition = in_mathzone }),
  s({ trig = '~~', name = 'approx', snippetType = 'autosnippet' }, { t '\\approx' }, { condition = in_mathzone }),
  -- opérateurs
  s({ trig = 'sqrt', name = 'sqrt', snippetType = 'autosnippet' }, fmta('\\sqrt{<>}', { i(1) })),
  s({ trig = 'in', name = 'in', snippetType = 'autosnippet' }, { t '\\in ' }, { condition = in_mathzone }),
  s({ trig = 'int', name = 'integral' }, fmta('\\int_{<>}^{<>}<>\\d <>', { i(1, 'a'), i(2, 'b'), i(3, 'f(t)'), i(4, 't') }), { condition = in_mathzone }),
  s(
    { trig = 'lim', name = 'limit', snippetType = 'autosnippet' },
    fmta('\\lim_{<>\\to<>}<>', { i(1, 'x'), i(2, '+\\infty'), i(3, 'f(x)') }),
    { condition = in_mathzone }
  ),
  s(
    { trig = 'ff', snippetType = 'autosnippet' },
    fmta('\\frac{<>}{<>}', {
      i(1),
      i(2),
    }),
    { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
  ),
  -- formatting
  s({ trig = 'mm', name = 'Inline math', snippetType = 'autosnippet' }, fmta('$<>$', { i(1) })),
  s({ trig = '**', name = 'superscript', wordTrig = false, snippetType = 'autosnippet' }, fmta('^{<>}', { i(1) }), { condition = in_mathzone }),
  s({ trig = '__', name = 'subscript', wordTrig = false, snippetType = 'autosnippet' }, fmta('_{<>}', { i(1) }), { condition = in_mathzone }),
  s(
    { trig = '([CRQZNPEV])%1', trigEngine = 'pattern', name = 'bold font letters', snippetType = 'autosnippet' },
    f(function(args, snip)
      -- return '\\' .. snip.captures[1]
      return '\\mathbf{' .. snip.captures[1] .. '}'
    end, {}),
    { condition = in_mathzone }
  ),
  -- sectioning
  s({ trig = 'sse', name = 'section', snippetType = 'autosnippet' }, fmta('\\section{<>}\n', { i(1) })),
  s({ trig = 'ssu', name = 'subsection', snippetType = 'autosnippet' }, fmta('\\subsection{<>}\n', { i(1) })),
  s({ trig = 'sss', name = 'subsubsection', snippetType = 'autosnippet' }, fmta('\\subsubsection{<>}\n', { i(1) })),
  s({ trig = 'spg', name = 'paragraph', snippetType = 'autosnippet' }, fmta('\\paragraph{<>}\n', { i(1) })),
  -- more complex stuff
  s(
    {
      trig = 'aa',
      name = '∀x∈ℝ, ',
      snippetType = 'autosnippet',
    },
    fmta('\\forall <><><>,\\ ', {
      c(1, { i(1, 'x'), i(2, 'n') }),
      c(2, { i(1, '\\in'), i(2, '\\geq'), i(3, '\\leq'), i(4, '>'), i(5, '<') }),
      d(3, function(args)
        if args[1][1] == '\\in' then
          return sn(nil, { c(1, { i(1, '\\R'), i(2, '\\N') }) })
        else
          return sn(nil, { t '0' })
        end
      end, { 2 }),
    }),
    { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
  ),
  s({trig = 'exovar', name = 'etude de variation'}, fmta([[Dérivons $<>$ : soit $x\in \R$, on a alors
  \begin{align*}
  <>'(x)&=<>\\
  \end{align*}
  $<>'(x)$ est <>
  D'où le tableau suivant : 
  <>
  ]], {i(1, 'f_1'), rep(1), i(2, 'calcul de la dérivée'), rep(1), i(3, 'etude du signe de la dérivée'), i(4, 'tabvar')}))
}
