import QtQuick 2.9
import QtQml.Models 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.0
import org.kde.kirigami 2.1 as Kirigami
import QtGraphicalEffects 1.0 

Kirigami.ScrollablePage {
   id: pageRoot

   background: Rectangle {
           color: Kirigami.Theme.backgroundColor
   }
   title: "Home"
   property alias mainpage: pageRoot
   property var smintent
   property var dataContent
   property alias cbwidth: pageRoot.width
   property alias autoCompModel: completionItems
   property alias textInput: qinput

   function testDbus(getState){
       convoLmodel.append({
           "itemType": "NonVisual",
           "InputQuery": getState
       })
   }
   
    function toggleInputMethod(selection){
        switch(selection){
        case "KeyboardSetActive":
            qinput.visible = true
            customMicIndicator.visible = false
            keybindic.color = "green"
            break
        case "KeyboardSetDisable":
            qinput.visible = false
            customMicIndicator.visible = true
            keybindic.color = Kirigami.Theme.textColor
            break
        }
   } 

   function playwaitanim(recoginit){
       switch(recoginit){
       case "recognizer_loop:record_begin":
               drawer.open()
               waitanimoutter.cstanim.running = true
               break
           case "recognizer_loop:audio_output_start":
               drawer.close()
               waitanimoutter.cstanim.running = false
               break
           case "mycroft.skill.handler.complete":
               drawer.close()
               waitanimoutter.cstanim.running = false
               break
       }
   }
   
    function autoAppend(model, getinputstring, setinputstring) {
        for(var i = 0; i < model.count; ++i)
            if (getinputstring(model.get(i))){
                console.log(model.get(i))
                    return true
            }
          return null
        }


   function filterSpeak(msg){
              convoLmodel.append({
                  "itemType": "NonVisual",
                  "InputQuery": msg
              })
                 inputlistView.positionViewAtEnd();
          }

          function filterincoming(intent, metadata) {
              var intentVisualArray = ['CurrentWeatherIntent'];
                      var itemType
                      var filterintentname = intent.split(':');
                      var intentname = filterintentname[1];

              if (intentVisualArray.indexOf(intentname) !== -1) {
                      switch (intentname){
                      case "CurrentWeatherIntent":
                          itemType = "CurrentWeather"
                          break;
                      }

                    convoLmodel.append({"itemType": itemType, "itemData": metadata})
                      }

              else {
                  convoLmodel.append({"itemType": "WebViewType", "InputQuery": metadata.url})
              }
          }
          
              function filtervisualObj(metadata){
                convoLmodel.append({"itemType": "LoaderType", "InputQuery": metadata.url})
                inputlistView.positionViewAtEnd();
          }

          function clearList() {
                  inputlistView.clear()
  }

          WebSocket {
                  id: socket
                  url: "ws://0.0.0.0:8181/core"
                  onTextMessageReceived: {
                      var somestring = JSON.parse(message)
                                  console.log(message)
                                  //filterdbg(message)
                                  var msgType = somestring.type;
                                   playwaitanim(msgType);
                                  //qinput.focus = false;

                                  if (msgType === "recognizer_loop:utterance") {
                                      var intpost = somestring.data.utterances;
                                      qinput.text = intpost.toString()
                                     convoLmodel.append({"itemType": "AskType", "InputQuery": intpost.toString()})
                                  }

                                  if (somestring && somestring.data && typeof somestring.data.intent_type !== 'undefined'){
                                      smintent = somestring.data.intent_type;
                                      console.log('intent type: ' + smintent);
                                  }

                                  if(somestring && somestring.data && typeof somestring.data.utterance !== 'undefined' && somestring.type === 'speak'){
                                      filterSpeak(somestring.data.utterance);
                                  }

                                  if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "data") {
                                      dataContent = somestring.data.desktop
                                      filterincoming(smintent, dataContent)
                                  }
                                  
                                  if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type == "visualObject") {
                                    dataContent = somestring.data.desktop
                                    filtervisualObj(dataContent)
                                    }

                                  //midbarAnim.wsistalking()
                  }

                  onStatusChanged: if (socket.status == WebSocket.Error) {
                                           //connectws.text = "Error"
                                           //connectws.color = "red"
                                           //startmycservice.circolour = "red"
                                    } else if (socket.status == WebSocket.Open) {
                                           //connectws.text = "Ready"
                                           //connectws.color = "green"
                                           //startmycservice.circolour = "green"
                                    } else if (socket.status == WebSocket.Closed) {
                                           //connectws.text = "Closed"
                                           //connectws.color = "white"
                                    } else if (socket.status == WebSocket.Connecting) {
                                           //connectws.text = "Starting.."
                                           //connectws.color = "white"
                                    } else if (socket.status == WebSocket.Closing) {
                                           //connectws.text = "Shutting.."
                                           //connectws.color = "blue"
                                           //startmycservice.circolour = "#1e4e62"
                                    }


                  active: true
          }

          ListModel{
          id: convoLmodel
          }

            ListView {
                id: inputlistView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                verticalLayoutDirection: ListView.TopToBottom
                spacing: 12
                clip: true
                model: convoLmodel
                delegate:  Component {
                           Loader {
                               source: switch(itemType) {
                                       case "NonVisual": return "SimpleMessageType.qml"
                                       case "WebViewType": return "WebViewType.qml"
                                       case "CurrentWeather": return "CurrentWeatherType.qml"
                                       case "DropImg" : return "ImgRecogType.qml"
                                       case "LoaderType" : return "LoaderType.qml"
                                       case "AskType" : return "AskMessageType.qml"
                                       }
                                property var metacontent : dataContent
                               }
                       }

            onCountChanged: {
                inputlistView.positionViewAtEnd();
                           }
                                             }

            footer:
                Rectangle{
                id: bottombar
                anchors.left: parent.left
                anchors.right: parent.right
                height:60
                color: Kirigami.Theme.backgroundColor
                
                ListModel {
                    id: completionItems
                }

                Drawer {
                    id: drawer
                    width: parent.width
                    height: 0.22 * pageRoot.height
                    edge: Qt.BottomEdge

                    background: Rectangle {
                            color: Kirigami.Theme.backgroundColor
                    }

                     CustomIndicator {
                         id: waitanimoutter
                         anchors.centerIn: parent
                         height: 80
                         width: 80
                     }
                }
                
                CustomMicIndicator {
                    id: customMicIndicator
                    anchors.centerIn: parent
                    anchors.bottomMargin: 22

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            customMicIndicator.inCircle = Qt.lighter(Kirigami.Theme.linkColor, 1.2)
                        }
                        onExited: {
                            customMicIndicator.inCircle = "lightblue"
                        }
                        onClicked: {
                            var socketmessage = {};
                            socketmessage.type = "mycroft.mic.listen";
                            socketmessage.data = {};
                            socketmessage.data.utterances = [];
                            socket.sendTextMessage(JSON.stringify(socketmessage));
                        }
                     }
                   }
                
                Rectangle {
                    id: keyboardactivaterect
                    color: Kirigami.Theme.backgroundColor
                    border.width: 1
                    border.color: Qt.lighter(Kirigami.Theme.backgroundColor, 1.2)
                    width: Kirigami.Units.gridUnit * 2
                    height: qinput.height
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: Kirigami.Units.gridUnit * 2.5

                    Image {
                        id: keybdImg
                        source: "../images/keyboard.png"
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                    }

                    ColorOverlay {
                        anchors.fill: keybdImg
                        source: keybdImg
                        color: Kirigami.Theme.textColor
                    }

                    Rectangle {
                        id: keybindic
                        anchors.top: keybdImg.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        height: 2
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {}
                        onExited: {}
                        onClicked: {
                            if(qinput.visible === false){
                                toggleInputMethod("KeyboardSetActive")
                                }
                            else if(qinput.visible === true){
                                toggleInputMethod("KeyboardSetDisable")
                                }
                            }
                        }
                    }

                TextField {
                    id: qinput
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.right: parent.right
                    anchors.rightMargin: 90
                    visible: false
                    placeholderText: qsTr("Enter Query or Say 'Hey Mycroft'")
                    onAccepted: {
                        var doesExist = autoAppend(autoCompModel, function(item) { return item.name === qinput.text }, qinput.text)
                        var evaluateExist = doesExist
                        if(evaluateExist === null){
                                    autoCompModel.append({"name": qinput.text});
                        }
                        var socketmessage = {};
                        socketmessage.type = "recognizer_loop:utterance";
                        socketmessage.data = {};
                        socketmessage.data.utterances = [qinput.text];
                        socket.sendTextMessage(JSON.stringify(socketmessage));
                        inputlistView.positionViewAtEnd();
                                }
                                
                    onTextChanged: {
                        evalAutoLogic();
                        }
                    }
                                                 
            }
        }
