#função para verificar se é número a string
# x é numero
enum<-function(x){
  grepl("^\\d+(\\.|\\,)\\d+$",x)
}
#reajusta o data.frame, x é data frame
reajvar<-function(x){
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
  
return(y)
}

