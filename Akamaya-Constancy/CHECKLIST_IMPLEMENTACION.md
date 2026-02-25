# ✅ CHECKLIST DE IMPLEMENTACIÓN

## Pre-Implementación
- [ ] Descargar todos los archivos
- [ ] Revisar README_SEGURIDAD.md
- [ ] Revisar GUIA_VISUAL.md
- [ ] Tener acceso a servidor Linux/Windows
- [ ] Tener Node.js instalado (v14+)
- [ ] Tener npm instalado
- [ ] Tener acceso a puerto 3000 disponible

---

## Paso 1: Preparar Archivos (15 minutos)

### En tu computadora local:
- [ ] Descargar:
  - [ ] `server.js`
  - [ ] `package.json`
  - [ ] `.env`
  - [ ] `categoria_SEGURO.html`
  - [ ] `.gitignore`
  - [ ] `.env.example`

### Transferir a servidor:
```bash
# Opción 1: SCP
[ ] scp server.js user@tu-servidor:/ruta/proyecto/
[ ] scp package.json user@tu-servidor:/ruta/proyecto/
[ ] scp .env user@tu-servidor:/ruta/proyecto/
[ ] scp .gitignore user@tu-servidor:/ruta/proyecto/

# Opción 2: FTP/SFTP
[ ] Conectar a servidor via FTP
[ ] Cargar archivos en `/ruta/proyecto/`
```

---

## Paso 2: Instalar Dependencias (5 minutos)

En el servidor SSH:
```bash
[ ] cd /ruta/proyecto
[ ] npm install
[ ] Esperar a que se instalen express, cors, dotenv
[ ] Verificar que se creó carpeta node_modules/
```

Verificar:
```bash
[ ] npm list
# Debería mostrar:
# ├── cors
# ├── dotenv
# └── express
```

---

## Paso 3: Configurar Variables de Entorno (10 minutos)

```bash
[ ] nano .env
# O en Windows:
[ ] notepad .env
```

Verificar que contiene:
- [ ] LICENSE_USERNAME=validfmf
- [ ] LICENSE_PASSWORD=PMfmf2026#$
- [ ] CONSTANCY_USERNAME=Constfmf
- [ ] CONSTANCY_PASSWORD=PMC0nst#2026#
- [ ] VALID_LICENSE_ID=A9F3K7M2Q8R5LZ4X6B1
- [ ] VALID_CONSTANCY_ID_1=C7A9M2FQ
- [ ] VALID_CONSTANCY_ID_2=9KX4B7L2
- [ ] PORT=3000

⚠️ Importante:
- [ ] Cambiar valores con tus credenciales reales
- [ ] No versionear .env en Git
- [ ] Proteger permisos: `chmod 600 .env`

---

## Paso 4: Probar Servidor Localmente (10 minutos)

En el servidor:
```bash
[ ] npm start
# Debería mostrar: "Servidor ejecutándose en puerto 3000"
```

Dejar corriendo en otra ventana SSH.

---

## Paso 5: Pruebas de API (15 minutos)

En otra ventana/terminal:

### Test 1: Ping al servidor
```bash
[ ] curl http://localhost:3000/
# Debería no devolver error
```

### Test 2: Login válido
```bash
[ ] curl -X POST http://localhost:3000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"validfmf","password":"PMfmf2026#$"}'
# Respuesta esperada: {"success":true,"userType":"license",...}
```
- [ ] Verificar que `"success":true`
- [ ] Verificar que `"userType":"license"`

### Test 3: Login inválido
```bash
[ ] curl -X POST http://localhost:3000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"invalid","password":"wrong"}'
# Respuesta esperada: {"success":false,"error":"Invalid credentials"}
```
- [ ] Verificar que `"success":false`

### Test 4: Validar License
```bash
[ ] curl -X POST http://localhost:3000/api/validate-license \
  -H "Content-Type: application/json" \
  -d '{"licenseId":"A9F3K7M2Q8R5LZ4X6B1"}'
# Respuesta esperada: {"success":true,"message":"License is valid",...}
```
- [ ] Verificar que `"success":true`

### Test 5: Validar Constancy
```bash
[ ] curl -X POST http://localhost:3000/api/validate-constancy \
  -H "Content-Type: application/json" \
  -d '{"constancyId":"C7A9M2FQ"}'
# Respuesta esperada: {"success":true,"details":{"name":"María García López",...}}
```
- [ ] Verificar que `"success":true`
- [ ] Verificar nombre devuelto

**Si todos pasan:** ✅ Continuar
**Si alguno falla:** ❌ Revisar logs y troubleshooting

---

## Paso 6: Actualizar Frontend (10 minutos)

En el servidor web (Apache/Nginx):

```bash
[ ] Copiar categoria_SEGURO.html a directorio web
[ ] cp categoria_SEGURO.html /var/www/html/categoria.html
```

O renombrarlo:
```bash
[ ] mv categoria_SEGURO.html categoria.html
```

Verificar:
- [ ] Archivo está en lugar correcto
- [ ] Permisos de lectura configurados
- [ ] Se puede acceder via navegador

---

## Paso 7: Configurar API_BASE_URL (5 minutos)

En `categoria.html`:

**Para desarrollo local:**
```javascript
const API_BASE_URL = 'http://localhost:3000';
```
- [ ] Verificado para localhost

**Para producción:**
```javascript
const API_BASE_URL = 'https://tu-dominio.com:3000';
```
- [ ] Cambiar `tu-dominio.com` por tu dominio real
- [ ] Cambiar `http` a `https` si está en producción
- [ ] Cambiar puerto si es diferente

---

## Paso 8: Pruebas en Navegador (15 minutos)

1. **Abrir sitio:**
   - [ ] http://localhost/categoria.html (desarrollo)
   - [ ] https://tu-dominio.com/categoria.html (producción)

2. **Test login:**
   - [ ] Intentar login con `validfmf` / `PMfmf2026#$`
   - [ ] Verificar que acepta el login
   - [ ] Verificar que se muestra pantalla de validación de licencia

3. **Test validación:**
   - [ ] Ingresar License ID: `A9F3K7M2Q8R5LZ4X6B1`
   - [ ] Verificar que dice "License Successfully Verified"
   - [ ] Botón "Verify Another" funciona
   - [ ] Botón "Back to Login" funciona

4. **Test constancy:**
   - [ ] Volver a hacer login con `Constfmf` / `PMC0nst#2026#`
   - [ ] Ingresar Constancy ID: `C7A9M2FQ`
   - [ ] Verificar que muestra nombre "María García López"
   - [ ] Verificar que dice "Constancy Successfully Verified"

5. **Test de seguridad en navegador:**
   - [ ] Abrir Inspector (F12)
   - [ ] Ir a Console
   - [ ] Escribir: `window.licenseCredentials`
   - [ ] Verificar que retorna: `undefined` (¡seguro!)
   - [ ] Escribir: `window.API_BASE_URL`
   - [ ] Verificar que retorna la URL de la API (esto es ok)

---

## Paso 9: Configurar Daemon (Producción) (15 minutos)

### Opción A: PM2 (Recomendado)

```bash
[ ] npm install -g pm2
[ ] pm2 start server.js --name "akamaya-api"
[ ] pm2 startup
[ ] pm2 save
```

Verificar:
```bash
[ ] pm2 list
[ ] pm2 logs akamaya-api
```

### Opción B: Systemd (Linux)

Crear archivo `/etc/systemd/system/akamaya-api.service`:
```
[Service]
ExecStart=/usr/bin/node /ruta/proyecto/server.js
Restart=always

[Unit]
Description=Akamaya API
After=network.target

[Install]
WantedBy=multi-user.target
```

Ejecutar:
```bash
[ ] sudo systemctl enable akamaya-api
[ ] sudo systemctl start akamaya-api
[ ] sudo systemctl status akamaya-api
```

### Opción C: Nginx (Proxy Inverso)

Crear archivo `/etc/nginx/sites-available/akamaya-api`:
```nginx
server {
    listen 3000;
    location / {
        proxy_pass http://127.0.0.1:3001;
    }
}
```

Ejecutar:
```bash
[ ] sudo systemctl restart nginx
[ ] sudo systemctl status nginx
```

---

## Paso 10: Configurar HTTPS (Producción) (20 minutos)

### Con Let's Encrypt + Certbot:

```bash
[ ] sudo apt-get install certbot python3-certbot-nginx
[ ] sudo certbot certonly -d tu-dominio.com
[ ] Copiar archivos .crt y .key
[ ] Actualizar server.js para usar HTTPS
```

En server.js:
```javascript
[ ] const https = require('https');
[ ] const fs = require('fs');
[ ] const options = {
      key: fs.readFileSync('/ruta/a/key.pem'),
      cert: fs.readFileSync('/ruta/a/cert.pem')
    };
[ ] https.createServer(options, app).listen(443);
```

Cambiar en HTML:
```javascript
[ ] const API_BASE_URL = 'https://tu-dominio.com';
```

---

## Paso 11: Configurar Git (5 minutos)

```bash
[ ] git init
[ ] git add .
[ ] Verificar .gitignore contiene: .env, node_modules/, logs/
[ ] git commit -m "Initial commit - Akamaya secure API"
[ ] git remote add origin https://github.com/usuario/repo.git
[ ] git push -u origin main
```

Verificar en GitHub:
- [ ] `.env` NO está versionado
- [ ] `node_modules/` NO está versionado
- [ ] `server.js` SÍ está versionado
- [ ] `package.json` SÍ está versionado

---

## Paso 12: Monitoreo y Logging (10 minutos)

```bash
[ ] Crear carpeta logs: mkdir -p logs/
[ ] pm2 logs akamaya-api > logs/api.log &
[ ] Monitorear intentos de login
[ ] Revisar logs regularmente
```

Agregar a cron (backup diario):
```bash
[ ] crontab -e
[ ] Agregar: 0 2 * * * tar -czf logs/backup-$(date +\%Y\%m\%d).tar.gz logs/
```

---

## Verificación Final

- [ ] Servidor ejecutándose sin errores
- [ ] API responde a solicitudes
- [ ] Frontend conecta con API
- [ ] Credenciales NO visibles en navegador
- [ ] HTTPS configurado (producción)
- [ ] Logs se están guardando
- [ ] Daemon está activo y restartea automáticamente
- [ ] .env está protegido (permisos 600)
- [ ] Backups automáticos funcionando

---

## Documentación Post-Implementación

- [ ] Guardar credenciales en lugar seguro (password manager)
- [ ] Compartir solo URLs, nunca credenciales
- [ ] Crear runbook de mantenimiento
- [ ] Documentar procedimientos de backup
- [ ] Configurar alertas para errores

---

## Pruebas de Seguridad Finales

```bash
[ ] nmap -p 3000 localhost  # Puerto abierto
[ ] curl -v http://localhost:3000/api/login  # GET debería rechazar
[ ] curl -X OPTIONS http://localhost:3000  # Verificar CORS
```

En navegador:
```javascript
[ ] Buscar "password" en consola - no debería encontrarse
[ ] Buscar "validfmf" en consola - no debería encontrarse
[ ] Buscar "C7A9M2FQ" en consola - no debería encontrarse
```

---

## Checklist de Seguridad

- [ ] ✅ Credenciales en servidor (.env)
- [ ] ✅ Sin credenciales en HTML/JavaScript
- [ ] ✅ API valida en servidor
- [ ] ✅ CORS configurado
- [ ] ✅ Rate limiting implementado (opcional)
- [ ] ✅ Logs de intentos registrados
- [ ] ✅ HTTPS en producción
- [ ] ✅ .env en .gitignore
- [ ] ✅ Permisos de archivo: 600 para .env
- [ ] ✅ Sin datos sensibles en localStorage

---

## Post-Implementación

### Mantenimiento Regular
- [ ] Revisar logs semanalmente
- [ ] Rotar credenciales mensualmente
- [ ] Actualizar dependencias npm: `npm update`
- [ ] Renovar certificados SSL (antes de expirar)

### Monitoreo
- [ ] Configurar alertas para errores 500
- [ ] Monitorear uso de puertos
- [ ] Revisar intentos fallidos de login
- [ ] Verificar disponibilidad de servidor

### Backups
- [ ] Backup automático diario de .env
- [ ] Backup automático de logs
- [ ] Pruebas mensuales de restauración

---

## Soporte

Si algo no funciona:
1. [ ] Revisar README_SEGURIDAD.md sección "Solución de Problemas"
2. [ ] Revisar logs: `pm2 logs akamaya-api`
3. [ ] Ejecutar test-api.sh: `./test-api.sh`
4. [ ] Verificar puertos: `netstat -tlnp | grep 3000`
5. [ ] Verificar .env: `cat .env`

---

## ¡Completado! 🎉

Cuando hayas completado TODOS los puntos:

✅ Tu sitio ahora es **SEGURO**
✅ Las credenciales están **PROTEGIDAS**
✅ La validación es en el **SERVIDOR**
✅ El código cliente está **LIMPIO**

**Felicidades - Implementación exitosa! 🎊**

---

**Fecha de implementación:** ________________
**Implementado por:** ________________
**Verificado por:** ________________
