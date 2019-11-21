import {createRegister} from './register';
import instructions from './instructions';

export const CPU = memory => {
  const registerNames = [
    'ip', 'acc',
    'r1', 'r2', 'r3', 'r4',
    'r5', 'r6', 'r7', 'r8',
  ];

  const register = createRegister(registerNames);

  const fetch8 = () => {
    const nextInstructionAddress = register.getValue('ip');
    const instruction = memory.getUint8(nextInstructionAddress);
    register.setValue('ip', nextInstructionAddress + 1);
    return instruction;
  }
  const fetch16 = () => {
    const nextInstructionAddress = register.getValue('ip');
    const instruction = memory.getUint16(nextInstructionAddress);
    register.setValue('ip', nextInstructionAddress + 2);
    return instruction;
  }

  const execute = instruction => {
    switch(instruction) {
      case instructions.MOV_LIT_R1: {
        register.setValue('r1', fetch16());
        return;
      }
      case instructions.MOV_LIT_R2: {
        register.setValue('r2', fetch16());
        return;
      }
      case instructions.ADD_REG_REG: {
        register.setValue('acc', register.getPointerValue(fetch8()*2) + register.getPointerValue(fetch8()*2));
        return;
      }
    }
  }

  const debug = () => {
    registerNames.forEach(name => {
      console.log(`${name}: 0x${register.getValue(name).toString(16).padStart(4, '0')}`);
    })
  }

  const step = () => {
    execute(fetch8());
  }

  return {
    step,
    debug,
  }

}
