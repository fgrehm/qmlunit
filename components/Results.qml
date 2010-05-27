import Qt 4.7

Rectangle {
    width: parent.width

    color: '#d2e0e6'

    Flickable {
        clip: true

        width: parent.width

        anchors.fill: parent

        contentHeight: results.height
        contentWidth: results.width

        Text {
            id: results
            text: ""
            textFormat: Text.RichText
        }
    }

    function appendTestCase(line) {
        results.text += '<br />&nbsp;&nbsp;&nbsp;TestCase: <b>' + line + "</b><br />";
    }

    function appendTest(line) {
        results.text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Test: " + line + "<br />";
    }

    function appendResult(line) {
        results.text += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + line + "<br />";
    }
}
