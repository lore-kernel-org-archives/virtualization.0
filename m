Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6B372B4B
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039916; cv=none; b=aQkyD+gfWpXE6KPtJ77yhxEnn3/iMGVR7ofY2g2CAR0A/dhHGM5OiAF+FpL4WNDbkQ7cDh1YESbK8huBr/FsUptmNyxhYBoVTlPHGh5xDdKYIbjX0JTj6/x3USHo73ShyopbD2GfqvG8bXMc1QrMu759zYn6u6qb+DyEPPQCb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039916; c=relaxed/simple;
	bh=Bnn99i8wdAGOwRGMZsJMp82H2cZoGX8Ko2zwcJ450zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfbhaAOBNN5O7QtkR8uf/rOj9/Gii4vEjZEgDVhvIjNlwMyDeiAXlRctrSchDEXlx4pTzfA9qC40q/61qmzIBaV4STJtKMzpQr6XYTRhQmfcxDRw2YaJtuu03m86Cu96iByUZJTpcqJfIbgwy9tjqel5UG9RyE8RBBnbhJ4K408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV5lM4vI; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV5lM4vI"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-805440319deso2176391a34.2
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039908; x=1790644708; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qooHmNPsO9wsi0saRmI1c1ln7c0iLHMc8ijb018ShDY=;
        b=OV5lM4vI2ajSRUEkyGTl0jXjTxgP+Xorlo/W6qJLnGbSsVEaXk/r48c0P2QPtOAZE8
         35qPW6zWNkTtxgsaL4ehzwMk2PGOBm0dKaEVo1AM3TBJEh/K/VtCOA257ynrL7lqq+T3
         o7nz3+t5q1f2Z5P1IvgOE0EcY3ziF/IJEfBI/IyGaB6jM8oUDdQCV0tN+4LYRgMCyNHQ
         tvIL/ke8Cbuhm2A+bZdnFuIAYsR2ApKhllGB1D0QQyDbrvVLRVLDA+J2sPI1WetY4K8N
         5boRWxqef61jajsNTutXMGfbbiohLe+VSqaQ1WE52Caz6oADntYa22TCaBRMwQHWrAha
         yGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039908; x=1790644708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qooHmNPsO9wsi0saRmI1c1ln7c0iLHMc8ijb018ShDY=;
        b=G5Bx56cIzmHGQspll2GOcM4pSoda3i7S+3AhWRYXJr6rOZSYVc7GjDaa4QRkwe7zPZ
         FN7pdWZVe/I912V62Jv4B3WBvtUIgJ8gy77ui4YcbveBwuBNaDDjNzqCQUd+9Mj9z1TL
         knXZ07hTis80T/h7xF/MT3TuvYHU7rRzkEoMRlbOsC1SAOUXbMrGYBF6dlAmL0fAWfN2
         iXh1EUr+VolQrSqWlUB2bXlEfTlZ8KT3yn5LrR6u+2v0cpca6NHvKIQGgrvNOalqJtDn
         QlpNxd7/KrU+Z6LWwhiJmhY33QEXEbr02lTDnAAPgTQrDeiF0O8cbQylWwe/s5ZmcrrO
         6ZNQ==
X-Gm-Message-State: AFuF++k6jPxIR3jpa+4Lgx8tERhW9dOXEbiWc0mWFnzdQvixU67KU53r
	ih281BsfoEWMz+1lQJyWhGU/Jnc7itmyY1lf5MkeP8F5PyZnOL3LxHgK
X-Gm-Gg: AYBFou2BHAj1u+Wkv4OmbKtzPBqC4ZYWkwIVX1W7nozx8HT2AfRH4e9lo+SA5tFT7NA
	s/EYtO8xrK/KbR8TBV72vw5DzyfpxS1tBR/p5MJT6KlwicCwfhrIUm6fFCkzCRc+hPlMsq9L7dH
	IQaoaFQOLsLJLpADP+dseNf9DUlzlfl7bUuQ94HeG/0+7tthSapups/7y0a9F8UckM/gnlu0hqm
	0oDl0cTnXxlO/m+J2uhZulpS2Tf7YBgGjEIf1Y0P2rANJokS/oIM4fy0TQfx85jFUPaeOiZlGnb
	y5x9dhm0tBcO78ltaxKIHacj5K+KMQYpXsuEx92htfnqesAsnai1Jp2Maqwe6zgEuGMfFkdKc26
	OykH1L3EW0Uyl2Jee0isItyQMvi7VH7A9QRU6ZXpUsaMSr/PXJl9mE6Thr8KCBHxQAPbBwJDSBA
	3W+i3URkBxETPGYWik1eTwMx3lbLisHQFuaEwXZ4GUcS6eN4C66VnUVXtrz5lhoyWi/vs=
X-Received: by 2002:a05:6830:25c2:b0:7f6:7110:1f83 with SMTP id 46e09a7af769-80ddf969756mr13489366a34.4.1790039907909;
        Mon, 21 Sep 2026 18:18:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e5f8c48dsm646578a34.13.2026.09.21.18.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:06 -0700
Subject: [PATCH net-next v2 3/6] vsock: add a netlink command to assign the
 g2h device to a netns
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-3-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Namespaces let a host isolate a VM's vsock traffic to a specific
namespace, but in a guest vsock traffic cannot be isolated to a
namespace. The vsock device is hardcoded to global mode and can't be
moved into a local-mode namespace.

Introduce a vsock generic netlink family whose one command,
VSOCK_CMD_DEV_NETNS_SET, moves the device to the namespace the request
was sent from.

VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
namespace as an nsid relative to the caller.

The command requires CAP_NET_ADMIN in the initial user namespace. A
privileged user wishing to "unassign" the device can move it to the
init_net, which is hardcoded to global mode (so no unassign call is
necessary).

Add a transport flag to indicate support for guest namespacing, so that
transports may opt in/out. A transport that opts out keeps the
reachability rules it had before this command existed.

Sockets are reset when the underlying device moves to a different
namespace, so as to prevent reachability from the previous and now
disallowed namespace.

The device's CID must not be observable from such a namespace either. It
is reached through three paths: IOCTL_VM_SOCKETS_GET_LOCAL_CID reports
it, bind() accepts it because vsock_find_cid() matches it, and connect()
to it selects the loopback transport because vsock_use_local_transport()
compares against it. All three read it through
vsock_registered_transport_cid(), which now takes the namespace asking
and reports VMADDR_CID_ANY for the g2h slot when that namespace cannot
reach the device.

Following the approach of netdevs, the device returns to init_net when
its namespace is removed. Care is taken to not break flows when the
device is inside a global namespace that is being torn down and alive
sockets are in a different global namespace. In this scenario, the
device's netns getter pre-emptively falls back to the init_net (always
global) so that these flows are not disrupted. If init_net ever
supports local-mode in the future, this logic will have to be changed.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 Documentation/admin-guide/sysctl/net.rst |  23 ++
 Documentation/netlink/specs/vsock.yaml   |  68 ++++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |   6 +-
 include/net/af_vsock.h                   |  17 +-
 include/uapi/linux/vsock.h               |  28 +++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 358 +++++++++++++++++++++++++++++--
 net/vmw_vsock/vsock_nl_gen.c             |  36 ++++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 11 files changed, 543 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index fe43e8595958..f2d8e4e84f89 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -529,6 +529,29 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
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
+The device starts out in the initial namespace, so until the command is issued
+nothing has moved and no mode has changed.
+
+Support is transport dependent. A G2H transport that does not implement the
+move refuses the command with ``EOPNOTSUPP``; of the in-tree guest transports
+only virtio-vsock implements it.
+
+Connections made before the move, from a namespace that can no longer reach the
+device, are reset. The device returns to the initial namespace when the
+namespace it was moved to is deleted, so assigning it to the initial namespace
+is how an assignment is undone.
+
 ns_mode
 -------
 
diff --git a/Documentation/netlink/specs/vsock.yaml b/Documentation/netlink/specs/vsock.yaml
new file mode 100644
index 000000000000..a33e02cb6f34
--- /dev/null
+++ b/Documentation/netlink/specs/vsock.yaml
@@ -0,0 +1,68 @@
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
+          NETNSA_NSID_NOT_ASSIGNED when the caller's namespace cannot reach
+          the device under the mode rules, or when no nsid could be
+          allocated for it.
+
+operations:
+  list:
+    -
+      name: dev-netns-set
+      doc: |
+        Set the network namespace of the guest's vsock device, the one owned
+        by the guest-to-host transport.
+
+        The device is moved to the namespace the request was sent from. It
+        starts out in the initial namespace, and moving it back there is how
+        an assignment is undone.
+
+        Support is transport dependent: a guest-to-host transport that does
+        not implement the move refuses the request with EOPNOTSUPP.
+
+        The namespace's mode decides who may then use the device: a global
+        mode namespace shares it with every other global mode namespace,
+        while a local mode namespace reserves it for itself.
+
+        Connections made before the assignment, from a namespace that can no
+        longer reach the device, are reset.
+      attribute-set: vsock
+      flags: [admin-perm]
+      do: {}
+    -
+      name: dev-netns-get
+      doc: |
+        Get the network namespace the guest's vsock device is assigned to.
+
+        The namespace is reported as an nsid relative to the caller, so the
+        attribute is absent when the device is already in the caller's own
+        namespace. A caller whose namespace cannot reach the device is told
+        NETNSA_NSID_NOT_ASSIGNED rather than where the device went.
+      attribute-set: vsock
+      do:
+        reply:
+          attributes:
+            - netns-id
diff --git a/MAINTAINERS b/MAINTAINERS
index df8ab9b82402..e30e6f8d71e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29143,10 +29143,12 @@ M:	Stefano Garzarella <sgarzare@redhat.com>
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
index abed1fbcf66c..badc064964b3 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -828,9 +828,11 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 		return -EINVAL;
 
 	/* Refuse if CID is assigned to the guest->host transport (i.e. nested
-	 * VM), to make the loopback work.
+	 * VM), to make the loopback work. Only when that device is reachable
+	 * from this VM's namespace, which is the same test the guest CID
+	 * collision check below applies.
 	 */
-	if (vsock_find_cid(guest_cid))
+	if (vsock_find_cid(vsock->net, guest_cid))
 		return -EADDRINUSE;
 
 	/* Refuse if CID is already in use */
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 370fcd3ddabc..dbf1a6aa367f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -35,6 +35,8 @@ struct vsock_sock {
 	/* Links for the global tables of bound and connected sockets. */
 	struct list_head bound_table;
 	struct list_head connected_table;
+	/* Protected by vsock_register_mutex. */
+	struct list_head pending_reset;
 	/* Accessed without the socket lock held. This means it can never be
 	 * modified outsided of socket create or destruct.
 	 */
@@ -190,6 +192,16 @@ struct vsock_transport {
 
 	/* Zero-copy. */
 	bool (*msgzerocopy_allow)(void);
+
+	/* True if the G2H transport honours VSOCK_CMD_DEV_NETNS_SET. A
+	 * transport that sets this must also implement reset.
+	 */
+	bool netns_assign_allow;
+
+	/* Send a reset to @vsk's peer. @skb is the packet being replied to, or
+	 * NULL when the reset is not a reply. May sleep.
+	 */
+	int (*reset)(struct vsock_sock *vsk, struct sk_buff *skb);
 };
 
 /**** CORE ****/
@@ -236,8 +248,11 @@ void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
-bool vsock_find_cid(unsigned int cid);
+bool vsock_find_cid(struct net *net, unsigned int cid);
 void vsock_linger(struct sock *sk);
+struct net *vsock_g2h_net_get(void);
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
index 95a435aef512..9938dd501019 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -130,6 +130,24 @@
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
+ *   longer reach the device, are reset.
+ *
+ *   No reference is taken on the assigned namespace. As is done for netdevs,
+ *   the device is moved back to init_net when that namespace is destroyed.
  */
 
 #include <linux/compat.h>
@@ -161,10 +179,14 @@
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
 
@@ -208,6 +230,11 @@ static const struct vsock_transport *transport_dgram;
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
+/* Network namespace of the g2h device. Protected by
+ * vsock_register_mutex/RCU.
+ */
+static struct net __rcu *vsock_g2h_net = RCU_INITIALIZER(&init_net);
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -553,7 +580,37 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
-static bool vsock_use_local_transport(unsigned int remote_cid)
+/* Return true if @t honours namespace assignment. One that does not keeps the
+ * reachability rules it had before VSOCK_CMD_DEV_NETNS_SET existed.
+ */
+static bool vsock_netns_assignable(const struct vsock_transport *t)
+{
+	return t && t->netns_assign_allow && t->reset;
+}
+
+/* Return the CID of the transport in @transport, as seen from @net.
+ *
+ * The g2h device is the one that can move between namespaces, so a @net that
+ * cannot reach it is told VMADDR_CID_ANY: the same answer it would get if no
+ * g2h transport were registered at all.
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
+	if (transport == &transport_g2h && vsock_netns_assignable(*transport) &&
+	    !vsock_g2h_net_reachable(net))
+		return VMADDR_CID_ANY;
+
+	return (*transport)->get_local_cid();
+}
+
+static bool vsock_use_local_transport(struct net *net, unsigned int remote_cid)
 {
 	lockdep_assert_held(&vsock_register_mutex);
 
@@ -564,7 +621,12 @@ static bool vsock_use_local_transport(unsigned int remote_cid)
 		return true;
 
 	if (transport_g2h) {
-		return remote_cid == transport_g2h->get_local_cid();
+		u32 cid = __vsock_registered_transport_cid(&transport_g2h, net);
+
+		/* The device may be unreachable from @net, in which case
+		 * @remote_cid is not the local CID.
+		 */
+		return cid != VMADDR_CID_ANY && remote_cid == cid;
 	} else {
 		return remote_cid == VMADDR_CID_HOST;
 	}
@@ -626,7 +688,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
+		if (vsock_use_local_transport(sock_net(sk), remote_cid))
 			new_transport = transport_local;
 		else if (remote_cid <= VMADDR_CID_HOST ||
 			 (remote_flags & VMADDR_FLAG_TO_HOST))
@@ -654,6 +716,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
+	if (new_transport && new_transport == transport_g2h &&
+	    vsock_netns_assignable(new_transport) &&
+	    !vsock_g2h_net_reachable(sock_net(sk))) {
+		ret = -ENETUNREACH;
+		goto err;
+	}
+
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
@@ -715,21 +784,22 @@ EXPORT_SYMBOL_GPL(vsock_assign_transport);
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
+bool vsock_find_cid(struct net *net, unsigned int cid)
 {
-	if (cid == vsock_registered_transport_cid(&transport_g2h))
+	if (cid == vsock_registered_transport_cid(&transport_g2h, net))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -742,6 +812,173 @@ bool vsock_find_cid(unsigned int cid)
 }
 EXPORT_SYMBOL_GPL(vsock_find_cid);
 
+/* Return the namespace the g2h device is assigned to, with a reference held,
+ * or NULL when that namespace is going away and the init_net cannot stand in
+ * for it.
+ */
+struct net *vsock_g2h_net_get(void)
+{
+	struct net *assigned;
+	struct net *net;
+
+	rcu_read_lock();
+	assigned = rcu_dereference(vsock_g2h_net);
+	net = maybe_get_net(assigned);
+
+	/* !net means the net is about to be destroyed, at which point the g2h
+	 * device will move to the init_net.  If the init_net and the dying net
+	 * are both global mode, we use the init_net as a fallback to avoid
+	 * disrupting global-mode flows. The per-net destructor hook will
+	 * eventually move the g2h device to the init_net anyway.
+	 *
+	 * vsock_net_check_mode() is safe here because 'assigned' is pointing
+	 * to a net that won't be freed until the following rcu grace period.
+	 */
+	if (!net && vsock_net_check_mode(&init_net, assigned))
+		net = get_net(&init_net);
+	rcu_read_unlock();
+
+	return net;
+}
+EXPORT_SYMBOL_GPL(vsock_g2h_net_get);
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
+	if (!vsock_netns_assignable(vsk->transport))
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
+ * and resets it, or @vsk is never added.
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
+/* Reset every connected socket of @t that can no longer reach the g2h device,
+ * and let the transport tell each peer.
+ */
+static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
+{
+	struct vsock_sock *vsk, *tmp;
+	LIST_HEAD(reset_list);
+	struct sock *sk;
+	int i;
+
+	/* The calling context must hold vsock_register_mutex, which serializes
+	 * concurrent netns assignments' use of vsk->pending_reset.
+	 */
+	lockdep_assert_held(&vsock_register_mutex);
+
+	spin_lock_bh(&vsock_table_lock);
+
+	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
+		list_for_each_entry(vsk, &vsock_connected_table[i],
+				    connected_table) {
+			sk = sk_vsock(vsk);
+
+			if (vsk->transport != t ||
+			    sk->sk_state == TCP_CLOSE ||
+			    vsock_g2h_reachable_sk(vsk))
+				continue;
+
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ECONNRESET;
+			sk_error_report(sk);
+
+			sock_hold(sk);
+			list_add_tail(&vsk->pending_reset, &reset_list);
+		}
+	}
+
+	spin_unlock_bh(&vsock_table_lock);
+
+	/* Reset outside of spinlock because the transport may sleep
+	 * (e.g., GFP_KERNEL alloc).
+	 */
+	list_for_each_entry_safe(vsk, tmp, &reset_list, pending_reset) {
+		list_del_init(&vsk->pending_reset);
+		t->reset(vsk, NULL);
+		sock_put(sk_vsock(vsk));
+	}
+}
+
+/* Move the g2h device to @net. Returns -ENODEV if no g2h transport is loaded
+ * and -EOPNOTSUPP if the loaded one cannot be moved.
+ */
+static int vsock_g2h_net_assign(struct net *net)
+{
+	int ret = 0;
+
+	mutex_lock(&vsock_register_mutex);
+	if (!transport_g2h) {
+		ret = -ENODEV;
+	} else if (!vsock_netns_assignable(transport_g2h)) {
+		ret = -EOPNOTSUPP;
+	} else {
+		/* See vsock_maybe_set_connected() comment about synchronizing
+		 * with connecting sockets.
+		 */
+		rcu_assign_pointer(vsock_g2h_net, net);
+		vsock_g2h_reset_unreachable(transport_g2h);
+	}
+	mutex_unlock(&vsock_register_mutex);
+
+	return ret;
+}
+
+/* Move the g2h device back to init_net if it lives in @net, which is about to
+ * be destroyed.
+ */
+/* Runs as .pre_exit: pernet_operations guarantees a synchronize_rcu()
+ * between pre_exit() and exit(), which drains the readers this drops.
+ */
+static void __net_exit vsock_g2h_net_reset(struct net *net)
+{
+	/* Avoid taking the mutex if the namespaces don't match. */
+	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
+		return;
+
+	mutex_lock(&vsock_register_mutex);
+	if (rcu_access_pointer(vsock_g2h_net) == net)
+		rcu_assign_pointer(vsock_g2h_net, &init_net);
+	mutex_unlock(&vsock_register_mutex);
+}
+
 static struct sock *vsock_dequeue_accept(struct sock *listener)
 {
 	struct vsock_sock *vlistener;
@@ -908,7 +1145,8 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	 * like AF_INET prevents binding to a non-local IP address (in most
 	 * cases), we only allow binding to a local CID.
 	 */
-	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
+	if (addr->svm_cid != VMADDR_CID_ANY &&
+	    !vsock_find_cid(sock_net(sk_vsock(vsk)), addr->svm_cid))
 		return -EADDRNOTAVAIL;
 
 	switch (sk->sk_socket->type) {
@@ -967,6 +1205,7 @@ static struct sock *__vsock_create(struct net *net,
 
 	INIT_LIST_HEAD(&vsk->bound_table);
 	INIT_LIST_HEAD(&vsk->connected_table);
+	INIT_LIST_HEAD(&vsk->pending_reset);
 	vsk->listener = NULL;
 	INIT_LIST_HEAD(&vsk->pending_links);
 	INIT_LIST_HEAD(&vsk->accept_queue);
@@ -2760,6 +2999,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
 {
 	u32 __user *p = ptr;
 	int retval = 0;
+	struct net *net;
 	u32 cid;
 
 	switch (cmd) {
@@ -2767,11 +3007,14 @@ static long vsock_dev_do_ioctl(struct file *filp,
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
@@ -2812,6 +3055,81 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
+int vsock_nl_dev_netns_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct net *assigned;
+	struct sk_buff *msg;
+	bool report;
+	void *hdr;
+	s32 id;
+	int err;
+
+	mutex_lock(&vsock_register_mutex);
+	if (!transport_g2h) {
+		mutex_unlock(&vsock_register_mutex);
+		NL_SET_ERR_MSG(info->extack,
+			       "no guest-to-host transport is loaded");
+		return -ENODEV;
+	}
+
+	rcu_read_lock();
+	assigned = rcu_dereference(vsock_g2h_net);
+	report = !net_eq(net, assigned);
+	if (report) {
+		/* Hide the assignment on the same terms the CID is hidden:
+		 * only a transport that honours namespace assignment keeps it
+		 * from a namespace that cannot reach the device.
+		 */
+		if (vsock_netns_assignable(transport_g2h) &&
+		    !vsock_net_check_mode(net, assigned))
+			id = NETNSA_NSID_NOT_ASSIGNED;
+		else
+			id = peernet2id_alloc(net, assigned, GFP_ATOMIC);
+	}
+	rcu_read_unlock();
+	mutex_unlock(&vsock_register_mutex);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_free;
+	}
+
+	if (report && nla_put_s32(msg, VSOCK_A_NETNS_ID, id)) {
+		err = -EMSGSIZE;
+		goto err_cancel;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+err_cancel:
+	genlmsg_cancel(msg, hdr);
+err_free:
+	nlmsg_free(msg);
+	return err;
+}
+
+int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	int err = vsock_g2h_net_assign(genl_info_net(info));
+
+	if (err == -ENODEV)
+		NL_SET_ERR_MSG(info->extack,
+			       "no guest-to-host transport is loaded");
+	else if (err == -EOPNOTSUPP)
+		NL_SET_ERR_MSG(info->extack,
+			       "the loaded guest-to-host transport does not support namespace assignment");
+
+	return err;
+}
+
 static int __vsock_net_mode_string(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos,
 				   enum vsock_net_mode mode,
@@ -3015,6 +3333,7 @@ static __net_exit void vsock_pernet_exit(struct net *net)
 
 static struct pernet_operations vsock_pernet_ops = {
 	.init = vsock_pernet_init,
+	.pre_exit = vsock_g2h_net_reset,
 	.exit = vsock_pernet_exit,
 };
 
@@ -3050,10 +3369,18 @@ static int __init vsock_init(void)
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
@@ -3066,6 +3393,7 @@ static int __init vsock_init(void)
 
 static void __exit vsock_exit(void)
 {
+	genl_unregister_family(&vsock_nl_family);
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
@@ -3141,8 +3469,10 @@ void vsock_core_unregister(const struct vsock_transport *t)
 	if (transport_h2g == t)
 		transport_h2g = NULL;
 
-	if (transport_g2h == t)
+	if (transport_g2h == t) {
 		transport_g2h = NULL;
+		rcu_assign_pointer(vsock_g2h_net, &init_net);
+	}
 
 	if (transport_dgram == t)
 		transport_dgram = NULL;
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
index 1e746e25e2bc..fa51108c43d4 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -55,4 +55,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_vsock:=$(call get_hdr_inc,_LINUX_VSOCK_H,vsock.h)
 CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)

-- 
2.53.0-Meta

