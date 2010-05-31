import Qt 4.7
import "components"

TestRunner {
    id: runner

    property variant logger : logger

    QmlLogger { id: logger }
}
