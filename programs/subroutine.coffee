instructions = require '../instructions'

subroutineAddress = 0x3000

module.exports = (cpu, i, writableBytes) =>
  # PROGRAM THAT EXECUTES A SUBROUTINE
  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x33
  writableBytes[i++] = 0x33

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x32
  writableBytes[i++] = 0x32

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x31
  writableBytes[i++] = 0x31

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x12
  writableBytes[i++] = 0x34
  writableBytes[i++] = cpu.register.nameToIndex.r1

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x56
  writableBytes[i++] = 0x78
  writableBytes[i++] = cpu.register.nameToIndex.r4


  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x00
  writableBytes[i++] = 0x00

  writableBytes[i++] = instructions.CAL_LIT
  writableBytes[i++] = (subroutineAddress & 0xff00) >> 8
  writableBytes[i++] = (subroutineAddress & 0x00ff)

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x44
  writableBytes[i++] = 0x44

  i = subroutineAddress

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x01
  writableBytes[i++] = 0x02

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x03
  writableBytes[i++] = 0x04

  writableBytes[i++] = instructions.PSH_LIT
  writableBytes[i++] = 0x05
  writableBytes[i++] = 0x06

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x07
  writableBytes[i++] = 0x08
  writableBytes[i++] = cpu.register.nameToIndex.r1

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x09
  writableBytes[i++] = 0x0a
  writableBytes[i++] = cpu.register.nameToIndex.r8

  writableBytes[i++] = instructions.RET
