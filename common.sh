log_file=/tmp/expense.log
head() {
    echo -e "\e[32m$1\e[0"
}

app_prereq(){
  dir=$1
head "remove the existing app content"
rm -rf /$1 &>>log_file
Stat $?
head "creating  app directory"
mkdir /$1 &>>log_file

Stat $?
head "download the application content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
Stat $?
head "change the app directory"
cd $1 &>>log_file


Stat $?
head "extracting the application content"
unzip /tmp/${component}.zip &>>log_file



}

Stat(){
  if [ $1 -eq 0 ]; then
      echo "sucess"
  else
      echo "failure"
      exit
  fi

}