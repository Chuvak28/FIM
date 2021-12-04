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





            ColumnLayout {
                spacing: -15

                anchors.top: image.bottom


                RadioButton {
                    id:r1
                    checked: ch?problem1="1": problem1="0"
                    text: qsTr("Намёк на взятку")
                    //scale: 0.75
                }




            }


        }


    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:5;locked:true}
}
##^##*/
