echo -e  "\e[32mdisable nodejs\e[0m" >/tmp/expense.log
dnf module disable nodejs -y
echo -e  "\e[32menable nodejs version\e[0m" >/tmp/expense.log
dnf module enable nodejs:18 -y
echo -e "\e[32minstall nodejs\e[0m" >/tmp/expense.log
dnf install nodejs -y
echo -e "\e[32m  configure the backend services\e[0m" >/tmp/expense.log
cp backend.service /etc/systemd/system/backend.service
echo -e "\e[32m adding application user\e[0m" >/tmp/expense.log
useradd expense
echo -e "\e[32m remove the existing app content\e[0m" >/tmp/expense.log
rm -rf /app
echo -e "\e[32m creating  app directory\e[0m" >/tmp/expense.log
mkdir /app
echo -e "\e[32m download the application content\e[0m" >/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
echo -e "\e[32m change the app directory\e[0m" >/tmp/expense.log
cd /app
echo -e "\e[32m extracting the application content\e[0m" >/tmp/expense.log
unzip /tmp/backend.zip
echo -e "\e[32m download the application dependencies\e[0m" >/tmp/expense.log
npm install
echo -e "\e[32m reload the systemD and restart the backend\e[0m" >/tmp/expense.log

systemctl daemon-reload
systemctl enable backend
systemctl restart backend
echo -e "\e[32m install mysql client\e[0m" >/tmp/expense.log
dnf install mysql -y
echo -e "\e[32m  load schema\e[0m" >/tmp/expense.log
mysql -h mysql-dev.narendrat.online -uroot -pExpenseApp@1 < /app/schema/backend.sql