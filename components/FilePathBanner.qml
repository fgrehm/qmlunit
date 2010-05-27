import Qt 4.7

Rectangle {
    color: "#2b81af"
    width: parent.width
    height: 28

    Text {
        text: testSuiteInput
        font.pixelSize: 18
        color: "lightgray"

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 5
    }
}
