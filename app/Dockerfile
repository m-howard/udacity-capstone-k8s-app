# ============================================================
# ---- Base ----
# ============================================================
FROM node:12-alpine as base

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN chmod +x /wait

# Create working directory
WORKDIR /usr/src/app
RUN mkdir service

# Copy package & app files
COPY package*.json ./
COPY ./service ./service


# ============================================================
# ---- Dependencies ----
# ============================================================
FROM base AS dependencies

# Allow ability to install node-gyp
# hadolint ignore=DL3018
RUN apk add --no-cache --virtual .gyp python make g++

# Install PROD node packages and copy aside
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production
RUN cp -R node_modules prod_node_modules

# Install ALL node_modules, including 'devDependencies'
RUN npm install


# ============================================================
# ---- Test ----
# ============================================================
FROM dependencies AS test

# Copy whole directory for linting
COPY . .

RUN  npm run lint


# ============================================================
# ---- Release ----
# ============================================================
FROM base AS release

# Copy production node_modules
COPY --from=dependencies /usr/src/app/prod_node_modules ./node_modules

# Expose port
EXPOSE 8080

# Start server
CMD ["npm", "run", "start"]


# ============================================================
# ---- Development ----
# ============================================================
FROM dependencies AS development

# Expose port
EXPOSE 8080

# Start server
RUN /wait && npm start
