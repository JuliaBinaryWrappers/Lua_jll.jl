# Autogenerated wrapper script for Lua_jll for i686-linux-musl
export luac, liblua, lua

using Readline_jll
## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `luac`
const luac_splitpath = ["bin", "luac"]

# This will be filled out by __init__() for all products, as it must be done at runtime
luac_path = ""

# luac-specific global declaration
function luac(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', ENV[LIBPATH_env])
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(luac_path)
    end
end


# Relative path to `liblua`
const liblua_splitpath = ["lib", "liblua.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
liblua_path = ""

# liblua-specific global declaration
# This will be filled out by __init__()
liblua_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const liblua = "liblua.so"


# Relative path to `lua`
const lua_splitpath = ["bin", "lua"]

# This will be filled out by __init__() for all products, as it must be done at runtime
lua_path = ""

# lua-specific global declaration
function lua(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', ENV[LIBPATH_env])
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(lua_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"Lua")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # We first need to add to LIBPATH_list the libraries provided by Julia
    LIBPATH_list = [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)]
    append!.(Ref(PATH_list), (Readline_jll.PATH_list,))
    append!.(Ref(LIBPATH_list), (Readline_jll.LIBPATH_list,))

    global luac_path = normpath(joinpath(artifact_dir, luac_splitpath...))

    push!(PATH_list, dirname(luac_path))
    global liblua_path = normpath(joinpath(artifact_dir, liblua_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global liblua_handle = dlopen(liblua_path)
    push!(LIBPATH_list, dirname(liblua_path))

    global lua_path = normpath(joinpath(artifact_dir, lua_splitpath...))

    push!(PATH_list, dirname(lua_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

