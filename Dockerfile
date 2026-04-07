# FROM oven/bun:1.3.11-alpine AS builder
# WORKDIR /app

# COPY ./package.json ./bun.lock ./
# RUN bun install --frozen-lockfile

# COPY . .
# RUN bun run build

# FROM oven/bun:1.3.11-alpine AS runner
# WORKDIR /app

# COPY ./package.json ./bun.lock ./
# RUN bun install --frozen-lockfile --production --ignore-scripts --no-cache

# COPY --from=builder /app/dist ./dist
# COPY --from=builder /app/pages ./pages

# EXPOSE 4141

# HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
#   CMD wget --spider -q http://localhost:4141/ || exit 1

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]


FROM oven/bun:1.3.11-alpine

WORKDIR /app

# 复制依赖文件并安装
COPY package*.json bun.lock* ./
RUN bun install --frozen-lockfile --production

# 复制所有源码
COPY . .

# 暴露端口（copilot-api 默认 4141）
EXPOSE 4141

# 直接使用 bun run start（项目自身的启动脚本，能正确读取环境变量）
CMD ["bun", "run", "start", "--port", "${PORT}"]