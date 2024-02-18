#!/bin/bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

cd ~/ric-towing/

echo "Automated run $(date +'%Y-%m-%d')"
python tow_scraper.py > logs/daily.log 2>&1
pyrc=$?

# print to job output
cat logs/daily.log

if [ $pyrc != 0 ]; then
  mail -s "Job error: ric-towing" $recipient <logs/daily.log
fi



