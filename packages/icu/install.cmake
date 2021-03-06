# Install icu
include("${EP_SCRIPT_CONFIG}")
include("${GENERIC_CMAKE_ENVIRONMENT}")

if(WIN32)

  message(STATUS "Installing icu (Windows)")

  set(ICU_INCLUDE_DIR ${SOURCE_DIR}/include)
  if(EP_PLATFORM_BITS EQUAL 64)
    set(ICU_BIN_DIR ${SOURCE_DIR}/bin64)
    set(ICU_LIB_DIR ${SOURCE_DIR}/lib64)
  else()
    set(ICU_BIN_DIR ${SOURCE_DIR}/bin)
    set(ICU_LIB_DIR ${SOURCE_DIR}/lib)
  endif()

  execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory "${ICU_BIN_DIR}" "${OME_EP_BIN_DIR}"
                  WORKING_DIRECTORY ${BUILD_DIR}
                  RESULT_VARIABLE install_bin_result)
  execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory "${ICU_LIB_DIR}" "${OME_EP_LIB_DIR}"
                  WORKING_DIRECTORY ${BUILD_DIR}
                  RESULT_VARIABLE install_lib_result)
  execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory "${ICU_INCLUDE_DIR}" "${OME_EP_INCLUDE_DIR}"
                  WORKING_DIRECTORY ${BUILD_DIR}
                  RESULT_VARIABLE install_include_result)

  if (install_bin_result OR install_lib_result OR install_include_result)
    message(FATAL_ERROR "icu: install failed")
  endif()

else(WIN32)

  message(STATUS "Installing icu (Unix)")

  execute_process(COMMAND ${OME_MAKE_PROGRAM} install
                  WORKING_DIRECTORY ${BUILD_DIR}
                  RESULT_VARIABLE install_result)

  if (install_result)
    message(FATAL_ERROR "icu: install failed")
  endif()

endif(WIN32)
