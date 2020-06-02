FROM alpine

ENV TZ=Asia/Shanghai

EXPOSE 1081

ADD entry.sh /entry.sh
RUN apk --no-cache --update add privoxy ca-certificates bash && \
    sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:1081/' /etc/privoxy/config && \
    sed -i'' 's/enable-edit-actions\ 0/enable-edit-actions\ 1/' /etc/privoxy/config && \
    sed -i'' 's/accept-intercepted-requests\ 0/accept-intercepted-requests\ 1/' /etc/privoxy/config && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    mkdir /data && \
    tar -czf /data/config.tgz /etc/privoxy && \
    chmod +x /entry.sh

CMD ["/entry.sh"]
