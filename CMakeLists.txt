cmake_minimum_required(VERSION 3.16)

project(ChessPlayerAnalyzerQt VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(ChessPlayerAnalyzerQt
    main.cpp
)

qt_add_qml_module(ChessPlayerAnalyzerQt
    URI ChessPlayerAnalyzerQt
    VERSION 1.0
    QML_FILES
        main.qml
        qml/layouts/RootLayout.qml
        qml/pages/HomePage.qml
        qml/pages/ResultsPage.qml
        qml/components/MetricDisplay.qml
        qml/components/PlayersList.qml
)

target_link_libraries(ChessPlayerAnalyzerQt PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
)

set_target_properties(ChessPlayerAnalyzerQt PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.chessanalyzer.qt
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)
