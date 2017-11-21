import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

BusyIndicator{
    id: control
    anchors.centerIn: parent
    running: false
    property alias cstanim: control

    contentItem: Item {
            implicitWidth: 120
            implicitHeight: 120

            Rectangle {
                 id: innerCircleOutHoriz
                 anchors.centerIn: parent
                 color: "steelblue"
                 radius: 10
                 implicitWidth: 60
                 implicitHeight: 30
                }

            Rectangle {
                 id: innerCircleOutVert
                 anchors.centerIn: parent
                 color: "steelblue"
                 radius: 10
                 implicitWidth: 30
                 implicitHeight: 60
                }

            Rectangle {
                 id: innerCircleIn
                 anchors.centerIn: parent
                 color: "lightblue"
                 border.color: "steelblue"
                 border.width: 4
                 radius: 100
                 implicitWidth: 50
                 implicitHeight: 50

                 Image {
                     id: innerPulser
                     source: "../images/midanim.png"
                     anchors.centerIn: parent
                     height: 80
                     width: 80
                 }

                 ColorOverlay {
                     anchors.fill: innerPulser
                     source: innerPulser
                     color: "steelblue"
                  }
                }

            RotationAnimator {
                   target: innerCircleOutHoriz
                   running: control.visible && control.running
                   from: 0
                   to: 360
                   loops: Animation.Infinite
                   duration: 600000
            }

            ScaleAnimator {
                target: innerCircleOutHoriz
                running: control.visible && control.running
                from: 1.1
                to: 0.5
                duration: 120000
                loops: Animation.Infinite
            }

            RotationAnimator {
                   target: innerCircleOutVert
                   running: control.visible && control.running
                   from: 0
                   to: 360
                   loops: Animation.Infinite
                   duration: 600000
            }

            ScaleAnimator {
                target: innerCircleOutVert
                running: control.visible && control.running
                from: 1.1
                to: 0.5
                duration: 120000
                loops: Animation.Infinite
            }

            ScaleAnimator {
                target: innerCircleIn
                running: control.visible && control.running
                from: 1
                to: 0.8
                duration: 120000
                loops: Animation.Infinite
            }
          }
        }
