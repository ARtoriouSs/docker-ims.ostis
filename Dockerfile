# Dockerfile with updating
FROM artorious/ostis
RUN echo "Updating repositories"
RUN cd /ostis && git pull origin master && \
    cd /ostis/sc-machine && git pull origin scp_stable && \
    cd /ostis/sc-web && git pull origin master && \
    cd /ostis/ims.ostis.kb && git pull origin master # && \
    # cd /ostis/scripts && ./install_npm_18x.sh && ./prepare.sh
