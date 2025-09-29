const { NxAppRspackPlugin } = require('@nx/rspack/app-plugin');
const { join } = require('path');
const rspack = require('@rspack/core');

module.exports = {
  entry: './src/main.ts',
  mode: 'development',
  output: {
    path: join(__dirname, '../../dist/apps/shell'),
    publicPath: 'http://localhost:4200/',
  },
  plugins: [
    new NxAppRspackPlugin({
      target: 'web',
      tsConfig: 'apps/shell/tsconfig.app.json',
      main: 'apps/shell/src/main.ts',
      outputHashing: 'none',
    }),
    new rspack.container.ModuleFederationPlugin({
      name: 'shell',
      filename: 'remoteEntry.js',
      remotes: {
        // Aquí puedes agregar tus microfrontends remotos
        // 'mfProfile': 'mfProfile@http://localhost:4201/remoteEntry.js',
      },
      shared: {
        '@angular/core': {
          singleton: true,
          strictVersion: true,
          requiredVersion: 'auto',
        },
        '@angular/common': {
          singleton: true,
          strictVersion: true,
          requiredVersion: 'auto',
        },
        '@angular/router': {
          singleton: true,
          strictVersion: true,
          requiredVersion: 'auto',
        },
        '@angular/platform-browser': {
          singleton: true,
          strictVersion: true,
          requiredVersion: 'auto',
        },
        '@angular/platform-browser-dynamic': {
          singleton: true,
          strictVersion: true,
          requiredVersion: 'auto',
        },
      },
    }),
  ],
};
