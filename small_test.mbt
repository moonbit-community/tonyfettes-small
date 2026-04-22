///|
test "small_bytes/less-than-8" {
  let sb = @small.bytes([1, 2, 3, 4, 5, 6, 7])
  json_inspect(sb.length(), content=7)
  json_inspect(sb[0], content=1)
  json_inspect(sb[6], content=7)
  let sb2 = sb[2:6]
  json_inspect(sb2.length(), content=4)
  json_inspect(sb2[0], content=3)
  json_inspect(sb2[3], content=6)
  let sb3 = sb[:4]
  json_inspect(sb3.length(), content=4)
  json_inspect(sb3[0], content=1)
  json_inspect(sb3[3], content=4)
  let sb4 = sb[3:]
  json_inspect(sb4.length(), content=4)
  json_inspect(sb4[0], content=4)
  json_inspect(sb4[3], content=7)
}

///|
test "small_bytes/less-than-16" {
  let sb = @small.bytes([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
  json_inspect(sb.length(), content=15)
  json_inspect(sb[0], content=1)
  json_inspect(sb[1], content=2)
  json_inspect(sb[2], content=3)
  json_inspect(sb[3], content=4)
  json_inspect(sb[4], content=5)
  json_inspect(sb[5], content=6)
  json_inspect(sb[6], content=7)
  json_inspect(sb[7], content=8)
  json_inspect(sb[8], content=9)
  json_inspect(sb[9], content=10)
  json_inspect(sb[13], content=14)
  json_inspect(sb[14], content=15)
  let sb4 = sb[5:10]
  json_inspect(sb4.length(), content=5)
  json_inspect(sb4[0], content=6)
  json_inspect(sb4[1], content=7)
  json_inspect(sb4[2], content=8)
  json_inspect(sb4[3], content=9)
  json_inspect(sb4[4], content=10)
  let sb5 = sb[2:12]
  json_inspect(sb5.length(), content=10)
  json_inspect(sb5[0], content=3)
  json_inspect(sb5[1], content=4)
  json_inspect(sb5[2], content=5)
  json_inspect(sb5[3], content=6)
  json_inspect(sb5[4], content=7)
  json_inspect(sb5[5], content=8)
  json_inspect(sb5[6], content=9)
  json_inspect(sb5[7], content=10)
  json_inspect(sb5[8], content=11)
  json_inspect(sb5[9], content=12)
  let sb6 = sb[10:15]
  json_inspect(sb6.length(), content=5)
  json_inspect(sb6[0], content=11)
  json_inspect(sb6[1], content=12)
  json_inspect(sb6[2], content=13)
  json_inspect(sb6[3], content=14)
  json_inspect(sb6[4], content=15)
}

///|
test "small_bytes/more-than-16" {
  let sb = @small.bytes([
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  ])
  json_inspect(sb.length(), content=20)
  json_inspect(sb[0], content=1)
  json_inspect(sb[19], content=20)
  let sb1 = sb[10:15]
  json_inspect(sb1.length(), content=5)
  json_inspect(sb1[0], content=11)
  json_inspect(sb1[4], content=15)
  let sb2 = sb[10:]
  json_inspect(sb2.length(), content=10)
  json_inspect(sb2[0], content=11)
  json_inspect(sb2[9], content=20)
  let sb3 = sb[:10]
  json_inspect(sb3.length(), content=10)
  json_inspect(sb3[0], content=1)
  json_inspect(sb3[9], content=10)
  let sb4 = sb[1:19]
  json_inspect(sb4.length(), content=18)
  json_inspect(sb4[0], content=2)
  json_inspect(sb4[17], content=19)
}

///|
test "small_bytes/bytes_view" {
  let b : Bytes = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
  ]
  let sb = @small.bytes(b[:16])
  json_inspect(sb.length(), content=16)
  json_inspect(sb[0], content=1)
  json_inspect(sb[3], content=4)
}

///|
test "small_bytes/equality" {
  let sb1 = @small.bytes([1, 2, 3, 4, 5, 6, 7])
  let sb2 = @small.bytes([1, 2, 3, 4, 5, 6, 7])
  let sb3 = @small.bytes([1, 2, 3, 4, 5, 6, 8])
  let sb4 = @small.bytes([1, 2, 3, 4, 5, 6, 7, 8])
  let sb5 = @small.bytes([1, 2, 3, 4, 5, 6, 7])
  json_inspect(sb1 == sb2, content=true)
  json_inspect(sb1 == sb3, content=false)
  json_inspect(sb1 == sb4, content=false)
  json_inspect(sb1 == sb5, content=true)
}

///|
test "bench/test" {
  let text : Bytes = b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer varius metus ac nulla ornare, ac dictum ante tincidunt. Praesent quis fringilla neque. Vestibulum eu placerat leo. Phasellus dictum turpis sit amet odio faucibus maximus. Proin imperdiet sit amet nulla in blandit. Nulla feugiat lorem ac ultrices tempor. Donec eu nunc at leo ullamcorper consequat. Sed tincidunt tortor sed libero consectetur vulputate. Nam rutrum, leo ut tempus aliquam, eros velit porttitor leo, sed sollicitudin erat lectus eu magna. Suspendisse blandit diam vitae quam tempor, et sagittis nibh vestibulum. Cras pulvinar velit elementum elit tristique, at volutpat purus eleifend. Integer lacinia nisi turpis, non dignissim leo pulvinar sed. Vivamus a arcu mi. Pellentesque id sem porttitor, tempor turpis a, efficitur ligula. In tristique lectus bibendum commodo tristique. Sed sodales neque quis ex ultrices ultricies. Donec commodo mauris eleifend, ornare orci id, imperdiet nibh. Fusce congue ac nibh ac vehicula. Donec euismod sed dolor at facilisis. In justo nisi, placerat eget rhoncus sed, euismod vel justo. Proin accumsan diam nec libero dignissim, eget sagittis dui laoreet. Duis laoreet, nunc sed dignissim consectetur, arcu metus rutrum dui, ut rutrum tortor diam in leo. Nulla ut sollicitudin nunc. Pellentesque nec varius lectus. Aliquam nec dolor sagittis libero malesuada bibendum. Nam rhoncus maximus metus, posuere aliquet leo hendrerit a. Maecenas ac faucibus eros. Pellentesque venenatis bibendum mi ac mollis. Vivamus lacinia vestibulum laoreet. Vivamus eu efficitur metus. Suspendisse fermentum metus magna, a pretium dui dapibus vitae. Cras maximus convallis semper. Morbi consectetur consequat nisi, eu dapibus turpis venenatis nec. Quisque nec turpis lectus. Cras a lacinia lorem. Donec bibendum augue vel enim dictum, in lobortis ante iaculis. Vivamus euismod tortor non tellus porttitor egestas. Morbi sed tempor lorem. Donec porta tristique turpis ut mollis. In quis nibh ut lorem condimentum rhoncus ut non ante. Nunc faucibus turpis non eros commodo, quis vestibulum lorem dictum. Donec egestas elementum arcu et elementum. Vestibulum sed volutpat turpis, eu ornare orci. Duis eleifend quam vitae lectus consectetur, ac egestas neque iaculis. Curabitur ut nibh ac elit tincidunt ultrices nec eu purus. Mauris lacus nisi, ultrices in dolor sodales, pulvinar hendrerit diam. Mauris nec gravida dolor. Etiam feugiat magna interdum mauris sollicitudin, sit amet aliquet lectus viverra. In orci nunc, rhoncus eu dignissim in, molestie ac quam. Mauris pretium pharetra turpis eu bibendum. Donec congue posuere quam et aliquam. Integer at magna sit amet leo tristique ornare. Nulla magna felis, dignissim non varius nec, semper ut dui. Quisque quis augue vel augue ullamcorper tempor at et velit. Integer ac est arcu. Duis leo dolor, facilisis ullamcorper justo at, faucibus convallis nunc. Maecenas vel dui ut ligula finibus dapibus. Vestibulum cursus suscipit nisi, in interdum diam faucibus in. Etiam varius luctus magna lacinia tincidunt."
  let haystack = []
  for start = 0, view = text[:] {
    match view {
      [] => {
        haystack.push(text[start:])
        break
      }
      [b' ', .. rest] => {
        haystack.push(text[start:view.start_offset()])
        continue rest.start_offset(), rest
      }
      [_, .. rest] => continue start, rest
    }
  }
  let needle : BytesView = b"magna"
  fn find(haystack : Array[BytesView], needle : BytesView) -> Int? {
    for i, word in haystack {
      if word == needle {
        return Some(i)
      }
    }
    None
  }

  let sso_haystack = haystack.map(w => @small.bytes(w))
  let sso_needle = @small.bytes(needle)
  fn sso_find(haystack : Array[SmallBytes], needle : SmallBytes) -> Int? {
    for i, word in haystack {
      if word == needle {
        return Some(i)
      }
    }
    None
  }
  json_inspect(find(haystack, needle), content=[357])
  json_inspect(sso_find(sso_haystack, sso_needle), content=[357])
}

///|
/// [tonyfettes/small] bench small_test.mbt:152 ("bench/split-words") ok
/// name time (mean ± σ)         range (min … max) 
/// loop    1.65 µs ±   0.01 µs     1.64 µs …   1.67 µs  in 10 ×  60150 runs
/// sso     1.32 µs ±   0.01 µs     1.31 µs …   1.34 µs  in 10 ×  75373 runs
/// Total tests: 1, passed: 1, failed: 0.
test "bench/split-words" (b : @bench.T) {
  let text : Bytes = b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer varius metus ac nulla ornare, ac dictum ante tincidunt. Praesent quis fringilla neque. Vestibulum eu placerat leo. Phasellus dictum turpis sit amet odio faucibus maximus. Proin imperdiet sit amet nulla in blandit. Nulla feugiat lorem ac ultrices tempor. Donec eu nunc at leo ullamcorper consequat. Sed tincidunt tortor sed libero consectetur vulputate. Nam rutrum, leo ut tempus aliquam, eros velit porttitor leo, sed sollicitudin erat lectus eu magna. Suspendisse blandit diam vitae quam tempor, et sagittis nibh vestibulum. Cras pulvinar velit elementum elit tristique, at volutpat purus eleifend. Integer lacinia nisi turpis, non dignissim leo pulvinar sed. Vivamus a arcu mi. Pellentesque id sem porttitor, tempor turpis a, efficitur ligula. In tristique lectus bibendum commodo tristique. Sed sodales neque quis ex ultrices ultricies. Donec commodo mauris eleifend, ornare orci id, imperdiet nibh. Fusce congue ac nibh ac vehicula. Donec euismod sed dolor at facilisis. In justo nisi, placerat eget rhoncus sed, euismod vel justo. Proin accumsan diam nec libero dignissim, eget sagittis dui laoreet. Duis laoreet, nunc sed dignissim consectetur, arcu metus rutrum dui, ut rutrum tortor diam in leo. Nulla ut sollicitudin nunc. Pellentesque nec varius lectus. Aliquam nec dolor sagittis libero malesuada bibendum. Nam rhoncus maximus metus, posuere aliquet leo hendrerit a. Maecenas ac faucibus eros. Pellentesque venenatis bibendum mi ac mollis. Vivamus lacinia vestibulum laoreet. Vivamus eu efficitur metus. Suspendisse fermentum metus magna, a pretium dui dapibus vitae. Cras maximus convallis semper. Morbi consectetur consequat nisi, eu dapibus turpis venenatis nec. Quisque nec turpis lectus. Cras a lacinia lorem. Donec bibendum augue vel enim dictum, in lobortis ante iaculis. Vivamus euismod tortor non tellus porttitor egestas. Morbi sed tempor lorem. Donec porta tristique turpis ut mollis. In quis nibh ut lorem condimentum rhoncus ut non ante. Nunc faucibus turpis non eros commodo, quis vestibulum lorem dictum. Donec egestas elementum arcu et elementum. Vestibulum sed volutpat turpis, eu ornare orci. Duis eleifend quam vitae lectus consectetur, ac egestas neque iaculis. Curabitur ut nibh ac elit tincidunt ultrices nec eu purus. Mauris lacus nisi, ultrices in dolor sodales, pulvinar hendrerit diam. Mauris nec gravida dolor. Etiam feugiat magna interdum mauris sollicitudin, sit amet aliquet lectus viverra. In orci nunc, rhoncus eu dignissim in, molestie ac quam. Mauris pretium pharetra turpis eu bibendum. Donec congue posuere quam et aliquam. Integer at magna sit amet leo tristique ornare. Nulla magna felis, dignissim non varius nec, semper ut dui. Quisque quis augue vel augue ullamcorper tempor at et velit. Integer ac est arcu. Duis leo dolor, facilisis ullamcorper justo at, faucibus convallis nunc. Maecenas vel dui ut ligula finibus dapibus. Vestibulum cursus suscipit nisi, in interdum diam faucibus in. Etiam varius luctus magna lacinia tincidunt."
  let haystack = []
  for start = 0, view = text[:] {
    match view {
      [] => {
        haystack.push(text[start:])
        break
      }
      [b' ', .. rest] => {
        haystack.push(text[start:view.start_offset()])
        continue rest.start_offset(), rest
      }
      [_, .. rest] => continue start, rest
    }
  }
  let needle : BytesView = b"magna"
  fn find(haystack : Array[BytesView], needle : BytesView) -> Int? {
    for i, word in haystack {
      if word == needle {
        return Some(i)
      }
    }
    None
  }

  let sso_haystack = haystack.map(w => @small.bytes(w))
  let sso_needle = @small.bytes(needle)
  fn sso_find(haystack : Array[SmallBytes], needle : SmallBytes) -> Int? {
    for i, word in haystack {
      if word == needle {
        return Some(i)
      }
    }
    None
  }

  json_inspect(find(haystack, needle), content=[357])
  json_inspect(sso_find(sso_haystack, sso_needle), content=[357])
  b.bench(name="loop", () => {
    for word in haystack {
      if word == needle {
        break
      }
    }
  })
  b.bench(name="sso", () => {
    for word in sso_haystack {
      if word == sso_needle {
        break
      }
    }
  })
}
