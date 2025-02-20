![img](https://github.com/Yash2526/online_shop/blob/feature/dockerize-application/Online%20Shop.png)
# **️🐳 Dockerized  Online Sho️p🛍️ Application**

This repository contains a Dockerized Node.js application with a **multi-stage build**. Below, we provide a detailed step-by-step explanation of the `Dockerfile` used in this project.

---

## **🚀 What This Dockerfile Does**
- Uses **multi-stage builds** to separate **development** and **production** environments.
- Uses a **lightweight Alpine-based Node.js image** to reduce image size.
- **Installs dependencies** and **copies only necessary files** for an optimized production build.
- **Exposes the application on port 3000**.
- Uses `CMD` to run the application in **development mode** with `--host` and `--port` options.

---

## **📝 Step-by-Step Explanation of Dockerfile**

### **🔹 Stage 1: Build Stage**
This stage is responsible for setting up the **development environment** and installing dependencies.

```dockerfile
# 1️⃣ Use Node.js Alpine as a base image for the build stage
FROM node:23-alpine AS build-stage
```
- This pulls the **latest Node.js 23 Alpine image**, which is lightweight and optimized.
- We name this stage `build-stage` so it can be referred to in the next stage.

```dockerfile
# 2️⃣ Set the working directory inside the container
WORKDIR /app
```
- All subsequent commands will be executed inside the `/app` directory.

```dockerfile
# 3️⃣ Copy package.json and package-lock.json to install dependencies
COPY package*.json ./
```
- Copies `package.json` and `package-lock.json` to ensure we only install required dependencies.

```dockerfile
# 4️⃣ Install application dependencies
RUN npm install
```
- Runs `npm install` to install all the required dependencies.
- Uses the **cached layers** feature of Docker to avoid re-installing dependencies when the code changes.

```dockerfile
# 5️⃣ Copy the entire project to the container
COPY . .
```
- Copies the **entire project directory** (except `.dockerignore` files) into the container.

```dockerfile
# 6️⃣ Build the application (if needed)
RUN npm run build
```
- This step is only required **if your application requires a build step**.
- If it's a simple Node.js backend, you can remove this step.

---

### **🔹 Stage 2: Production Stage**
This stage is responsible for creating a lightweight **production-ready container**.

```dockerfile
# 7️⃣ Use a smaller Node.js image for production
FROM node:lts-alpine AS production
```
- Uses a **lightweight Node.js LTS Alpine image** to optimize performance.
- Keeps only the essential files for production.

```dockerfile
# 8️⃣ Set the working directory for the production environment
WORKDIR /app/phase1_hackathon
```
- All files will be placed inside `/app/phase1_hackathon` for better organization.

```dockerfile
# 9️⃣ Copy only necessary build files from the build-stage
COPY --from=build-stage /app /app/phase1_hackathon
```
- Copies only the required files from `build-stage` to the `production` stage.
- Ensures that unnecessary files (such as `node_modules`) do not get copied.

```dockerfile
# 🔟 Set an environment variable for the port
ENV PORT=3000
```
- Defines an environment variable `PORT=3000` for flexibility.

```dockerfile
# 1️⃣1️⃣ Expose port 3000 to allow external access
EXPOSE 3000
```
- Opens **port 3000**, allowing external traffic to reach the container.

```dockerfile
# 1️⃣2️⃣ Start the application
CMD ["npm", "run", "dev", "--", "--host", "--port", "3000"]
```
- The application runs in **development mode** (`npm run dev`).
- **Flags Explanation:**
  - `--` **(double dashes)**: Passes arguments to the npm script.
  - `--host`: Ensures the app is accessible outside the container.
  - `--port 3000`: Explicitly sets the app to run on port 3000.

---

## **📌 Running the Container**

### **1️⃣ Build the Docker Image**
```sh
docker build -t online_shop-app:latest .
```

### **2️⃣ Run the Container**
```sh
docker run -d -p 3000:3000 online_shop-app:latest
```

### **3️⃣ Access the Application**
- Open your browser and go to:  
  **http://localhost:3000**

---

## **🚀 Advantages of This Multi-Stage Build**
✅ **Reduces Image Size** (removes unnecessary files).  
✅ **Optimizes Production Deployment** (only copies necessary files).  
✅ **Uses a Lightweight Alpine Image** (reduces memory usage).  
✅ **Ensures Development & Production Environments are Separated**.  

---

## **🔧 Troubleshooting**

### **🔴 ERROR: load metadata for docker.io/library/node:23-alpine3.20**
- This happens when the image **does not exist**.
- **Fix:** Use `node:23-alpine` instead of `node:23-alpine3.20`.

### **🔴 Application Not Running on localhost:3000?**
- Check if the container is running:
  ```sh
  docker ps
  ```
- If not, restart the container:
  ```sh
  docker restart <container_id>
  ```
- Ensure port 3000 is correctly exposed:
  ```sh
  docker run -p 3000:3000 my-node-app
  ```

---
## 📤 **Submission Details**

- **Full Name:** Bharitkar Yash
- **Email Address:** yashbharitkar2003@gmail.com
- **GitHub Repo:** [GitHub Repository Link](https://github.com/Yash2526/online_shop)
- **Demo Video:** [Watch Here](https://go.screenpal.com/watch/cTnYrPnhKpH)

---

## 📣 **Sharing for Extra Points 🚀**

- **LinkedIn :** (https://www.linkedin.com/in/yashbharitkar25learns-cloud/)


---

## 📑 **License**

MIT License © Amit Singh

---

💡 *Made with 💖 using React, Vite, and Docker.*


