echo -e  "\e[32mdisable nodejs\e[0m"
dnf module disable nodejs -y >/tmp/expense.log
echo -e  "\e[32menable nodejs version\e[0m"
dnf module enable nodejs:18 -y >/tmp/expense.log
echo -e "\e[32minstall nodejs\e[0m"
dnf install nodejs -y >/tmp/expense.log
echo -e "\e[32m  configure the backend services\e[0m"
cp backend.service /etc/systemd/system/backend.service >/tmp/expense.log
echo -e "\e[32m adding application user\e[0m"
useradd expense >/tmp/expense.log
echo -e "\e[32m remove the existing app content\e[0m"
rm -rf /app >/tmp/expense.log
echo -e "\e[32m creating  app directory\e[0m"
mkdir /app >/tmp/expense.log
echo -e "\e[32m download the application content\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >/tmp/expense.log
echo -e "\e[32m change the app directory\e[0m"
cd /app >/tmp/expense.log
echo -e "\e[32m extracting the application content\e[0m"
unzip /tmp/backend.zip
echo -e "\e[32m download the application dependencies\e[0m"
npm install >/tmp/expense.log
echo -e "\e[32m reload the systemD and restart the backend\e[0m"

systemctl daemon-reload >/tmp/expense.log
systemctl enable backend >/tmp/expense.log
systemctl restart backend >/tmp/expense.log
echo -e "\e[32m install mysql client\e[0m"
dnf install mysql -y >/tmp/expense.log
echo -e "\e[32m  load schema\e[0m"
mysql -h mysql-dev.narendrat.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >/tmp/expense.log