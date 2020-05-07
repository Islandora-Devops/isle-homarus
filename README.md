# ISLE 8 - Homarus image

Designed to used with:

* The `isle-homarus-connector` container and docker-compose service
* The Drupal 8 site

Based on:

* [isle-crayfish-base](https://github.com/Islandora-Devops/isle-crayfish-base)

Contains and includes:

* [Composer](https://getcomposer.org/)
* [ffmpeg](https://packages.debian.org/buster/ffmpeg)
* [Homarus](https://github.com/Islandora/Crayfish/tree/dev/Homarus)

## Running

To run the container, you'll need to bind mount two things:

* A public key from the key pair used to sign and verify JWT tokens at `/opt/keys/public.key`
* A `php.ini` file with output buffering enabled at `/usr/local/etc/php/php.ini`

You'll also want to set two environment variables, which affect configuration of the microservice

* HOMARUS_JWT_ADMIN_TOKEN - An easy to remember token to replace an actual JWT when testing (usually "islandora")
* HOMARUS_LOG_LEVEL - Logging level for the Homarus microservice (DEBUG, INFO, WARN, ERROR, etc...)

`docker run -d -p 8000:8000 -e HOMARUS_JWT_ADMIN_TOKEN=islandora -e HOMARUS_LOG_LEVEL=DEBUG -v /path/to/public.key:/opt/keys/public.key -v /path/to/php.ini:/usr/local/etc/php/php.ini isle-homarus`

### Testing

To test Homarus, you can issue a curl command against it to verify its endpoint is working.  For example, to convert an .ogv (ogg video) file to .mp4:

* `curl -H "Authorization: Bearer islandora" -H "Apix-Ldp-Resource: http://techslides.com/demos/sample-videos/small.ogv" -H "Accept: video/mp4" idcp.localhost:8000/convert > converted.mp4`

Note the the `Authorization` header contains the HOMARUS_JWT_ADMIN_TOKEN value after `Bearer`.
