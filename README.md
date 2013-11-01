# Modelo de Tese em capítulos UFLA 2013/1

Este arquivo é a descrição de como foram organizados os arquivos e os diretórios além de guias gerais para aproveitar a estrutura dos arquivos fornecidos.

## Partição do código fonte

Uma das vantagens da edição de documentos em LaTex é fazer a partição do código fonte. Com iss é possível editar partes de um grande documento, como uma Tese, mantendo as partes separadas em arquivos. 

Para ter um maior controle do projeto eu separei todo o conteúdo em diretórios. Cada capítulo tem um diretório. As figuras, tabelas e scripts R tambem tem seus diretórios. Abaixo está a organização do diretório.

```
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

Uma vez que tem-se o código fonte dividido e os elementos que o compõem estão distribuídos em vários diretórios, deve se dar atenção nas chamadas dos arquivos nos `\input{}`, `\includegraphics{}` e `\bibliography{}`. No linux isso é facilmente controlado por meio da espeficicação relacional de diretórios usando `../` e `./`.

## Descrição de cada arquivo

#### Diretórios
* `cap?`: diretórios para os arquivos de cada capítulo;
* `figuras`: diretório com todas figuras;
* `tabelas`: diretório com todas as tabelas;
* `scripts`: diretório com scripts R fornecidos como anexo.

#### Nomes de arquivos
* `cap?`: prefixo `cap` seguido de número, que indica o capítulo, é o arquivo com o corpo do capítulo. Com sulfixos indica-se que elementos textuais se referem.
    * `resumo`: resumo do capitulo;
    * `abstract`: abstract do capítulo;
* `WalmesTese`: arquivo mestre que gera o pdf da Tese;
* `capaspretexto`: capa, folha de rosto, ficha catalográfica, agradecimentos, epigrafe;
* `resumos`: contém o resumo e abstract geral da Tese;
* `bibtese2`: documentado no item `*.bib`
* `preambulo`: preambulo de acordo com as normas da UFLA em 2013/1 para Tese;
* `preambulosimples`: preambulo simples usado para gerar o pdf de cada capítulo isolado.

#### Extensões de arquivos
* `*.tex`: arquivos nativos do latex;
* `*.aux`: auxiliar ao sistema de citação bibliográfica;
* `*.bbl`: resultado do processo de citação, contém entradas `\bibitem`. No caso de alguma referência não estar de acordo com as normas de citação exigidas, pode-se arterar a forma como ela é escrita e salvar em outro arquivo que no caso é está identificado por `-corrigido.bbl`;
* `*.blg`: é o log do sistema de referências bibliográficas;
* `*.log`: log da compilação, que inclui mensagens de erro no caso de falha;
* `*.bib`: é o arquivo com cadastro das referências bibliográficas. No meu caso esse arquivo é gerado automaticamente pelo Mendeley (gerenciador de referências bibliográficas), sendo assim sua organização/estrutura é definida pelo Mendeley. Esse arquivo também pode ser criado manualmente;
* `*.out`: auxiliar dos bookmarks (suponho);
* `*.toc`: auxiliar do sumário.

A codificação de caracteres desses arquivos é uft-8. Usuários do Windows provavelmente terão que converter para o iso-8859-1 que a codificação predominante nesse sistema.

## Recursos de edição

A edição desses arquivos foi feita princilpalmente com o editor [Kile](http://kile.sourceforge.net/) para arquivos [LaTex](http://www.latex-project.org/). Para análises estatísticas foi considerado o [aplicativo R computação estatística](http://cran.r-project.org/). Para trabalhar com arquivos [Sweave](http://www.stat.uni-muenchen.de/~leisch/Sweave/) (não incluídos) foi usado [Emacs](http://vgoulet.act.ulaval.ca/en/emacs/)+[ESS](http://ess.r-project.org/). O sistema operacional foi o [Ubuntu 12.04](http://releases.ubuntu.com/precise/).

