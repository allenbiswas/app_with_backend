import Data from "../models/datamodel.js";

export const getAllData = async (req, res) => {
  try {
    const data = await Data.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getDataById = async (req, res) => {
  try {
    const data = await Data.findById(req.params.id);
    if (!data) return res.status(404).json({ message: "Data not found" });
    res.json(data);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const addData = async (req, res) => {
  const { name, phone, email, address } = req.body;
  try {
    const newData = new Data({ name, phone, email, address });
    await newData.save();
    res.status(201).json(newData);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

export const updateData = async (req, res) => {
  try {
    const { name, phone, email, address } = req.body;

    const updatedData = await Data.findByIdAndUpdate(
      req.params.id,
      { name, phone, email, address },
      { new: true, runValidators: true }
    );

    if (!updatedData) {
      return res.status(404).json({ message: "Data not found" });
    }

    res.json(updatedData);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const deleteData = async (req, res) => {
  try {
    const result = await Data.findByIdAndDelete(req.params.id);
    if (!result) return res.status(404).json({ message: "Data not found" });
    res.json({ message: "Deleted successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
