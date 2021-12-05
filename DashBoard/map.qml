import QtQuick 2.9
import QtQuick.Window 2.3
import QtLocation 5.9
import QtPositioning 5.8
import QtQml.Models 2.2
import QtQuick.Controls 2.12

Map {
    Plugin {
        id: mapPlugin
        name: "osm"
    }
    property bool showToolTip: false
    property string toolTipText: "message"

    //anchors.fill: parent
    id: myMap
    width: 788
    height: 332
    plugin: mapPlugin
    center: QtPositioning.coordinate(41.2816234,69.206447)
    zoomLevel: 6


    //    MapCircle {
    //        id: circleTashkent
    //        center {
    //            latitude: 41.2646500;
    //            longitude: 69.2162700;

    //        }
    //        radius: 15000
    //        color: 'red'
    //        border.width: 3
    //        opacity: 0.5

    //        ToolTip{

    //            text: "Test"
    //            visible: toolTipText ? ma.containsMouse : false
    //        }

    //        MouseArea {
    //            id: ma
    //            anchors.fill: parent
    //            hoverEnabled: true


    //        }
    //    }

    MapItemView {
        id: mapItemViewCircles
        model: ListModel{
            ListElement{lat: 41.2646500; lon: 69.2162700}
            ListElement{lat: 39.777552; lon: 64.422798}
            ListElement{lat: 39.640760; lon: 66.967887}
            ListElement{lat: 40.779437; lon: 72.319645}
            ListElement{lat: 40.118843; lon: 67.854395}
            ListElement{lat: 38.929023; lon: 65.753589}
            ListElement{lat: 40.098017; lon: 65.371614}
            ListElement{lat: 40.970525; lon: 71.644623}
            ListElement{lat: 38.137516; lon: 67.460209}
            ListElement{lat: 40.379791; lon: 71.790462}
            ListElement{lat: 41.283891; lon: 61.210010}
            ListElement{lat: 42.471432; lon: 59.603830}
        }

        delegate: MapCircle{
            id: circles

            center {
                latitude: lat;
                longitude: lon;

            }
            radius: 15000
            color: 'red'
            border.width: 3
            opacity: 0.5
            Component.onCompleted: {
                console.count("Loaded a MapCircle")
                myMap.addMapItem(circles);
            }

            //            ItemSelectionModel {
            //                id: ism
            //                model: sqlModel


            //            }
            ToolTip{

                text: "City Tashkent Problems:303"
                visible: toolTipText ? ma.containsMouse : false
            }
            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true


            }
            //            MouseArea {
            //                anchors.fill: parent
            //                onClicked: {

            //                    ism.select(sqlModel.index(index,0), ItemSelectionModel.Select | ItemSelectionModel.Current)
            //                    console.log(ism.hasSelection)
            //                }

            //            }
        }

    }
}
