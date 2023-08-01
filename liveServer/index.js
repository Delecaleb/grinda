var http = require('http');
var express = require('express');
var io = require('socket.io');
var app = express();
var server = http.createServer(app);
var socketServer = io(server);

server.listen(3000, () => {
  console.log('running on 3000');
});

app.get('/', (req, res) => {
  res.send('Connected ');
});

socketServer.on('connection', (socket) => {
  var userEmail = socket.handshake.query.email;
  console.log(`${userEmail} connected`);

  // Join a room based on the user's email (targetId)
  socket.join(userEmail);

  // getting and broadcasting user current location
  socket.on('location-update', (data) => {
    console.log(`current location update from socket server ${data.address}`);
    console.log(`current target update from socket server ${data.targetId}`);
    console.log(`current eta update from socket server ${data.eta}`);

    const targetEmail = data.targetId; // Assuming data.targetId holds the target email

    // Emit the 'update-location' event to the room of the target user (email)
    socket.to(targetEmail).emit('update-location', data);

    // let currentLocation = data.location;
    // convert location data into a street address and time to reach the user
  });

  // Handle socket disconnection and leave the room
  socket.on('disconnect', () => {
    socket.leave(userEmail);
    console.log(`${userEmail} disconnected`);
  });
});
