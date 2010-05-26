.pragma library

function click(element) {
    element.clicked({
        button: Qt.LeftButton,
        buttons: 0,
        modifiers: Qt.NoModifier
    });
}

// TODO: it would be easier if there was some way to disconnect all signals
var signals = [];
function connect(sig, func) {
    signals.unshift([sig, func]);
    sig.connect(func);
}
function disconnectAll() {
    var entry;
    while (entry = signals.pop())
        entry[0].disconnect(entry[1]);
}
