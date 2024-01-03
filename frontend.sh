component=frontend
source common.sh
head "install nginx software"
dnf install nginx -y &>>log_file
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "copy expense config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi

app_prereq "/usr/share/nginx/html"
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi
head "enable and restart the application"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
if [ $? -eq 0 ]; then
    echo "sucess"
else
    echo "failure"
    exit
fi