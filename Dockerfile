# Use official Node.js image as base
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Start the app
CMD ["npm", "start"]

# Expose port (adjust if needed)
EXPOSE 3000
