import mongoose from 'mongoose';

const dataSchema = new mongoose.Schema({
  name: { type: String, required: true },
  phone: { type: String, required: true },
  email: { type: String, required: true },
  address: { type: String, required: true }
}, { timestamps: true });

export default mongoose.model('Data', dataSchema);
