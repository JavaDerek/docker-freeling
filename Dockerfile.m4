# freeling

FROM debian:jessie

MAINTAINER Hernán 'herchu' Foffani <hfoffani@gmail.com>

include(dependencies.docker)
include(locale.docker)
include(freeling.docker)

ifdef(fl-es, include(es-config.docker))