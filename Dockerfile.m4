# freeling

FROM library/openjdk:8u181-jdk-stretch

MAINTAINER Hernán 'herchu' Foffani <hfoffani@gmail.com>

include(dependencies.docker)
include(locale.docker)

ifdef(py-dv, include(python.docker))

include(freeling.docker)
ifdef(fl-es, include(es-config.docker))

ifdef(py-dv, include(pyfreeling.docker))
include(javafreeling.docker)

CMD ["export", "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/APIs/java"]
ENV FREELINGSHARE /usr/share/freeling
EXPOSE 50005
CMD ["/usr/bin/analyzer", "-f", "/usr/share/freeling/config/ru.cfg", "--server", "--port", "50005"]