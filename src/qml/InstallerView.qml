import QtQuick 2.9
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
import org.kde.kirigami 2.1 as Kirigami


Kirigami.ScrollablePage {
    id: skilltipRoot
    title: "Install New Skills"

    property var skillList: []

    function getSkillByName(skillName){
        var tempSN=[];
        for(var i = 0; i <skillList.length;i++){
            var sList = skillList[i].name;
            if(sList.indexOf(skillName) !== -1){
                tempSN.push(skillList[i]);
            }
        }
        return tempSN;
    }

    function getSkills() {
      var doc = new XMLHttpRequest()
      var url = "https://raw.githubusercontent.com/MycroftAI/mycroft-skills/master/.gitmodules"
      doc.open("GET", url, true);
      doc.send();

      doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
          var path, list;
          var tempRes = doc.responseText
          var moduleList = tempRes.split("[");
          for (var i = 1; i < moduleList.length; i++) {
            path = moduleList[i].substring(moduleList[i].indexOf("= ") + 2, moduleList[i].indexOf("url")).replace(/^\s+|\s+$/g, '');
            url = moduleList[i].substring(moduleList[i].search("url =") + 6).replace(/^\s+|\s+$/g, '');
            skillList[i-1] = {"name": path, "url": url};
            msmskillsModel.reload();
          }
        }
      }
    }

    function refreshAllSkills(){
        getSkills();
        msmskillsModel.reload();
    }

    function getAllSkills(){
        if(skillList.length <= 0){
            getSkills();
        }
        return skillList;
}

        ListModel {
            id: msmskillsModel

            Component.onCompleted: {
                reload();
                //console.log('Completing too early?');
            }

             function reload() {
                var skList = getAllSkills();
                msmskillsModel.clear();
                for( var i=0; i < skList.length ; ++i ) {
                    msmskillsModel.append(skList[i]);
                }
            }

            function applyFilter(skName) {
                var skList = getSkillByName(skName);
                msmskillsModel.clear();
                for( var i=0; i < skList.length ; ++i ) {
                    msmskillsModel.append(skList[i]);
                }
            }

        }

        ListView {
            id: msmlistView
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            model: msmskillsModel
            delegate: InstallerDelegate {}
            spacing: 4
            focus: false
            interactive: true
            clip: true;
            }

        footer: Item {
            id: msmtabtopbar
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50

            TextField {
            id: msmsearchfld
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.right: getskillsbx.left
            placeholderText: qsTr("Search Skills")

            onTextChanged: {
            if(text.length > 0 ) {
                msmskillsModel.applyFilter(text.toLowerCase());
            } else {
                msmskillsModel.reload();
            }
        }
    }

        ToolButton {
                id: getskillsbx
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                text: "\u27F3"
                flat: true
                width: Math.round(40)
                height: width
                z: 102

                onClicked: {
                        msmskillsModel.clear();
                        refreshAllSkills();
                    }
                }
        }
}
