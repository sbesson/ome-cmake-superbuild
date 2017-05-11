# yaml-cpp superbuild

# Set dependency list
ome_add_dependencies(yaml-cpp THIRD_PARTY_DEPENDENCIES boost gtest patch)

list(APPEND CONFIGURE_OPTIONS -Wno-dev --no-warn-unused-cli)
list(APPEND CONFIGURE_OPTIONS "-DGTEST_SOURCE=${CMAKE_BINARY_DIR}/gtest-source")
string(REPLACE ";" "^^" CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS}")

ExternalProject_Add(${EP_PROJECT}
  ${OME_EP_COMMON_ARGS}
  URL "https://github.com/jbeder/yaml-cpp/archive/release-0.5.3.tar.gz"
  URL_HASH "SHA512=5ed15fee3c6455c08e6bd8f74256b230f274ef18f8e144491e940640e41626517c7eaaf4a1f380c4179066a2a757c8a0f61878df9dc3caa15e37c4954be47fe0"
  SOURCE_DIR "${EP_SOURCE_DIR}"
  BINARY_DIR "${EP_BINARY_DIR}"
  INSTALL_DIR ""
  PATCH_COMMAND
    ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DPATCH_DIR:PATH=${CMAKE_CURRENT_LIST_DIR}/patches"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_PATCH}"
  CONFIGURE_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    "-DCONFIGURE_OPTIONS=${CONFIGURE_OPTIONS}"
    -P "${GENERIC_CMAKE_CONFIGURE}"
  BUILD_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_BUILD}"
  INSTALL_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_INSTALL}"
  TEST_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_BINARY_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_TEST}"
  DEPENDS
    ${EP_PROJECT}-prerequisites
)
