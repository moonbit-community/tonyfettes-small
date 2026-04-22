///|
#valtype
struct SmallBytes {
  buf : Bytes?
  off : UInt64
  len : UInt64
}

///|
pub fn bytes(bytes : BytesView) -> SmallBytes {
  let old_len = bytes.length()
  if old_len < 8 {
    let off = for i = 0, off = 0UL; i < old_len; {
      let b = bytes.unsafe_get(i)
      continue i + 1, off | (b.to_uint64() << (i * 8))
    } nobreak {
      off
    }
    let len = old_len.to_uint64() << 56
    SmallBytes::{ buf: None, off, len }
  } else if old_len < 16 {
    let new_off = bytes.unsafe_get(0).to_uint64() |
      (bytes.unsafe_get(1).to_uint64() << 8) |
      (bytes.unsafe_get(2).to_uint64() << 16) |
      (bytes.unsafe_get(3).to_uint64() << 24) |
      (bytes.unsafe_get(4).to_uint64() << 32) |
      (bytes.unsafe_get(5).to_uint64() << 40) |
      (bytes.unsafe_get(6).to_uint64() << 48) |
      (bytes.unsafe_get(7).to_uint64() << 56)
    let new_len = for i = 8, new_len = 0UL; i < old_len; {
      let b = bytes.unsafe_get(i)
      continue i + 1, new_len | (b.to_uint64() << ((i - 8) * 8))
    } nobreak {
      new_len
    }
    let len = (old_len.to_uint64() << 56) | new_len
    SmallBytes::{ buf: None, off: new_off, len }
  } else {
    let old_buf = bytes.data()
    if old_len <= old_buf.length() / 2 {
      let new_buf = bytes.to_bytes()
      SmallBytes::{ buf: Some(new_buf), off: 0, len: old_len.to_uint64() }
    } else {
      SmallBytes::{
        buf: Some(old_buf),
        off: bytes.start_offset().to_uint64(),
        len: old_len.to_uint64(),
      }
    }
  }
}

///|
pub fn SmallBytes::length(self : SmallBytes) -> Int {
  match self.buf {
    None => ((self.len & 0xFF00000000000000) >> 56).to_int()
    Some(_) => self.len.to_int()
  }
}

///|
pub fn SmallBytes::op_as_view(
  self : SmallBytes,
  start? : Int = 0,
  end? : Int,
) -> SmallBytes {
  match self.buf {
    None => {
      let old_len = self.len
      let sem_len = ((old_len & 0xFF00000000000000) >> 56).to_int()
      let end = match end {
        None => sem_len
        Some(e) => e
      }
      guard start >= 0 && end >= start && end <= sem_len else {
        abort("SmallBytes::op_as_view: invalid range")
      }
      if start < 8 {
        let bits = start * 8
        let mask = (1UL << bits) - 1
        let new_off = ((old_len & mask) << (64 - bits)) | (self.off >> bits)
        let new_len = ((old_len & 0x00FFFFFFFFFFFFFF) >> bits) |
          ((end - start).to_uint64() << 56)
        SmallBytes::{ buf: None, off: new_off, len: new_len }
      } else {
        let bits = (start - 8) * 8
        let new_off = (old_len & 0x00FFFFFFFFFFFFFF) >> bits
        let new_len = (end - start).to_uint64() << 56
        SmallBytes::{ buf: None, off: new_off, len: new_len }
      }
    }
    Some(buf) => {
      let old_len = self.len.to_int()
      let end = match end {
        None => old_len
        Some(e) => e
      }
      guard start >= 0 && end >= start && end <= old_len else {
        abort("SmallBytes::op_as_view: invalid range")
      }
      let sem_len = end - start
      if sem_len < 8 {
        let new_off = for i = 0, off = 0UL; i < sem_len; {
          let b = buf.unsafe_get(self.off.to_int() + start + i)
          continue i + 1, off | (b.to_uint64() << (i * 8))
        } nobreak {
          off
        }
        let new_len = sem_len.to_uint64() << 56
        SmallBytes::{ buf: None, off: new_off, len: new_len }
      } else if sem_len < 16 {
        let new_off = buf.unsafe_get(self.off.to_int() + start).to_uint64() |
          (buf.unsafe_get(self.off.to_int() + start + 1).to_uint64() << 8) |
          (buf.unsafe_get(self.off.to_int() + start + 2).to_uint64() << 16) |
          (buf.unsafe_get(self.off.to_int() + start + 3).to_uint64() << 24) |
          (buf.unsafe_get(self.off.to_int() + start + 4).to_uint64() << 32) |
          (buf.unsafe_get(self.off.to_int() + start + 5).to_uint64() << 40) |
          (buf.unsafe_get(self.off.to_int() + start + 6).to_uint64() << 48) |
          (buf.unsafe_get(self.off.to_int() + start + 7).to_uint64() << 56)
        let new_len = for i = 8, new_len = 0UL; i < sem_len; {
          let b = buf.unsafe_get(self.off.to_int() + start + i)
          continue i + 1, new_len | (b.to_uint64() << ((i - 8) * 8))
        } nobreak {
          new_len
        }
        let new_len = (sem_len.to_uint64() << 56) | new_len
        SmallBytes::{ buf: None, off: new_off, len: new_len }
      } else {
        SmallBytes::{
          buf: Some(buf),
          off: self.off + start.to_uint64(),
          len: sem_len.to_uint64(),
        }
      }
    }
  }
}

///|
pub fn SmallBytes::op_get(self : SmallBytes, index : Int) -> Byte {
  guard index >= 0 && index < self.length() else {
    abort("SmallBytes::op_get: index out of bounds")
  }
  match self.buf {
    None =>
      if index < 8 {
        ((self.off >> (index * 8)) & 0xFF).to_byte()
      } else {
        ((self.len >> ((index - 8) * 8)) & 0xFF).to_byte()
      }
    Some(buf) => buf.unsafe_get(self.off.to_int() + index)
  }
}

///|
pub impl Eq for SmallBytes with equal(self : SmallBytes, other : SmallBytes) -> Bool {
  match self.buf {
    None => self.off == other.off && self.len == other.len
    Some(b1) => {
      let self_len = self.len.to_int()
      let other_len = other.len.to_int()
      if self_len != other_len {
        return false
      }
      let b2 = other.buf.unwrap()
      let self_off = self.off.to_int()
      let other_off = other.off.to_int()
      for i in 0..<self_len {
        if b1.unsafe_get(self_off + i) != b2.unsafe_get(other_off + i) {
          break false
        }
      } nobreak {
        true
      }
    }
  }
}
