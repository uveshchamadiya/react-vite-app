# STAGE 1: Build - Updated to Node 20
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# STAGE 2: Production - Updated to Node 20
FROM node:20-alpine
WORKDIR /app

RUN npm install -g serve

# Copy ONLY the build folder
COPY --from=builder /app/dist ./dist

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]