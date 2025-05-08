Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211831F8ADB
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665325; cv=none; b=PYxUMVNO0+7SLJKYpRysFwF8guQZjYCUXkrMJKEHMGRumUt4HP68F9vPvDBrgvlNUVccty0RQ+eMeUGlUDYxIBMEKIMy8jRuZ7hgfiVgVlYTzHMCjFzLfqph9yap/W3V6gYPL3rUMouz6nX6bRh7R9kATlvFNfRG9PI1PH7u/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665325; c=relaxed/simple;
	bh=4jUNCNjECA7PPZ4+BZYmFMt31HNjPRlrhkD5S9xqW2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdVYQ0hNZU0SF2jYUUdcoWWqNvg6jK3F5eaTGP2ultVAAw8JMYK3ySb530kXAIawPyEHz990cTI4Y8nDOQRfmmcC+FUdBWHM22gaYWPVK/gdKZ0fXAGmurpeVb1GoVKmWGdiHd0wixy1kvk62UX7proDGhdNI7qfpd7wnYFBkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJ+sr/4Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ+sr/4Z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso584293b3a.3
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746665322; x=1747270122; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJxPiRsv5mC+aacl3ED/DgmDVvwyw3AKvd/EhyAWZPc=;
        b=hJ+sr/4ZnWDaQVchrJuGKyoM8i2+EEj/ZQTBAORAs+5ujvmBZ+F3sK9rpIHawily0Z
         UZ3aeQEhTt1nb0AwOUhpk/omeZ2NnbDr/XHJoo3h2BUnkt4BRn3RqYrxpjAwIr2Ee+Qw
         fnPDwbjIXU3NtlwJUwxZQTU4GuW29CkLSztP3+Z+r2BCKFAvJrwZfh5+u4GtS9x226eG
         DZLEvAMvZDfTZots9lCOVRIxyqmarNzPHXuIEOm91kalJt62CUH/G7OxLG6+qj1HkHAO
         VBVorVLo4pcf4HcmwggTAgyYLpxRrrkDBpHdsTsRIICaThr7f/2gNOs2fpqqTMz6Ss2j
         eSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746665322; x=1747270122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJxPiRsv5mC+aacl3ED/DgmDVvwyw3AKvd/EhyAWZPc=;
        b=uTxVS/D/bp2JvxN7nJBVRPvN05ylEmMtMtl/d4a87aOjvIQTtkvddrzCyiyqJWVDUI
         KhWZsA6pDegry4WdIkeWSrse45bZTPTlwhKp6LpBsRxgrAyv+3p6R3d5WmDSHGTVzhaW
         fc9XBX5Lh4pxLI7pKA1R68vFPWY4oYZdAZSX7TPSckmaJpmteaA2I6BuRAyVzCivzQJu
         g9AljoElvZZdjH+QhS5JdGDIthxH7pXl6gPCuPT4Xv4Ge+9dmYHJH9FSN6gtTmO4JQkB
         XSfvrD68JSBRQkfo5LVpycEWiD3IkkH8n1tuqC6Ru3eAMx5xebEjZS7PB00EFnGHXpUR
         TBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKzjkgjYirnV7Ux48981SfXCWMYw3Ig3yBnDP1h+NqDtCdHvyOXkCwVFrA088xLaLOVx8FKe227nJWAm1wYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMGtgHP/lvw52g7xg84lpbkM+tHKBtUCCCnYUnl1xqRVkN/5oC
	9Mqqv2cuk+VvtcJqHHWG7X9E8865VXVImM0GJdfmjAZ7tichEaI3ZUa4jnOdWQqHz27OUsBPTx2
	jIUDHhNNWBXMdbCyjUeCkUQ==
X-Google-Smtp-Source: AGHT+IGmYWzxLwSxhc9NDnVVhx1fBBq1AAFy1tyJQ33YIyq8DB1qbWkBK1FqlOHE8+uWHo9OMasEeZ9R3Hldh8h8uQ==
X-Received: from pgix5.prod.google.com ([2002:a63:db45:0:b0:b0d:967f:23de])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d04f:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-2148b1133fbmr8296492637.3.1746665322596;
 Wed, 07 May 2025 17:48:42 -0700 (PDT)
Date: Thu,  8 May 2025 00:48:26 +0000
In-Reply-To: <20250508004830.4100853-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250508004830.4100853-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508004830.4100853-7-almasrymina@google.com>
Subject: [PATCH net-next v14 6/9] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Drivers need to make sure not to pass netmem dma-addrs to the
dma-mapping API in order to support netmem TX.

Add helpers and netmem_dma_*() helpers that enables special handling of
netmem dma-addrs that drivers can use.

Document in netmem.rst what drivers need to do to support netmem TX.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v8:
- use spaces instead of tabs (Paolo)

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
index ca8605eb82ffc..c69cc89c958e0 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
+unsigned long:1                     netmem_tx:1;                read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 5014f7cc1398b..02bd7536fc0ca 100644
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
index 7de21ddb54129..b63aded463370 100644
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
index 0321fd952f708..a661820a26c44 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1772,6 +1772,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
+ *	@netmem_tx:	device support netmem_tx.
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2087,6 +2088,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
+		unsigned long		netmem_tx:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
diff --git a/include/net/netmem.h b/include/net/netmem.h
index ecb6b29c93f61..386164fb9c185 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -8,6 +8,7 @@
 #ifndef _NET_NETMEM_H
 #define _NET_NETMEM_H
 
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <net/net_debug.h>
 
@@ -276,4 +277,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
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
2.49.0.987.g0cc8ee98dc-goog

