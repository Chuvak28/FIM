import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import komtek.fim 1.0

Page {
    id:root

    Drawer{
        id:drawer

        width: Math.min(window.width,window.height)/3*2
        height: window.height

        ListView{
            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate{
                width: parent.width
                text: model.text
                highlighted: ListView.isCurrentItem
                onClicked: {
                    drawer.close()
                    model.triggered()
                }
            }

            model: ListModel{
                ListElement {
                    text: qsTr("Open...")
                    triggered: function(){ fileOpenDialog.open(); }
                }
                ListElement {
                    text: qsTr("About...")
                    triggered: function(){ aboutDialog.open(); }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator{}
        }
    }

    header: ToolBar{

        ToolButton{
            id:menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "images/baseline-menu-24px.svg"
            onClicked: drawer.open()
        }
        Label{
            anchors.centerIn: parent
            text: "Ishonch"
            font.pixelSize: 20
        }
    }

    ListView{
        id: listView
        anchors.fill: parent
        leftMargin: 1
        model: SqlContactModel{}
        delegate: ItemDelegate{
            text: model.display
            width: listView.width - listView.leftMargin - listView.rightMargin
            height: avatar.implicitHeight
            leftPadding: avatar.implicitWidth + 32
            onClicked: root.StackView.view.push("qrc:/ConversationPage.qml", { inConversationWith: model.display })

            Image {
                id: avatar

                source: "qrc:/images/" + modelData.replace(" ", "_") + ".png"
            }
        }
    }
}
