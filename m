Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AF9C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D4A611C3
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73D4A611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3138B60ECD;
	Wed, 29 Sep 2021 15:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhDtj1qoIAwf; Wed, 29 Sep 2021 15:11:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8385660C25;
	Wed, 29 Sep 2021 15:11:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADFDC0028;
	Wed, 29 Sep 2021 15:11:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D362C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3E15422AD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2WaHx6mvHEW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98D76421FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1632928289;
 x=1664464289; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CsaghLSaVLpU2MMwhss1abZWxi44kmc1aR1WxQPDiFY=;
 b=XrSQ3se7t9rrRCOnFL9zTryREYrMnx9t0tlL3chP2IoNkngwhbXaoS8y
 x40Es55UYM4+M2cJfrRVLxgwjXb6KhWvp74x1OqvNvqN4ULA/RtzkmKuO
 Rb3e0euOAfuGIt7mK3lFGnOCYJ9tPPWFkkVG35LbvdMkNxMp5G4/MZ7vI
 TM7bfpaVevn2YisH6XqUTT0kE+Ke5avFtrrb8QyK+UTsMhbOiT2Of8GMI
 4pwsCLwGCaw2bj/KYeQ7KzF/lEjXSOqI36I9gaUWPCnemNTOONDYRR74E
 tw7By4xN6LbD8Z2D9b1iIsRInlCzGuj4A7Nz84x0a1gtLPjHwYt754uCd g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
Subject: [RFC PATCH 10/10] selftests: add vhost_kernel tests
Date: Wed, 29 Sep 2021 17:11:19 +0200
Message-ID: <20210929151119.14778-11-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210929151119.14778-1-vincent.whitchurch@axis.com>
References: <20210929151119.14778-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com,
 stefanha@redhat.com, pbonzini@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add a test which uses the vhost_kernel_test driver to test the vhost
kernel buffers support.

The test uses virtio-net and vhost-net and sets up a loopback network
and then tests that ping works between the interface.  It also checks
that unbinding/rebinding of devices and closing the involved file
descriptors in different sequences during active use works correctly.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../vhost_kernel/vhost_kernel_test.c          | 287 ++++++++++++++++++
 .../vhost_kernel/vhost_kernel_test.sh         | 125 ++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 tools/testing/selftests/vhost_kernel/vhost_kernel_test.c
 create mode 100755 tools/testing/selftests/vhost_kernel/vhost_kernel_test.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..14a8349e3dc1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -73,6 +73,7 @@ TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
 TARGETS += vDSO
+TARGETS += vhost_kernel
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/vhost_kernel/vhost_kernel_test.c b/tools/testing/selftests/vhost_kernel/vhost_kernel_test.c
new file mode 100644
index 000000000000..b0f889bd2f72
--- /dev/null
+++ b/tools/testing/selftests/vhost_kernel/vhost_kernel_test.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/if_tun.h>
+#include <linux/virtio_net.h>
+#include <linux/vhost.h>
+#include <net/if.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#ifndef VIRTIO_F_ACCESS_PLATFORM
+#define VIRTIO_F_ACCESS_PLATFORM 33
+#endif
+
+#ifndef VKTEST_ATTACH_VHOST
+#define VKTEST_ATTACH_VHOST _IOW(0xbf, 0x31, int)
+#endif
+
+static int vktest;
+static const int num_vqs = 2;
+
+static int tun_alloc(char *dev)
+{
+	int hdrsize = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	struct ifreq ifr = {
+		.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR,
+	};
+	int fd, ret;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0)
+		err(1, "open /dev/net/tun");
+
+	strncpy(ifr.ifr_name, dev, IFNAMSIZ);
+
+	ret = ioctl(fd, TUNSETIFF, &ifr);
+	if (ret < 0)
+		err(1, "TUNSETIFF");
+
+	ret = ioctl(fd, TUNSETOFFLOAD,
+		    TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 | TUN_F_TSO_ECN);
+	if (ret < 0)
+		err(1, "TUNSETOFFLOAD");
+
+	ret = ioctl(fd, TUNSETVNETHDRSZ, &hdrsize);
+	if (ret < 0)
+		err(1, "TUNSETVNETHDRSZ");
+
+	strncpy(dev, ifr.ifr_name, IFNAMSIZ);
+
+	return fd;
+}
+
+static void handle_signal(int signum)
+{
+	if (signum == SIGUSR1)
+		close(vktest);
+}
+
+static void vhost_net_set_backend(int vhost)
+{
+	char if_name[IFNAMSIZ];
+	int tap_fd;
+
+	snprintf(if_name, IFNAMSIZ, "vhostkernel%d", 0);
+
+	tap_fd = tun_alloc(if_name);
+
+	for (int i = 0; i < num_vqs; i++) {
+		struct vhost_vring_file txbackend = {
+			.index = i,
+			.fd = tap_fd,
+		};
+		int ret;
+
+		ret = ioctl(vhost, VHOST_NET_SET_BACKEND, &txbackend);
+		if (ret < 0)
+			err(1, "VHOST_NET_SET_BACKEND");
+	}
+}
+
+static void prepare_vhost_vktest(int vhost, int vktest)
+{
+	uint64_t features = 1llu << VIRTIO_F_ACCESS_PLATFORM | 1llu << VIRTIO_F_VERSION_1;
+	int ret;
+
+	for (int i = 0; i < num_vqs; i++) {
+		int kickfd = eventfd(0, EFD_CLOEXEC);
+
+		if (kickfd < 0)
+			err(1, "eventfd");
+
+		struct vhost_vring_file kick = {
+			.index = i,
+			.fd = kickfd,
+		};
+
+		ret = ioctl(vktest, VHOST_SET_VRING_KICK, &kick);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_KICK");
+
+		ret = ioctl(vhost, VHOST_SET_VRING_KICK, &kick);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_KICK");
+	}
+
+	for (int i = 0; i < num_vqs; i++) {
+		int callfd = eventfd(0, EFD_CLOEXEC);
+
+		if (callfd < 0)
+			err(1, "eventfd");
+
+		struct vhost_vring_file call = {
+			.index = i,
+			.fd = callfd,
+		};
+
+		ret = ioctl(vktest, VHOST_SET_VRING_CALL, &call);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_CALL");
+
+		ret = ioctl(vhost, VHOST_SET_VRING_CALL, &call);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_CALL");
+	}
+
+	ret = ioctl(vhost, VHOST_SET_FEATURES, &features);
+	if (ret < 0)
+		err(1, "VHOST_SET_FEATURES");
+}
+
+static void test_attach(void)
+{
+	int vktest, vktest2;
+	int vhost;
+	int ret;
+
+	vhost = open("/dev/vhost-net-kernel", O_RDONLY);
+	if (vhost < 0)
+		err(1, "vhost");
+
+	vktest = open("/dev/vktest", O_RDONLY);
+	if (vktest < 0)
+		err(1, "vhost");
+
+	ret = ioctl(vhost, VHOST_SET_OWNER);
+	if (ret < 0)
+		err(1, "VHOST_SET_OWNER");
+
+	prepare_vhost_vktest(vhost, vktest);
+
+	ret = ioctl(vktest, VKTEST_ATTACH_VHOST, vhost);
+	if (ret < 0)
+		err(1, "VKTEST_ATTACH_VHOST");
+
+	vktest2 = open("/dev/vktest", O_RDONLY);
+	if (vktest2 < 0)
+		err(1, "vktest");
+
+	ret = ioctl(vktest2, VKTEST_ATTACH_VHOST, vhost);
+	if (ret == 0)
+		errx(1, "Second attach did not fail");
+
+	close(vktest2);
+	close(vktest);
+	close(vhost);
+}
+
+int main(int argc, char *argv[])
+{
+	bool serve = false;
+	uint64_t features;
+	int vhost;
+	struct option options[] = {
+		{ "serve", no_argument, NULL, 's' },
+		{}
+	};
+
+	while (1) {
+		int c;
+
+		c = getopt_long_only(argc, argv, "", options, NULL);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 's':
+			serve = true;
+			break;
+		case '?':
+		default:
+			errx(1, "usage %s [--serve]", argv[0]);
+		}
+	};
+
+	if (!serve) {
+		test_attach();
+		return 0;
+	}
+
+	vhost = open("/dev/vhost-net-kernel", O_RDONLY);
+	if (vhost < 0)
+		err(1, "vhost");
+
+	int ret;
+
+	ret = ioctl(vhost, VHOST_SET_OWNER);
+	if (ret < 0)
+		err(1, "VHOST_SET_OWNER");
+
+	vktest = open("/dev/vktest", O_RDONLY);
+	if (vktest < 0)
+		err(1, "vktest");
+
+	for (int i = 0; i < num_vqs; i++) {
+		int kickfd;
+
+		kickfd = eventfd(0, EFD_CLOEXEC);
+		if (kickfd < 0)
+			err(1, "eventfd");
+
+		struct vhost_vring_file kick = {
+			.index = i,
+			.fd = kickfd,
+		};
+
+		ret = ioctl(vktest, VHOST_SET_VRING_KICK, &kick);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_KICK");
+
+		ret = ioctl(vhost, VHOST_SET_VRING_KICK, &kick);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_KICK");
+	}
+
+	for (int i = 0; i < num_vqs; i++) {
+		int callfd;
+
+		callfd = eventfd(0, EFD_CLOEXEC);
+		if (callfd < 0)
+			err(1, "eventfd");
+
+		struct vhost_vring_file call = {
+			.index = i,
+			.fd = callfd,
+		};
+
+		ret = ioctl(vktest, VHOST_SET_VRING_CALL, &call);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_CALL");
+
+		ret = ioctl(vhost, VHOST_SET_VRING_CALL, &call);
+		if (ret < 0)
+			err(1, "VHOST_SET_VRING_CALL");
+	}
+
+	features = 1llu << VIRTIO_F_ACCESS_PLATFORM | 1llu << VIRTIO_F_VERSION_1;
+	ret = ioctl(vhost, VHOST_SET_FEATURES, &features);
+	if (ret < 0)
+		err(1, "VHOST_SET_FEATURES");
+
+	vhost_net_set_backend(vhost);
+
+	ret = ioctl(vktest, VKTEST_ATTACH_VHOST, vhost);
+	if (ret < 0)
+		err(1, "VKTEST_ATTACH_VHOST");
+
+	signal(SIGUSR1, handle_signal);
+
+	while (1)
+		pause();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/vhost_kernel/vhost_kernel_test.sh b/tools/testing/selftests/vhost_kernel/vhost_kernel_test.sh
new file mode 100755
index 000000000000..82b7896cea68
--- /dev/null
+++ b/tools/testing/selftests/vhost_kernel/vhost_kernel_test.sh
@@ -0,0 +1,125 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0-only
+
+cleanup() {
+	[ -z "$PID" ] || kill $PID 2>/dev/null || :
+	[ -z "$PINGPID0" ] || kill $PINGPID0 2>/dev/null || :
+	[ -z "$PINGPID1" ] || kill $PINGPID1 2>/dev/null || :
+	ip netns del g2h 2>/dev/null || :
+	ip netns del h2g 2>/dev/null || :
+}
+
+fail() {
+	echo "FAIL: $*"
+	exit 1
+}
+
+./vhost_kernel_test || fail "Sanity test failed"
+
+cleanup
+trap cleanup EXIT
+
+test_one() {
+	ls /sys/class/net/ > before
+	echo > new
+
+	./vhost_kernel_test --serve &
+	PID=$!
+
+	echo 'Waiting for interfaces'
+
+	timeout=5
+	while [ $timeout -gt 0 ]; do
+		timeout=$(($timeout - 1))
+		sleep 1
+		ls /sys/class/net/ > after
+		grep -F -x -v -f before after > new || continue
+		[ $(wc -l < new) -eq 2 ] || continue
+		break
+	done
+
+	g2h=
+	h2g=
+
+	while IFS= read -r iface; do
+		case $iface in
+			vhostkernel*)
+				h2g=$iface
+				;;
+			*)
+				# Assumed to be virtio-net
+				g2h=$iface
+				;;
+		esac
+
+	done<new
+
+	[ "$g2h" ] || fail "Did not find guest-to-host interface"
+	[ "$h2g" ] || fail "Did not find host-to-guest interface"
+
+	# IPv6 link-local addresses prevent short-circuit delivery.
+	hostip=fe80::0
+	guestip=fe80::1
+
+	# Move the interfaces out of the default namespaces to prevent network manager
+	# daemons from messing with them.
+	ip netns add g2h
+	ip netns add h2g
+
+	ip link set dev $h2g netns h2g
+	ip netns exec h2g ip addr add dev $h2g scope link $hostip
+	ip netns exec h2g ip link set dev $h2g up
+
+	ip link set dev $g2h netns g2h
+	ip netns exec g2h ip addr add dev $g2h scope link $guestip
+	ip netns exec g2h ip link set dev $g2h up
+
+	# ip netns exec g2h tcpdump -i $g2h -w $g2h.pcap &
+	# ip netns exec h2g tcpdump -i $h2g -w $h2g.pcap &
+
+	ip netns exec h2g ping6 -c10 -A -s 20000 $guestip%$h2g
+	ip netns exec g2h ping6 -c10 -A -s 20000 $hostip%$g2h
+}
+
+start_background_flood() {
+	ip netns exec h2g ping6 -f $guestip%$h2g &
+	PINGPID0=$!
+	ip netns exec g2h ping6 -f $hostip%$g2h &
+	PINGPID1=$!
+	sleep 1
+}
+
+echo TEST: Basic test
+test_one
+# Trigger cleanup races
+start_background_flood
+cleanup
+
+echo TEST: Close vhost_test fd before vhost
+test_one
+start_background_flood
+kill -USR1 $PID
+PID=
+cleanup
+
+echo TEST: Unbind virtio_net and close
+test_one
+start_background_flood
+echo virtio0 > /sys/bus/virtio/drivers/virtio_net/unbind
+cleanup
+
+echo TEST: Unbind and rebind virtio_net
+test_one
+start_background_flood
+echo virtio0 > /sys/bus/virtio/drivers/virtio_net/unbind
+echo virtio0 > /sys/bus/virtio/drivers/virtio_net/bind
+# We assume that $g2h is the same after the new probe
+ip link set dev $g2h netns g2h
+ip netns exec g2h ip addr add dev $g2h scope link $guestip
+ip netns exec g2h ip link set dev $g2h up
+ip netns exec g2h ping6 -c10 -A -s 20000 $hostip%$g2h
+cleanup
+
+trap - EXIT
+
+echo OK
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
