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

i = 0

writableBytes[i++] = instructions.MOV_MEM_REG
writableBytes[i++] = 0x01
writableBytes[i++] = 0x00
writableBytes[i++] = R1

writableBytes[i++] = instructions.MOV_LIT_REG
writableBytes[i++] = 0x00
writableBytes[i++] = 0x01
writableBytes[i++] = R2

writableBytes[i++] = instructions.ADD_REG_REG
writableBytes[i++] = R1
writableBytes[i++] = R2

writableBytes[i++] = instructions.MOV_REG_MEM
writableBytes[i++] = ACC
writableBytes[i++] = 0x01
writableBytes[i++] = 0x00

writableBytes[i++] = instructions.JMP_NOT_EQ
writableBytes[i++] = 0x00
writableBytes[i++] = 0x03
writableBytes[i++] = 0x00
writableBytes[i++] = 0x00

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
