Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B671E834E
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629543; cv=none; b=eDPktSK10egFwD+gAKtCqCS0L7xN/Tq76J3gHp70Hwcc8mEh4P8Ae8xsCiB9hj2yBpHl55OzEZt7XzF/t7rWIiRfl5CH10Uy8yUgTYeqZoK8ppljWc6bc/g7GXgyFsf6ST/+h1OXdJfvSwkQk3LWunmZBxIGpJETV/KQxWRbXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629543; c=relaxed/simple;
	bh=6zZjhg68/iYJBRB4m3XZfkrP8wJihUvJUf0RzhlSaaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R99kDIRAmGZoozVJ0KB0mqmWd6G+IOxvc1k0uqfaRI1P98b4jo9Otr+HclqFbvspwdWonAVyzqtPdnO230ZUiGwJCJb+Hix8YuyAb7/qyNuvv0no5+QAgJ75nEgyEypksssO8prmCuVt9uZ00xe++rgYNyptegdIhFi4wcexemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNDdVVCI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNDdVVCI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d9d98ea6so15563575ad.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 20:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629540; x=1741234340; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbf1n5nMrGgkEm8OKJmH1KH6YQxHSldVAhZv8jgHSII=;
        b=kNDdVVCIHLZ62xYUnaOtChajFUlFl+Mez0mcK87j/QpItb9Bq6EZ2dMH48kSZxdzmO
         4qTPdy5NDlt2BovnfP0yZaZbEFr6QSiICKUpE/uTqv1CN0WokP0GCjQKXBKMrvqgw685
         P/KgTTFQKcsuk5IQT8MlhJGr9eM4lTHt84vYuF/JIbSbUREMF0mWVQQZG02xtz4ORriP
         018DyaYpDcotAezgPe5jFPn9NQq9dcDbMUArh3ovtMmUl5oeysAco9UQC2I8AAXri4Ek
         7lFBqIsO9sHvRQTapllZG8q9GHiXlHLsaIVDqk/qNxqB/ceUkQcOJXJa9Tjz9caeg3Vu
         njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629540; x=1741234340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbf1n5nMrGgkEm8OKJmH1KH6YQxHSldVAhZv8jgHSII=;
        b=BSCqXbKN6qnZ23BR6sNpN9h+fiUklW99cGeDjq0dumcN8leu+zqA41+Jo8ANurDmh9
         6KII33EF6WuUiRjSEN0AetgPo8uLd394dxjYodedEhp7naC1VB720I1nioEzr32ugPmI
         +z+g3gbE2u9exfvRGmgOB0I/tEmQB/I7b2Pq3yGysr71RjDernRA5GRE1IKKtNVJOUSN
         kSDJJ64zJXbZKsF3QkfelVlX6thsSKiCgdFDjoiG2+Ai0gnXbwv1ITfCDluBFtBmIwvY
         Jm/btU8vW6ttQ4JvZUWCw90qXfy2PN1Z0Zh0aF52uzcsVzfwoJOMNW8gKyhhd110LpUJ
         3oow==
X-Forwarded-Encrypted: i=1; AJvYcCU9+tHV0g1h6M4D4eU+JsOp7PcUu8k5o6g3nXgKMlljc7EvZ9nhqsl4H9f+R63zvdblXtVdUvnkxL6IyPksTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAAf75hTYK9Kagmc/jbJIoSRwicmj0ygwPXiRZZ0R7/+vL0qKf
	yBLebQP+RJTDu7aiwmUjZkakl3N7h13fY6PhqMQsgljpwrWC5gqmw+YVd65axJY0l+dtB95JEQ7
	Hkl+B5/M7NxNpwytzhKiTHg==
X-Google-Smtp-Source: AGHT+IGDKy2giXtpgwmEdeX2eF65rox8vmx9oiPEONB7TDDjKbzKlZJQAqoYxBHtqGROwp8XHqTNhyRilESKagNMkg==
X-Received: from pfbfb34.prod.google.com ([2002:a05:6a00:2da2:b0:730:7485:6b59])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e05:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-734791b7657mr16917355b3a.20.1740629540276;
 Wed, 26 Feb 2025 20:12:20 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:06 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-6-almasrymina@google.com>
Subject: [PATCH net-next v6 5/8] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Drivers need to make sure not to pass netmem dma-addrs to the
dma-mapping API in order to support netmem TX.

Add helpers and netmem_dma_*() helpers that enables special handling of
netmem dma-addrs that drivers can use.

Document in netmem.rst what drivers need to do to support netmem TX.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v5:
- Fix netmet TX documentation (Stan).

v4:
- New patch
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 Documentation/networking/netdev-features.rst  |  5 ++++
 Documentation/networking/netmem.rst           | 23 +++++++++++++++++--
 include/linux/netdevice.h                     |  2 ++
 include/net/netmem.h                          | 20 ++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 15e31ece675f..e3043b033647 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
+unsigned long:1			    netmem_tx:1;	        read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 5014f7cc1398..02bd7536fc0c 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hardware.
 This should be set for devices which duplicate outgoing HSR (High-availability
 Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
 frames in hardware.
+
+* netmem-tx
+
+This should be set for devices which support netmem TX. See
+Documentation/networking/netmem.rst
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 7de21ddb5412..b63aded46337 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -19,8 +19,8 @@ Benefits of Netmem :
 * Simplified Development: Drivers interact with a consistent API,
   regardless of the underlying memory implementation.
 
-Driver Requirements
-===================
+Driver RX Requirements
+======================
 
 1. The driver must support page_pool.
 
@@ -77,3 +77,22 @@ Driver Requirements
    that purpose, but be mindful that some netmem types might have longer
    circulation times, such as when userspace holds a reference in zerocopy
    scenarios.
+
+Driver TX Requirements
+======================
+
+1. The Driver must not pass the netmem dma_addr to any of the dma-mapping APIs
+   directly. This is because netmem dma_addrs may come from a source like
+   dma-buf that is not compatible with the dma-mapping APIs.
+
+   Helpers like netmem_dma_unmap_page_attrs() & netmem_dma_unmap_addr_set()
+   should be used in lieu of dma_unmap_page[_attrs](), dma_unmap_addr_set().
+   The netmem variants will handle netmem dma_addrs correctly regardless of the
+   source, delegating to the dma-mapping APIs when appropriate.
+
+   Not all dma-mapping APIs have netmem equivalents at the moment. If your
+   driver relies on a missing netmem API, feel free to add and propose to
+   netdev@, or reach out to the maintainers and/or almasrymina@google.com for
+   help adding the netmem API.
+
+2. Driver should declare support by setting `netdev->netmem_tx = true`
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a387d456592..22d9621633a0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1753,6 +1753,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
+ *	@netmem_tx:	device support netmem_tx.
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2061,6 +2062,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
+		unsigned long		netmem_tx:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index a2148ffb203d..1fb39ad63290 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,7 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <net/net_debug.h>
 
@@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 void get_netmem(netmem_ref netmem);
 void put_netmem(netmem_ref netmem);
 
+#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
+	do {                                                     \
+		if (!netmem_is_net_iov(NETMEM))                  \
+			dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
+		else                                             \
+			dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
+	} while (0)
+
+static inline void netmem_dma_unmap_page_attrs(struct device *dev,
+					       dma_addr_t addr, size_t size,
+					       enum dma_data_direction dir,
+					       unsigned long attrs)
+{
+	if (!addr)
+		return;
+
+	dma_unmap_page_attrs(dev, addr, size, dir, attrs);
+}
+
 #endif /* _NET_NETMEM_H */
-- 
2.48.1.658.g4767266eb4-goog

