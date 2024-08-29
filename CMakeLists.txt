cmake_minimum_required(VERSION 3.15)


set(CMAKE_CUDA_ARCHITECTURES 89)
set(CMAKE_CUDA_COMPILER /usr/local/cuda-12.6/bin/nvcc)

# Project name and version
project(CUERFA VERSION 2.0.1 LANGUAGES C CUDA)

# Add the custom CMake modules directory to the module search path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
# Use the custom FindGTest module to set up GoogleTest
find_package(GTest REQUIRED)


# Set the C and C++ standards
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CUDA_STANDARD 11)
set(CMAKE_CUDA_STANDARD_REQUIRED True)

set(SOFA_VERSION "20231011")
set(PACKAGE_VERSION "${PROJECT_VERSION}")
set(PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(PACKAGE_VERSION_MICRO "${PROJECT_VERSION_PATCH}")

add_definitions(-DHAVE_CONFIG_H)

# Configure config.h
configure_file(
    ${CMAKE_SOURCE_DIR}/config.h.in
    ${CMAKE_BINARY_DIR}/config.h
)

# Include the config.h file directory
include_directories(${CMAKE_BINARY_DIR})


# Include the src directory for headers
# include_directories(src)
set(SOURCES
    src/a2af.cu
    src/a2tf.cu
    src/ab.cu
    src/ae2hd.cu
    src/af2a.cu
    src/anp.cu
    src/anpm.cu
    src/apcg.cu
    src/apcg13.cu
    src/apci.cu
    src/apci13.cu
    src/apco.cu
    src/apco13.cu
    src/apcs.cu
    src/apcs13.cu
    src/aper.cu
    src/aper13.cu
    src/apio.cu
    src/apio13.cu
    src/atcc13.cu
    src/atccq.cu
    src/atci13.cu
    src/atciq.cu
    src/atciqn.cu
    src/atciqz.cu
    src/atco13.cu
    src/atic13.cu
    src/aticq.cu
    src/aticqn.cu
    src/atio13.cu
    src/atioq.cu
    src/atoc13.cu
    src/atoi13.cu
    src/atoiq.cu
    src/bi00.cu
    src/bp00.cu
    src/bp06.cu
    src/bpn2xy.cu
    src/c2i00a.cu
    src/c2i00b.cu
    src/c2i06a.cu
    src/c2ibpn.cu
    src/c2ixy.cu
    src/c2ixys.cu
    src/c2s.cu
    src/c2t00a.cu
    src/c2t00b.cu
    src/c2t06a.cu
    src/c2tcio.cu
    src/c2teqx.cu
    src/c2tpe.cu
    src/c2txy.cu
    src/cal2jd.cu
    src/cp.cu
    src/cpv.cu
    src/cr.cu
    src/cuda_strcmp.cu
    src/d2dtf.cu
    src/d2tf.cu
    src/dat.cu
    src/dtdb.cu
    src/dtf2d.cu
    src/eceq06.cu
    src/ecm06.cu
    src/ee00.cu
    src/ee00a.cu
    src/ee00b.cu
    src/ee06a.cu
    src/eect00.cu
    src/eform.cu
    src/eo06a.cu
    src/eors.cu
    src/epb.cu
    src/epb2jd.cu
    src/epj.cu
    src/epj2jd.cu
    src/epv00.cu
    src/eqec06.cu
    src/eqeq94.cu
    src/era00.cu
    src/erfadatextra.cu
    src/erfaversion.cu
    src/fad03.cu
    src/fae03.cu
    src/faf03.cu
    src/faju03.cu
    src/fal03.cu
    src/falp03.cu
    src/fama03.cu
    src/fame03.cu
    src/fane03.cu
    src/faom03.cu
    src/fapa03.cu
    src/fasa03.cu
    src/faur03.cu
    src/fave03.cu
    src/fk425.cu
    src/fk45z.cu
    src/fk524.cu
    src/fk52h.cu
    src/fk54z.cu
    src/fk5hip.cu
    src/fk5hz.cu
    src/fw2m.cu
    src/fw2xy.cu
    src/g2icrs.cu
    src/gc2gd.cu
    src/gc2gde.cu
    src/gd2gc.cu
    src/gd2gce.cu
    src/gmst00.cu
    src/gmst06.cu
    src/gmst82.cu
    src/gst00a.cu
    src/gst00b.cu
    src/gst06.cu
    src/gst06a.cu
    src/gst94.cu
    src/h2fk5.cu
    src/hd2ae.cu
    src/hd2pa.cu
    src/hfk5z.cu
    src/icrs2g.cu
    src/ir.cu
    src/jd2cal.cu
    src/jdcalf.cu
    src/ld.cu
    src/ldn.cu
    src/ldsun.cu
    src/lteceq.cu
    src/ltecm.cu
    src/lteqec.cu
    src/ltp.cu
    src/ltpb.cu
    src/ltpecl.cu
    src/ltpequ.cu
    src/moon98.cu
    src/num00a.cu
    src/num00b.cu
    src/num06a.cu
    src/numat.cu
    src/nut00a.cu
    src/nut00b.cu
    src/nut06a.cu
    src/nut80.cu
    src/nutm80.cu
    src/obl06.cu
    src/obl80.cu
    src/p06e.cu
    src/p2pv.cu
    src/p2s.cu
    src/pap.cu
    src/pas.cu
    src/pb06.cu
    src/pdp.cu
    src/pfw06.cu
    src/plan94.cu
    src/pm.cu
    src/pmat00.cu
    src/pmat06.cu
    src/pmat76.cu
    src/pmp.cu
    src/pmpx.cu
    src/pmsafe.cu
    src/pn.cu
    src/pn00.cu
    src/pn00a.cu
    src/pn00b.cu
    src/pn06.cu
    src/pn06a.cu
    src/pnm00a.cu
    src/pnm00b.cu
    src/pnm06a.cu
    src/pnm80.cu
    src/pom00.cu
    src/ppp.cu
    src/ppsp.cu
    src/pr00.cu
    src/prec76.cu
    src/pv2p.cu
    src/pv2s.cu
    src/pvdpv.cu
    src/pvm.cu
    src/pvmpv.cu
    src/pvppv.cu
    src/pvstar.cu
    src/pvtob.cu
    src/pvu.cu
    src/pvup.cu
    src/pvxpv.cu
    src/pxp.cu
    src/refco.cu
    src/rm2v.cu
    src/rv2m.cu
    src/rx.cu
    src/rxp.cu
    src/rxpv.cu
    src/rxr.cu
    src/ry.cu
    src/rz.cu
    src/s00.cu
    src/s00a.cu
    src/s00b.cu
    src/s06.cu
    src/s06a.cu
    src/s2c.cu
    src/s2p.cu
    src/s2pv.cu
    src/s2xpv.cu
    src/sepp.cu
    src/seps.cu
    src/sp00.cu
    src/starpm.cu
    src/starpv.cu
    src/sxp.cu
    src/sxpv.cu
    src/taitt.cu
    src/taiut1.cu
    src/taiutc.cu
    src/tcbtdb.cu
    src/tcgtt.cu
    src/tdbtcb.cu
    src/tdbtt.cu
    src/tf2a.cu
    src/tf2d.cu
    src/tpors.cu
    src/tporv.cu
    src/tpsts.cu
    src/tpstv.cu
    src/tpxes.cu
    src/tpxev.cu
    src/tr.cu
    src/trxp.cu
    src/trxpv.cu
    src/tttai.cu
    src/tttcg.cu
    src/tttdb.cu
    src/ttut1.cu
    src/ut1tai.cu
    src/ut1tt.cu
    src/ut1utc.cu
    src/utctai.cu
    src/utcut1.cu
    src/xy06.cu
    src/xys00a.cu
    src/xys00b.cu
    src/xys06a.cu
    src/zp.cu
    src/zpv.cu
    src/zr.cu
)

# Add the library (static or shared)
add_library(cuerfa STATIC ${SOURCES})

# Link the math library
target_link_libraries(cuerfa m)

# turn on CUDA separable compilation
set_target_properties(cuerfa PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

# Optionally set up testing
enable_testing()

# Add gtest if you want to set up testing
find_package(GTest REQUIRED)
find_package(CUDAToolkit REQUIRED)

include_directories(${GTEST_INCLUDE_DIRS})

# Add separate test executables
add_executable(run_test_1 src/t_erfa_c.cu)
add_executable(run_test_2 src/t_erfa_c_extra.cu)

# turn on CUDA separable compilation
set_target_properties(run_test_1 PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(run_test_2 PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

# Link each executable with the necessary libraries
target_link_libraries(run_test_1 ${GTEST_LIBRARIES} cuerfa ${CUDAToolkit_LIBRARIES} m pthread)
target_link_libraries(run_test_2 ${GTEST_LIBRARIES} cuerfa ${CUDAToolkit_LIBRARIES} m pthread)

# Add tests
add_test(NAME ERFA_Test_1 COMMAND run_test_1)
add_test(NAME ERFA_Test_2 COMMAND run_test_2)