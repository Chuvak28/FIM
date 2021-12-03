import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id:window

    width: 360
    height: 520
    visible: true

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: HomePage{}
    }

}
