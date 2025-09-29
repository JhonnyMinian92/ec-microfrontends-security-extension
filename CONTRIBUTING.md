# 🚀 Guía Instalación: Angular + Rspack + Module Federation con Nx

<div align="center">

**✨ Configuración perfecta probada y funcional ✨**

*Una guía paso a paso para crear aplicaciones Angular con Rspack y Module Federation*

![Angular](https://img.shields.io/badge/Angular-20.2.4-red?style=for-the-badge&logo=angular)
![Nx](https://img.shields.io/badge/Nx-21.5.3-blue?style=for-the-badge&logo=nx)
![Rspack](https://img.shields.io/badge/Rspack-1.5.6-orange?style=for-the-badge)
![Node.js](https://img.shields.io/badge/Node.js-20.19.0-green?style=for-the-badge&logo=node.js)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1.26100-blue?style=for-the-badge&logo=powershell)

---

### 👨‍💻 **Creada por Jhonny Miñan**

*Desarrollador Full Stack • Web Development • Prompt Engineering*

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](#)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](#)

**📅 Última actualización**: 25 de Septiembre, 2025  
**⏱️ Tiempo estimado**: 45-60 minutos  
**🎯 Dificultad**: Intermedio  
**✅ Estado**: Probado y funcional

</div>

---

## 📋 Especificaciones del Sistema Base

> **⚠️ IMPORTANTE**: Usa exactamente estas versiones que están **probadas y funcionando** en el sistema de referencia.

### 🖥️ **Sistema Operativo y Shell**
```powershell
# Windows con PowerShell
Windows 10/11 (x64)
PowerShell: 5.1.26100.6584
```

### 🛠️ **Herramientas del Sistema**
```bash
# Versiones específicas del sistema
Node.js: v20.19.0
npm: 10.8.2
Angular CLI: 20.2.2
Nx: 21.5.3 (local)
TypeScript: 5.9.2
```

### 📦 **Dependencias Exactas de Producción**
```json
{
  "dependencies": {
    "@angular/common": "20.2.4",
    "@angular/compiler": "20.2.4", 
    "@angular/core": "20.2.4",
    "@angular/forms": "20.2.4",
    "@angular/platform-browser": "20.2.4",
    "@angular/router": "20.2.4",
    "@nx/angular": "21.5.3",
    "rxjs": "7.8.2",
    "zone.js": "0.15.1"
  }
}
```

### 🔧 **Dependencias Exactas de Desarrollo**
```json
{
  "devDependencies": {
    "@angular-devkit/build-angular": "20.2.2",
    "@angular-devkit/core": "20.2.2",
    "@angular-devkit/schematics": "20.2.2",
    "@angular/build": "20.2.2",
    "@angular/cli": "20.2.2",
    "@angular/compiler-cli": "20.2.4",
    "@angular/language-service": "20.2.4",
    "@eslint/js": "9.8.0",
    "@module-federation/enhanced": "0.18.4",
    "@nx/angular-rspack": "21.5.3",
    "@nx/eslint": "21.5.3",
    "@nx/eslint-plugin": "21.5.3",
    "@nx/js": "21.5.3",
    "@nx/module-federation": "21.5.3",
    "@nx/rspack": "21.5.3",
    "@nx/web": "21.5.3",
    "@nx/webpack": "21.5.3",
    "@nx/workspace": "21.5.3",
    "@rspack/cli": "1.5.6",
    "@rspack/core": "1.5.6",
    "@rspack/dev-server": "1.1.4",
    "@schematics/angular": "20.2.2",
    "@swc-node/register": "1.9.1",
    "@swc/core": "1.5.7",
    "@swc/helpers": "0.5.11",
    "@typescript-eslint/utils": "8.40.0",
    "angular-eslint": "20.2.0",
    "eslint": "9.8.0",
    "eslint-config-prettier": "10.0.0",
    "nx": "21.5.3",
    "prettier": "2.6.2",
    "ts-node": "10.9.1",
    "tslib": "2.3.0",
    "typescript": "5.9.2",
    "typescript-eslint": "8.40.0",
    "webpack-merge": "5.8.0"
  }
}
```

---

## 🛠️ Proceso de Instalación Completo

> **💡 TIP**: Ejecuta cada comando en **PowerShell** como Administrador para evitar problemas de permisos.

### **FASE 1: Preparación del Entorno**

#### 1.1. **Verificar Herramientas del Sistema**

```powershell
# Verificar versiones instaladas
node --version          # Debe mostrar: v20.19.0
npm --version           # Debe mostrar: 10.8.2
$PSVersionTable.PSVersion # Debe mostrar: 5.1.26100.xxxx
```

#### 1.2. **Limpiar Cache de npm (Recomendado)**

```powershell
# Limpiar cache para evitar conflictos
npm cache clean --force
npm cache verify
```

### **FASE 2: Creación del Workspace**

#### 2.1. **Crear Workspace Nx con Angular**

```powershell
# Crear proyecto base (SIN --interactive=false para responder preguntas)
npx create-nx-workspace@21.5.3 [NOMBRE_DEL_PROYECTO] `
  --preset=angular-standalone `
  --appName=[NOMBRE_DE_LA_APP] `
  --style=scss `
  --routing=true `
  --packageManager=npm `
  --standaloneApi=true
```

**📝 Preguntas interactivas que aparecen:**

1. **"Which bundler would you like to use?"**
   - ✅ **Respuesta**: `rspack` 

2. **"Would you like to use SSR?"**
   - ✅ **Respuesta**: `No`

3. **"Test runner to use for unit tests:"**
   - ✅ **Respuesta**: `none`

4. **"Which E2E test runner would you like to use?"**
   - ✅ **Respuesta**: `none` 

5. **"Set up Nx Cloud? (It's free and doesn't require registration.)"**
   - ✅ **Respuesta**: `skip` (para evitar configuración adicional)

**Ejemplo real completo:**
```powershell
npx create-nx-workspace@21.5.3 mi-microfrontend-project `
  --preset=angular-standalone `
  --appName=shell `
  --style=scss `
  --routing=true `
  --packageManager=npm `
  --standaloneApi=true

# Cuando aparezcan las preguntas, responder:
# Bundler: rspack
# SSR: No  
# Test runner: no
# E2E runner: no
# Nx Cloud: skip
```

#### 2.2. **Navegar al Directorio del Proyecto**

```powershell
cd [NOMBRE_DEL_PROYECTO]

# Verificar estructura creada
dir  # Debe mostrar: apps/, libs/, package.json, nx.json, etc.
```

#### 2.3. **Verificar Instalación Base**

```powershell
# Verificar que Nx funciona correctamente
npx nx --version        # Debe mostrar: 21.5.3
npx nx build [NOMBRE_DE_LA_APP]  # Primer build para verificar
```

### **FASE 2.5: Eliminación y Recreación de Shell** 

> **⚠️ IMPORTANTE**: La shell creada inicialmente tiene configuración de webpack. Necesitamos eliminarla y recrearla correctamente para Rspack.

#### 2.5.1. **Eliminar la Shell Original**

```powershell
# Eliminar la aplicación shell original
npx nx g @nx/workspace:remove [NOMBRE_DE_LA_APP]

# Si el comando anterior no funciona, eliminar manualmente:
rmdir /s /q apps\[NOMBRE_DE_LA_APP]

# Limpiar referencias en nx.json
# Editar nx.json y eliminar referencias a [NOMBRE_DE_LA_APP] si existen
```

#### 2.5.2. **Limpiar Rastros de Configuración**

```powershell
# Limpiar cache de Nx
npx nx reset

# Verificar que no queden rastros
dir apps\  # No debe mostrar [NOMBRE_DE_LA_APP]

# Verificar package.json scripts
type package.json | findstr [NOMBRE_DE_LA_APP]
# Si aparecen scripts, eliminarlos manualmente del package.json
```

#### 2.5.3. **Recrear Shell en apps/ con Configuración Correcta**

```powershell
# Crear nueva aplicación Angular en apps/
npx nx g @nx/angular:application [NOMBRE_DE_LA_APP] `
  --routing=true `
  --style=scss `
  --standalone=true `
  --directory=apps `
  --bundler=webpack `
  --interactive=false
```

**Preguntas si aparecen:**
- **"Would you like to configure routing?"** → `Yes`
- **"Which stylesheet format would you like to use?"** → `SCSS`
- **"Would you like to use the Angular router?"** → `Yes`

#### 2.5.4. **Verificar Recreación**

```powershell
# Verificar estructura creada
dir apps\[NOMBRE_DE_LA_APP]

# Debe mostrar:
# - src/
# - project.json
# - tsconfig.app.json
# - tsconfig.spec.json
# - etc.

# Probar build inicial
npx nx build [NOMBRE_DE_LA_APP]
```

### **FASE 3: Preparación de Estructura**

#### 3.1. **Crear Carpeta public para Assets**

```powershell
# Crear carpeta public dentro de la aplicación
mkdir apps\[NOMBRE_DE_LA_APP]\public

# Crear archivo favicon.ico vacío o copiar uno existente
echo. > apps\[NOMBRE_DE_LA_APP]\public\favicon.ico

# Verificar estructura
dir apps\[NOMBRE_DE_LA_APP]\public
```

### **FASE 4: Instalación de Rspack**

#### 4.1. **Instalar Dependencias Principales de Rspack**

```powershell
# Instalar paquetes de Nx para Rspack
npm install --save-dev `
  @nx/rspack@21.5.3 `
  @nx/angular-rspack@21.5.3 `
  --legacy-peer-deps
```

#### 4.2. **Instalar Core de Rspack**

```powershell
# Instalar dependencias core de Rspack
npm install --save-dev `
  @rspack/core@1.5.6 `
  @rspack/cli@1.5.6 `
  @rspack/dev-server@1.1.4 `
  --legacy-peer-deps
```

#### 4.3. **Verificar Instalación de Rspack**

```powershell
# Verificar que los paquetes se instalaron correctamente
npm list @rspack/core @nx/rspack @nx/angular-rspack --depth=0
```

### **FASE 5: Instalación de Module Federation**

#### 5.1. **Instalar Dependencias de Module Federation**

```powershell
# Instalar paquetes para Module Federation
npm install --save-dev `
  @nx/module-federation@21.5.3 `
  @module-federation/enhanced@0.18.4 `
  --legacy-peer-deps
```

#### 5.2. **Verificar Instalación de Module Federation**

```powershell
# Verificar instalación
npm list @nx/module-federation @module-federation/enhanced --depth=0
```

### **FASE 6: Conversión a Rspack**

#### 6.1. **Convertir Aplicación Angular a Rspack**

```powershell
# Convertir el proyecto para usar Rspack
npx nx g @nx/angular:convert-to-rspack `
  --project=[NOMBRE_DE_LA_APP] `
  --verbose
```

**Salida esperada:**
```
NX  Generating @nx/angular:convert-to-rspack

The output location of the browser build has been updated from 
"../../dist/apps/[NOMBRE_DE_LA_APP]" to "../../dist/apps/[NOMBRE_DE_LA_APP]/browser". 
You might need to adjust your deployment pipeline...
UPDATE apps/[NOMBRE_DE_LA_APP]/rspack.config.ts
UPDATE apps/[NOMBRE_DE_LA_APP]/project.json
```

#### 6.2. **Configurar Rspack Completo**

```powershell
# Agregar configuración completa de Rspack
npx nx g @nx/rspack:configuration `
  --project=[NOMBRE_DE_LA_APP] `
  --verbose
```

**Preguntas que aparecen y respuestas correctas:**

1. **`What framework is the project you want to convert using?`**
   - ✅ **Seleccionar**: `none` (usar flechas del teclado y Enter)

2. **Mensaje informativo sobre no encontrar targets convertibles**
   - Aparecerá un mensaje explicando que no se encontraron targets convertibles

3. **`Should Nx convert your project to use the @nx/rspack executors? (Y/n)`**
   - ✅ **Responder**: `Y` (Yes) y presionar Enter

**Salida esperada:**
```
NX  Generating @nx/rspack:configuration

DELETE apps/[NOMBRE_DE_LA_APP]/webpack.config.ts
UPDATE apps/[NOMBRE_DE_LA_APP]/project.json  
CREATE apps/[NOMBRE_DE_LA_APP]/rspack.config.js
```

#### 6.3. **Verificar Conversión a Rspack (Primer Intento)**

```powershell
# Probar build con Rspack (probablemente falle por assets)
npx nx build [NOMBRE_DE_LA_APP]
```

**Error esperado:**
```
NX   ENOENT: no such file or directory, stat 'C:\path\to\apps\[NOMBRE_DE_LA_APP]\src\favicon.ico'
```

> **📝 NOTA**: Este error es normal y lo solucionaremos en la siguiente fase de configuración.

---

## 📝 FASE 7: Configuración de Archivos

> **⚠️ IMPORTANTE**: Esta es la parte más crítica. Cada archivo debe configurarse exactamente como se muestra.

### **7.1. Configurar project.json con Executors de Rspack**

#### 7.1.1. **Ubicar y editar el archivo**

```powershell
# El archivo está en:
code apps/[NOMBRE_DE_LA_APP]/project.json
```

#### 7.1.2. **Reemplazar contenido completo de project.json**
```json
{
  "name": "[NOMBRE_DE_LA_APP]",
  "$schema": "../../node_modules/nx/schemas/project-schema.json",
  "projectType": "application",
  "prefix": "app",
  "sourceRoot": "apps/[NOMBRE_DE_LA_APP]/src",
  "tags": [],
  "targets": {
    "build": {
      "executor": "@nx/rspack:rspack",
      "outputs": ["{options.outputPath}"],
      "defaultConfiguration": "production",
      "options": {
        "target": "web",
        "outputPath": "dist/apps/[NOMBRE_DE_LA_APP]",
        "index": "apps/[NOMBRE_DE_LA_APP]/src/index.html",
        "main": "apps/[NOMBRE_DE_LA_APP]/src/main.ts",
        "tsConfig": "apps/[NOMBRE_DE_LA_APP]/tsconfig.app.json",
        "rspackConfig": "apps/[NOMBRE_DE_LA_APP]/rspack.config.js",
        "assets": [{
          "glob": "**/*",
          "input": "apps/[NOMBRE_DE_LA_APP]/public",
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
        "buildTarget": "[NOMBRE_DE_LA_APP]:build",
        "port": 4200
      }
    },
    "extract-i18n": {
      "executor": "@angular-devkit/build-angular:extract-i18n",
      "options": {
        "buildTarget": "[NOMBRE_DE_LA_APP]:build"
      }
    },
    "lint": {
      "executor": "@nx/eslint:lint"
    },
    "serve-static": {
      "continuous": true,
      "executor": "@nx/web:file-server",
      "options": {
        "buildTarget": "[NOMBRE_DE_LA_APP]:build",
        "port": 4200,
        "spa": true
      }
    }
  }
}
```

### **7.2. Configurar rspack.config.js con Module Federation**

#### 7.2.1. **Crear archivo de configuración de Rspack**

```powershell
# Crear el archivo (si no existe)
echo. > apps/[NOMBRE_DE_LA_APP]/rspack.config.js
```

#### 7.2.2. **Configuración completa de rspack.config.js**

> **💡 EXPLICACIÓN**: Este archivo configura Rspack con Module Federation nativo, incluyendo shared libraries de Angular y configuración de remotes.
```javascript
const { NxAppRspackPlugin } = require('@nx/rspack/app-plugin');
const { join } = require('path');
const rspack = require('@rspack/core');

module.exports = {
  entry: './src/main.ts',
  mode: 'development',
  output: {
    path: join(__dirname, '../../dist/apps/[NOMBRE_DE_LA_APP]'),
    publicPath: 'http://localhost:4200/',
  },
  plugins: [
    new NxAppRspackPlugin({
      target: 'web',
      tsConfig: 'apps/[NOMBRE_DE_LA_APP]/tsconfig.app.json',
      main: 'apps/[NOMBRE_DE_LA_APP]/src/main.ts',
      outputHashing: 'none',
    }),
    new rspack.container.ModuleFederationPlugin({
      name: '[NOMBRE_DE_LA_APP]',
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
```

### 9. Crear `apps/[NOMBRE_DE_LA_APP]/module-federation.config.ts`
```typescript
import { ModuleFederationConfig } from '@nx/module-federation';

const config: ModuleFederationConfig = {
  name: '[NOMBRE_DE_LA_APP]',
  /**
   * Para usar un remote que no existe en tu workspace actual
   * Puedes usar la tuple-syntax para definir tu remote
   *
   * remotes: [['my-external-remote', 'https://nx-angular-remote.netlify.app']]
   *
   * Tal vez necesites agregar un archivo `remotes.d.ts` a tu carpeta `src/` declarando el remote externo para tsc, con el
   * siguiente contenido:
   *
   * declare module 'my-external-remote';
   *
   */
  remotes: [],
};

/**
 * Nx requiere una exportación por defecto del config para permitir la correcta resolución del grafo de module federation.
 **/
export default config;
```

### 10. Configurar Bootstrap Pattern

**`apps/[NOMBRE_DE_LA_APP]/src/main.ts`**:
```typescript
import('./bootstrap').catch((err) => console.error(err));
```

**`apps/[NOMBRE_DE_LA_APP]/src/bootstrap.ts`**:
```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import { App } from './app/app';
import { appConfig } from './app/app.config';

bootstrapApplication(App, appConfig).catch((err) => console.error(err));
```

### 11. Configurar `apps/[NOMBRE_DE_LA_APP]/src/app/app.routes.ts`
```typescript
import { Route } from '@angular/router';
import { NxWelcome } from './nx-welcome';

export const appRoutes: Route[] = [
  {
    path: '',
    component: NxWelcome,
  },
  // Aquí puedes agregar rutas para microfrontends remotos:
  // {
  //   path: 'profile',
  //   loadChildren: () => import('mfProfile/routes').then(m => m.routes)
  // },
];
```

### 12. Crear `apps/[NOMBRE_DE_LA_APP]/public/module-federation.manifest.json`
```json
{}
```

---

## ✅ FASE 8: Verificación y Testing

### **8.1. Verificación del Build**

#### 8.1.1. **Probar Build de Desarrollo**

```powershell
# Build en modo desarrollo
npx nx build [NOMBRE_DE_LA_APP] --configuration=development
```

**Salida esperada exitosa:**
```
Entrypoint main XX.X KiB = runtime.js XX.X KiB main.js XXX bytes
chunk (runtime: runtime) ...
Rspack compiled successfully (xxxxxxxxxxxxxxxx)

NX   Successfully ran target build for project [NOMBRE_DE_LA_APP] (Xs)
```

#### 8.1.2. **Probar Build de Producción**

```powershell
# Build en modo producción
npx nx build [NOMBRE_DE_LA_APP] --configuration=production
```

### **8.2. Verificación del Dev Server**

#### 8.2.1. **Iniciar servidor de desarrollo**

```powershell
# Servir aplicación con Module Federation
npx nx serve [NOMBRE_DE_LA_APP]
```

**Salida esperada exitosa:**
```
NX  Starting module federation dev-server for [NOMBRE_DE_LA_APP] with 0 remotes
NX  Starting static remotes proxies...
NX  Static remotes proxies started successfully
[webpack-dev-server] Project is running at:
[webpack-dev-server] Loopback: http://localhost:4200/
NX  Server ready at http://localhost:4200
Type-checking in progress...
No TypeScript errors found.
```

#### 8.2.2. **Verificar en el navegador**

1. Abrir **http://localhost:4200**
2. Debe cargar la aplicación Angular
3. Verificar que no hay errores en la consola del desarrollador
4. Verificar que el archivo `remoteEntry.js` se genera (ir a http://localhost:4200/remoteEntry.js)

### **8.3. Verificar Module Federation**

```powershell
# Verificar archivos generados
dir dist/apps/[NOMBRE_DE_LA_APP]/

# Debe mostrar archivos como:
# - remoteEntry.js (archivo de Module Federation)
# - main.js, runtime.js (archivos de la aplicación)
# - index.html
```

## 🎯 Resultado Esperado

- ✅ Aplicación Angular con Rspack como bundler
- ✅ Module Federation configurado como Host
- ✅ Dev server optimizado para Module Federation
- ✅ Shared libraries de Angular configuradas
- ✅ Bootstrap pattern implementado
- ✅ Routing listo para microfrontends
- ✅ Build y serve funcionando correctamente

## 🔧 Para Agregar Microfrontends Remotos

1. **En `rspack.config.js`**, agregar en `remotes`:
```javascript
remotes: {
  'mfProfile': 'mfProfile@http://localhost:4201/remoteEntry.js',
  'mfDashboard': 'mfDashboard@http://localhost:4202/remoteEntry.js',
},
```

2. **En `app.routes.ts`**, agregar rutas:
```typescript
{
  path: 'profile',
  loadChildren: () => import('mfProfile/routes').then(m => m.routes)
},
{
  path: 'dashboard', 
  loadChildren: () => import('mfDashboard/routes').then(m => m.routes)
}
```

## 🚨 Notas Importantes

- **Usar `--legacy-peer-deps`** al instalar dependencias para evitar conflictos
- **Puerto por defecto**: 4200 para el host
- **Puertos remotos**: 4201, 4202, etc. para microfrontends
- **Rspack es más rápido** que webpack tradicional
- **Compatible con todas las funcionalidades** de Module Federation

## 📚 Comandos Útiles

```bash
# Build de producción
npx nx build [NOMBRE_DE_LA_APP] --configuration=production

# Build de desarrollo
npx nx build [NOMBRE_DE_LA_APP] --configuration=development

# Servir en modo desarrollo
npx nx serve [NOMBRE_DE_LA_APP]

# Verificar configuración
npx nx graph
```

---

## 🚫 FASE 9: Troubleshooting y Solución de Problemas

### **9.1. Problemas Comunes y Soluciones**

#### ⚠️ **Error: "ENOENT: no such file or directory, stat 'favicon.ico'"**

**Solución:**
```powershell
# Editar apps/[NOMBRE_DE_LA_APP]/project.json
# En la sección "assets", cambiar de:
"assets": ["apps/[NOMBRE_DE_LA_APP]/src/favicon.ico", "apps/[NOMBRE_DE_LA_APP]/public"]

# A:
"assets": [{
  "glob": "**/*",
  "input": "apps/[NOMBRE_DE_LA_APP]/public",
  "output": "./"
}]
```

#### ⚠️ **Error: "Cannot find module './module-federation.config'"**

**Solución:**
```powershell
# El archivo rspack.config.js está referenciando un archivo que no existe
# Eliminar la línea problemática del rspack.config.js:
# const mfConfig = require('./module-federation.config');
```

#### ⚠️ **Error: "Entry is required. Please set the 'main' option"**

**Solución:**
```javascript
// En rspack.config.js, asegurarse de tener:
module.exports = {
  entry: './src/main.ts',  // ¡Esta línea es crucial!
  // ... resto de configuración
};
```

#### ⚠️ **Error: "Duplicate identifier 'NxWelcome'"**

**Solución:**
```typescript
// En apps/[NOMBRE_DE_LA_APP]/src/app/app.routes.ts
// Eliminar importaciones duplicadas:
import { Route } from '@angular/router';
import { NxWelcome } from './nx-welcome';  // Solo una vez

export const appRoutes: Route[] = [
  {
    path: '',
    component: NxWelcome,
  },
  // Solo una ruta
];
```

### **9.2. Comandos de Diagnóstico**

```powershell
# Verificar versiones instaladas
node --version
npm --version
npx nx --version

# Verificar paquetes de Rspack
npm list @rspack/core @nx/rspack --depth=0

# Verificar configuración del proyecto
npx nx show project [NOMBRE_DE_LA_APP]

# Limpiar cache si hay problemas
npx nx reset
npm cache clean --force
```

### **9.3. Comandos de Limpieza**

```powershell
# Si algo sale mal, limpiar completamente:
rmdir /s /q node_modules
rmdir /s /q dist
npm install --legacy-peer-deps
```

---

## 🏆 RESULTADO FINAL ESPERADO

### **✅ Características Confirmadas:**

- ✅ **Aplicación Angular 20.2.4** con componentes standalone
- ✅ **Rspack 1.5.6** como bundler (más rápido que webpack)
- ✅ **Module Federation** configurado como Host
- ✅ **Dev server optimizado** para microfrontends
- ✅ **Shared libraries** de Angular configuradas
- ✅ **Bootstrap pattern** implementado correctamente
- ✅ **Routing** preparado para carga dinámica
- ✅ **TypeScript 5.9.2** con soporte completo
- ✅ **Build y serve** funcionando perfectamente

### **📈 Rendimiento:**

- **Build time**: ~9-11 segundos (vs ~20-30s con webpack)
- **Dev server start**: ~3-5 segundos
- **Hot reload**: < 1 segundo
- **Bundle size**: Optimizado con code splitting automático

### **🔗 URLs Importantes:**

- **Aplicación**: http://localhost:4200
- **Module Federation Entry**: http://localhost:4200/remoteEntry.js
- **Assets**: Servidos desde http://localhost:4200/assets/

---

## 📚 Referencias y Recursos

### **Documentación Oficial:**
- [Nx Angular](https://nx.dev/packages/angular)
- [Rspack](https://rspack.dev/)
- [Module Federation](https://module-federation.io/)
- [Angular CLI](https://angular.io/cli)

### **Comandos de Referencia Rápida:**
```powershell
# Desarrollo
npx nx serve [NOMBRE_DE_LA_APP]                    # Servidor de desarrollo
npx nx build [NOMBRE_DE_LA_APP] --watch           # Build con auto-rebuild
npx nx test [NOMBRE_DE_LA_APP]                     # Ejecutar pruebas

# Producción
npx nx build [NOMBRE_DE_LA_APP] --configuration=production
npx nx serve [NOMBRE_DE_LA_APP] --configuration=production

# Utilidades
npx nx graph                                       # Ver grafo del proyecto
npx nx show project [NOMBRE_DE_LA_APP]            # Ver configuración
npx nx reset                                       # Limpiar cache
```

---

<div align="center">

## 🎉 **¡CONFIGURACIÓN COMPLETA EXITOSA!** 🎉

**Tu aplicación está lista para funcionar como Host de Module Federation con Rspack**

🚀 **Performance optimizado** • 🛠️ **100% configurable** • 🔄 **Escalable** • ⚙️ **Probado y funcional**

*Creado y probado en el sistema de referencia*

</div>
