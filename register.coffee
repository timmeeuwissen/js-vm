{ createMemory} = require './memory'

createRegister = (names) =>
  registerByteLength = 2
  memory = createMemory(names.length * registerByteLength)

  indexToByte = (index) => index * registerByteLength;

  nameToPointer = names.reduce(
    (acc, name, index) => ({...acc, [name]: indexToByte(index)}),
    {}
  );

  getPointerValue = (index, byByte) => memory.get2 (if byByte then index else indexToByte(index))
  setPointerValue = (index, value, byByte) => memory.set2 (if byByte then index else indexToByte(index)), value

  getValue = (name) =>
    if !nameToPointer.hasOwnProperty(name)
      throw new Error "Unknown name #{name} to obtain from register"
    getPointerValue nameToPointer[name], true

  setValue = (name, value) =>
    if !nameToPointer.hasOwnProperty name
      throw new Error "Unknown name #{name} to store in register"
    setPointerValue nameToPointer[name], value, true

  debug = () =>
    names.forEach (name) =>
      console.log "#{name}: 0x#{getValue(name).toString(16).padStart(4, '0')}"

  {
    getValue,
    setValue,
    getPointerValue,
    setPointerValue,
    debug,
  }

module.exports = {
  createRegister
}
