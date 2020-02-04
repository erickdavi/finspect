#!/bin/bash
source /home/erickdavi/projects/finspect/etc/vars.cnf
source $ETCDIR/mdirs.cnf
source $ETCDIR/finspect.cnf



#Realiza a listagem dos arquivos monitorados
function list_files(){
   for files in ${MONITORED_DIRS[*]}; do
      find $files -type f -exec echo \'{}\' \;;
   done | sort #| awk -F"'" '{print $2}'
}
#Exibe o hash sha256 dos arquivos listados através da função list_files
#function hash_files(){
#   list_files | xargs sha256sum
#}
function hash_files(){
   if [ -n $1 -a -f $1 ]; then
      sha256sum $1 | awk '{print $1}'
   else
      echo "null"
   fi
}

#Exibe os inodes dos arquivos listados através da função list_files
#function inode_files(){
#   list_files | xargs ls -li | awk '{print $1" "$NF}'
#}

function inode_files(){
   if [ -n $1 -a -f $1 ]; then
      ls -li $1 | awk '{print $1}'
   else
      echo "null"
   fi
}

#Exibe os atributos dos arquivos listados através da função list_files
#function attr_files(){
#   list_files | xargs lsattr
#}
function attr_files(){
   if [ -n $1 -a -f $1 ]; then
      lsattr $1 | awk '{print $1}'
   else
      echo "null $1"
   fi
}

#Exibe as permissões dos arquivos listados através da função list_files
function perm_files(){
   if [ -n $1 -a -f $1 ]; then
      ls -lih --full-time $1 | awk '{print $2}'
   else
      echo "null"
   fi
}

#Exibe os usuários donos dos arquivos listados através da função list_files
function owner_files(){
   if [ -n $1 -a -f $1 ]; then
      ls -lih --full-time $1 | awk '{print $4}'
   else
      echo "null"
   fi
}

#Exibe os grupos dos dos arquivos listados através da função list_files
function group_files(){
   if [ -n $1 -a -f $1 ]; then
      ls -lih --full-time $1 | awk '{print $5}'
   else
      echo "null"
   fi
}

#Exibe o tamanho dos arquivos listados através da função list_files
function size_files(){
   if [ -n $1 -a -f $1 ]; then
      du -b $1 | awk '{print $1}'
   else
      echo "null"
   fi
}

#Exibe a data de criação ou modificação dos arquivos listados através da função list_files
function date_files(){
   if [ -n $1 -a -f $1 ]; then
      ls -lih --full-time $1 | awk '{print $7"-"$8}'
   else
      echo "null"
   fi
}

#Exibe o tipo dos arquivos listados através da função list_files
#function type_files(){
#   for files in ${MONITORED_DIRS[*]}; do
#      find $files -type f -exec file {} \;;
#   done | awk -F":" '{print $NF": "$1}'
#}
function type_files(){
   if [ -n $1 -a -f $1 ]; then
      file $1 | awk -F":" '{print $2}' | sed 's/^ //g'
   else
      echo "null"
   fi
}




#Realiza o backup compactado dos arquivos listados através da função list_files
function to_shadow_files(){
   for files in ${MONITORED_DIRS[*]}; do
      find $files -type f -exec cp {} $SHADOWDIR \;;
   done

   gzip $SHADOWDIR/*
   #chattr +i $SHADOWDIR/*
}

#Inicializa o ambiente, criando diretórios de controle e os arquivos de modelo para as comparações
#function init_enviroment(){
#   if [ !(-e $FSTATIC) &&  ]; then 
#      echo "tentativa inválida de criar o ambiente"
#   else 
#      if [   ]
#      echo Nao
#   fi
#}


#Coleta e organiza as informacoes de um arquivo
function data_file_collector(){
   HASH=$(hash_files $1)
   INODE=$(inode_files $1)
   #ATTR=$(attr_files $1)
   PERM=$(perm_files $1)
   OWNER=$(owner_files $1)
   GRP_OWN=$(group_files $1)
   SIZE=$(size_files $1)
   DATE=$(date_files $1)
   TYPE=$(type_files $1)

   echo "$1,$HASH,$INODE,$PERM,$OWNER,$GRP_OWN,$SIZE,$DATE,$TYPE"

}

