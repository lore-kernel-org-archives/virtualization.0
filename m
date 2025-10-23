Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EE34B407
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244089; cv=none; b=q3CYmcOB9M5TK1HM1u0ZbtsWgVlJxaNV4Fk/lGP6LIiQq7i1Jxuwg//39JXR/4GXbg18o9VY7LCwQgx9aXsVdMw/2+r7/ztBLqPDrZ4WBHncEUoPkZSdICgmwaYZylC7TtbPcvKb8LkuYiXeCr1CYN3TRw8LUV4THtk//IC5Ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244089; c=relaxed/simple;
	bh=DiDrb1BokArJE32Lh27GZlJPhGF6a+qvcuLYVDPWq/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/MgIlTYl1knnaqZOYxiwTpf5A1NK1v1Y7V/W0RRbAp5/f4mbSKZsIVEkjJ6Lto6zI/xyYH70IIeNbyVUaMV8BaabLJXbsxTwP9bOH/TGrUti8uj9lmD7QIFm8DSn4z+aE5aP9ELHAyHBvRW4sr0y21u/n+hTh347TWQrdVKESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8RTk4fB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8RTk4fB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso1443892a91.0
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244085; x=1761848885; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFTV345Uxjg8NO2N6HSXl0oNvQ4licLKHdUY0ZmDF6U=;
        b=g8RTk4fBWx52JgpIXiKFwJAaWfDXjkSadvbKNQNghOxhJc7Qj+YVIeWPXycq9r6Dkz
         k/LUSBerjjbWYhEw73MgrYxxdgFideOcYdIBWCy15RqFIr2JZa0Upgxlb+iPcfecx6i3
         kY76rNIxhiblDYtoHIuOMWDiroIIvr8lkpK+3F6vP0t5xL6BmwLGQIaoVlx9lq4ViwSV
         HdUGHYznmd8JxbA5Fq2Au5M/yrAZg3wEyA9lpdZ4avU0X/7211GZiGj7tPFfVnuKCGoW
         h9eFEPtfEHhpGtEG1TAwBQFgGS2JjK8LCc7U1YnrtLevvkPbMBzemyDJOmPaOsEfCfIZ
         ayyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244085; x=1761848885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFTV345Uxjg8NO2N6HSXl0oNvQ4licLKHdUY0ZmDF6U=;
        b=AKizEwhTZrfPA5BYbgVG/9a9Y9cmuhaEdyWS0ofiAiLcNuWoAu7Vh0Wk9kQWA5QS1x
         Fzun43/iRPuok9coXn6+J+u3K/n71cZ491I8hR0XhZNZB8dqYhJMoGIAEuoklqLsZhNL
         UL0S1Q1peK73R/IEmiS1RuYeuF7P8pfNwPoD7Jp8vFl8RsoEcKNwBmgynj84FBEwOAew
         cMSJ2dG2oQeBoCVB1mk1UxQt9IjKzv/yCluhVxlFdo/I2PIxfj99S/tdFQR7z0kZJFIB
         Kpn7S3BRNjiTPwLyxzLyqkJt20zreBbl3t8t8/MVnLHw7Kcc7FwSi03lrcvVxw7M99d7
         7oaQ==
X-Gm-Message-State: AOJu0YxraeYRdpl1XbZqPQRyBGlEgRQYmx7PSbMg4g/Dgj3dLEYs/Ur9
	AkKnmrAsRGC9WRzeg0duM5AX+ogYSZ0CWONHY/HjJ2iN6ypnNnZbFhrP
X-Gm-Gg: ASbGncsK+arrxQs+4MfcHuJzs8GTb1bkqlldrOUBy+8qsamhUnZqUA12PpmVppQvOuH
	9YJZUoQQvFrptfB0bRwPWR2j4Egr8kIUj7/t5AzNXZ4vvwJEMsiTi90r81WoQJQ4vaPfBPgAJTo
	JMNoOpRU/LEae3UhDPBGWp3+cBgvuaJZIvHSbIF4nozfOZNLzbkH2OVgAqj78XB/VQtQokNKhcf
	vROT1jUe2NrPTXlmQ0A97zBnTb/Lr4qHNIL7pzv8n/fxksgzGRvQEF9rjQxp+eoJuupR7zZNA+T
	+E3RbsOwgiaX16q/Lut0h3DnZqfFEYRiuwT0xs79bFptyTvsmU4QSvsw7EXA2xxZzlvLoo0LCnh
	XzM0yUWLSOwspPcC9hbco5nRm6x4hjKpm0zK5NmA4gOPvEhjg8NQcF0co+KS9jS4bh2qLddDsQ1
	QAE04xIYFUwVdA4vusAQ==
X-Google-Smtp-Source: AGHT+IF5gCB8PDbjBmaJRaXuLaNEfiH+8q7bEw4A0Za+n8p2aXh1gbRC1f7GemMYYIIeYwiqsz/RpA==
X-Received: by 2002:a17:90b:35cc:b0:32e:43ae:e7e9 with SMTP id 98e67ed59e1d1-33bcf8ec899mr35313668a91.17.1761244084653;
        Thu, 23 Oct 2025 11:28:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb00500b8sm3093014a91.6.2025.10.23.11.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:40 -0700
Subject: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 include/net/af_vsock.h      | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 20 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea72b3bd2248..dd765bbf79ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27070,6 +27070,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..bce5389ef742 100644
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
@@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	enum vsock_net_mode ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+
+	if (net->vsock.mode_locked) {
+		ret = false;
+		goto skip;
+	}
+
+	net->vsock.mode = mode;
+	net->vsock.mode_locked = true;
+	ret = true;
+
+skip:
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * ns0 and ns1 are the namespaces being checked.
+ * mode0 and mode1 are the vsock namespace modes of ns0 and ns1.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0, enum vsock_net_mode mode0,
+					struct net *ns1, enum vsock_net_mode mode1)
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
index 000000000000..c9a438ad52f2
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,20 @@
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
+	spinlock_t lock;
+
+	/* protected by lock */
+	enum vsock_net_mode mode;
+	bool mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3

