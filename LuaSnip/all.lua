return {
  s(
    { trig = 'ssnip', desc = 'new snippet creation', snippetType = 'autosnippet' },
    fmta(
      "s({trig='<>', name='<>', snippetType='<>snippet'}, fmta('<>', {<>})),",
      { i(1, { key = 'trig' }), c(2, { rep(k 'trig'), i(2, 'good name') }), c(3, { t '', t 'auto' }), i(4), i(5) }
    )
  ),
  s(
    { trig = '([cC])ad', trigEngine = 'pattern', snippetType = 'autosnippet' },
    f(function(args, snip)
      local prefix = snip.captures[1]
      return prefix .. "'est-à-dire "
    end, {})
  ),
  s({ trig = 'ssi', snippetType = 'autosnippet' }, t 'si et seulement si '),
  s({ trig = 'tle', name = 'Terminale', snippetType = 'snippet' }, fmta('T\\up{le}', {})),
  s({ trig = 'sec', name = 'Seconde', snippetType = 'snippet' }, fmta('2\\up{nde}', {})),
  s({ trig = 'prem', name = 'Première', snippetType = 'snippet' }, fmta('1\\iere', {})),
}
