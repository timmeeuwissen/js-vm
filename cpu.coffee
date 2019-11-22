{ createRegister } = require './register'
instructions = require './instructions'

CPU = (memory) =>
  registerNames = [
    'ip', 'acc',
    'r1', 'r2', 'r3', 'r4',
    'r5', 'r6', 'r7', 'r8',
  ]

  register = createRegister registerNames

  fetch8 = () =>
    nextInstructionAddress = register.getValue 'ip'
    instruction = memory.getUint8 nextInstructionAddress
    register.setValue 'ip', nextInstructionAddress + 1
    instruction

  fetch16 = () =>
    nextInstructionAddress = register.getValue 'ip'
    instruction = memory.getUint16 nextInstructionAddress
    register.setValue 'ip', nextInstructionAddress + 2
    instruction

  execute = (instruction) =>
    switch instruction
      when instructions.MOV_LIT_R1 then register.setValue('r1', fetch16())
      when instructions.MOV_LIT_R2 then register.setValue('r2', fetch16())
      when instructions.ADD_REG_REG
        register.setValue 'acc', register.getPointerValue(fetch8()*2) + register.getPointerValue(fetch8()*2)
      else
        throw new Error "Unknown instruction #{instruction}"

  debug = () =>
    registerNames.forEach (name) =>
      console.log "#{name}: 0x#{register.getValue(name).toString(16).padStart(4, '0')}"


  step = () =>
    execute fetch8()

  {
    step,
    debug,
  }

module.exports = {
  CPU
}
