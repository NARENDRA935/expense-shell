log_file=/tmp/expense.log
mysql_passwd=$1
head(){
    echo -e "\e[32m"$1\e[0m"
}
head " disable nodejs\e[0m"
dnf module disable nodejs -y &>>log_file
head " enable nodejs version\e[0m"
dnf module enable nodejs:18 -y &>>log_file
head " install nodejs\e[0m"
dnf install nodejs -y &>>log_file
head "  configure the backend services\e[0m"
cp backend.service /etc/systemd/system/backend.service
head " adding application user\e[0m"
useradd expense &>>log_file
head " remove the existing app content\e[0m"
rm -rf /app &>>log_file
head " creating  app directory\e[0m"
mkdir /app &>>log_file
head " download the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
head " change the app directory\e[0m"
cd /app &>>log_file
head " extracting the application content\e[0m"
unzip /tmp/backend.zip &>>log_file
head " download the application dependencies\e[0m"
npm install &>>log_file
head " reload the systemD and restart the backend\e[0m"

systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
head " install mysql client\e[0m"
dnf install mysql -y &>>log_file
head "  load schema\e[0m"
mysql -h mysql-dev.narendrat.online -uroot -p${mysql_passwd} < /app/schema/backend.sql &>>log_file