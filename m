Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715770;
	b=c3FSPqf7nsJNNw1gAVLfilrdslXJ01zBpojcTyMGBB1BuM4tA3bZ/hsGAuYDo1gGVWjn
	 R++e5IGfeHQ1h/Ba+DUhv6vFdp9bCNEnIEhL287l5hvjAugeIdiAwGi27BDMyXlrX7X7C
	 WSsQUWfJi4bjVbEHcWRzJIG0J4trjGAIiXCcVCwPlGuvqU1DLjGdBNfK69zF3ce48EaOi
	 L2Z+eAawX/yPG5N7940NUox+6LXNE64R/C55Ne1HBaAIWGzUAzOOv2C1RFJgDQyi5Q8iB
	 FGt1Q1cKN3Iu4V5ayI8zActKIepgSDihTpDq10moZQv2jqSoqxUNqNjZoTcdDNCu2uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715770;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=XLJPnkyQhuEnZBa/myDWTU9XLxRjPFGToIxLj/Biql0=;
	b=xXYEfaA7bz3/c2Za4jx8Sc2biG1adBvAjqywDo/uRhaMfXve64pdTN7iUEo08TT9rYuK
	 FCSd6fH0QaUdubG37yBb+q4RXdglAZApf7xCm/JFRNOhCdaClalWiEeaor3ivwEzmQ0rN
	 IoHxlkwhK6hMuFTbRy1YJAM8ssKh/fiGuf5btddCVHc5qWJvIZHjzM05XArnlUjqUuKwK
	 1zrUqecMdU48ECPPywAmERsX+09XalToPBHxp1mS3VNalw+fGQw1R1CK3GpT7hFRahzK1
	 5M4viCyfa4pHGO2lOtJIaC9kjBwKxThTE3p44/i1VqhrPqhj39bDAQWdn0AgPfI4CMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Pf58EaMa;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A5606D802
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A88A5606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Pf58EaMa
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jJrPw0T0PzNlqt;
	Tue, 03 Nov 2026 15:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793715764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLJPnkyQhuEnZBa/myDWTU9XLxRjPFGToIxLj/Biql0=;
	b=Pf58EaMaJvJIUN+LbVOlLhvCY6NE5uQE4PeBlVTXku+7yDQejV4Y8Rq3xEOBuuq+nGowYi
	BATNTFzW4dw4t/JUqxl864UnwvVz637rnAvIfIkHGsQbm+1dbgUXPrdtrPYX5x9lXBlEGq
	K1UDLEFQdeysQ6B7ECRkMpfn9UC5NsDLwH/hF26ByiNFYdBIUOO9M6vGUFOzCKkmvOqFRH
	uIkKKIcGXwXVQKE1cx8JqKYgi0zX+EmkNLiv5APy7uf/+N6UN31gGfWcIN7Pkr0Bqkyn+A
	ZJEoeccFfm1kW3rnfvPHfn1JnJIxMujo9e2wN8Gma0269tOjuian3wGRaZRFEg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maheshb@google.com,
	peterpenkov96@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v4 2/2] selftests: net: add a vhost-net test for the tun NAPI queue bound
Date: Tue,  3 Nov 2026 15:22:30 +0100
Message-ID: <20261103142232.1869185-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103142232.1869185-1-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJrPw0T0PzNlqt

Send 16k packets from vhost-net into a tap device with IFF_NAPI and
netdev_max_backlog set to 8, in the three ways vhost-net passes packets
to tun: batches of XDP buffers, one packet per sendmsg() with MSG_MORE,
and zerocopy buffers. Check that excess packets are dropped and counted,
that the queue keeps draining while vhost-net keeps sending, that every
packet is either delivered or dropped, and that every buffer comes back
to the ring, which it does not if a dropped zerocopy buffer is never
completed.

The zerocopy variant needs vhost_net loaded with experimental_zcopytx=1
and is skipped otherwise; with it, vhost-net does not batch and the
batch variant is skipped instead.

The test drives a minimal split virtqueue itself. It needs root and
CONFIG_VHOST_NET, and restores netdev_max_backlog, which is global, on
exit.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 tools/testing/selftests/net/Makefile    |   1 +
 tools/testing/selftests/net/config      |   1 +
 tools/testing/selftests/net/tun_vhost.c | 361 ++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 tools/testing/selftests/net/tun_vhost.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index df215e1a6262..de4cdaac99a0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -203,6 +203,7 @@ TEST_GEN_PROGS := \
 	tap \
 	tcp_port_share \
 	tls \
+	tun_vhost \
 	udp_splice_checksum \
 # end of TEST_GEN_PROGS
 
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cb8cb4696df7..1dce372caf43 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -136,6 +136,7 @@ CONFIG_TRACEPOINTS=y
 CONFIG_TUN=y
 CONFIG_USER_NS=y
 CONFIG_VETH=y
+CONFIG_VHOST_NET=m
 CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
 CONFIG_XFRM_INTERFACE=m
diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/selftests/net/tun_vhost.c
new file mode 100644
index 000000000000..dbf76d324a7e
--- /dev/null
+++ b/tools/testing/selftests/net/tun_vhost.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Send packets from vhost-net into a tap device with IFF_NAPI and check
+ * that the NAPI queue is bounded by netdev_max_backlog: excess packets
+ * are dropped and counted, and every buffer is returned to the driver,
+ * zerocopy ones included.
+ *
+ * vhost-net passes packets to tun in three ways:
+ *  - batch: batches of XDP buffers (tun_xdp_one()), the default when the
+ *    socket send buffer is unlimited and zerocopy is disabled
+ *  - copy: one packet per sendmsg(), when the send buffer is limited
+ *  - zerocopy: one packet per sendmsg() with a ubuf_info to complete,
+ *    only with vhost_net experimental_zcopytx=1 (else skipped)
+ *
+ * Tun schedules NAPI only after a batch, or after the last of a series of
+ * MSG_MORE packets, so with a small netdev_max_backlog the queue always
+ * overflows. It must keep draining while the sender keeps sending.
+ *
+ * Author: Antonio Quartulli <antonio@mandelbit.com>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/if.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/if_tun.h>
+#include <linux/vhost.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include "kselftest_harness.h"
+
+#define TV_IFNAME	"tvh0"
+#define TV_RING_NUM	256
+#define TV_BUF_SIZE	2048
+#define TV_HDR_LEN	sizeof(struct virtio_net_hdr_v1)
+#define TV_PKTS		(64 * TV_RING_NUM)
+#define TV_BACKLOG	"8"
+#define TV_TX_VQ	1
+
+static const unsigned char tv_mac_tap[ETH_ALEN] = { 2, 0, 0, 0, 0, 1 };
+static const unsigned char tv_mac_dst[ETH_ALEN] = { 2, 0, 0, 0, 0, 2 };
+static const unsigned char tv_mac_src[ETH_ALEN] = { 2, 0, 0, 0, 0, 3 };
+
+struct tv_stats {
+	unsigned long long rx_packets;
+	unsigned long long rx_dropped;
+};
+
+static int tv_read_stats(const char *ifname, struct tv_stats *st)
+{
+	char line[512], *p;
+	FILE *f;
+	int ret = -1;
+
+	f = fopen("/proc/net/dev", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		p = strchr(line, ':');
+		if (!p)
+			continue;
+		*p = '\0';
+		if (strcmp(line + strspn(line, " "), ifname))
+			continue;
+		if (sscanf(p + 1, "%*u %llu %*u %llu", &st->rx_packets,
+			   &st->rx_dropped) == 2)
+			ret = 0;
+		break;
+	}
+	fclose(f);
+	return ret;
+}
+
+FIXTURE(tun_vhost)
+{
+	int backlog_fd;
+	char backlog[32];
+	int tap;
+	int vhost;
+	int kick;
+	int call;
+	void *ring;
+	struct vring vr;
+	char *bufs;
+	unsigned short avail_idx;
+	unsigned short used_idx;
+};
+
+FIXTURE_VARIANT(tun_vhost)
+{
+	bool batch;
+	bool limit_sndbuf;
+	bool zerocopy;
+	int pktlen;
+};
+
+FIXTURE_VARIANT_ADD(tun_vhost, batch)
+{
+	.batch = true,
+	.pktlen = 64,
+};
+
+FIXTURE_VARIANT_ADD(tun_vhost, copy)
+{
+	.limit_sndbuf = true,
+	.pktlen = 64,
+};
+
+FIXTURE_VARIANT_ADD(tun_vhost, zerocopy)
+{
+	.limit_sndbuf = true,
+	.zerocopy = true,
+	.pktlen = 1000,
+};
+
+static bool tv_zerocopy_enabled(void)
+{
+	char c = '0';
+	int fd;
+
+	fd = open("/sys/module/vhost_net/parameters/experimental_zcopytx",
+		  O_RDONLY);
+	if (fd < 0)
+		return false;
+	if (read(fd, &c, 1) != 1)
+		c = '0';
+	close(fd);
+	return c == '1';
+}
+
+static void tv_vhost_setup(struct __test_metadata *_metadata,
+			   FIXTURE_DATA(tun_vhost) *self)
+{
+	struct vhost_vring_state state = { .index = TV_TX_VQ };
+	struct vhost_vring_file file = { .index = TV_TX_VQ };
+	struct vhost_vring_addr addr = { .index = TV_TX_VQ };
+	size_t memsz = sizeof(struct vhost_memory) +
+		       sizeof(struct vhost_memory_region);
+	unsigned long long features;
+	struct vhost_memory *mem;
+
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_OWNER, NULL), 0);
+	ASSERT_EQ(ioctl(self->vhost, VHOST_GET_FEATURES, &features), 0);
+	ASSERT_TRUE(features & (1ULL << VIRTIO_F_VERSION_1));
+	features = 1ULL << VIRTIO_F_VERSION_1;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_FEATURES, &features), 0);
+
+	/* buffer addresses are passed as is: map them 1:1 */
+	mem = calloc(1, memsz);
+	ASSERT_NE(mem, NULL);
+	mem->nregions = 1;
+	mem->regions[0].guest_phys_addr = (unsigned long)self->bufs;
+	mem->regions[0].userspace_addr = (unsigned long)self->bufs;
+	mem->regions[0].memory_size = TV_RING_NUM * TV_BUF_SIZE;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_MEM_TABLE, mem), 0);
+	free(mem);
+
+	state.num = TV_RING_NUM;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_NUM, &state), 0);
+	state.num = 0;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_BASE, &state), 0);
+	addr.desc_user_addr = (unsigned long)self->vr.desc;
+	addr.avail_user_addr = (unsigned long)self->vr.avail;
+	addr.used_user_addr = (unsigned long)self->vr.used;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_ADDR, &addr), 0);
+	file.fd = self->kick;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_KICK, &file), 0);
+	file.fd = self->call;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_CALL, &file), 0);
+	file.fd = self->tap;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_NET_SET_BACKEND, &file), 0);
+}
+
+FIXTURE_SETUP(tun_vhost)
+{
+	struct ifreq ifr = {};
+	int hdrlen = TV_HDR_LEN;
+	int sndbuf = 1 << 20;
+	ssize_t n;
+	int i, fd;
+
+	self->tap = -1;
+	self->vhost = open("/dev/vhost-net", O_RDWR);
+	if (self->vhost < 0)
+		SKIP(return, "no /dev/vhost-net");
+	if (variant->zerocopy && !tv_zerocopy_enabled())
+		SKIP(return, "vhost_net experimental_zcopytx not enabled");
+	if (variant->batch && tv_zerocopy_enabled())
+		SKIP(return, "vhost_net does not batch with zerocopy");
+
+	/* global, and only visible from init_net: keep it open to restore */
+	self->backlog_fd = open("/proc/sys/net/core/netdev_max_backlog",
+				O_RDWR);
+	ASSERT_GE(self->backlog_fd, 0);
+	n = read(self->backlog_fd, self->backlog, sizeof(self->backlog) - 1);
+	ASSERT_GT(n, 0);
+	self->backlog[n] = '\0';
+	ASSERT_EQ(pwrite(self->backlog_fd, TV_BACKLOG, strlen(TV_BACKLOG), 0),
+		  strlen(TV_BACKLOG));
+
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+
+	self->tap = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(self->tap, 0);
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR | IFF_NAPI;
+	memcpy(ifr.ifr_name, TV_IFNAME, sizeof(TV_IFNAME));
+	ASSERT_EQ(ioctl(self->tap, TUNSETIFF, &ifr), 0);
+	ASSERT_EQ(ioctl(self->tap, TUNSETVNETHDRSZ, &hdrlen), 0);
+	if (variant->limit_sndbuf)
+		ASSERT_EQ(ioctl(self->tap, TUNSETSNDBUF, &sndbuf), 0);
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	ASSERT_GE(fd, 0);
+	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+	memcpy(ifr.ifr_hwaddr.sa_data, tv_mac_tap, ETH_ALEN);
+	ASSERT_EQ(ioctl(fd, SIOCSIFHWADDR, &ifr), 0);
+	ASSERT_EQ(ioctl(fd, SIOCGIFFLAGS, &ifr), 0);
+	ifr.ifr_flags |= IFF_UP;
+	ASSERT_EQ(ioctl(fd, SIOCSIFFLAGS, &ifr), 0);
+	close(fd);
+
+	/* every buffer: zeroed vnet header + IPv4 frame for another host,
+	 * which the stack drops without counting it in rx_dropped
+	 */
+	ASSERT_EQ(posix_memalign((void **)&self->bufs, 4096,
+				 TV_RING_NUM * TV_BUF_SIZE), 0);
+	memset(self->bufs, 0, TV_RING_NUM * TV_BUF_SIZE);
+	for (i = 0; i < TV_RING_NUM; i++) {
+		unsigned char *eth = (unsigned char *)self->bufs +
+				     i * TV_BUF_SIZE + TV_HDR_LEN;
+
+		memcpy(eth, tv_mac_dst, ETH_ALEN);
+		memcpy(eth + ETH_ALEN, tv_mac_src, ETH_ALEN);
+		eth[12] = ETH_P_IP >> 8;
+		eth[13] = ETH_P_IP & 0xff;
+		eth[14] = 0x45;
+	}
+
+	ASSERT_EQ(posix_memalign(&self->ring, 4096,
+				 vring_size(TV_RING_NUM, 4096)), 0);
+	memset(self->ring, 0, vring_size(TV_RING_NUM, 4096));
+	vring_init(&self->vr, TV_RING_NUM, self->ring, 4096);
+
+	self->kick = eventfd(0, EFD_NONBLOCK);
+	self->call = eventfd(0, EFD_NONBLOCK);
+	ASSERT_GE(self->kick, 0);
+	ASSERT_GE(self->call, 0);
+
+	tv_vhost_setup(_metadata, self);
+}
+
+FIXTURE_TEARDOWN(tun_vhost)
+{
+	if (self->tap < 0)
+		return;
+	/* waits for outstanding zerocopy buffers */
+	close(self->vhost);
+	close(self->tap);
+	if (pwrite(self->backlog_fd, self->backlog, strlen(self->backlog),
+		   0) < 0)
+		TH_LOG("cannot restore netdev_max_backlog to %s",
+		       self->backlog);
+	close(self->backlog_fd);
+}
+
+/* queue up to @n buffers, return how many */
+static int tv_post(FIXTURE_DATA(tun_vhost) *self, int pktlen, int n)
+{
+	int inflight = (unsigned short)(self->avail_idx - self->used_idx);
+	unsigned long long one = 1;
+	int i;
+
+	for (i = 0; i < n && inflight < TV_RING_NUM; i++, inflight++) {
+		unsigned int id = self->avail_idx % TV_RING_NUM;
+
+		self->vr.desc[id].addr = (unsigned long)self->bufs +
+					 id * TV_BUF_SIZE;
+		self->vr.desc[id].len = TV_HDR_LEN + pktlen;
+		self->vr.desc[id].flags = 0;
+		self->vr.avail->ring[id] = id;
+		self->avail_idx++;
+	}
+	__atomic_store_n(&self->vr.avail->idx, self->avail_idx,
+			 __ATOMIC_RELEASE);
+	if (i && write(self->kick, &one, sizeof(one)) != sizeof(one))
+		return -1;
+	return i;
+}
+
+/* reap returned buffers, waiting up to @ms for at least one */
+static int tv_reap(FIXTURE_DATA(tun_vhost) *self, int ms)
+{
+	struct pollfd pfd = { .fd = self->call, .events = POLLIN };
+	unsigned short used;
+	unsigned long long v;
+
+	for (;;) {
+		used = __atomic_load_n(&self->vr.used->idx, __ATOMIC_ACQUIRE);
+		if (used != self->used_idx) {
+			int n = (unsigned short)(used - self->used_idx);
+
+			self->used_idx = used;
+			return n;
+		}
+		if (ms <= 0 || poll(&pfd, 1, 100) < 0)
+			return 0;
+		if (pfd.revents & POLLIN && read(self->call, &v, sizeof(v)) < 0)
+			return -1;
+		ms -= 100;
+	}
+}
+
+TEST_F(tun_vhost, napi_queue_bounded)
+{
+	struct tv_stats before, after;
+	unsigned long long delivered, dropped;
+	int posted = 0, reaped = 0, n;
+
+	ASSERT_EQ(tv_read_stats(TV_IFNAME, &before), 0);
+
+	while (reaped < TV_PKTS) {
+		n = tv_post(self, variant->pktlen, TV_PKTS - posted);
+		ASSERT_GE(n, 0);
+		posted += n;
+		n = tv_reap(self, 5000);
+		ASSERT_GE(n, 0);
+		if (!n) {
+			TH_LOG("%d of %d buffers not returned",
+			       posted - reaped, posted);
+			ASSERT_GT(n, 0);
+		}
+		reaped += n;
+	}
+
+	ASSERT_EQ(tv_read_stats(TV_IFNAME, &after), 0);
+	delivered = after.rx_packets - before.rx_packets;
+	dropped = after.rx_dropped - before.rx_dropped;
+	TH_LOG("sent %d, delivered %llu, dropped %llu", TV_PKTS, delivered,
+	       dropped);
+	/* bounded, */
+	EXPECT_GT(dropped, 0);
+	/* still draining, */
+	EXPECT_GE(delivered, TV_PKTS / 64);
+	/* and every packet accounted for */
+	EXPECT_EQ(delivered + dropped, TV_PKTS);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.0

