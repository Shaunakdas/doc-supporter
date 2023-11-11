FROM node:lts as builder

WORKDIR /doc-supporter

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

FROM node:lts

WORKDIR /doc-supporter

COPY --from=builder /doc-supporter .

# Copy .env if it exists
# COPY --from=builder /doc-supporter/.env* ./

EXPOSE 3000

CMD ["yarn", "start"]