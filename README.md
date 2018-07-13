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

解题思路：输出提示信息就是单纯的用if实现，主要是解压功能。
用shell里字符串截取的办法，提取出待解压文件所在路径、待解压文件名、待解压文件后缀、解压目录。然后根据各种不同格式的解压命令，通过case来执行对应的命令。

## 3.file_size
#代码功能：找出目录最大的前n个文件并排序输出

#!/bin/bash

#由于直接用head -n输出的结果，不符合题目所给示例的描述，所以写一个转换打印格式的函数  
function printt  
{

        count=1
        cat fileFor4.txt | while read line #从自动生成的fileFor4.txt里按行读取
        do
                #printf '%d %s\n' 1 "abc"
                printf "\t%d\t %-50s\n" $count "$line"
                count=$(($count+1))
        done
}

#如果输入参数个数为零，默认将本目录前5名输出  

	if [ $# -eq 0 ];then
        echo "The largest files/directories in $4 are:"
        find -type f -o -type d -print0 | xargs -0 du -h | sort -rh | head -n 5 >fileFor4.txt
        printt

#如果输入了4个参数，而且第一个和第三个是-n和-d，则执行输出前n个的功能

	elif [[ $# -eq 4 && $1 == "-n" && $3 == "-d" ]];then
        echo "The largest files/directories in $4 are:"
        find $4 -type f -o -type d -print0 | xargs -0 du -h | sort -rh | head -n $2 >fileFor4.txt
        printt

#除此之外，全部输出usage

	else
        echo "usage: 4.file_size.sh [-n N][-d DTR]"
        echo "Show top N largest files/directories"

	fi

解题思路：find   path   -option   [   -print ]。如果是默认本目录，则缺省path；-option选择type来指定搜索的文件类型（f表示普通文件，d表示文件夹。他们中间用-o连接起来，表示无论普通文件还是文件夹皆可被搜索。）；最后的print0来输出完整文件名，并跟随一个null。  
”|“来将前面find的输出变成下一条命令的输入。  
xargs将标准输入换成命令行参数，-0保证以空字符（null）而不是空白字符来分割记录。经过xargs的转换处理，du接收find搜索到的目录下的所有文件和文件夹，并且得到它们的大小，-h是为了让结果更易于阅读（2048k就会变成2M）。  
sort可以对du的结果进行排序，-r保证了它按从大到小排序，-h作用也是使结果易于阅读。  
head用来输出前n行结果。  
由于head输出的结果格式不符合题目规范，我将其结果重定向输出至fileFor4.txt文件，再用printt函数读取并转换格式来输出。  
