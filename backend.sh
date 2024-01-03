mysql_passwd=$1
component=backend
source common.sh
head "disable nodejs"
dnf module disable nodejs -y &>>log_file

Stat $?
head "enable nodejs version"
dnf module enable nodejs:18 -y &>>log_file


Stat $?
head "install nodejs"
dnf install nodejs -y &>>log_file


Stat $?
head "configure the backend services"
cp backend.service /etc/systemd/system/backend.service
Stat $?
head "adding application user"
useradd expense &>>log_file
id expense &>>log_file
if [ $? -ne 0 ]; then
    useradd expense &>>log_file
fi
Stat $?
app_prereq "/app"
head "download the application dependencies"
npm install &>>log_file
Stat $?
head "reload the systemD and restart the backend"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
Stat $?
head "install mysql client"
dnf install mysql -y &>>log_file
Stat $?
mysql -h mysql-dev.narendrat.online -uroot -p${mysql_passwd} < /app/schema/backend.sql &>>log_file
Stat $?