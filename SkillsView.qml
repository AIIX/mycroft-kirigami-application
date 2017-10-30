import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
import org.kde.kirigami 2.1 as Kirigami

Kirigami.ScrollablePage {
    id: skilltipRoot
    title: "General Skills"

                ListView {
                    id: skillslistmodelview
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    model: SkillModel{}
                    delegate: SkillDelegate{}
                    spacing: 4
                    focus: false
                    interactive: true
                    clip: true;
                }
        }
