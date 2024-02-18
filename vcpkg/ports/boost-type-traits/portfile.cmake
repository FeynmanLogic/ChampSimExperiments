# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/type_traits
    REF boost-1.82.0
    SHA512 0ffabde32148936aea8564b45f64c55b4243b2d84f23b615efc6057d43a13da5ff2f8c757b09c1c29a7e2209b3449d2b0eebec370717e52bab9110d6903691e1
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})