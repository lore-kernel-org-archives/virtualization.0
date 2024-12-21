Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E41F949
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742301; cv=none; b=F0fmDjJN74NPO6vfGfchqP8+g7diaOS/mh7UMIHJTWmKr6FmW62L0iWLKgr4waQlq6O2iuJpWViXpxtwpkG1mZjFVd6qe5QJfr4Y7YlaAfcvrEl8VAERSMwoIu0CJTZxMIiKK9wOE3O3Vz5eRC8F3+8oeLjtdi44RVGZD9gzWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742301; c=relaxed/simple;
	bh=oM9VPB9o+HoOhFQ2jKZEYqU0zOMOqiBju5kW7kCY7hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAbMahEurZyynDbd9wIFZR9QC0pbylQ4lznkxfnOBPqJWlMIi5KC7Ppk0PY6LVeMxmBgF3Apwp9YYQb/OQUkuhdMNLX1wOjj7Lr+qrlVv/eFchA9LTRQBhHk3WxYqs78t9AHxSuITAAA+lDJpMrJgFjU30s0bOqcEbxfrVc2Scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoZsmyz3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoZsmyz3"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-8019f05c629so2664202a12.2
        for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742297; x=1735347097; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvRhxm0PfanRMhR9AWSahUuI027dbnG0NIDTqQqY9zM=;
        b=LoZsmyz3WG0tbfpXi04S2ATg/aW+qlF192S+6wUPwsrHjF/RBbdqYZci3wR/udZLYl
         Evus5fZ+LvwMy//eR12D+ryc7eB3O6eylzRk1eFt+4G7FeOUZfEvaDtG8rGUEG7vCF8R
         IAKeJ5mlDKlwrOwaA2SWXI9PUmx9sd3E2TTN/EQMHQ9/ZsQCNBcWmqJyq7yfN8j2DvTO
         4LvOmu9HYoAdPmPhjRvYmPC0bdTeVa4SgRsV4Uj4cBM3PH3+sVdNKT8IFKtJQ8Y92x6W
         LIMI9mKdssnaeRghZdcbt12r/qllMQmkdcwODvL+hNGC028nRd2jnjidgbUww/RIxz6b
         YtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742297; x=1735347097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvRhxm0PfanRMhR9AWSahUuI027dbnG0NIDTqQqY9zM=;
        b=Cz9ItvbSYnHY9zvcBYuDO50x6kTPE+zCq3GR2Z0mBu2rsl7msgwuHMOm58lpDQyTBM
         qc/4/S+9ukL+bzArpNQyWeciv0o5BL/P6vubkrawUjcLR9zVcI9jXBzEPP1e/Cujg0aL
         iRTxggLhI2TBkDxdCnYd+SZoSEsl+8YmWiYMLQlkJH2G/41sU3k/b7Zt2MPOBQL2SWQe
         Un0jyraL+WYO08DgL1J81YJAVG/3UmAk0sdMC5g33knJzZmfTMJHMtlYbxuRp3zPo0US
         kXzvup3nVRhFaHLn2eLCMT4cZArS3l7HE2PhwIZpJZBjANPG/vUEa4dcGXE2Lt8ZzG2h
         pOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCvO0NaDDzlCy4He2KAAQuPs0lUX+3BwBimzUx1ghmoI3E+cGlHW+/TcJR6Br85srSfgS8m0/5pcmS27Arhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJejboVBl6kKgzHpceCjc8Y9EBXU8kitQvOxh21B1i5LNvJeeG
	3Ja3erb28/Sgnh436xcPxIP5GPZpjE2BjuOdNn8uDPZVaVOkmpv7lSf/K64y6PihWC5SlBUkic4
	B1io9ar91UfMi1x/6UG63mw==
X-Google-Smtp-Source: AGHT+IE9+UzLSddcELfZ2mgl0mh/RGerBHIeMvNiWYQCp1XxXSrcI+ut917KM8tfbtPFabOJFM2yXHBxSI1aokLf1g==
X-Received: from pgwb8.prod.google.com ([2002:a65:6688:0:b0:801:e378:a64a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3115:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1e5e044e423mr8605246637.3.1734742297348;
 Fri, 20 Dec 2024 16:51:37 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:33 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-3-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement devmem TCP TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"

Add support for devmem TX in ncdevmem.

This is a combination of the ncdevmem from the devmem TCP series RFCv1
which included the TX path, and work by Stan to include the netlink API
and refactored on top of his generic memory_provider support.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 261 +++++++++++++++++-
 1 file changed, 259 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 19a6969643f4..c1cbe2e11230 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -40,15 +40,18 @@
 #include <fcntl.h>
 #include <malloc.h>
 #include <error.h>
+#include <poll.h>
 
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
+#include <sys/time.h>
 
 #include <linux/memfd.h>
 #include <linux/dma-buf.h>
+#include <linux/errqueue.h>
 #include <linux/udmabuf.h>
 #include <libmnl/libmnl.h>
 #include <linux/types.h>
@@ -80,6 +83,8 @@ static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
+static uint32_t tx_dmabuf_id;
+static int waittime_ms = 500;
 
 struct memory_buffer {
 	int fd;
@@ -93,6 +98,8 @@ struct memory_buffer {
 struct memory_provider {
 	struct memory_buffer *(*alloc)(size_t size);
 	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
+				 void *src, int n);
 	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
 				   size_t off, int n);
 };
@@ -153,6 +160,20 @@ static void udmabuf_free(struct memory_buffer *ctx)
 	free(ctx);
 }
 
+static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
+				     void *src, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst->buf_mem + off, src, n);
+
+	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+}
+
 static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 				       size_t off, int n)
 {
@@ -170,6 +191,7 @@ static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
 static struct memory_provider udmabuf_memory_provider = {
 	.alloc = udmabuf_alloc,
 	.free = udmabuf_free,
+	.memcpy_to_device = udmabuf_memcpy_to_device,
 	.memcpy_from_device = udmabuf_memcpy_from_device,
 };
 
@@ -394,6 +416,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
+			 struct ynl_sock **ys)
+{
+	struct netdev_bind_tx_req *req = NULL;
+	struct netdev_bind_tx_rsp *rsp = NULL;
+	struct ynl_error yerr;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!*ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_bind_tx_req_alloc();
+	netdev_bind_tx_req_set_ifindex(req, ifindex);
+	netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+	rsp = netdev_bind_tx(*ys, req);
+	if (!rsp) {
+		perror("netdev_bind_tx");
+		goto err_close;
+	}
+
+	if (!rsp->_present.id) {
+		perror("id not present");
+		goto err_close;
+	}
+
+	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
+	tx_dmabuf_id = rsp->id;
+
+	netdev_bind_tx_req_free(req);
+	netdev_bind_tx_rsp_free(rsp);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
+	netdev_bind_tx_req_free(req);
+	ynl_sock_destroy(*ys);
+	return -1;
+}
+
 static void enable_reuseaddr(int fd)
 {
 	int opt = 1;
@@ -432,7 +497,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
-int do_server(struct memory_buffer *mem)
+static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -686,6 +751,198 @@ void run_devmem_tests(void)
 	provider->free(mem);
 }
 
+static unsigned long gettimeofday_ms(void)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
+}
+
+static int do_poll(int fd)
+{
+	struct pollfd pfd;
+	int ret;
+
+	pfd.events = POLLERR;
+	pfd.revents = 0;
+	pfd.fd = fd;
+
+	ret = poll(&pfd, 1, waittime_ms);
+	if (ret == -1)
+		error(1, errno, "poll");
+
+	return ret && (pfd.revents & POLLERR);
+}
+
+static void wait_compl(int fd)
+{
+	int64_t tstop = gettimeofday_ms() + waittime_ms;
+	char control[CMSG_SPACE(100)] = {};
+	struct sock_extended_err *serr;
+	struct msghdr msg = {};
+	struct cmsghdr *cm;
+	int retries = 10;
+	__u32 hi, lo;
+	int ret;
+
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	while (gettimeofday_ms() < tstop) {
+		if (!do_poll(fd))
+			continue;
+
+		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			error(1, ret, "recvmsg(MSG_ERRQUEUE)");
+			return;
+		}
+		if (msg.msg_flags & MSG_CTRUNC)
+			error(1, 0, "MSG_CTRUNC\n");
+
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_IP &&
+			    cm->cmsg_level != SOL_IPV6)
+				continue;
+			if (cm->cmsg_level == SOL_IP &&
+			    cm->cmsg_type != IP_RECVERR)
+				continue;
+			if (cm->cmsg_level == SOL_IPV6 &&
+			    cm->cmsg_type != IPV6_RECVERR)
+				continue;
+
+			serr = (void *)CMSG_DATA(cm);
+			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
+				error(1, 0, "wrong origin %u", serr->ee_origin);
+			if (serr->ee_errno != 0)
+				error(1, 0, "wrong errno %d", serr->ee_errno);
+
+			hi = serr->ee_data;
+			lo = serr->ee_info;
+
+			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
+			return;
+		}
+	}
+
+	error(1, 0, "did not receive tx completion");
+}
+
+static int do_client(struct memory_buffer *mem)
+{
+	char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
+	struct sockaddr_in6 server_sin;
+	struct sockaddr_in6 client_sin;
+	struct dmabuf_tx_cmsg ddmabuf;
+	struct ynl_sock *ys = NULL;
+	struct msghdr msg = {};
+	ssize_t line_size = 0;
+	struct cmsghdr *cmsg;
+	uint64_t off = 100;
+	char *line = NULL;
+	struct iovec iov;
+	size_t len = 0;
+	int socket_fd;
+	int opt = 1;
+	int ret;
+
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
+
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (socket_fd < 0)
+		error(1, socket_fd, "create socket");
+
+	enable_reuseaddr(socket_fd);
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
+			 strlen(ifname) + 1);
+	if (ret)
+		error(1, ret, "bindtodevice");
+
+	if (bind_tx_queue(ifindex, mem->fd, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	ret = parse_address(client_ip, atoi(port), &client_sin);
+	if (ret < 0)
+		error(1, 0, "parse client address");
+
+	ret = bind(socket_fd, &client_sin, sizeof(client_sin));
+	if (ret)
+		error(1, ret, "bind");
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+	if (ret)
+		error(1, ret, "set sock opt");
+
+	fprintf(stderr, "Connect to %s %d (via %s)\n", server_ip,
+		ntohs(server_sin.sin6_port), ifname);
+
+	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret)
+		error(1, ret, "connect");
+
+	while (1) {
+		free(line);
+		line = NULL;
+		line_size = getline(&line, &len, stdin);
+
+		if (line_size < 0)
+			break;
+
+		provider->memcpy_to_device(mem, off, line, line_size);
+
+		while (line_size) {
+			fprintf(stderr, "read line_size=%ld off=%d\n",
+				line_size, off);
+
+			iov.iov_base = NULL;
+			iov.iov_len = line_size;
+
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+
+			msg.msg_control = ctrl_data;
+			msg.msg_controllen = sizeof(ctrl_data);
+
+			cmsg = CMSG_FIRSTHDR(&msg);
+			cmsg->cmsg_level = SOL_SOCKET;
+			cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+			cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+
+			ddmabuf.dmabuf_id = tx_dmabuf_id;
+			ddmabuf.dmabuf_offset = off;
+
+			*((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+
+			ret = sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
+			if (ret < 0)
+				error(1, errno, "Failed sendmsg");
+
+			fprintf(stderr, "sendmsg_ret=%d\n", ret);
+
+			off += ret;
+			line_size -= ret;
+
+			wait_compl(socket_fd);
+		}
+	}
+
+	fprintf(stderr, "%s: tx ok\n", TEST_PREFIX);
+
+	free(line);
+	close(socket_fd);
+
+	if (ys)
+		ynl_sock_destroy(ys);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct memory_buffer *mem;
@@ -779,7 +1036,7 @@ int main(int argc, char *argv[])
 		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.47.1.613.gc27f4b7a9f-goog

