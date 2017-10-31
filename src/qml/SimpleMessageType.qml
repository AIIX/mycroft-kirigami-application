import QtQuick 2.9
import QtQml.Models 2.3
import QtQuick.Controls 2.2
import org.kde.kirigami 2.1 as Kirigami

Column {
                    spacing: 6
                    anchors.right: parent.right

                    readonly property bool sentByMe: model.recipient !== "User"
                    property alias mssg: messageText.text
                        
                    Row {
                        id: messageRow
                        spacing: 6
                            
                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: messageText.implicitHeight + 24
                        color: Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
                        
                    Label {
                        id: messageText
                        text: model.InputQuery
                        anchors.fill: parent
                        anchors.margins: 12
                        wrapMode: Label.WrapAnywhere
                        color: Kirigami.Theme.textColor
                        
                        }
                            }
                                }
                                    }
