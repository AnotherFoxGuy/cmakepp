function(test)
    file(WRITE "${test_dir}/file1.txt" "asd")
    file(WRITE "${test_dir}/file2.txt" "asd")
    file(WRITE "${test_dir}/file3.txt" "asd")

    assign(function_files = glob ("**.txt" --relative))
    message("dsxsdx ${function_files}")

    markdown_template_function_list("${function_files}")
    ans(res)

    message("XD ${res}")
endfunction()