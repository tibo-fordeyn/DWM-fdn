" Conceal definitions for custom commands with icons
syntax match texQs "\\qs{[^}]*}{[^}]*}" conceal
syntax match texExqs "\\exqs{[^}]*}{[^}]*}" conceal
syntax match texDfn "\\dfn{[^}]*}{[^}]*}" conceal
syntax match texThm "\\thm{[^}]*}{[^}]*}" conceal
syntax match texProp "\\prop{[^}]*}{[^}]*}" conceal
syntax match texLmm "\\lmm{[^}]*}{[^}]*}" conceal
syntax match texPrf "\\prf{[^}]*}{[^}]*}" conceal
syntax match texCor "\\cor{[^}]*}{[^}]*}" conceal
syntax match texIdea "\\idea{[^}]*}{[^}]*}" conceal
syntax match texClar "\\clar{[^}]*}{[^}]*}" conceal
syntax match texRem "\\rem{[^}]*}{[^}]*}" conceal
syntax match texAdd "\\add{[^}]*}{[^}]*}" conceal
syntax match texEx "\\ex{[^}]*}{[^}]*}" conceal
syntax match texBsl "\\bsl{[^}]*}{[^}]*}" conceal

" Define conceal characters with updated icons
syntax match texQs "\\qs" conceal cchar=🔍 
syntax match texExqs "\\ex" conceal cchar=📝
syntax match texThm "\\thm" conceal cchar=⚖️ 
syntax match texPrf "\\prf" conceal cchar=🧾 
syntax match texIdea "\\idea" conceal cchar=💡
syntax match texClar "\\clar" conceal cchar=ℹ️ 
syntax match texRem "\\rem" conceal cchar=🔔 
syntax match texAdd "\\add" conceal cchar=➕ 
syntax match texEx "\\exqs" conceal cchar=🧪 
syntax match texBsl "\\bsl" conceal cchar=📁 

syntax match texDfn "\\dfn" conceal cchar=📜 
syntax match texLmm "\\lmm" conceal cchar=L 
syntax match texProp "\\prop" conceal cchar=🔧 
syntax match texCor "\\cor" conceal cchar=C 

" Anki specific conceal for \akq and \akns
syntax match texAkq "\\akq" conceal cchar=?  
syntax match texAkns "\\akns" conceal cchar=! 

" Conceal begin and end LaTeX environments (thanks to reddit comment by dualfoothands)
call matchadd('Conceal', '\\begin{\ze[^}]\+}', 10, -1, {'conceal':'['})
call matchadd('Conceal', '\\begin{[^}]\+\zs}\ze', 10, -1, {'conceal':']'})

call matchadd('Conceal', '\\end\ze{[^}]\+}', 10, -1, {'conceal':'['})
call matchadd('Conceal', '\\end\zs{\ze[^}]\+}', 10, -1, {'conceal':'/'})
call matchadd('Conceal', '\\end{[^}]\+\zs}\ze', 10, -1, {'conceal':']'})


