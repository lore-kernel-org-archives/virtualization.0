Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604972;
	b=rLqAqxGo32jz2c+RfZfLXxP+ZbKZ8zHaHdPV8Bk+kmbsB++hrvX9Nu3vAAF3Hm+hdnb6
	 axMnHA2qjKYBFkLPTDkvyWgJXq/j5+N9+bYgylYAVD0gpAaSStBKNPC7LL40wQsy+ptVQ
	 /5Mql655qpqnCiuGAh6Xco2Bwawqjx2yDh3FbUGmruhEG6HVCnPonwoFbDNnvWq1cFElj
	 tnS/YAp174ow1XS3240naMeEBTyxPR/i2y41J+Bdlhlv/TY928IWE7plr5mYuaxhwk3WU
	 IND6nw5KF+wfhc/0qyZkyi6PAq7Ki9wBArK1LeaubxCmTjrHXf0P4rFJO9xnZKtj1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604972;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=Cu4x4WmH2/yBDIcG2JjlkQx41I1i4l3NXrbNMU1SeGc=;
	b=AReDZ7v9gfZQ03EZyInAikqILTW2lEmSVa6BKUi78iGhFl9GL+/E2FKUtg1dQ6npLYtf
	 M/vUjQHB3RWQCYm4nxTVpeRpGWWfQIeL0vIQ7jn6S0wdUYIeQrOJ1HolGQtjomoUNcswy
	 uKfcWARZbk+NMPAghBChCW7i5JtAZelNti9HRjWvtM8G1FH+F2ZsU63RcNA9qlxVcOFxb
	 qXmX3jerT/YzmioRyy739j+6mWWPQUmbTStSKBJiSEvX8OqHRvGTqVQnnjeoGFv/rCFs+
	 oRsebb9liG7N/ZdkqXUs5/q2D7Ge6s6hLT4nPEPBqldPbmaFtEhp3Yuv4QVGEiUTkRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=GtWGARdb;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FA606A332
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3FA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=GtWGARdb
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jR9G01yP2z3xwh;
	Fri, 13 Nov 2026 22:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794604968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cu4x4WmH2/yBDIcG2JjlkQx41I1i4l3NXrbNMU1SeGc=;
	b=GtWGARdb7QIyQNWhDSUCYgUQJzDqadlhGeYW+HO+XIPkSciHMNG1DfvMZBBE6tcBgvtC3o
	5c55RBi5g3olakYecTaWuUUzLXi2OC2jE5yBmCVg6i6rwYtTltjTL9Eu6Fre/F/CFu7GWt
	MN3ExoAy+Dnm3xMuhGvwEyRp8xZqX9dgci6/0n8QovHgruziFk88oI62JHvC6zpL8oF5ca
	4QEQVcf1jSk7dkwpLLOJk5oEFk1NNYh76G0iw5GyqJh2NvWmhslYKJcwvd8VrpbHXm6tHR
	SwLUrVcHR/md5l1KNiZeagE/2ccDto4/loOMuGMrlCW+89PsO49PD7MWwUaBNw==
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
Subject: [PATCH net v6 2/2] selftests: net: add a vhost-net test for the tun NAPI queue bound
Date: Fri, 13 Nov 2026 22:22:34 +0100
Message-ID: <20261113212237.1742984-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113212237.1742984-1-antonio@mandelbit.com>
References: <20261113212237.1742984-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jR9G01yP2z3xwh

Feed a tap device with IFF_NAPI from vhost-net with netdev_max_backlog
set to 8, in the three ways vhost-net passes packets to tun: batches of
XDP buffers, single packets with MSG_MORE and zerocopy buffers. Check
that excess packets are dropped and counted, that the queue keeps
draining and that every buffer comes back.

The wrapper loads vhost_net and, if it can reload it, also runs the
zerocopy variant with experimental_zcopytx=1.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 tools/testing/selftests/net/.gitignore   |   1 +
 tools/testing/selftests/net/Makefile     |   2 +
 tools/testing/selftests/net/config       |   1 +
 tools/testing/selftests/net/tun_vhost.c  | 222 +++++++++++++++++++++++
 tools/testing/selftests/net/tun_vhost.sh |  23 +++
 5 files changed, 249 insertions(+)
 create mode 100644 tools/testing/selftests/net/tun_vhost.c
 create mode 100755 tools/testing/selftests/net/tun_vhost.sh

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 27761239d069..2f4104b1aa6d 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -56,6 +56,7 @@ timestamping
 tls
 tools
 tun
+tun_vhost
 txring_overwrite
 txtimestamp
 udp_splice_checksum
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baea3e7f0f8f..b3965a976451 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -123,6 +123,7 @@ TEST_PROGS := \
 	test_vxlan_vnifiltering.sh \
 	tfo_passive.sh \
 	traceroute.sh \
+	tun_vhost.sh \
 	txtimestamp.sh \
 	udpgro.sh \
 	udpgro_bench.sh \
@@ -177,6 +178,7 @@ TEST_GEN_FILES := \
 	tcp_mmap \
 	tfo \
 	timestamping \
+	tun_vhost \
 	txring_overwrite \
 	txtimestamp \
 	udpgso \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3e7ce41bd64d..c3bb0d572325 100644
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
index 000000000000..c9bf6d07cc26
--- /dev/null
+++ b/tools/testing/selftests/net/tun_vhost.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Feed a tap device with IFF_NAPI from vhost-net, in batches of XDP buffers,
+ * as single packets with MSG_MORE, or as zerocopy buffers, with
+ * netdev_max_backlog set to 8: excess packets must be dropped and counted,
+ * the queue must keep draining, and every buffer must come back.
+ *
+ * Author: Antonio Quartulli <antonio@mandelbit.com>
+ */
+
+#define _GNU_SOURCE
+#include <endian.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/if.h>
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
+#define RING	256
+#define BUFSZ	2048
+#define HDRLEN	sizeof(struct virtio_net_hdr_v1)
+#define PKTS	(64 * RING)
+
+static long read_long(const char *fmt, const char *arg, long def)
+{
+	char path[128];
+	long v = def;
+	FILE *f;
+
+	snprintf(path, sizeof(path), fmt, arg);
+	f = fopen(path, "r");
+	if (f) {
+		if (fscanf(f, "%ld", &v) != 1)
+			v = def;
+		fclose(f);
+	}
+	return v;
+}
+
+FIXTURE(tun_vhost)
+{
+	char ifname[IFNAMSIZ];
+	char bl[16];		/* saved netdev_max_backlog */
+	int bl_fd;
+	struct vring vr;
+	int vhost;
+	int kick;
+	int tap;
+};
+
+FIXTURE_VARIANT(tun_vhost)
+{
+	bool limit_sndbuf;	/* no XDP batches */
+	bool zerocopy;
+	int pktlen;
+};
+
+FIXTURE_VARIANT_ADD(tun_vhost, batch)
+{
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
+FIXTURE_SETUP(tun_vhost)
+{
+	struct ifreq ifr = { .ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR |
+					  IFF_NAPI };
+	unsigned long long features = 1ULL << VIRTIO_F_VERSION_1;
+	struct vhost_vring_state state = { .index = 1, .num = RING };
+	struct vhost_vring_file file = { .index = 1 };
+	struct vhost_vring_addr addr = { .index = 1 };
+	int hdrlen = HDRLEN, sndbuf = 1 << 20, i, fd;
+	struct vhost_memory *mem;
+	unsigned char *bufs;
+	void *ring;
+	bool zc;
+
+	self->bl_fd = -1;
+	self->vhost = open("/dev/vhost-net", O_RDWR);
+	if (self->vhost < 0)
+		SKIP(return, "no /dev/vhost-net");
+	zc = read_long("/sys/module/vhost_net/parameters/%s",
+		       "experimental_zcopytx", 0);
+	if (variant->zerocopy && !zc)
+		SKIP(return, "vhost_net experimental_zcopytx not set");
+	if (!variant->limit_sndbuf && zc)
+		SKIP(return, "vhost_net does not batch with zerocopy");
+
+	self->tap = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(self->tap, 0);
+	strcpy(ifr.ifr_name, "tvh%d");
+	ASSERT_EQ(ioctl(self->tap, TUNSETIFF, &ifr), 0);
+	memcpy(self->ifname, ifr.ifr_name, IFNAMSIZ);
+	ASSERT_EQ(ioctl(self->tap, TUNSETVNETHDRSZ, &hdrlen), 0);
+	if (variant->limit_sndbuf)
+		ASSERT_EQ(ioctl(self->tap, TUNSETSNDBUF, &sndbuf), 0);
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	ASSERT_EQ(ioctl(fd, SIOCGIFFLAGS, &ifr), 0);
+	ifr.ifr_flags |= IFF_UP;
+	ASSERT_EQ(ioctl(fd, SIOCSIFFLAGS, &ifr), 0);
+	close(fd);
+
+	/* each buffer: vnet header and an IPv4 frame for another host, which
+	 * the stack drops without counting it
+	 */
+	ASSERT_EQ(posix_memalign((void **)&bufs, 4096, RING * BUFSZ), 0);
+	memset(bufs, 0, RING * BUFSZ);
+	ASSERT_EQ(posix_memalign(&ring, 4096, vring_size(RING, 4096)), 0);
+	memset(ring, 0, vring_size(RING, 4096));
+	vring_init(&self->vr, RING, ring, 4096);
+	for (i = 0; i < RING; i++) {
+		unsigned char *eth = bufs + i * BUFSZ + HDRLEN;
+
+		eth[0] = 0x02;
+		eth[5] = 0x02;
+		eth[12] = 0x08;
+		eth[14] = 0x45;
+		self->vr.desc[i].addr = htole64((unsigned long)eth - HDRLEN);
+		self->vr.desc[i].len = htole32(HDRLEN + variant->pktlen);
+		self->vr.avail->ring[i] = htole16(i);
+	}
+
+	/* buffer addresses are passed as is: map them 1:1 */
+	mem = calloc(1, sizeof(*mem) + sizeof(mem->regions[0]));
+	ASSERT_NE(mem, NULL);
+	mem->nregions = 1;
+	mem->regions[0].guest_phys_addr = (unsigned long)bufs;
+	mem->regions[0].userspace_addr = (unsigned long)bufs;
+	mem->regions[0].memory_size = RING * BUFSZ;
+
+	self->kick = eventfd(0, 0);
+	ASSERT_GE(self->kick, 0);
+	addr.desc_user_addr = (unsigned long)self->vr.desc;
+	addr.avail_user_addr = (unsigned long)self->vr.avail;
+	addr.used_user_addr = (unsigned long)self->vr.used;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_OWNER, NULL), 0);
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_FEATURES, &features), 0);
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_MEM_TABLE, mem), 0);
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_NUM, &state), 0);
+	state.num = 0;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_BASE, &state), 0);
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_ADDR, &addr), 0);
+	file.fd = self->kick;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_VRING_KICK, &file), 0);
+	file.fd = self->tap;
+	ASSERT_EQ(ioctl(self->vhost, VHOST_NET_SET_BACKEND, &file), 0);
+	free(mem);
+}
+
+FIXTURE_TEARDOWN(tun_vhost)
+{
+	/* restore first: closing vhost blocks if buffers are not returned */
+	if (self->bl_fd >= 0 &&
+	    pwrite(self->bl_fd, self->bl, strlen(self->bl), 0) < 0)
+		TH_LOG("cannot restore netdev_max_backlog to %s", self->bl);
+	close(self->vhost);
+	close(self->tap);
+}
+
+TEST_F(tun_vhost, napi_queue_bounded)
+{
+	const char *stat = "/sys/class/net/%s/statistics/rx_packets";
+	const char *drop = "/sys/class/net/%s/statistics/rx_dropped";
+	long rx = read_long(stat, self->ifname, -1);
+	long dropped = read_long(drop, self->ifname, -1);
+	unsigned short idx = 0;
+	int n, ms;
+
+	/* lowered only here, so that a failed setup leaves it alone */
+	self->bl_fd = open("/proc/sys/net/core/netdev_max_backlog", O_RDWR);
+	ASSERT_GE(self->bl_fd, 0);
+	n = pread(self->bl_fd, self->bl, sizeof(self->bl) - 1, 0);
+	ASSERT_GT(n, 0);
+	self->bl[n] = '\0';
+	ASSERT_EQ(pwrite(self->bl_fd, "8", 1, 0), 1);
+
+	/* post the whole ring, wait for every buffer to come back, repeat */
+	for (n = 0; n < PKTS; n += RING) {
+		idx += RING;
+		__atomic_store_n(&self->vr.avail->idx, htole16(idx),
+				 __ATOMIC_RELEASE);
+		ASSERT_EQ(eventfd_write(self->kick, 1), 0);
+		for (ms = 0; le16toh(__atomic_load_n(&self->vr.used->idx,
+						     __ATOMIC_ACQUIRE)) != idx;
+		     ms++) {
+			ASSERT_LT(ms, 5000) TH_LOG("buffers not returned");
+			usleep(1000);
+		}
+	}
+
+	rx = read_long(stat, self->ifname, -1) - rx;
+	dropped = read_long(drop, self->ifname, -1) - dropped;
+	TH_LOG("sent %d, delivered %ld, dropped %ld", PKTS, rx, dropped);
+	EXPECT_GT(dropped, 0);		/* bounded */
+	EXPECT_GE(rx, PKTS / 16);	/* draining while the sender sends */
+	EXPECT_EQ(rx + dropped, PKTS);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/tun_vhost.sh b/tools/testing/selftests/net/tun_vhost.sh
new file mode 100755
index 000000000000..d92707de5e29
--- /dev/null
+++ b/tools/testing/selftests/net/tun_vhost.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run tun_vhost with vhost_net loaded, and once more with zerocopy enabled
+# if the module can be reloaded.
+
+ksft_skip=4
+param=/sys/module/vhost_net/parameters/experimental_zcopytx
+
+modprobe -q vhost_net
+[ -e /dev/vhost-net ] || exit $ksft_skip
+
+./tun_vhost
+ret=$?
+
+zc=$(cat "$param" 2>/dev/null)
+if [ "$zc" = 0 ] && modprobe -q -r vhost_net 2>/dev/null; then
+	modprobe vhost_net experimental_zcopytx=1 &&
+		{ ./tun_vhost -v zerocopy || ret=1; }
+	modprobe -q -r vhost_net
+	modprobe vhost_net experimental_zcopytx="$zc"
+fi
+exit $ret
-- 
2.56.0

