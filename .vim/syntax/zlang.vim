
if exists("b:current_syntax")
    finish
endif

" statements
syn keyword zLanguageKeywords fn on if else elseif
hi def link zLanguageKeywords Statement

syn keyword zInit var
hi def link zInit Type

syn match zAssign "[:][=]"
hi def link zAssign PreProc

" delimeters
syn match zDelimiter    "[()]"
syn match zBraces display "[{}]"

hi def link zDelimiter Delimiter
hi def link zBraces Delimiter

" numbers
syn match zNumber "-\=\<\d\+\>"
syn match zNumber "\<0x\x\{1,8}\>"
syn match zFloat  "\(-\=\<\d+\|-\=\)\.\d\+\>"
syn keyword zBoolean true false TRUE FALSE

hi def link zNumber Number
hi def link zFloat Float
hi def link zBoolean Boolean

" operators
syn match zOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match zOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match zOperator	"[.!~*&%<>^|=,+-]"
"syn match zOperator	"/[^/*=]"me=e-1
syn match zOperator	"/$"
syn match zOperator "&&\|||"
syn match zOperator	"[][]"

hi def link zOperator Operator

" comments
syn match zComment  "#.\{-}$"

hi def link zComment Comment

" variables
syn match zVar "[@]\a\+"
hi def link zVar Identifier

" errors
syn match zSemi ";"
hi def link zSemi Error

