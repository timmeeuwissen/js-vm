{ createMemory } = require './memory'
{ CPU } = require './cpu'
instructions = require './instructions'
readline = require 'readline'

memory = createMemory 256*256
writableBytes = new Uint8Array memory.ref.buffer

cpu = CPU memory

i = 0

# require('./programs/count') cpu, i, writableBytes
# require('./programs/stack_move') cpu, i, writableBytes
require('./programs/subroutine') cpu, i, writableBytes

interact = readline.createInterface {
  input: process.stdin
  output: process.stdout
}

console.log "Initial state:"
cpu.register.debug()
memory.debug cpu.register.getValue 'ip'
memory.debug 0x0100
cpu.stack.debug()


interact.on 'line', () =>
  cpu.step()
  cpu.register.debug()
  memory.debug cpu.register.getValue 'ip'
  memory.debug 0x0100
  cpu.stack.debug()

