#!/bin/bash 
#author: AlphanetEX, Vertion:0.1.4
#public variables 
pkgjson='package.json';

#stable creator multiforlder 
mkrfd(){
 array=("$@") #@ ya es un arraid solo se reasigna 
 mkdir -p -- "$1" && 
 cd -P -- "$1" 
 cant="${#array[*]}"
    counter=1
    while [ $counter -lt $cant ] 
    do
    mkdir -p -- "${array[$counter]}"
    ((counter ++));
    done
    cd .. 
}

#stable creator multiarchive 
archive(){
  receptor=("$@")
  cant="${#receptor[*]}"
  pushd $1 > /dev/null
  counter=1
  while [ $counter -lt $cant ] 
    do
     touch "${receptor[$counter]}"
    ((counter ++));
    done
    popd > /dev/null
}

#folder sector creations
mkrfd views
mkrfd public images css 
mkrfd snipets 

#archive sector creations 
archive views/ home.html login.html register.html
archive public/css/  styles.css 
touch app.js

#npm dependencies 
npm init -y
npm i -S express
npm dev dependencies 
npm i -D nodemon 

#veriry if on distribution its linux (sed) or macosx (gsed)
#sed operations 
if [[ $(uname -s) == "Darwin" ]]; then 
gsed -i '1c\/node_modules' .gitignore 
gsed -i '10c\\n' $pkgjson; 
gsed -i '10c\  "start": "node app.js",' $pkgjson;
gsed -i '11c\\n' $pkgjson; 
gsed -i '11c\  "dev": "nodemon app.js",' $pkgjson;
gsed -i '12c\\n' $pkgjson; 
gsed -i '12c\ "test": "mocha --exit"' $pkgjson 
#gsed -i '9c\},' $pkgjson;
elif [[ $(uname -s) = "Linux" ]]; then
sed -i '1c\/node_modules' .gitignore 
sed -i '10c\ \n' $pkgjson; 
sed -i '10c\  "start": "node app.js",' $pkgjson;
sed -i '11c\\n' $pkgjson; 
sed -i '11c\  "dev": "nodemon app.js",' $pkgjson;
gsed -i '12c\\n' $pkgjson; 
gsed -i '12c\ "test": "mocha --exit",' $pkgjson 
else
echo "Contact with de Delevoper for attach this new characteristic sed in your enviroment"
fi 

cat <<EOM >> .gitignore 
/node_modules
.gitignore
.env
EOM


cat <<EOM >> .env.example
// CONFIG 
PORT=8000 

// MONGO 
DB_USER=
DB_PASSWORD=
DB_HOST= 
DB_PORT=
DB_NAME= 

// Sentry 
SENTRY_DNS=
SENTRY_ID=

//AUTH 
AUTH_ADMIN_USERNAME=
AUTH_ADMIN_PASSWORD=
AUTH_ADMIN_EMAIL=
AUTH_JWT_SECRET=
EOM

# #fix this part
# cat <<EOM >> .dockerignore
# /node_modules
# docker-compose.yml 
# Dockerfile
# .dockerignore
# root.bash
# EOM 

# #fix this part 
# cat <<EOM >> Dockerfile
# FROM node:10

# COPY ["package.json","package-lock.json", "/usr/src/"]

# WORKDIR /usr/src

# RUN npm install

# COPY [".", "/usr/src/"]

# EXPOSE 3000

# CMD ["npx", "nodemon", "index.js"]
# EOM

