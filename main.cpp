#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    QQuickStyle::setStyle("Material");
    
    engine.load(QUrl(QStringLiteral("qrc:/ChessAnalyzer/main.qml")));

    return app.exec();
}
