#每天备份 MySQL
USER=root
PASSWORD=xxxx
BACKUP_DIR=/db_apps/mysql_backup #备份数据库文件的路径
LOGFILE=/db_apps/mysql_backup/data_backup.log    #备份数据库脚本的日志文件
DATE=`date +%Y%m%d-%H%M -d -3minute`     #获取当前系统时间-3分钟
ARCHIVE1=$DATE-tar.gz                #备份的数据库压缩后的名称

if [ ! -d $BACKUP_DIR ]; then                #判断备份路径是否存在，若不存在则创建该路径
    sudo mkdir -p "$BACKUP_DIR"
fi

sudo echo -e "\n" >> $LOGFILE
sudo echo "------------------------------------" >> $LOGFILE
sudo echo "BACKUP DATE:$DATE">> $LOGFILE
sudo echo "------------------------------------" >> $LOGFILE

cd $BACKUP_DIR                           #跳到备份路径下
sudo mysqldump -u$USER -p$PASSWORD --all-databases --add-drop-table --add-locks > $BACKUP_DIR/backup.sql    #使用mysqldump备份数据库
if [[ $? == 0 ]]; then
    sudo tar czvf $ARCHIVE1 backup.sql >> $LOGFILE 2>&1                               #判断是否备份成功，若备份成功，则压缩备份数据库，否则将错误日志写入日志文件中去。
echo "$ARCHIVE1 BACKUP SUCCESSFUL!" >> $LOGFILE
sudo rm -f backup.sql
else
sudo echo "$ARCHIVE1 Backup Fail!" >> $LOGFILE
fi