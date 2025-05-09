" Only load once
if exists("b:current_syntax")
  finish
endif

" Match the module field (everything until the first pipe, without including it)
syntax match LogModule /^[^|]\+/
highlight default link LogModule Identifier

" Match the pipe separators to visually separate fields
syntax match LogSeparator /\s*|\s*/
highlight default link LogSeparator Special

" Match the request id between the first and second pipe.
syntax match LogRequestId /| \zsreq-[0-9a-zA-Z-]\+\ze |/
highlight default link LogRequestId Constant

" Match individual log levels and assign custom colors
syntax match LogLevelINFO /| \zsINFO\ze |/
highlight LogLevelINFO ctermfg=Yellow guifg=Yellow

syntax match LogLevelWARNING /| \zsWARN\ze |/
highlight LogLevelWARNING ctermfg=DarkYellow guifg=Orange

syntax match LogLevelERROR /| \zsERROR\ze |/
highlight LogLevelERROR ctermfg=Red guifg=Red

syntax match LogLevelDEBUG /| \zsDEBUG\ze |/
" No highlight applied, left default

" Match the timestamp (format: HH:MM:SS UTC±ZZZZ) between the third and fourth pipe.
syntax match LogTimestamp /| \zs\d\{2}:\d\{2}:\d\{2} UTC[-+]\d\{4}\ze |/
highlight default link LogTimestamp Type

" Match the log message (everything after the fourth pipe).
syntax match LogMessage /\v^([^|]*\|\s*[^|]*\|\s*[^|]*\|\s*[^|]*\|\s*)\zs.*/
highlight default link LogMessage Comment

" Highlight HTTP method names (e.g., GET, POST, PUT, DELETE, PATCH)
syntax match LogHTTPMethod /\v(GET|POST|PUT|DELETE|PATCH)/
highlight default link LogHTTPMethod Statement

" Highlight URLs enclosed in quotes
syntax region LogURL start=/"/ end=/"/
highlight default link LogURL String

" Additional highlights within the log message
syntax keyword LogFrom FROM
highlight default link LogFrom Identifier

syntax keyword LogResponse RESPONSE
highlight default link LogResponse Statement

syntax match LogDuration /Duration=\zs\d\+\.\d\+s/
highlight default link LogDuration Number

" Match status codes like Status=200
syntax match LogStatus /Status=\zs\d\{3}\ze/
highlight LogStatus ctermfg=Yellow guifg=Yellow

" Optionally highlight IP addresses (e.g., 127.0.0.1)
syntax match LogIP /\v\d{1,3}(\.\d{1,3}){3}/
highlight default link LogIP Constant

let b:current_syntax = "log"

