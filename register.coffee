{ createMemory } = require './memory'

createRegister = (names) =>
  memory = createMemory(names.length * 2)

  nameToPointer = names.reduce(
    (acc, name, index) => ({...acc, [name]: index * 2}),
    {}
  );

  getPointerValue = (index) => memory.getUint16 index

  getValue = (name) =>
    if !nameToPointer.hasOwnProperty(name)
      throw new Error "Unknown name #{name} to obtain from register"
    getPointerValue nameToPointer[name]

  setValue = (name, value) =>
    if !nameToPointer.hasOwnProperty name
      throw new Error "Unknown name #{name} to store in register"
    memory.setUint16 nameToPointer[name], value

  return {
    getValue,
    setValue,
    getPointerValue,
  }

module.exports = {
  createRegister
}
