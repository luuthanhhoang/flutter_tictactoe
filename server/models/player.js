import mongoose from "mongoose";

const PlayerSchema = new mongoose.Schema({
  nickname: {
    type: String,
    trim: true,
  },
  socketId: {
    type: String,
  },
  points: {
    type: Number,
    default: 0,
  },
  playerType: {
    required: true,
    type: String,
  },
});

export default PlayerSchema;
