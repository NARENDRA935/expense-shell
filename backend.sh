log_file=/tmp/expense.log
mysql_passwd=$1
head() {
    echo -e "\e[36m$1\e[0"
}
head "disable nodejs"
dnf module disable nodejs -y &>>log_file
echo $?
head "enable nodejs version"
dnf module enable nodejs:18 -y &>>log_file
echo $?
head "install nodejs"
dnf install nodejs -y &>>log_file
echo $?
head "configure the backend services"
cp backend.service /etc/systemd/system/backend.service
echo $?
head "adding application user"
useradd expense &>>log_file
echo $?
head "remove the existing app content"
rm -rf /app &>>log_file
echo $?
head "creating  app directory"
mkdir /app &>>log_file
echo $?
head "download the application content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo $?
head "change the app directory"
cd /app &>>log_file
echo $?
head "extracting the application content"
unzip /tmp/backend.zip &>>log_file
echo $?
head "download the application dependencies"
npm install &>>log_file
echo $?
head "reload the systemD and restart the backend"

systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
echo $?
head "install mysql client"
dnf install mysql -y &>>log_file
echo $?
head "load schema"
mysql -h mysql-dev.narendrat.online -uroot -p${mysql_passwd} < /app/schema/backend.sql &>>log_file
echo $?