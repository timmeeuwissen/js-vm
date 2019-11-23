instructions = require '../instructions'

module.exports = (cpu, i, writableBytes) =>
  # PROGRAM TO COUNT TO THREE
  writableBytes[i++] = instructions.MOV_MEM_REG
  writableBytes[i++] = 0x01
  writableBytes[i++] = 0x00
  writableBytes[i++] = cpu.register.nameToIndex.r1

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x00
  writableBytes[i++] = 0x01
  writableBytes[i++] = cpu.register.nameToIndex.r2

  writableBytes[i++] = instructions.ADD_REG_REG
  writableBytes[i++] = cpu.register.nameToIndex.r1
  writableBytes[i++] = cpu.register.nameToIndex.r2

  writableBytes[i++] = instructions.MOV_REG_MEM
  writableBytes[i++] = cpu.register.nameToIndex.acc
  writableBytes[i++] = 0x01
  writableBytes[i++] = 0x00

  writableBytes[i++] = instructions.JMP_NOT_EQ
  writableBytes[i++] = 0x00
  writableBytes[i++] = 0x03
  writableBytes[i++] = 0x00
  writableBytes[i++] = 0x00

