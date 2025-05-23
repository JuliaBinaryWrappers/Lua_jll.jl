# Autogenerated wrapper script for Lua_jll for aarch64-unknown-freebsd
export liblua, lua, luac

using Readline_jll
JLLWrappers.@generate_wrapper_header("Lua")
JLLWrappers.@declare_library_product(liblua, "liblua.so")
JLLWrappers.@declare_executable_product(lua)
JLLWrappers.@declare_executable_product(luac)
function __init__()
    JLLWrappers.@generate_init_header(Readline_jll)
    JLLWrappers.@init_library_product(
        liblua,
        "lib/liblua.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@init_executable_product(
        lua,
        "bin/lua",
    )

    JLLWrappers.@init_executable_product(
        luac,
        "bin/luac",
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
