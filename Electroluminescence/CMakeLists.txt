cmake_minimum_required(VERSION 3.9 FATAL_ERROR)
project(Electroluminescence)
if(NOT TARGET Garfield::Garfield)
  find_package(Garfield REQUIRED)
endif()

# ---Define executables---------------------------------------------------------
add_executable(Mesh Mesh.C)
target_link_libraries(Mesh Garfield::Garfield)

add_executable(PlotEField PlotEField.C)
target_link_libraries(PlotEField Garfield::Garfield)


add_executable(TrackSim TrackSim.C)
target_link_libraries(TrackSim Garfield::Garfield)

add_executable(CRAB CRAB.C)
target_link_libraries(CRAB Garfield::Garfield)

add_executable(Mesh_noPrint Mesh_noPrint.C)
target_link_libraries(Mesh_noPrint Garfield::Garfield)


#----------------------------------------------------------------------------
# Copy all scripts to the build directory, i.e. the directory in which we
# build B5. This is so that we can run the executable directly because it
# relies on these scripts being in the current working directory.
#

#set(GAS_FILES
#  ar_4.0bar.gas
#  ar_10.0bar.gas
#  Argon_4bar.gas
#  xe.gas
#  xe_properties.gas
#  )

foreach(_script ${GAS_FILES})
  configure_file(
    ${PROJECT_SOURCE_DIR}/${_script}
    ${PROJECT_BINARY_DIR}/${_script}
    COPYONLY
    )
endforeach()
