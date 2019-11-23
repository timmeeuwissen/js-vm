instructions = require '../instructions'

module.exports = (i, writableBytes) =>
  # PROGRAM THAT LEVERAGES THE STACK TO SWAP VALUE R3 AND R4
  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x13
  writableBytes[i++] = 0x13
  writableBytes[i++] = R3

  writableBytes[i++] = instructions.MOV_LIT_REG
  writableBytes[i++] = 0x14
  writableBytes[i++] = 0x14
  writableBytes[i++] = R4

  writableBytes[i++] = instructions.PSH_REG
  writableBytes[i++] = R3

  writableBytes[i++] = instructions.PSH_REG
  writableBytes[i++] = R4

  writableBytes[i++] = instructions.POP
  writableBytes[i++] = R3

  writableBytes[i++] = instructions.POP
  writableBytes[i++] = R4
