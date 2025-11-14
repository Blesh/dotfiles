if exists("b:current_syntax")
  finish
endif

" Define group of keywords
" syn keyword logComponent server locationcomputer tagpositionworker positionprovider
syntax match logComponent '^\(server\|locationcomputer\|tagpositionworker\|positionprovider\)\s'

" Define group based on regular expression match
" Timestamp (ISO 8601 format)
" Example: 2025-05-20T13:21:29.703Z
syn match logTimestamp /\d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}\.\d\{3}Z/ containedin=ALLBUT

syn region logString      start=/"/  end=/"/  end=/$/  skip=/\\./
syn region logString      start=/`/  end=/`/  end=/$/  skip=/\\./
" Quoted strings, but no match on quotes like `don't`, possessive `s'` and `'s`
syn region logString      start=/\(s\)\@<!'\(s \|t \)\@!/  end=/'/  end=/$/  skip=/\\./

" Log Levels
syn match logTrace    /\s\d\{3}T\s/ containedin=ALLBUT
syn match logDebug    /\s\d\{3}D\s/ containedin=ALLBUT
syn match logInfo     /\s\d\{3}I\s/ containedin=ALLBUT
syn match logWarn     /\s\d\{3}W\s/ containedin=ALLBUT
syn match logCritical /\s\d\{3}C\s/ containedin=ALLBUT

syntax match logFilePath '\v(\S+)(\.(cpp|h))(:)(\s*)(\d+)' contains=logLineNum
syntax match logLineNum '\v\d+' contained

" Defines a group for a region that starts and ends with certain patterns.
" syn region logString start=/\S/ end=/$/ contains=@Spell,logTodo transparent keepend extend

hi def link logComponent      Constant
hi def link logTimestamp      Type

hi def link logFilePath       Statement
hi def link logLineNum        Type
hi def link logString         String

hi def link logTrace          Operator
hi def link logDebug          DiagnosticHint
hi def link logInfo           DiagnosticInfo
hi def link logWarn           DiagnosticWarn
hi def link logCritical       DiagnosticError


