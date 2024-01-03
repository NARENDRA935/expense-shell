mysql_passwd=$1
component=backend
source common.sh
head "disable nodejs"
dnf module disable nodejs -y &>>log_file
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "enable nodejs version"
dnf module enable nodejs:18 -y &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "install nodejs"
dnf install nodejs -y &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "configure the backend services"
cp backend.service /etc/systemd/system/backend.service

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "adding application user"
useradd expense &>>log_file
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
app_prereq "/app"

head "download the application dependencies"
npm install &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "reload the systemD and restart the backend"

systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "install mysql client"
dnf install mysql -y &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "load schema"
mysql -h mysql-dev.narendrat.online -uroot -p${mysql_passwd} < /app/schema/backend.sql &>>log_file

if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi