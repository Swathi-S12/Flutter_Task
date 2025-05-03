const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 5000;

app.use(cors());
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect('mongodb+srv://swathicse2025:lIwqFepkIhM3njYZ@cluster0.9x0i8kk.mongodb.net/plants?retryWrites=true&w=majority&appName=Cluster0', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log("MongoDB connected"))
  .catch((err) => console.error(err));

// Schema & Model
const plantSchema = new mongoose.Schema({
  commonName: String,
  botanicalName: String,
  category: String,
  uses: String,
  price: Number,
  imageUrl: String
});

const Plant = mongoose.model('Plant', plantSchema);

// Routes
app.get('/plants', async (req, res) => {
  const plants = await Plant.find();
  res.json(plants);
});

app.post('/plants', async (req, res) => {
  const newPlant = new Plant(req.body);
  await newPlant.save();
  res.status(201).json(newPlant);
});

app.put('/plants/:id', async (req, res) => {
  const updatedPlant = await Plant.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json(updatedPlant);
});

app.delete('/plants/:id', async (req, res) => {
  await Plant.findByIdAndDelete(req.params.id);
  res.json({ message: 'Plant deleted' });
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
