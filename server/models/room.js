import mongoose from "mongoose";
import PlayerSchema from "./player.js";

const RoomSchema = new mongoose.Schema({
  occupancy: {
    type: Number,
    default: 2,
  },
  maxRounds: {
    type: Number,
    default: 6,
  },
  currentRound: {
    type: Number,
    required: true,
    default: 1,
  },
  players: [PlayerSchema],
  isJoin: {
    type: Boolean,
    default: true,
  },
  turn: PlayerSchema,
  turnIndex: {
    type: Number,
    default: 0,
  },
});

const roomModel = mongoose.model("Room", RoomSchema);

export default roomModel;
