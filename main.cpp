#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    QQuickStyle::setStyle("Material");
    
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ChessAnalyzer", "Main");

    return app.exec();
}
