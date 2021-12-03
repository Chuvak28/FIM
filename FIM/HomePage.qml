import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
//import komtek.ishonch 1.0

Page {
    id:root

    Drawer{
        id:drawer

        width: Math.min(window.width,window.height)/3*2
        height: window.height
        interactive: stackView.depth === 1

        ListView{
            id: listView
            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate{
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel{
                ListElement { title: "Info"; source: "qrc:/pages/BusyIndicatorPage.qml" }
                ListElement { title: "Take a picture"; source: "qrc:TakePicture.qml" }
            }
            ScrollIndicator.vertical: ScrollIndicator{}
        }
    }

    header: ToolBar{

        ToolButton{
            id:menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/icons/icons/20x20/drawer.png"
            onClicked: drawer.open()
        }
        Label{
            anchors.centerIn: parent
            text: "Ishonch"
            font.pixelSize: 20
        }
    }

//    ListView{
//        id: listView
//        anchors.fill: parent
//        leftMargin: 1
//        model: SqlContactModel{}
//        delegate: ItemDelegate{
//            text: model.display
//            width: listView.width - listView.leftMargin - listView.rightMargin
//            height: avatar.implicitHeight
//            leftPadding: avatar.implicitWidth + 32
//            onClicked: root.StackView.view.push("qrc:/ConversationPage.qml", { inConversationWith: model.display })

//            Image {
//                id: avatar

//                source: "qrc:/images/" + modelData.replace(" ", "_") + ".png"
//            }
//        }
//    }
}
