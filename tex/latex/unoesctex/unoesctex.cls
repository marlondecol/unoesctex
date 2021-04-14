% ------------------------------------------------------------------------------
% Copyright 2019 Marlon Luís de Col.
%
% This work may be distributed and/or modified under the conditions of the LaTeX
% Project Public License, either version 1.3 of this license or (at your option)
% any later version.
%
% The latest version of this license is in http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Marlon Luís de Col.
% ------------------------------------------------------------------------------



% ------------------------------------------------------------------------------
% INICIALIZAÇÃO DA CLASSE.
% ------------------------------------------------------------------------------

% Informações da classe.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unoesctex}[2019/09/25 Classe para trabalhos acadêmicos da Unoesc Chapecó]



% ------------------------------------------------------------------------------
% DECLARAÇÕES DE OPÇÕES.
% ------------------------------------------------------------------------------

% Define o método de processamento das abreviações e siglas.
\newcommand{\SistemaSiglas}{automatico}


% Define as fontes padrão de corpo, monoespaçada e para ambientes matemáticos.
% ------------------------------------------------------------------------------
% Times New Roman.
\newcommand{\UnoescFont}{times}
% Fira Code.
\newcommand{\UnoescMono}{fcode}
% XITS Math.
\newcommand{\UnoescMath}{xits}


% Opções de definição e processamento de abreviações e siglas.
% ------------------------------------------------------------------------------
% Utiliza o pacote `glossaries` para automatizar o processo.
\DeclareOption{siglas=automatico}{\renewcommand{\SistemaSiglas}{automatico}}
 % Deixa as declarações e manipulação inteiramente manuais.
\DeclareOption{siglas=manual}{\renewcommand{\SistemaSiglas}{manual}}


% Opções de fontes de corpo.
% ------------------------------------------------------------------------------
% Arial.
\DeclareOption{arial}{\renewcommand{\UnoescFont}{arial}}
% Times New Roman.
\DeclareOption{times}{\renewcommand{\UnoescFont}{times}}


% Opções de fontes monoespaçadas.
% ------------------------------------------------------------------------------
% Fira Code.
\DeclareOption{fcode}{\renewcommand{\UnoescMono}{fcode}}
% Ubuntu Mono.
\DeclareOption{umono}{\renewcommand{\UnoescMono}{umono}}


% Opções de fontes para ambientes matemáticos.
% ------------------------------------------------------------------------------
% Latin Modern.
\DeclareOption{latin}{\renewcommand{\UnoescMath}{latin}}
% XITS Math.
\DeclareOption{xits}{\renewcommand{\UnoescMath}{xits}}

% Repassa o restante dos parâmetros para a classe abnTeX2.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abntex2/abntex2}}

% Processa as opções.
\ProcessOptions\relax



% ------------------------------------------------------------------------------
% CLASSE BASE.
% ------------------------------------------------------------------------------

% Carrega a classe abnTeX2.
\LoadClass[%
	% O tamanho da fonte deve ser 12.
	12pt,
	% O tamanho da folha deve ser A4.
	a4paper,
	% Impressão em apenas uma face da folha.
	oneside,
	% Títulos de primeiro nível devem ser maiúsculos.
	chapter=TITLE,
	% Títulos de segundo nível também devem ser maiúsculos.
	section=TITLE,
	% Define o estilo do sumário.
	sumario=tradicional
]{abntex2}



% ------------------------------------------------------------------------------
% PACOTES ADICIONAIS.
% ------------------------------------------------------------------------------

% Carrega os pacotes necessários.
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{hyperxmp}
\RequirePackage{indentfirst}
\RequirePackage{lastpage}
\RequirePackage{pdfpages}
\RequirePackage{silence}
\RequirePackage{titlesec}
\RequirePackage{unicode-math}
\RequirePackage{xcolor}
\RequirePackage{xstring}

% Suprime aviso de utilização do pacote caption com a classe memoir.
\WarningFilter*{memoir}{For the caption package to function properly with memoir}

% Este pacote é carregado aqui para que seja possível suprimir o aviso descrito
% acima.
\RequirePackage{caption}

% Utiliza o pacote `glossaries` se o método de processamento de abreviações e
% siglas for o automático.
\ifthenelse{\equal{\SistemaSiglas}{automatico}}{%
	% Evita avisos relacionados a conflitos com outros pacotes.
	\let\printglossary\relax
	\let\theglossary\relax
	\let\endtheglossary\relax

	% Deve ser carregado antes do pacote `abntex2cite` por motivos internos.
	\RequirePackage[%
		% Habilita o processamento de acrônimos e comandos relacionados.
		acronyms,
		% Desabilita exibição das páginas de ocorrências dos acrônimos.
		nonumberlist,
		% Não coloca ponto final nas entradas da lista.
		nopostdot,
		% Permite utilizar comandos reduzidos.
		shortcuts
	]{glossaries}
}{}

% Referências e citações da ABNT.
\RequirePackage[%
	% Formata os grifos em negrito.
	abnt-emphasize=bf,
	% Substitui 3 ou mais autores por "et al".
	abnt-etal-list=3,
	% Prenomes exibidos por extenso.
	abnt-full-initials=yes,
	% Substitui títulos repetidos nas referências por linhas sublinhadas.
	abnt-repeated-title-omit=yes,
	% Nenhum pacote é usado para tratar URLs.
	abnt-url-package=none,
	% Usa o estilo de citação alfabético.
	alf
]{abntex2cite}



% ------------------------------------------------------------------------------
% COMANDOS ÚTEIS.
% ------------------------------------------------------------------------------

% Cria uma label a partir do nome de um arquivo, sem a extensão.
\newcommand{\labelfromfile}[2]{%
	% Se há alguma barra na string informada,...
	\IfSubStr{#2}{/}{%
		% ... separa-a pela última ocorrência...
		\StrCount{#2}{/}[\slashesnumber]
		\StrCut[\slashesnumber]{#2}{/}\path\file

		% ... e utiliza a substring da direita.
		\let\filepart\file
	% Caso contrário,...
	}{%
		% ... utiliza a string original informada.
		\let\filepart#2
	}

	% Retira a extensão da string resultante, caso houver.
	\StrCount{\filepart}{.}[\pointsnumber]
	\StrCut[\pointsnumber]{\filepart}{.}\filename\extension

	% Cria a label unindo o prefixo e nome do arquivo.
	\label{#1:\filename}
}



% ------------------------------------------------------------------------------
% FONTES.
% ------------------------------------------------------------------------------

% Define a fonte principal, de corpo, de acordo com os parâmetros da classe
% definidos pelo usuário.
\setmainfont{\UnoescFont}[%
	% Caminho até os arquivos da fonte.
	Path=fontes/\UnoescFont/,
	% Extensão dos arquivos.
	Extension=.ttf,
	% Procura pelo nome do arquivo mais o sufixo "b" para negrito.
	BoldFont=*b,
	% Procura pelo nome do arquivo mais o sufixo "i" para itálico.
	ItalicFont=*i,
	% Procura pelo nome do arquivo mais o sufixo "z" para negrito e itálico.
	BoldItalicFont=*z,
	% Habilita ligatures.
	Ligatures=TeX
]

% Define a fonte monoespaçada, de acordo com os parâmetros da classe definidos
% pelo usuário.
\setmonofont{\UnoescMono}[%
	% Caminho até os arquivos da fonte.
	Path=fontes/\UnoescMono/,
	% Extensão dos arquivos.
	Extension=.ttf,
	% Procura pelo nome do arquivo mais o sufixo "b" para negrito.
	BoldFont=*b,
	% Tamanho reduzido para melhor apresentação.
	Scale=0.8,
	% Habilita ligatures.
	Ligatures=TeX
]

% Define a fonte para ambientes matemáticos, de acordo com os parâmetros da
% classe definidos pelo usuário.
% Caso a fonte definida seja a `latin`, nenhuma configuração adicional é
% realizada.
\ifthenelse{\equal{\UnoescMath}{latin}}{}{%
	\setmathfont{\UnoescMath-math}[%
		% Caminho até os arquivos da fonte.
		Path=fontes/\UnoescMath/,
		% Extensão dos arquivos.
		Extension=.otf,
		% Procura pelo nome do arquivo mais o sufixo "b" para negrito.
		BoldFont=*b,
		% Habilita ligatures.
		Ligatures=TeX
	]
}



% ------------------------------------------------------------------------------
% DEFINIÇÕES DE CORES.
% ------------------------------------------------------------------------------

% Cores da Unoesc, extraídas da imagem unoesc.png, disponível no site da
% universidade.
\definecolor{unoesc-blue}{RGB}{15, 109, 182}
\definecolor{unoesc-green}{RGB}{111, 194, 121}



% ------------------------------------------------------------------------------
% SÍMBOLOS MATEMÁTICOS.
% ------------------------------------------------------------------------------

% Operadores trigonométricos em português.
\DeclareMathOperator{\sen}{sen}
\DeclareMathOperator{\tg}{tg}
\DeclareMathOperator{\cotg}{cotg}
\DeclareMathOperator{\cosec}{cosec}
\DeclareMathOperator{\arcsen}{arcsen}
\DeclareMathOperator{\arctg}{arctg}
\DeclareMathOperator{\senh}{senh}
\DeclareMathOperator{\tgh}{tgh}



% ------------------------------------------------------------------------------
% CONFIGURAÇÕES GERAIS.
% ------------------------------------------------------------------------------

% Permite adicionar subtítulo.
\providecommand{\imprimirsubtitulo}{}
\newcommand{\subtitulo}[1]{\renewcommand{\imprimirsubtitulo}{#1}}

% Configura o estilo de paginação em páginas de arquivos PDF inclusos.
\includepdfset{pagecommand=\thispagestyle{abntheadings}}

% Retira espaços extras entre as frases.
\frenchspacing

% O espaçamento entre-linhas deve ser de um e meio.
\linespread{1.3}

% Aproxima os pontos das linhas pontilhadas nos sumários e listas.
\renewcommand{\cftdotsep}{0.5}

% Define os espaços antes e depois de ambientes matemáticos.
\setlength{\belowdisplayskip}{0.5em}
\setlength{\belowdisplayshortskip}{0.5em}
\setlength{\abovedisplayskip}{0.5em}
\setlength{\abovedisplayshortskip}{0.5em}

% Ajusta o espaçamento após os títulos dos resumos e abstracts.
\setlength{\abstitleskip}{\baselineskip}

% Espaçamento antes e depois dos capítulos.
\setlength{\beforechapskip}{0em}
\setlength{\afterchapskip}{\baselineskip}

% Espaço entre as linhas em ambiente matemático.
\setlength{\jot}{0.75em}

% Recuo de parágrafo (tabulação).
\setlength{\parindent}{1.25cm}

% Espaço após os parágrafos.
\setlength{\parskip}{0em}

% Espaço entre as linhas de uma moldura e seu conteúdo.
\setlength{\fboxsep}{0em}

% Configurações dos links.
\hypersetup{%
	% Profundidade máxima ao listar os bookmarks do arquivo PDF.
	bookmarksdepth=5,
	% Remove as bordas ao redor de links.
	colorlinks=true,
	% Citações na mesma cor do texto.
	citecolor=.,
	% Links na mesma cor do texto.
	linkcolor=.,
	% URLs na mesma cor do texto.
	urlcolor=.
}



% ------------------------------------------------------------------------------
% CONFIGURAÇÕES DO BABEL.
% ------------------------------------------------------------------------------

% Comando para o título da lista de abreviações e siglas.
\providecommand{\acronymname}{}

% Ajusta títulos em português.
\addto\captionsbrazil{%
	\providecommand{\quadroname}{Quadro}
	\renewcommand{\acronymname}{Lista de abrevia\c{c}\~{o}es e siglas}
	\renewcommand{\figurename}{Ilustra\c{c}\~{a}o}
}

% Ajusta títulos em inglês.
\addto\captionsenglish{%
	\providecommand{\quadroname}{Frame}
	\renewcommand{\acronymname}{Acronyms}
	\renewcommand{\figurename}{Ilustration}
}

% Ajusta rótulos em português.
\addto\extrasbrazil{%
	\providecommand{\quadroautorefname}{Quadro}
	\renewcommand{\figureautorefname}{Ilustra\c{c}\~{a}o}
	\renewcommand{\tableautorefname}{Tabela}
}

% Ajusta rótulos em inglês.
\addto\extrasenglish{%
	\providecommand{\quadroautorefname}{Frame}
	\renewcommand{\figureautorefname}{Ilustration}
	\renewcommand{\tableautorefname}{Table}
}



% ------------------------------------------------------------------------------
% CITAÇÕES.
% ------------------------------------------------------------------------------

% Opção para citar autor já citado na frase imediatamente anterior.
% Exibe, entre parênteses, apenas o ano e um comentário opcional.
\newcommand{\citeagain}[2][]{(\citeyear{#2}\ifthenelse{\equal{#1}{}}{}{, #1})}

% Reconfigura o ambiente de citação direta longa.
\renewenvironment*{citacao}[1][default]{%
	% Pula uma linha antes do bloco.
	\vspace*{1em}

	% Inicia um bloco com espaçamento entre-linhas simples.
	\begin{SingleSpace}
		% Diminui o tamanho da fonte para 10.
		\footnotesize

		% Ajusta a margem à esquerda para 4 cm.
		\setlength{\leftskip}{\ABNTEXcitacaorecuo}

		% Configura a fonte para itálico caso seja em outro idioma.
		\ifthenelse{\not\equal{#1}{default}}{\itshape\selectlanguage{#1}}{}

		% Remove o recuo do parágrafo.
		\noindent
}{%
	% Finaliza o bloco de espaçamento entre-linhas simples.
	\end{SingleSpace}

	% Pula uma linha após o bloco.
	\vspace*{1em}
}



% ------------------------------------------------------------------------------
% ILUSTRAÇÕES, QUADROS E TABELAS.
% ------------------------------------------------------------------------------

% Define a quantidade de espaço ao redor de figuras, quadros e tabelas.
\setlength{\floatsep}{1.3\baselineskip}
\setlength{\intextsep}{1.3\baselineskip}
\setlength{\textfloatsep}{1.3\baselineskip}

% Declara um separador para os rótulo e as legendas.
\DeclareCaptionLabelSeparator{dash}{\space--\space}

\AtBeginDocument{%
	% Configura a exibição das legendas em figuras, quadros e tabelas.
	\captionsetup{%
		% Espaçamento acima da legenda.
		aboveskip=0pt,
		% Espaçamento abaixo da legenda.
		belowskip=3pt,
		% Altera o distância entre as linhas.
		font=singlespacing,
		% Formato sem indentação.
		format=plain,
		% Altera para hífen o separador entre o rótulo e a legenda.
		labelsep=dash,
		% Indica que esta legenda será a de cima.
		position=top,
		% Não centraliza a legenda se tiver apenas uma linha.
		singlelinecheck=false,
		% Distância entre a legenda e o elemento em questão.
		skip=6pt
	}
}

% Declara uma fonte para usar nas legendas.
\DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}

\makeatletter

% Configura a exibição da legenda da fonte em figuras, quadros e tabelas.
\renewcommand{\fonte}[1]{%
	% Altera as configurações da legenda da fonte.
	\captionsetup{%
		% Espaçamento acima da legenda.
		aboveskip=0pt,
		% Espaçamento abaixo da legenda.
		belowskip=-9pt,
		% Formato sem indentação.
		format=plain,
		% Configurações da fonte.
		font={%
			% Diminui o tamanho da fonte da legenda da fonte.
			ABNTEXfontereduzida,
			% Altera o distância entre as linhas.
			singlespacing
		},
		% Altera para dois pontos o separador entre o rótulo e a legenda.
		labelsep=colon,
		% Indica que esta legenda será a de baixo.
		position=bottom,
		% Não centraliza a legenda se tiver apenas uma linha.
		singlelinecheck=false,
		% Distância entre a legenda e o elemento em questão.
		skip=6pt,
		% Adiciona um ponto final ao texto da legenda.
		textformat=period
	}

	% Exibe a legenda da fonte.
	\@makecaption{\fontename}{\ignorespaces#1}
}

% Configura o posicionamento padrão dos floats para as ilustrações e tabelas.
\def\fps@figure{htbp!}
\def\fps@table{htbp!}

% Centraliza os floats em páginas dedicadas.
\setlength{\@fptop}{0pt plus 1fil}
\setlength{\@fpbot}{16pt plus 1fil}

\makeatother

% Configura o limiar que define se um float estará em uma página dedicada ou
% não.
\renewcommand{\floatpagefraction}{.8}



% ------------------------------------------------------------------------------
% ITENS, LISTAS E LISTAS ENUMERADAS.
% ------------------------------------------------------------------------------


% Configuração de ambientes de lista enumerada.
% ------------------------------------------------------------------------------
% Nível 1.
\setlist[enumerate, 1]{itemsep=0cm, label=\alph*), labelsep=0.5cm, leftmargin=1.25cm, parsep=0cm, partopsep=6pt, topsep=1em}
% Nível 2.
\setlist[enumerate, 2]{itemsep=0cm, label=\roman*., labelsep=0.5cm, leftmargin=0.75cm, parsep=0cm, partopsep=6pt, topsep=1em}


% Configuração de ambientes de itens.
% ------------------------------------------------------------------------------
% Nível 1.
\setlist[itemize, 1]{itemsep=0cm, labelsep=0.5cm, leftmargin=1.25cm, parsep=0cm, partopsep=6pt, topsep=1em}
% Nível 2.
\setlist[itemize, 2]{itemsep=0cm, labelsep=0.5cm, leftmargin=0.75cm, parsep=0cm, partopsep=6pt, topsep=1em}


% Criação do ambiente de abreviações e siglas.
\newlist{acronymize}{itemize}{1}

% Cria um novo comando para adição de um item na lista de abreviações e siglas.
\newcommand{\acronym}[1]{\item[#1]--}

% Configuração do ambiente de abreviações e siglas.
\setlist[acronymize, 1]{align=parleft, itemsep=0cm, labelsep=0cm, labelwidth=3cm, leftmargin=!, parsep=0cm, topsep=0cm}



% ------------------------------------------------------------------------------
% PAGINAÇÃO.
% ------------------------------------------------------------------------------

% Estilo de cabeçalhos herdado da classe abnTeX2.
\makepagestyle{abntheadings}

% Os números de paginação devem estar no canto superior direito de todas as
% páginas.
\makeevenhead{abntheadings}{}{}{\ABNTEXfontereduzida\thepage}
\makeoddhead{abntheadings}{}{}{\ABNTEXfontereduzida\thepage}



% ------------------------------------------------------------------------------
% FONTES DOS TÍTULOS.
% ------------------------------------------------------------------------------

% Títulos de primeiro e terceiro níveis são em negrito.
\renewcommand{\ABNTEXpartfont}{\bfseries}
\renewcommand{\ABNTEXchapterfont}{\bfseries}
\renewcommand{\ABNTEXsubsectionfont}{\bfseries}

% Títulos de segundo e quarto níveis são em fonte regular.
\renewcommand{\ABNTEXsectionfont}{\mdseries}
\renewcommand{\ABNTEXsubsubsectionfont}{\mdseries}

% Títulos de quinto nível são em itálico.
\renewcommand{\ABNTEXsubsubsubsectionfont}{\itshape}

% Define a fonte dos títulos do último nível.
\providecommand{\ABNTEXparagraphfont}{}
\renewcommand{\ABNTEXparagraphfont}{\itshape}

% O tamanho de todos os títulos deve ser 12pt.
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}

% Define o tamanho da fonte dos títulos do último nível.
\providecommand{\ABNTEXparagraphfontsize}{}
\renewcommand{\ABNTEXparagraphfontsize}{\normalsize}



% ------------------------------------------------------------------------------
% CONFIGURAÇÕES DOS TÍTULOS.
% ------------------------------------------------------------------------------

% Cria novas classes de títulos para apêndices e anexos.
\titleclass{\apendicechapter}[0]{top}
\titleclass{\anexochapter}[0]{top}

% Cria contadores de numeração dos títulos de apêndices e anexos.
\newcounter{apendicechapter}
\newcounter{anexochapter}

% Altera os contadores de numeração dos títulos de apêndices e anexos para
% alfabético.
\renewcommand{\theapendicechapter}{\Alph{apendicechapter}}
\renewcommand{\theanexochapter}{\Alph{anexochapter}}

% Instancia novos rótulos para cross-reference de apêndices e anexos.
\providecommand{\apendicechapterautorefname}{Ap\^endice}
\providecommand{\anexochapterautorefname}{Anexo}

% Configura as fontes dos títulos e os espaços entre os números e textos.
\titleformat{\chapter}{\ABNTEXchapterfont}{\thechapter\space}{0ex}{\MakeUppercase}
\titleformat{\section}{\ABNTEXsectionfont}{\thesection\space}{0ex}{\MakeUppercase}
\titleformat{\subsection}{\ABNTEXsubsectionfont}{\thesubsection\space}{0ex}{}
\titleformat{\subsubsection}{\ABNTEXsubsubsectionfont}{\thesubsubsection\space}{0ex}{}
\titleformat{\subsubsubsection}{\ABNTEXsubsubsubsectionfont}{\thesubsubsubsection\space}{0ex}{}
\titleformat{\paragraph}{\ABNTEXparagraphfont}{\theparagraph\space}{0ex}{}

% Mesma configuração acima para títulos sem numeração.
\titleformat{name=\part, numberless}{\centering\ABNTEXpartfont}{}{0ex}{\MakeUppercase}
\titleformat{name=\chapter, numberless}{\centering\ABNTEXchapterfont}{}{0ex}{\MakeUppercase}
\titleformat{name=\apendicechapter, numberless}{\ABNTEXchapterfont}{AP\^ENDICE\space\theapendicechapter\space--\space}{0ex}{\MakeUppercase}
\titleformat{name=\anexochapter, numberless}{\ABNTEXchapterfont}{ANEXO\space\theanexochapter\space--\space}{0ex}{\MakeUppercase}

% Ajusta os espaços antes e depois dos títulos.
\titlespacing*{\part}{0ex}{-\baselineskip}{\baselineskip}
\titlespacing*{\chapter}{0ex}{-\baselineskip}{\baselineskip}
\titlespacing*{\section}{0ex}{\baselineskip}{\baselineskip}
\titlespacing*{\subsection}{0ex}{\baselineskip}{\baselineskip}
\titlespacing*{\subsubsection}{0ex}{\baselineskip}{\baselineskip}
\titlespacing*{\subsubsubsection}{0ex}{\baselineskip}{\baselineskip}
\titlespacing*{\paragraph}{0ex}{\baselineskip}{\baselineskip}

% Mesma configuração acima para títulos sem numeração.
\titlespacing*{name=\part, numberless}{0ex}{-\baselineskip}{\baselineskip}
\titlespacing*{name=\chapter, numberless}{0ex}{-\baselineskip}{\baselineskip}
\titlespacing*{name=\apendicechapter, numberless}{0ex}{-\baselineskip}{\baselineskip}
\titlespacing*{name=\anexochapter, numberless}{0ex}{-\baselineskip}{\baselineskip}



% ------------------------------------------------------------------------------
% FONTES DO SUMÁRIO.
% ------------------------------------------------------------------------------

\makeatletter

% Converte a fonte dos chapters e sections que ficam no sumário em maiúsculo.
\patchcmd{\l@chapter}{#1}{\uppercase{#1}}{}{}
\patchcmd{\l@section}{#1}{\uppercase{#1}}{}{}

\makeatother

% Chapter.
\renewcommand{\cftchapterfont}{\normalsize\bfseries}
\renewcommand{\cftchapterpagefont}{\cftchapterfont}

% Section.
\renewcommand{\cftsectionfont}{\normalsize}
\renewcommand{\cftsectionpagefont}{\cftsectionfont}

% Subsection.
\renewcommand{\cftsubsectionfont}{\normalsize\bfseries}
\renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

% Subsubsection.
\renewcommand{\cftsubsubsectionfont}{\normalsize}
\renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

% Subsubsubsection.
\renewcommand{\cftparagraphfont}{\normalsize\itshape}
\renewcommand{\cftparagraphpagefont}{\cftparagraphfont}



% ------------------------------------------------------------------------------
% CONFIGURAÇÕES DO SUMÁRIO.
% ------------------------------------------------------------------------------

% Remove os recuos dos títulos no sumário.
\setlength{\cftchapterindent}{0ex}
\setlength{\cftsectionindent}{0ex}
\setlength{\cftsubsectionindent}{0ex}
\setlength{\cftsubsubsectionindent}{0ex}
\setlength{\cftparagraphindent}{0ex}

% Anula o tamanho do numerador dos títulos do sumário.
\setlength{\cftchapternumwidth}{0ex}
\setlength{\cftsectionnumwidth}{0ex}
\setlength{\cftsubsectionnumwidth}{0ex}
\setlength{\cftsubsubsectionnumwidth}{0ex}
\setlength{\cftparagraphnumwidth}{0ex}

\makeatletter

% Faz com que os pontos cheguem até o número da página no sumário.
\renewcommand{\@pnumwidth}{0ex{}}

% Anula a margem interna direita do sumário para justificar títulos com quebra
% de linha.
\renewcommand{\@tocrmarg}{0ex}

% Ajusta os espaços entre os números e os títulos.
\renewcommand{\chapternumberline}[1]{\@cftbsnum#1\@cftasnum\space}
\renewcommand{\numberline}[1]{\@cftbsnum#1\@cftasnum\space}

\makeatother



% ------------------------------------------------------------------------------
% CAPA.
% ------------------------------------------------------------------------------

% Refatoração do comando de impressão da capa.
\renewcommand{\imprimircapa}{%
	\begin{capa}
		% Centraliza todo o conteúdo.
		\centering

		% O espaçamento entre-linhas deve ser simples.
		\SingleSpace

		% Imprime o nome da instituição.
		\textbf{\MakeUppercase\imprimirinstituicao}

		\vspace*{10\baselineskip}

		% Imprime o nome do autor.
		\textbf{\MakeUppercase\imprimirautor}

		\vspace*{11\baselineskip}

		\textbf{%
			% Imprime o título do trabalho.
			\MakeUppercase\imprimirtitulo
			% Imprime o subtítulo, se houver.
			\ifthenelse{\equal{\imprimirsubtitulo}{}}{}{%
				: \imprimirsubtitulo
			}
		}

		\vspace*{\fill}

		% Imprime local e data.
		\textbf{\MakeUppercase\imprimirlocal}\par
		\textbf{\imprimirdata}
	\end{capa}
}



% ------------------------------------------------------------------------------
% FOLHA DE ROSTO.
% ------------------------------------------------------------------------------

% Refatoração do comando de impressão da folha de rosto.
\renewcommand{\imprimirfolhaderosto}{%
	\begin{folhaderosto}
		% Centraliza todo o conteúdo.
		\centering

		% O espaçamento entre-linhas deve ser simples.
		\SingleSpace

		% Imprime o nome do autor.
		\MakeUppercase\imprimirautor

		\vspace*{15\baselineskip}

		% Imprime o título do trabalho.
		\MakeUppercase\imprimirtitulo
		% Imprime o subtítulo, se houver.
		\ifthenelse{\equal{\imprimirsubtitulo}{}}{}{%
			: \imprimirsubtitulo
		}

		\vspace*{5\baselineskip}

		% Imprime o preâmbulo, caso ele foi definido.
		\ifthenelse{\equal{\imprimirpreambulo}{}}{}{%
			\hfill\begin{minipage}{10cm}
				\imprimirpreambulo
			\end{minipage}
		}

		\vspace*{2\baselineskip}

		% Imprime o nome do orientador.
		\begin{flushleft}
			\imprimirorientadorRotulo\space\imprimirorientador\par
		\end{flushleft}

		\vspace*{\fill}

		% Imprime local e data.
		\imprimirlocal\par
		\imprimirdata
	\end{folhaderosto}
}



% ------------------------------------------------------------------------------
% LISTA DE ILUSTRAÇÕES.
% ------------------------------------------------------------------------------

% Configura alguns parâmetros da lista de ilustrações.
\setlength{\cftfigureindent}{0ex}
\setlength{\cftfigurenumwidth}{0ex}

% Corrige a separação entre o prefixo e o título.
\renewcommand{\cftfigurename}{}
\renewcommand{\cftfigurepresnum}{\figurename\space}
\renewcommand{\cftfigureaftersnum}{\space--}

% Refatoração do comando de impressão da lista de ilustrações.
\newcommand{\imprimirfiguras}{%
	% Adiciona a lista de ilustrações aos bookmarks.
	\pdfbookmark[0]{\listfigurename}{lof}

	% Imprime a lista de ilustrações.
	\listoffigures*

	% Ajusta o espaçamento após o título da lista.
	\addtocontents{lof}{\vspace*{\baselineskip}}

	% Finaliza a página.
	\cleardoublepage
}



% ------------------------------------------------------------------------------
% LISTA DE QUADROS.
% ------------------------------------------------------------------------------

% Cria e configura uma nova entrada para a lista de quadros.
\newlistentry{quadro}{loq}{0}
\counterwithout{quadro}{chapter}

% Cria um novo ambiente para a adição de quadros.
\newfloat[chapter]{quadro}{loq}{\quadroname}

\makeatletter

% Configura o posicionamento padrão dos floats para os quadros.
\def\fps@quadro{htbp!}

\makeatother

% Cria uma nova lista para a lista de quadros.
\newcommand{\listofquadrosname}{Lista de quadros}
\newlistof{listofquadros}{loq}{\listofquadrosname}

% Configura alguns parâmetros da lista de ilustrações.
\setlength{\cftquadroindent}{0ex}
\setlength{\cftquadronumwidth}{0ex}

% Configura os rótulos da lista de quadros.
\renewcommand{\cftquadropresnum}{\quadroname\space}
\renewcommand{\cftquadroaftersnum}{\space--}

% Refatoração do comando de impressão da lista de quadros.
\newcommand{\imprimirquadros}{%
	% Adiciona a lista de quadros aos bookmarks.
	\pdfbookmark[0]{\listofquadrosname}{loq}

	% Imprime a lista de quadros.
	\listofquadros*

	% Ajusta o espaçamento após o título da lista.
	\addtocontents{loq}{\vspace*{\baselineskip}}

	% Finaliza a página.
	\cleardoublepage
}



% ------------------------------------------------------------------------------
% LISTA DE TABELAS.
% ------------------------------------------------------------------------------

% Configura alguns parâmetros da lista de tabelas.
\setlength{\cfttableindent}{0ex}
\setlength{\cfttablenumwidth}{0ex}

% Corrige a separação entre o prefixo e o título.
\renewcommand{\cfttablename}{}
\renewcommand{\cfttablepresnum}{\tablename\space}
\renewcommand{\cfttableaftersnum}{\space--}

% Refatoração do comando de impressão da lista de tabelas.
\newcommand{\imprimirtabelas}{%
	% Adiciona a lista de tabelas aos bookmarks.
	\pdfbookmark[0]{\listtablename}{lot}

	% Imprime a lista de tabelas.
	\listoftables*

	% Ajusta o espaçamento após o título da lista.
	\addtocontents{lot}{\vspace*{\baselineskip}}

	% Finaliza a página.
	\cleardoublepage
}



% ------------------------------------------------------------------------------
% LISTA DE ABREVIAÇÕES E SIGLAS.
% ------------------------------------------------------------------------------

% Comandos e configurações para o processamento automático de abreviações e
% siglas.
\ifthenelse{\equal{\SistemaSiglas}{automatico}}{%
	% Inclui o arquivo com as definições de acrônimos. Deve ser utilizada no
	% preâmbulo.
	\newcommand{\inserirsiglas}[1]{%
		\makeglossaries
		\loadglsentries{#1}
	}

	% Define um novo estilo para a lista de acrônimos.
	\newglossarystyle{unoescsiglas}{%
		% Adiciona o título da lista aos bookmarks e ajusta seu espaçamento.
		\renewcommand*{\glossarysection}[2][]{%
			% Imprime o título da lista.
			\pretextualchapter{##2}

			% Ajusta o espaçamento após o título da lista.
			\vspace*{\baselineskip}
		}

		% Utiliza o mesmo ambiente de acrônimos do modo manual.
		\renewenvironment{theglossary}{\begin{acronymize}}{\end{acronymize}}

		% Redefine alguns atributos.
		\renewcommand*{\glossaryheader}{}%
		\renewcommand*{\glsgroupheading}[1]{}%
		\renewcommand*{\glsgroupskip}{}%

		% Configura cada entrada como um item do ambiente de acrônimos.
		\renewcommand*{\glossentry}[1]{\acronym{\glstarget{##1}{\glossentryname{##1}}} \glossentrydesc{##1}}
	}

	% Comando de atalho para impressão da lista de abreviações e siglas.
	\newcommand{\imprimirsiglas}{%
		% Imprime a lista de abreviações e siglas.
		\printacronyms[style=unoescsiglas]

		% Finaliza a página.
		\cleardoublepage
	}
}{}

% Comandos e configurações para o processamento manual de abreviações e siglas.
\ifthenelse{\equal{\SistemaSiglas}{manual}}{%
	% Comando para salvar o caminho do arquivo das abreviações e siglas.
	\providecommand{\arquivosiglas}{}

	% Inclui o arquivo com as definições de acrônimos. Deve ser utilizada no
	% preâmbulo.
	\newcommand{\inserirsiglas}[1]{%
		\renewcommand{\arquivosiglas}{#1}
	}

	% Refatoração do ambiente da lista de abreviações e siglas.
	\renewenvironment{siglas}{%
		% Imprime o título da lista.
		\pretextualchapter{\acronymname}

		% Ajusta o espaçamento após o título da lista.
		\vspace*{\baselineskip}

		% Inicia a lista de abreviações e siglas.
		\begin{acronymize}
	}{%
		% Finaliza a lista de abreviações e siglas.
		\end{acronymize}

		% Finaliza a página.
		\cleardoublepage
	}

	% Comando de atalho para impressão da lista de abreviações e siglas.
	\newcommand{\imprimirsiglas}{%
		\begin{siglas}%
			\input{\arquivosiglas}\unskip
		\end{siglas}
	}
}{}



% ------------------------------------------------------------------------------
% SUMÁRIO.
% ------------------------------------------------------------------------------

\makeatletter

% Configura o título do sumário.
\renewcommand{\tableofcontents}{%
	% Centraliza.
	\begin{center}%
		% Altera o estilo da fonte.
		\ABNTEXchapterfont%

		% Imprime o título em maiúsculo.
		\MakeUppercase\contentsname
	\end{center}

	% Faz um espaçamento após o título.
	\vspace{0.5em}

	% Inicia o restante do sumario.
	\@starttoc{toc}
}

\makeatother

% Comando de atalho para impressão do sumário.
\newcommand{\imprimirsumario}{%
	% Adiciona o sumário aos bookmarks.
	\pdfbookmark[0]{\contentsname}{toc}

	% Imprime o sumário.
	\tableofcontents

	% Ajusta o espaçamento após o título do sumário.
	\addtocontents{toc}{\vspace*{\baselineskip}}

	% Finaliza a página.
	\cleardoublepage
}



% ------------------------------------------------------------------------------
% REFERÊNCIAS.
% ------------------------------------------------------------------------------

\renewcommand{\bibsection}{%
	% Alinha o título a esquerda.
	\let\OldABNTEXchapterfont\ABNTEXchapterfont
	\renewcommand{\ABNTEXchapterfont}{\OldABNTEXchapterfont\raggedright}

	% Imprime o título das referências.
	\chapter*{\bibname}

	% Pula uma linha após o título.
	\vspace*{\baselineskip}

	\bibmark

	% Adiciona as referências no sumário.
	\ifnobibintoc\else
		\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
	\fi

	\prebibhook
}



% ------------------------------------------------------------------------------
% APÊNDICES E/OU ANEXOS.
% ------------------------------------------------------------------------------

\newcommand{\imprimircentralizado}[1]{%
	% Vai para uma nova página.
	\newpage

	% Ajusta a númeração da página para o bookmark.
	\phantomsection

	% Adiciona o título ao sumário.
	\addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{#1}}{#1}}

	% Centraliza na página.
	\begin{center}%
		\vspace*{\fill}

		% Altera o estilo da fonte.
		\ABNTEXchapterfont%

		% Imprime o título em maiúsculo.
		\uppercase{#1}

		\vspace*{\fill}
	\end{center}

	% Finaliza a página.
	\cleardoublepage
}

% Comandos para impressão do capítulo de apêndices e/ou anexos.
\newcommand{\imprimirtituloanexos}{\imprimircentralizado{Anexos}}
\newcommand{\imprimirtituloapendices}{\imprimircentralizado{Apêndices}}
\newcommand{\imprimirtituloapendicesanexos}{\imprimircentralizado{Apêndices e anexos}}



% ------------------------------------------------------------------------------
% APÊNDICES.
% ------------------------------------------------------------------------------

% Insere um apêndice a partir de um arquivo LaTeX.
\newcommand{\imprimirapendice}[2]{%
	% Vai para uma nova página.
	\newpage

	% Ajusta a númeração da página para o bookmark.
	\phantomsection

	% Incrementa o contador da numeração do título.
	\refstepcounter{apendicechapter}\labelfromfile{apx}{#2}

	% Imprime o título do apêndice.
	\apendicechapter*{#1}

	% Insere o conteúdo.
	\input{#2}\unskip

	% Finaliza a página.
	\cleardoublepage
}

% Insere um apêndice a partir de um arquivo PDF.
\newcommand{\imprimirapendicepdf}[2]{%
	% Vai para uma nova página.
	\newpage

	% Ajusta a númeração da página para o bookmark.
	\phantomsection

	% Incrementa o contador da numeração do título.
	\refstepcounter{apendicechapter}\labelfromfile{apx}{#2}

	% Insere a primeira página do arquivo.
	\includepdf[%
		% Imprime o título do apêndice, mantendo o estilo de paginação.
		pagecommand=\apendicechapter*{#1}\thispagestyle{abntheadings},
		pages=1
	]{#2}

	% Insere as demais páginas, se houver.
	\includepdf[pages=2-]{#2}

	% Finaliza a página.
	\cleardoublepage
}



% ------------------------------------------------------------------------------
% ANEXOS.
% ------------------------------------------------------------------------------

% Insere um anexo a partir de um arquivo LaTeX.
\newcommand{\imprimiranexo}[3]{%
	% Vai para uma nova página.
	\newpage

	% Ajusta a númeração da página para o bookmark.
	\phantomsection

	% Incrementa o contador da numeração do título.
	\refstepcounter{apendicechapter}\labelfromfile{anx}{#2}

	% Imprime o título do anexo.
	\anexochapter*{#1}

	% Insere o conteúdo.
	\input{#2}\unskip

	% Insere a fonte do documento.
	\fonte{#3}

	% Finaliza a página.
	\cleardoublepage
}

% Insere um anexo a partir de um arquivo PDF.
\newcommand{\imprimiranexopdf}[3]{%
	% Vai para uma nova página.
	\newpage

	% Ajusta a númeração da página para o bookmark.
	\phantomsection

	% Incrementa o contador da numeração do título.
	\refstepcounter{apendicechapter}\labelfromfile{anx}{#2}

	% Insere a primeira página do arquivo.
	\includepdf[%
		% Imprime o título do anexo, mantendo o estilo de paginação.
		pagecommand=\anexochapter*{#1}\thispagestyle{abntheadings},
		pages=1
	]{#2}

	% Insere as demais páginas, se houver.
	\includepdf[pages=2-]{#2}

	% Insere a fonte do documento.
	\fonte{#3}

	% Finaliza a página.
	\cleardoublepage
}
