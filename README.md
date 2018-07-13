# Linux学习任务（因为浏览器上传不了图片，所以结果截图在另一个pdf里） 
## 1.factorial
#代码功能：计算阶乘

#!/bin/bash

n=$1;sum=1

#具体计算阶乘的递归函数
function factorial()  
{

        local local_n=$1
        local local_n_sub_1=$(($local_n-1))

        if [ $local_n_sub_1 -lt 1 ];then
                sum=1
        else
                factorial $local_n_sub_1
                sum=`expr $local_n \* $sum`
        fi
}

#如果没有传入参数，就显示usage，有参数则显示阶乘计算结果

    if [ $# -eq 0  ];then
        echo 'usage:1.factorial.sh [n]'
        echo "calculate a number's factorial"

    elif [ $# -eq 1 ];then
        factorial $n
        echo $sum

    else
        echo 'Input Error!'

    fi

解题思路：如果传入参数个数等于0，则输出usage；如果传入参数个数等于1，则计算阶乘。  
先给local_n传入$1，如果其大于1则进入递归，一直到其等于1时才能避免递归，进行下一步sum*=local_n。然后在一步步脱出的过程中，完成了阶乘。  

## 2.self_compression  
#代码功能：自动解压文件

#!/bin/bash

#如果参数个数等于0，则输出usage
if [ $# == '0' ];then
        echo "usage: 2.self_compression.sh [--list] or [Source compressed file] [Destination path]"
        echo "Self compression according wo the file name suffix"

#如果参数1为"--list"，则输出支持的类型
elif [ $1 == "--list" ];then
        echo "Supported file types: zip tar tar.gz tar.bz2"

#除此之外，则执行解压功能模块
else
        main=$1
        path1="${main%/*}"
        path0="${path1#*.}" #压缩文件所在路径
        filename="${main##*/}" #压缩文件名称（包含后缀）
        extension="${filename##*.}" #压缩文件后缀
        case $extension in
                zip)
                        #根据参数个数，判断用户有没有指定解压路径
                        if [ $# == '1' ];then
                                cd $path0
                                unzip $filename
                        elif [ $# == '2' ];then
                                cd $path0
                                path=$2
                                unzip $filename -d $path
                        fi
                ;;
                tar)
                        if [ $# == '1' ];then
                                cd $path0
                                tar -xvf $filename
                        elif [ $# == '2' ];then
                                cd $path0
                                path=$2
                                tar -xvf $filename -C $path
                        fi
                ;;
                tar.gz)
                        if [ $# == '1' ];then
                                cd $path0
                                tar -xzf $filename
                        elif [ $# == '2' ];then
                                cd $path0
                                path=$2
                                tar -xzf $filename -C $path
                        fi
                ;;
                tar.bz2)
                        if [ $# == '1' ];then
                                cd $path0
                                tar -xjf $filename
                        elif [ $# == '2' ];then
                                cd $path0
                                path=$2
                                tar -xjf $filename -C $path
                        fi
                ;;
                *)
                        echo 'Input error filename!'
                ;;
        esac

fi


