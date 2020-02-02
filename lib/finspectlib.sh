#!/bin/bash
source /home/epessanha/Documentos/finspect/etc/vars.cnf
source $ETCDIR/mdirs.cnf
source $ETCDIR/finspect.cnf



#Realiza a listagem dos arquivos monitorados
function list_files(){
   for files in ${MONITORED_DIRS[*]}; do 
      find $files -type f -exec echo \'{}\' \;; 
   done | sort
}

#Exibe o hash sha256 dos arquivos listados através da função list_files
function hash_files(){
   list_files | xargs sha256sum
}

#Exibe os inodes dos arquivos listados através da função list_files
function inode_files(){
   list_files | xargs ls -li | awk '{print $1" "$NF}'
}

#Exibe os atributos dos arquivos listados através da função list_files
function attr_files(){
   list_files | xargs lsattr
}

#Exibe as permissões dos arquivos listados através da função list_files
function perm_files(){
   list_files | xargs ls -lih --full-time | awk '{print $2" "$NF}'
}

#Exibe os usuários donos dos arquivos listados através da função list_files
function owner_files(){
   list_files | xargs ls -lih --full-time | awk '{print $4" "$NF}'
}

#Exibe os grupos dos dos arquivos listados através da função list_files
function group_files(){
   list_files | xargs ls -lih --full-time | awk '{print $5" "$NF}'
}

#Exibe o tamanho dos arquivos listados através da função list_files
function size_files(){
   list_files | xargs du -b
}

#Exibe a data de criação ou modificação dos arquivos listados através da função list_files
function date_files(){
   list_files | xargs ls -lih --full-time | awk '{print $7"-"$8" "$NF}'
}

#Exibe o tipo dos arquivos listados através da função list_files
function type_files(){
   for files in ${MONITORED_DIRS[*]}; do 
      find $files -type f -exec file {} \;; 
   done
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
function init_enviroment(){
   if [ !(-e $FSTATIC) &&  ]; then 
      echo "tentativa inválida de criar o ambiente"
   else 
      if [   ]
      echo Nao
   fi
}
