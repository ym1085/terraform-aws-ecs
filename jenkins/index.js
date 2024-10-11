const http = require("http");

// 서버가 요청을 받을 포트
const port = 3000;

// HTTP 서버 생성
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Hello, World!\n");
});

// 서버 시작
server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
