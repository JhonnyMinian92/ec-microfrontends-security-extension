# 🏗️ Arquitectura Chrome Extension + Microfrontends

## 📊 **Análisis del Proyecto**

### **Contexto:**
- **Tipo**: Extensión de Google Chrome para Security Extensions
- **Framework**: Angular + Rspack + Module Federation
- **Microfrontends**: 4 remotos especializados + 1 shell orchestrator
- **Función principal**: Gestión integral de documentos con seguridad empresarial

### **Requisitos Especiales:**
- ✅ Chrome Extension APIs (Storage, Tabs, Active Tab)
- ✅ Content Scripts + Background Workers
- ✅ Manifest V3 compliance + CSP strict
- ✅ PDF Viewer como remote principal
- ✅ Sistema de Login + Dashboard navegación
- ✅ Signature Workers (crypto + validation)
- ✅ Cloud Services integration
- ✅ Online Documents management
- ✅ Comunicación segura entre contextos

---

## 🏛️ **PATRÓN ARQUITECTURAL RECOMENDADO**

### **"Security-Extension Pattern" con Module Federation**

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CHROME EXTENSION SHELL (Host)                    │
├─────────────────────────────────────────────────────────────────────┤
│  🎆 LOGIN SYSTEM + DASHBOARD NAVIGATION                      │
│  ├── Extension Bridge (Chrome APIs + Security)                 │
│  ├── Remote Orchestrator (Module Federation + Auth)           │
│  ├── Context Manager (Background ↔ Content ↔ Popup)           │
│  ├── Signature Workers (crypto.worker + signature.worker)     │
│  └── PDF-Lib Wrapper (pdf-lib-wrapper.ts)                    │
└─────────────────────────────────────────────────────────────────────┘
                                        │
                  ┌─────────────┼───────────────┐
                  │             │               │
       ┌──────────┴───┐   ┌──────┴────────┴───────┐
       │ 📄 PDF VIEWER │   │ ✍️ SIGNATURE  │ │ ☁️ CLOUD   │
       │    (PRINCIPAL)  │   │   MANAGER    │ │ MANAGER  │
       │     Remote     │   │   Remote     │ │  Remote  │
       └───────────────┘   └──────────────┴───────┘
                                          │
                                   ┌──────┴────────┐
                                   │ 📝 DOCUMENTS  │
                                   │   ONLINE      │
                                   │   Remote      │
                                   └───────────────┘
```

---

## 📁 **ESTRUCTURA DE ARCHIVOS PROPUESTA**

```
ec-microfrontends-security-extension/
├── 📂 apps/
│   ├── 🏠 shell/                          # Host principal + Login + Dashboard
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── features/
│   │   │   │   │   ├── auth/
│   │   │   │   │   │   ├── login/
│   │   │   │   │   │   │   ├── login.component.ts
│   │   │   │   │   │   │   ├── login.component.html
│   │   │   │   │   │   │   └── login.component.scss
│   │   │   │   │   │   ├── auth.service.ts
│   │   │   │   │   │   └── auth.guard.ts
│   │   │   │   │   └── dashboard/
│   │   │   │   │       ├── dashboard.component.ts
│   │   │   │   │       ├── dashboard.component.html
│   │   │   │   │       ├── dashboard.component.scss
│   │   │   │   │       └── remote-navigator.service.ts
│   │   │   │   ├── core/
│   │   │   │   │   ├── chrome-bridge.service.ts
│   │   │   │   │   ├── remote-loader.service.ts
│   │   │   │   │   └── context-manager.service.ts
│   │   │   │   ├── shared/
│   │   │   │   │   ├── interfaces/
│   │   │   │   │   └── utils/
│   │   │   │   └── shell-orchestrator/
│   │   │   ├── background/
│   │   │   │   └── background.ts
│   │   │   ├── content/
│   │   │   │   └── content-script.ts
│   │   │   ├── popup/
│   │   │   │   └── popup.html
│   │   │   └── worker/
│   │   │       ├── signature.worker.ts
│   │   │       └── crypto.worker.ts
│   │   ├── public/
│   │   │   ├── manifest.json              # Manifest V3
│   │   │   ├── icons/
│   │   │   └── _locales/
│   │   └── rspack.config.js               # Con Module Federation
│   │
│   ├── 📄 pdf-viewer-remote/              # Remote 1 (PRINCIPAL)
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── pdf-engine/
│   │   │   │   │   ├── pdf-renderer.component.ts
│   │   │   │   │   ├── pdf-canvas.component.ts
│   │   │   │   │   └── pdf-worker.service.ts
│   │   │   │   ├── annotations/
│   │   │   │   │   ├── annotation.component.ts
│   │   │   │   │   └── annotation.service.ts
│   │   │   │   ├── controls/
│   │   │   │   │   ├── zoom-controls.component.ts
│   │   │   │   │   ├── navigation.component.ts
│   │   │   │   │   └── toolbar.component.ts
│   │   │   │   └── pdf-viewer.module.ts
│   │   │   └── remote-entry.ts
│   │   └── rspack.config.js
│   │
│   ├── ✍️ signature-manager-remote/          # Remote 2
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── signature-services/
│   │   │   │   │   ├── signature-provider.service.ts
│   │   │   │   │   ├── digital-signature.component.ts
│   │   │   │   │   └── signature-validation.service.ts
│   │   │   │   ├── contracts/
│   │   │   │   │   ├── service-contracts.component.ts
│   │   │   │   │   ├── contract-manager.service.ts
│   │   │   │   │   └── billing.component.ts
│   │   │   │   ├── crypto/
│   │   │   │   │   ├── encryption.service.ts
│   │   │   │   │   └── certificate.service.ts
│   │   │   │   └── signature-manager.module.ts
│   │   │   └── remote-entry.ts
│   │   └── rspack.config.js
│   │
│   ├── ☁️ cloud-manager-remote/             # Remote 3
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── cloud-services/
│   │   │   │   │   ├── cloud-provider.service.ts
│   │   │   │   │   ├── aws-s3.service.ts
│   │   │   │   │   ├── google-drive.service.ts
│   │   │   │   │   └── dropbox.service.ts
│   │   │   │   ├── storage/
│   │   │   │   │   ├── file-upload.component.ts
│   │   │   │   │   ├── cloud-browser.component.ts
│   │   │   │   │   └── sync.service.ts
│   │   │   │   ├── contracts/
│   │   │   │   │   ├── cloud-contracts.component.ts
│   │   │   │   │   └── billing-manager.service.ts
│   │   │   │   └── cloud-manager.module.ts
│   │   │   └── remote-entry.ts
│   │   └── rspack.config.js
│   │
│   └── 📝 documents-online-remote/        # Remote 4
│       ├── src/
│       │   ├── app/
│       │   │   ├── document-viewer/
│       │   │   │   ├── online-viewer.component.ts
│       │   │   │   ├── document-preview.component.ts
│       │   │   │   └── viewer.service.ts
│       │   │   ├── document-manager/
│       │   │   │   ├── document-list.component.ts
│       │   │   │   ├── search.component.ts
│       │   │   │   └── document.service.ts
│       │   │   ├── collaboration/
│       │   │   │   ├── real-time-editing.component.ts
│       │   │   │   ├── comments.component.ts
│       │   │   │   └── collaboration.service.ts
│       │   │   └── documents-online.module.ts
│       │   └── remote-entry.ts
│       └── rspack.config.js
│
├── 📂 libs/                               # Librerías compartidas
│   ├── chrome-extension-core/
│   │   ├── src/
│   │   │   ├── lib/
│   │   │   │   ├── chrome-apis.service.ts
│   │   │   │   ├── messaging.service.ts
│   │   │   │   ├── storage.service.ts
│   │   │   │   └── extension-auth.service.ts
│   │   │   └── index.ts
│   │   └── project.json
│   │
│   ├── shared-libs/                         # Workers y wrappers
│   │   ├── pdf-lib-wrapper/
│   │   │   ├── src/
│   │   │   │   ├── lib/
│   │   │   │   │   ├── pdf-lib-wrapper.ts           # Wrapper principal
│   │   │   │   │   ├── pdf-renderer.service.ts
│   │   │   │   │   ├── pdf-manipulation.service.ts
│   │   │   │   │   └── interfaces/
│   │   │   │   └── index.ts
│   │   │   └── project.json
│   │   ├── workers/
│   │   │   ├── signature.worker.ts              # Worker de firmas
│   │   │   ├── crypto.worker.ts                 # Worker de encriptación
│   │   │   ├── pdf.worker.ts                    # Worker de PDF processing
│   │   │   └── cloud-sync.worker.ts             # Worker de sincronización
│   │   └── project.json
│   │
│   ├── security-core/
│   │   ├── src/
│   │   │   ├── lib/
│   │   │   │   ├── encryption.service.ts
│   │   │   │   ├── signature-validation.service.ts
│   │   │   │   ├── certificate.service.ts
│   │   │   │   └── interfaces/
│   │   │   └── index.ts
│   │   └── project.json
│   │
│   └── shared-ui/
│       ├── src/
│       │   ├── lib/
│       │   │   ├── components/
│       │   │   │   ├── loading.component.ts
│       │   │   │   ├── modal.component.ts
│       │   │   │   └── navigation.component.ts
│       │   │   ├── directives/
│       │   │   └── pipes/
│       │   └── index.ts
│       └── project.json
│
├── 📂 tools/
│   ├── extension-builder/                 # Scripts de build personalizados
│   │   ├── build-extension.js             # Script principal de build
│   │   ├── validate-manifest.js           # Validador de manifest V3
│   │   ├── bundle-analyzer.js             # Análisis de bundles
│   │   ├── security-audit.js              # Auditoría de seguridad
│   │   ├── package-extension.js           # Empaquetado para Chrome Store
│   │   ├── test-extension.js              # Testing automatizado
│   │   └── deploy-extension.js            # Deploy automatizado
│   ├── dev-server/                        # Dev server para extension
│   │   ├── extension-dev-server.js        # Servidor de desarrollo
│   │   ├── hot-reload.js                  # Hot reload para extension
│   │   └── proxy-config.js                # Configuración de proxy
│   └── performance/
│       ├── bundle-optimizer.js            # Optimización de bundles
│       ├── lazy-loading-analyzer.js       # Análisis de lazy loading
│       └── memory-profiler.js             # Profiling de memoria
│
└── 📄 Archivos de configuración
    ├── nx.json
    ├── package.json
    └── tsconfig.base.json
```

---

## 🎯 **PATRONES DE DISEÑO APLICADOS**

### **1. 🏛️ Architectural Patterns**

#### **A) Micro-Extension Pattern (Principal)**
```typescript
// Shell como orchestrador de remotes en contexto de extensión
@Injectable({ providedIn: 'root' })
export class RemoteOrchestrator {
  private remotes = new Map<string, any>();
  
  async loadRemote(remoteName: string, context: 'popup' | 'content' | 'background') {
    const remote = await loadRemoteModule(remoteName);
    this.adaptToContext(remote, context);
    return remote;
  }
  
  private adaptToContext(remote: any, context: string) {
    // Adaptar el remote al contexto específico de Chrome
  }
}
```

#### **B) Bridge Pattern (Chrome APIs)**
```typescript
// Abstrae las APIs de Chrome para que sean consumibles por Angular
@Injectable({ providedIn: 'root' })
export class ChromeApiBridge {
  // Encapsula chrome.* APIs
  async getStorage(key: string): Promise<any> {
    return new Promise((resolve) => {
      chrome.storage.local.get([key], (result) => resolve(result[key]));
    });
  }
  
  async sendMessage(message: any): Promise<any> {
    return chrome.runtime.sendMessage(message);
  }
}
```

### **2. 🔄 Communication Patterns**

#### **A) Event Bus Pattern (Comunicación entre remotes)**
```typescript
@Injectable({ providedIn: 'root' })
export class ExtensionEventBus {
  private events$ = new Subject<ExtensionEvent>();
  
  emit(event: ExtensionEvent) {
    this.events$.next(event);
  }
  
  on<T>(eventType: string): Observable<T> {
    return this.events$.pipe(
      filter(event => event.type === eventType),
      map(event => event.payload)
    );
  }
}
```

#### **B) Context Adapter Pattern**
```typescript
// Adapta funcionalidades según el contexto de ejecución
export class ContextAdapter {
  static adapt(component: any, context: ExtensionContext) {
    switch(context) {
      case 'popup':
        return new PopupAdapter(component);
      case 'content':
        return new ContentAdapter(component);
      case 'background':
        return new BackgroundAdapter(component);
    }
  }
}
```

### **3. 📦 Loading Patterns**

#### **A) Lazy Loading con Context Awareness**
```typescript
const routes: Routes = [
  {
    path: 'pdf-viewer',
    loadChildren: () => loadRemoteModule('pdfViewer', {
      context: this.extensionContext,
      permissions: ['activeTab']
    })
  },
  {
    path: 'security',
    loadChildren: () => loadRemoteModule('security', {
      context: this.extensionContext,
      permissions: ['storage', 'tabs']
    })
  }
];
```

---

## ⚙️ **CONFIGURACIONES ESPECÍFICAS**

### **1. 📋 Manifest V3 Configuration**

```json
{
  "manifest_version": 3,
  "name": "PDF Viewer Extension",
  "version": "1.0.0",
  "description": "Advanced PDF viewer with microfrontends",
  
  "permissions": [
    "storage",
    "activeTab",
    "scripting"
  ],
  
  "background": {
    "service_worker": "background.js",
    "type": "module"
  },
  
  "content_scripts": [{
    "matches": ["<all_urls>"],
    "js": ["content-script.js"],
    "run_at": "document_start"
  }],
  
  "action": {
    "default_popup": "popup.html",
    "default_icon": "icons/icon-48.png"
  },
  
  "web_accessible_resources": [{
    "resources": [
      "remoteEntry.js",
      "*.js",
      "*.css"
    ],
    "matches": ["<all_urls>"]
  }],
  
  "content_security_policy": {
    "extension_pages": "script-src 'self' 'wasm-unsafe-eval'; object-src 'self'"
  }
}
```

### **2. 🔧 Rspack Config para Extension**

```javascript
// apps/shell/rspack.config.js
const { NxAppRspackPlugin } = require('@nx/rspack/app-plugin');
const rspack = require('@rspack/core');

module.exports = {
  entry: {
    main: './src/main.ts',
    background: './src/background/background.ts',
    'content-script': './src/content/content-script.ts'
  },
  
  output: {
    path: join(__dirname, '../../dist/apps/shell'),
    publicPath: 'chrome-extension://__MSG_@@extension_id__/',
  },
  
  plugins: [
    new NxAppRspackPlugin({
      target: 'web',
      tsConfig: 'apps/shell/tsconfig.app.json',
      main: 'apps/shell/src/main.ts',
    }),
    
    new rspack.container.ModuleFederationPlugin({
      name: 'securityExtensionShell',
      remotes: {
        pdfViewer: 'pdfViewer@chrome-extension://__MSG_@@extension_id__/remoteEntry.js',
        signatureManager: 'signatureManager@chrome-extension://__MSG_@@extension_id__/remoteEntry.js',
        cloudManager: 'cloudManager@chrome-extension://__MSG_@@extension_id__/remoteEntry.js',
        documentsOnline: 'documentsOnline@chrome-extension://__MSG_@@extension_id__/remoteEntry.js'
      },
      shared: {
        '@angular/core': { singleton: true, strictVersion: true },
        '@angular/common': { singleton: true, strictVersion: true },
        '@angular/router': { singleton: true, strictVersion: true },
        '@angular/platform-browser': { singleton: true, strictVersion: true },
        'rxjs': { singleton: true, strictVersion: true },
        'pdf-lib': { singleton: true },
        'pdfjs-dist': { singleton: true }
      }
    }),
    
    // Plugin para copiar manifest y assets
    new rspack.CopyRspackPlugin({
      patterns: [
        { from: 'public/manifest.json', to: 'manifest.json' },
        { from: 'public/icons', to: 'icons' },
        { from: 'public/_locales', to: '_locales' }
      ]
    })
  ]
};
```

---

## 🔄 **FLUJOS DE COMUNICACIÓN**

### **1. 📄 PDF Viewer como Default Handler**

```typescript
// Background script registration
chrome.runtime.onInstalled.addListener(() => {
  // Registrar como default PDF viewer
  chrome.declarativeContent.onPageChanged.addRules([{
    conditions: [
      new chrome.declarativeContent.PageStateMatcher({
        pageUrl: { urlSuffix: '.pdf' }
      })
    ],
    actions: [
      new chrome.declarativeContent.ShowAction(),
      // Cargar PDF viewer remote
      new chrome.declarativeContent.RequestContentScript({
        js: ['pdf-viewer-loader.js']
      })
    ]
  }]);
});
```

### **2. 🔗 Remote Communication Flow**

```
PDF Detection → Background Script → Shell Orchestrator → PDF Viewer Remote
      ↓                ↓                    ↓                    ↓
Content Script ←→ Chrome APIs ←→ Event Bus ←→ Security Remote ←→ Analytics
      ↓                ↓                    ↓                    ↓  
   Settings ←────── Storage ←────── Context Manager ←────── UI Updates
```

---

## 🎯 **VENTAJAS DE ESTA ARQUITECTURA**

### ✅ **Beneficios Técnicos:**
1. **Modularidad**: Cada funcionalidad es un microfrontend independiente
2. **Escalabilidad**: Fácil agregar nuevos remotes
3. **Performance**: Carga lazy de funcionalidades
4. **Mantenimiento**: Desarrollo y deploy independientes
5. **Testing**: Pruebas aisladas por remote

### ✅ **Beneficios para Chrome Extension:**
1. **CSP Compliance**: Cumple Content Security Policy
2. **Context Isolation**: Separación clara de contextos
3. **Permission Management**: Permisos granulares por remote
4. **Resource Efficiency**: Carga solo lo necesario
5. **Update Strategy**: Actualizaciones parciales

---

## 🚀 **IMPLEMENTACIÓN RECOMENDADA**

### **Fase 1: Core Shell + Login/Dashboard (2-3 semanas)**
- ✅ Shell extension base con Chrome APIs
- ✅ Sistema de Login en `features/auth/`
- ✅ Dashboard de navegación entre remotes
- ✅ Chrome Extension manifest V3 + CSP
- ✅ PDF-Lib wrapper básico
- ✅ Workers foundation (crypto.worker, signature.worker)

### **Fase 2: PDF Viewer Remote (Principal) (3-4 semanas)**
- ✅ PDF Viewer como remote principal
- ✅ PDF rendering engine con pdfjs-dist
- ✅ Annotations y markup tools
- ✅ Zoom controls y navigation
- ✅ PDF manipulation con pdf-lib
- ✅ Integración con Shell dashboard

### **Fase 3: Signature Manager Remote (3-4 semanas)**
- ✅ Digital signature services
- ✅ Certificate management
- ✅ Contracted services management
- ✅ Crypto workers integration
- ✅ Signature validation
- ✅ Billing component para servicios

### **Fase 4: Cloud Manager Remote (2-3 semanas)**
- ✅ Multi-cloud integration (AWS, Google, Dropbox)
- ✅ File upload/download components
- ✅ Cloud synchronization workers
- ✅ Storage contracts management
- ✅ Cloud billing integration

### **Fase 5: Documents Online Remote (2-3 semanas)**
- ✅ Online document viewer
- ✅ Document management system
- ✅ Real-time collaboration features
- ✅ Comments and annotation system
- ✅ Search and filtering capabilities

### **Fase 6: Integration + Testing (2 semanas)**
- ✅ Inter-remote communication optimization
- ✅ Performance testing y optimization
- ✅ Security testing completo
- ✅ Chrome Web Store preparation
- ✅ End-to-end testing

---

## 📚 **TECNOLOGÍAS COMPLEMENTARIAS**

```typescript
// Librerías adicionales recomendadas para Security Extension
{
  "dependencies": {
    // PDF Processing
    "pdf-lib": "^1.17.1",           // Manipulación avanzada de PDFs
    "pdfjs-dist": "^3.11.174",     // Renderizado de PDFs (Mozilla)
    
    // Security & Crypto
    "node-forge": "^1.3.1",        // Cryptographic functions
    "jsrsasign": "^10.8.6",        // Digital signatures
    "crypto-js": "^4.1.1",         // Encryption/decryption
    
    // Cloud Services
    "aws-sdk": "^2.1467.0",        // AWS S3 integration
    "@google-cloud/storage": "^6.12.0", // Google Cloud Storage
    "dropbox": "^10.34.0",         // Dropbox API
    
    // Workers & Performance
    "comlink": "^4.4.1",           // Web Workers communication
    "idb": "^7.1.1",               // IndexedDB wrapper
    "web-streams-polyfill": "^3.2.1", // Streams API polyfill
    
    // UI & Utils
    "@angular/cdk": "^17.0.0",     // Angular CDK components
    "rxjs": "^7.8.2",              // Reactive programming
    "date-fns": "^2.30.0"          // Date utilities
  },
  
  "devDependencies": {
    "@types/chrome": "^0.0.243",   // Chrome Extension types
    "@types/node-forge": "^1.3.5", // Node-forge types
    "@types/crypto-js": "^4.1.2",  // Crypto-js types
    "web-ext": "^7.8.0",          // Extension development tools
    "chrome-webstore-upload": "^5.0.0", // Automated deployment
    "@types/pdf-lib": "^1.17.1",  // PDF-lib types
    "webpack-bundle-analyzer": "^4.9.1" // Bundle analysis
  }
}
```

---

## 🤖 **AUTOMATIZACIÓN DE BUILD Y DEPLOY**

### **1. 🔧 Scripts de Build Personalizados**

#### **A) Script Principal de Build (`tools/extension-builder/build-extension.js`)**

```javascript
#!/usr/bin/env node
const { execSync } = require('child_process');
const fs = require('fs-extra');
const path = require('path');
const bundleAnalyzer = require('./bundle-analyzer');
const manifestValidator = require('./validate-manifest');
const securityAudit = require('./security-audit');

class ExtensionBuilder {
  constructor(options = {}) {
    this.isDev = options.mode === 'development';
    this.outputDir = 'dist/extension';
    this.tempDir = '.temp-build';
  }

  async build() {
    console.log('🚀 Iniciando build de Security Extension...');
    
    try {
      // 1. Limpiar directorios
      await this.cleanup();
      
      // 2. Build de todos los remotes
      await this.buildRemotes();
      
      // 3. Build del shell
      await this.buildShell();
      
      // 4. Procesar workers
      await this.processWorkers();
      
      // 5. Validar manifest
      await manifestValidator.validate();
      
      // 6. Análisis de bundles
      const bundleReport = await bundleAnalyzer.analyze();
      
      // 7. Auditoría de seguridad
      const securityReport = await securityAudit.audit();
      
      // 8. Empaquetar extensión
      await this.packageExtension();
      
      console.log('✅ Build completado exitosamente!');
      console.log(`📄 Bundle size: ${bundleReport.totalSize}`);
      console.log(`🔒 Security score: ${securityReport.score}/100`);
      
    } catch (error) {
      console.error('❌ Build fallido:', error.message);
      process.exit(1);
    }
  }

  async buildRemotes() {
    const remotes = ['pdf-viewer', 'signature-manager', 'cloud-manager', 'documents-online'];
    
    for (const remote of remotes) {
      console.log(`📱 Building ${remote} remote...`);
      execSync(`npx nx build ${remote}-remote --configuration=${this.isDev ? 'development' : 'production'}`, 
        { stdio: 'inherit' });
    }
  }

  async buildShell() {
    console.log('🏠 Building shell application...');
    execSync(`npx nx build shell --configuration=${this.isDev ? 'development' : 'production'}`, 
      { stdio: 'inherit' });
  }

  async processWorkers() {
    console.log('📐 Processing workers...');
    const workers = ['signature.worker.ts', 'crypto.worker.ts'];
    
    for (const worker of workers) {
      const workerPath = path.join('apps/shell/src/worker', worker);
      const outputPath = path.join(this.outputDir, worker.replace('.ts', '.js'));
      
      // Compile worker with specific config for Chrome Extension
      execSync(`npx tsc ${workerPath} --target ES2020 --module ESNext --outDir ${path.dirname(outputPath)}`);
    }
  }

  async packageExtension() {
    console.log('📦 Packaging extension...');
    
    // Copy manifest and assets
    await fs.copy('apps/shell/public', this.outputDir);
    
    // Create .zip for Chrome Web Store
    if (!this.isDev) {
      execSync(`cd ${this.outputDir} && zip -r ../security-extension-${this.getVersion()}.zip .`);
    }
  }
}

// CLI usage
if (require.main === module) {
  const builder = new ExtensionBuilder({ mode: process.argv[2] || 'production' });
  builder.build();
}

module.exports = ExtensionBuilder;
```

#### **B) Validador de Manifest (`tools/extension-builder/validate-manifest.js`)**

```javascript
const fs = require('fs-extra');
const ajv = require('ajv');

class ManifestValidator {
  constructor() {
    this.manifestPath = 'apps/shell/public/manifest.json';
    this.schema = this.getManifestV3Schema();
  }

  async validate() {
    console.log('📝 Validando manifest V3...');
    
    const manifest = await fs.readJson(this.manifestPath);
    
    // Validación de esquema
    const validator = ajv({ allErrors: true });
    const valid = validator(this.schema, manifest);
    
    if (!valid) {
      throw new Error(`Manifest inválido: ${validator.errors.map(e => e.message).join(', ')}`);
    }
    
    // Validaciones de seguridad específicas
    this.validateSecurityPolicies(manifest);
    this.validatePermissions(manifest);
    
    console.log('✅ Manifest V3 válido!');
  }

  validateSecurityPolicies(manifest) {
    const csp = manifest.content_security_policy;
    
    if (!csp || !csp.extension_pages) {
      throw new Error('CSP requerido para extension_pages');
    }
    
    // Validar que no permita 'unsafe-eval' excepto para wasm
    if (csp.extension_pages.includes("'unsafe-eval'") && !csp.extension_pages.includes("'wasm-unsafe-eval'")) {
      throw new Error('CSP inseguro detectado');
    }
  }

  validatePermissions(manifest) {
    const requiredPermissions = ['storage', 'activeTab'];
    const dangerousPermissions = ['tabs', 'history', 'bookmarks'];
    
    // Verificar permisos requeridos
    for (const perm of requiredPermissions) {
      if (!manifest.permissions.includes(perm)) {
        console.warn(`⚠️ Permiso requerido faltante: ${perm}`);
      }
    }
    
    // Advertir sobre permisos peligrosos
    for (const perm of dangerousPermissions) {
      if (manifest.permissions.includes(perm)) {
        console.warn(`⚠️ Permiso sensible detectado: ${perm} - Justificar su uso`);
      }
    }
  }
}

module.exports = ManifestValidator;
```

#### **C) Analizador de Bundles (`tools/extension-builder/bundle-analyzer.js`)**

```javascript
const fs = require('fs-extra');
const path = require('path');
const gzipSize = require('gzip-size');

class BundleAnalyzer {
  constructor() {
    this.distDir = 'dist';
    this.maxBundleSize = 2 * 1024 * 1024; // 2MB limit for Chrome Extension
  }

  async analyze() {
    console.log('📈 Analizando tamaños de bundle...');
    
    const report = {
      remotes: {},
      shell: {},
      workers: {},
      totalSize: 0,
      warnings: []
    };
    
    // Analizar cada remote
    const remotes = ['pdf-viewer', 'signature-manager', 'cloud-manager', 'documents-online'];
    
    for (const remote of remotes) {
      const remotePath = path.join(this.distDir, 'apps', `${remote}-remote`);
      if (await fs.pathExists(remotePath)) {
        report.remotes[remote] = await this.analyzeDirectory(remotePath);
      }
    }
    
    // Analizar shell
    const shellPath = path.join(this.distDir, 'apps', 'shell');
    if (await fs.pathExists(shellPath)) {
      report.shell = await this.analyzeDirectory(shellPath);
    }
    
    // Calcular tamaño total
    report.totalSize = this.calculateTotalSize(report);
    
    // Generar advertencias
    this.generateWarnings(report);
    
    // Guardar reporte
    await fs.writeJson('dist/bundle-report.json', report, { spaces: 2 });
    
    return report;
  }

  async analyzeDirectory(dirPath) {
    const files = await this.getJSFiles(dirPath);
    const analysis = {
      files: {},
      totalSize: 0,
      gzippedSize: 0
    };
    
    for (const file of files) {
      const filePath = path.join(dirPath, file);
      const content = await fs.readFile(filePath);
      const gzipped = await gzipSize(content);
      
      analysis.files[file] = {
        size: content.length,
        gzippedSize: gzipped
      };
      
      analysis.totalSize += content.length;
      analysis.gzippedSize += gzipped;
    }
    
    return analysis;
  }

  generateWarnings(report) {
    // Advertencia por tamaño total
    if (report.totalSize > this.maxBundleSize) {
      report.warnings.push(`Bundle total excede ${this.maxBundleSize / 1024 / 1024}MB`);
    }
    
    // Advertencias por remote
    Object.entries(report.remotes).forEach(([name, data]) => {
      if (data.totalSize > 512 * 1024) { // 512KB per remote
        report.warnings.push(`Remote ${name} es muy grande: ${(data.totalSize / 1024).toFixed(1)}KB`);
      }
    });
  }
}

module.exports = BundleAnalyzer;
```

---

## 🔒 **OPTIMIZACIÓN DE PERFORMANCE Y SEGURIDAD**

### **1. 🎨 Optimización de Performance**

#### **A) Manifest V3 Optimizado con Permisos Mínimos**

```json
{
  "manifest_version": 3,
  "name": "Security Document Extension",
  "version": "1.0.0",
  "description": "Enterprise document security with microfrontends",
  
  "permissions": [
    "storage",           // Básico para configuración
    "activeTab"          // Solo tab activo, no todos los tabs
  ],
  
  "optional_permissions": [
    "scripting",         // Solo cuando sea necesario
    "offscreen"          // Para workers cuando se requiera
  ],
  
  "background": {
    "service_worker": "background.js",
    "type": "module"
  },
  
  "content_scripts": [{
    "matches": ["https://*.pdf", "file://*.pdf"],  // Solo PDFs
    "js": ["content-script.js"],
    "run_at": "document_start",
    "world": "ISOLATED"     // Aislamiento máximo
  }],
  
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icons/icon-16.png",
      "32": "icons/icon-32.png",
      "48": "icons/icon-48.png",
      "128": "icons/icon-128.png"
    }
  },
  
  "web_accessible_resources": [{
    "resources": [
      "remoteEntry.js",
      "*.css",
      "worker/*.js"
    ],
    "matches": ["https://*/*"],
    "use_dynamic_url": true    // URL dinámica para seguridad
  }],
  
  "content_security_policy": {
    "extension_pages": "script-src 'self' 'wasm-unsafe-eval'; object-src 'self'; connect-src https: wss:;",
    "sandbox": "sandbox allow-scripts allow-forms allow-popups allow-modals;"
  },
  
  "host_permissions": [
    "https://*.amazonaws.com/*",    // Solo dominios necesarios
    "https://*.googleapis.com/*",
    "https://*.dropboxapi.com/*"
  ]
}
```

#### **B) Optimización de Bundles con Tree Shaking**

```javascript
// apps/shell/rspack.config.js - Optimized
const { NxAppRspackPlugin } = require('@nx/rspack/app-plugin');
const rspack = require('@rspack/core');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

module.exports = {
  entry: {
    main: './src/main.ts',
    background: './src/background/background.ts',
    'content-script': './src/content/content-script.ts'
  },
  
  output: {
    path: join(__dirname, '../../dist/apps/shell'),
    publicPath: 'chrome-extension://__MSG_@@extension_id__/',
    filename: '[name].[contenthash].js',
    chunkFilename: '[name].[contenthash].chunk.js'
  },
  
  optimization: {
    minimize: true,
    sideEffects: false,      // Habilitar tree shaking
    usedExports: true,
    providedExports: true,
    
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /node_modules/,
          name: 'vendors',
          chunks: 'all',
          priority: 10
        },
        angular: {
          test: /[\\/]node_modules[\\/]@angular[\\/]/,
          name: 'angular',
          chunks: 'all',
          priority: 20
        },
        pdf: {
          test: /[\\/]node_modules[\\/](pdf-lib|pdfjs-dist)[\\/]/,
          name: 'pdf-libs',
          chunks: 'all',
          priority: 15
        }
      }
    }
  },
  
  plugins: [
    new NxAppRspackPlugin({
      target: 'web',
      tsConfig: 'apps/shell/tsconfig.app.json',
      main: 'apps/shell/src/main.ts',
      optimization: true,
      extractCss: true,
      sourceMap: false      // Deshabilitado en producción
    }),
    
    new rspack.container.ModuleFederationPlugin({
      name: 'securityExtensionShell',
      remotes: {
        pdfViewer: `pdfViewer@chrome-extension://__MSG_@@extension_id__/remoteEntry.js`,
        signatureManager: `signatureManager@chrome-extension://__MSG_@@extension_id__/remoteEntry.js`,
        cloudManager: `cloudManager@chrome-extension://__MSG_@@extension_id__/remoteEntry.js`,
        documentsOnline: `documentsOnline@chrome-extension://__MSG_@@extension_id__/remoteEntry.js`
      },
      shared: {
        '@angular/core': { 
          singleton: true, 
          strictVersion: true,
          requiredVersion: '^20.2.0'
        },
        '@angular/common': { 
          singleton: true, 
          strictVersion: true,
          requiredVersion: '^20.2.0'
        },
        'rxjs': { 
          singleton: true, 
          strictVersion: true,
          requiredVersion: '^7.8.0'
        }
      }
    }),
    
    // Análisis de bundle solo en desarrollo
    ...(process.env.ANALYZE_BUNDLE ? [new BundleAnalyzerPlugin()] : [])
  ]
};
```

#### **C) Lazy Loading Inteligente**

```typescript
// apps/shell/src/app/features/dashboard/remote-navigator.service.ts
@Injectable({ providedIn: 'root' })
export class RemoteNavigatorService {
  private loadedRemotes = new Set<string>();
  private loadingPromises = new Map<string, Promise<any>>();
  
  async loadRemote(remoteName: string): Promise<any> {
    // Evitar cargas duplicadas
    if (this.loadedRemotes.has(remoteName)) {
      return Promise.resolve();
    }
    
    // Usar promesa existente si está cargando
    if (this.loadingPromises.has(remoteName)) {
      return this.loadingPromises.get(remoteName);
    }
    
    // Iniciar carga con timeout
    const loadPromise = this.loadRemoteWithTimeout(remoteName, 10000);
    this.loadingPromises.set(remoteName, loadPromise);
    
    try {
      const module = await loadPromise;
      this.loadedRemotes.add(remoteName);
      this.loadingPromises.delete(remoteName);
      return module;
    } catch (error) {
      this.loadingPromises.delete(remoteName);
      console.error(`Failed to load remote ${remoteName}:`, error);
      throw error;
    }
  }
  
  private async loadRemoteWithTimeout(remoteName: string, timeout: number): Promise<any> {
    return Promise.race([
      this.loadRemoteModule(remoteName),
      new Promise((_, reject) => 
        setTimeout(() => reject(new Error(`Timeout loading ${remoteName}`)), timeout)
      )
    ]);
  }
  
  private async loadRemoteModule(remoteName: string): Promise<any> {
    switch (remoteName) {
      case 'pdfViewer':
        return import('pdfViewer/Module');
      case 'signatureManager':
        return import('signatureManager/Module');
      case 'cloudManager':
        return import('cloudManager/Module');
      case 'documentsOnline':
        return import('documentsOnline/Module');
      default:
        throw new Error(`Unknown remote: ${remoteName}`);
    }
  }
  
  // Preload crítico
  async preloadCriticalRemotes(): Promise<void> {
    await this.loadRemote('pdfViewer'); // PDF Viewer es crítico
  }
}
```

### **2. 🔐 Configuración de Seguridad Avanzada**

#### **A) Security Audit Script (`tools/extension-builder/security-audit.js`)**

```javascript
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');

class SecurityAuditor {
  constructor() {
    this.securityRules = {
      // Patrones peligrosos
      dangerousPatterns: [
        /eval\s*\(/g,
        /innerHTML\s*=/g,
        /document\.write/g,
        /\.postMessage\(/g,
        /window\[/g
      ],
      
      // APIs sensibles
      sensitiveAPIs: [
        'chrome.tabs',
        'chrome.history', 
        'chrome.bookmarks',
        'chrome.cookies'
      ],
      
      // Patrones requeridos de seguridad
      securityPatterns: [
        /Content-Security-Policy/i,
        /sanitize|escape/i
      ]
    };
  }
  
  async audit() {
    console.log('🔍 Ejecutando auditoría de seguridad...');
    
    const report = {
      score: 100,
      issues: [],
      warnings: [],
      recommendations: []
    };
    
    // Auditar archivos JavaScript
    await this.auditJavaScriptFiles(report);
    
    // Auditar manifest
    await this.auditManifest(report);
    
    // Auditar dependencias
    await this.auditDependencies(report);
    
    // Calcular score final
    report.score = Math.max(0, 100 - (report.issues.length * 10) - (report.warnings.length * 5));
    
    // Guardar reporte
    await fs.writeJson('dist/security-report.json', report, { spaces: 2 });
    
    return report;
  }
  
  async auditJavaScriptFiles(report) {
    const jsFiles = await this.findJSFiles('dist');
    
    for (const file of jsFiles) {
      const content = await fs.readFile(file, 'utf-8');
      
      // Buscar patrones peligrosos
      for (const pattern of this.securityRules.dangerousPatterns) {
        if (pattern.test(content)) {
          report.issues.push({
            type: 'dangerous-pattern',
            file: path.relative('dist', file),
            pattern: pattern.source,
            severity: 'high'
          });
        }
      }
      
      // Verificar uso de APIs sensibles
      for (const api of this.securityRules.sensitiveAPIs) {
        if (content.includes(api)) {
          report.warnings.push({
            type: 'sensitive-api',
            file: path.relative('dist', file),
            api: api,
            severity: 'medium'
          });
        }
      }
    }
  }
  
  async auditManifest(report) {
    const manifest = await fs.readJson('apps/shell/public/manifest.json');
    
    // Verificar permisos excesivos
    const dangerousPermissions = ['tabs', 'history', 'bookmarks', '<all_urls>'];
    for (const perm of dangerousPermissions) {
      if (manifest.permissions?.includes(perm)) {
        report.warnings.push({
          type: 'excessive-permission',
          permission: perm,
          severity: 'medium',
          recommendation: `Considerar usar optional_permissions para ${perm}`
        });
      }
    }
    
    // Verificar CSP
    if (!manifest.content_security_policy?.extension_pages) {
      report.issues.push({
        type: 'missing-csp',
        severity: 'high',
        recommendation: 'Agregar Content Security Policy estricto'
      });
    }
  }
}

module.exports = SecurityAuditor;
```

#### **B) Scripts de Build en package.json**

```json
{
  "scripts": {
    "build:extension": "node tools/extension-builder/build-extension.js production",
    "build:extension:dev": "node tools/extension-builder/build-extension.js development",
    "analyze:bundles": "ANALYZE_BUNDLE=true npm run build:extension",
    "audit:security": "node tools/extension-builder/security-audit.js",
    "validate:manifest": "node tools/extension-builder/validate-manifest.js",
    "package:extension": "node tools/extension-builder/package-extension.js",
    "deploy:store": "node tools/extension-builder/deploy-extension.js",
    "test:extension": "web-ext lint --source-dir=dist/extension && npm run audit:security",
    "dev:extension": "concurrently \"npm run build:extension:dev\" \"web-ext run --source-dir=dist/extension\""
  }
}
```

Esta arquitectura optimizada te dará **máxima seguridad, performance y mantenibilidad** para tu extensión empresarial.
