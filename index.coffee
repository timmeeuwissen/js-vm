{ createMemory } = require './memory'
{ CPU } = require './cpu'
instructions = require './instructions'
readline = require 'readline'

memory = createMemory 256*256
writableBytes = new Uint8Array memory.ref.buffer

cpu = CPU memory

IP = 0
ACC = 1
R1 = 2
R2 = 3
R3 = 4
R4 = 5
R5 = 6
R6 = 7
R7 = 8
R8 = 9

i = 0

# require('./programs/count') i, writableBytes
require('./programs/stack_move') i, writableBytes




interact = readline.createInterface {
  input: process.stdin
  output: process.stdout
}

console.log "Initial state:"
cpu.register.debug()
memory.debug cpu.register.getValue 'ip'
memory.debug 0x0100


interact.on 'line', () =>
  cpu.step()
  cpu.register.debug()
  memory.debug cpu.register.getValue 'ip'
  memory.debug 0x0100
