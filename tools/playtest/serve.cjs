// Node.js 18+; no packages, installation, or system configuration required.
const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const root = fs.realpathSync(__dirname);
const port = Number(process.argv[2] || 8080);
if (!Number.isInteger(port) || port < 1024 || port > 65535) {
  console.error('Port must be an integer from 1024 to 65535.'); process.exit(1);
}
if (!fs.existsSync(path.join(root, 'index.html'))) {
  console.error('Missing index.html. Run this script from the extracted playtest package.'); process.exit(1);
}
const mime = {'.html':'text/html; charset=utf-8','.js':'application/javascript',
  '.json':'application/json','.png':'image/png','.jpg':'image/jpeg','.jpeg':'image/jpeg',
  '.wav':'audio/wav','.wasm':'application/wasm','.txt':'text/plain; charset=utf-8'};
const server = http.createServer((req,res) => {
  if (!['GET','HEAD'].includes(req.method)) { res.writeHead(405); res.end(); return; }
  try {
    const pathname = decodeURIComponent(new URL(req.url, 'http://localhost').pathname);
    if (pathname === '/favicon.ico') { res.writeHead(204); res.end(); return; }
    const candidate = path.resolve(root, '.' + (pathname === '/' ? '/index.html' : pathname));
    const file = fs.realpathSync(candidate);
    if (!file.startsWith(root + path.sep) || !fs.statSync(file).isFile()) {
      res.writeHead(403); res.end(); return;
    }
    res.writeHead(200, {'Content-Type':mime[path.extname(file).toLowerCase()] || 'application/octet-stream',
      'Content-Length':fs.statSync(file).size, 'Cache-Control':'no-store', 'X-Content-Type-Options':'nosniff'});
    if(req.method === 'HEAD') res.end(); else fs.createReadStream(file).pipe(res);
  } catch { res.writeHead(404); res.end('Not found'); }
});
server.on('error', error => {
  console.error(error.code === 'EADDRINUSE' ? `Port ${port} is in use. Try: node serve.cjs ${port+1}` : error.message);
  process.exitCode = 1;
});
server.listen(port, '127.0.0.1', () => console.log(`Demo01: http://127.0.0.1:${port}/\nKeep this window open. Ctrl+C to stop.`));
