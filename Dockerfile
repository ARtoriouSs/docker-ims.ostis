FROM artorious/ostis

RUN cd /ostis && git pull origin master
RUN cd /ostis/sc-machine && git pull origin scp_stable
RUN cd /ostis/sc-web && git pull origin master
RUN cd /ostis/ims.ostis.kb && git pull origin master

COPY / /ostis/kb/
