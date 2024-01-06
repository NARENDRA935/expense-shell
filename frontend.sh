component=frontend
#source common.sh
#head "install nginx software"
#dnf install nginx -y &>>log_file
#
#Stat $?
#head "copy expense config file"
#cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
#
#Stat $?
#
#
#head "remove the existing app content"
#rm -rf /$1 &>>log_file
#Stat $?
#head "creating  app directory"
#mkdir /$1 &>>log_file
#
#Stat $?
#head "download the application content"
#curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
#Stat $?
#head "change the app directory"
#cd $1 &>>log_file
#
#
#Stat $?
#head "extracting the application content"
#unzip /tmp/${component}.zip &>>log_file
#head "enable and restart the application"
#systemctl enable nginx &>>log_file
#systemctl restart nginx &>>log_file

