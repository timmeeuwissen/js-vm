createMemory = (sizeInBytes) =>
  ref = new DataView(new ArrayBuffer sizeInBytes)

  get = (index) => ref.getUint8(index)
  get2 = (index) => ref.getUint16(index)
  set = (index, value) => ref.setUint8(index, value)
  set2 = (index, value) => ref.setUint16(index, value)

  debug = (address, bytes = 8) =>
    ahead = Array.from({length: bytes}, (_, i) => get(address + i)).map (v) =>
      "0x#{v.toString(16).padStart(2, '0')}"
    console.log "memory at 0x#{address.toString(16).padStart(4, '0')} (#{bytes} bytes): #{ahead.join(' ')}"

  { ref, get, get2, set, set2, debug }

module.exports = {
  createMemory
}
