cmake_minimum_required(VERSION 3.16)

project(ChessPlayerAnalyzerQt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt_add_executable(appChessPlayerAnalyzerQt
    main.cpp
)

# Copy QML files to build directory
configure_file(Main.qml Main.qml COPYONLY)
configure_file(HomePage.qml HomePage.qml COPYONLY)
configure_file(ResultsPage.qml ResultsPage.qml COPYONLY)
configure_file(RootLayout.qml RootLayout.qml COPYONLY)
configure_file(MetricDisplay.qml MetricDisplay.qml COPYONLY)
configure_file(PlayersList.qml PlayersList.qml COPYONLY)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appChessPlayerAnalyzerQt PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appChessPlayerAnalyzerQt
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appChessPlayerAnalyzerQt
    PRIVATE Qt6::Core Qt6::Quick Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS appChessPlayerAnalyzerQt
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
