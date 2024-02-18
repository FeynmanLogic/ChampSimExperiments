vcpkg_download_distfile(
    SYSCTL_REMOVED_PATCH
    URLS https://github.com/slembcke/Chipmunk2D/commit/9a051e6fb970c7afe09ce2d564c163b81df050a8.patch?full_index=1
    SHA512 54ec8766529d301ea35e8e0e7f7e9803101454d0f3655f7be87b6c81414a71e6fd269c14cf1d89902eebea78bb20526b0e4da4c53cf660d169ebabe46dadd059
    FILENAME 9a051e6fb970c7afe09ce2d564c163b81df050a8.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO slembcke/Chipmunk2D
    REF 87340c216bf97554dc552371bbdecf283f7c540e
    SHA512 9094017755e9c140aa5bf8a1b5502077ae4fb2b0a3e12f1114e86d8591a6188f89822ecc578a2b5e95f61c555018f1b3273fe50e833fe2daf30e94b180a3d07c
    HEAD_REF master
    PATCHES
        "${SYSCTL_REMOVED_PATCH}"
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" KEYSTONE_BUILD_STATIC)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" KEYSTONE_BUILD_SHARED)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_DEMOS=OFF
        -DBUILD_SHARED=${KEYSTONE_BUILD_SHARED}
        -DBUILD_STATIC=${KEYSTONE_BUILD_STATIC}
        -DINSTALL_STATIC=${KEYSTONE_BUILD_STATIC}
)

vcpkg_cmake_install()

if (NOT VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL debug)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
endif()

file(GLOB DLLS "${CURRENT_PACKAGES_DIR}/lib/*.dll")
if(DLLS)
    file(COPY ${DLLS} DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
    file(REMOVE ${DLLS})
endif()

file(INSTALL
    "${SOURCE_PATH}/include/chipmunk"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include"
)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)