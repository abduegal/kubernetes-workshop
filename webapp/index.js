var express = require('express')
var app = express()

var version = process.env.VERSION;
var isHealthy = true;
var isReady = true;
var instance = process.env.HOSTNAME;

app.get('/', function (req, res) {
  res.send('Hello World, Version: ' + version + ' with instance name: ' + instance);
});

app.get('/health', function (req, res) {
  if (isHealthy) {
    res.send('ok');
  } else {
    res.status(400).send('error');
  }
});

app.get('/health/toggle', function (req, res) {
  isHealthy = !isHealthy;
  res.send('changed is healthy status to: ' + isHealthy);
});

app.get('/ready', function (req, res) {
  if (isReady && isHealthy) {
    res.send('ok');
  } else {
    res.status(400).send('error');
  }
});

app.get('/ready/toggle', function (req, res) {
  isReady = !isReady;
  res.send('changed is ready status to: ' + isReady);
});

app.listen(3000)
console.log('Running on port 3000');
