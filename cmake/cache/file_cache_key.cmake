
function(file_cache_key cache_key)
  ref_isvalid("${cache_key}")
  ans(isref)
  if(isref)
    json("${cache_key}")
    ans(cache_key)
  endif()
  checksum_string("${cache_key}")
  ans(key)
  oocmake(temp_dir)
  ans(temp_dir)
  set(file "${temp_dir}/file_cache/_${key}.cmake")
  return_ref(file)
endfunction()