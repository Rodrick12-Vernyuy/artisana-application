// Setup script to initialize the database with sample data
const mongoose = require('mongoose');
const User = require('./models/User');
const Product = require('./models/Product');
require('dotenv').config();

const sampleUsers = [{
        name: 'Alice Johnson',
        email: 'alice@example.com',
        password: 'password123',
        role: 'artisan',
        location: 'Yaoundé, Cameroon',
        bio: 'Passionate woodworker specializing in traditional Cameroonian furniture.'
    },
    {
        name: 'Bob Smith',
        email: 'bob@example.com',
        password: 'password123',
        role: 'customer',
        location: 'Douala, Cameroon'
    }
];

const sampleProducts = [{
        name: "Bamileke Royal Stool",
        description: "Authentic Bamileke royal stool hand-carved from mahogany wood, featuring traditional geometric patterns and symbols of authority from the West Region of Cameroon.",
        price: "45000",
        category: "Woodwork",
        imageUrl: "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=400",
        stockQuantity: 5
    },
    {
        name: "Ekoi Ancestral Mask",
        description: "Sacred Ekoi ancestral mask carved from ebony wood, used in traditional ceremonies and representing spiritual protection.",
        price: "35000",
        category: "Woodwork",
        imageUrl: "https://images.unsplash.com/photo-1578662996442-48f60103fc96?q=80&w=400",
        stockQuantity: 3
    },
    {
        name: "Kente-Inspired Wrapper",
        description: "Handwoven textile wrapper inspired by Ghanaian Kente cloth, featuring vibrant colors and traditional African patterns.",
        price: "28000",
        category: "Textile",
        imageUrl: "https://images.unsplash.com/photo-1594736797933-d0401ba2fe65?q=80&w=400",
        stockQuantity: 8
    },
    {
        name: "Indigo Tie-Dye Scarf",
        description: "Traditional indigo-dyed scarf using ancient African tie-dye techniques, creating beautiful blue patterns on cotton fabric.",
        price: "15000",
        category: "Textile",
        imageUrl: "https://images.unsplash.com/photo-1601924582970-9238bcb495d9?q=80&w=400",
        stockQuantity: 12
    },
    {
        name: "Tubu Bead Necklace",
        description: "Handcrafted bead necklace featuring traditional African trade beads and cowrie shells, symbolizing wealth and status.",
        price: "12000",
        category: "Jewelry",
        imageUrl: "https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?q=80&w=400",
        stockQuantity: 15
    },
    {
        name: "Zulu-Inspired Bracelet",
        description: "Sterling silver bracelet inspired by Zulu beadwork, featuring intricate patterns and traditional African symbolism.",
        price: "18000",
        category: "Jewelry",
        imageUrl: "https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=400",
        stockQuantity: 7
    }
];

async function setupDatabase() {
    try {
        await mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/artisanal');
        console.log('Connected to MongoDB');

        // Clear existing data
        await User.deleteMany({});
        await Product.deleteMany({});
        console.log('Cleared existing data');

        // Create sample users
        const users = await User.create(sampleUsers);
        console.log('Created sample users');

        // Create sample products with artisan references
        const artisan = users.find(u => u.role === 'artisan');
        const productsWithArtisan = sampleProducts.map(product => ({
            ...product,
            artisan: artisan._id
        }));

        await Product.create(productsWithArtisan);
        console.log('Created sample products');

        console.log('Database setup completed successfully!');
        console.log(`Created ${users.length} users and ${sampleProducts.length} products`);

    } catch (error) {
        console.error('Setup failed:', error);
    } finally {
        await mongoose.connection.close();
        console.log('Database connection closed');
    }
}

// Run setup if this file is executed directly
if (require.main === module) {
    setupDatabase();
}

module.exports = setupDatabase;