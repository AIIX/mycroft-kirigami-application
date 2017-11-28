import QtQuick 2.9
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.1 as Kirigami

Item {
    anchors.fill: parent
    property alias inCircle: innerCircleIn.color

    Rectangle {
         id: innerCircleSurround
         anchors.centerIn: parent
         color: "#404682b4"
         border.color: "#00000000"
         border.width: Kirigami.Units.gridUnit * 0.2
         radius: 100
         implicitWidth: Kirigami.Units.gridUnit * 3.7
         implicitHeight: Kirigami.Units.gridUnit * 3.7
        }

    Rectangle {
         id: innerCircleSurroundOutterRing
         anchors.centerIn: parent
         color: "#00000000"
         border.color: "lightblue"
         border.width: Kirigami.Units.gridUnit * 0.2
         radius: 100
         implicitWidth: Kirigami.Units.gridUnit * 3.7
         implicitHeight: Kirigami.Units.gridUnit * 3.7
        }

    Rectangle {
         id: innerCircleIn
         anchors.centerIn: parent
         color: "lightblue"
         border.color: "steelblue"
         border.width: Kirigami.Units.gridUnit * 0.1
         radius: 100
         implicitWidth: Kirigami.Units.gridUnit * 1.7
         implicitHeight: Kirigami.Units.gridUnit * 1.7
        }

    Rectangle {
         id: innerCircleInMic
         anchors.centerIn: parent
         color: "#00000000"
         border.color: "#00000000"
         border.width: Kirigami.Units.gridUnit * 0.1
         radius: 100
         implicitWidth: Kirigami.Units.gridUnit * 1.7
         implicitHeight: Kirigami.Units.gridUnit * 1.7

         Image {
            id: innerImgInnerCirc
            anchors.centerIn: parent
            source: "../images/mic.png"
            width: Kirigami.Units.gridUnit * 1
            height: Kirigami.Units.gridUnit * 1
            }

         ColorOverlay{
            anchors.fill: innerImgInnerCirc
            source: innerImgInnerCirc
            color: Qt.lighter(Kirigami.Theme.backgroundColor, 1.4)
            }
        }

    ScaleAnimator {
        target: innerCircleSurround
        running: true
        from: 1.2
        to: 0.8
        duration: 360000
        loops: Animation.Infinite
        }

    ScaleAnimator {
        target: innerCircleSurroundOutterRing
        running: true
        from: 1
        to: 0.9
        duration: 360000
        loops: Animation.Infinite
        }

    ScaleAnimator {
        target: innerCircleIn
        running: true
        from: 0.8
        to: 1
        duration: 360000
        loops: Animation.Infinite
        }

}
