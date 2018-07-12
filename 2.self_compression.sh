#set -e
#set -xv

if [ $# == '0' ];then
	echo "usage: 2.self_compression.sh [--list] or [Source compressed file] 	[Destination path]"
	echo "Self compression according wo the file name suffix"

elif [ $1 == "--list" ];then
	echo "Supported file types: zip tar tar.gz tar.bz2"

else
	filename=$1
	extension="${filename##*.}"
	case $extension in
		zip)
			if [ $# == '1' ];then
                        	unzip $filename
	                elif [ $# == '2' ];then
				path=$2
				unzip $filename -d $path
			fi
		;;
		tar)
                        if [ $# == '1' ];then
                                tar -xvf $filename
                        elif [ $# == '2' ];then
                                path=$2
                                tar -xvf $filename -C $path
			fi
                ;;
		tar.gz)
                        if [ $# == '1' ];then
                                tar -xzf $filename
                        elif [ $# == '2' ];then
                                path=$2
                                tar -xzf $filename -C $path
			fi
                ;;
		tar.bz2)
                        if [ $# == '1' ];then
                                tar -xjf $filename
                        elif [ $# == '2' ];then
                                path=$2
                                tar -xjf $filename -C $path
			fi
                ;;
		*)
			echo 'Input error filename!'
		;;
	esac
	
fi
