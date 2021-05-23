" vim:sw=4
" ============================================================================
" File:           tasksystem.vim
" Author:         caoshenghui <576365750@qq.com>
" Github:         https://github.com/caoshenghui
" Description:
" LICENSE:        MIT
" ============================================================================


function! tasksystem#complete(ArgLead, CmdLine, CursorPos) abort
    return []
endfunction

function! tasksystem#run(bang, label) abort
    " from json file get local and global settings
    let taskinfo = tasksystem#json#taskinfo()
    " process tasks's parameters
    " 需要改进这个函数，性能太差了
    let taskinfo = tasksystem#params#process(taskinfo)
    let fttaskinfo = tasksystem#params#fttaskinfo()
    if has_key(fttaskinfo, &filetype)
        echo a:label
        echo fttaskinfo[&filetype]
        if get(fttaskinfo[&filetype], a:label, '') != ''
        endif
    endif
    return
    " check params
    if has_key(opts, a:label)
        let params = opts[a:label]
        " process predefinedvars
        let params = tasksystem#predefinedvars#process_macros(params)
        let type = get(params, 'type', 'floaterm')
        if type == 'floaterm'
            call tasksystem#floaterm#run(a:bang, params)
        endif
    else
        call tasksystem#utils#errmsg(a:label . " task not exist!")
    endif
endfunction

" call tasksystem#run('', '12')
