# PVIM - pronounce as PWIM 


This is the dockerized vim with PHP Support and Idea behind pvim is pretty simply - you take your VIM along with you. 

It is based on [SVIM](https://github.com/VarunBatraIT/svim)

# How to use?

Add this to your ~/.bashrc or ~/.zshrc depending on your configuration:

```
alias pvim='docker run -ti -e TERM=xterm -e GIT_USERNAME="You True" -e GIT_EMAIL="you@getyourdatasold"  --rm -v $(pwd):/home/developer/workspace varunbatrait/pvim'
```

Then use 

```
pvim path/to/file
```

# Note

Try to be on the directory of project - where you have your git repository. It will have added functionality of git. 

