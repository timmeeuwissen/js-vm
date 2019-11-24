requiredRegisters = ['sp', 'fp']

createStack = (memory, register) =>
  lastMemoryPosition = memory.ref.byteLength - 1

  register.setValue 'sp', lastMemoryPosition - 1
  register.setValue 'fp', lastMemoryPosition - 1

  stackFrameSize = 0

  push = (value) =>
    currentSP = register.getValue 'sp'
    memory.set2 currentSP, value
    register.setValue 'sp', currentSP - 2
    stackFrameSize += 2

  pop = () =>
    nextSP = (register.getValue 'sp') + 2
    register.setValue 'sp', nextSP
    stackFrameSize -= 2
    memory.get2 nextSP

  pushRegister = () =>
    register.getCluster('generalPurpose').forEach (registerName) =>
      push register.getValue registerName
    push register.getValue 'ip'
    push stackFrameSize + 2
    register.setValue 'fp', register.getValue 'sp'
    stackFrameSize = 0

  popRegister = () =>
    framePointerAddress = register.getValue 'fp'
    register.setValue 'sp', framePointerAddress
    stackFrameSize = pop()
    restoredStackFrameSize = stackFrameSize
    register.setValue 'ip', pop()
    register.getCluster('generalPurpose').reverse().forEach (registerName) =>
      register.setValue registerName pop()

    callArgs = pop()
    [0...callArgs].foreach pop

    register.setValue 'fp', framePointerAddress + restoredStackFrameSize


  debug = () =>
    currentSP = (register.getValue 'sp') + 2
    bytesOccupied = lastMemoryPosition + 1 - currentSP
    ahead = Array.from({length: bytesOccupied / 2}, (_, i) => memory.get2(currentSP + i * 2)).map (v) =>
      "0x#{v.toString(16).padStart(4, '0')}"
    console.log "Stack memory at 0x#{currentSP.toString(16).padStart(4, '0')} (#{bytesOccupied} bytes): #{ahead.join(' ')}"


  {
    push
    pop
    pushRegister
    popRegister
    debug
  }

module.exports = {
  requiredRegisters,
  createStack,
}
