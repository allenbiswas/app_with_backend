import express from 'express';
import {
  getAllData,
  getDataById,     
  addData,
  updateData,
  deleteData
} from '../controllers/dataController.js';

const router = express.Router();

router.get('/', getAllData);         
router.get('/:id', getDataById);    
router.post('/', addData);   
router.put('/:id', updateData);        
router.delete('/:id', deleteData);  

export default router;
