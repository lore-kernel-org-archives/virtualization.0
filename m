Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55413C816
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251725; cv=none; b=nemYD8/LLPGy23w6ljpK9R3l6tvd792J+7EeOYqA7zYsStWhCp239CODq6WlNpNcB+bSPnZ8r5ALIC232vfZ0tWrHepMc5uxGZwCbSaHdyYAZo6lIZdtgWi6ZCiqDeke5yiofa2peYM+bd1niupzXeUNTBiEsYlW6C+um2dMkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251725; c=relaxed/simple;
	bh=8hHuafidSvrrDPzN1rK4NrpnqDvHUFeQD0HDJ+fsQGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/097k1B/TptP1nw7c1nMA0Bn45O+yDTdyP3+6SGvrYkwecuFod4t6UWKwq4T5Sg1euZhwmU2p67c0teZ6+XP7vQYjNMr8JDo09GpjqdSyzgk89VGjM0t5lNJCLgi7lDnX/3WDp0iaM8hDPLGa7OG4UTraD06AY8GNSSdBeO0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJY0hyRb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJY0hyRb"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so6261054a91.0
        for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251722; x=1740856522; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmVMF/N+Ap+RHm3V03Y6V9mWFRDB6yMKiDn7IGjBd4k=;
        b=GJY0hyRb4dkMKJZkrhFHLWMkfWPcmfGVgE2QnN5A8CmVTCVvCtTV6kjcgVgI/JtLWo
         1pTqY7j6hAZyp8XAXFs+lLiTIIGhxeXjXHCd1zTSpIWsBw3orgHFm1WwMWzKq4bKPb2G
         +iGMUWsT24ilU50rWZY1slf26ieeN+S384xBSp8lFiiRYnNTdERlNNo6EZ7AVUaY8wJm
         DstbBsscfTi31jUmJTr9vlpZOxVhff0rZiOtqg8FWbNgWdOiCE0zL6a8BCYyEPDOz4xc
         SNUGfISpjqSBppiwXHvLk/9GzfB5tC0JnVjm3eQqrWOMpVPiehb9/MDEz6ABllH2Og6P
         rl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251722; x=1740856522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmVMF/N+Ap+RHm3V03Y6V9mWFRDB6yMKiDn7IGjBd4k=;
        b=qXOOWhr/dLjyqMF+TehrvS0u4nhNNl6rFoV25EwvRJX7ttAHnzw4s86DJ++z0+L4rl
         DKo8VFVP5Sbov5S6KMSD+hsaaoOcWiSoM5MJd+OUQFM6DwTIXN1V9Z7yJbYwCDyOVwmJ
         5HHlnvOOGr3+uIH2AmC8XD4ycMWUkjnGJt/UIbqdZ2o/R5+h6pdnxEDmHGnB6ONt8XRN
         u4HnILxskQSHjtq1UfsLSdifL3fuAcID/yZ6UiBuWVNPDkk1pb1zxyFLBXyAS0eMmwKT
         sqwD+qXniOiaV5Tmp+G+WxMsuyeiYFsdYk5p3nHBZQR3RndEzC2XGY4u6JpeVQsUrawu
         G4yg==
X-Forwarded-Encrypted: i=1; AJvYcCUzjpQJIQT7dgHFTWPW/YbfAHabzYBOiEaPxok2F28a+i3vGPiZLj06q6rrLxLZBMtR/h3dPJEozgCHB3X4IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCWENokj1yXancKDvKFKhyb2n1wOjFyT0vs2kmem4u5lyeIBxB
	8pgk84/O133lhT4DlODDsZB1Xb0sTCaD1aha3ZAoY/GgGOOWZw/HC1xSMv9+5/IV3syArNRiQUo
	kHgchXHxpdJ3lzo4XTlQcyw==
X-Google-Smtp-Source: AGHT+IGZ+vSi+xRAyavOp/pwzu6XPW4bg11KacVipDuoahr0nhZE+inydsp0VRbLkZVbrSzgGryCMtyyW31XCXlgcw==
X-Received: from pgbcz5.prod.google.com ([2002:a05:6a02:2305:b0:ad5:577f:8e58])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a24b:b0:1ea:f941:8d7e with SMTP id adf61e73a8af0-1eef3c893edmr15418728637.13.1740251721805;
 Sat, 22 Feb 2025 11:15:21 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:09 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-2-almasrymina@google.com>
Subject: [PATCH net-next v5 1/9] net: add get_netmem/put_netmem support
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

Currently net_iovs support only pp ref counts, and do not support a
page ref equivalent.

This is fine for the RX path as net_iovs are used exclusively with the
pp and only pp refcounting is needed there. The TX path however does not
use pp ref counts, thus, support for get_page/put_page equivalent is
needed for netmem.

Support get_netmem/put_netmem. Check the type of the netmem before
passing it to page or net_iov specific code to obtain a page ref
equivalent.

For dmabuf net_iovs, we obtain a ref on the underlying binding. This
ensures the entire binding doesn't disappear until all the net_iovs have
been put_netmem'ed. We do not need to track the refcount of individual
dmabuf net_iovs as we don't allocate/free them from a pool similar to
what the buddy allocator does for pages.

This code is written to be extensible by other net_iov implementers.
get_netmem/put_netmem will check the type of the netmem and route it to
the correct helper:

pages -> [get|put]_page()
dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
new net_iovs ->	new helpers

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v2:
- Add comment on top of refcount_t ref explaining the usage in the XT
  path.
- Fix missing definition of net_devmem_dmabuf_binding_put in this patch.

---
 include/linux/skbuff_ref.h |  4 ++--
 include/net/netmem.h       |  3 +++
 net/core/devmem.c          | 10 ++++++++++
 net/core/devmem.h          | 20 ++++++++++++++++++++
 net/core/skbuff.c          | 30 ++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 0f3c58007488..9e49372ef1a0 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -17,7 +17,7 @@
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	get_netmem(skb_frag_netmem(frag));
 }
 
 /**
@@ -40,7 +40,7 @@ static inline void skb_page_unref(netmem_ref netmem, bool recycle)
 	if (recycle && napi_pp_put_page(netmem))
 		return;
 #endif
-	put_page(netmem_to_page(netmem));
+	put_netmem(netmem);
 }
 
 /**
diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b4..a2148ffb203d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -264,4 +264,7 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+void get_netmem(netmem_ref netmem);
+void put_netmem(netmem_ref netmem);
+
 #endif /* _NET_NETMEM_H */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7c6e0b5b6acb..b1aafc66ebb7 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -325,6 +325,16 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return ERR_PTR(err);
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
+}
+
+void net_devmem_put_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_put(net_devmem_iov_binding(niov));
+}
+
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 7fc158d52729..946f2e015746 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -29,6 +29,10 @@ struct net_devmem_dmabuf_binding {
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use.
+	 *
+	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
+	 * reference, making sure that the binding remains alive until all the
+	 * net_iovs are no longer used.
 	 */
 	refcount_t ref;
 
@@ -111,6 +115,9 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	__net_devmem_dmabuf_binding_free(binding);
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov);
+void net_devmem_put_net_iov(struct net_iov *niov);
+
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
@@ -120,6 +127,19 @@ bool net_is_devmem_iov(struct net_iov *niov);
 #else
 struct net_devmem_dmabuf_binding;
 
+static inline void
+net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline void net_devmem_get_net_iov(struct net_iov *niov)
+{
+}
+
+static inline void net_devmem_put_net_iov(struct net_iov *niov)
+{
+}
+
 static inline void
 __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b241c9e6f38..6e853d55a3e8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -89,6 +89,7 @@
 #include <linux/textsearch.h>
 
 #include "dev.h"
+#include "devmem.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -7253,3 +7254,32 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 	return false;
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
+
+void get_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem)) {
+		/* Assume any net_iov is devmem and route it to
+		 * net_devmem_get_net_iov. As new net_iov types are added they
+		 * need to be checked here.
+		 */
+		net_devmem_get_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+	get_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(get_netmem);
+
+void put_netmem(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem)) {
+		/* Assume any net_iov is devmem and route it to
+		 * net_devmem_put_net_iov. As new net_iov types are added they
+		 * need to be checked here.
+		 */
+		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+
+	put_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(put_netmem);
-- 
2.48.1.601.g30ceb7b040-goog

