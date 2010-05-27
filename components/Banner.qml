import Qt 4.7

Rectangle {
    id: resultsBanner

    color: "#0d3349"

    height: 45

    width: parent.width

    Text {
        id: resultsHeader
        text: "QmlUnit"
        font.pixelSize: 25
        font.bold: true
        color: "white"

        anchors.centerIn: parent

        effect: DropShadow {
            blurRadius: 3
            offset.x: 1
            offset.y: 5
            color: "black"
        }
    }
}
