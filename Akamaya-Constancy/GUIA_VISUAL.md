# 🔒 GUÍA DE SEGURIDAD - Akamaya Constancy

## El Problema: Credenciales Expuestas ❌

```
┌─────────────────────────────────────────────────────────┐
│  ANTES - Todo visible en el navegador                    │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Usuario abre Inspector (F12)                           │
│  ↓                                                       │
│  Ve el código JavaScript con:                           │
│  • Usernames: validfmf, Constfmf                        │
│  • Passwords: PMfmf2026#$, PMC0nst#2026#                │
│  • License ID: A9F3K7M2Q8R5LZ4X6B1                      │
│  • Constancy IDs: C7A9M2FQ, 9KX4B7L2                    │
│                                                          │
│  ⚠️ ¡PROBLEMA! Cualquiera puede verlos                  │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## La Solución: Backend Seguro ✅

```
┌──────────────────────────────────────────────────────────────┐
│  DESPUÉS - Credenciales en el servidor                       │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  CLIENTE (navegador)          SERVIDOR (Node.js)            │
│  ┌──────────────┐             ┌──────────────────┐          │
│  │              │             │   server.js      │          │
│  │  HTML/JS     │  JSON ←--→  │  ┌────────────┐  │          │
│  │              │             │  │ .env file  │  │          │
│  │ Solo UI      │             │  │ Credencials│  │          │
│  │ sin datos    │             │  │ (oculto)   │  │          │
│  └──────────────┘             │  └────────────┘  │          │
│                                │  ┌────────────┐  │          │
│  Usuario abre Inspector (F12)  │  │ Validación │  │          │
│  ↓                             │  │  Lógica    │  │          │
│  Ve: fetch() calls solamente   │  └────────────┘  │          │
│                                └──────────────────┘          │
│  ⚠️ ¡SEGURO! No ve credenciales                             │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

---

## Flujo de Validación

### 1. Login
```
┌─────────────────────────────────────────────────────────┐
│  Cliente: Envía {username, password}                    │
└─────────────────────────────────────────────────────────┘
           ↓ (HTTPS - encriptado)
┌─────────────────────────────────────────────────────────┐
│  Servidor: Compara con .env                            │
│  • ¿username === licenseCredentials.username?          │
│  • ¿password === licenseCredentials.password?          │
└─────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────┐
│  Servidor: Responde {success: true/false, userType}    │
└─────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────┐
│  Cliente: Muestra pantalla de validación               │
└─────────────────────────────────────────────────────────┘
```

### 2. Validar License ID
```
┌─────────────────────────────────────────────────────────┐
│  Cliente: Envía {licenseId}                            │
└─────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────┐
│  Servidor: Compara con VALID_LICENSE_ID en .env       │
│  if (licenseId === validIDs.license) → ✓ Válido        │
└─────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────┐
│  Servidor: Responde {success: true/false}              │
└─────────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────────┐
│  Cliente: Muestra resultado                            │
└─────────────────────────────────────────────────────────┘
```

### 3. Validar Constancy ID
```
Lo mismo pero devuelve también el nombre asociado
┌─────────────────────────────────────────────────────────┐
│  Servidor: Si ID válido                                │
│  → Busca nombre en constancyNames{}                    │
│  → Devuelve {success: true, name, status}              │
└─────────────────────────────────────────────────────────┘
```

---

## Estructura de Archivos

```
Tu Servidor (Linux/Windows)
│
├── server.js .......................... Backend Express
│   ├── Endpoints API
│   ├── Validaciones
│   └── Lógica de negocio
│
├── package.json ....................... Dependencias
│   ├── express
│   ├── cors
│   └── dotenv
│
├── .env (⚠️ SECRETO) .................. Variables de entorno
│   ├── LICENSE_USERNAME
│   ├── LICENSE_PASSWORD
│   ├── CONSTANCY_USERNAME
│   ├── CONSTANCY_PASSWORD
│   ├── VALID_LICENSE_ID
│   ├── VALID_CONSTANCY_ID_1
│   └── VALID_CONSTANCY_ID_2
│
└── node_modules/ ...................... Dependencias instaladas

Tu Servidor Web (Apache/Nginx)
│
├── categoria_SEGURO.html .............. Frontend
│   ├── HTML (sin credenciales)
│   ├── CSS
│   └── JavaScript (llamadas API)
│
└── index.html, css/, js/, images/ .... Archivos estáticos
```

---

## Pasos de Instalación

### Paso 1: Descargar Archivos
```bash
# Descarga estos archivos a tu servidor
- server.js
- package.json
- .env
```

### Paso 2: Instalar Dependencias
```bash
cd /ruta/a/tu/proyecto
npm install
```

### Paso 3: Configurar Variables de Entorno
```bash
# Editar .env con tus credenciales
nano .env

# O en Windows:
notepad .env
```

### Paso 4: Iniciar Servidor
```bash
npm start
# O para desarrollo:
npm run dev
```

```
✅ Servidor iniciado en http://localhost:3000
```

### Paso 5: Actualizar HTML
```bash
# Reemplazar categoria.html con categoria_SEGURO.html
cp categoria_SEGURO.html categoria.html

# O actualizar URL en el código:
const API_BASE_URL = 'http://localhost:3000';
// Cambiar localhost por tu dominio en producción
```

---

## Verificación de Seguridad

### Test 1: Inspeccionar Navegador
```
1. Abre tu sitio en navegador
2. Presiona F12 (Inspector)
3. Vuelve a la consola (Console)
4. Escribe: window.licenseCredentials
5. ❌ ERROR: licenseCredentials is not defined
6. ✅ SEGURO: No hay variables con credenciales
```

### Test 2: Revisar Network
```
1. Abre Network tab en Inspector
2. Intenta login
3. Observa la solicitud POST a /api/login
4. El body contiene SOLO {username, password}
5. Las credenciales NO están en la respuesta
```

### Test 3: Credenciales Incorrectas
```
1. Intenta con usuario falso
2. Servidor responde: {success: false}
3. Sin detalles de por qué falló
4. ✅ SEGURO: No revela qué campo es incorrecto
```

---

## Comparación: Antes vs Después

### ANTES (Inseguro)
```javascript
// ❌ VISIBLE en el navegador
const licenseCredentials = {
    username: 'validfmf',
    password: encryptPassword('PMfmf2026#$')
};

const validLicenseID = btoa('A9F3K7M2Q8R5LZ4X6B1');

function validateLogin() {
    if (username === licenseCredentials.username) {
        // ¡CÓDIGO DE VALIDACIÓN VISIBLE!
    }
}
```

### DESPUÉS (Seguro)
```javascript
// ✅ Cliente solo envía datos
async function validateLogin() {
    const response = await fetch('/api/login', {
        method: 'POST',
        body: JSON.stringify({ username, password })
    });
    
    // Respuesta: {success: true/false}
    // Las credenciales NUNCA se ven
}
```

---

## Variables de Entorno (.env)

```
# Credenciales de Licencia
LICENSE_USERNAME=validfmf
LICENSE_PASSWORD=PMfmf2026#$

# Credenciales de Constancy
CONSTANCY_USERNAME=Constfmf
CONSTANCY_PASSWORD=PMC0nst#2026#

# IDs Válidos
VALID_LICENSE_ID=A9F3K7M2Q8R5LZ4X6B1
VALID_CONSTANCY_ID_1=C7A9M2FQ
VALID_CONSTANCY_ID_2=9KX4B7L2

# Configuración del Servidor
PORT=3000
NODE_ENV=production
```

⚠️ **IMPORTANTE**: Nunca versionear el `.env` en Git!

Agregar a `.gitignore`:
```
.env
node_modules/
```

---

## Endpoints de API

### POST /api/login
```
Entrada:  {username, password}
Salida:   {success, userType, token}
```

### POST /api/validate-license
```
Entrada:  {licenseId}
Salida:   {success, message, details}
```

### POST /api/validate-constancy
```
Entrada:  {constancyId}
Salida:   {success, message, details: {name, status, timestamp}}
```

---

## Mejoras Recomendadas

### Corto Plazo
- [x] Sacar credenciales del cliente
- [ ] Implementar HTTPS obligatorio
- [ ] Agregar validación de entrada
- [ ] Implementar rate limiting

### Mediano Plazo
- [ ] JWT tokens en lugar de base64
- [ ] Base de datos en lugar de .env
- [ ] Logging de intentos de acceso
- [ ] 2FA (autenticación de dos factores)

### Largo Plazo
- [ ] Autenticación OAuth2/SSO
- [ ] Audit trail completo
- [ ] Encriptación de datos sensibles
- [ ] Backup automático

---

## Contacto y Soporte

Si tienes preguntas:
1. Verifica el README_SEGURIDAD.md
2. Revisa los logs del servidor
3. Prueba endpoints con Postman/cURL

---

**¡Tu sitio ahora es seguro! 🎉**

Las credenciales están protegidas en el servidor.
El cliente solo ve lo que necesita.
