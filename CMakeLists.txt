
cmake_minimum_required(VERSION 2.8.3)
project(omplapp_catkin)

find_package(catkin_simple REQUIRED)
catkin_simple()

include(ExternalProject)

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include)

ExternalProject_Add(omplapp_src
  GIT_REPOSITORY https://github.com/yuzhangbit/omplapp.git
  UPDATE_COMMAND ""
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=${CATKIN_DEVEL_PREFIX}
  -DCMAKE_INSTALL_LIBDIR:PATH=${CATKIN_DEVEL_PREFIX}/lib/
  -DBUILD_SHARED_LIBS:BOOL=true
  -DCMAKE_BUILD_TYPE:STRING=Release
)

cs_add_library(${PROJECT_NAME} src/dependency_tracker.cc)
add_dependencies(${PROJECT_NAME} omplapp_src)
target_link_libraries(${PROJECT_NAME} ${CATKIN_DEVEL_PREFIX}/lib/libompl${CMAKE_SHARED_LIBRARY_SUFFIX}
                    ${CATKIN_DEVEL_PREFIX}/lib/libompl_app${CMAKE_SHARED_LIBRARY_SUFFIX}
                    ${CATKIN_DEVEL_PREFIX}/lib/libompl_app_base${CMAKE_SHARED_LIBRARY_SUFFIX})

cs_install()

cs_export(INCLUDE_DIRS ${CATKIN_DEVEL_PREFIX}/include
  CFG_EXTRAS omplapp-extras.cmake)
