-- [Build and run]
-- $ xmake b game && xmake run

set_project("game")

set_defaultmode("debug")
add_rules("mode.debug", "mode.release")
set_toolchains("msvc")
set_languages("cxx23")
set_encodings("utf-8")
set_exceptions("none")
set_symbols("debug", "hidden")

add_defines("UNICODE", "_UNICODE")

add_cxxflags("-nologo", "-Oi", "-TP", "-fp:precise", "-Gm-", "-MP", "-FC", "-EHsc-", "-GR-", "-GF")
-- add_cxxflags("-nologo", "-Oi", "-TP", "-fp:precise", "-Gm-", "-MP", "-FC", "-GR-", "-GF")
-- Warnings
add_cxxflags("-W4", "-WX",
    "-wd4100", "-wd4101", "-wd4127", "-wd4146",
    "-wd4505",
    "-wd4456", "-wd4457")

if is_mode("debug") then
    add_cxxflags("-Od", "-MDd", "-Z7")
    add_defines("_DEBUG","DEBUG")
end

if is_mode("release") then
    add_cxxflags("-O2", "-MT", "-Z7")
    add_defines("NDEBUG")
end

target("massage_box")
    set_kind("binary")
    add_files("massage_box/*.cpp")
    add_syslinks("user32")
