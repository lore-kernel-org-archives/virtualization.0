Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB931ED83
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229667; cv=none; b=o/XcEx0oXd+XjL+FXYeVZszoJ5XasdEtXE9K51ovuUDR2cj4EzyKxMgXf/Hqa745DSgPTgUXkpNCkxFiJEp34z5oHNjKCvwgi/+7QBPQ0w+TSvCCBF4AH5f0ygJ5lwZ/XMskwaHGLu6J+H0vIGrUoKPft1l2KM99yxnthz5J40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229667; c=relaxed/simple;
	bh=26Ucrht91aAIwIXyn98Z2G6zb0Uqo0wULoQ9rseWbpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvVUIXqXYJZ3Lj6qwRaiRROiYz5s2uGWzuMCZ+sg90zM7hY3wNnqnZHaHxmuYUJj6P9gyYjuApj17cVOD9n6nwNJbWJNXGNKN/SbupiWF4/eyNRLGOUmEZIatD/j04T+cODMDv9SVwDPdA1c7WX6r63jsKbxN90Inx56bR+V65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akHS3VO2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akHS3VO2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29568d93e87so5748305ad.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229664; x=1764834464; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rD2STQ1vCewvqhwa6nIY2y5ruJr4z91nYVEqL9bn/Qk=;
        b=akHS3VO2S2XnOe4PM7Kv9PIqO85XGHChr+IWDq36bf1li8x+lJ9B0xBYf1IzsCZbg1
         bMgtLrn/fmD9uPtbl0rL0xBD9vT1lgHBQD5f+RD5mRueLC6pyABWdqoCv5YihLN6HMra
         5rpArtSuIaOv09ss/PBWfBQnH7R1+WmpU+aIzifn1DDc/iD9Rqs2bjkQXaZDT0X4rLds
         iUcsTjE+Rd7XvJwxezNccr1+YVjh2CtgiCkBlxpnRqw1c50A5Qv0nqeEl8njT6N8Sh/d
         gGqKOp8bW723GCTgWGdSp1iGcqos2hTL2ma0lRjemNo/XQF4uYLO/RiMXP+TPNIZ/lnZ
         uAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229664; x=1764834464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rD2STQ1vCewvqhwa6nIY2y5ruJr4z91nYVEqL9bn/Qk=;
        b=agkbCYsZ6eCKfiyxh7tMsJDkSoRBqdKl2g5nzbIYOiFS6niNoeTapvddE5QdzJfH51
         CKafhZ4RXSiRsm04TXSAXF+HahKAuXSmhqqo9q9+7ekKixIeOHS3vmwhNZtzRSV94YoZ
         ey8oKKaVZspB03BBmlM1D7OKsZbu+jHsmwtpgKNBHryuDiOvUB04578+M6eXbxRj4PtN
         9Vi8ku8/ZmsxeFVO5IIknZsVPwBjaqInxJ6ma4U89L8FSyBnD30kxsslMgv+YYNrnJEE
         7P+hGJ7k0IyU1uT40h0cn+6qlKglJquaxH7XtUDiW1WYm0eS5c4RV1o2l4a0rZ6gbEIk
         yPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWE55MACSnwwqnnR6XluIOnrsokvWSnIk11jC8Fz4eM5MpsckD88qZcwl92NHUptnG8HdHJH/raSpMByxa9wA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTLhn4l7K7MOpJ7lc+uTjN7butbb2xw5MzxgcgSElzH/rOhZ7i
	Yyp7jyMIblddKwvIbtEtXUK12OOLPJegwO+zhHsBJnk+nNwKk7ZElF3v
X-Gm-Gg: ASbGncuNAzxiyQh7V890f5SpboN0ozWr9mM2ZaAu9nvx0Itct+lZsE9nEi4GfaklALZ
	pppAj1IpvOfpSKYe2stnNLmYCh4ZagyrO4jO+nqY/e7H4oT7aJjVfo40SrB9YEWEBvA14Bxrceo
	ve8Spw5l6fTco2+/w29a82U4N3tLCeD7TgmKkoCuLDCUihww4f/u6nYK1+rXDM0RZKa7poy2a8H
	E49MMn0M9aGq57lhljXHcFKROjGxjoiOXTgifXxLKVJ8SNNcYgeC7UJSfXGYvuHV8rVIf9hA5fS
	+Bc7vpDfsA/XDzbF4Dyi6UTcX90Z2js/IRM7/e6NU7sTiDRnKShtdxzaZMyFDBx1hWjXtn+bA3n
	T8vwQ85dzhpnD70Du2aBid8dNWKloOxsdb7t64EsBhJkj135G5jOAK/sLwfb1TyUObfa/Hem3aa
	6burj60Ai7jfKrdMXs
X-Google-Smtp-Source: AGHT+IHn8ZHQCrrjN8WYiQwLe7s4AgFxywclEFz4RKnAL0Y6AAFYxABrnxA49xZvkfu8g2UNHoUjMw==
X-Received: by 2002:a17:902:c406:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-29baae4ed2emr111145825ad.7.1764229663889;
        Wed, 26 Nov 2025 23:47:43 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb542a4sm8131685ad.86.2025.11.26.23.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:43 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:30 -0800
Subject: [PATCH net-next v12 01/12] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-1-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

A "net_mode" field is added to vsock_sock to store the mode of the
namespace when the vsock_sock was created. In order to evaluate
namespace mode rules we need to know both a) which namespace the
endpoints are in, and b) what mode that namespace had when the endpoints
were created. This allows us to handle the changing of modes from global
to local *after* a socket has been created by remembering that the mode
was global when the socket was created. If we were to use the current
net's mode instead, then the lookup would fail and the socket would
break.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- change mode_locked to int (Stefano)

Changes in v9:
- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
- remove spin lock in net->vsock (not used anymore)
- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()

Changes in v7:
- clarify vsock_net_check_mode() comments
- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
- remove extraneous explanation of `orig_net_mode`
- rename `written` to `mode_locked`
- rename `vsock_hdr` to `sysctl_hdr`
- change `orig_net_mode` to `net_mode`
- make vsock_net_check_mode() more generic by taking just net pointers
  and modes, instead of a vsock_sock ptr, for reuse by transports
  (e.g., vhost_vsock)

Changes in v6:
- add orig_net_mode to store mode at creation time which will be used to
  avoid breakage when namespace changes mode during socket/VM lifespan

Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 17 +++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..b6ac6720d706 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27105,6 +27105,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..9b5bdd083b6f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -65,6 +66,7 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	enum vsock_net_mode net_mode;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -256,4 +258,46 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	return READ_ONCE(net->vsock.mode);
+}
+
+static inline bool vsock_net_write_mode(struct net *net,
+					enum vsock_net_mode mode)
+{
+	if (xchg(&net->vsock.mode_locked, 1))
+		return false;
+
+	WRITE_ONCE(net->vsock.mode, mode);
+	return true;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * - ns0 and ns1 are the namespaces being checked.
+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
+ *   the vsock objects were created.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0,
+					enum vsock_net_mode mode0,
+					struct net *ns1,
+					enum vsock_net_mode mode1)
+{
+	/* Any vsocks within the same network namespace are always reachable,
+	 * regardless of the mode.
+	 */
+	if (net_eq(ns0, ns1))
+		return true;
+
+	/*
+	 * If the network namespaces differ, vsocks are only reachable if both
+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
+	 */
+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..66d3de1d935f 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/vsock.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -196,6 +197,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_VSOCKETS)
+	struct netns_vsock	vsock;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
new file mode 100644
index 000000000000..c1a5e805949d
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+enum vsock_net_mode {
+	VSOCK_NET_MODE_GLOBAL,
+	VSOCK_NET_MODE_LOCAL,
+};
+
+struct netns_vsock {
+	struct ctl_table_header *sysctl_hdr;
+	enum vsock_net_mode mode;
+	int mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3

