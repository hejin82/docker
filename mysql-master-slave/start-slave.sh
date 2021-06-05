#!/bin/sh

# depends_onの設定しておけば気にならないけど念の為masterの起動を待つ
while ! mysqladmin ping -h mysql-master --silent; do
  sleep 1
done

# masterをロックする
mysql -u root -h mysql-master -e "RESET MASTER;"
mysql -u root -h mysql-master -e "FLUSH TABLES WITH READ LOCK;"

# masterのDB情報をDumpする
mysqldump -uroot -h mysql-master --all-databases --master-data --single-transaction --flush-logs --events > /tmp/master_dump.sql

# dumpしたmasterのDBをslaveにimportする
mysql -u root -e "STOP SLAVE;";
mysql -u root < /tmp/master_dump.sql

# masterに繋いで bin-logのファイル名とポジションを取得する
log_file=`mysql -u root -h mysql-master -e "SHOW MASTER STATUS\G" | grep File: | awk '{print $2}'`
pos=`mysql -u root -h mysql-master -e "SHOW MASTER STATUS\G" | grep Position: | awk '{print $2}'`

# slaveの開始
mysql -u root -e "RESET SLAVE";
mysql -u root -e "CHANGE MASTER TO MASTER_HOST='mysql-master', MASTER_USER='root', MASTER_PASSWORD='', MASTER_LOG_FILE='${log_file}', MASTER_LOG_POS=${pos};"
mysql -u root -e "START SLAVE"

# masterをunlockする
mysql -u root -h mysql-master -e "UNLOCK TABLES;"
