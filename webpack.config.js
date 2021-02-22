const path = require('path')

module.exports = {
  entry: './ui/app.coffee',
  mode: 'development',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  resolve: {
    alias: {
      process: 'process/browser'
    }
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
        options: {
          transpile: {
            presets: [
              '@babel/env',
              '@babel/preset-react',
            ],
          },
        },
      },
    ],
  },
};
