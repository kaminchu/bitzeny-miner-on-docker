FROM gcc:7.3.0

RUN apt-get update -qq && apt-get install -y \
    make \
    automake \
    libcurl4-openssl-dev \
&& git clone -b v2.6.0 https://github.com/macchky/cpuminer.git \
&& cd cpuminer \
&& ./autogen.sh \
&& ./configure CFLAGS="-O3 -march=native" \
&& make \
&& apt-get clean \
&& apt-get purge -y git \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& ls | grep -v -E 'minerd' | xargs rm -r

WORKDIR         /cpuminer
ENTRYPOINT      ["./minerd"]
