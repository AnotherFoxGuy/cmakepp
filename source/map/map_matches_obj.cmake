# returns true if actual has all properties (and recursive properties) that
# expected has
function(map_match_obj actual expected)
  obj("${actual}")
  ans(actual)
  obj("${expected}")
  ans(expected)
  map_match("${actual}" "${expected}")
  return_ans()
endfunction()
