import express from "express";
import http from "http";
import { Server } from "socket.io";
import mongoose from "mongoose";
import roomModel from "./models/room.js";

const app = express();
const port = process.env.PORT || 3000;
const mongooseDb =
  "mongodb+srv://hoangthanhluu1998:LUUthanhhoang1998@cluster0.b8enz99.mongodb.net/?retryWrites=true&w=majority";

const server = http.createServer(app);

const io = new Server(server);

io.on("connection", (socket) => {
  socket.on("createRoom", async ({ nickname }) => {
    //Create room
    try {
      let room = new roomModel();
      let player = {
        socketId: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      const roomId = room._id.toString();
      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (error) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room Id");
        return;
      }

      let room = await roomModel.findById(roomId);
      if (room.isJoin) {
        let player = { nickname, socketId: socket.id, playerType: "O" };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, try again later"
        );
      }
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("tap", async ({ index, roomId }) => {
    try {
      let room = await roomModel.findById(roomId);

      let choice = room.turn.playerType;
      if (room.turnIndex == 0) {
        room.turnIndex = 1;
        room.turn = room.players[1];
      } else {
        room.turnIndex = 0;
        room.turn = room.players[0];
      }
      room = await room.save();
      io.to(roomId).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await roomModel.findById(roomId);

      let player = room.players.find((el) => el.socketId == winnerSocketId);
      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (error) {
      console.log(error);
    }
  });
});

app.use(express.json());
mongoose
  .connect(mongooseDb)
  .then(() => {
    console.log("Connect mongoose successful!");
  })
  .catch((e) => console.log(e));

server.listen(port, "0.0.0.0", () => {
  console.log("Server is running on Port ", port);
});
