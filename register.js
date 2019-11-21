import {createMemory} from './memory';

export const createRegister = names => {
  const memory = createMemory(names.length * 2);

  const nameToPointer = names.reduce(
    (acc, name, index) => ({...acc, [name]: index * 2}),
    {}
  );

  const getPointerValue = index => memory.getUint16(index);

  const getValue = name => {
    if (!nameToPointer.hasOwnProperty(name)) {
      throw new Error(`Unknown name ${name} to obtain from register`);
    }
    return getPointerValue(nameToPointer[name]);
  }

  const setValue = (name, value) => {
    if (!nameToPointer.hasOwnProperty(name)) {
      throw new Error(`Unknown name ${name} to store in register`);
    }
    return memory.setUint16(nameToPointer[name], value);
  }

  return {
    getValue,
    setValue,
    getPointerValue,
  }
}
