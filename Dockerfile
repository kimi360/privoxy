FROM alpine

EXPOSE 1081
HEALTHCHECK --interval=30s --timeout=3s CMD nc -z localhost 1081
RUN apk --no-cache --update add privoxy ca-certificates bash && \
    sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:1081/' /etc/privoxy/config
RUN chown privoxy.privoxy /etc/privoxy/*
ENTRYPOINT ["privoxy"]
CMD ["--no-daemon","--user","privoxy","/etc/privoxy/config"]