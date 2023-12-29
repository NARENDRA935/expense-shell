echo disable nodejs
dnf module disable nodejs -y
echo enable nodejs verson
dnf module enable nodejs:18 -y
echo install nodejs
dnf install nodejs -y
echo configure the backend services
cp backend.service /etc/systemd/system/backend.service
echo adding application user
useradd expense
echo remove the existing app content
rm -rf /app
echo creating a app directory
mkdir /app
echo download the application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
echo change the app directory
cd /app
echo extracting the application content
unzip /tmp/backend.zip
echo downloadthe application dependancies
npm install
echo reload the systemD and restart the backend

systemctl daemon-reload
systemctl enable backend
systemctl restart backend
echo install mysql client
dnf install mysql -y
echo  load schema
mysql -h mysql-dev.narendrat.online -uroot -pExpenseApp@1 < /app/schema/backend.sql