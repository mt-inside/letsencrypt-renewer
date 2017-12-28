For security (to stop non-root users getting certs for the domain), the
ACME challenge server MUST bind to 443, there is no option to override
this. There are options --tls-sni-01-port and --http-01-port, but they
change certbot's bind port only.

Thus we have to stop the webserver. The renew command has --pre-hook and
--post-hook for this purpose, but you can't stop one container from
another. Thus it's currently manual.

```
cd petstack-systemd/system
docker-compose ps
docker-compose stop http-proxy
cd letsencrypt-renewer
make build
make run
cd petstack-systemd/system
<consider moving nginx pin forwards and re-building>
docker-compose start http-proxy
```

This isn't zero-downtime. I guess that's what the server integration is for
- not for noobs, but to give a path on which ACME can sit and listen.

TODO: fire up a test container from the old http-proxy (nginx + certbot)
Dockerfile, run "certbot-auto run --nginx" for full noob-mode and see what
it does; I'm guessing a path-based location for ACME, somehow backing onto
certbot? Replicate this manually with http-proxy - add a location that
proxy_passes that path to the renew container. Then add cron / "at" to the
renew container so that a) it can renew on a period as there's no manual
intervention needed now and b) it can go up before http-proxy so that
nginx doesn't complain about missing backends. OR, try DNS validation?
