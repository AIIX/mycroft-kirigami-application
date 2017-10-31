import QtQuick 2.9
import QtQml.Models 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
import org.kde.kirigami 2.1 as Kirigami

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

   function testDbus(getState){
       convoLmodel.append({
           "itemType": "NonVisual",
           "InputQuery": getState
       })
   }

   function playwaitanim(recoginit){
       switch(recoginit){
           case "mycroft.skill.handler.start":
               waitanimoutter.opacity = 1
               waitaniminner.playing = true;
               qinput.opacity = 0
               break
           case "recognizer_loop:audio_output_start":
               waitanimoutter.opacity = 0
               waitaniminner.playing = false;
               qinput.opacity = 1
               break
       }
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
                                      //qinput.text = intpost.toString()
                                      //midbarAnim.wsistalking()
                                  }

                                  if (somestring && somestring.data && typeof somestring.data.intent_type !== 'undefined'){
                                      smintent = somestring.data.intent_type;
                                      console.log('intent type: ' + smintent);
                                  }

                                  if(somestring && somestring.data && typeof somestring.data.utterance !== 'undefined' && somestring.type === 'speak'){
                                      filterSpeak(somestring.data.utterance);
                                  }

                                  if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined') {
                                      dataContent = somestring.data.desktop
                                      filterincoming(smintent, dataContent)
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

                Image {
                    id: waitanimoutter
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity: 0
                    height: 60
                    width: 60

//                    AnimatedImage{
//                    id: waitaniminner
//                    anchors.fill: parent
//                    source: "images/anim.gif"
//                    z: 99999
//                    }
                }

//                Image {
//                    id: micTest
//                    anchors.bottom: parent.bottom
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    source: "images/mic.png"
//                    height: 40
//                    width: 40

//                    MouseArea{
//                        anchors.fill: parent
//                        hoverEnabled: true

//                        onEntered: {
//                            micTest.width = "32"
//                            micTest.height = "32"
//                        }

//                        onExited:  {
//                            micTest.width = "40"
//                            micTest.height = "40"
//                        }

//                        onClicked: {
//                            console.log("HERE")
//                            var socketmessage = {};
//                            socketmessage.type = "recognizer_loop:record_begin";
////                            socketmessage.payload = {};
////                            socketmessage.payload.utterance = "self.wakeword_recognizer.key_phrase";
////                            socketmessage.payload.session = "SessionManager.get().session_id";
//                            socket.sendTextMessage(JSON.stringify(socketmessage));
//                        }
//                    }
//                }

                TextField {
                    id: qinput
                    //height: 60
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 78
                    anchors.right: parent.right
                    anchors.rightMargin: 78
                    placeholderText: qsTr("Enter Query or Say 'Hey Mycroft'")
                    onAccepted: {
                        var socketmessage = {};
                        socketmessage.type = "recognizer_loop:utterance";
                        socketmessage.data = {};
                        socketmessage.data.utterances = [qinput.text];
                        socket.sendTextMessage(JSON.stringify(socketmessage));
                        convoLmodel.append({
                            "itemType": "NonVisual",
                            "InputQuery": qinput.text
                        })
                           inputlistView.positionViewAtEnd();

                                             }
                                                 }
                                                   }
}
