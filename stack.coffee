requiredRegisters = ['sp', 'fp']

createStack = (memory, register) =>
  lastMemoryPosition = memory.ref.byteLength - 1

  register.setValue 'sp', lastMemoryPosition - 1
  register.setValue 'fp', lastMemoryPosition - 1

  push = (value) =>
    currentSP = register.getValue 'sp'
    memory.set2 currentSP, value
    register.setValue 'sp', currentSP - 2

  pop = () =>
    nextSP = (register.getValue 'sp') + 2
    register.setValue 'sp', nextSP
    memory.get2 nextSP

  debug = () =>
    currentSP = (register.getValue 'sp') + 2
    bytesOccupied = lastMemoryPosition + 1 - currentSP
    ahead = Array.from({length: bytesOccupied / 2}, (_, i) => memory.get2(currentSP + i * 2)).map (v) =>
      "0x#{v.toString(16).padStart(4, '0')}"
    console.log "Stack memory at 0x#{currentSP.toString(16).padStart(4, '0')} (#{bytesOccupied} bytes): #{ahead.join(' ')}"


  {
    push
    pop
    debug
  }

module.exports = {
  requiredRegisters,
  createStack,
}
