mysql_passwd=$1
if [ -z "$mysq_passwd" ]; then
  echo "input mysql_password is misssing"
fi
dnf module disable mysql -y
cp mysql.repo /etc/yum.repos.d/mysql.repo
dnf install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass ${mysql_passwd}