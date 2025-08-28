Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3644199920
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341096; cv=none; b=oEB/NAG3xdU4+8bep6c7iDOfYWIAzlmr0nHxO7ara5NESx2cYeMTpob4rmgFYXdpxJVwNW4tYHI+2NFZnywN7QWXYmvgrpBrfkaTerMZvT6F9uFu+mK1USlPle+Z0yH1D1pxYTB42ni9dS0bkgyW/HrVmed743V0eHSnxISIgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341096; c=relaxed/simple;
	bh=z+sr6MdX8qILdTTvivuBLqgcZDE/1O6PGveEjKKmkI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWN4FxwXH+gdFu8MqxQrF1fn9uBQHMHHbiE0yGx48HEOceA3pD3NGuyGqg283QTiKCO4lHTTgwplWQJXA74U7bwTD0XzJR+oim50hB6o3S/xqUhJyQXlTg3SolK8E59r+EC/yIOdA5Lv6mY3lVLzD3xsKxnikKpPrJOBVyBV+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnYesqHa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnYesqHa"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7720c7cc05fso334207b3a.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341094; x=1756945894; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgPhhCZTl4chPUEyREnq+4qsbR5ADg6VFT1FXFFAJKw=;
        b=XnYesqHaF/utk6Mo5fHlsZhQ55pcuuMetSLmF3vwzbCP7SPDsMT5lpeVb39KkpbuGK
         ZFWmnyGiJYgaifllcPTN/G+WkUB1pMH44/otQ0D5EZpOKrMlvbmRarGuJVnzDHspDlcc
         4diI8NpUsUfBlQzY7lVMtjDoOB8eWiPYMn5Y8t4dtQdpWz7QFtRNMSBYKwSkgCOWzeNr
         bn9u7uzBx73lRcfa6oKdDSZCbTJ1NJFwM6aYxDXrexIBU8PIlV1cLx2dIO58e7cxplOH
         dMoM78iKL2CcYxqycEBEBMhwE8F/nOPL+eOmln/XPuDe3gqwj/d1RaKpVgHF0OsGdHUJ
         usqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341094; x=1756945894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgPhhCZTl4chPUEyREnq+4qsbR5ADg6VFT1FXFFAJKw=;
        b=MeSF9ZnsSXYb/ihUr3paMVI1dKVTEo0bZjTHqrNc5qISD+maPnGGykmSZA/48tfBle
         D6L898kFORZMGsNnjc10eZTFsQUt/j0oECdHjqXHuxvQ5Il0WTF3p6+0J/7pZwdWIr48
         V1wdPVYx3e86SN7mUJnKqFS3OPqwCCiPMeISCibs2bLxpGxYbwbJBgcw/GYXE8Oieows
         QfJP1lRwEZXPlk+bTiXzxXiGMNpjgC64TrxhQD1ix7EXpbEJDw+qYLdfS20vG8cLk1kk
         mDb+oCk1SuU6H0dJEbm+NMSa4yJigJKUzSjcaLyxiVkg2BRzLtXB0Acw1LSJ2VScOKYi
         fmWg==
X-Gm-Message-State: AOJu0Yz9BW7idFscTayAtiQTOk1MG/iu5/NWnfe4YigPT95B9Tt9TF0p
	SFDzch12xKIMfBe5K6o532yX1kr+8N+mqNIkx1B8wstb3Yt58nElv2Pz
X-Gm-Gg: ASbGncv2GP3Y+f6wz3KNeaaYFCEsna8ixojFQfT9lPUVj8NQWfDGVvM6wOIC4wvWMFj
	f0mWoD+KQE4GIW9ZDBRtGJOzHqWWowQEWXagyX4nzlhZSOTReHrKzebAryvqUjxcFj1lWjFt0fR
	LPai+bkwEj+qRMgLdlFMmS80qrEEnflc1yWWfhN5q3H+lbifm9+4jsTOrLeIBC4AxQwsdLIXx0X
	/kwkgI2wP7cbMeDsY0YR6b5UxbWOMODVdbNLwitIRtvVAYP+ryWvQfhNUdrq5mylF5xeYEAMlyN
	7dDwkDSWcN3O2e12PVdeTgwPPlVhHcRdrX8OxR/mIx9SZeC1KXmIFVdRE52ecQLdeIXX6kNSVhC
	JV/Dv2QP5Tv20WJzpO1s=
X-Google-Smtp-Source: AGHT+IGASGKslm4YnrVrCyR6nvJ/i2wzlfWuyETjLKTMh0O1Ojw/wh+hTG7OFeKYXpYEcTD89VSvYw==
X-Received: by 2002:a05:6a00:179a:b0:772:65e:4273 with SMTP id d2e1a72fcca58-772065e467dmr5963292b3a.18.1756341093774;
        Wed, 27 Aug 2025 17:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772093cac4bsm2796708b3a.12.2025.08.27.17.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:32 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:29 -0700
Subject: [PATCH net-next v5 1/9] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-1-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
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
Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 20 ++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..deaf7f02ec32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26578,6 +26578,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..5707514c30b6 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -256,4 +257,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline u8 vsock_net_mode(struct net *net)
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
+/* Return true if vsock net mode check passes. Otherwise, return false.
+ *
+ * Read more about modes in comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
+{
+	return net_eq(n1, n2) ||
+	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
+		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
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

