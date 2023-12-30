log_file =/tmp/expense.log
echo -e  "\e[32m disable nodejs\e[0m"
dnf module disable nodejs -y &>>log_file
echo -e  "\e[32m enable nodejs version\e[0m"
dnf module enable nodejs:18 -y &>>log_file
echo -e "\e[32m install nodejs\e[0m"
dnf install nodejs -y &>>log_file
echo -e "\e[32m  configure the backend services\e[0m"
cp backend.service /etc/systemd/system/backend.service
echo -e "\e[32m adding application user\e[0m"
useradd expense &>>log_file
echo -e "\e[32m remove the existing app content\e[0m"
rm -rf /app &>>log_file
echo -e "\e[32m creating  app directory\e[0m"
mkdir /app &>>log_file
echo -e "\e[32m download the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo -e "\e[32m change the app directory\e[0m"
cd /app &>>log_file
echo -e "\e[32m extracting the application content\e[0m"
unzip /tmp/backend.zip &>>log_file
echo -e "\e[32m download the application dependencies\e[0m"
npm install &>>log_file
echo -e "\e[32m reload the systemD and restart the backend\e[0m"

systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
echo -e "\e[32m install mysql client\e[0m"
dnf install mysql -y &>>log_file
echo -e "\e[32m  load schema\e[0m"
mysql -h mysql-dev.narendrat.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file