FROM ruby:3.3.3-bookworm

RUN set -eux; \
    apt-get update; \
    apt-get -y upgrade; \
    apt-get install -y libpq-dev libssl-dev openssl imagemagick libvips

ARG UID=1000

RUN set -eux; \
    useradd -s /bin/bash -u ${UID} -m backend; \
    mkdir -p /backend/vendor/bundle; \
    chown -R backend:backend /backend

USER backend

WORKDIR /backend

ENV BUNDLE_PATH=vendor/bundle
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_USER_CACHE=vendor/bundle/cache

# This will force using gems with native extensions instead of pre-compiled versions.
# Using precompiled versions leads to compatibility issues in the case of ARM platform.
RUN bundle config set force_ruby_platform true

# Install dependencies
COPY --chown=backend:backend Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code
COPY --chown=backend:backend . .
