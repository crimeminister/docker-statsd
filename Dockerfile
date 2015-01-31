# Dockerfile: crimeminister/statsd

FROM node:latest
MAINTAINER Robert Medeiros <robert@crimeminister.org>

WORKDIR /usr/local/src
RUN git clone https://github.com/etsy/statsd.git

# Add a config.js based on exampleConfig.js that reads configuration
# settings from environment variables.
ADD ./config.js /usr/local/src/statsd/config.js

# TODO Use ONBUILD to add trigger that updates the statsd config.js

# Default settings for use in config.js
# --------------------------------------------------------------------

ENV GRAPHITE_PORT 2003
ENV GRAPHITE_HOST localhost

ENV STATSD_ADDRESS 0.0.0.0
ENV STATSD_ADDRESS_IPV6 false
ENV STATSD_PORT 8125

ENV STATSD_MGMT_ADDRESS 0.0.0.0
ENV STATSD_MGMT_PORT 8126

# Flush interval in milliseconds
ENV STATSD_FLUSH_INTERVAL 10000

# Whether to prettyprint the console backend output
ENV STATSD_CONSOLE_PRETTYPRINT true

# GRAPHITE

# Use the legacy namespace?
ENV STATSD_GRAPHITE_LEGACY_NAMESPACE true
# Global prefix to use for sending stats to graphite
ENV STATSD_GRAPHITE_GLOBAL_PREFIX "stats"
# Graphite prefix for counter metrics
ENV STATSD_GRAPHITE_PREFIX_COUNTER "counters"
# Graphite prefix for timer metrics
ENV STATSD_GRAPHITE_PREFIX_TIMER "timers"
# Graphite prefix for gauge metrics
ENV STATSD_GRAPHITE_PREFIX_GAUGE "gauges";
# Graphite prefix for set metrics
ENV STATSD_GRAPHITE_PREFIX_SET "sets";

ENV STATSD_LOG_BACKEND stdout
ENV STATSD_LOG_APPLICATION statsd
ENV STATSD_LOG_LEVEL LOG_INFO

# Expose the ports used by statsd to collect data.
# NB: the StatsD admin interface is accessible via telnet at 8126/tcp.
EXPOSE 8125/udp
EXPOSE 8126/tcp

WORKDIR /usr/local/src/statsd

# Use 'npm start' to run the 'start' alias defined in package.json
ENTRYPOINT ["npm"]
CMD ["start"]
