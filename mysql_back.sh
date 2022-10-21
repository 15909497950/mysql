#!/bin/bash
# mysql备份脚本，每天备份一次，删除7天前备份(可以根据客户需求更改)
#backdir
backupDir=/data/dbback
#mysqlDump
mysqldump=/usr/local/mysql/bin/mysqldump
#ip address
host=127.0.0.1
#username && password
username=root
password=Udcdata@2022!

#今天日期
today=`date +%Y%m%d`
#7天前的日期
timeSevenDaysAgo=`date -d -7day +%Y%m%d`

echo $today-'开始备份mysql'
$mysqldump -h$host --port 3306 -u$username -p$password --all-databases|gzip > $backupDir/mysqlback-$today.sql.gz
echo '成功备份'$database'到'$backupDir/mysqlback-$today.sql.gz

if [ ! -f "$backupDir/mysqlback-$timeSevenDaysAgo.sql.gz" ]; then
          echo '7天前备份不存在，无需删除'
      else
          rm $backupDir/mysqlback-$timeSevenDaysAgo.sql.gz
          echo '删除7天前的备份文件'$backupDir/$database-$timeSevenDaysAgo.sql.gz
fi
echo "*****************************************************"
