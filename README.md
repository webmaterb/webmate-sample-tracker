## Start server
* $ thin start

## Client Websocket sample:

```
client = Webmate.connect('projects/123')
client.on('tasks/list', function(data) {console.log(data)})
client.send('tasks/list', {gvalmon: "Hello"})
```