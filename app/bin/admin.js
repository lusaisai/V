var WebSocketServer = require('ws').Server;
var fs = require('fs');

var monitorAndSend = function(ws) {
    process.stdin.on('readable', function(){
        try {
            var chunk = process.stdin.read().toString();
            if(chunk.valueOf() == "stop".valueOf()) process.exit();
            ws.send(chunk);
        } catch (e) {
            process.exit();
        }
    });

};

var wss = new WebSocketServer({port: 8000});

wss.on('connection', function(ws) {
    var info = 'Please say "start" to tell me to start the admin processing.';
    var started = false;
    ws.send(info);
    ws.on('message', function(message) {
        if( message == 'start' && !started ) {
            monitorAndSend(ws);
            console.log('start\n');
            started = true;
        } else if ( started ) {
            ws.send('Already started.')
        } else {
            ws.send(info);
        }
    });
});
