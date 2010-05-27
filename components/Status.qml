import Qt 4.7

Rectangle {
    property alias text : banner.text

    width: parent.width
    height: 22

    anchors.bottom: parent.bottom
    color: 'gray'

    Text {
        id: banner

        text: 'status'
        textFormat: Text.RichText

        color: "white"

        anchors.centerIn: parent
    }
}
