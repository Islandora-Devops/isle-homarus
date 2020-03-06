# ISLE 8 - Homarus image

Designed to used with:

* The `isle-homarus-connector` container and docker-compose service
* The Drupal 8 site

Based on:

* Official PHP Apache image: [php:7.4.3-apache](https://hub.docker.com/layers/php/library/php/7.4.3-apache/images/sha256-48dde1707d7dca2b701aa230344c58cb8ec5b0ce8e9dbceced65bec5ccd7d1d0?context=explore)

Contains and includes:

* [Composer](https://getcomposer.org/)
* [ffmpeg](https://packages.debian.org/buster/ffmpeg)
* [Homarus](https://github.com/Islandora/Crayfish/tree/dev/Homarus)

## MVP 2 sprint

* **TO DO:** Build a local image without docker-compose: _pseudo-code do not run this yet_
  * `docker build -t islandoradevops/isle-homarus .`

* **TO DO:** Despite successful build, further testing is required to determine if the resulting container works, what happens and how to communicate with it.

* **TO DO:** How to expose API-X endpoints for Homarus e.g. `/homarus/convert` to be called by curl or is this an Apache setup change on the Drupal site or both the service and site?

* **TO DO:** Add SYN / JWT

* **TO DO:** Convert Apache logging to stdout / stderr
