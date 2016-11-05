syn match pythonOperator "\v\="

syn match pythonOperator "\v\+\=?"
syn match pythonOperator "\v-\=?"
syn match pythonOperator "\v\*\=?"
syn match pythonOperator "\v/\=?"
syn match pythonOperator "\v//\=?"
syn match pythonOperator "\v\*\*\=?"

syn match pythonOperator "\v\=\="
syn match pythonOperator "\v\!\="
syn match pythonOperator "\v\!"

syn match pythonOperator "\v\>"
syn match pythonOperator "\v\<"
syn match pythonOperator "\v\>\="
syn match pythonOperator "\v\<\="

syn match pythonOperator "\v\&"
syn match pythonOperator "\v\|"
syn match pythonOperator "\v\^"
syn match pythonOperator "\v\~"
syn match pythonOperator "\v\<\<"
syn match pythonOperator "\v\>\>"

highlight link pythonOperator Operator


syn keyword pythonStatement self


syn keyword pythonBuiltinType range int tuple list bool dict float bytearray str bytes slice object unicode ascii
highlight link pythonBuiltinType Type

