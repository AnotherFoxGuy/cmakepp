function(json2 input)

  json2_definition()
  ans(lang)
  language_initialize(${lang})
  address_set(json2_language_definition "${lang}")
  function(json2 input)
    checksum_string("${input}")
    ans(ck)
    file_cache_return_hit("${ck}")
    address_get(json2_language_definition)
    ans(lang)
    map_new()
    ans(ctx)
    map_set(${ctx} input "${input}")
    map_set(${ctx} def "json")
    obj_setprototype(${ctx} "${lang}")

    # lang2(output json2 input "${input}" def "json")

    lang(output ${ctx})
    ans(res)
    file_cache_update("${ck}" ${res})
    return_ref(res)
  endfunction()
  json2("${input}")
  return_ans()
endfunction()
