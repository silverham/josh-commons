################
## Optional example of alaises in git bash
################

## xampp mysql (different port to dev desktop)
#alias mysql="winpty /c/xampp/mysql/bin/mysql --defaults-file=\"C:\xampp\mysql\bin\my.ini\""

#alias mysqldump="/c/xampp/mysql/bin/mysqldump --defaults-file=\"C:\xampp\mysql\bin\my.ini\""

## dev desktop mysql (different port to xampp)
#alias mysql='winpty "/c/Program Files (x86)/DevDesktop/mysql/bin/mysql" --defaults-file="C:\Program Files (x86)\DevDesktop\mysql\my.cnf"'

#alias mysqldump='winpty "/c/Program Files (x86)/DevDesktop/mysql/bin/mysqldump" --defaults-file="C:\Program Files (x86)\DevDesktop\mysql\my.cnf"'

## show git branch on prompt
# Taken from sourcetrre
export PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '

################
#startup SSH
################

eval `ssh-agent`

# Note must only 1 key active to SSH into Git Hub (most likey BitBucket)
# If you want to work in personal stuff, switch keys below. (and reopen git bash)
ssh-add /c/path/to/my/key/mykey.private

################
# Set a PHP version if not set already (and add mysql to PATH)
################
## To use remove "#(uncomment)" from lines below.

#(uncomment)if [ -z ${PHP_ID+x} ]; then
  ## echo "var is unset";
  ## If drupal less than 7.50 - then use php 5.6
  ## export PHP_ID="php5_6"
  ##(uncomment) export PHP_ID="php7_0"
#else
  #echo "var is set to '$PHP_ID'";
#(uncomment)fi

#(uncomment)export DEVDESKTOP_DRUPAL_SETTINGS_DIR=$USERPROFILE/.acquia/DevDesktop/DrupalSettings
#(uncomment)export PATH="/c/Program Files (x86)/DevDesktop/common/msys/bin:/c/Program Files (x86)/DevDesktop/$PHP_ID:/c/Program Files (x86)/DevDesktop/mysql/bin:"$PATH

################
# Add global composer bin files to git
################
# To use remove "#(uncomment)" from lines below.

#(uncomment)export PATH="$PATH:$USERPROFILE/AppData/Roaming/Composer/vendor/bin"

# add ruby/sass to path
export PATH=/c/Ruby23-x64/bin:$PATH

