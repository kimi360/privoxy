FROM alpine

EXPOSE 1081

ADD entry.sh /entry.sh
RUN apk --no-cache --update add privoxy ca-certificates bash && \
    sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:1081/' /etc/privoxy/config && \
    sed -i'' 's/enable-edit-actions\ 0/enable-edit-actions\ 1/' /etc/privoxy/config && \
    sed -i'' 's/accept-intercepted-requests\ 0/accept-intercepted-requests\ 1/' /etc/privoxy/config && \
    chown privoxy.privoxy /etc/privoxy/* && \
    mkdir /data && \
    tar -czf /data/config.tgz -C /etc/privoxy && \
    chmod +x /entry.sh

CMD ["/entry.sh"]
