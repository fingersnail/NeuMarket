TEMPLATE = app

QT += qml quick
QT += widgets
CONFIG += c++11
LIBS += -LC:\Users\a2476\Code\Qt\NeuMarket\qjson\bin -llibqjson-qt5
INCLUDEPATH += C:\Users\a2476\Code\Qt\NeuMarket\qjson\include\qjson-qt5
SOURCES += main.cpp \
    colortransformer.cpp \
    controllayertoolcs.cpp \
    controllayer.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    colortransformer.h \
    controllayertoolcs.h \
    controllayer.h

DISTFILES +=

