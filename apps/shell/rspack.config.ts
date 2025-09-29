import { createConfig } from '@nx/angular-rspack';

export default createConfig({
  options: {
    root: __dirname,

    outputPath: {
      base: '../../dist/apps/shell',
    },
    index: './src/index.html',
    browser: './src/main.ts',
    tsConfig: './tsconfig.app.json',
    assets: ['./public'],
    styles: ['./src/styles.scss'],
    scripts: [],
  },
});
