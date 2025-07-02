cmake_minimum_required(VERSION 3.16)

project(ChessPlayerAnalyzerQt VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick QUIET)
if (NOT Qt6_FOUND)
    find_package(Qt5 5.15 REQUIRED COMPONENTS Quick)
endif()

qt_standard_project_setup()

qt_add_executable(ChessPlayerAnalyzerQt
    main.cpp
)

qt_add_qml_module(ChessPlayerAnalyzerQt
    URI ChessAnalyzer
    VERSION 1.0
    QML_FILES
        main.qml
        FeatureCard.qml
    SOURCES
)

if (Qt6_FOUND)
    qt_finalize_executable(ChessPlayerAnalyzerQt)
    target_link_libraries(ChessPlayerAnalyzerQt PRIVATE Qt6::Quick)
else()
    target_link_libraries(ChessPlayerAnalyzerQt PRIVATE Qt5::Quick)
endif()
