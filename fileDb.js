// File-based Database System
// Replaces MongoDB - stores data in JSON files
const fs = require('fs');
const path = require('path');

class FileDatabase {
    constructor() {
        this.dbDir = path.join(__dirname, '..', 'data');
        this.usersFile = path.join(this.dbDir, 'users.json');
        this.productsFile = path.join(this.dbDir, 'products.json');
        this.ratingsFile = path.join(this.dbDir, 'ratings.json');

        // Ensure data directory exists
        this.ensureDirectoryExists();
        // Initialize database files
        this.initializeFiles();
    }

    ensureDirectoryExists() {
        if (!fs.existsSync(this.dbDir)) {
            fs.mkdirSync(this.dbDir, { recursive: true });
            console.log('Created data directory:', this.dbDir);
        }
    }

    initializeFiles() {
        if (!fs.existsSync(this.usersFile)) {
            fs.writeFileSync(this.usersFile, JSON.stringify([], null, 2));
            console.log('Initialized users database');
        }
        if (!fs.existsSync(this.productsFile)) {
            fs.writeFileSync(this.productsFile, JSON.stringify([], null, 2));
            console.log('Initialized products database');
        }
        if (!fs.existsSync(this.ratingsFile)) {
            fs.writeFileSync(this.ratingsFile, JSON.stringify([], null, 2));
            console.log('Initialized ratings database');
        }
    }

    readJSON(filePath) {
        try {
            const data = fs.readFileSync(filePath, 'utf8');
            return JSON.parse(data) || [];
        } catch (error) {
            console.error('Error reading file:', filePath, error.message);
            return [];
        }
    }

    writeJSON(filePath, data) {
        try {
            fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf8');
            return true;
        } catch (error) {
            console.error('Error writing file:', filePath, error.message);
            return false;
        }
    }

    // USER OPERATIONS
    findUserByEmail(email) {
        const users = this.readJSON(this.usersFile);
        return users.find(u => u.email === email);
    }

    findUserById(id) {
        const users = this.readJSON(this.usersFile);
        return users.find(u => u._id === id);
    }

    createUser(userData) {
        const users = this.readJSON(this.usersFile);

        // Check if user already exists
        if (users.find(u => u.email === userData.email)) {
            throw new Error('User already exists');
        }

        const user = {
            _id: String(Date.now()),
            name: userData.name || '',
            email: userData.email || '',
            password: userData.password || '',
            role: userData.role || 'customer',
            location: userData.location || '',
            imageUrl: userData.imageUrl || 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200',
            phone: userData.phone || '',
            bio: userData.bio || '',
            paymentMethodsCount: userData.paymentMethodsCount || 0,
            isActive: userData.isActive !== undefined ? userData.isActive : true,
            lastLogin: userData.lastLogin || new Date().toISOString(),
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString()
        };

        users.push(user);
        if (!this.writeJSON(this.usersFile, users)) {
            throw new Error('Failed to save user data');
        }
        return user;
    }

    updateUser(id, updateData) {
        const users = this.readJSON(this.usersFile);
        const userIndex = users.findIndex(u => u._id === id);

        if (userIndex === -1) {
            throw new Error('User not found');
        }

        users[userIndex] = {
            ...users[userIndex],
            ...updateData,
            updatedAt: new Date().toISOString()
        };

        if (!this.writeJSON(this.usersFile, users)) {
            throw new Error('Failed to update user data');
        }
        return users[userIndex];
    }

    deleteUser(id) {
        const users = this.readJSON(this.usersFile);
        const userIndex = users.findIndex(u => u._id === id);

        if (userIndex === -1) {
            return null;
        }

        const deletedUser = users.splice(userIndex, 1)[0];
        this.writeJSON(this.usersFile, users);
        return deletedUser;
    }

    getAllUsers() {
        return this.readJSON(this.usersFile);
    }

    // PRODUCT OPERATIONS
    findProductById(id) {
        const products = this.readJSON(this.productsFile);
        return products.find(p => p._id === id);
    }

    findProducts(filter = {}) {
        let products = this.readJSON(this.productsFile);

        if (filter.category) {
            products = products.filter(p => p.category === filter.category);
        }

        if (filter.search) {
            const search = filter.search.toLowerCase();
            products = products.filter(p =>
                p.name.toLowerCase().includes(search) ||
                p.description.toLowerCase().includes(search)
            );
        }

        return products;
    }

    createProduct(productData) {
        const products = this.readJSON(this.productsFile);

        const product = {
            _id: String(Date.now()),
            ...productData,
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString()
        };

        products.push(product);
        this.writeJSON(this.productsFile, products);
        return product;
    }

    updateProduct(id, updateData) {
        const products = this.readJSON(this.productsFile);
        const productIndex = products.findIndex(p => p._id === id);

        if (productIndex === -1) {
            throw new Error('Product not found');
        }

        products[productIndex] = {
            ...products[productIndex],
            ...updateData,
            updatedAt: new Date().toISOString()
        };

        this.writeJSON(this.productsFile, products);
        return products[productIndex];
    }

    deleteProduct(id) {
        const products = this.readJSON(this.productsFile);
        const productIndex = products.findIndex(p => p._id === id);

        if (productIndex === -1) {
            return null;
        }

        const deletedProduct = products.splice(productIndex, 1)[0];
        this.writeJSON(this.productsFile, products);
        return deletedProduct;
    }

    getAllProducts() {
        return this.readJSON(this.productsFile);
    }

    // RATING OPERATIONS
    createRating(ratingData) {
        const ratings = this.readJSON(this.ratingsFile);

        const rating = {
            _id: String(Date.now()),
            ...ratingData,
            createdAt: new Date().toISOString()
        };

        ratings.push(rating);
        this.writeJSON(this.ratingsFile, ratings);
        return rating;
    }

    findRatingsByProductId(productId) {
        const ratings = this.readJSON(this.ratingsFile);
        return ratings.filter(r => r.product === productId);
    }

    getAllRatings() {
        return this.readJSON(this.ratingsFile);
    }

    // DATABASE UTILITIES
    clear() {
        this.writeJSON(this.usersFile, []);
        this.writeJSON(this.productsFile, []);
        this.writeJSON(this.ratingsFile, []);
        console.log('Database cleared');
    }

    getStats() {
        return {
            users: this.readJSON(this.usersFile).length,
            products: this.readJSON(this.productsFile).length,
            ratings: this.readJSON(this.ratingsFile).length
        };
    }

    addSampleData() {
        const users = this.readJSON(this.usersFile);
        const products = this.readJSON(this.productsFile);

        // Add sample user if doesn't exist
        if (!users.find(u => u.email === 'artisan@example.com')) {
            this.createUser({
                name: 'Sample Artisan',
                email: 'artisan@example.com',
                password: 'hashed_password_here',
                role: 'artisan',
                location: 'Yaoundé, Cameroon',
                bio: 'Skilled craftsperson',
                imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200',
                isActive: true
            });
        }

        // Add sample products if don't exist
        if (products.length === 0) {
            const firstUserId = users.length > 0 ? users[0]._id : '1';

            this.createProduct({
                name: "Bamileke Royal Stool",
                description: "Authentic Bamileke royal stool hand-carved from mahogany wood",
                price: 45000,
                category: "Woodwork",
                imageUrl: "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=400",
                stockQuantity: 5,
                artisan: firstUserId
            });

            this.createProduct({
                name: "Ekoi Ancestral Mask",
                description: "Sacred Ekoi ancestral mask carved from ebony wood",
                price: 35000,
                category: "Woodwork",
                imageUrl: "https://images.unsplash.com/photo-1578662996442-48f60103fc96?q=80&w=400",
                stockQuantity: 3,
                artisan: firstUserId
            });
        }
    }
}

// Create and export singleton instance
const db = new FileDatabase();
db.addSampleData();

module.exports = db;