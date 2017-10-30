import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQml.Models 2.2
import org.kde.kirigami 2.1 as Kirigami

Column {
    spacing: 6
    
    property var scttemp: metacontent.currenttemp
    property var slttemp: metacontent.mintemp
    property var shttemp: metacontent.maxtemp
    property var ssum: metacontent.sum
    property var sloc: metacontent.loc

    Row {
        id: messageRow
        spacing: 6

        Rectangle{
            id: messageWrapper
            width: cbwidth
            height: messageRect.height
            color: Kirigami.Theme.textColor

            Rectangle {
                id: messageRect
                width: cbwidth
                height: 100
                color: Kirigami.Theme.textColor
            
             Rectangle {
                id: weatherinfoBar
                width: messageRect
                color: Kirigami.Theme.textColor
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            
                Kirigami.Label {
                    id: todayweather
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font.italic: false
                    font.bold: true
                    font.pixelSize: 15
                    color: Kirigami.Theme.backgroundColor
                    
                    Component.onCompleted: {
                        todayweather.text = sloc
                    }
                }
                
                Kirigami.Label {
                    id: weathersum
                    //text: qsTr(metacontent.sum)
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    font.italic: true
                    font.bold: true
                    font.pixelSize: 10
                    
                    Component.onCompleted: {
                        weathersum.text = ssum
                    }
                }
            }

                Rectangle {
                    id: rectanglectt
                    width: 125
                    anchors.left: parent.left
                    height: 75
                    color: Kirigami.Theme.textColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5

                    Kirigami.Label {
                        id: currenttemplable
                        text: "Current"
                        font.pointSize: 12
                        //font.family: "Courier"
                        font.bold: true
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        //anchors.verticalCenter: currenttempaniimage.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        color: Kirigami.Theme.backgroundColor
                    }

                    Kirigami.Label {
                        id: currenttempitem
                        x: 73
                        y: 38
                        //text: metacontent.currenttemp
                        anchors.horizontalCenter: currenttemplable.horizontalCenter
                        anchors.top: currenttemplable.bottom
                        anchors.topMargin: 10
                        color: Kirigami.Theme.backgroundColor
                        
                    Component.onCompleted: {
                       currenttempitem.text = scttemp
                    }
                    }

                    Kirigami.Label {
                        id: weatherwidgetcurrenttempdegrees
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: currenttempitem.verticalCenter
                        anchors.left: currenttempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                        color: Kirigami.Theme.backgroundColor
                    }


                }

                Rectangle {
                    id: rectangleltt
                    //width: 100
                    height: 75
                    color: Kirigami.Theme.textColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter

                    Kirigami.Label {
                        id: lowtemplable
                        anchors.left: parent.left
                        //anchors.verticalCenter: lowtempaniimage.verticalCenter
                        text: "Low"
                        //font.family: "Courier"
                        font.pointSize: 12
                        font.bold: true
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.leftMargin: 30
                        color: Kirigami.Theme.backgroundColor
                    }

                    Kirigami.Label {
                        id: lowtempitem
                        x: 63
                        y: 33
                        anchors.top: lowtemplable.bottom
                        //text: metacontent.mintemp
                        anchors.horizontalCenter: lowtemplable.horizontalCenter
                        anchors.topMargin: 10
                        color: Kirigami.Theme.backgroundColor
                        
                    Component.onCompleted: {
                       lowtempitem.text = slttemp
                            }
                    }

                    Kirigami.Label {
                        id: weatherwidgetlowtempdegree
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: lowtempitem.verticalCenter
                        anchors.left: lowtempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                        color: Kirigami.Theme.backgroundColor
                    }
                }

                Rectangle {
                    id: rectanglehtt
                    width: 125
                    height: 75
                    color: Kirigami.Theme.textColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.leftMargin: 0

                    Kirigami.Label {
                        id: hightempitem
                        x: 65
                        y: 70
                        anchors.top: hightemplable.bottom
                        anchors.topMargin: 10
                        anchors.horizontalCenter: hightemplable.horizontalCenter
                        color: Kirigami.Theme.backgroundColor
                    
                    Component.onCompleted: {
                       hightempitem.text = shttemp
                                }
                            }

                    Kirigami.Label {
                        id: hightemplable
                        anchors.left: parent.left
                        text: "High"
                        font.pointSize: 12
                        font.bold: true
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.leftMargin: 30
                        color: Kirigami.Theme.backgroundColor
                    }

                   Kirigami.Label {
                        id: weatherwidgethightempdegree
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: hightempitem.verticalCenter
                        anchors.left: hightempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                        color: Kirigami.Theme.backgroundColor
                    }


                }
                

                
                }
            }
        }
}
