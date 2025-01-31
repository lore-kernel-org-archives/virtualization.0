Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFD1F2368
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345548; cv=none; b=drbghUOmHCJo5x72CYhpdnnZ06pAH3T7ZIP5NndtsRYS8xHx1M1CubSSgHR9dFPNbp2VtBAjuLJ8rtbosWcYkAnKZaYEgYEOL+Rz1qHBty/tU0EFJ9ASDjaQJaZBp+qgZothTW5N7vSfk67ni0k4v2j+UjyFgzd/7yU7g0qdO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345548; c=relaxed/simple;
	bh=LtizhXTHtfGr0a4uyDDlAcCu32NCBWRWgX358My2va0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueQAhwaKg0KtC+vkd9pw3Vg/zJQLfJM38aJpfsnpn6aDlcJ7db4AUlIX+pWRw0uP3ItgeDbh1Ju7+8wcg8SVqhq6fRNd2LXbQ0jfXyrxikQ7Ev78ruCslvGDe4UW8VMlrccUfdQ7IPpGCE7gTrCM0eJHosemhyzMLHv1tmyyiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS6wbha9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS6wbha9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166022c5caso36265125ad.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 09:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738345546; x=1738950346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHGax4hoNoCFK8uMn60wvh4xfs/D3J09QEwYzNMX7L8=;
        b=aS6wbha9bLjZMz0WozpSXvBjDI6thg70gidm0uOhpWxL/vps1cF9riyRVY1keqyLW6
         nBmntCci0W7enpFXPxbYIHvYNhm6kHu1ulnfXHlWdDz+9ax1RssAWxxj5g5QUwTVU0HU
         Dd36awOxRSl6VHnja+0BAixTuxrZUxvkBDJKvYKQvotq6hEwjmA0oUttOJkPnHcB4/+9
         99pb9GSRukpehF9Spdzj00nv6i/TUEUKIXCl7bWifEZTBwWC0fg0hqnExOlK4XtLaVIO
         QhbsGBUPcMF/Z4IJcx5m0+2Berg6iCo8XwbuBpqfN+HRctdMHcF3XzFJECcWB3de+amx
         Qt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738345546; x=1738950346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHGax4hoNoCFK8uMn60wvh4xfs/D3J09QEwYzNMX7L8=;
        b=wdCU4JRn9edW6hgNblj+oy7ws/l/atQFPm5gZgOw6rpF0ZYxau0x9ljF/8K7IOYRbo
         JqUFxxdoxFXvY5WeWQJhyegEVNQGWK9di6u1x69De2akRW2xa9uYHMmATYbIdPA0o2a1
         dD/dv4Gf2RpBF9PeHKIx5SEgsRQEbL9EC3dDydDrwrwv5uJYq36idhs8/pvipa93DN3c
         nnehGmIxZ94HYDjxD0CEQN3u/dNq0WjZHs9vSnV6I/skQwxlSWmrCvgAzQd5NXd1GERH
         ChqVFtZUacnWcUMIkN4NFtWoEaSIn1eipCCucs7/h8ICCRH3JrlSWRw0VrWwhDF1USyl
         orJw==
X-Forwarded-Encrypted: i=1; AJvYcCU055tcflZvfUNc23S3bsMEwWXC7SiFgWLziUOuB/VHzPyy1oFZpkJbIrA6BKKwpm4hOfhHpvAIe3r7+xBRUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBFjQw3j4pa6p/qCtMYOwOJ8Q/DLb7Siuq2Mrv2ePFgKycVhBM
	/lYVgX+MoSSB6TveOQlOY9caN17WLJCoNqqnr96muLA8YDoJhh8=
X-Gm-Gg: ASbGncvM6kP+5+IkYEzGfJ5W6Ax0FmdvjAJdoUHEZqNDj3571e/F8j04Tf3gUh82ApT
	UrFxA0qUWLlQK77CEMe3RZibaaPVNTF9vtumuqx4pztiilKJXca07ZAZYvMNTKb7SdEll7JOknm
	Fyljmu1t4nGHo8ywWZ0d7GrUBoPRdXLX6wy5LWi6qLEpyPb/nedG8LXikfIn0qW7bdwHdBmdg9s
	VIskGgAXZnCXK+kUU+eYOnZsDK1x9NfZptwmUkpRngSGxVfz3AbmY7uwQYHg7IRI6noWXmTZwRF
	mkBSs6lyFTalxN0=
X-Google-Smtp-Source: AGHT+IFmqTOI0/2HC2NK8R/nQ3xP1/wKaQScsH01OoR9/XrAZ3uJwlCmnrJ/mGKIBgwmAauKXsrbOA==
X-Received: by 2002:a05:6a00:2183:b0:725:c8ea:b30b with SMTP id d2e1a72fcca58-72fd0c0b836mr14940619b3a.11.1738345545868;
        Fri, 31 Jan 2025 09:45:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69bbb7esm3702551b3a.106.2025.01.31.09.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:45:45 -0800 (PST)
Date: Fri, 31 Jan 2025 09:45:44 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 2/6] selftests: ncdevmem: Implement
 devmem TCP TX
Message-ID: <Z50MSEBi2yQ99Y5z@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-3-almasrymina@google.com>

On 01/30, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v2:
> - make errors a static variable so that we catch instances where there
>   are less than 20 errors across different buffers.
> - Fix the issue where the seed is reset to 0 instead of its starting
>   value 1.
> - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> - Do not set POLLERR (Willem).
> - Update the test to use the new interface where iov_base is the
>   dmabuf_offset.
> - Update the test to send 2 iov instead of 1, so we get some test
>   coverage over sending multiple iovs at once.
> - Print the ifindex the test is using, useful for debugging issues where
>   maybe the test may fail because the ifindex of the socket is different
>   from the dmabuf binding.
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 276 +++++++++++++++++-
>  1 file changed, 272 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 19a6969643f4..8455f19ecd1a 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -40,15 +40,18 @@
>  #include <fcntl.h>
>  #include <malloc.h>
>  #include <error.h>
> +#include <poll.h>
>  
>  #include <arpa/inet.h>
>  #include <sys/socket.h>
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>  #include <sys/syscall.h>
> +#include <sys/time.h>
>  
>  #include <linux/memfd.h>
>  #include <linux/dma-buf.h>
> +#include <linux/errqueue.h>
>  #include <linux/udmabuf.h>
>  #include <libmnl/libmnl.h>
>  #include <linux/types.h>
> @@ -80,6 +83,8 @@ static int num_queues = -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> +static uint32_t tx_dmabuf_id;
> +static int waittime_ms = 500;
>  
>  struct memory_buffer {
>  	int fd;
> @@ -93,6 +98,8 @@ struct memory_buffer {
>  struct memory_provider {
>  	struct memory_buffer *(*alloc)(size_t size);
>  	void (*free)(struct memory_buffer *ctx);
> +	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> +				 void *src, int n);
>  	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
>  				   size_t off, int n);
>  };
> @@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
>  	free(ctx);
>  }
>  
> +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
> +				     void *src, int n)
> +{
> +	struct dma_buf_sync sync = {};
> +
> +	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> +	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +
> +	memcpy(dst->buf_mem + off, src, n);
> +
> +	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> +	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +}
> +
>  static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
>  				       size_t off, int n)
>  {
> @@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
>  static struct memory_provider udmabuf_memory_provider = {
>  	.alloc = udmabuf_alloc,
>  	.free = udmabuf_free,
> +	.memcpy_to_device = udmabuf_memcpy_to_device,
>  	.memcpy_from_device = udmabuf_memcpy_from_device,
>  };
>  
> @@ -188,7 +210,7 @@ void validate_buffer(void *line, size_t size)
>  {
>  	static unsigned char seed = 1;
>  	unsigned char *ptr = line;
> -	int errors = 0;
> +	static int errors;
>  	size_t i;
>  
>  	for (i = 0; i < size; i++) {
> @@ -202,7 +224,7 @@ void validate_buffer(void *line, size_t size)
>  		}
>  		seed++;
>  		if (seed == do_validation)
> -			seed = 0;
> +			seed = 1;
>  	}
>  
>  	fprintf(stdout, "Validated buffer\n");
> @@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
>  	return -1;
>  }
>  
> +static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> +			 struct ynl_sock **ys)
> +{
> +	struct netdev_bind_tx_req *req = NULL;
> +	struct netdev_bind_tx_rsp *rsp = NULL;
> +	struct ynl_error yerr;
> +
> +	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +	if (!*ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return -1;
> +	}
> +
> +	req = netdev_bind_tx_req_alloc();
> +	netdev_bind_tx_req_set_ifindex(req, ifindex);
> +	netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> +
> +	rsp = netdev_bind_tx(*ys, req);
> +	if (!rsp) {
> +		perror("netdev_bind_tx");
> +		goto err_close;
> +	}
> +
> +	if (!rsp->_present.id) {
> +		perror("id not present");
> +		goto err_close;
> +	}
> +
> +	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
> +	tx_dmabuf_id = rsp->id;
> +
> +	netdev_bind_tx_req_free(req);
> +	netdev_bind_tx_rsp_free(rsp);
> +
> +	return 0;
> +
> +err_close:
> +	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
> +	netdev_bind_tx_req_free(req);
> +	ynl_sock_destroy(*ys);
> +	return -1;
> +}
> +
>  static void enable_reuseaddr(int fd)
>  {
>  	int opt = 1;
> @@ -432,7 +497,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
>  	return 0;
>  }
>  
> -int do_server(struct memory_buffer *mem)
> +static int do_server(struct memory_buffer *mem)
>  {
>  	char ctrl_data[sizeof(int) * 20000];
>  	struct netdev_queue_id *queues;
> @@ -686,6 +751,207 @@ void run_devmem_tests(void)
>  	provider->free(mem);
>  }
>  
> +static uint64_t gettimeofday_ms(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	return (tv.tv_sec * 1000ULL) + (tv.tv_usec / 1000ULL);
> +}
> +
> +static int do_poll(int fd)
> +{
> +	struct pollfd pfd;
> +	int ret;
> +
> +	pfd.revents = 0;
> +	pfd.fd = fd;
> +
> +	ret = poll(&pfd, 1, waittime_ms);
> +	if (ret == -1)
> +		error(1, errno, "poll");
> +
> +	return ret && (pfd.revents & POLLERR);
> +}
> +
> +static void wait_compl(int fd)
> +{
> +	int64_t tstop = gettimeofday_ms() + waittime_ms;
> +	char control[CMSG_SPACE(100)] = {};
> +	struct sock_extended_err *serr;
> +	struct msghdr msg = {};
> +	struct cmsghdr *cm;
> +	int retries = 10;
> +	__u32 hi, lo;
> +	int ret;
> +
> +	msg.msg_control = control;
> +	msg.msg_controllen = sizeof(control);
> +
> +	while (gettimeofday_ms() < tstop) {
> +		if (!do_poll(fd))
> +			continue;
> +
> +		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
> +		if (ret < 0) {
> +			if (errno == EAGAIN)
> +				continue;
> +			error(1, ret, "recvmsg(MSG_ERRQUEUE)");
> +			return;
> +		}
> +		if (msg.msg_flags & MSG_CTRUNC)
> +			error(1, 0, "MSG_CTRUNC\n");
> +
> +		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
> +			if (cm->cmsg_level != SOL_IP &&
> +			    cm->cmsg_level != SOL_IPV6)
> +				continue;
> +			if (cm->cmsg_level == SOL_IP &&
> +			    cm->cmsg_type != IP_RECVERR)
> +				continue;
> +			if (cm->cmsg_level == SOL_IPV6 &&
> +			    cm->cmsg_type != IPV6_RECVERR)
> +				continue;
> +
> +			serr = (void *)CMSG_DATA(cm);
> +			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
> +				error(1, 0, "wrong origin %u", serr->ee_origin);
> +			if (serr->ee_errno != 0)
> +				error(1, 0, "wrong errno %d", serr->ee_errno);
> +
> +			hi = serr->ee_data;
> +			lo = serr->ee_info;
> +
> +			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
> +			return;
> +		}
> +	}
> +
> +	error(1, 0, "did not receive tx completion");
> +}
> +
> +static int do_client(struct memory_buffer *mem)
> +{
> +	char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +	struct sockaddr_in6 server_sin;
> +	struct sockaddr_in6 client_sin;
> +	struct dmabuf_tx_cmsg ddmabuf;
> +	struct ynl_sock *ys = NULL;
> +	struct msghdr msg = {};
> +	ssize_t line_size = 0;
> +	struct cmsghdr *cmsg;
> +	struct iovec iov[2];
> +	uint64_t off = 100;
> +	char *line = NULL;
> +	size_t len = 0;
> +	int socket_fd;
> +	int ret, mid;
> +	int opt = 1;
> +
> +	ret = parse_address(server_ip, atoi(port), &server_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse server address");
> +
> +	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (socket_fd < 0)
> +		error(1, socket_fd, "create socket");
> +
> +	enable_reuseaddr(socket_fd);
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
> +			 strlen(ifname) + 1);
> +	if (ret)
> +		error(1, ret, "bindtodevice");
> +
> +	if (bind_tx_queue(ifindex, mem->fd, &ys))
> +		error(1, 0, "Failed to bind\n");
> +

[..]

> +	ret = parse_address(client_ip, atoi(port), &client_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse client address");
> +
> +	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
> +	if (ret)
> +		error(1, ret, "bind");
> +

Can we wrap the two above in 'if (client_ip) {}'? For my case, as long as
we do SO_BINDTODEVICE, the autobind will do the right thing and I don't
have to explicitly pass '-c' (ncdemem crashes right now if it's
not passed).

> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +	if (ret)
> +		error(1, ret, "set sock opt");
> +
> +	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> +		ntohs(server_sin.sin6_port), ifname);
> +

[..]

> +	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
> +	if (ret)
> +		error(1, ret, "connect");

The most new error() invocations, you pass 'ret' as a second argument.
We need to use 'errno' instead where possible to give the users correct errors
for diagnostics.

> +
> +	while (1) {
> +		free(line);
> +		line = NULL;
> +		/* Subtract 1 from line_size to remove trailing newlines that
> +		 * get_line are surely to parse...
> +		 */
> +		line_size = getline(&line, &len, stdin) - 1;
> +
> +		if (line_size < 0)
> +			break;
> +
> +		mid = (line_size / 2) + 1;
> +
> +		iov[0].iov_base = (void *)100;
> +		iov[0].iov_len = mid;
> +		iov[1].iov_base = (void *)2000;
> +		iov[1].iov_len = line_size - mid;
> +
> +		provider->memcpy_to_device(mem, (size_t)iov[0].iov_base, line,
> +					   iov[0].iov_len);

This generates the following on my side:

ncdevmem.c:911:15: warning: format specifies type 'int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                 ~~
      |                                                 %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                    ^~~
ncdevmem.c:911:20: warning: format specifies type 'int' but the argument has type 'void *' [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                    ~~
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                         ^~~~~~~~~~~~~~~
ncdevmem.c:911:37: warning: format specifies type 'int' but the argument has type '__kernel_size_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                       ~~
      |                                                                                       %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
      |                                                          ^~~~~~~~~~~~~~
ncdevmem.c:912:4: warning: format specifies type 'int' but the argument has type 'void *' [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                                           ~~
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
  912 |                         iov[1].iov_base, iov[1].iov_len);
      |                         ^~~~~~~~~~~~~~~
ncdevmem.c:912:21: warning: format specifies type 'int' but the argument has type '__kernel_size_t' (aka 'unsigned long') [-Wformat]
  910 |                         "read line_size=%ld off=%d iov[0].iov_base=%d, iov[0].iov_len=%d, iov[1].iov_base=%d, iov[1].iov_len=%d\n",
      |                                                                                                                              ~~
      |                                                                                                                              %lu
  911 |                         line_size, off, iov[0].iov_base, iov[0].iov_len,
  912 |                         iov[1].iov_base, iov[1].iov_len);
      |                                          ^~~~~~~~~~~~~~
