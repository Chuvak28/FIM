import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0
import komtek.ishonch 1.0
import POST_REQ 1.0

Page {
    id: root

    property string name
    property string nameDept
    property string problem1
    property string problem2
    property string problem3
    property string problem4
    property string comment
    property bool ch: true

    POST_REQ {
        id: demo
    }

    property string inConversationWith

    header: ChatToolBar {
        ToolButton {
            text: qsTr("Back")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: root.StackView.view.pop()
        }

        Label {
            id: pageTitle
            text: inConversationWith
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: rectangle

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.margins: pane.leftPadding + messageField.leftPadding
            height: 200
            color: "#a1e5fb"
            clip: true

            ///roundingImage
            Image {
                id: image

                x:rectangle.x/2
                y:rectangle.y/4


                source: "qrc:/images/" + inConversationWith.replace(" ", "_") + ".png"

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: image.width
                        height: image.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: image.adapt ? image.width : Math.min(image.width, image.height)
                            height: image.adapt ? image.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
            }

            Text {
                id: aboutName
                text: inConversationWith
                anchors.left: image.right
                anchors.leftMargin: 5
                font {
                    bold: true
                    family: "Helvetica";
                    pointSize: 10

                }
            }

            Text {
                id: aboutPosition
                text: "Руководитель в районном ЭС"
                anchors.top: aboutName.bottom
                anchors.left: image.right
                anchors.leftMargin: 5
                font {
                    bold: true
                    family: "Helvetica";
                    pointSize: 10

                }
            }

            ColumnLayout {
                spacing: -15

                anchors.top: image.bottom


                RadioButton {
                    id:r1
                    checked: ch?problem1="1": problem1="0"
                    text: qsTr("Намёк на взятку")
                    //scale: 0.75
                }
                RadioButton {
                    id:r2
                    checked:ch?problem2="1": problem2="0"
                    text: qsTr("Нагрубил")
                    //scale: 0.75
                }
                RadioButton {
                    id:r3
                    checked:ch?problem3="1": problem3="0"
                    text: qsTr("Затягивает с подписанием документов")
                    //scale: 0.75

                }
                RadioButton {
                    id:r4
                    checked:ch?problem4="1": problem4="0"
                    text: qsTr("Не выполнил свои обещания")
                    //scale: 0.75
                }

            }


        }



        ListView {
            id: listView

            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: pane.leftPadding + messageField.leftPadding
            displayMarginBeginning: 40
            displayMarginEnd: 40
            //verticalLayoutDirection: ListView.BottomToTop
            verticalLayoutDirection: ListView.TopToBottom
            spacing: 12
            model: SqlConversationModel {
                recipient: inConversationWith
            }
            delegate: Column {
                anchors.right: sentByMe ? parent.right : undefined
                spacing: 6

                readonly property bool sentByMe: model.recipient !== "Me"

                Row {
                    id: messageRow
                    spacing: 6
                    anchors.right: sentByMe ? parent.right : undefined

                    Image {
                        id: avatar
                        source: !sentByMe ? "qrc:/images/" + model.author.replace(" ", "_") + ".png" : ""
                    }

                    Rectangle {
                        width: Math.min(messageText.implicitWidth + 24, listView.width - avatar.width - messageRow.spacing)
                        height: messageText.implicitHeight + 24
                        color: sentByMe ? "lightgrey" : "steelblue"

                        Label {
                            id: messageText
                            text: model.message
                            color: sentByMe ? "black" : "white"
                            anchors.fill: parent
                            anchors.margins: 12
                            wrapMode: Label.Wrap
                        }
                    }
                }

                Label {
                    id: timestampText
                    text: Qt.formatDateTime(model.timestamp, "d MMM hh:mm")
                    color: "lightgrey"
                    anchors.right: sentByMe ? parent.right : undefined
                }
            }

            ScrollBar.vertical: ScrollBar {}
        }


        Pane {
            id: pane
            Layout.fillWidth: true

            RowLayout {
                width: parent.width

                TextArea {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Compose message")
                    wrapMode: TextArea.Wrap
                }

                Button {
                    id: sendButton
                    text: qsTr("Send")
                    enabled: messageField.length > 0
                    onClicked: {
                        listView.model.sendMessage(inConversationWith, messageField.text);
                        name=inConversationWith
                        nameDept="RayGaz"
                        comment = messageField.text
                        demo.upload(name, nameDept,problem1,problem2,
                                    problem3,problem4, comment)
                        messageField.text = "";
                    }
                }
            }
        }
    }
}
