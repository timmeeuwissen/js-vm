module.exports =
  NO_OP       : 0x00

  # move
  MOV_LIT_REG : 0x10
  MOV_REG_REG : 0x11
  MOV_REG_MEM : 0x12
  MOV_MEM_REG : 0x13

  # operations
  ADD_REG_REG : 0x14

  # branching
  JMP_NOT_EQ  : 0x15

  # stack operations
  PSH_LIT     : 0x16
  PSH_REG     : 0x17
  POP         : 0x18
  CAL_LIT     : 0x1a
  CAL_REG     : 0x1b
  RET         : 0x1c
