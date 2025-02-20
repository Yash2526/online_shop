# Stage 1: Build Stage

FROM node:23-alpine AS build-stage  

# Working Directory for the app

WORKDIR /app

# Copy all the Dependencies

COPY package*.json ./

# Install Dependencies

RUN npm install

# Copy the code from your HOST to the container

COPY . .

# Build the app (only needed if you're using a build step)

RUN npm run build



# Stage 2: Production Image

FROM node:lts-alpine AS production

# Set the working directory for the production environment

WORKDIR /app/phase1_hackathon

# Copy only the necessary build files from the first stage

COPY --from=build-stage /app /app/phase1_hackathon


# Set environment variable for the port

ENV PORT=3000

# Expose the port

EXPOSE 3000


# Serve the app / keep it running

CMD ["npm", "run", "dev", "--", "--host", "--port", "3000"]

