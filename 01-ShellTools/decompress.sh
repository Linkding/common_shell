#Author:Allenoyk
#Description:����ѹ���ļ��ĸ�ʽ��ȷѡ���ѹ��ʽ��

#version 1.0
case ${1##*.tar.} in
  bz2)
    tar jzxf $1
    ;;
  gz)
    tar zxvf $1
    ;;
  *)
    echo "wrong file type"
esac

#version 2.0
case ${1##*.} in
  bz2)
    tar jzxf $1
    ;;
  gz)
    tar zxvf $1
    ;;
  bz)
    tar xjvf $1
    ;;
  tar)
    tar xvf $1
    ;;
  tgz)
    tar xzf $1
    ;;
  zip)
    unzip $1
    ;;
  *)
    echo "wrong file type"
esac
