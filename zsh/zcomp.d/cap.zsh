_cap_does_task_list_need_generating () {
  if [ ! -f .cap_tasks~ ]; then return 0;
  else
    [[ config/deploy.rb -nt .cap_tasks~ ]]
    
    # accurate=$(builtin stat +mtime .cap_tasks)
    # changed=$(builtin stat +mtime config/deploy.rb)
    # return $(($accurate >= $changed))
  fi
}

_cap () {
  if [ -f config/deploy.rb ]; then
    if _cap_does_task_list_need_generating; then
      cap -T | grep "^cap " | cut -d " " -f 2 | sed -e '/^ *$/D' -e '1,2D' >! .cap_tasks~
    fi
    compadd `cat .cap_tasks~`
  fi
}

compdef _cap capompdef _cap cap
