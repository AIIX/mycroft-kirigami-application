import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.1 as Kirigami

Kirigami.AbstractListItem {
        id: skillDelegate
        height: Kirigami.Units.gridUnit * 5

        ColumnLayout {
            id: skillcontent
            Layout.fillWidth: true;
            Layout.fillHeight: true;

            RowLayout {
            id: skillTopRowLayout
            spacing: 5
            anchors.fill: parent

            Label {
                id: innerskllname
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap;
                font.bold: true;
                text: qsTr('<b>' + model.Skill + '</b>')
                color: Kirigami.Theme.textColor
                Kirigami.Separator {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        bottomMargin: Kirigami.Units.gridUnit * -0.2
                       }
                    color: Kirigami.Theme.linkColor
                   }
                }

            Item {
                id: skilltipsimage
                anchors.left: parent.left
                anchors.top: innerskllname.bottom
                anchors.topMargin: Kirigami.Units.gridUnit * 0.6
                anchors.bottom: parent.bottom
                width: 32

            Image {
             id: innerskImg
             source: model.Pic
             width: 32
             height: 32
             anchors.centerIn: parent
                }
            }

            Item {
            id: skilltipsinner
            anchors.left: skilltipsimage.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: innerskllname.bottom
            anchors.topMargin: Kirigami.Units.gridUnit * 0.6
            anchors.bottom: parent.bottom

            Column{
                id: innerskillscolumn
                spacing: 2

            Label {wrapMode: Text.WordWrap; width: skillDelegate.width; color: Kirigami.Theme.textColor ; text: qsTr('<b>Command:</b> ' + model.CommandList.get(0).Commands)}
            Label {wrapMode: Text.WordWrap; width: skillDelegate.width; color: Kirigami.Theme.textColor ; text: qsTr('<b>Command:</b> ' + model.CommandList.get(1).Commands)}
                }
                    }
                        }
                            }
                                }
