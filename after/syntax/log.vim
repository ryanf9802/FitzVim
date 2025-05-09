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

" Highlight 2xx status codes (200–299) in bright green
syntax match LogStatusSuccess /Status=\zs2\d\d\ze/
highlight LogStatusSuccess ctermfg=LightGreen guifg=#00ff00

" Highlight 3xx status codes (300–399) in bright yellow
syntax match LogStatusRedirect /Status=\zs3\d\d\ze/
highlight LogStatusRedirect ctermfg=Yellow guifg=#ffff00

" Highlight 4xx and 5xx status codes (400–599) in bright red
syntax match LogStatusError /Status=\zs[45]\d\d\ze/
highlight LogStatusError ctermfg=LightRed guifg=#ff5555

" Optionally highlight IP addresses (e.g., 127.0.0.1)
syntax match LogIP /\v\d{1,3}(\.\d{1,3}){3}/
highlight default link LogIP Constant

syntax keyword LogLevelDEBUG   DEBUG
syntax keyword LogLevelINFO    INFO
syntax keyword LogLevelWARNING WARNING
syntax keyword LogLevelERROR   ERROR

" ——— Highlight groups for log-levels ———
highlight LogLevelDEBUG   ctermfg=Blue      guifg=#9999ff
highlight LogLevelINFO    ctermfg=LightGreen     guifg=#99ff99
highlight LogLevelWARNING ctermfg=Yellow    guifg=#ffbb00
highlight LogLevelERROR   ctermfg=LightRed       guifg=#ff4444

let b:current_syntax = "log"

