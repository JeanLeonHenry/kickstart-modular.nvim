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

local arbre = s(
  { trig = 'arbre', name = 'arbre de probabilité', snippetType = 'snippet' },
  fmta(
    [[
    \begin{center}
	    \hfill~\begin{tikzpicture}[xscale=1,yscale=1,baseline={(R.base)}]
		    % Styles (MODIFIABLES)
		    \tikzstyle{fleche}=[->>,>>=latex,thick]
		    \tikzstyle{noeud}=[fill=white,circle,inner sep=2pt]
		    \tikzstyle{feuille}=[fill=white,circle,inner sep=2pt]
		    \tikzstyle{etiquette}=[pos=0.6,fill=white, inner xsep=3pt, inner ysep=1.5pt]
		    % Dimensions (MODIFIABLES)
		    \def\DistanceInterNiveaux{3}
		    \def\DistanceInterFeuilles{1}
		    % Dimensions calculées (NON MODIFIABLES)
		    \def\NiveauA{(0)*\DistanceInterNiveaux}
		    \def\NiveauB{(1)*\DistanceInterNiveaux}
		    \def\NiveauC{(2)*\DistanceInterNiveaux}
		    \def\InterFeuilles{(-1)*\DistanceInterFeuilles}
		    % Noeuds (MODIFIABLES : Styles et Coefficients d'InterFeuilles)
		    \node[noeud] (R) at ({\NiveauA},{(1.5)*\InterFeuilles}) {};
		    \node[noeud] (Ra) at ({\NiveauB},{(0.5)*\InterFeuilles})  {<>};
		    \node[feuille] (Raa) at ({\NiveauC},{(0)*\InterFeuilles}) {<>};
		    \node[feuille] (Rab) at ({\NiveauC},{(1)*\InterFeuilles}) {<>};
		    \node[noeud] (Rb) at ({\NiveauB},{(2.5)*\InterFeuilles})  {<>};
		    \node[feuille] (Rba) at ({\NiveauC},{(2)*\InterFeuilles}) {<>};
		    \node[feuille] (Rbb) at ({\NiveauC},{(3)*\InterFeuilles}) {<>};
		    % Arcs (MODIFIABLES : Styles)
		    \draw[fleche] (R.east)--(Ra.west) node[etiquette]   {<>};
		    \draw[fleche] (R.east)--(Rb.west) node[etiquette]   {<>};
		    \draw[fleche] (Ra.east)--(Raa.west) node[etiquette] {<>};
		    \draw[fleche] (Ra.east)--(Rab.west) node[etiquette] {<>};
		    \draw[fleche] (Rb.east)--(Rba.west) node[etiquette] {<>};
		    \draw[fleche] (Rb.east)--(Rbb.west) node[etiquette] {<>};
	    \end{tikzpicture} \hfill~	\end{center}
]],
    { i(1, '$A$'), i(3, '$B$'), i(4, '$\\overline{B}$'), i(2, '$\\overline{A}$'), rep(3), rep(4), i(5), i(6), i(7), i(8), i(9), i(10) }
  )
)

return {
  s(
    { trig = 'beg', name = 'Insert env', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{<>}
        <><>
      \end{<>}
      ]],
      {
        c(1, { i(1, "nom de l'env"), t 'align*', t 'solution', t 'enumerate', t 'itemize', t 'questions', t 'pmatrix' }),
        d(2, inside_env, { 1 }, {}),
        i(3),
        rep(1),
      }
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
  s(
    { trig = 'plot', name = 'pgf plot', snippetType = 'snippet' },
    fmta(
      [[
\begin{center}
\begin{tikzpicture}
\begin{axis}[
no marks,
grid=both,
axis lines=center,
]
\addplot{<>};
\end{axis}
\end{tikzpicture}
\end{center}
  ]],
      { i(1, 'f(x)') }
    )
  ),
  arbre,
}
