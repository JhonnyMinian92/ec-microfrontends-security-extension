# Este script de PowerShell automatiza la instalación y configuración completa
# de un proyecto Nx con Angular, Rspack y Module Federation.
# Creado para ser ejecutado en un solo paso en herramientas como Warp.

# -----------------------------------------------------------------------------
#                            CONFIGURACIÓN INICIAL
# -----------------------------------------------------------------------------

# Define el nombre de tu proyecto y aplicación aquí
$PROYECTO_NOMBRE = "mi-microfrontend-project"
$APP_NOMBRE = "shell"

# Imprime un mensaje de bienvenida
Write-Host "🚀 Iniciando la instalación y configuración de Angular + Rspack + Module Federation..." -ForegroundColor Green
Write-Host "📁 Nombre del proyecto: $PROYECTO_NOMBRE" -ForegroundColor Cyan
Write-Host "✨ Nombre de la aplicación: $APP_NOMBRE" -ForegroundColor Cyan
Write-Host "---"

# -----------------------------------------------------------------------------
#                            FASE 1: PREPARACIÓN DEL ENTORNO
# -----------------------------------------------------------------------------

# Limpiar caché de npm para evitar conflictos
Write-Host "📦 Limpiando la caché de npm..." -ForegroundColor Yellow
npm cache clean --force
npm cache verify

# -----------------------------------------------------------------------------
#                            FASE 2: CREACIÓN DEL WORKSPACE
# -----------------------------------------------------------------------------

# Eliminar el directorio si ya existe para asegurar una instalación limpia
if (Test-Path $PROYECTO_NOMBRE) {
    Write-Host "🗑️ Eliminando el directorio del proyecto existente..." -ForegroundColor Red
    Remove-Item -Recurse -Force $PROYECTO_NOMBRE
}

# Crear el nuevo workspace de Nx con las opciones no interactivas
Write-Host "🏗️ Creando el workspace de Nx..." -ForegroundColor Green
npx create-nx-workspace@21.5.3 $PROYECTO_NOMBRE `
  --preset=angular-standalone `
  --appName=$APP_NOMBRE `
  --style=scss `
  --routing=true `
  --packageManager=npm `
  --standaloneApi=true `
  --bundler=rspack `
  --ssr=false `
  --unitTestRunner=none `
  --e2eTestRunner=none `
  --skip-nx-cloud

# Navegar al directorio del proyecto
Write-Host "➡️ Navegando al directorio del proyecto..." -ForegroundColor Green
cd $PROYECTO_NOMBRE

# -----------------------------------------------------------------------------
#                            FASE 3: INSTALACIÓN DE DEPENDENCIAS ADICIONALES
# -----------------------------------------------------------------------------

Write-Host "🛠️ Instalando dependencias de Rspack y Module Federation..." -ForegroundColor Green
# Instalación de paquetes de Rspack para Nx
npm install --save-dev `
  @nx/rspack@21.5.3 `
  @nx/angular-rspack@21.5.3 `
  --legacy-peer-deps

# Instalación de paquetes core de Rspack
npm install --save-dev `
  @rspack/core@1.5.6 `
  @rspack/cli@1.5.6 `
  @rspack/dev-server@1.1.4 `
  --legacy-peer-deps

# Instalación de paquetes de Module Federation
npm install --save-dev `
  @nx/module-federation@21.5.3 `
  @module-federation/enhanced@0.18.4 `
  --legacy-peer-deps

# -----------------------------------------------------------------------------
#                            FASE 4: CONFIGURACIÓN DE ARCHIVOS
# -----------------------------------------------------------------------------

Write-Host "✍️ Configurando archivos de proyecto..." -ForegroundColor Green

# Crear la carpeta 'public' y el archivo 'favicon.ico'
mkdir "apps\$APP_NOMBRE\public"
New-Item -Path "apps\$APP_NOMBRE\public\favicon.ico" -ItemType File

# Crear el archivo de manifiesto de Module Federation
New-Item -Path "apps\$APP_NOMBRE\public\module-federation.manifest.json" -ItemType File -Value "{}"

# Contenido para project.json
$projectJsonContent = @"
{
  "name": "$APP_NOMBRE",
  "\$schema": "../../node_modules/nx/schemas/project-schema.json",
  "projectType": "application",
  "prefix": "app",
  "sourceRoot": "apps/$APP_NOMBRE/src",
  "tags": [],
  "targets": {
    "build": {
      "executor": "@nx/rspack:rspack",
      "outputs": ["{options.outputPath}"],
      "defaultConfiguration": "production",
      "options": {
        "target": "web",
        "outputPath": "dist/apps/$APP_NOMBRE",
        "index": "apps/$APP_NOMBRE/src/index.html",
        "main": "apps/$APP_NOMBRE/src/main.ts",
        "tsConfig": "apps/$APP_NOMBRE/tsconfig.app.json",
        "rspackConfig": "apps/$APP_NOMBRE/rspack.config.js",
        "assets": [{
          "glob": "**/*",
          "input": "apps/$APP_NOMBRE/public",
          "output": "./"
        }]
      },
      "configurations": {
        "development": {
          "mode": "development"
        },
        "production": {
          "mode": "production",
          "optimization": true,
          "sourceMap": false
        }
      }
    },
    "serve": {
      "executor": "@nx/rspack:module-federation-dev-server",
      "options": {
        "buildTarget": "$APP_NOMBRE:build",
        "port": 4200
      }
    },
    "extract-i18n": {
      "executor": "@angular-devkit/build-angular:extract-i18n",
      "options": {
        "buildTarget": "$APP_NOMBRE:build"
      }
    },
    "lint": {
      "executor": "@nx/eslint:lint"
    },
    "serve-static": {
      "continuous": true,
      "executor": "@nx/web:file-server",
      "options": {
        "buildTarget": "$APP_NOMBRE:build",
        "port": 4200,
        "spa": true
      }
    }
  }
}
"@
# Reemplazar el contenido de project.json
$projectJsonContent | Out-File -FilePath "apps\$APP_NOMBRE\project.json" -Encoding utf8

# Contenido para rspack.config.js
$rspackConfigContent = @"
const { NxAppRspackPlugin } = require('@nx/rspack/app-plugin');
const { join } = require('path');
const rspack = require('@rspack/core');

module.exports = {
  entry: './src/main.ts',
  mode: 'development',
  output: {
    path: join(__dirname, '../../dist/apps/$APP_NOMBRE'),
    publicPath: 'http://localhost:4200/',
  },
  plugins: [
    new NxAppRspackPlugin({
      target: 'web',
      tsConfig: 'apps/$APP_NOMBRE/tsconfig.app.json',
      main: 'apps/$APP_NOMBRE/src/main.ts',
      outputHashing: 'none',
    }),
    new rspack.container.ModuleFederationPlugin({
      name: '$APP_NOMBRE',
      filename: 'remoteEntry.js',
      remotes: {},
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
"@
# Crear el archivo rspack.config.js
$rspackConfigContent | Out-File -FilePath "apps\$APP_NOMBRE\rspack.config.js" -Encoding utf8

# Contenido para module-federation.config.ts
$mfConfigContent = @"
import { ModuleFederationConfig } from '@nx/module-federation';

const config: ModuleFederationConfig = {
  name: '$APP_NOMBRE',
  remotes: [],
};

export default config;
"@
# Crear el archivo module-federation.config.ts
$mfConfigContent | Out-File -FilePath "apps\$APP_NOMBRE\module-federation.config.ts" -Encoding utf8

# Contenido para main.ts (Bootstrap Pattern)
$mainTsContent = @"
import('./bootstrap').catch((err) => console.error(err));
"@
$mainTsContent | Out-File -FilePath "apps\$APP_NOMBRE\src\main.ts" -Encoding utf8

# Contenido para bootstrap.ts
$bootstrapTsContent = @"
import { bootstrapApplication } from '@angular/platform-browser';
import { App } from './app/app';
import { appConfig } from './app/app.config';

bootstrapApplication(App, appConfig).catch((err) => console.error(err));
"@
$bootstrapTsContent | Out-File -FilePath "apps\$APP_NOMBRE\src\bootstrap.ts" -Encoding utf8

# Contenido para app.routes.ts
$appRoutesContent = @"
import { Route } from '@angular/router';
import { NxWelcome } from './nx-welcome';

export const appRoutes: Route[] = [
  {
    path: '',
    component: NxWelcome,
  },
];
"@
$appRoutesContent | Out-File -FilePath "apps\$APP_NOMBRE\src\app\app.routes.ts" -Encoding utf8

# -----------------------------------------------------------------------------
#                            FASE 5: VERIFICACIÓN Y TESTEO
# -----------------------------------------------------------------------------

Write-Host "✅ Realizando el primer build de producción para verificar la configuración..." -ForegroundColor Green
npx nx build $APP_NOMBRE --configuration=production

Write-Host "🚀 Iniciando el servidor de desarrollo..." -ForegroundColor Green
Write-Host "🌐 Accede a http://localhost:4200 para ver la aplicación." -ForegroundColor Cyan
npx nx serve $APP_NOMBRE
