function(semver_constraint_compile constraint)
  set(ops "\\(\\)\\|,!=~><")

  if("${constraint}" STREQUAL "*")
    set(constraint ">=0.0.0")
  endif()
  string(REGEX REPLACE ">=([^${ops}]+)" "(>\\1|=\\1)" constraint
                       "${constraint}")
  string(REGEX REPLACE "<=([^${ops}]+)" "(<\\1|=\\1)" constraint
                       "${constraint}")

  string(REPLACE "!" ";NOT;" constraint "${constraint}")
  string(REPLACE "," ";AND;" constraint "${constraint}")
  string(REPLACE "|" ";OR;" constraint "${constraint}")
  string(REPLACE ")" ";);" constraint "${constraint}")
  string(REPLACE "(" ";(;" constraint "${constraint}")
  set(elements ${constraint})
  if(elements)
    list(REMOVE_DUPLICATES elements)
    list(
      REMOVE_ITEM
      elements
      "AND"
      "OR"
      "NOT"
      "("
      ")")
  endif()
  foreach(element ${elements})
    semver_constraint_element_isvalid(${element})
    ans(isvalid)
    if(NOT isvalid)
      return()
    endif()
  endforeach()
  # message("constraint ${constraint}") message("elements ${elements}")
  nav(compiled_constraint.template "${constraint}")
  nav(compiled_constraint.elements "${elements}")
  map_set_special(${compiled_constraint} "semver_constraint" true)
  return(${compiled_constraint})

endfunction()
