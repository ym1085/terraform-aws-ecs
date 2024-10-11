# Alpine 기반 Node.js 이미지 사용
FROM node:10.13-alpine

# 작업 디렉토리 설정
WORKDIR /home/app

# 소스 코드 복사
COPY . .

# Timezone 설정
ENV TZ=Asia/Seoul

# 의존성 설치 (필요한 경우에만)
RUN npm install

# 애플리케이션에서 사용할 포트 지정
EXPOSE 3000

# 애플리케이션 실행
CMD ["node", "index.js"]