import Qt 4.7

Rectangle {
    id: status
    property alias text : banner.text

    width: parent.width
    height: 22

    anchors.bottom: parent.bottom
    color: 'green'

    states: [
    State {
        name: "error"
        PropertyChanges {
            target: status
            color: '#ee5757'
        }
    }
    ]

    Text {
        id: banner

        text: 'status'
        textFormat: Text.RichText

        color: "white"

        anchors.centerIn: parent
    }
}
