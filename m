Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6B19DF99
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738278327; cv=none; b=JLloXBqlQxQwo0YBmmyU3o87+Y1anc+NXhRxU2KR/DFnFofExcn7wVUk5NMByccmWYlLsG8pVi4xz3qD3q/OIW6dYOUku7bjbbFrPLhm9IVD9/8khZvNcR1g1l4PXXp5WvcSh3LXd4q6cYiJus5Ao57wCaweR80EbdwQ75OxIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738278327; c=relaxed/simple;
	bh=oX+vDadGyUiqv4+oWeZ2tS8At04HdG1Fuw71i+G+9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8WqGw0656enSGyy9Nmz6esirYO9RtPIW4FZTfPUwpwyxjQfhV25aa+iTq2lpMHo/MnBotIvj8FmFdAkTmTJFpu1O/Jq0rwGxsufZR1CzEgVNbfQP7/tb9q06TB5QNPZV1U2kYMFG9eiWbh0eSLAzljoBYBTHoBhubFFHX/ZGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3oyp4Ef; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3oyp4Ef"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb94cceso16866205ad.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738278325; x=1738883125; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WICdH51S127J9PzlzomBDnMtgVSX3AbSg3nriL6O+OA=;
        b=J3oyp4Ef89ehEQaVfbn4DOReCMh6vKqibsHawhvyVH3pedYyERPzUnGVozAmtTVs9q
         70cPHqsmJT1WVP1Ne7/Us0m40R9UUacjegh3+fizRMvLbduDTOqmmoao6/I9ZFBF1sSp
         qo3+NVV+h+Dka01Nm9X90kfOwjJGKVHgiHpgjiOR85LozZd6s0q5rtQHMQ3Z6fbmBe2Q
         qzryBELhfSIPQQvNEmeL2q8ifwbWesDdKftPI7u0VO5Q0DwhT8JzjcIy0JoX63TufDM1
         50R8kk3TujY8jrmFRY6gCpSJ9MpHss9nh/ZuHalPtR3446kYTaqoUMQVTrV9RWC4w/hY
         2O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738278325; x=1738883125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WICdH51S127J9PzlzomBDnMtgVSX3AbSg3nriL6O+OA=;
        b=ExL2vcAvbdxR1GCMk45kdG+I4kvkBRDd7LFJNQY3WE5FsOfJqOMPM/LF6TvOoX+QAY
         BPiSOp5BhMBW9jExr+HHmJGJDRaPUnNqpRssfQIeipNXsNClz7U/B7+M3GoxM0b0/rHV
         lV1HfVWxVG/kgQv8C8uSctC0+F3zt1LwDomwbQuTOgEDVRgjz2HOeosp5k9xiAj9Knm/
         4UA+wQJq9dXUcX+Cb6EJqpxq+OU4WRsLM6zFXlXTQC27EMh+ft1DdBK7YqRzc9AUA2PH
         7woWu7VKpxdj8teY8t4dlhwikjeWNnQxbNVZXs55W/xxh9GFLDQbt4vuzjkx+TnJCyfr
         VAaw==
X-Forwarded-Encrypted: i=1; AJvYcCUJgRG8bRhEOuPGPUtNLaUn2F1Z7nRIh9rnQEDILlZ4yyty9JuTukqNz7c0F+At0/a4qume+Ryzy4GiT/f7Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvD2gYYVSALxEFV1kqXNFBgSwYrQt16BIdfU+hyhiS9PeKHhsz
	OGoYUMAzM2vrvQLVb5vvHtLPkuNp3ypnCIpKKhVBLYomYx4UO1c=
X-Gm-Gg: ASbGncuUdB8Fs9YfWfP+wKAtdDIhkSnwXJnsvHurlmpLfc4V2qz4jRm4I0BY/l6pC2R
	on7D6+nnJuX60QKlwHBFR/WJsihUxgEnaxR4KoDFaabA2uZb10Q4kzLQluPd+Mk2TOCteiAYFU1
	42ODh81L60EN1QCi5PHKI0jQCNHiwhLO7p7GtR4A80qHU1YoGyiUKyPFCIStKvwLuCcE8vZdwVG
	8ENMoLrKZBqhNBgLRSbPdiiTjBCPrW4sTmRjSGKnpRKdXOOWtpkOGTxpSsqGS5CMzWAU5xOv6WN
	J/W/6UWzB+PYFvk=
X-Google-Smtp-Source: AGHT+IGdacTBFsgqVod2DHsmK3HjZmnZudg8Nfs3KkTZyJqoDPkmRpC/K1f6p2Tya31UjoWh9t0ipg==
X-Received: by 2002:a05:6a00:2c88:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72fd0bc25a9mr11543951b3a.1.1738278324804;
        Thu, 30 Jan 2025 15:05:24 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe653a9f3sm2008544b3a.75.2025.01.30.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 15:05:24 -0800 (PST)
Date: Thu, 30 Jan 2025 15:05:23 -0800
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
Message-ID: <Z5wFs3-6pNWARhRL@mini-arch>
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
> +	ret = parse_address(client_ip, atoi(port), &client_sin);
> +	if (ret < 0)
> +		error(1, 0, "parse client address");
> +
> +	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
> +	if (ret)
> +		error(1, ret, "bind");
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +	if (ret)
> +		error(1, ret, "set sock opt");
> +
> +	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
> +		ntohs(server_sin.sin6_port), ifname);
> +
> +	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
> +	if (ret)
> +		error(1, ret, "connect");
> +
> +	while (1) {
> +		free(line);
> +		line = NULL;
> +		/* Subtract 1 from line_size to remove trailing newlines that
> +		 * get_line are surely to parse...
> +		 */
> +		line_size = getline(&line, &len, stdin) - 1;

Why not send the '\n' as well? If we skip the '\n', it's not keeping
netcat-like behavior :-(

> +
> +		if (line_size < 0)
> +			break;

[..]

> +		mid = (line_size / 2) + 1;
> +
> +		iov[0].iov_base = (void *)100;
> +		iov[0].iov_len = mid;
> +		iov[1].iov_base = (void *)2000;
> +		iov[1].iov_len = line_size - mid;

This seems a bit hard-coded. We should at least test that mid is < 2000?

But ideally we should have two modes for tx with a flag (and run them
both from the selftest):
- pass one big iov, this will test the sendmsg path which creates
  multiple skbs internally
- break 'line' into N sections (as you do here), but maybe have more
  control over the number of sections?

Maybe let's have a new --max-iov-size flag? Then we can call ncdevmem
with --max-iov-size <some prime number close to 4k> to exercise all
sorts of weird offsets?

(seems ok to also follow up on that separately)
