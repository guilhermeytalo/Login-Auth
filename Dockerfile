# Installs Node.js image
FROM node:16.20.0

# sets the working directory for any RUN, CMD, COPY command
# all files we put in the Docker container running the server will be in /usr/src/app (e.g. /usr/src/app/package.json)
WORKDIR /usr/src/app


# Copies package.json, package-lock.json, tsconfig.json, .env to the root of WORKDIR
COPY ["package.json", "yarn.lock", "tsconfig.json", ".env", "./"]

# Installs all packages
RUN yarn install

# Run the following command to build the image
RUN yarn build

# Run migration
RUN yarn db:migration

# Copies everything in the src directory to WORKDIR/src
COPY ./src ./src

# Runs the dev npm script to build & start the server
CMD yarn start