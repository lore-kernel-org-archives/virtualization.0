Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545342;
	b=4LzyTY5uLWiIlpPAbLrukOUt98isaMAl/WuI1ZHIy3sN/UtZTpim7r/PPM3ApzAyz8tD
	 MX7f33i/HnmMOF5BMEFCVrcuSElXuGMw0nEP4Vo2424wcO3D37I9QVa6h7i6jY9oxrz8Q
	 T3L1FiSxN3J4/2y4TBEykb6mWKjOhhnnaS+myfa6lo9XujFihgZjdLEKEv4rAbS7IvxNB
	 5pioc5Qp5zMBt3XkYVrKQxqI1TaPGfa1Q/QdZEsRENFtN1hQminbG9ej39a7zYq8ixGSY
	 nLpkYsZCq/C4HWOtShiHUXEATdgZwkEzw/aFsbaaAqzmFYYHqKuCOMJas0KzmueZqlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=928rN+AT5MdWDoPuNCNNp4C4Ybs3Rqz21W8MSmNz1zo=;
	b=NIHRyQ3obCFJJ9E3xl6r6va4yxfOQ7SH9ij3ZkFfAa4p2WKvW+HPD4/hvGxlneooaJ9g
	 jMlvK5DJ3ltUYqt1m2fM3xcq1W2trp/T0D+nb9Cv1t6MAMyWJQQ2fv5Puo6gFPu2MtAj5
	 Djx/FaxPnMpGEDADI1k0ICl6EMDsn7vvjIt8Q4JysimDHlGtDGY/ecE3uIe90j5g/V1Wb
	 K16GDFsB7ZccMX/eWX41u6ZAtfbWKwvL9/TSo3TmtIsocSwP1AkPzpLfKzZYHS6hn2f73
	 lN7h3IwahlEeKcVaa8XlmsUrYT5qBbEYSQTJKrnPDDqZxTeIDhZU70+3HFMKGv1u7hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bs6xW7zN;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D68606A320
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D68606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=bs6xW7zN
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNFmtE885087;
	Tue, 20 Oct 2026 18:15:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=928rN+AT5MdWDoPuNCNNp4C4Ybs3Rqz21W8MS
	mNz1zo=; b=bs6xW7zNmtFf91B/3n1bboL793D8U29T/gwvs5hapAVnIafzaaSBw
	2sdidUkl4VhlUSot+e4PzOLEGsQ2ZPOgA0drsvZdUcJotnWH8yJoKzNNZgK89IFs
	0qROZRB432Rh3qG/RZDhVp0d5PV3ONB3LyRuvCgkdH52D+MiamPeEkeUe1K8WHgT
	9GGZEA2MB7j5FpP/9mdBsbDf40qgZGkRcqfb/3mcj0lpU2JiOi/LNXlO8UtJuipG
	dGDXdSOP9Uqg3JHShoS4hpXz7dewYpgHpL8Ucaa/NMJ4NIDYRXg3445mS97f2iJx
	FRqVFIQtCBP1ZhcxIAc9OqA9eBXfxSn8A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw52r0mj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:20 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 21 Oct
 2026 01:15:19 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:07 -0700
Subject: [PATCH net-next v4 4/7] vsock: add a netlink command to assign the
 g2h device to a netns
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX5KaXk1HOjSuI
 5uMtEIj45uRNrBaiS1sX9f2mXE3+rra9toR+5waKvXXPT7/0FrkQLPkjcy9SeoN6rEOOZAUkA/G
 NPvnLFtSbzxIsLS8kCvrRasuQbJGwG2XH7ig5es3YuSvXQb8dQdng4pN3Rvnfvr14xhj7WwnUFM
 6PKAE110p7gawiK6IrknUx+Am4Wvd1VQpLg9Sb065a7haxUmOhUUNRhb8AD7Ouv9mp25pNGJiEr
 3ZNO4iLJJNqv/8hWQ1vQscjkISKht47Wbsd9aRz6f5xETGwr+8xTDWh9la3jMwtz3aQ/TxgWMfn
 hIdCvcFVEuE0QmBbHPea6lH1mXHS2LJr1CHxUyzIVG+hlBa3TkqF/InmzvIM+CZJ0Rr+bH5VCMd
 0rH96LOFfaAGVLehIiEgk0goO29osLAHPsG/Ts1aqwSB2slIMXZBFwduVdIawthJD2mDCC3VDzI
 DYA6lRo1HBfSdC48cWA==
X-Proofpoint-ORIG-GUID: A4HyRIk1LDBNKTvA1Zd1JKotwD3KWmjj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX5Mmp8+H/RmyI
 B2Y7ddA6x3HyVQrwvuPlmaXuyPRGsOMejm+WcNV3nD5m3VpHF4SyUNREuVrv1HlNuiWm+HTT47O
 YTtX0L4nscxEnMa/g/+4cjGuPO8yJD4=
X-Proofpoint-GUID: A4HyRIk1LDBNKTvA1Zd1JKotwD3KWmjj
X-Authority-Analysis: v=2.4 cv=BqEIUoX5 c=1 sm=1 tr=0 ts=6ad81228 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=fzBPsfzWtFBdnYnY89EA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

Namespaces let a host isolate a VM's vsock traffic to a specific
namespace, but in a guest vsock traffic cannot be isolated to a
namespace. The vsock device is hardcoded to global mode and can't be
moved into a local-mode namespace.

Introduce a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET,
which moves the device to the namespace the request was sent from.

VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
namespace as an nsid relative to the caller. VSOCK_CMD_DEV_NETNS_SET
replies with the same message.

The command requires CAP_NET_ADMIN in the initial user namespace. A
privileged user wishing to "unassign" the device can move it to the
init_net, which is hardcoded to global mode (so no unassign call is
necessary).

Connected sockets are closed with ECONNRESET when the underlying device
moves to a different namespace, so as to prevent reachability from the
previous and now disallowed namespace.

Device netns assignment is rejected when it would cause a CID collision
(e.g., moving a g2h device with CID 10 into a namespace with a nested
H2G VM with CID 10). On namespace destruction, the netdev approach
cannot be emulated. A netdev's IP addresses are removed before it
returns to init_net, which makes an address collision impossible, but
the vsock device keeps its CID. Instead, namespace destruction is
deferred until the device has moved. Again, CAP_NET_ADMIN in the init
user namespace is required for the assignment.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- Treat an unreachable g2h device as absent in vsock_use_local_transport(),
  so a local ns can connect to the CID it reports as local (Sashiko)
- Reset swept sockets under lock_sock() (Sashiko), and serialize assigns
  with vsock_g2h_assign_mutex now that the sweep runs outside
  vsock_register_mutex

Changes in v3:
- Try to use net_tracker when taking net references
- Take a reference on the net when assigning a device to it. This keeps
  the net alive even after deletion. Drop the concept of moving the
  device back to init_net on net destruction. This avoids the problem
  of the device CID colliding with a nested h2g CID.
- Refuse the assign with -EADDRINUSE when a guest in the target netns
  already answers to the device's CID, via the h2g transport's
  ->has_remote_cid()
- Hold vsock_register_mutex across the CID check and commit in
  vhost_vsock_set_cid(), so it cannot race an assign. We also add a
  lockdep assertion into vsock_find_cid() because it is a requirement to
  avoid racing between netns assignment of a g2h device and setting a
  nested h2g CID (I know, not ideal looking)
- Unlink swept sockets from vsock_connected_table, so a retried
  connect() cannot insert the same node twice
- Drop the RST to the peer from the sweep, along with the ->reset op and
  the pending_reset list (Sashiko)
- Reply to VSOCK_CMD_DEV_NETNS_SET with the netns-id instead a plain ACK
  (Sashiko)

Changes in v2:
- New patch, replaces the ioctl with a genl family and
  VSOCK_CMD_DEV_NETNS_SET (Stefano)
- Make netns_assign_allow a bool, not a callback (Stefano)
- One vsock_netns_assignable(t) helper for both call sites (Stefano)
- Make vsock_g2h_reachable_sk() static, drop the export (Stefano)
- RST the peer when socket loses access to the device's net (Stefano)
- Move the netns reset out of the sysctl exit hook, into the renamed
  vsock_pernet_ops (Stefano).
- Remove the synchronize_rcu() from the pernet exit path. The
  net_namespace documentation states that synchronize_rcu() should be
  avoided in the pernet exit path.
- Run the socket reset in the pernet pre_exit() hook, as the
  net_namespace management code (and documentation) guarantees
  synchronize_rcu() between pre_exit() and exit()
- Drop the conditional synchronize_rcu() in vsock_core_unregister()
  (Stefano)
- Specifically state "G2H transport" in the netns_assign_allow comment (Stefano)
- Avoid leaking the g2h CID to a namespace that cannot reach it;
  GET_LOCAL_CID, bind() and loopback transport selection all read it
  through vsock_registered_transport_cid(), which now takes a netns
- Add VSOCK_CMD_DEV_NETNS_GET
---
 Documentation/admin-guide/sysctl/net.rst |  42 +++
 Documentation/netlink/specs/vsock.yaml   |  75 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  19 +-
 include/net/af_vsock.h                   |  13 +-
 include/uapi/linux/vsock.h               |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 479 +++++++++++++++++++++++++++++--
 net/vmw_vsock/vsock_nl_gen.c             |  36 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 11 files changed, 693 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index fe43e8595958..eb60903e4eb2 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -529,6 +529,48 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
 by the namespace's mode (``global`` or ``local``), which controls how CIDs
 (Context IDs) are allocated and how sockets interact across namespaces.
 
+In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
+to one network namespace at a time. The ``VSOCK_CMD_DEV_NETNS_SET`` command of
+the ``vsock`` netlink family, described in
+Documentation/netlink/specs/vsock.yaml, moves it to the namespace the request
+was sent from, which requires ``CAP_NET_ADMIN`` in the initial user namespace.
+The namespace's mode decides who may then use the device:
+
+- ``global`` - every ``global`` mode namespace may use it.
+- ``local`` - only that namespace may use it, which reserves the connection to
+  the host for it alone.
+
+The device starts out in init_net, so until the command is issued nothing has
+moved and no mode has changed.
+
+Support is transport dependent. A G2H transport that does not implement the
+move refuses the command with ``EOPNOTSUPP``. Of the in-tree guest transports,
+only virtio-vsock implements it.
+
+A namespace that cannot reach the device sees the vsock addresses it would see
+if no G2H transport were loaded: the device's CID is not one of its local CIDs,
+and with ``vsock_loopback`` loaded, ``VMADDR_CID_HOST`` (2) is served by
+loopback.
+
+Connections established before the move, from a namespace that can no longer
+reach the device, are closed with ``ECONNRESET``. Nothing is sent to the peer,
+which is what already happens when the device is removed altogether: the peer
+finds out on its next send, which no longer matches a socket and so is answered
+with a reset. A peer that only receives waits for its own timeout. A connection
+still being set up when the device moves is refused with a reset once the peer
+answers it.
+
+An assignment keeps the namespace alive, the same way an open socket does, so
+deleting that namespace does not move the device. Assigning the device to
+another namespace, such as init_net, is the only way to undo an assignment, and
+releases the reference the assignment held on the previous namespace.
+
+The move is refused with ``EADDRINUSE`` if a guest registered in the target
+namespace already answers to the device's CID, since the CID would otherwise
+name two different peers there. If a loaded H2G transport cannot check that,
+the move is refused with ``EOPNOTSUPP``. Of the in-tree host transports, only
+vhost-vsock can.
+
 ns_mode
 -------
 
diff --git a/Documentation/netlink/specs/vsock.yaml b/Documentation/netlink/specs/vsock.yaml
new file mode 100644
index 000000000000..74cf2472bf91
--- /dev/null
+++ b/Documentation/netlink/specs/vsock.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+#
+---
+name: vsock
+
+doc: |
+  Control interface for the vsock (AF_VSOCK) core.
+
+protocol: genetlink
+
+uapi-header: linux/vsock.h
+
+attribute-sets:
+  -
+    name: vsock
+    attributes:
+      -
+        name: netns-id
+        type: s32
+        doc: |
+          Network namespace the guest's vsock device is assigned to, as an
+          nsid relative to the caller.
+
+          Absent when the device is in the caller's own namespace, and
+          NETNSA_NSID_NOT_ASSIGNED when the g2h transport supports netns
+          assignment and the caller's namespace cannot reach the device under
+          the mode rules, or when no nsid could be allocated for it.
+
+operations:
+  list:
+    -
+      name: dev-netns-set
+      doc: |
+        Set the network namespace of the guest's vsock device.
+
+        The device is moved to the namespace the request was sent from. It
+        starts out in init_net, and moving it back there is how an
+        assignment is undone.
+
+        A g2h transport that does not support netns assignment returns
+        EOPNOTSUPP. If the netns assignment would cause a CID collision, it
+        is rejected with EADDRINUSE.
+
+        The namespace's mode decides who may then use the device: a global
+        mode namespace shares it with every other global mode namespace,
+        while a local mode namespace reserves it for itself.
+
+        Movement to an unreachable local namespace results in sockets being
+        closed with ECONNRESET. Peers are not guaranteed to be notified via
+        an RST.
+
+        The assignment holds a reference on the namespace.
+      attribute-set: vsock
+      flags: [admin-perm]
+      do:
+        reply:
+          attributes:
+            - netns-id
+    -
+      name: dev-netns-get
+      doc: |
+        Get the network namespace the guest's vsock device is assigned to.
+
+        The namespace is reported as an nsid relative to the caller, so the
+        attribute is absent when the device is already in the caller's own
+        namespace. If the g2h transport supports netns assignment, a caller
+        whose namespace cannot reach the device is told
+        NETNSA_NSID_NOT_ASSIGNED rather than where the device went.
+      attribute-set: vsock
+      do:
+        reply:
+          attributes:
+            - netns-id
diff --git a/MAINTAINERS b/MAINTAINERS
index 7636ab50d44f..6bca71c935cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29169,10 +29169,12 @@ M:	Stefano Garzarella <sgarzare@redhat.com>
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/netlink/specs/vsock.yaml
 F:	drivers/net/vsockmon.c
 F:	include/net/af_vsock.h
 F:	include/uapi/linux/vm_sockets.h
 F:	include/uapi/linux/vm_sockets_diag.h
+F:	include/uapi/linux/vsock.h
 F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/selftests/vsock/
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 01f8930ca51f..11893f1943c6 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -815,6 +815,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 {
 	struct vhost_vsock *other;
+	int ret;
 
 	/* Refuse reserved CIDs */
 	if (guest_cid <= VMADDR_CID_HOST ||
@@ -828,15 +829,20 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	/* Refuse if CID is assigned to the guest->host transport (i.e. nested
 	 * VM), to make the loopback work.
 	 */
-	if (vsock_find_cid(guest_cid))
-		return -EADDRINUSE;
+	mutex_lock(&vsock_register_mutex);
+
+	if (__vsock_find_cid(vsock->net, guest_cid)) {
+		ret = -EADDRINUSE;
+		goto unlock;
+	}
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
 	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
-		return -EADDRINUSE;
+		ret = -EADDRINUSE;
+		goto unlock;
 	}
 
 	if (vsock->guest_cid)
@@ -846,7 +852,12 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
 	mutex_unlock(&vhost_vsock_mutex);
 
-	return 0;
+	ret = 0;
+
+unlock:
+	mutex_unlock(&vsock_register_mutex);
+
+	return ret;
 }
 
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 1c38a27fadf2..883a98dab36d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -9,6 +9,7 @@
 #define __AF_VSOCK_H__
 
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <net/netns/vsock.h>
 #include <net/sock.h>
@@ -22,6 +23,7 @@
 extern struct list_head vsock_bind_table[VSOCK_HASH_SIZE + 1];
 extern struct list_head vsock_connected_table[VSOCK_HASH_SIZE];
 extern spinlock_t vsock_table_lock;
+extern struct mutex vsock_register_mutex;
 
 #define vsock_sk(__sk)    ((struct vsock_sock *)__sk)
 #define sk_vsock(__vsk)   (&(__vsk)->sk)
@@ -190,6 +192,9 @@ struct vsock_transport {
 
 	/* Zero-copy. */
 	bool (*msgzerocopy_allow)(void);
+
+	/* True if the G2H transport honours VSOCK_CMD_DEV_NETNS_SET. */
+	bool netns_assign_allow;
 };
 
 /**** CORE ****/
@@ -236,8 +241,14 @@ void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
-bool vsock_find_cid(unsigned int cid);
+bool vsock_find_cid(struct net *net, unsigned int cid);
+/* Caller must hold vsock_register_mutex. */
+bool __vsock_find_cid(struct net *net, unsigned int cid);
 void vsock_linger(struct sock *sk);
+struct net *vsock_g2h_net_get(netns_tracker *tracker);
+bool vsock_g2h_net_eq(const struct net *net);
+bool vsock_g2h_net_reachable(struct net *net);
+bool vsock_maybe_set_connected(struct vsock_sock *vsk);
 
 /**** TAP ****/
 
diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
new file mode 100644
index 000000000000..803b9aa1f0b3
--- /dev/null
+++ b/include/uapi/linux/vsock.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/vsock.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_VSOCK_H
+#define _UAPI_LINUX_VSOCK_H
+
+#define VSOCK_FAMILY_NAME	"vsock"
+#define VSOCK_FAMILY_VERSION	1
+
+enum {
+	VSOCK_A_NETNS_ID = 1,
+
+	__VSOCK_A_MAX,
+	VSOCK_A_MAX = (__VSOCK_A_MAX - 1)
+};
+
+enum {
+	VSOCK_CMD_DEV_NETNS_SET = 1,
+	VSOCK_CMD_DEV_NETNS_GET,
+
+	__VSOCK_CMD_MAX,
+	VSOCK_CMD_MAX = (__VSOCK_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_VSOCK_H */
diff --git a/net/vmw_vsock/Makefile b/net/vmw_vsock/Makefile
index 5da74c4a9f1d..97e2a559e2bf 100644
--- a/net/vmw_vsock/Makefile
+++ b/net/vmw_vsock/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_VIRTIO_VSOCKETS_COMMON) += vmw_vsock_virtio_transport_common.o
 obj-$(CONFIG_HYPERV_VSOCKETS) += hv_sock.o
 obj-$(CONFIG_VSOCKETS_LOOPBACK) += vsock_loopback.o
 
-vsock-y += af_vsock.o af_vsock_tap.o vsock_addr.o
+vsock-y += af_vsock.o af_vsock_tap.o vsock_addr.o vsock_nl_gen.o
 vsock-$(CONFIG_BPF_SYSCALL) += vsock_bpf.o
 
 vsock_diag-y += diag.o
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c9b28e34b1b3..e16e72471b4a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -130,6 +130,27 @@
  *       a different transport that *does* support local mode. For
  *       example, virtio-vsock may not support local mode, but the socket
  *       may still accept a connection from vhost-vsock which does.
+ *
+ * - A guest has a single vsock device, owned by the guest->host transport.
+ *   The VSOCK_CMD_DEV_NETNS_SET netlink command moves it to the namespace the
+ *   request was sent from. It starts out in init_net. The mode rules then
+ *   decide who may use it, and which namespace packets from the host are
+ *   delivered to:
+ *
+ *   - assigned to a global mode namespace - every global mode namespace may
+ *     use it. Until the command is issued nothing has moved and no mode has
+ *     changed, so the default is the behaviour that predates it.
+ *   - assigned to a local mode namespace - only that namespace may use it.
+ *     This is how a nested VM is isolated from the rest of the guest.
+ *
+ *   Connections made before an assignment, from a namespace that can no
+ *   longer reach the device, are closed with ECONNRESET. Nothing is sent to
+ *   the peer. As with device removal, it finds out on its next send.
+ *
+ *   The assignment holds a reference on the namespace, the way an open socket
+ *   does, so deleting that namespace does not move the device: its destruction
+ *   is deferred until the device moves to another namespace, on another
+ *   assignment or when the transport unregisters.
  */
 
 #include <linux/compat.h>
@@ -161,10 +182,14 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
+#include <linux/net_namespace.h>
+#include <net/genetlink.h>
 #include <net/netns/vsock.h>
 #include <uapi/linux/vm_sockets.h>
 #include <uapi/asm-generic/ioctls.h>
 
+#include "vsock_nl_gen.h"
+
 #define VSOCK_NET_MODE_STR_GLOBAL "global"
 #define VSOCK_NET_MODE_STR_LOCAL "local"
 
@@ -206,7 +231,21 @@ static const struct vsock_transport *transport_g2h;
 static const struct vsock_transport *transport_dgram;
 /* Transport used for local communication */
 static const struct vsock_transport *transport_local;
-static DEFINE_MUTEX(vsock_register_mutex);
+/* Protects transport registration and the g2h device's netns. */
+DEFINE_MUTEX(vsock_register_mutex);
+EXPORT_SYMBOL_GPL(vsock_register_mutex);
+
+/* Network namespace of the g2h device. Protected by
+ * vsock_register_mutex/RCU.
+ */
+static struct net __rcu *vsock_g2h_net = RCU_INITIALIZER(&init_net);
+static netns_tracker vsock_g2h_net_tracker;
+
+/* Held across an assign's swap and reset sweep, so that a later assign cannot
+ * move the device back before the sweep has closed every socket that lost it.
+ * Must be taken before vsock_register_mutex.
+ */
+static DEFINE_MUTEX(vsock_g2h_assign_mutex);
 
 /**** UTILS ****/
 
@@ -553,7 +592,42 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
-static bool vsock_use_local_transport(unsigned int remote_cid)
+/* Return true if @t honours namespace assignment. One that does not keeps the
+ * reachability rules it had before VSOCK_CMD_DEV_NETNS_SET existed.
+ */
+static bool vsock_net_assignable(const struct vsock_transport *t)
+{
+	return t && t->netns_assign_allow;
+}
+
+static bool vsock_g2h_unreachable(const struct vsock_transport *t,
+				  struct net *net)
+{
+	return t == transport_g2h && vsock_net_assignable(t) &&
+	       !vsock_g2h_net_reachable(net);
+}
+
+/* Return the CID of the transport in @transport, as seen from @net.
+ *
+ * Returns VMADDR_CID_ANY if the transport supports net assignment but is not
+ * reachable from the net.
+ */
+static u32
+__vsock_registered_transport_cid(const struct vsock_transport **transport,
+				 struct net *net)
+{
+	lockdep_assert_held(&vsock_register_mutex);
+
+	if (!*transport)
+		return VMADDR_CID_ANY;
+
+	if (vsock_g2h_unreachable(*transport, net))
+		return VMADDR_CID_ANY;
+
+	return (*transport)->get_local_cid();
+}
+
+static bool vsock_use_local_transport(struct net *net, unsigned int remote_cid)
 {
 	lockdep_assert_held(&vsock_register_mutex);
 
@@ -563,11 +637,10 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
 	if (remote_cid == VMADDR_CID_LOCAL)
 		return true;
 
-	if (transport_g2h) {
+	if (transport_g2h && !vsock_g2h_unreachable(transport_g2h, net))
 		return remote_cid == transport_g2h->get_local_cid();
-	} else {
-		return remote_cid == VMADDR_CID_HOST;
-	}
+
+	return remote_cid == VMADDR_CID_HOST;
 }
 
 static void vsock_deassign_transport(struct vsock_sock *vsk)
@@ -626,7 +699,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
+		if (vsock_use_local_transport(sock_net(sk), remote_cid))
 			new_transport = transport_local;
 		else if (remote_cid <= VMADDR_CID_HOST ||
 			 (remote_flags & VMADDR_FLAG_TO_HOST))
@@ -651,6 +724,11 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
+	if (vsock_g2h_unreachable(new_transport, sock_net(sk))) {
+		ret = -ENETUNREACH;
+		goto err;
+	}
+
 	if (vsk->transport && vsk->transport == new_transport) {
 		ret = 0;
 		goto err;
@@ -717,21 +795,24 @@ EXPORT_SYMBOL_GPL(vsock_assign_transport);
  * Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
  * Otherwise we may race with module removal. Do not use on `vsk->transport`.
  */
-static u32 vsock_registered_transport_cid(const struct vsock_transport **transport)
+static u32
+vsock_registered_transport_cid(const struct vsock_transport **transport,
+			       struct net *net)
 {
-	u32 cid = VMADDR_CID_ANY;
+	u32 cid;
 
 	mutex_lock(&vsock_register_mutex);
-	if (*transport)
-		cid = (*transport)->get_local_cid();
+	cid = __vsock_registered_transport_cid(transport, net);
 	mutex_unlock(&vsock_register_mutex);
 
 	return cid;
 }
 
-bool vsock_find_cid(unsigned int cid)
+bool __vsock_find_cid(struct net *net, unsigned int cid)
 {
-	if (cid == vsock_registered_transport_cid(&transport_g2h))
+	lockdep_assert_held(&vsock_register_mutex);
+
+	if (cid == __vsock_registered_transport_cid(&transport_g2h, net))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -742,8 +823,303 @@ bool vsock_find_cid(unsigned int cid)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(__vsock_find_cid);
+
+bool vsock_find_cid(struct net *net, unsigned int cid)
+{
+	bool found;
+
+	mutex_lock(&vsock_register_mutex);
+	found = __vsock_find_cid(net, cid);
+	mutex_unlock(&vsock_register_mutex);
+
+	return found;
+}
 EXPORT_SYMBOL_GPL(vsock_find_cid);
 
+/* Return the namespace the g2h device is assigned to, with a reference held.
+ *
+ * The assignment itself holds a reference, so the namespace cannot be going
+ * away here and this never fails.
+ */
+struct net *vsock_g2h_net_get(netns_tracker *tracker)
+{
+	struct net *net;
+
+	rcu_read_lock();
+	net = rcu_dereference(vsock_g2h_net);
+	get_net_track(net, tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return net;
+}
+EXPORT_SYMBOL_GPL(vsock_g2h_net_get);
+
+/* True if @net is still the namespace the device is assigned to. Cheap enough
+ * to call per packet on the RX path.
+ */
+bool vsock_g2h_net_eq(const struct net *net)
+{
+	return rcu_access_pointer(vsock_g2h_net) == net;
+}
+EXPORT_SYMBOL_GPL(vsock_g2h_net_eq);
+
+bool vsock_g2h_net_reachable(struct net *net)
+{
+	bool reachable;
+
+	rcu_read_lock();
+	reachable = vsock_net_check_mode(net, rcu_dereference(vsock_g2h_net));
+	rcu_read_unlock();
+
+	return reachable;
+}
+EXPORT_SYMBOL_GPL(vsock_g2h_net_reachable);
+
+static bool vsock_g2h_reachable_sk(struct vsock_sock *vsk)
+{
+	if (!vsock_net_assignable(vsk->transport))
+		return true;
+
+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
+}
+
+/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
+ * has moved to a namespace @vsk cannot reach. Returns false without doing
+ * either in that case.
+ *
+ * The reset sweep walks the same table under the same lock, so an assign
+ * cannot land between the check and the insert: either the sweep finds @vsk
+ * and closes it, or @vsk is never added.
+ */
+bool vsock_maybe_set_connected(struct vsock_sock *vsk)
+{
+	struct list_head *list;
+	bool reachable;
+
+	list = vsock_connected_sockets(&vsk->remote_addr, &vsk->local_addr);
+
+	spin_lock_bh(&vsock_table_lock);
+	reachable = vsock_g2h_reachable_sk(vsk);
+	if (reachable) {
+		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
+		__vsock_insert_connected(list, vsk);
+	}
+	spin_unlock_bh(&vsock_table_lock);
+
+	return reachable;
+}
+EXPORT_SYMBOL_GPL(vsock_maybe_set_connected);
+
+static bool vsock_g2h_should_reset(struct vsock_sock *vsk,
+				   const struct vsock_transport *t)
+{
+	return vsk->transport == t &&
+	       READ_ONCE(sk_vsock(vsk)->sk_state) != TCP_CLOSE &&
+	       !READ_ONCE(vsk->close_work_scheduled) &&
+	       !vsock_g2h_reachable_sk(vsk);
+}
+
+static struct vsock_sock *
+vsock_g2h_next_unreachable(const struct vsock_transport *t, unsigned int *i)
+{
+	struct vsock_sock *vsk;
+
+	spin_lock_bh(&vsock_table_lock);
+
+	for (; *i < ARRAY_SIZE(vsock_connected_table); (*i)++) {
+		list_for_each_entry(vsk, &vsock_connected_table[*i],
+				    connected_table) {
+			if (vsock_g2h_should_reset(vsk, t)) {
+				sock_hold(sk_vsock(vsk));
+				spin_unlock_bh(&vsock_table_lock);
+				return vsk;
+			}
+		}
+	}
+
+	spin_unlock_bh(&vsock_table_lock);
+
+	return NULL;
+}
+
+/* Close every connected socket of @t that can no longer reach the g2h device.
+ */
+static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
+{
+	struct vsock_sock *vsk;
+	unsigned int i = 0;
+	struct sock *sk;
+	bool reset;
+
+	lockdep_assert_held(&vsock_g2h_assign_mutex);
+	lockdep_assert_not_held(&vsock_register_mutex);
+
+	while ((vsk = vsock_g2h_next_unreachable(t, &i))) {
+		sk = sk_vsock(vsk);
+
+		lock_sock(sk);
+
+		reset = false;
+		spin_lock_bh(&vsock_table_lock);
+		if (__vsock_in_connected_table(vsk) &&
+		    vsock_g2h_should_reset(vsk, t)) {
+			__vsock_remove_connected(vsk);
+			reset = true;
+		}
+		spin_unlock_bh(&vsock_table_lock);
+
+		if (reset) {
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ECONNRESET;
+			sk_error_report(sk);
+		}
+
+		release_sock(sk);
+		sock_put(sk);
+	}
+}
+
+/* Point the g2h device at @net, taking the reference that keeps @net alive,
+ * and return the namespace it leaves behind.
+ */
+static struct net *vsock_g2h_net_swap(struct net *net, netns_tracker *old)
+{
+	lockdep_assert_held(&vsock_register_mutex);
+
+	*old = vsock_g2h_net_tracker;
+	get_net_track(net, &vsock_g2h_net_tracker, GFP_KERNEL);
+
+	return rcu_replace_pointer(vsock_g2h_net, net,
+				   lockdep_is_held(&vsock_register_mutex));
+}
+
+/* Drop the namespace the device just left, once the readers that may still
+ * see it in vsock_g2h_net_get() are gone. Runs without the mutex held.
+ */
+static void vsock_g2h_net_release(struct net *old, netns_tracker *tracker)
+{
+	synchronize_rcu();
+	put_net_track(old, tracker);
+}
+
+static int vsock_nl_dev_netns_fill(struct sk_buff *msg, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct net *assigned;
+	bool equal;
+	void *hdr;
+	s32 id;
+
+	lockdep_assert_held(&vsock_register_mutex);
+
+	rcu_read_lock();
+	assigned = rcu_dereference(vsock_g2h_net);
+	equal = net_eq(net, assigned);
+	if (!equal) {
+		if (vsock_net_assignable(transport_g2h) &&
+		    !vsock_net_check_mode(net, assigned))
+			id = NETNSA_NSID_NOT_ASSIGNED;
+		else
+			id = peernet2id_alloc(net, assigned, GFP_ATOMIC);
+	}
+	rcu_read_unlock();
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (!equal && nla_put_s32(msg, VSOCK_A_NETNS_ID, id)) {
+		genlmsg_cancel(msg, hdr);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+}
+
+/* Move the g2h device to @net, which keeps @net alive until the device leaves
+ * again. Returns -ENODEV if no g2h transport is loaded, -EOPNOTSUPP if the
+ * loaded one cannot be moved, and -EADDRINUSE if a guest in @net already uses
+ * the device's CID.
+ */
+static int vsock_g2h_net_assign(struct net *net, struct sk_buff *msg,
+				struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = info->extack;
+	const struct vsock_transport *t;
+	netns_tracker old_tracker;
+	struct net *old;
+	void *hdr;
+	int ret;
+
+	mutex_lock(&vsock_g2h_assign_mutex);
+	mutex_lock(&vsock_register_mutex);
+
+	ret = -ENODEV;
+	if (!transport_g2h) {
+		NL_SET_ERR_MSG(extack, "no guest-to-host transport is loaded");
+		goto unlock;
+	}
+
+	ret = -EOPNOTSUPP;
+	if (!vsock_net_assignable(transport_g2h)) {
+		NL_SET_ERR_MSG(extack,
+			       "the loaded guest-to-host transport does not support namespace assignment");
+		goto unlock;
+	}
+
+	if (transport_h2g && !transport_h2g->has_remote_cid) {
+		NL_SET_ERR_MSG(extack,
+			       "the loaded host-to-guest transport cannot check the device's CID");
+		goto unlock;
+	}
+
+	ret = -EADDRINUSE;
+	if (transport_h2g &&
+	    transport_h2g->has_remote_cid(net,
+					  transport_g2h->get_local_cid())) {
+		NL_SET_ERR_MSG(extack,
+			       "a guest in the target namespace already uses the device's CID");
+		goto unlock;
+	}
+
+	ret = -EMSGSIZE;
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		goto unlock;
+	genlmsg_end(msg, hdr);
+
+	ret = genlmsg_reply(msg, info);
+	msg = NULL;
+	if (ret)
+		goto unlock;
+
+	old = vsock_g2h_net_swap(net, &old_tracker);
+	t = transport_g2h;
+
+	mutex_unlock(&vsock_register_mutex);
+
+	/* See vsock_maybe_set_connected() comment about synchronizing with
+	 * connecting sockets.
+	 */
+	vsock_g2h_reset_unreachable(t);
+
+	mutex_unlock(&vsock_g2h_assign_mutex);
+
+	vsock_g2h_net_release(old, &old_tracker);
+
+	return 0;
+
+unlock:
+	mutex_unlock(&vsock_register_mutex);
+	mutex_unlock(&vsock_g2h_assign_mutex);
+	nlmsg_free(msg);
+
+	return ret;
+}
+
 static struct sock *vsock_dequeue_accept(struct sock *listener)
 {
 	struct vsock_sock *vlistener;
@@ -910,7 +1286,8 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	 * like AF_INET prevents binding to a non-local IP address (in most
 	 * cases), we only allow binding to a local CID.
 	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
+	if (addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(sock_net(sk_vsock(vsk)), addr->svm_cid))
 		return -EADDRNOTAVAIL;
 
 	switch (sk->sk_socket->type) {
@@ -2798,6 +3175,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
 {
 	u32 __user *p = ptr;
 	int retval = 0;
+	struct net *net;
 	u32 cid;
 
 	switch (cmd) {
@@ -2805,11 +3183,14 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		cid = vsock_registered_transport_cid(&transport_g2h);
+		net = current->nsproxy->net_ns;
+		cid = vsock_registered_transport_cid(&transport_g2h, net);
 		if (cid == VMADDR_CID_ANY)
-			cid = vsock_registered_transport_cid(&transport_h2g);
+			cid = vsock_registered_transport_cid(&transport_h2g,
+							     net);
 		if (cid == VMADDR_CID_ANY)
-			cid = vsock_registered_transport_cid(&transport_local);
+			cid = vsock_registered_transport_cid(&transport_local,
+							     net);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
@@ -2850,6 +3231,44 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
+int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	int err;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	mutex_lock(&vsock_register_mutex);
+	if (transport_g2h) {
+		err = vsock_nl_dev_netns_fill(msg, info);
+	} else {
+		NL_SET_ERR_MSG(info->extack,
+			       "no guest-to-host transport is loaded");
+		err = -ENODEV;
+	}
+	mutex_unlock(&vsock_register_mutex);
+
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	return vsock_g2h_net_assign(genl_info_net(info), msg, info);
+}
+
 static int __vsock_net_mode_string(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos,
 				   enum vsock_net_mode mode,
@@ -3065,6 +3484,8 @@ static int __init vsock_init(void)
 
 	vsock_init_tables();
 
+	get_net_track(&init_net, &vsock_g2h_net_tracker, GFP_KERNEL);
+
 	vsock_proto.owner = THIS_MODULE;
 	vsock_device.minor = MISC_DYNAMIC_MINOR;
 	err = misc_register(&vsock_device);
@@ -3091,10 +3512,18 @@ static int __init vsock_init(void)
 		goto err_unregister_sock;
 	}
 
+	err = genl_register_family(&vsock_nl_family);
+	if (err) {
+		pr_err("Cannot register vsock netlink family: %d\n", err);
+		goto err_unregister_pernet;
+	}
+
 	vsock_bpf_build_proto();
 
 	return 0;
 
+err_unregister_pernet:
+	unregister_pernet_subsys(&vsock_pernet_ops);
 err_unregister_sock:
 	sock_unregister(AF_VSOCK);
 err_unregister_proto:
@@ -3102,15 +3531,20 @@ static int __init vsock_init(void)
 err_deregister_misc:
 	misc_deregister(&vsock_device);
 err_reset_transport:
+	put_net_track(&init_net, &vsock_g2h_net_tracker);
 	return err;
 }
 
 static void __exit vsock_exit(void)
 {
+	genl_unregister_family(&vsock_nl_family);
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
 	unregister_pernet_subsys(&vsock_pernet_ops);
+
+	put_net_track(rcu_dereference_protected(vsock_g2h_net, true),
+		      &vsock_g2h_net_tracker);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
@@ -3177,13 +3611,18 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
 
 void vsock_core_unregister(const struct vsock_transport *t)
 {
+	netns_tracker old_tracker;
+	struct net *old = NULL;
+
 	mutex_lock(&vsock_register_mutex);
 
 	if (transport_h2g == t)
 		transport_h2g = NULL;
 
-	if (transport_g2h == t)
+	if (transport_g2h == t) {
 		transport_g2h = NULL;
+		old = vsock_g2h_net_swap(&init_net, &old_tracker);
+	}
 
 	if (transport_dgram == t)
 		transport_dgram = NULL;
@@ -3192,6 +3631,10 @@ void vsock_core_unregister(const struct vsock_transport *t)
 		transport_local = NULL;
 
 	mutex_unlock(&vsock_register_mutex);
+
+	/* The device is gone, so release the namespace it was holding. */
+	if (old)
+		vsock_g2h_net_release(old, &old_tracker);
 }
 EXPORT_SYMBOL_GPL(vsock_core_unregister);
 
diff --git a/net/vmw_vsock/vsock_nl_gen.c b/net/vmw_vsock/vsock_nl_gen.c
new file mode 100644
index 000000000000..81db4c61d7bb
--- /dev/null
+++ b/net/vmw_vsock/vsock_nl_gen.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/vsock.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "vsock_nl_gen.h"
+
+#include <uapi/linux/vsock.h>
+
+/* Ops table for vsock */
+static const struct genl_split_ops vsock_nl_ops[] = {
+	{
+		.cmd	= VSOCK_CMD_DEV_NETNS_SET,
+		.doit	= vsock_nl_dev_netns_set_doit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= VSOCK_CMD_DEV_NETNS_GET,
+		.doit	= vsock_nl_dev_netns_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family vsock_nl_family __ro_after_init = {
+	.name		= VSOCK_FAMILY_NAME,
+	.version	= VSOCK_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= vsock_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(vsock_nl_ops),
+};
diff --git a/net/vmw_vsock/vsock_nl_gen.h b/net/vmw_vsock/vsock_nl_gen.h
new file mode 100644
index 000000000000..c041195584a0
--- /dev/null
+++ b/net/vmw_vsock/vsock_nl_gen.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/vsock.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_VSOCK_GEN_H
+#define _LINUX_VSOCK_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/vsock.h>
+
+int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info);
+int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family vsock_nl_family;
+
+#endif /* _LINUX_VSOCK_GEN_H */
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 3eee34e0efcf..f3150b41dd33 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -62,4 +62,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_vsock:=$(call get_hdr_inc,_LINUX_VSOCK_H,vsock.h)
 CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)

-- 
2.53.0-Meta

