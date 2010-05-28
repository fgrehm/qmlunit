import Qt 4.7

Item {
    id: progressbar

    property int minimum: 0
    property int maximum: 100
    property int value: 0
    property alias color: highlight.color

    width: 250; height: 23
    clip: true

    Rectangle {
        id: box
        width: parent.width;
        height: parent.height
        border.color: 'black'
        border.width: 2
    }

    Rectangle {
        id: highlight

        property int widthDest: ((progressbar.width-2) * (value - minimum)) / (maximum - minimum)

        width: highlight.widthDest

        Behavior on width { SmoothedAnimation { velocity: 1200 } }

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: 1
            topMargin: 1
            bottomMargin: 1
        }
        radius: 1
    }
}
