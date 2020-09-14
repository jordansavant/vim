" Nightbow is my customization of Inkpot colorscheme modified for 256

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "nightbow"

" map a urxvt cube number to an xterm-256 cube number
fun! <SID>M(a)
    return strpart("0135", a:a, 1) + 0
endfun

" map a urxvt colour to an xterm-256 colour
fun! <SID>X(a)
    if &t_Co == 88
        return a:a
    else
        if a:a == 8
            return 237
        elseif a:a < 16
            return a:a
        elseif a:a > 79
            return 232 + (3 * (a:a - 80))
        else
            let l:b = a:a - 16
            let l:x = l:b % 4
            let l:y = (l:b / 4) % 4
            let l:z = (l:b / 16)
            return 16 + <SID>M(l:x) + (6 * <SID>M(l:y)) + (36 * <SID>M(l:z))
        endif
    endif
endfun

" echo"<SID>X(39)=" . <SID>X(39)
" <SID>X(79)=235

let g:nbl_colorcursor = 1

let nb_mainbg = 233
let nb_text = 252
let nb_faintext = nb_mainbg + 6
let nb_black = 16
let nb_white = 15
let nb_deepsea = 17
let nb_jetblue = 27
let nb_skyblue = 33
let nb_nimblue = 45
let nb_danger = 9   " red
let nb_hazard = 215 " orange
let nb_caution = 221 " yello
let nb_cautionfade = 185
let nb_ewokgrn = 40 " lime green
let nb_plasmared = 203 " red
let nb_bubblegum = 177
let nb_ultravio = 129
let nb_energy = 84
let nb_darkvio = 55

if &t_Co == 256

    exec "hi Normal         cterm=NONE   ctermfg=" . nb_text . " ctermbg=" . nb_mainbg

    exec "hi Cursor     cterm=NONE  ctermfg=" . nb_black . "  ctermbg=" . nb_white
    exec "hi CursorIM   cterm=NONE  ctermfg=" . nb_black . "  ctermbg=" . nb_white
    exec "hi CursorLineNr cterm=NONE ctermfg=" . nb_energy ." ctermbg=" . nb_black
    if g:nbl_colorcursor == 1
        exec "hi CursorLine     cterm=NONE   ctermbg=" . nb_black
        exec "hi CursorColumn   cterm=NONE   ctermbg=" . nb_black
    else
        exec "hi CursorLine     cterm=NONE   ctermbg=" . "NONE"
        exec "hi CursorColumn   cterm=NONE   ctermbg=" . "NONE"
    endif

    exec "hi IncSearch      cterm=BOLD   ctermfg=" . nb_mainbg . " ctermbg=" . nb_hazard
    exec "hi Search         cterm=NONE   ctermfg=" . nb_mainbg . " ctermbg=" . <SID>X(52)

    exec "hi ErrorMsg       cterm=BOLD   ctermfg=" . nb_black . " ctermbg=" . <SID>X(48)
    exec "hi WarningMsg     cterm=BOLD   ctermfg=" . nb_black . " ctermbg=" . <SID>X(68)
    exec "hi ModeMsg        cterm=BOLD   ctermfg=" . <SID>X(38) . " ctermbg=" . "NONE"
    exec "hi MoreMsg        cterm=BOLD   ctermfg=" . <SID>X(38) . " ctermbg=" . "NONE"
    exec "hi Question       cterm=BOLD   ctermfg=" . <SID>X(52) . " ctermbg=" . "NONE"

    " not sure what users are
    exec "hi User1          cterm=BOLD   ctermfg=" . <SID>X(28) . " ctermbg=" . <SID>X(81)
    exec "hi User2          cterm=BOLD   ctermfg=" . <SID>X(39) . " ctermbg=" . <SID>X(81)

    exec "hi VertSplit      cterm=NONE   ctermfg=" . nb_jetblue . " ctermbg=NONE"
    exec "hi TabLineFill    cterm=NONE   ctermbg=" . (nb_mainbg + 1)
    exec "hi TabLine        cterm=NONE   ctermfg=NONE ctermbg=" . (nb_mainbg + 2)
    exec "hi TabLineSel     cterm=NONE   ctermfg=NONE ctermbg=" . nb_jetblue

    " status line color modes
    exec "hi StatusLine     cterm=NONE   ctermfg=" . nb_faintext . " ctermbg=" . (nb_mainbg + 1)
    exec "hi StatusLineNC   cterm=NONE   ctermfg=" . nb_faintext . " ctermbg=" . nb_mainbg

    let g:nb_faintext = nb_faintext
    let g:nb_mainbg = nb_mainbg
    let g:nb_deepsea = nb_deepsea
    let g:nb_energy = nb_energy
    function! InsertStatuslineColor(mode)
        if a:mode == 'i'
            exec "hi statusline ctermfg=" . g:nb_energy . " ctermbg=" . g:nb_deepsea
        elseif a:mode == 'r'
            exec "hi StatusLine cterm=NONE ctermfg=" . g:nb_faintext . " ctermbg=" . (g:nb_mainbg + 1)
        else
            exec "hi StatusLine cterm=NONE ctermfg=" . g:nb_faintext . " ctermbg=" . (g:nb_mainbg + 1)
        endif
    endfunction
    au InsertEnter * call InsertStatuslineColor(v:insertmode)
    au InsertChange * call InsertStatuslineColor(v:insertmode)
    au InsertLeave * exec "hi StatusLine     cterm=NONE   ctermfg=" . nb_faintext . " ctermbg=" . (nb_mainbg + 1)

    exec "hi WildMenu       cterm=BOLD   ctermfg=" . nb_text . " ctermbg=" . <SID>X(38)

    exec "hi MBENormal                   ctermfg=" . <SID>X(85) . " ctermbg=" . <SID>X(81)
    exec "hi MBEChanged                  ctermfg=" . nb_text . " ctermbg=" . <SID>X(81)
    exec "hi MBEVisibleNormal            ctermfg=" . <SID>X(85) . " ctermbg=" . <SID>X(82)
    exec "hi MBEVisibleChanged           ctermfg=" . nb_text . " ctermbg=" . <SID>X(82)

    exec "hi DiffText       cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(34)
    exec "hi DiffChange     cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(17)
    exec "hi DiffDelete     cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
    exec "hi DiffAdd        cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(20)

    exec "hi Folded         cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(35)
    exec "hi FoldColumn     cterm=NONE   ctermfg=" . <SID>X(39) . " ctermbg=" . nb_mainbg

    "exec "hi Directory      cterm=NONE   ctermfg=" . nb_jetblue . " ctermbg=" . "NONE"
    exec "hi Directory      cterm=NONE   ctermfg=" . (nb_faintext + 5) . " ctermbg=" . "NONE"
    "exec "hi Directory      cterm=NONE   ctermfg=" . nb_skyblue . " ctermbg=" . "NONE"
    exec "hi LineNr         cterm=NONE   ctermfg=" . nb_faintext . " ctermbg=" . nb_black
    " hide nontext tildes in empty buffer
    exec "hi NonText cterm=NONE ctermfg=" . nb_mainbg . " ctermbg=" . nb_mainbg
    exec "hi SpecialKey     cterm=BOLD   ctermfg=" . <SID>X(55) . " ctermbg=" . "NONE"
	exec "hi Title          ctermbg=NONE  ctermfg=" . nb_energy ."    cterm=NONE"
    exec "hi Visual         cterm=NONE   ctermfg=" . nb_black . " ctermbg=" . nb_faintext

    exec "hi Comment        cterm=NONE   ctermfg=" . nb_faintext. " ctermbg=" . "NONE"
    exec "hi Constant       cterm=NONE   ctermfg=" . nb_hazard . " ctermbg=" . "NONE"
    exec "hi String         cterm=NONE   ctermfg=" . nb_ewokgrn . " ctermbg=" . (nb_mainbg + 2)
    exec "hi Error          cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
    exec "hi Identifier     cterm=NONE   ctermfg=" . nb_skyblue . " ctermbg=" . "NONE"
    exec "hi Ignore         cterm=NONE"

    exec "hi Number         cterm=NONE   ctermfg=" . nb_plasmared . " ctermbg=" . "NONE"
    exec "hi cNumber         cterm=NONE   ctermfg=" . nb_plasmared . " ctermbg=" . "NONE"
    exec "hi cFloat         cterm=NONE   ctermfg=" . nb_plasmared . " ctermbg=" . "NONE"

    exec "hi PreProc        cterm=NONE   ctermfg=" . nb_cautionfade . " ctermbg=" . "NONE"
    exec "hi Special        cterm=NONE   ctermfg=" . <SID>X(55) . " ctermbg=" . "NONE"
    exec "hi SpecialChar    cterm=NONE   ctermfg=" . <SID>X(55) . " ctermbg=" . <SID>X(81)
    " if elses etc
    exec "hi Statement      cterm=NONE   ctermfg=" . nb_nimblue . " ctermbg=" . "NONE"
    exec "hi Operator      cterm=NONE   ctermfg=" . nb_bubblegum . " ctermbg=" . "NONE"
    exec "hi Delimiter      cterm=NONE   ctermfg=" . nb_bubblegum . " ctermbg=" . "NONE"

    " inverted comment TODO comment
    exec "hi Todo           cterm=NONE   ctermfg=" . nb_mainbg . " ctermbg=" . nb_faintext

    exec "hi Type           cterm=NONE   ctermfg=" . nb_ultravio . " ctermbg=" . "NONE"
    exec "hi cStructure ctermfg=" . nb_ultravio .  " ctermbg=NONE cterm=NONE"
    exec "hi phpStructure ctermfg=" . nb_ultravio .  " ctermbg=NONE cterm=NONE"
    exec "hi Underlined     cterm=BOLD   ctermfg=" . <SID>X(77) . " ctermbg=" . "NONE"
    exec "hi TaglistTagName cterm=BOLD   ctermfg=" . <SID>X(39) . " ctermbg=" . "NONE"

    if v:version >= 700
        " intellisense autocomplete
        exec "hi Pmenu          cterm=NONE   ctermfg=" . nb_text . " ctermbg=" . (nb_mainbg + 2)
        exec "hi PmenuSel       cterm=NONE   ctermfg=" . nb_text . " ctermbg=" . nb_darkvio
        exec "hi PmenuSbar      cterm=BOLD   ctermfg=" . nb_text . " ctermbg=" . nb_black
        exec "hi PmenuThumb     cterm=BOLD   ctermfg=" . nb_text . " ctermbg=" . nb_darkvio

        exec "hi SpellBad       cterm=NONE ctermbg=" . <SID>X(32)
        exec "hi SpellRare      cterm=NONE ctermbg=" . <SID>X(33)
        exec "hi SpellLocal     cterm=NONE ctermbg=" . <SID>X(36)
        exec "hi SpellCap       cterm=NONE ctermbg=" . <SID>X(21)
        exec "hi MatchParen     cterm=NONE ctermbg=" . nb_darkvio . "ctermfg=" . <SID>X(25)
    endif

endif

" vim: set et :
