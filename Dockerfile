FROM --platform=$TARGETPLATFORM node:16.10.0 AS frontend
ENV TZ=Asia/Shanghai

COPY . /code-run
WORKDIR /code-run

RUN npm install
RUN npm run build

# simplify
FROM --platform=$TARGETPLATFORM nginx:alpine
COPY --from=frontend /code-run/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]