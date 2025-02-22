Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C522135BF
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251733; cv=none; b=FBS7A0SfbokDUMFzzDKEtvyyIUKuSYQRrBkIc0Q386p9d1jopc9oao/FhRRvua7HFgay8ghLFUmaW7jYbp7UhmJGGSdVYSfys1DG1Y+4gcMLuxktTZ2NeJf7o9yCwhitg4WPKFNTDg1Mp8Si2LH3AQ1AFOpuDJoAoBiYsWsR92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251733; c=relaxed/simple;
	bh=Z8XZh144o1xsxD6YeKrPk1DFMZATUyG50T5LU7nvHVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mGLs7XAkJL6ljTMTq6t+yWHHgi5l13czwg3yNOndVgdVypyGDxNqUfC/YvWtTHDoP362HAvDDoysWpuPV3m1YZQQMBaBAEhUGW9ig0TA5fMeSoRU8+IGjRFUsur+A1SwFiRR/PdDPw1jVnr3hTr5bXuGY5vEJYbOBIorvf99yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpySseGp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpySseGp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e04e67e2so89503635ad.2
        for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251731; x=1740856531; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQstzXvy/+ei25gmEQDC5JMLZS6iH36WD8mnGccBiB0=;
        b=VpySseGpwqkd/H0qXZgs3fQolbGiCMsKOuAB4yM04fu1ImXOYNwctIZt4JrV9GjTEY
         nzgSi1gui3jlBAWb57X3rGyq6MObVgKDIv1L3mzfu2TEkkArBfIeAwivzpZxetR2VYAM
         W0UtnimrB+P4+eHlHK+QV+8CT/yGsYGbbOjKcoB2Nni0c9THHCiBQ/nGpightuHKFglq
         yL7dPU+2yuy//GPlOaDEocBjYjhWrFSGH/qKUuU3arlg232f5jGkxLgYpePfeXtPiBig
         9puG/GhO58iJheEI5uLcRMtz1kjJC4TYUsqR8BsfBG4og4nDCCwNDmcYfIx52tzkjWKi
         p/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251731; x=1740856531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQstzXvy/+ei25gmEQDC5JMLZS6iH36WD8mnGccBiB0=;
        b=uCC9OGqkLFAipnCSuwlSP3EliRccpCqiLaI04lsImj83ZzPxUIBrMBdf0oo4Jo7aFt
         L4pqYtvZPWvGQBP/nE92rUkfqVSPZ5K0d1C8Ip+ltZ4Tc2AnsGXcI78vL4EgdxIry+rL
         znov0pLa7UI5RNJyuki/6XeACF/Ispoq0TPMCC3fP3NhbjII+BKjj8Ljik5jVbXak7gA
         fSsP8O5k25cZESIIIXS+MUSQ5JhFB4cxlBhZe9rv+lnHltKhmGJL6WrkLR3On+mYPBeA
         eDSTjW/9ReMIl2l7sO3Cze0FngJow3dwikM3RAChyoWAIi7lmQyw5hawwiwUzxERhJGO
         +8+g==
X-Forwarded-Encrypted: i=1; AJvYcCU6e/bvtA/8H5YXEZuGqq7NW8gKzkbsLPENpLamgxMJyLseuQdRYDsOVFx8JNlQLKFX3gelZvsTT+vjsL7YsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqOEC11YDHfmCXW7khkxftYzf50iCArQPAVEnwk8qn+ht9a6XG
	HF+J/VwELKJ8kfJYQGN0untR0HGaUassZ4ya6mNPrDpXtVvvuM8iOaXK3mmV89AqM1JWOG7Hv8+
	zNbAonqopBetT45Nzl5LR0A==
X-Google-Smtp-Source: AGHT+IGzohye702pra9xAOfuA8QqfT7yOlA9WIo2DniYe4LBDR8mwbdq2/IMdBRMBotzAJAXvPnQ2LHGT+xy2L2BlA==
X-Received: from ploo10.prod.google.com ([2002:a17:902:e00a:b0:212:4557:e89b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:191:b0:216:4853:4c0b with SMTP id d9443c01a7336-2219ffc491dmr125988365ad.33.1740251730917;
 Sat, 22 Feb 2025 11:15:30 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:14 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-7-almasrymina@google.com>
Subject: [PATCH net-next v5 6/9] net: enable driver support for netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
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
2.48.1.601.g30ceb7b040-goog

