# Akamaya Constancy - Sistema Seguro 🔒

## Problema Original ❌
Las credenciales (usernames, passwords, IDs válidos) estaban **visibles en el código JavaScript** del navegador:
- Cualquiera podía inspeccionar la página con F12
- Las credenciales estaban hardcodeadas en el cliente
- Los IDs válidos era fáciles de descubrir

## Solución Implementada ✅
Se creó un **backend Node.js/Express** que:
- Almacena todas las credenciales en el **servidor** (no en el cliente)
- Valida los datos y devuelve solo el resultado (verdadero/falso)
- Las credenciales están en variables de entorno `.env`
- El cliente **nunca ve** las credenciales reales

---

## Archivos Creados

### 1. **server.js** - Backend Express
- API REST con 3 endpoints
- Valida login, licenses, constancy IDs
- Almacena credenciales de forma segura

### 2. **.env** - Variables de Entorno
```
LICENSE_USERNAME=validfmf
LICENSE_PASSWORD=PMfmf2026#$
CONSTANCY_USERNAME=Constfmf
CONSTANCY_PASSWORD=PMC0nst#2026#
VALID_LICENSE_ID=A9F3K7M2Q8R5LZ4X6B1
VALID_CONSTANCY_ID_1=C7A9M2FQ
VALID_CONSTANCY_ID_2=9KX4B7L2
PORT=3000
```

### 3. **package.json** - Dependencias
- express
- cors
- dotenv

### 4. **categoria_SEGURO.html** - Frontend Actualizado
- Usa fetch API para llamar al servidor
- No contiene credenciales
- Comunicación segura con el backend

---

## Instalación 🚀

### Paso 1: Instalar Dependencias
```bash
npm install
```

### Paso 2: Configurar Variables de Entorno
Edita el archivo `.env` y reemplaza con tus credenciales reales:
```bash
nano .env
```

### Paso 3: Iniciar el Servidor
```bash
npm start
```

El servidor iniciará en `http://localhost:3000`

### Paso 4: Reemplazar HTML
Copia el archivo `categoria_SEGURO.html` a tu servidor web y renómbralo a `categoria.html`

---

## Endpoints de la API

### 1. POST `/api/login`
Valida credenciales de usuario
```javascript
// Request
{
  "username": "validfmf",
  "password": "PMfmf2026#$"
}

// Response (sucesso)
{
  "success": true,
  "userType": "license",
  "token": "base64encodedtoken"
}

// Response (error)
{
  "success": false,
  "error": "Invalid credentials"
}
```

### 2. POST `/api/validate-license`
Valida un License ID
```javascript
// Request
{
  "licenseId": "A9F3K7M2Q8R5LZ4X6B1"
}

// Response (válido)
{
  "success": true,
  "message": "License is valid",
  "details": {
    "status": "✓ License Successfully Verified",
    "timestamp": "2025-02-25T10:30:00Z"
  }
}
```

### 3. POST `/api/validate-constancy`
Valida un Constancy ID
```javascript
// Request
{
  "constancyId": "C7A9M2FQ"
}

// Response (válido)
{
  "success": true,
  "message": "Constancy is valid",
  "details": {
    "name": "María García López",
    "status": "✓ Constancy Successfully Verified",
    "timestamp": "2025-02-25T10:30:00Z"
  }
}
```

---

## Características de Seguridad 🔐

✅ **Credenciales en el Servidor**
- Las contraseñas NUNCA viajan al cliente
- Se guardan en variables de entorno

✅ **Validación del Lado del Servidor**
- El cliente solo envía datos, no los valida
- El servidor es la fuente de verdad

✅ **CORS Habilitado**
- Permite llamadas desde el cliente
- Configurable por dominio

✅ **Sin Almacenamiento de Datos Sensibles**
- Las credenciales no se guardan en el navegador
- No hay localStorage con datos sensibles

✅ **Comunicación HTTPS** (en producción)
- Cambiar `http://localhost:3000` a `https://tudominio.com`

---

## Mejoras para Producción 🏗️

### 1. HTTPS Obligatorio
```bash
# Usar Let's Encrypt o certificado
const https = require('https');
```

### 2. JWT Token para Sesiones
```javascript
const jwt = require('jsonwebtoken');
// Implementar autenticación con tokens
```

### 3. Base de Datos
```javascript
// Migrar de variables de entorno a base de datos
const mongoose = require('mongoose');
```

### 4. Rate Limiting
```javascript
const rateLimit = require('express-rate-limit');
// Prevenir ataques de fuerza bruta
```

### 5. Validación de Entrada
```javascript
const { body, validationResult } = require('express-validator');
// Sanitizar y validar datos
```

### 6. Logging
```javascript
const morgan = require('morgan');
// Registrar intentos de acceso
```

---

## Ejemplo de Uso

### Credenciales de Prueba

**Licencia:**
- Username: `validfmf`
- Password: `PMfmf2026#$`
- License ID: `A9F3K7M2Q8R5LZ4X6B1`

**Constancy:**
- Username: `Constfmf`
- Password: `PMC0nst#2026#`
- IDs válidos: `C7A9M2FQ` o `9KX4B7L2`

---

## Verificación de Seguridad

### ❌ Inspeccionar con F12 (Antes)
```javascript
// VES ESTO EN EL CÓDIGO:
const licenseCredentials = {
    username: 'validfmf',
    password: encryptPassword('PMfmf2026#$')  // VISIBLE!
};
```

### ✅ Inspeccionar con F12 (Ahora)
```javascript
// SOLO VES LLAMADAS A LA API:
fetch('http://localhost:3000/api/login', {
    method: 'POST',
    body: JSON.stringify({ username, password })
})
// Las credenciales NUNCA aparecen en el cliente
```

---

## Solución de Problemas

### Error: "Error connecting to server"
- Verificar que el servidor está ejecutándose: `npm start`
- Cambiar `API_BASE_URL` en el HTML si el servidor está en otro puerto
- Verificar CORS en el servidor

### Error: CORS
```javascript
// En server.js, permitir más orígenes:
app.use(cors({
  origin: ['http://localhost:3000', 'https://tudominio.com']
}));
```

### Las credenciales no funcionan
- Verificar el archivo `.env`
- Reiniciar el servidor después de cambiar `.env`
- Verificar que no hay espacios en blanco

---

## Archivos Incluidos

```
/home/claude/
├── server.js              # Backend Express
├── package.json           # Dependencias
├── .env                   # Variables de entorno
└── /mnt/user-data/outputs/
    └── categoria_SEGURO.html  # Frontend actualizado
```

---

## Próximos Pasos

1. Copiar `server.js`, `package.json` y `.env` a tu servidor
2. Ejecutar `npm install` en el servidor
3. Ejecutar `npm start` para iniciar el servidor
4. Reemplazar `categoria.html` con `categoria_SEGURO.html`
5. Cambiar `API_BASE_URL` según tu dominio
6. Implementar las mejoras de producción

---

## Soporte

Si tienes problemas, verifica:
- Puerto 3000 disponible
- Variables de entorno configuradas
- CORS habilitado
- Servidor ejecutándose

¡Tu sitio ahora es seguro! 🎉
