* How to set up coding environment.
```bash
$ ./nonstop_vim_setup.sh
$ cp ./mkcscope.sh [TARGET_DIR]
$ cd [TARGET_DIR]
$ ./mkcscope.sh 
$ ctags -R .
$ vim ~/.vimrc
set tags+=[TARGET_DIR]/tags
```
