# verificando se os pacotes que quero estão instalados
list.of.packages <- c("readxl")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
#função para verificar se é número a string
# x é numero
enum<-function(x){
  grepl("^\\d+(\\.|\\,)\\d+$",x)
}
#reajusta o data.frame, x é data frame
reajvar<-function(x,lista=F){
  if (is.data.frame(x)==F){
    x=as.data.frame(x)
  }
  y=NULL
nam=names(x)
n=rep(T,nrow(x))
  for (i in 1:nrow(x)){
    for (j in 1:ncol(x)){
      # se for a primeira linha, já aviso que iremos excluir
      if (j==1)  exclude=T
      # se for número eu não excluo
      if (enum(x[i,j])){
        exclude=F
        n[i]=F
      }

      else
        #se não for a primeira linha e ainda estou dizendo que vou excluir, então excluo
        if (j==ncol(x) & exclude==F)
          y<-rbind(y,x[i,])
    }
  }
# variável auxiliar para pegar os nomes
xt<-x[n,]
# encho a nova variável com nomes vazios
names(y)<-rep(NA,ncol(xt))
for (i in 1:nrow(xt))
  for (j in 1:ncol(xt))
    # se a celula não é na
  if (is.na(xt[i,j])==F)
    # se no nome não contém a célula
        if (!any(grepl(xt[i,j],names(y)[j]))){
          # se o nome for vazio
          if (is.na(names(y)[j]))
            # este é o primeiro nome da minha variável
            names(y)[j]<-x[i,j]
          #caso o contrário eu o adiciono aos nomes anteriores
else
          names(y)[j]<- paste(names(y)[j],x[i,j],sep = '-')
        }
  if (lista==F) return(y)
else
return(list(dataf=y,valor=n))
}

# Mesma função de cima, porém transforma as datas
# options(chron.origin = c(month=12, day=30, year=1899))
# catra1<-function(x,lista1=NULL,lista2=NULL){
#   # x a lista, data frame, etc
#   # lista1 é a lista de palavras que identificam datas
#   # primeiro ajeito o banco, ainda tendo os números
#   x1<- reajvar(x)
#   x11<-as.data.frame(x1)
#   # agora verifico se tenho alguma palavra a verificar
#   if (!is.null(lista1)){
#     # quantas palavras vou verificar
#     n<-length(lista1)
#     for (i in 1:n){
#       # para cada palavra, verifico quais colunas vou verificar
#       ver<-grepl(lista1[i],names(x1))
#       # tomo a quantidade de colunas
#       n1<-length(names(x1))
#       for (j in 1:n1){
#         # se a minha coluna contém a palavra
#         if (ver[j]==T){
#           # percorro linha por linha modificando o format0
#           n2=length(x1[1,])
#           for (k in 1:n2){
#             x11[k,j] <-as.Date(as.numeric(x1[k,j]), origin = "1899-12-30")
#           }
#         }
#       }
#     }
#   }
#   # agora verifico se tenho alguma palavra a verificar
#   if (!is.null(lista2))
#   {
#     # quantas palavras vou verificar para tempo
#     n<-length(lista2)
#     for (i in 1:n){
#       # para cada palavra, verifico quais colunas vou verificar
#       ver<-grepl(lista2[i],names(x1))
#       # tomo a quantidade de colunas
#       n1<-length(names(x1))
#       for (j in 1:n1){
#         # se a minha coluna contém a palavra
#         if (ver[j]==T){
#           # percorro linha por linha modificando o format0
#           n2=length(x1[1,])
#           for (k in 1:n2){
#             x11[k,j] <-chron::as.chron(as.numeric(x1[k,j]))
#           }
#         }
#       }
#     }
#   }
#   return(x11)
# }
#ler o banco já ajeitando os dados
opera<-function(x,lista1=NULL){
  # primeiro leio o arquivo
  x2<-readxl::read_excel(x)
  #aqui reajusto o arquivo
  x1x<-reajvar(x2,lista = T)
  # separo o arquivo entre os valores e as linhas que não quero
  x1<-as.data.frame(x1x$dataf)
  nn<-as.vector(x1x$valor)
  # pego os nomes das linhas
  name<-names(x1)
  # digo que nenhuma coluna corresponde a data
  ver1<-rep(F,ncol(x1))
  if(!is.null(lista1)){
    # pego a quantidade de valores que vou procurar
    n=length(lista1)
    for (i in 1:n){
      # procuro quais colunas vou verificar
      ver<-grepl(lista1[i],names(x1))
      ver1[which(ver==T)]=T
    }
    # assumo que todos serão lidos como padrão, ou seja, texto
  ver2=rep("text",ncol(x1))
  # quais eu disse que verei, mudo para data
  ver2[which(ver1==T)]="date"
  # leio com o novo formato
  x1<-readxl::read_excel(x,col_types = ver2)
  }
  # quais eu não queroeu excluo
  x2<-x1[-which(nn==T),]
  #transformo em data frame
  x2<-as.data.frame(x2)
  # atribuo os nomes
  names(x2)<-name
  return(x2)
}
opera1<-function(x){
  #essa função usa a função opera porém com uma lista1 padrão
  padronizado=c("DATA","HORA","INTERVAL")
  x1<-opera(x,padronizado)
  return(x1)
}
