FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY package.json /app
COPY pnpm-lock.yaml /app

##

FROM base AS prod-deps
RUN pnpm install --prod --frozen-lockfile
RUN sleep 10


##
FROM base AS build
RUN pnpm install --frozen-lockfile
COPY . /app
RUN pnpm run build

FROM base
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist

EXPOSE 3000
CMD [ "pnpm", "start" ]