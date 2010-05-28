import Qt 4.7

Rectangle {
    width: parent.width
    color: '#d2e0e6'

    ListView {
        id: view

        anchors.fill: parent
        clip: true
        spacing: 10

        model: VisualDataModel {
            model: ListModel {
                id: results
            }

            delegate: Column {
                width: parent.width

                Rectangle {
                    width: parent.width - 1
                    height: banner.height + 2

                    color: (failures > 0) ? 'red' : '#2b81af'

                    border.width: 1
                    border.color: "black"

                    Text {
                        x: 5
                        y: 1
                        id:banner
                        text: name // from model
                        font.pixelSize: 18
                        color: (failures > 0) ? 'white' : "lightgray"
                    }
                }

                Repeater {
                    model: tests // from model

                    Rectangle {
                        id: delegate
                        height: label.height
                        width: parent.width - 1
                        border.width: 1
                        border.color: "black"
                        color: 'lightyellow'

                        states: State {
                            name: "details"

                            // "Stretches" box
                            PropertyChanges { target: delegate; height: details.height + label.height; }
                            // Make details visible
                            PropertyChanges { target: details; opacity: 1; }
//                            // Move the list so that this item is at the top.
//                            PropertyChanges { target: view; explicit: true; contentY: delegate.y }
                        }

                        transitions: [
                            Transition {
                                from: ""
                                to: "details"
                                SequentialAnimation {
                                    NumberAnimation { duration: 150; properties: "height" }
                                    NumberAnimation { duration: 50; properties: "opacity" }
                                }
                            },
                            Transition {
                                from: "details"
                                to: ""
                                SequentialAnimation {
                                    NumberAnimation { duration: 50; properties: "opacity" }
                                    NumberAnimation { duration: 150; properties: "height" }
                                }
                            }
                        ]

                        Text {
                            id: label
                            x: 5
                            y: 2
                            height: 20
                            text: (index+1) + '. <b>' + name + '</b>'
                            color: (failures > 0) ? 'red' : '#2e8cbd'
                        }

                        Item {
                            id: details
                            width: parent.width
                            height: col.height
                            clip: true
                            anchors.top: label.bottom
                            opacity: 0

                            Column {
                                id: col

                                Repeater {
                                    model: assertions

                                    Text {
                                        x: 30
                                        text: (index+1) + '. ' + (message ? message : '(no message)')
                                        height: 20
                                        color: result ? 'green' : 'red'
                                    }
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: delegate
                            onClicked: {
                                delegate.state = (delegate.state == 'details') ? '' : 'details';
                            }
                        }
                    }
                }
            }
        }
    }

    function appendTestCase(tc) {
        results.append(tc);
    }

    function appendTest(test) {
        var item = results.get(results.count - 1);
        results.setProperty((results.count - 1), 'failures', item.failures + test.failures);
        item.tests.append(test);
    }
}
