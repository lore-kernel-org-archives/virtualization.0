Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4002227E96
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931756; cv=none; b=JEdlhhsOUpwiXpa7C3aqWL87wmU1yHuRBtnHpT0PQJJ9kuMY/WFwE3EM9cFkGB9gFMEm6qq50LLYr9XUkSbJknl81x/GhlM+waHrPkT8vBp93SSAqT7gLb3FO0gSny94c6I3hCO7Z9yOUhaU0S2dU9lv49jKy3kCUw5O6meIXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931756; c=relaxed/simple;
	bh=fzaYKng0T3Co74hvCTG9udlLkD2OatKkoguf+4LrFwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vfupl/08+SmXR69/O8oSoMQNoheL7CTppGpFgMgR5qxiP1gTTquRR7ZAm1CImH8ltI4wN/pwSEol1A+HEWIpsaPZzigHJrN9ikIPkOSb7jbAgasFogOo12BOslrQ6tJBLRd96KnduIB8V/qgmJhQr5zBwCv0J6HB+zqPIYWg37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPj3dmIy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPj3dmIy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5156fbe79so1271548a12.1
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931753; x=1745536553; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cprBYrTkt8SACAxz6gSxyS+E08xq9L0dSYJ8bsP6wwM=;
        b=CPj3dmIy9ROWQBXxBRJM39JMtf+ffZV4UuFSFCISf0KlCgX3gcDRUaOdeQlYregVDW
         Y1rfo6/lvvv+xtsFiFqupZv0NuZqNtu0gIiXtUyHGZ8DwUvEG7uxASD8PiPNXNYdDAhJ
         CuGpsv1G93opk+oWNLGKZsvHWeiNVOnqAlgChid9SMe+xRx6BF6vc7GwZmAZqDDuqFF1
         9T2ILQM2ZJ5iO+yhyVzZv6FYKLHOA3N4NYWKc5FUu/dJHedKJQqzMzLTtA2ysSWE7XAm
         Gba8VjCFeX6/eis9ZAnbLtYdFdwvFxGt0xswTfZZuUTB8qua3qDwMspkbsYQvf6zjzfH
         /PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931753; x=1745536553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cprBYrTkt8SACAxz6gSxyS+E08xq9L0dSYJ8bsP6wwM=;
        b=ja/wngVt/f8QwSUkKTqS1WswTlgLKBBXiT+ZcyP/yreriDgKeq22L3EQ24jqV6Etbr
         NVoStAZKxbJZkX5L6MX4OzT5VyrkwxRQfcfiPUUtvZ84zLYRYvXazS52VT9wLX3FU5Zr
         zuLXiwZPG1kTuwwQIozy4jfQOAtXKMELy8j2n+vJWNg1uIv7SP5ysND0tRQIzTWJLmOA
         5aQR00VO3zfRrb01u0VyMBfz0D5foAAkh+aU3A0WEtjlEQZ12kd9tCYnYLjfPXkCiCN3
         PFTmW4u8m+rUgK58igDCn5NNumBwgBNlwQ0Zj105aqbeHrugu3XcWvyOVX2kOT0yvB7k
         dJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGgLvCPL3+vuxguEu++9wJxOpH4NxSvDdK172Po7VPECzSxRU9z68cm2LdOUFLrAH31gPHfTilOSAcPQLLaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuFZiTCWOGhAajaWuYeMz5mwRmdmv0nxuUbzqwb0okkdGkk/lQ
	u0sOtHVRozdXA3KYK10BYNE4gsqFPk6YgWaICRM4v5YgYwFn65VOhEM93HTyVaEcwNsBFi5MMMv
	2y3ZamtXcJs3U19J0YrFo3A==
X-Google-Smtp-Source: AGHT+IGYAArMfEgUK1cvPNPaiKS/U4hTByxsO4kPgiPrUcx4/IV0vY60kwNzcMXBVWGgPQm+lAKTsy7vFXuX7h3SlA==
X-Received: from pfbcm18.prod.google.com ([2002:a05:6a00:3392:b0:739:8cd6:c16c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c9:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22c53605049mr8866935ad.39.1744931752991;
 Thu, 17 Apr 2025 16:15:52 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:37 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-7-almasrymina@google.com>
Subject: [PATCH net-next v9 6/9] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
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
index ca8605eb82ff..c69cc89c958e 100644
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
index e6036b82ef4c..4275144a4e34 100644
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
index 1b047cfb9e4f..8a9210e2868d 100644
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
2.49.0.805.g082f7c87e0-goog

