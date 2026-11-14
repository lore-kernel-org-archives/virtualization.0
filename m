Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626452;
	b=saQKOydmnQYA0WUfKBsxgeqEZS5fWpX6Kie9npFys1qA2uexPt9nNTWTmiKNeoZNgPRJ
	 IflQhvuKKJ8fvn8tI3dgLOmHO13AryzZwSjijhSnMjqqbaPZLLDQdr3w/zkiPJKSy/W1H
	 3655fscQQa667AFxjPfdEISoQJ0TV1RmEjsKext3n+T9BmdOcPCfFK/FkjmitX9vR6KFi
	 8cHbq+mLU7zARoj4BXCDhhDjpkqG3Nhk46ikD4oxzhYoMcNxcf9QJQvR8w/IOrH4wFVkM
	 DFyx7GUig2UXcrF/UfYItvGczg9HaoaBoktu67hmRCkylZFEOLMnSrwys9nkXw9hNJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626452;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=HX4xNVLh/KCfTSMXN5aSMiIfKLMvNIdimzbEat6BxVA=;
	b=Lu68N85hzvUeLokR9jPcsLEbvgxkpUeOtGhzW7bnVGuWJdIdXe5FjVks/HVl6SQWFyWJ
	 GrWZZkiPQQf1T5hkTmhDM92hR5+KowXeaUjI0TmBtFGvegUEFl2Hc6E+S7irXpUNhNLJ7
	 Bxc/yzsaKgGU5xerEQ+8dLUhX9KV7aWXLr6QqMMKHFIgux9QJubI2bGJSpZL1MZ33dbdU
	 jBxXaPeVqWvZDzqeNtd9kfTEZPavD1XE/KETkHjwCONvIRJtJHHebXCjm+COiExb87PYa
	 QJKoG6Sj4ZKwhtOHoBtLRQNmMeEr0Cy47ZpUunZi30fIaSycP9vlV0RoUttvzU0qyZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PmIsWyAM;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F49606A8A9
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F49606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PmIsWyAM
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22XeX3157915;
	Fri, 13 Nov 2026 19:20:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=HX4xNVLh/KCfTSMXN5aSMiIfKLMvNIdimzbEa
	t6BxVA=; b=PmIsWyAMQsMNPDS9ap2Ct3zNJCHU//AnLC4m5iixVz/lHLb2xLjRr
	P0BTaffEQ4oUCzVCrPzez3Q2eSoNJjVWoA+SOftnqGNDFXhhY8QV0rrQ7loidBfn
	Heo5WJjUrLf7QA/1rMUhZLxuFmsFr9MfO0bC982nKtGsgUSvni2WR+o8/EotSKKp
	GP9cmskgos66I6f7xCooYDfmQs8irIhgew6gyyvDPx2Z84kgk3zI8cl9H1OqTExs
	5ajnjPj3OBLDY1A5OTFSSf0e24VGoqlQyxUuIfh242G+ZYJpXFwNGnsWchVl5tkG
	EXokkdI373I2LyrY5k/+e0UPAO5ztw3aQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:25 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:24 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:16 -0800
Subject: [PATCH net-next v6 5/8] vsock: add a netlink command to assign the
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
Message-ID: <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
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
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, Eric Dumazet <edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: vyo9aq2-WTlborZBe0fbsu6cl-byoHxN
X-Proofpoint-GUID: vyo9aq2-WTlborZBe0fbsu6cl-byoHxN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX+3HmfiGjqn7m
 MZqAmOA/d0juvFUMJSZa1xXWEn8nI6tAAxPhp8J1GayOhIlHIzAfvWQwUX4kAEzp4rkIePo8WNR
 a4nrXaV96mJt7Yu/ZhmFQWT3OQ0FKn0=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d379 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=sfD3Rtdq9_ZB75tFU9oA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX5uOPspmY5FwC
 5YoJCwq+atlxgNmJfecC52IDrCaczyxl7wJ9HCIlYpWnzIiHxDXk0wlqmtGfNloPyUxPN4Fbenz
 3zOcAt1uhq4NWcyOfdrMYW3Xl4s8hwVG6ZHl1t9jIKpoE/9vUGaFkv93kOg1oA+llDM1W3cNdil
 XBmBiqNASGdYhhqQ3B7Ne4KtpakS3LEsR/1HFPvBqjECndrm4YUDNijt7GU7mVXHk+SxUm/Y940
 CUG01hv2kmJGTP2/A/gp/xnyreqOeC2Qe+TI4IHlwg5AwiBZ0lBPHt9SigdY5j7VP2vIW+mukqI
 s2xkbrm9d6Mhrf1VbtXnZeXO7okg+tVSNwinJ07djlX/CnbclZFw9FdQs2RL4XM0ShGyoPdAUMr
 CwFVmtGc7lTrKp63aTE4l7vYzksxGzNK/U2HqfjEv8q6Zwpfan8RA4FqtOunzAC+otOhDFGAv5q
 bBBH1QUy6X6GzpjIJwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

Namespaces let a host isolate a VM's vsock traffic to a specific
namespace, but in a guest vsock traffic cannot be isolated to a
namespace. The vsock device is hardcoded to global mode and can't be
moved into a local-mode namespace.

Introduce a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET,
which moves the device to the namespace given by the netns-fd or
netns-pid attribute, as rtnetlink and devlink do, or to the namespace
the request was sent from if neither is given.

VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
namespace as an nsid relative to the caller. VSOCK_CMD_DEV_NETNS_SET
only returns the netlink ack.

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
Changes in v6:
- Move vsock_connect_close() to its own patch (Michal)
- Set swept sockets to TCP_CLOSING instead of TCP_CLOSE, as a peer RST
  does: they were established, and vsock_connect() handles TCP_CLOSING
  as such rather than as a failed connect (Sashiko)
- Take the target namespace from optional netns-fd and netns-pid
  attributes of VSOCK_CMD_DEV_NETNS_SET, falling back to the sender's
  namespace, so userspace no longer has to setns() into the target
  (Stephen)

Changes in v5:
- Rename the uapi header to linux/vsock_netlink.h (Stefano)
- Drop the VSOCK_CMD_DEV_NETNS_SET reply and rely on the netlink ack
  (Stefano)
- Keep vsock_register_mutex static, export vsock_cid_lock() and
  vsock_cid_unlock() for vhost_vsock_set_cid() instead (Stefano)
- Replace vsock_g2h_next_unreachable() with a generic
  vsock_next_connected_socket() next to vsock_for_each_connected_socket(),
  which cannot be reused because the sweep takes lock_sock() (Stefano)
- Use rcu_dereference_protected() in vsock_nl_dev_netns_fill(), drop the
  RCU read lock and allocate the nsid with GFP_KERNEL (Stefano)
- Point to the vsock_g2h_assign_mutex comment for the lock ordering in
  vsock_g2h_net_assign() (Stefano)
- Reverse xmas tree in vsock_dev_do_ioctl() (Stefano)
- Set SOCK_DONE and peer_shutdown on swept sockets, so recv() returns EOF
  and send() fails with -EPIPE/-ECONNRESET instead of -ENOTCONN (Sashiko)
- Only move sock->state back to SS_UNCONNECTED in vsock_connect() if it is
  still SS_CONNECTING, via the new vsock_connect_close(), so a socket
  swept while connect() sleeps cannot be connect()ed again and have
  vsk->trans freed under in-flight skbs (Michal)

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
 Documentation/admin-guide/sysctl/net.rst |  43 +++
 Documentation/netlink/specs/vsock.yaml   |  89 ++++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  19 +-
 include/net/af_vsock.h                   |  14 +-
 include/uapi/linux/vsock_netlink.h       |  30 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 507 +++++++++++++++++++++++++++++--
 net/vmw_vsock/vsock_nl_gen.c             |  44 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 11 files changed, 748 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index fe43e8595958..87bde0fe1ccf 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -529,6 +529,49 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
 by the namespace's mode (``global`` or ``local``), which controls how CIDs
 (Context IDs) are allocated and how sockets interact across namespaces.
 
+In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
+to one network namespace at a time. The ``VSOCK_CMD_DEV_NETNS_SET`` command of
+the ``vsock`` netlink family, described in
+Documentation/netlink/specs/vsock.yaml, moves it to a namespace given by fd or
+PID, or else to the namespace the request was sent from. It requires
+``CAP_NET_ADMIN`` in the initial user namespace.
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
index 000000000000..f260ee88b140
--- /dev/null
+++ b/Documentation/netlink/specs/vsock.yaml
@@ -0,0 +1,89 @@
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
+uapi-header: linux/vsock_netlink.h
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
+      -
+        name: netns-fd
+        type: u32
+        doc: |
+          File descriptor of the network namespace to move the guest's vsock
+          device to.
+      -
+        name: netns-pid
+        type: u32
+        doc: |
+          PID of a process in the network namespace to move the guest's vsock
+          device to.
+
+operations:
+  list:
+    -
+      name: dev-netns-set
+      doc: |
+        Set the network namespace of the guest's vsock device.
+
+        The device is moved to the namespace given by netns-fd or netns-pid,
+        or to the namespace the request was sent from if neither is given.
+        It starts out in init_net, and moving it back there is how an
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
+        request:
+          attributes:
+            - netns-fd
+            - netns-pid
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
index 7636ab50d44f..95c8882669bb 100644
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
+F:	include/uapi/linux/vsock_netlink.h
 F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/selftests/vsock/
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 01f8930ca51f..1a03cff56c5a 100644
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
+	vsock_cid_lock();
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
+	vsock_cid_unlock();
+
+	return ret;
 }
 
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 1c38a27fadf2..a35ab9e41bbb 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -9,6 +9,7 @@
 #define __AF_VSOCK_H__
 
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <net/netns/vsock.h>
 #include <net/sock.h>
@@ -190,6 +191,9 @@ struct vsock_transport {
 
 	/* Zero-copy. */
 	bool (*msgzerocopy_allow)(void);
+
+	/* True if the G2H transport honours VSOCK_CMD_DEV_NETNS_SET. */
+	bool netns_assign_allow;
 };
 
 /**** CORE ****/
@@ -236,8 +240,16 @@ void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
-bool vsock_find_cid(unsigned int cid);
+bool vsock_find_cid(struct net *net, unsigned int cid);
+void vsock_cid_lock(void);
+void vsock_cid_unlock(void);
+/* Caller must hold vsock_cid_lock(). */
+bool __vsock_find_cid(struct net *net, unsigned int cid);
 void vsock_linger(struct sock *sk);
+struct net *vsock_g2h_net_get(netns_tracker *tracker);
+bool vsock_g2h_net_eq(const struct net *net);
+bool vsock_g2h_net_reachable(struct net *net);
+bool vsock_maybe_set_connected(struct vsock_sock *vsk);
 
 /**** TAP ****/
 
diff --git a/include/uapi/linux/vsock_netlink.h b/include/uapi/linux/vsock_netlink.h
new file mode 100644
index 000000000000..c7e23d0da17e
--- /dev/null
+++ b/include/uapi/linux/vsock_netlink.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/vsock.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_VSOCK_NETLINK_H
+#define _UAPI_LINUX_VSOCK_NETLINK_H
+
+#define VSOCK_FAMILY_NAME	"vsock"
+#define VSOCK_FAMILY_VERSION	1
+
+enum {
+	VSOCK_A_NETNS_ID = 1,
+	VSOCK_A_NETNS_FD,
+	VSOCK_A_NETNS_PID,
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
+#endif /* _UAPI_LINUX_VSOCK_NETLINK_H */
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
index 37abde1ca26c..d4d88c8cf142 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -130,6 +130,27 @@
  *       a different transport that *does* support local mode. For
  *       example, virtio-vsock may not support local mode, but the socket
  *       may still accept a connection from vhost-vsock which does.
+ *
+ * - A guest has a single vsock device, owned by the guest->host transport.
+ *   The VSOCK_CMD_DEV_NETNS_SET netlink command moves it to a namespace given
+ *   by fd or PID, or else to the one the request was sent from. It starts
+ *   out in init_net. The mode rules then decide who may use it, and which
+ *   namespace packets from the host are delivered to:
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
 
@@ -206,8 +231,21 @@ static const struct vsock_transport *transport_g2h;
 static const struct vsock_transport *transport_dgram;
 /* Transport used for local communication */
 static const struct vsock_transport *transport_local;
+/* Protects transport registration and the g2h device's netns. */
 static DEFINE_MUTEX(vsock_register_mutex);
 
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
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -502,6 +540,37 @@ void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 }
 EXPORT_SYMBOL_GPL(vsock_for_each_connected_socket);
 
+/* Return the next connected socket of @transport that @match accepts, with a
+ * reference held. The scan starts at bucket *@bucket and leaves it where it
+ * stopped, so calling again resumes there. Unlike
+ * vsock_for_each_connected_socket(), the caller acts on the socket after
+ * vsock_table_lock is dropped, so it can take lock_sock().
+ */
+static struct sock *
+vsock_next_connected_socket(const struct vsock_transport *transport,
+			    unsigned int *bucket,
+			    bool (*match)(struct vsock_sock *vsk))
+{
+	struct vsock_sock *vsk;
+
+	spin_lock_bh(&vsock_table_lock);
+
+	for (; *bucket < ARRAY_SIZE(vsock_connected_table); (*bucket)++) {
+		list_for_each_entry(vsk, &vsock_connected_table[*bucket],
+				    connected_table) {
+			if (vsk->transport == transport && match(vsk)) {
+				sock_hold(sk_vsock(vsk));
+				spin_unlock_bh(&vsock_table_lock);
+				return sk_vsock(vsk);
+			}
+		}
+	}
+
+	spin_unlock_bh(&vsock_table_lock);
+
+	return NULL;
+}
+
 void vsock_add_pending(struct sock *listener, struct sock *pending)
 {
 	struct vsock_sock *vlistener;
@@ -553,7 +622,42 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
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
 
@@ -563,11 +667,10 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
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
@@ -626,7 +729,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
+		if (vsock_use_local_transport(sock_net(sk), remote_cid))
 			new_transport = transport_local;
 		else if (remote_cid <= VMADDR_CID_HOST ||
 			 (remote_flags & VMADDR_FLAG_TO_HOST))
@@ -651,6 +754,11 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
@@ -717,21 +825,39 @@ EXPORT_SYMBOL_GPL(vsock_assign_transport);
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
+/* Keep the CIDs checked by __vsock_find_cid() stable: transport registration
+ * and g2h device netns assignment both wait for vsock_cid_unlock().
+ */
+void vsock_cid_lock(void)
 {
-	if (cid == vsock_registered_transport_cid(&transport_g2h))
+	mutex_lock(&vsock_register_mutex);
+}
+EXPORT_SYMBOL_GPL(vsock_cid_lock);
+
+void vsock_cid_unlock(void)
+{
+	mutex_unlock(&vsock_register_mutex);
+}
+EXPORT_SYMBOL_GPL(vsock_cid_unlock);
+
+bool __vsock_find_cid(struct net *net, unsigned int cid)
+{
+	lockdep_assert_held(&vsock_register_mutex);
+
+	if (cid == __vsock_registered_transport_cid(&transport_g2h, net))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -742,8 +868,269 @@ bool vsock_find_cid(unsigned int cid)
 
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
+static bool vsock_g2h_should_reset(struct vsock_sock *vsk)
+{
+	return READ_ONCE(sk_vsock(vsk)->sk_state) != TCP_CLOSE &&
+	       !READ_ONCE(vsk->close_work_scheduled) &&
+	       !vsock_g2h_reachable_sk(vsk);
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
+	/* lock_sock() cannot be taken under vsock_table_lock, so pick the
+	 * sockets one at a time, then recheck each under both locks.
+	 */
+	while ((sk = vsock_next_connected_socket(t, &i,
+						 vsock_g2h_should_reset))) {
+		vsk = vsock_sk(sk);
+
+		lock_sock(sk);
+
+		reset = false;
+		spin_lock_bh(&vsock_table_lock);
+		/* It may have been closed since we dropped the table lock. */
+		if (__vsock_in_connected_table(vsk) && vsk->transport == t &&
+		    vsock_g2h_should_reset(vsk)) {
+			__vsock_remove_connected(vsk);
+			reset = true;
+		}
+		spin_unlock_bh(&vsock_table_lock);
+
+		if (reset) {
+			sock_set_flag(sk, SOCK_DONE);
+			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
+			sk->sk_state = TCP_CLOSING;
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
+	struct net *g2h;
+	bool equal;
+	void *hdr;
+	s32 id;
+
+	g2h = rcu_dereference_protected(vsock_g2h_net,
+					lockdep_is_held(&vsock_register_mutex));
+	equal = net_eq(net, g2h);
+	if (!equal) {
+		if (vsock_net_assignable(transport_g2h) &&
+		    !vsock_net_check_mode(net, g2h))
+			id = NETNSA_NSID_NOT_ASSIGNED;
+		else
+			id = peernet2id_alloc(net, g2h, GFP_KERNEL);
+	}
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
+static int vsock_g2h_net_assign(struct net *net,
+				struct netlink_ext_ack *extack)
+{
+	const struct vsock_transport *t;
+	netns_tracker old_tracker;
+	struct net *old;
+	int ret;
+
+	/* See vsock_g2h_assign_mutex for the lock ordering. */
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
+
+	return ret;
+}
+
 static struct sock *vsock_dequeue_accept(struct sock *listener)
 {
 	struct vsock_sock *vlistener;
@@ -910,7 +1297,8 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	 * like AF_INET prevents binding to a non-local IP address (in most
 	 * cases), we only allow binding to a local CID.
 	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
+	if (addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(sock_net(sk_vsock(vsk)), addr->svm_cid))
 		return -EADDRNOTAVAIL;
 
 	switch (sk->sk_socket->type) {
@@ -2804,6 +3192,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
+	struct net *net;
 	int retval = 0;
 	u32 cid;
 
@@ -2812,11 +3201,14 @@ static long vsock_dev_do_ioctl(struct file *filp,
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
@@ -2857,6 +3249,63 @@ static struct miscdevice vsock_device = {
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
+	struct nlattr *pid_attr = info->attrs[VSOCK_A_NETNS_PID];
+	struct nlattr *fd_attr = info->attrs[VSOCK_A_NETNS_FD];
+	struct net *net;
+	int err;
+
+	if (fd_attr && pid_attr) {
+		NL_SET_ERR_MSG(info->extack,
+			       "netns-fd and netns-pid are mutually exclusive");
+		return -EINVAL;
+	}
+
+	if (fd_attr)
+		net = get_net_ns_by_fd(nla_get_u32(fd_attr));
+	else if (pid_attr)
+		net = get_net_ns_by_pid(nla_get_u32(pid_attr));
+	else
+		net = get_net(genl_info_net(info));
+	if (IS_ERR(net)) {
+		NL_SET_BAD_ATTR(info->extack, fd_attr ?: pid_attr);
+		return PTR_ERR(net);
+	}
+
+	err = vsock_g2h_net_assign(net, info->extack);
+	put_net(net);
+
+	return err;
+}
+
 static int __vsock_net_mode_string(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos,
 				   enum vsock_net_mode mode,
@@ -3072,6 +3521,8 @@ static int __init vsock_init(void)
 
 	vsock_init_tables();
 
+	get_net_track(&init_net, &vsock_g2h_net_tracker, GFP_KERNEL);
+
 	vsock_proto.owner = THIS_MODULE;
 	vsock_device.minor = MISC_DYNAMIC_MINOR;
 	err = misc_register(&vsock_device);
@@ -3098,10 +3549,18 @@ static int __init vsock_init(void)
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
@@ -3109,15 +3568,20 @@ static int __init vsock_init(void)
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
@@ -3184,13 +3648,18 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
 
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
@@ -3199,6 +3668,10 @@ void vsock_core_unregister(const struct vsock_transport *t)
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
index 000000000000..18f3d47e723d
--- /dev/null
+++ b/net/vmw_vsock/vsock_nl_gen.c
@@ -0,0 +1,44 @@
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
+#include <uapi/linux/vsock_netlink.h>
+
+/* VSOCK_CMD_DEV_NETNS_SET - do */
+static const struct nla_policy vsock_dev_netns_set_nl_policy[VSOCK_A_NETNS_PID + 1] = {
+	[VSOCK_A_NETNS_FD] = { .type = NLA_U32, },
+	[VSOCK_A_NETNS_PID] = { .type = NLA_U32, },
+};
+
+/* Ops table for vsock */
+static const struct genl_split_ops vsock_nl_ops[] = {
+	{
+		.cmd		= VSOCK_CMD_DEV_NETNS_SET,
+		.doit		= vsock_nl_dev_netns_set_doit,
+		.policy		= vsock_dev_netns_set_nl_policy,
+		.maxattr	= VSOCK_A_NETNS_PID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
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
index 000000000000..a2fd87344581
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
+#include <uapi/linux/vsock_netlink.h>
+
+int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info);
+int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family vsock_nl_family;
+
+#endif /* _LINUX_VSOCK_GEN_H */
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 3eee34e0efcf..cd1450f1cac0 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -62,4 +62,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_vsock:=$(call get_hdr_inc,_LINUX_VSOCK_NETLINK_H,vsock_netlink.h)
 CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)

-- 
2.53.1-Meta

