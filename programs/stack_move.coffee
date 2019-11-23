instructions = require '../instructions'

module.exports = (cpu, i, writableBytes) =>
  # PROGRAM THAT LEVERAGES THE STACK TO SWAP VALUE R3 AND R4
  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x13
  writableBytes[i++] = 0x13
  writableBytes[i++] = cpu.register.nameToIndex.r3

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x14
  writableBytes[i++] = 0x14
  writableBytes[i++] = cpu.register.nameToIndex.r4

  writableBytes[i++] = instructions.PSH_REG
  writableBytes[i++] = cpu.register.nameToIndex.r3

  writableBytes[i++] = instructions.PSH_REG
  writableBytes[i++] = cpu.register.nameToIndex.r4

  writableBytes[i++] = instructions.POP
  writableBytes[i++] = cpu.register.nameToIndex.r3

  writableBytes[i++] = instructions.POP
  writableBytes[i++] = cpu.register.nameToIndex.r4
