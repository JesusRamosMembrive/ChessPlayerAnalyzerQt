QT += quick quickcontrols2

CONFIG += c++17

TARGET = ChessPlayerAnalyzerQt

SOURCES += \
    main.cpp

RESOURCES += qml.qrc

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
