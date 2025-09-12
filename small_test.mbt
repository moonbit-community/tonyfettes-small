///|
test "small_bytes/less-than-8" {
  let sb = @small.bytes([1, 2, 3, 4, 5, 6, 7])
  @json.inspect(sb.length(), content=7)
  @json.inspect(sb[0], content=1)
  @json.inspect(sb[6], content=7)
  let sb2 = sb[2:6]
  @json.inspect(sb2.length(), content=4)
  @json.inspect(sb2[0], content=3)
  @json.inspect(sb2[3], content=6)
  let sb3 = sb[:4]
  @json.inspect(sb3.length(), content=4)
  @json.inspect(sb3[0], content=1)
  @json.inspect(sb3[3], content=4)
  let sb4 = sb[3:]
  @json.inspect(sb4.length(), content=4)
  @json.inspect(sb4[0], content=4)
  @json.inspect(sb4[3], content=7)
}

///|
test "small_bytes/less-than-16" {
  let sb = @small.bytes([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
  @json.inspect(sb.length(), content=15)
  @json.inspect(sb[0], content=1)
  @json.inspect(sb[1], content=2)
  @json.inspect(sb[2], content=3)
  @json.inspect(sb[3], content=4)
  @json.inspect(sb[4], content=5)
  @json.inspect(sb[5], content=6)
  @json.inspect(sb[6], content=7)
  @json.inspect(sb[7], content=8)
  @json.inspect(sb[8], content=9)
  @json.inspect(sb[9], content=10)
  @json.inspect(sb[13], content=14)
  @json.inspect(sb[14], content=15)
  let sb4 = sb[5:10]
  @json.inspect(sb4.length(), content=5)
  @json.inspect(sb4[0], content=6)
  @json.inspect(sb4[1], content=7)
  @json.inspect(sb4[2], content=8)
  @json.inspect(sb4[3], content=9)
  @json.inspect(sb4[4], content=10)
  let sb5 = sb[2:12]
  @json.inspect(sb5.length(), content=10)
  @json.inspect(sb5[0], content=3)
  @json.inspect(sb5[1], content=4)
  @json.inspect(sb5[2], content=5)
  @json.inspect(sb5[3], content=6)
  @json.inspect(sb5[4], content=7)
  @json.inspect(sb5[5], content=8)
  @json.inspect(sb5[6], content=9)
  @json.inspect(sb5[7], content=10)
  @json.inspect(sb5[8], content=11)
  @json.inspect(sb5[9], content=12)
  let sb6 = sb[10:15]
  @json.inspect(sb6.length(), content=5)
  @json.inspect(sb6[0], content=11)
  @json.inspect(sb6[1], content=12)
  @json.inspect(sb6[2], content=13)
  @json.inspect(sb6[3], content=14)
  @json.inspect(sb6[4], content=15)
}

///|
test "small_bytes/more-than-16" {
  let sb = @small.bytes([
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  ])
  @json.inspect(sb.length(), content=20)
  @json.inspect(sb[0], content=1)
  @json.inspect(sb[19], content=20)
  let sb1 = sb[10:15]
  @json.inspect(sb1.length(), content=5)
  @json.inspect(sb1[0], content=11)
  @json.inspect(sb1[4], content=15)
  let sb2 = sb[10:]
  @json.inspect(sb2.length(), content=10)
  @json.inspect(sb2[0], content=11)
  @json.inspect(sb2[9], content=20)
  let sb3 = sb[:10]
  @json.inspect(sb3.length(), content=10)
  @json.inspect(sb3[0], content=1)
  @json.inspect(sb3[9], content=10)
  let sb4 = sb[1:19]
  @json.inspect(sb4.length(), content=18)
  @json.inspect(sb4[0], content=2)
  @json.inspect(sb4[17], content=19)
}

///|
test "small_bytes/bytes_view" {
  let b : Bytes = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
  ]
  let sb = @small.bytes(b[:16])
  @json.inspect(sb.length(), content=16)
  @json.inspect(sb[0], content=1)
  @json.inspect(sb[3], content=4)
}
