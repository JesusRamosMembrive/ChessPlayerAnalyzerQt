# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appChessPlayerAnalyzerQt_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appChessPlayerAnalyzerQt_autogen.dir\\ParseCache.txt"
  "appChessPlayerAnalyzerQt_autogen"
  )
endif()
