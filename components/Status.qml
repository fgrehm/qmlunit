import Qt 4.7

Rectangle {
    id: status
    property int totalTests : 0
    property int testsRan : 0
    property int totalAssertions : 0
    property int totalFailures : 0

    width: parent.width
    height: progressBar.height + banner.height

    onTestsRanChanged: {
        if (testsRan == totalTests)
            state = 'completed';
    }

    states: [
        State {
            name: "loading"
            PropertyChanges {
                target: banner
                text: 'Loading tests... (' + totalTests + ' found so far)'
            }
        },
        State {
            name: "running"
            PropertyChanges {
                target: banner
                text: totalTests + ' tests, ' + testsRan + ' completed, ' + totalAssertions + ' assertions, ' + totalFailures + ' tests failed'
            }
        },
        State {
            name: "completed"
            PropertyChanges {
                target: banner
                text: '<b>Finished!</b> ' + totalTests + ' tests, ' + testsRan + ' completed, ' + totalAssertions + ' assertions, ' + totalFailures + ' tests failed'
            }
        }
    ]

    ProgressBar {
        id: progressBar
        maximum: totalTests
        width: parent.width
        value: testsRan
        color: (totalFailures > 0) ? 'red' : 'green'
    }

    Text {
        id: banner

        textFormat: Text.RichText

        color: "black"

        anchors.top: progressBar.bottom
        anchors.topMargin: 2

        anchors.horizontalCenter: parent.horizontalCenter
    }
}
