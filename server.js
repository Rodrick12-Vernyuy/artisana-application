const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();

// Security middleware
app.use(helmet());
app.use(cors({
    origin: true, // Allow all origins for development
    credentials: true
}));

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per windowMs
});
app.use('/api/', limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Database connection
let mongoConnected = false;
let mongoConnectionAttempt = false;

// Try to connect to MongoDB with a longer timeout and retry logic
async function connectDB() {
    const mongoUri = process.env.MONGODB_URI || 'mongodb://localhost:27017/artisanal';

    return new Promise((resolve) => {
        const timeout = setTimeout(() => {
            mongoConnected = false;
            mongoConnectionAttempt = true;
            console.error('MongoDB connection timeout');
            console.log('Starting server in offline mode with in-memory data store...');
            console.log('NOTE: Data will not persist between server restarts');
            resolve();
        }, 8000);

        mongoose.connect(mongoUri, {
                useNewUrlParser: true,
                useUnifiedTopology: true,
                serverSelectionTimeoutMS: 5000,
                connectTimeoutMS: 5000,
                retryWrites: false,
            })
            .then(() => {
                clearTimeout(timeout);
                mongoConnected = true;
                mongoConnectionAttempt = true;
                console.log('MongoDB connected successfully');
                resolve();
            })
            .catch((err) => {
                clearTimeout(timeout);
                mongoConnected = false;
                mongoConnectionAttempt = true;
                console.error('MongoDB connection failed:', err.message);
                console.log('Starting server in offline mode...');
                resolve();
            });
    });
}

// Initiate database connection
connectDB();

// Routes - wrapped in try-catch to handle schema registration failures
try {
    // Use mock auth routes when MongoDB is not available
    if (!mongoConnected) {
        console.log('Using mock authentication (file-based storage)');
        app.use('/api/auth', require('./routes/auth-mock'));
    } else {
        console.log('Using Mongoose authentication (MongoDB storage)');
        app.use('/api/auth', require('./routes/auth'));
    }
} catch (error) {
    console.error('Error loading auth routes:', error.message);
}

// Try to load other routes - they may fail if Mongoose is not connected
try {
    app.use('/api/products', require('./routes/products'));
} catch (error) {
    console.warn('Products route unavailable:', error.message);
    // Create a fallback route
    app.get('/api/products', (req, res) => {
        res.json({ success: true, data: [], message: 'Products unavailable - database not connected' });
    });
}

try {
    app.use('/api/ratings', require('./routes/ratings'));
} catch (error) {
    console.warn('Ratings route unavailable:', error.message);
}

try {
    app.use('/api/cart', require('./routes/cart'));
} catch (error) {
    console.warn('Cart route unavailable:', error.message);
}

// try {
//     app.use('/api/orders', require('./routes/orders'));
// } catch (error) {
//     console.warn('Orders route unavailable:', error.message);
// Health check
app.get('/api/health', (req, res) => {
    res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({
        success: false,
        message: 'Something went wrong!',
        error: process.env.NODE_ENV === 'development' ? err.message : {}
    });
});

// 404 handler
app.use('*', (req, res) => {
    res.status(404).json({
        success: false,
        message: 'API endpoint not found'
    });
});

const PORT = process.env.PORT || 5000;

// Delay server startup slightly to allow database connection attempt
setTimeout(() => {
    app.listen(PORT, () => {
        console.log(`\nServer running on port ${PORT}`);
        console.log(`Database status: ${mongoConnected ? 'Connected to MongoDB' : 'Offline mode (in-memory)'}`);
    });
}, 2000);

module.exports = app;