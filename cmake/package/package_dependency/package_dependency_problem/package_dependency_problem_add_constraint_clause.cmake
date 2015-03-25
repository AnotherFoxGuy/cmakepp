
function(package_dependency_problem_add_constraint_clause problem positive negative reason)
  map_tryget(${dependency_problem} clauses)
  ans(clauses)
  map_tryget(${dependency_problem} reasons)
  ans(reasons)

  set(clause)

  foreach(package_handle ${negative})
    map_tryget(${package_handle} uri)
    ans(uri)
    list(APPEND clause "!${uri}")
  endforeach()
  foreach(package_handle ${positive})
    map_tryget(${package_handle} uri)
    ans(uri)
    list(APPEND clause "${uri}")
  endforeach()
  sequence_add("${clauses}" "${clause}")
  ans(ci)
  map_set(${reasons} "${ci}" "${reason}")
endfunction()