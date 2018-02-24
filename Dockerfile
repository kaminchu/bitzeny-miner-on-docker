FROM            ubuntu:devel

RUN             apt-get update -qq && \
                apt-get upgrade -y && \
                apt-get install -qqy gcc libcurl4-openssl-dev automake git make && \
                git clone https://github.com/macchky/cpuminer.git && \
                cd cpuminer && \
                ./autogen.sh && \
                ./configure CFLAGS="-O3 -march=native" && \
                make && \
                apt-get clean && \
                rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
                ls | grep -v -E 'minerd' | xargs rm -r

WORKDIR         /cpuminer
ENTRYPOINT      ["./minerd"]
