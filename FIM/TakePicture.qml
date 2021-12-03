import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.12
import QtPositioning 5.12
//import POST_REQ 1.0



Page {
    property string lat
    property string lon
    property date currentTime: new Date()
    property string timeString
    property string textString
    property string photoString

    Rectangle {
        id: rect1
        anchors.fill: parent



//        POST_REQ {
//            id: demo
//        }


        PositionSource {
            id: src
            updateInterval: 1000
            active: true

            onPositionChanged: {
                var coord = src.position.coordinate;
                console.log("Coordinate:", coord.latitude,coord.longitude );
                lat=coord.latitude;
                lon=coord.longitude;

            }

        }

        Image {
            id: photoPreview

            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }


        Camera {
            id: camera
            imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
            captureMode: Camera.CaptureStillImage

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposurePortrait
            }

            flash.mode: Camera.FlashRedEyeReduction

            imageCapture {
                id: imageSaved
                onImageSaved:  {

                    //photoPreview.source = preview
                    photoString=path
                    //demo.processImage(preview);
                }
            }
        }


        VideoOutput {
            source: camera
            //anchors.fill: parent
            //focus : visible // to receive focus and capture key events when visible
        }

        Button {
            id: cpatureButton

            opacity: 0.5

            Text {
                id: textId
                text: qsTr("Take Photo")
                color: "white"
            }
            onClicked: {
                camera.imageCapture.capture();
                cpatureButton.enabled=false
                textId.visible=false
                sendButton.visible = true
                sendButton.enabled = true
                complainText.visible = true


            }
        }

        Button {
            id: sendButton

            text: "Send"
            visible : false
            enabled: false



            onClicked:
            {
                timeString = currentTime.toLocaleString(locale,"yyyy-MM-dd hh:mm:ss");//  Locale.ShortFormat);
                textString = complainText.text
                demo.upload(lat,lon, timeString,textString, photoString)
                console.log(lat,lon,timeString, textString, photoString);
            }
        }

        TextField {
            id: complainText

            x: parent.width/2
            y: parent.bottom
            visible : false
            width: 160
            placeholderText: "Enter Text Here"
            focus: true
            color: "#aaa"
        }


    }
}
