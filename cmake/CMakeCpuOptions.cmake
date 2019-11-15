cmake_minimum_required (VERSION 3.10)

###############################################################
#
# Options area 
#
# -mavx -mavx2 -mfma -msse2 -msse3 -mssse3 -msse4.1 -msse4.2
#
#
# TODO: 
#  1. support debug and release
#  2. support NEON 
#
#
#

# Can be useful for cross-compiling
# Setting this to YES would allow you to tweak flags such as WITH_SSE3
# These flags are ignored otherwise
option(WITH_CUSTOM_CONFIGURATION "Should use user-defined processor configuration instead of auto-detecting one" NO)

if (WITH_CUSTOM_CONFIGURATION)
    message(STATUS "Will use user-defined configuration (cross-compile)")
    option(WITH_SSE "Should compile with SSE" YES)
    if (WITH_SSE)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse2")
        add_definitions(-DWITH_SSE)
    endif ()

    option(WITH_SSE3 "Should compile with SSE3" YES)
    if (WITH_SSE3)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse3")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse3")
        add_definitions(-DWITH_SSE3)
    endif ()

    option(WITH_SSE4_1 "Should compile with SSE4_1" YES)
    if (WITH_SSE4_1)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse4.1")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse4.1")
        add_definitions(-DWITH_SSE4_1)
    endif ()

    option(WITH_SSE4_2 "Should compile with SSE4_2" YES)
    if (WITH_SSE4_2)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse4.2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse4.2")
        add_definitions(-DWITH_SSE4_2)
    endif ()

    option(WITH_AVX "Should compile with AVX" YES)
    if (WITH_AVX)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mavx")
        add_definitions(-DWITH_AVX)
    endif ()

    option(WITH_AVX2 "Should compile with AVX2" YES)
    if (WITH_AVX2)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mavx2")
        add_definitions(-DWITH_AVX2)
    endif ()

    option(WITH_FMA "Should compile with FMA" YES)
    if (WITH_FMA)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfma")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfma")
        add_definitions(-DWITH_FMA)
    endif ()
else ()
    message(STATUS "Will autodetect processor configuration")

    # first, detect SSE and SSE2
    cmake_host_system_information(RESULT HAS_SSE QUERY HAS_SSE)
    cmake_host_system_information(RESULT HAS_SSE2 QUERY HAS_SSE2)

    # next, determine what other options are available
    IF (CMAKE_SYSTEM_NAME MATCHES "Linux")
        EXEC_PROGRAM(cat ARGS "/proc/cpuinfo" OUTPUT_VARIABLE CPUINFO)
        STRING(REGEX REPLACE "^.*(sse2).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "sse2" "${SSE_THERE}" SSE2_TRUE)
        IF (SSE2_TRUE)
            set(SSE2_FOUND true CACHE BOOL "SSE2 available on host")
        ELSE (SSE2_TRUE)
            set(SSE2_FOUND false CACHE BOOL "SSE2 available on host")
        ENDIF (SSE2_TRUE)
        # /proc/cpuinfo apparently omits sse3 :(
        STRING(REGEX REPLACE "^.*[^s](sse3).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "sse3" "${SSE_THERE}" SSE3_TRUE)
        IF (NOT SSE3_TRUE)
            STRING(REGEX REPLACE "^.*(T2300).*$" "\\1" SSE_THERE ${CPUINFO})
            STRING(COMPARE EQUAL "T2300" "${SSE_THERE}" SSE3_TRUE)
        ENDIF (NOT SSE3_TRUE)
        STRING(REGEX REPLACE "^.*(ssse3).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "ssse3" "${SSE_THERE}" SSSE3_TRUE)
        IF (SSE3_TRUE OR SSSE3_TRUE)
            set(SSE3_FOUND true CACHE BOOL "SSE3 available on host")
        ELSE (SSE3_TRUE OR SSSE3_TRUE)
            set(SSE3_FOUND false CACHE BOOL "SSE3 available on host")
        ENDIF (SSE3_TRUE OR SSSE3_TRUE)
        IF (SSSE3_TRUE)
            set(SSSE3_FOUND true CACHE BOOL "SSSE3 available on host")
        ELSE (SSSE3_TRUE)
            set(SSSE3_FOUND false CACHE BOOL "SSSE3 available on host")
        ENDIF (SSSE3_TRUE)

        STRING(REGEX REPLACE "^.*(sse4_1).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "sse4_1" "${SSE_THERE}" SSE41_TRUE)
        IF (SSE41_TRUE)
            set(SSE4_1_FOUND true CACHE BOOL "SSE4.1 available on host")
        ELSE (SSE41_TRUE)
            set(SSE4_1_FOUND false CACHE BOOL "SSE4.1 available on host")
        ENDIF (SSE41_TRUE)

        STRING(REGEX REPLACE "^.*(sse4_2).*$" "\\1" SSE_THREE ${CPUINFO})
        STRING(COMPARE EQUAL "sse4_2" "${SSE_THREE}" "SSE42_TRUE")
        IF (SSE42_TRUE)
            set(SSE4_2_FOUND true CACHE BOOL "SSE4.2 available on host")
        ELSE ()
            set(SSE4_2_FOUND false CACHE BOOL "SSE4.2 available on host")
        ENDIF ()

        STRING(REGEX REPLACE "^.*(avx).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "avx" "${SSE_THERE}" AVX_TRUE)
        IF (AVX_TRUE)
            set(AVX_FOUND true CACHE BOOL "AVX available on host")
        ELSE (AVX_TRUE)
            set(AVX_FOUND false CACHE BOOL "AVX available on host")
        ENDIF (AVX_TRUE)

        STRING(REGEX REPLACE "^.*(avx2).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "avx2" "${SSE_THERE}" AVX2_TRUE)
        IF (AVX2_TRUE)
            set(AVX2_FOUND true CACHE BOOL "AVX2 available on host")
        ELSE (AVX2_TRUE)
            set(AVX2_FOUND false CACHE BOOL "AVX2 available on host")
        ENDIF (AVX2_TRUE)

        STRING(REGEX REPLACE "^.*(fma).*$" "\\1" SSE_THREE ${CPUINFO})
        STRING(COMPARE EQUAL "fma" ${SSE_THREE} FMA_TRUE)
        IF (FMA_TRUE)
            set(FMA_FOUND true CACHE BOOL "FMA available on host")
        ELSE ()
            set(AVX_FOUND false CACHE BOOL "FMA available on host")
        ENDIF ()
    ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Darwin")
        EXEC_PROGRAM("/usr/sbin/sysctl -n machdep.cpu.features" OUTPUT_VARIABLE CPUINFO)
        STRING(REGEX REPLACE "^.*[^S](SSE2).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "SSE2" "${SSE_THERE}" SSE2_TRUE)
        IF (SSE2_TRUE)
            set(SSE2_FOUND true CACHE BOOL "SSE2 available on host")
        ELSE (SSE2_TRUE)
            set(SSE2_FOUND false CACHE BOOL "SSE2 available on host")
        ENDIF (SSE2_TRUE)
        STRING(REGEX REPLACE "^.*[^S](SSE3).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "SSE3" "${SSE_THERE}" SSE3_TRUE)
        IF (SSE3_TRUE)
            set(SSE3_FOUND true CACHE BOOL "SSE3 available on host")
        ELSE (SSE3_TRUE)
            set(SSE3_FOUND false CACHE BOOL "SSE3 available on host")
        ENDIF (SSE3_TRUE)
        STRING(REGEX REPLACE "^.*(SSSE3).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "SSSE3" "${SSE_THERE}" SSSE3_TRUE)
        IF (SSSE3_TRUE)
            set(SSSE3_FOUND true CACHE BOOL "SSSE3 available on host")
        ELSE (SSSE3_TRUE)
            set(SSSE3_FOUND false CACHE BOOL "SSSE3 available on host")
        ENDIF (SSSE3_TRUE)
        STRING(REGEX REPLACE "^.*(SSE4.1).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "SSE4.1" "${SSE_THERE}" SSE41_TRUE)
        IF (SSE41_TRUE)
            set(SSE4_1_FOUND true CACHE BOOL "SSE4.1 available on host")
        ELSE (SSE41_TRUE)
            set(SSE4_1_FOUND false CACHE BOOL "SSE4.1 available on host")
        ENDIF (SSE41_TRUE)
        STRING(REGEX REPLACE "^.*(AVX).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "AVX" "${SSE_THERE}" AVX_TRUE)
        IF (AVX_TRUE)
            set(AVX_FOUND true CACHE BOOL "AVX available on host")
        ELSE (AVX_TRUE)
            set(AVX_FOUND false CACHE BOOL "AVX available on host")
        ENDIF (AVX_TRUE)
        STRING(REGEX REPLACE "^.*(avx2).*$" "\\1" SSE_THERE ${CPUINFO})
        STRING(COMPARE EQUAL "AVX2" "${SSE_THERE}" AVX2_TRUE)
        IF (AVX2_TRUE)
            set(AVX2_FOUND true CACHE BOOL "AVX2 available on host")
        ELSE (AVX2_TRUE)
            set(AVX2_FOUND false CACHE BOOL "AVX2 available on host")
        ENDIF (AVX2_TRUE)
    ELSEIF (CMAKE_SYSTEM_NAME MATCHES "Windows")
        # TODO
        set(SSE2_FOUND true CACHE BOOL "SSE2 available on host")
        set(SSE3_FOUND false CACHE BOOL "SSE3 available on host")
        set(SSSE3_FOUND false CACHE BOOL "SSSE3 available on host")
        set(SSE4_1_FOUND false CACHE BOOL "SSE4.1 available on host")
        set(AVX_FOUND false CACHE BOOL "AVX available on host")
        set(AVX2_FOUND false CACHE BOOL "AVX2 available on host")
    ELSE (CMAKE_SYSTEM_NAME MATCHES "Linux")
        set(SSE2_FOUND true CACHE BOOL "SSE2 available on host")
        set(SSE3_FOUND false CACHE BOOL "SSE3 available on host")
        set(SSSE3_FOUND false CACHE BOOL "SSSE3 available on host")
        set(SSE4_1_FOUND false CACHE BOOL "SSE4.1 available on host")
        set(AVX_FOUND false CACHE BOOL "AVX available on host")
        set(AVX2_FOUND false CACHE BOOL "AVX2 available on host")
    ENDIF (CMAKE_SYSTEM_NAME MATCHES "Linux")
    mark_as_advanced(SSE2_FOUND SSE3_FOUND SSSE3_FOUND SSE4_1_FOUND, AVX_FOUND, AVX2_FOUND)

    # finally, apply the options
    if (HAS_SSE)
        message(STATUS "SSE found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse")
        add_definitions(-DWITH_SSE)
    else ()
        message(STATUS "SSE2 not found")
    endif ()
    if (HAS_SSE2)
        message(STATUS "SSE2 found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse2")
        add_definitions(-DWITH_SSE)
    else ()
        message(STATUS "SSE2 not found")
    endif ()
    if (SSE3_FOUND)
        message(STATUS "SSE3 found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse3")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse3")
        add_definitions(-DWITH_SSE3)
    else ()
        message(STATUS "SSE3 not found")
    endif ()
    if (SSE4_1_FOUND)
        message(STATUS "SSE4.1 found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse4.1")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse4.1")
        add_definitions(-DWITH_SSE4_1)
    else ()
        message(STATUS "SSE4.1 not found")
    endif ()
    if (SSE4_2_FOUND)
        message(STATUS "SSE4.2 found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -msse4.2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -msse4.2")
        add_definitions(-DWITH_SSE4_2)
    else ()
        message(STATUS "SSE4.2 not found")
    endif ()
    if (AVX_FOUND)
        message(STATUS "AVX found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mavx")
        add_definitions(-DWITH_AVX)
    else ()
        message(STATUS "AVX not found")
    endif ()
    if (AVX2_FOUND)
        message(STATUS "AVX2 found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx2")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mavx2")
        add_definitions(-DWITH_AVX2)
    else ()
        message(STATUS "AVX2 not found")
    endif ()
    if (FMA_FOUND)
        message(STATUS "FMA found")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfma")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfma")
        add_definitions(-DWITH_FMA)
    else ()
        message(STATUS "FMA not found")
    endif ()
endif ()

