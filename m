Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEE244679
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430556; cv=none; b=HPla9AeMPpZPmjZuuwktGiNwT28vFmpTJdewNVyq89PGkg1denXCf7TtlO+LC6PZd8qXzLOSutaxdWE8xqKXz07TwEMh8ckuPnoVIkT3Bi2byNB+QpaTBmxqwYPR9GOD+vXPPPyMQphqx6ZB5EVyQ3d/ESoYMEm9ewDlbbETnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430556; c=relaxed/simple;
	bh=fx/j12c7X1avNwUI/3xCv2xqKheT5FfFmdObHtz3nVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qu8g7bGTW9A3EMw12UhjUavCcLt+3nH+3XK+Ht8oQkJZiv9lF7dlvOfsQnDkF8w+6C5mCJTW343iCPBEg6e5IHJ9Ghl+5Up1eGPeRLQZITSZZiK0DOeWWdSbqkbOv7HQz/oU6eUpmZ4XFa4S7TB9F5gzujDNj1wEcplETIQP/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6OngZo4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6OngZo4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ffdea3575so34880665ad.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430554; x=1755035354; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx5ceqh/7qvQN6L4QFmi/M9LWu27g5Sp9j8Lv00Y7aY=;
        b=m6OngZo4UwKZt2Wue9Jj7RcEQ86D/pDDr1buSne4DnwNBBhb99+PQWT7PHPTgYordh
         4Z5QxXN5fnWUg+XHSBeAkplP/xG4y98Kh5CjrRkyvKIisihyCIcSAlYTc+/1RxBheMWA
         I52VsK0auJnCQ/MWcdqo3H2kc8ubLkY9Kxfa94DK5w71SCr2y7xx4TvIVa4PY5GqfvOS
         tSbIUyKj8jy0hH6wveNXITnJMWviHWHXkLTSpyK3TQBvgojYLnKPkSAza8WbODbTljIK
         dFgBv5o3FjfxVrkBPlSqhiqyhLZh1f6yNotv5z/PUjtgZAk2TQ8Ea0Y9y+cJueWh57FB
         ewwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430554; x=1755035354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx5ceqh/7qvQN6L4QFmi/M9LWu27g5Sp9j8Lv00Y7aY=;
        b=QUUg1rd4for7EkUJvsRGWJkbhf/HxkVHrF08fmkQzb2S/B9tqtawz4oLF8YNTKv7kb
         4S4Y2ChlgfsBkQiYZ7wOWBluw0q6JKWC1S4v9JCFL1M6EXZhh6QBh99jJyTdjk1nG1jF
         lhD/5Zlv3QRcCuNzdCizHW/wslVY/RT08IEaBCZR+oPg3b9dkXTDJ63wuFKHhluMLLZo
         29N0jtOack8UQvZOfzLMpESfC3GuUGj0J/sGqtlt3AiayD7N2Fyc68zuU0VCSB/ybQgC
         dtzewoR6RN2eREsKu+69k8Z1m/pBoF+ErrSTayA8kmAeNW1TPZoUkQ3fBO4Xn7C5G3qz
         sW9Q==
X-Gm-Message-State: AOJu0YybURv+j8PWxOwv8ZDvVD5w+kbixXdSyQseLVAIlWWcQHBA76v8
	AEdLvEFas3djUWRl5zccrH0/Sy+ybKX6G9OlA8N5ZapTVjRvXuO89Sd7
X-Gm-Gg: ASbGncvNL2EqFx8+5KjCrhwJDP7hXgVap/ySYeGvzpUM1IrzoCmf5jy4GmUdwy04zoH
	KLbqLmFuubSuE7/MFO3Wt41Bgcu1tM0dhaRZsRN3dO+ovFmM1S7ws39NfOlYWPA32KB20VdYxsF
	TsTr9BXDwYxmB/A94+5lT5JnOmW48yc2mpau0u7lU9NvHS7cKJn0oFWJGMHCvCZPDH/a/5T3rKH
	BexZaId8igCb5R46jNv4qJpI6gu+qyxTLTAvidtTLcIjJo2sCwu4AvvQvEL5YYsT/rMnZwmwc6O
	TWLuFHwPwqiYnf/sIddtjhmZcZslvsvgat1JAgLD2xx7Kb/M2QjCIeb6KW5ZjunRqUBCBSNq6Nl
	4krqV6ybWmuq2AwT3GZk=
X-Google-Smtp-Source: AGHT+IEM+7ah9OnFP8VaGRZ5rhV8vXufNMLrUwoiWelHwq+LhOlK9tECYmajZTfLn97xMBqRGxMpVQ==
X-Received: by 2002:a17:902:d4c9:b0:23f:dc56:66e2 with SMTP id d9443c01a7336-242a0b60289mr2909435ad.38.1754430554146;
        Tue, 05 Aug 2025 14:49:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef83f3sm141034935ad.28.2025.08.05.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:09 -0700
Subject: [PATCH RFC net-next v4 01/12] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-1-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
holding the mode necessary and some of the definitions, but does not
integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc1698bc5ae..76905fc1c1d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26208,6 +26208,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..d34bf7dbc69a 100644
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
+	u8 ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.ns_mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline void vsock_net_set_mode(struct net *net, u8 mode)
+{
+	spin_lock_bh(&net->vsock.lock);
+	net->vsock.ns_mode = mode;
+	net->vsock.written = true;
+	spin_unlock_bh(&net->vsock.lock);
+}
+
+/* Return true if mode has already been written once. Otherwise, return false. */
+static inline bool vsock_net_mode_can_set(struct net *net)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = !net->vsock.written;
+	spin_unlock_bh(&net->vsock.lock);
+
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
index 000000000000..0bad4652815c
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+#define VSOCK_NET_MODE_GLOBAL	1
+#define VSOCK_NET_MODE_LOCAL	(1 << 1)
+
+struct netns_vsock {
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	u8 ns_mode;
+	bool written;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3

