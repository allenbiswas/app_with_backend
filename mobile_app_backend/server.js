import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';
import dataRoutes from './routes/dataRoutes.js';
import authRoutes from './routes/authRoutes.js';

dotenv.config(); // Load .env

const app = express();
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/flutter_app';

// Middlewares
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/data', dataRoutes);
app.use('/api/auth', authRoutes); 

// Test route
app.get('/', (req, res) => {
  res.send('Flutter Backend is Running...');
});

// MongoDB connection
mongoose.connect(MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log('✅ MongoDB Connected');
  app.listen(PORT, () => console.log(`🚀 Server running on http://localhost:${PORT}`));
}).catch(err => {
  console.error('❌ MongoDB connection failed:', err);
});
