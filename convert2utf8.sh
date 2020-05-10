    #! /bin/bash
    base=$1

    function loop_dir(){
        for file in `ls $1`       #注意此处这是两个反引号，表示运行系统命令
        do
            if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
            then
                loop_dir $1"/"$file
            else
                if [[ $file == *txt ]]
                then
                    filePath=$base"/utf8"${1:${#base}}"/"$file #把转换后的文件放入文件夹下的utf8目录
                    mkdir -p  ${filePath%/*} #创建文件夹层次
                    `iconv -f GB18030 -t UTF8 $1"/"$file > $filePath` #可以在此处修改原始编码和目标编码，根据情况设定
                    if [ $? -ne 0 ];then
                        echo ${filePath} #出错时打印出错的文件
                    
                    fi
                fi

                
            fi
        done
    }   
    
    
    #读取第一个参数
    loop_dir $1
