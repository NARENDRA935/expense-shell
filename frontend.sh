component=frontend
source common.sh
head "install nginx software"
dnf install nginx -y &>>log_file

Stat $?
head "copy expense config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file

Stat $?

app_prereq "/usr/share/nginx/html"
head "enable and restart the application"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file

Stat $?