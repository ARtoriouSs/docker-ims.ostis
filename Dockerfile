# Dockerfile with updating
FROM artorious/ostis

RUN echo "Updating repositories" && \
    cd /ostis && git pull origin master && \
    cd /ostis/sc-machine && git pull origin scp_stable && \
    cd /ostis/sc-web && git pull origin master && \
    cd /ostis/ims.ostis.kb && git pull origin master

# here is copying
