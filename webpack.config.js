var autoprefixer = require('autoprefixer')

module.exports = {
  entry: './src/index.js',

  output: {
    path: './static',
    filename: 'index.js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },

  module: {
    loaders: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm'
      },
      {
        test: /\.css/,
        exclude: [/node_modules/],
        loader: 'style!css!postcss'
      }
    ],

    noParse: /\.elm$/
  },

  postcss: function() {
    return [autoprefixer]
  },

  devServer: {
    inline: true,
    stats: 'errors-only',
    contentBase: './static'
    // proxy: {
    //   '/some/path': {
    //     target: 'http://localhost:3000',
    //     secure: false,
    //     changeOrigin: true
    //   }
    // }
  }
}
