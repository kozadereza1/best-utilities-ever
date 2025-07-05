import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        width: parent.width
        contentHeight: column.height
        height: Math.min(parent.height, contentHeight)
        anchors.verticalCenter: parent.verticalCenter
        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge
            property string question
            property string answer
            Behavior on height { NumberAnimation { duration: 200 } }
            function generate() {
                var pairs = [
                    ["UNDER CONSTRUCTION", "UNDER CONSTRUCTION"]
                ]
                var pair = pairs[Math.floor(Math.random()*pairs.length)]
                question = pair[0]
                answer = pair[1]
                buttonLayout.visible = false
                label.text = qsTr("Скажи %1").arg(question)
                field.visible = true
                field.focus = true
            }
            Component.onCompleted: generate()
            InfoLabel {
                id: label
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextField {
                id: field
                width: parent.width
                Component.onCompleted: focus = true
                placeholderText: column.question

                EnterKey.enabled: text.toLowerCase() == column.question.toLowerCase()
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: {
                    visible = false
                    focus = false
                    label.text = column.answer
                    buttonLayout.visible = true
                }
            }
            ButtonLayout {
                id: buttonLayout
                visible: false
                Button {
                    icon.source: "image://theme/icon-m-refresh"
                    text: qsTr("Попробовать ещё раз")
                    onClicked: column.generate()
                }
            }
        }
    }
}