{ createRegister } = require './register'
instructions = require './instructions'

CPU = (memory) =>
  registerNames = [
    'ip', 'acc',
    'r1', 'r2', 'r3', 'r4',
    'r5', 'r6', 'r7', 'r8',
    'sp', 'fp',
  ]

  register = createRegister registerNames

  register.setValue 'sp', memory.ref.byteLength - 1 - 1
  register.setValue 'fp', memory.ref.byteLength - 1 - 1

  fetch8 = () =>
    nextInstructionAddress = register.getValue 'ip'
    instruction = memory.get nextInstructionAddress
    register.setValue 'ip', nextInstructionAddress + 1
    instruction

  fetch16 = () =>
    nextInstructionAddress = register.getValue 'ip'
    instruction = memory.get2 nextInstructionAddress
    register.setValue 'ip', nextInstructionAddress + 2
    instruction

  push = (value) =>
    currentSP = register.getValue 'sp'
    memory.set2 currentSP, value
    register.setValue 'sp', currentSP - 2

  pop = () =>
    nextSP = (register.getValue 'sp') + 2
    register.setValue 'sp', nextSP
    memory.get2 nextSP

  execute = (instruction) =>
    switch instruction

      when instructions.NO_OP then break

      when instructions.MOV_LIT_REG
        literal = fetch16()
        registerTo = fetch8()
        register.setPointerValue registerTo, literal

      when instructions.MOV_REG_REG
        originPointer = fetch8()
        targetPointer = fetch8()
        register.setPointerValue targetPointer, register.getPointerValue(originPointer)

      when instructions.MOV_REG_MEM
        registerFrom = fetch8()
        memoryTo = fetch16()
        value = register.getPointerValue registerFrom
        memory.set2 memoryTo, value

      when instructions.MOV_MEM_REG
        memoryFrom = fetch16()
        registerTo = fetch8()
        register.setPointerValue registerTo, memory.get2(memoryFrom)

      when instructions.MOV_MEM_REG
        memoryFrom = fetch16()
        registerTo = fetch8()
        value = register.setPointerValue registerTo, memory.get2(memoryFrom)

      when instructions.ADD_REG_REG
        register.setValue 'acc', register.getPointerValue(fetch8()) + register.getPointerValue(fetch8())

      when instructions.JMP_NOT_EQ
        comparisonValue = fetch16()
        memoryTo = fetch16()
        if comparisonValue != register.getValue('acc')
          register.setValue 'ip', memoryTo

      when instructions.PSH_LIT
        push fetch16()

      when instructions.PSH_REG
        push register.getPointerValue fetch8()

      when instructions.POP
        register.setPointerValue fetch8(), pop()

      else
        throw new Error "Unknown instruction #{instruction.toString(16).padStart(2, '0')}"

  step = () =>
    execute fetch8()

  {
    step,
    register,
  }

module.exports = {
  CPU
}
