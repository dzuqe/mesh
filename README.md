# Mesh:

A template for creative dapps that require a registry for 3D based content. 

The template integrates the following tech:
1. Arweave to store 3D models and texture files
2. Ceramic to create documents that describe the nature of the 3D model
customizable schema
3. Near contract mesh registry to facilitate a 3D model network

Aims to be a minimal and lightweight 3D dapp template for creative coders
who don't mind that the lexer is a little wonky. 

- [coffescript](https://coffeescript.org/) without jsx
- [gulp](https://gulpjs.com/) and [browserify](https://browserify.org/) module bundler 
- [react](reactjs.org/) application framework
- [redux](https://redux.js.org/) for state management 


Requirements:
Nodejs: v14.15.5

### installation:
```
git clone https://github.com/rinzlxr/mesh.git
cd mesh
nvm use # if you have node version manager
npm install
```

### build:
```
npm run build # build contract and ui
npm run build:ui # build frontend
npm run build:tx # build contract
```

### test:
```
npm run test:tx # test contract
```
