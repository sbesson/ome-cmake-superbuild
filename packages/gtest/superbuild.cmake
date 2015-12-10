# gtest superbuild

# Set dependency list
ome_add_dependencies(gtest)

# Notes:
# Installs cmake settings into lib/libgtest; could be deleted

set(CONFIGURE_OPTIONS -Wno-dev --no-warn-unused-cli -Dgtest_build_tests:BOOL=ON -Dgtest_build_samples:BOOL=ON)
string(REPLACE ";" "^^" CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS}")

ExternalProject_Add(${EP_PROJECT}
  ${BIOFORMATS_EP_COMMON_ARGS}
  URL "https://github.com/google/googletest/archive/release-1.7.0.tar.gz"
  URL_HASH "SHA512=c623d5720c4ed574e95158529872815ecff478c03bdcee8b79c9b042a603533f93fe55f939bcfe2cd745ce340fd626ad6d9a95981596f1a4d05053d874cd1dfc"
  SOURCE_DIR "${EP_SOURCE_DIR}"
  BINARY_DIR "${EP_SOURCE_DIR}"
  INSTALL_DIR ""
  CONFIGURE_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_SOURCE_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    "-DCONFIGURE_OPTIONS=${CONFIGURE_OPTIONS}"
    -P "${GENERIC_CMAKE_CONFIGURE}"
  BUILD_COMMAND ${CMAKE_COMMAND}
    "-DSOURCE_DIR:PATH=${EP_SOURCE_DIR}"
    "-DBUILD_DIR:PATH=${EP_SOURCE_DIR}"
    "-DCONFIG:INTERNAL=$<CONFIG>"
    "-DEP_SCRIPT_CONFIG:FILEPATH=${EP_SCRIPT_CONFIG}"
    -P "${GENERIC_CMAKE_BUILD}"
  INSTALL_COMMAND ""
  TEST_COMMAND ""
  DEPENDS
    ${EP_PROJECT}-prerequisites
)
