function(test)
  compile_tool(
    "testXDXD123"
    "
    #include <iostream>
    int main(int argc, const char ** argv){
        std::cout<< \"echo(hello)\";
        return 0;
    }")
  testxdxd123()
  ans(res)

  assert(${res} EQUALS "echo(hello)")

endfunction()
