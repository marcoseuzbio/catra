# Introdução
Estes codigos tem por intenção auxiliar em problemas enfrentados quanto a tarefas rotineiras na agencia.
## função enum
a função enum tem por objetivo verificar se o string é um número. A função retorna um valor boolean
### sintaxde
x1<- 'carro'
x2<- '1,2'
x3<-'1.2'
enum(x1)
a função retorna F
enum(x2)
 a função retorna T
enum(x3)
a função retorna T
## função reajvar
A função tem por objetivo apenas utilizar as linhas que contenham algum valor númerico, e assim descartar as que não contenham valor númerico, ela também transforma as linhas excluidas em titulo. A função retorna uma lista se for informado um segundo valor como True
## Função opera
A função tem como objetivo ler um arquivo excel, verificar quais variáveis contém datas, e assim fazer um banco de dados com datas.
Esta função deve ser utilizada com cuidado, visto que ela depende de variáveis dentro do primeiro excel.
## FUnção opera1
Esta função tem como objetivo utilizar a função opera porém esperando que tenha sido dito que existe data, hora, ou interval
