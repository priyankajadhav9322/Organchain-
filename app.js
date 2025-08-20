require('dotenv').config();
const express = require('express');
const donorRoutes = require('./routes/donor');
const recipientRoutes = require('./routes/recipient');
const matchRoutes = require('./routes/match');

const app = express();
app.use(express.json());

app.use('/donor', donorRoutes);
app.use('/recipient', recipientRoutes);
app.use('/match', matchRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
