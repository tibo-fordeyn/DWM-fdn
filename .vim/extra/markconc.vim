" Markdown-specific conceal syntax
syntax match MarkdownH1 "^# .*$" conceal cchar=🔹
syntax match MarkdownH2 "^## .*$" conceal cchar=🔸
syntax match MarkdownH3 "^### .*$" conceal cchar=🔻
syntax match MarkdownH4 "^#### .*$" conceal cchar=🔶

" Conceal voor lijsten (bullet points)
syntax match MarkdownBullet "^\s*[-*]\s" conceal cchar=•   
syntax match MarkdownOrderedList "^\s*\d\+\.\s" conceal cchar=➤

" Conceal voor links
syntax match MarkdownLink /\[\([^]]\+\)\]\([^)]\+\)/ conceal cchar=🔗

" Conceal voor blokquotes
syntax match MarkdownBlockQuote "^> " conceal cchar=❝

" Conceal voor inline code
syntax match MarkdownInlineCode "`[^`]*`" conceal cchar=⌨️

" Conceal voor code blocks
syntax match MarkdownCodeBlock "```[^`]*```" conceal cchar=📄

" Vimwiki-specific conceal syntax
syntax match VimwikiLink /\[\[[^]]\+\]\]/ conceal cchar=🗂️  " Conceal Wiki-links met icoon
syntax match VimwikiTodo "^TODO:" conceal cchar=✔️         " Conceal TODO met checkbox
syntax match VimwikiDone "^DONE:" conceal cchar=✅         " Conceal DONE met vinkje

" Algemeen conceal voor begin- en eindmarkeringen van markdown
call matchadd('Conceal', '\\[\\ze[^]]\\+\\]', 10, -1, {'conceal':'['})
call matchadd('Conceal', '\\[\\([^]]\\+\\)\\zs\\]', 10, -1, {'conceal':']'})
call matchadd('Conceal', '\\(http[s]\?\\):\\zs\\/\\ze\\/', 10, -1, {'conceal':'/'})
