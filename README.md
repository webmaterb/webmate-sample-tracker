## Welcome!
This is sample web application built with Webmate.
Webmate will be moved to separate gem after releasing alpha version.

## Getting Started

### Start server
* $ bundle exec webmate server

### Start console
* $ bundle exec webmate console

## Client Websocket sample:

```
client = Webmate.connect('projects/123')
client.on('tasks/list', function(data) {console.log(data)})
client.send('tasks/list', {gvalmon: "Hello"})
```