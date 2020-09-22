augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
  au! BufNewFile,BufRead *.meta setf csv
  au! BufNewFile,BufRead *.cfg setf csv
  au! BufNewFile,BufRead *.view setf php
  au! BufNewFile,BufRead *.vue setf html
augroup END
