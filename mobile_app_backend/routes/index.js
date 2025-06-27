import express from 'express';
import mongoose from 'mongoose';
import dataRoutes from './routes/dataRoutes.js';
import authRoutes from './routes/authRoutes.js';

const app = express();
app.use(express.json());

app.use('/api/data', dataRoutes);
app.use('/api/auth', authRoutes);

// DB & server
mongoose.connect('mongodb://localhost:27017/flutter_app')
  .then(() => app.listen(5000, () => console.log("Server running")))
  .catch(err => console.error(err));
