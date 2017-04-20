# Optioanl example of alaises in git bash

alias mysql="winpty /c/xampp/mysql/bin/mysql --defaults-file=\"C:\xampp\mysql\bin\my.ini\""
alias mysqldump="/c/xampp/mysql/bin/mysqldump --defaults-file=\"C:\xampp\mysql\bin\my.ini\""

#startup SSH

eval `ssh-agent`

# Note must only 1 key active to SSH into Git Hub (most likey BitBucket)
# If you want to work in personal stuff, switch keys below. (and reopen git bash)
ssh-add /c/path/to/my/key/mykey.private
