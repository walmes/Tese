# Modelo de Tese UFLA 2013/1

*Walmes Zeviani* (`walmes@ufpr.br`) - 01/11/2013

Este arquivo é a descrição de como foram organizados os arquivos e os
diretórios além de guias gerais para aproveitar a estrutura e conteúdo
dos arquivos fornecidos para fazer Dissertação e Tese nos formatos
vigentes da UFLA em 2013/1.

## Partição do código fonte

Uma das vantagens da edição de documentos em LaTex é fazer a partição
do código fonte. Com iss é possível editar partes de um grande
documento, como uma Tese, mantendo as partes separadas em arquivos.

Para ter um maior controle do projeto os arquivos foram serapados em
diretórios específicos. Cada capítulo tem um diretório, bem como as
figuras, tabelas e scripts R. Abaixo está a árvore de organização do
diretório.

```latex
.
├── cap1
│   ├── cap1abstract.tex
│   ├── cap1introduc.aux
│   ├── cap1introduc.bbl
│   ├── cap1introduc.blg
│   ├── cap1introduc-corrigido.bbl
│   ├── cap1introduc.log
│   ├── cap1introduc.pdf
│   ├── cap1introduc.tex
│   ├── cap1resumo.tex
│   └── cap1.tex
├── cap2
│   ├── cap2abstract.tex
│   ├── cap2nlme.aux
│   ├── cap2nlme.bbl
│   ├── cap2nlme.blg
│   ├── cap2nlme-corrigido.bbl
│   ├── cap2nlme.log
│   ├── cap2nlme.pdf
│   ├── cap2nlme.tex
│   ├── cap2resumo.tex
│   └── cap2.tex
├── cap3
│   ├── cap3abstract.tex
│   ├── cap3nls.aux
│   ├── cap3nls.bbl
│   ├── cap3nls.blg
│   ├── cap3nls-corrigido.bbl
│   ├── cap3nls.log
│   ├── cap3nls.pdf
│   ├── cap3nls.tex
│   ├── cap3nls.tex.backup
│   ├── cap3resumo.tex
│   └── cap3.tex
├── figuras
│   ├── cra_perfil.pdf
│   ├── param_ic.pdf
│   ├── previsu.pdf
│   ├── ufla.eps
│   └── UFLAlogo.pdf
├── scripts
│   ├── anexoCRA.R
│   └── anexoDESF.R
├── tabelas
│   ├── anexotabDESF.txt
│   ├── anexotabEL.txt
│   ├── anexotabL.txt
│   ├── tab_paramet_2.tex
│   ├── tab_paramet_3.tex
│   ├── tab_paramet_4.tex
│   ├── ZevianiTeseCRA.txt
│   └── ZevianiTeseDESF.txt
├── tese
│   ├── bibtese2.bib
│   ├── capaspretexto.tex
│   ├── preambulosimples.tex
│   ├── preambulo.tex
│   ├── resumos.tex
│   ├── WalmesTese.aux
│   ├── WalmesTese.log
│   ├── WalmesTese.out
│   ├── WalmesTese.pdf
│   ├── WalmesTese.tex
│   └── WalmesTese.toc
└── tree.txt

```

Uma vez que tem-se o código fonte dividido e os elementos que o
compõem estão distribuídos em vários diretórios, deve se dar atenção
nas chamadas dos arquivos nos `\input{}`, `\includegraphics{}` e
`\bibliography{}` que são feitos. No Linux isso é facilmente feito por meio da
notação de diretórios relativos `./`. e `../`. 

## Descrição de cada arquivo

#### Diretórios

* `cap?`: para os arquivos de cada capítulo;
* `figuras`: para as figuras inseridas no texto;
* `scripts`: para os scripts R fornecidos como anexo.
* `tabelas`: para as tabelas inseridas no texto;
* `tese`: para preambulo, arquivos de referências e arquivo mestre;

#### Nomes dos arquivos

* `cap?.tex`: prefixo `cap` seguido de número, que indica o capítulo, é o
    arquivo com o corpo do capítulo. Com sufixos indica-se que
    elementos textuais se referem.
    * `cap?.resumo.tex`: resumo do capitulo;
    * `cap?abstract.tex`: abstract do capítulo;
* `WalmesTese.tex`: arquivo mestre que gera o pdf da Tese;
* `capaspretexto.tex`: capa, folha de rosto, ficha catalográfica,
    agradecimentos, epigrafe;
* `resumos.tex`: contém o resumo e abstract geral da Tese;
* `bibtese2.bib`: documentado no item `*.bib`
* `preambulo.tex`: preambulo de acordo com as normas da UFLA em 2013/1
    para Tese;
* `preambulosimples.tex`: preambulo simples usado para gerar o pdf de cada
    capítulo isolado.

#### Extensões dos arquivos

* `*.tex`: arquivos nativos do latex;
* `*.aux`: auxiliar ao sistema de citação bibliográfica;
* `*.bbl`: resultado do processo de citação, contém entradas
  `\bibitem`. No caso de alguma referência não estar de acordo com as
  normas de citação exigidas, pode-se alterar a forma como ela é
  escrita e salvar em outro arquivo que no caso está identificado por
  `-corrigido.bbl`;
* `*.blg`: é o log do sistema de referências bibliográficas;
* `*.log`: log da compilação, que inclui mensagens de erro no caso de
  falha;
* `*.bib`: é o arquivo com cadastro das referências bibliográficas. No
  meu caso esse arquivo é gerado automaticamente pelo Mendeley
  (gerenciador de referências bibliográficas), sendo assim sua
  organização/estrutura é definida pelo Mendeley. Esse arquivo também
  pode ser criado manualmente;
* `*.out`: auxiliar dos bookmarks (suponho);
* `*.toc`: auxiliar do sumário.

A codificação de caracteres desses arquivos é utf-8. Usuários do
Windows provavelmente terão que converter para o iso-8859-1 que a
codificação predominante nesse sistema.

## Aplicativos

A edição desses arquivos foi feita principalmente com o editor
[Kile](http://kile.sourceforge.net/) para arquivos
[LaTex](http://www.latex-project.org/). Para análises estatísticas foi
considerado o [aplicativo R computação
estatística](http://cran.r-project.org/). Para trabalhar com arquivos
[Sweave](http://www.stat.uni-muenchen.de/~leisch/Sweave/) (não
incluídos) foi usado
[Emacs](http://vgoulet.act.ulaval.ca/en/emacs/)+[ESS](http://ess.r-project.org/). Para
extrair e gerenciar referências bibliográficas foi usado o
[Mendeley](http://www.mendeley.com/) com navegador
[Firefox](http://www.mozilla.org/pt-BR/firefox/new/). O estilo de
referências bibliográficas foi disponível no pacote latex
[abntcite](http://code.google.com/p/abntex2/). O sistema operacional
foi o [Ubuntu 12.04](http://releases.ubuntu.com/precise/).

## Funcionamento

#### Por que repartir o código fonte?

Para ter melhor controle do projeto como um todo. Mantendo cada
capítulo isolado é mais fácil navegar dentro do arquivo e encontrar
erros (debugar). Ao compilar `WalmesTese.tex` pode-se deixar comentado
os demais capítulos para ver como fica cada capítulo à medida que se
edita.

#### Por que compilar cada arquivo separado dentro de cada diretório?

Essa foi a forma que encontrada para superar a exigência de que cada
capítulo tivesse suas referências bibliográficas ao final. O arquivo
`cap1introduc.bbl`, que contêm cada `\bibitem{}` das citações em
`cap1.tex`, é criado ao gerar o `cap1introduc.pdf` a partir do
`cap1introduc.tex`. Sendo assim, em `WalmesTese.tex` basta fazer o
`\input{cap1introduc.bbl}`. O detalhe é que foi usado
`\input{cap1introduc-corrigido.bbl}`.

#### Qual a diferença entre `*.bbl` e `*-corrigido.bbl`?

Algumas referências tem peculiaridades que o abntcite não sabe
tratar. Um exemplo são os artigos da JRSS. Após o nome da revista tem
a série (A, B ou C). A citação correta deve ter apenas o nome da
revista em negrito conforme o exemplo abaixo:

> BEALE, E. M. Confidence regions in non-linear estimation.  **Journal
  of the Royal Statistical Society**. Series B (Methodological),
  v. 22, n. 1, p. 41-76, jan. 1960.

Para sair assim deve-se editar o `\bibitem{}` para que fique dessa forma:

```latex
\bibitem[Beale 1960]{Beale1960}
\abntrefinfo{Beale}{BEALE}{1960}
{BEALE, E.~M. {Confidence regions in non-linear estimation}.
\textbf{Journal of the Royal Statistical Society}. Series B (Methodological),
  v.~22, n.~1, p. 41--76, Jan. 1960.}
```

No arquivo `bibtese2.bib` essa citação está registrada assim:

```latex
@article{Beale1960,
author  = {Beale, E M},
journal = {Journal of the Royal Statistical Society. Series B (Methodological)},
month   = jan,
number  = {1},
pages   = {41--76},
title   = {{Confidence regions in non-linear estimation}},
volume  = {22},
year    = {1960}
}
```

Como não tem um campo para esse subtítulo da revista, a única opção é
deixar junto no campo `journal={}`. Acontece que sendo assim o
`\bibitem{}` gerado é com o `\textbf{}` incluindo nome da revista e
subtítulo:

```latex
\bibitem[Beale 1960]{Beale1960}
\abntrefinfo{Beale}{BEALE}{1960}
{BEALE, E.~M. {Confidence regions in non-linear estimation}.
\textbf{Journal of the Royal Statistical Society. Series B (Methodological)},
  v.~22, n.~1, p. 41--76, jan. 1960.}
```

E a citação correspondente fica errada:

> BEALE, E. M. Confidence regions in non-linear estimation.  **Journal
  of the Royal Statistical Society. Series B (Methodological)**,
  v. 22, n. 1, p. 41-76, jan. 1960.

Em resumo, enquanto houver inserção/remoção de referências use o
`abntcite` e nas referências cadastradas no `*.bib`. Isso vai gerar o
`*.bbl` que será incluído e possivelmente algumas referências vão
precisar ser alteradas. Ao final, copie o `*.bbl` para
`*-corrigido.bbl`. Entre no `*-corrigido.bbl` e edite as referências
que estão fora do padrão. Então use o `*-corrigido.bbl`. Por exemplo,
dentro do arquivo `*cap1introduc.tex` foi usado:

```latex
\bibliography{../tese/bibtese2}
%% \vspace*{-1.5cm}
%% \input{cap1introduc-corrigido.bbl}
```

Permaneceu assim até a versão submetida à Banca de Exame do
Doutorado. Após correções das referências bibliográficas por uma
profissional, as referências foram inseridas assim:

```latex
%% \bibliography{../tese/bibtese2}
\vspace*{-1.5cm}
\input{cap1introduc-corrigido.bbl}
```

## Campos desnecessários no `*.bib`

O Mendeley foi o aplicativo usado para gerenciar as
referências. Normalmente os metadados das referências são extraídas
das páginas web das revistas de onde baixa-se também o pdf dos
artigos. Ao extrair os metadados com o Mendeley vem mais informação do
que o necessário para gerar as referências na Tese. Essas informações
são o ISSN, ISBN, url, doi, como exemplo abaixo:

```latex
%% arquivo bibtese.bib gerado pelo Mendeley
@article{Alper1990,
author = {Alper, Joseph S. and Gelb, Robert I.},
doi = {10.1021/j100374a068},
file = {:home/walmes/Documentos/Mendeley Desktop/Alper1990.pdf},
issn = {0022-3654},
journal = {The Journal of Physical Chemistry},
month = may,
number = {11},
pages = {4747--4751},
publisher = {American Chemical Society},
title = {{Standard errors and confidence intervals ...}},
url = {http://dx.doi.org/10.1021/j100374a068},
volume = {94},
year = {1990}
}
```

Tais informações desnecessárias são incluídas no `*.pdf` quando
presentes no cadastro da referência dentro do `*.bib` que é gerado
automaticamente pelo Mendeley. Não foi encontrado como especificar os
campos que devem ser exportados pelo Mendeley ou os considerados pelo
abntcite. A solução foi excluir os campos desnecessários no arquivo
gerado pelo Mendeley. O código R abaixo lê o `bibtese.bib`, que veio
do Mendeley, e remove alguns campos para salvar o resultado em
`bibtese2.bib`, que é de fato o arquivo usado.

```r
## lê arquivo
bib <- readLines("bibtese.bib")

## encontra as linhas com campos indesejáveis
tira <- grep("(abstract|issn|isbn|url|doi|series|file) =", bib)

## escreve outro arquivo sem as linhas de campos indesejáveis
writeLines(bib[-tira], con="bibtese2.bib")
```

Após remover os campos, a mesma referência tem os seguintes campos no
arquivo `bibtese2.bib`:

```latex
%% arquivo bibtese2.bib resultado de remoção de linhas (campos)
%% feito por meio de um script R
@article{Alper1990,
author = {Alper, Joseph S. and Gelb, Robert I.},
journal = {The Journal of Physical Chemistry},
month = may,
number = {11},
pages = {4747--4751},
publisher = {American Chemical Society},
title = {{Standard errors and confidence intervals ...}},
volume = {94},
year = {1990}
}
```