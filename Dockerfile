# nginx 1.13.x
# Debian 9
FROM nginx:1.13
# TODO: doesn't need to be nginx...


# == Let's Encrypt ==
# No debian pacakges for letsencrypt
RUN apt update && apt install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/*
RUN wget https://dl.eff.org/certbot-auto && chmod a+x certbot-auto

# Install deps at build-time using its bootstrap script
RUN ./certbot-auto --noninteractive --agree-tos --os-packages-only


# Cert input/output
VOLUME /etc/letsencrypt


# Can't publish a port during docker build (makes sense). Thus certbot can't get
# certs during build, so we do it at first run. This is actually better cause it
# stops certs expiring between build and run.
COPY cmd.sh /
CMD /cmd.sh
