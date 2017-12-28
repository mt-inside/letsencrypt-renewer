# "renew" finds all certs in the default location and renews those close to
# expiry, using the original options.
# Fore more control, can call certonly again with all the options and
# --keep-until-expiring
./certbot-auto \
    renew \
    --no-bootstrap \
    --noninteractive \
    --preferred-challenges tls-sni

# Don't use http challenge because I guess it's not as good.
# Don't use dns challenge because it's not set up.
# ACME challenges are versioned, so tls-sni will pick tls-sni-01 as of
# writing, but should use the latest available

#./certbot-auto install --nginx \
#    --cert-path /etc/letsencrypt/live/frogstar-a.empty.org.uk/cert.pem \
#    --fullchain-path /etc/letsencrypt/live/frogstar-a.empty.org.uk/fullchain.pem \
#    --key-path /etc/letsencrypt/live/frogstar-a.empty.org.uk/privkey.pem \
#    --no-bootstrap --noninteractive --agree-tos --no-eff-email --email="desborough@gmail.com" --domains="frogstar-a.empty.org.uk"
