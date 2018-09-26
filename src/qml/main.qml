import QtQuick 2.9
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.0
import org.kde.kirigami 2.1 as Kirigami

Kirigami.ApplicationWindow {
    id: window
    visible: true
    pageStack.initialPage: mainPageComponent

    onActiveChanged: {
        //mainPageComponent.innerPageComp.testDbus(window.toString());
    }

    onWindowStateChanged: {
        //mainPageComponent.innerPageComp.testDbus("statechanged");
    }

    Connections {
        target: MycroftDbusAdapterInterface
        onSendShowMycroft: {
            window.raise();
            window.requestActivate();
        }
    }

    header: Kirigami.ApplicationHeader {}

           globalDrawer: Kirigami.GlobalDrawer {
               title: "Mycroft AI"
               titleIcon: "mycroft-plasma-appicon"
               drawerOpen: false

                     actions: [
                        Kirigami.Action {
                            text: "Home"
                            onTriggered: {
                                 pageStack.layers.pop(null)
                             }
                         },
                         Kirigami.Action {
                             text: "General Skills"
                             onTriggered: {
                                 pageStack.layers.push(Qt.resolvedUrl("SkillsView.qml"))
                             }
                            },
                            Kirigami.Action {
                            text: "Install Skills"
                            onTriggered:{
                                 pageStack.layers.push(Qt.resolvedUrl("InstallerView.qml"));
                            }
                         }
                        ]
           }

           contextDrawer: Kirigami.OverlayDrawer {
               id: contextDrawer
               edge: Qt.RightEdge
               drawerOpen: false

               contentItem: ColumnLayout {
                                   id: settingscontent

                                   Kirigami.Heading{
                                     id: customSettingHeader
                                     text: "Settings"
                                     color: Kirigami.Theme.highlightedTextColor
                                     anchors.top: parent.top
                                     width: settingscontent.width
                                     Kirigami.Separator {
                                         anchors {
                                             left: parent.left
                                             right: parent.right
                                             bottom: parent.bottom
                                             bottomMargin: Kirigami.Units.gridUnit * 0.1
                                            }
                                        }
                                   }

                                   Label {
                                       id: settingsTabUnits
                                       text: i18n("Mycroft Websocket Path")
                                       color: Kirigami.Theme.highlightedTextColor
                                       anchors.top: customSettingHeader.bottom
                                       }

                                   TextField {
                                           id: settingsTabUnitsWSpath
                                           width: settingscontent.width
                                           anchors.top: settingsTabUnits.bottom
                                           placeholderText: i18n("ws://0.0.0.0:8181/core")
                                           text: i18n("ws://0.0.0.0:8181/core")
                                                }
                                            }
                                        }

              Kirigami.Page{
               id: mainPageComponent
               title: "Home"
               property alias innerPageComp: mainPageSubComp

               MainPage{
                id: mainPageSubComp
                anchors.fill: parent
               }
           }
}
