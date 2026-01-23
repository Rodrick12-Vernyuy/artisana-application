// Mock In-Memory Database for Development
// This provides a fallback when MongoDB is not available

class MockDatabase {
    constructor() {
        this.users = [];
        this.products = [];
        this.ratings = [];
        this.cartItems = [];
        this.nextUserId = 1;
        this.nextProductId = 1;
        this.nextRatingId = 1;
    }

    // User operations
    findUserByEmail(email) {
        return this.users.find(u => u.email === email);
    }

    createUser(userData) {
        const user = {
            _id: String(this.nextUserId++),
            ...userData,
            createdAt: new Date(),
            updatedAt: new Date()
        };
        this.users.push(user);
        return user;
    }

    findUserById(id) {
        return this.users.find(u => u._id === id);
    }

    updateUser(id, data) {
        const user = this.findUserById(id);
        if (user) {
            Object.assign(user, data);
            user.updatedAt = new Date();
        }
        return user;
    }

    deleteUser(id) {
        const index = this.users.findIndex(u => u._id === id);
        if (index > -1) {
            return this.users.splice(index, 1)[0];
        }
        return null;
    }

    // Product operations
    findProductById(id) {
        return this.products.find(p => p._id === id);
    }

    findProducts(filter = {}) {
        let results = this.products;
        if (filter.category) {
            results = results.filter(p => p.category === filter.category);
        }
        if (filter.search) {
            const search = filter.search.toLowerCase();
            results = results.filter(p =>
                p.name.toLowerCase().includes(search) ||
                p.description.toLowerCase().includes(search)
            );
        }
        return results;
    }

    createProduct(productData) {
        const product = {
            _id: String(this.nextProductId++),
            ...productData,
            createdAt: new Date(),
            updatedAt: new Date()
        };
        this.products.push(product);
        return product;
    }

    updateProduct(id, data) {
        const product = this.findProductById(id);
        if (product) {
            Object.assign(product, data);
            product.updatedAt = new Date();
        }
        return product;
    }

    deleteProduct(id) {
        const index = this.products.findIndex(p => p._id === id);
        if (index > -1) {
            return this.products.splice(index, 1)[0];
        }
        return null;
    }

    // Rating operations
    createRating(ratingData) {
        const rating = {
            _id: String(this.nextRatingId++),
            ...ratingData,
            createdAt: new Date()
        };
        this.ratings.push(rating);
        return rating;
    }

    findRatingsByProductId(productId) {
        return this.ratings.filter(r => r.product === productId);
    }

    // Cart operations
    addToCart(item) {
        this.cartItems.push({...item, _id: String(Date.now()) });
        return item;
    }

    getCart() {
        return this.cartItems;
    }

    clearCart() {
        this.cartItems = [];
    }

    // Database utilities
    clear() {
        this.users = [];
        this.products = [];
        this.ratings = [];
        this.cartItems = [];
    }

    getStats() {
        return {
            users: this.users.length,
            products: this.products.length,
            ratings: this.ratings.length,
            cartItems: this.cartItems.length
        };
    }
}

// Create a singleton instance
const mockDb = new MockDatabase();

// Add sample data for testing
mockDb.createProduct({
    name: "Bamileke Royal Stool",
    description: "Authentic Bamileke royal stool hand-carved from mahogany wood",
    price: 45000,
    category: "Woodwork",
    imageUrl: "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=400",
    stockQuantity: 5,
    artisan: "1"
});

mockDb.createProduct({
    name: "Ekoi Ancestral Mask",
    description: "Sacred Ekoi ancestral mask carved from ebony wood",
    price: 35000,
    category: "Woodwork",
    imageUrl: "https://images.unsplash.com/photo-1578662996442-48f60103fc96?q=80&w=400",
    stockQuantity: 3,
    artisan: "1"
});

module.exports = mockDb;