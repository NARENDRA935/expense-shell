source common.sh
head "install nginx software"
dnf install nginx -y &>>log_file
echo $?
head "copy expense config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
echo $?
head "remove defalut content"
rm -rf /usr/share/nginx/html/* &>>log_file
echo $?
head "download tha application content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
echo $?
head "change the directories"
cd /usr/share/nginx/html &>>log_file
echo $?
head "extracting the content"
unzip /tmp/frontend.zip &>>log_file
echo $?
head "enable and restart the application"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
echo $?