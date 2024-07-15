import { parse as toJson }  from 'md-2-json'


const output = (toJson(`
# Heading 1


This is a para

- This is a list

## Heading 2

This is a para
`));



const stack = [...Object.keys(output)]
let last = false


while(stack.length === 0) {

}




