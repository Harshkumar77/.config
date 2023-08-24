syntax match todoCheckbox '\v.*\[\ \]'hs=e-2 conceal cchar=⬜
syntax match todoCheckbox '\[x\]' conceal cchar=✔️

setlocal conceallevel=2
hi Conceal guibg=NONE
!echo "HI"
