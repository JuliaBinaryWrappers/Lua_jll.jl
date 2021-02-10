# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule Lua_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("Lua")
JLLWrappers.@generate_main_file("Lua", UUID("a4086b1d-a96a-5d6b-8e4f-2030e6f25ba6"))
end  # module Lua_jll
