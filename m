Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627A2D3EE1
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066235; cv=none; b=hIctvFz63v8lSWa9D0YQp5hz9P5VbgRuU1KxqXa96wdMYgvAfOo1NNgOJMg9hD8UKyWWbBkugVyxdigLGmt8k19prDDqDnKFOOFxT/1JR1VgizkKDqEE5LIyru1uKrLVynW2ccnkp7slOJaAxRqSXw4w5+H/HsYnS3/HdluAs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066235; c=relaxed/simple;
	bh=Dk9VyxyIvtP0F39UJUil8ovVHs626DJUG8k2vLMbeOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSDOK1hxWXe7MOeNrepWMmby1pnxES4+oUVLNBHt489/XPesJtsMbdC0her+5+7jAEkIGb+XyD6q3bZt9u92uvaVM9IcEWom1DKKCVVv0qQVN0N8iKEFlb6PfW49gDyIayuPjYzsXFkZPkMj25G3gAc82bxnDcrC1Wkdho2W6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIEzkwE1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIEzkwE1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-266fa7a0552so25664835ad.3
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066232; x=1758671032; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDgkQGQUryaMm+zGaxUKsUJp0YtqeKJ83wvvsePh8vI=;
        b=SIEzkwE12VLYmxoOclw4dp2dDBD7Ca+aNG5QzOyiasNIZN+nwMnlcw09ler1+d//uT
         ufnRD8K0B2miEuS1RrtOonfqeofGSmK1RQlG/du4pZWZ9AYr2a38UhMV+JaeUR+9oscc
         7eSaZsZi+6njB7xqXJMFc57Bq1IfQWJal7xeI97dXM4Z2rjtD2/aAP8Bpd5zSnlxR0bw
         sOsjyZHrLpW/6jAyT29sFtsH7KVokGQn24ls7W4kuSTksaZYhRND34RBf0oLQ/Z4G60h
         H5FAV+EeeLPh4huX6bu4ud0rhxRHErLuE4wBcpDOr1cXcNuP2gAC0QcC2dyAVCcRsTE/
         ILjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066232; x=1758671032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDgkQGQUryaMm+zGaxUKsUJp0YtqeKJ83wvvsePh8vI=;
        b=EdY9uBn1wUupyc/Fb7MbsBCE8jEUV9d4yxOlrFBbZa1izSbh3abU1JJZSRi/aIMlvf
         k/mH3t1SXOdh+BzpStbYvYv6K6A/S1x+F0C2zOC9Bk+jNhvkTOW0ySA87s5WpB8mdU5s
         GrwKm414P6NnNHXV5E80LZDsPRjCzyfTXFvrMAnofRrW129pHf36ak+aq/boxIGXED4y
         O7WCdGjKeGLU5hweDQrxkkqpkkJ2VY9yzIH6S3vU+KMsjQJLIwQhN4FpjfX958htKLjf
         905xG5J74NqgQKJ2IOBat+7G2BXwZRjnrj7uZQqgE7CwXHKVdBBqKNdebVmeFsV5vU86
         qXKg==
X-Gm-Message-State: AOJu0YwjNbk5IYWmjaBgzVU/KL9q5nINC58w+NixGsf+W+EIC1P6xd+T
	jmEWCOT5ukZm6UjpT5rui64qYTXU4g/tFWBjFsCA4i9af+Y+5QdxYDXi
X-Gm-Gg: ASbGncu+yey4pSGnO/LRToumxHdxX0O5fV+FBEPEDl42c8PeZK9NaOrdSa+iVxnwtzE
	dIzcugx0KS8UQdL1Dq6C+IsFMK5uaJqldHy/cOD9FfF7IpxvZJyFxSKC0sEfNgLA40FhsNU4XqX
	cadaWlxaFCpgjXXN8lnC6aOVAAzaa2p2b+eHZvgjIfOIzF8yQUgkBpJggQd2tQcFrNLPMvbC9iU
	4g3/vXvMqcETeOVxcqgO6VOiIhQladt8aa4RhXMXnGkM7s6C9eha8Z0TINz9Bmqd9TNgYjLSTGt
	3+7WiNCNjK4WORWsu01OBHE7UQlB9Nrt0b5iq8t/fvVNs/hMBmp9D+mDbKWmLThVv2Gi+0ojeuV
	HOyioqo0Nxiw0J7TqcEKemwOuIniqoPagl5bN5SMMmQ==
X-Google-Smtp-Source: AGHT+IFVbvXLxgO62dbzANopztRHZ7d+Af+r5jTnwntikynxpQfHrSD3pfyEQgBGsXER4rBG1QRrKQ==
X-Received: by 2002:a17:903:120f:b0:265:604c:17e7 with SMTP id d9443c01a7336-26813dfe930mr588135ad.60.1758066232359;
        Tue, 16 Sep 2025 16:43:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm169999425ad.123.2025.09.16.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:45 -0700
Subject: [PATCH net-next v6 1/9] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-1-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
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
 include/net/af_vsock.h      | 55 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 20 +++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47bc35743f22..bc53c67e0926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26634,6 +26634,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..2857e97699de 100644
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
+	enum vsock_net_mode orig_net_mode;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -256,4 +258,57 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
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
+	if (net->vsock.written) {
+		ret = false;
+		goto skip;
+	}
+
+	net->vsock.mode = mode;
+	net->vsock.written = true;
+	ret = true;
+
+skip:
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if vsock_sock passes the mode rules for a given net and
+ * orig_net_mode. Otherwise, return false.
+ *
+ * net is the current net namespace of the object being checked. orig_net_mode
+ * is the mode of net when the object was created.
+ *
+ * orig_net_mode is the mode of arg 'net' at the time of creation for the
+ * object being checked. For example, if searching for a vsock_sock then
+ * orig_net_mode is arg net's mode at the time the vsock_sock was created.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct vsock_sock *vsk, struct net *net,
+					enum vsock_net_mode orig_net_mode)
+{
+	struct net *vsk_net = sock_net(sk_vsock(vsk));
+
+	if (net_eq(vsk_net, net))
+		return true;
+
+	return orig_net_mode == VSOCK_NET_MODE_GLOBAL && vsk->orig_net_mode == VSOCK_NET_MODE_GLOBAL;
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..005c0da4fb62 100644
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
index 000000000000..d4593c0b8dc4
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
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	enum vsock_net_mode mode;
+	bool written;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3

