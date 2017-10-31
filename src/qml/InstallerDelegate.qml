import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.1 as Kirigami

Kirigami.SwipeListItem {
                id: skillcontent
                Layout.fillWidth: true
                height: Kirigami.Units.gridUnit * 3


//                function getSkillInfoLocal() {
//                var customFold = '/opt/mycroft/skills/'
//                var skillPath = customFold + model.name +'/__init__.py'
//                if(myReader.file_exists_local(skillPath)){
//                    msminstllbtn.visible = false
//                    instlabel.color = "Green"
//                    instlabel.text = "Installed"
//                    }
//                else {
//                    //console.log(skillPath)
//                    instlabel.text = "Not Installed"
//                    }
//                }

                function exec(msmparam) {
                    var bscrpt = innerset.msmloc
                    return launchinstaller.msmapp("x-terminal-emulator --hold -e" + " " + bscrpt + " install " + model.url)
                }

                Component.onCompleted: {
                    //getSkillInfoLocal()
                    //msmSkillInstallProgBar.visible = false;
                }

                RowLayout{
                    id: msmRwlayout
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item {
                        id: skillsplaceholderimage
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32

                    Image {
                         id: innerplaceholderImg
                         source: "images/installer.svg"
                         width: 32
                         height: 32
                         anchors.centerIn: parent
                        }
                    }

                    Column {
                        id: skillcolumn
                        width: parent.width
                        spacing: 6
                        anchors.left: skillsplaceholderimage.right
                        anchors.leftMargin: 10

                    Label {
                         font.capitalization: Font.AllUppercase
                         wrapMode: Text.WordWrap
                         text: model.name
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

                    Label {
                         wrapMode: Text.WordWrap
                         text: model.url
                         color: Kirigami.Theme.textColor
                       }
                     }
                }

//                Button {
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                anchors.verticalCenter: parent.verticalCenter
//                id: msminstllbtn
//                visible: true
//                text: "\u25BC Install"
//                flat: true
//                checked: false
//                focus: false
//                width: 120
//                height: 42

//                onClicked: {
//                    console.log(model.url)
//                    var msmprogress = exec()
//                    var getcurrentprogress = msmprogress.split("\n")
//                    console.log(getcurrentprogress);
//                    if(getcurrentprogress.indexOf("Cloning repository") != -1)
//                        {
//                         msmSkillInstallProgBar.visible = true;
//                         msmSkillInstallProgBar.indeterminate = true;
//                        }
//                    if(getcurrentprogress.indexOf("Skill installed!") != -1)
//                        {
//                        msmSkillInstallProgBar.indeterminate = false;
//                        msmSkillInstallProgBar.value = 100;
//                        instlabel.color = "Green"
//                        instlabel.text = "Installed"
//                        }
//                    }

//                }

//                ProgressBar {
//                    anchors.right: parent.right
//                    anchors.rightMargin: 2
//                    anchors.bottom: parent.bottom
//                    width: 40
//                    id: msmSkillInstallProgBar
//                    visible: false
//                    indeterminate: false
//                }

                }

