{ createMemory } = require './memory'
{ CPU } = require './cpu'
instructions = require './instructions'

memory = createMemory 256
writableBytes = new Uint8Array memory.buffer

cpu = CPU memory

writableBytes[0] = instructions.MOV_LIT_R1
writableBytes[1] = 0x12
writableBytes[2] = 0x34

writableBytes[3] = instructions.MOV_LIT_R2
writableBytes[4] = 0xAB
writableBytes[5] = 0xCD

writableBytes[6] = instructions.ADD_REG_REG
writableBytes[7] = 2
writableBytes[8] = 3

cpu.debug()

cpu.step()
cpu.debug()

cpu.step()
cpu.debug()

cpu.step()
cpu.debug()

