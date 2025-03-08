Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F720E31F
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470053; cv=none; b=LAkBrnOAoiyYrv9xPupkVWwodn64enSPnKjn9xQ7hlBrJrF7ZoJGAbTEOgpx9WQ+6iyoo8NK0t12YZiCe5U1meoqOxqRcDooTbH7W1whU1PVhShoDQpI+rZBptKA3AmtkHT6/g4L1GpLxncfgdH3j1tt1TR9CGwp8E4OZ/8iXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470053; c=relaxed/simple;
	bh=7pQTGJiG+gkCckiu7VrEfaZJUM/GgV9bYtRCfpuAGVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JEuWC7lh+CCmlEWktYecwaeo5PfLihvoDYUmun7K9LBqJMqNv/Z0R58WjA4Gzuh+xSw3BsPMDH8VaWHiyh8SzIDilWR03PWr64TOODHoQ7KlFVGEaXY+n9dGuiDFWsxS2jv8Chk1eu5jFe2kLrJm+AwhEwfdho0486Xnuxs5jWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OG0oMYhy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OG0oMYhy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so3889018a91.2
        for <virtualization@lists.linux.dev>; Sat, 08 Mar 2025 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741470050; x=1742074850; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uazn3Yur7EC+BlkBfnfCt5gd1JcQM6gP6YoaVvOEWgU=;
        b=OG0oMYhynfBJPIzADGxZ7GPFlMxpa38esOQmqqkzxm9JxCyIZNeR1HA3X8LRQVLw6D
         jhc+E7a7Yr/Bu9IldR9BlTTIKcsMtJXJj9c/lyjQlcCyCcjo9HHtVbFJW7qt89hLZFX3
         BLYGublFRYbrtab/lUFlcMtXkruAvonn7Ewg2T8CZ6UWxqPI0QdkW3U/rW4ncSuZBC4s
         sVyT994etWeS+fXKOTtei1/4TpcEaL6qpbYGplDRXczR/Gg0B4Q7UlQxGSNbQVTw9RSM
         zWh0oJcOEKe8rsO87oPPgQocqhyDASw481f3mfcMzOeub1q3Pw+l0vZUOwhPSdwJYtNX
         y+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470050; x=1742074850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uazn3Yur7EC+BlkBfnfCt5gd1JcQM6gP6YoaVvOEWgU=;
        b=pw5OWoFRwaleH7sxOz0wRs2wTVQCMhqN2Z8+JrWdQkCMSwXCwfnpbAX3Axn5KWZnRO
         JXthYzLTXmkIYt74cUfJ9/OVqnMy35Fiu/UlKATI3xA8cQLV+5V55G25baDO6Lk23Tsv
         o9SW80TOD3NQ3cVry8qMCokNsU4CMwTOtOSGFQ6lGvLA1YoFLc13A0k9tZ/O9d7KBxGw
         ByEH4D2OLKJPUqfBB4pFno2Nsbv52dGJy/iseuuwbyWWYnXPUoJeAs67mkOJQc8dhLyS
         P2DhSGjn5+LeO4Lei/BfXWPARcU3ftrZqMD7TpZVdhkB8x/f4aMmbcGthTGzo0qpeNJN
         jkOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3N6Agk+Cetri55Vi3yq34mH674lzvz5NeVI08Gzmtqy7+oHMWiyYkxFP5O+8WZtbdF+Wmp5HX2Od+uO//Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd1CNBCDPF3uVCdkZSKqWxuC4Ewrp8o7L05RH0w5Bp6bZJOAnN
	mnXf5AtHUIasd+tgiMCHwxFRhgSYsz5XgpAIE5Kjx2kvZaQ5ANPfF1ZvkBliYHrqgxL+J6fZ5sW
	JZK77W1yKTzP99K4licNitA==
X-Google-Smtp-Source: AGHT+IGXS8/G04rAqU1dTYOAUKMkFt2IW1nAEIfrdWh+khmoOhCAntkqTN5Oyi6ICyS0xlqCnZiOGrQcYYJWSHl5SA==
X-Received: from pjbse15.prod.google.com ([2002:a17:90b:518f:b0:2fc:201d:6026])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d605:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-2ff7ce61dbcmr12417520a91.6.1741470050325;
 Sat, 08 Mar 2025 13:40:50 -0800 (PST)
Date: Sat,  8 Mar 2025 21:40:38 +0000
In-Reply-To: <20250308214045.1160445-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308214045.1160445-3-almasrymina@google.com>
Subject: [PATCH net-next v7 2/9] net: add get_netmem/put_netmem support
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

v5: https://lore.kernel.org/netdev/20250227041209.2031104-2-almasrymina@google.com/

- Updated to check that the net_iov is devmem before calling
  net_devmem_put_net_iov().

- Jakub requested that callers of __skb_frag_ref()/skb_page_unref be
  inspected to make sure that they generate / anticipate skbs with the
  correct pp_recycle and unreadable setting:

skb_page_unref
==============

- callers that are unreachable for unreadable skbs:

gro_pull_from_frag0, skb_copy_ubufs, __pskb_pull_tail

-  callers that are reachable for unreadable skbs. These would only see rx
   unreadable skbs with pp_recycle set before this patchset and would drop
   a pp ref count. After this patchset they can see tx unreadable skbs
   with no pp attached and no pp_recycle set, and so now they will drop
   a net_iov ref via put_netmem:

__pskb_trim, __pskb_trim_head, skb_release_data, skb_shift

__skb_frag_ref
==============

Before this patchset __skb_frag_ref would not do the right thing if it
saw any unreadable skbs, either with pp_recycle set or not. Because it
unconditionally tries to acquire a page ref, but with RX only support I
can't reproduce calls to __skb_frag_ref even after enabling tc forwarding
to TX.

After this patchset __skb_frag_ref would obtain a page ref equivalent on
dmabuf net_iovs, by obtaining a ref on the binding.

Callers that are unreachable for unreadable skbs:

- veth_xdp_get

Callers that are reachable for unreadable skbs, and from code review they
look specific to the TX path:

- tcp_grow_skb, __skb_zcopy_downgrade_managed, __pskb_copy_fclone,
  pskb_expand_head, skb_zerocopy, skb_split, pksb_carve_inside_header,
  pskb_care_inside_nonlinear, tcp_clone_payload, skb_segment.

Callers that are reachable for unreadable skbs, and from code review they
look reachable in the RX path, although my testing never hit these
paths. These are concerning. Maybe we should put this patch in net and
cc stable? However, no drivers currently enable unreadable netmem, so
fixing this in net-next is fine as well maybe:

- skb_shift, skb_try_coalesce

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
index 16ef53ea713a..e8afe6b654aa 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -277,4 +277,7 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+void get_netmem(netmem_ref netmem);
+void put_netmem(netmem_ref netmem);
+
 #endif /* _NET_NETMEM_H */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 69c160ad3ebd..0cf3d189f06c 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -326,6 +326,16 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
index ab8acb737b93..ee2d1b769c13 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -89,6 +89,7 @@
 #include <linux/textsearch.h>
 
 #include "dev.h"
+#include "devmem.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -7315,3 +7316,32 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 	return false;
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
+
+void get_netmem(netmem_ref netmem)
+{
+	struct net_iov *niov;
+
+	if (netmem_is_net_iov(netmem)) {
+		niov = netmem_to_net_iov(netmem);
+		if (net_is_devmem_iov(niov))
+			net_devmem_get_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+	get_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(get_netmem);
+
+void put_netmem(netmem_ref netmem)
+{
+	struct net_iov *niov;
+
+	if (netmem_is_net_iov(netmem)) {
+		niov = netmem_to_net_iov(netmem);
+		if (net_is_devmem_iov(niov))
+			net_devmem_put_net_iov(netmem_to_net_iov(netmem));
+		return;
+	}
+
+	put_page(netmem_to_page(netmem));
+}
+EXPORT_SYMBOL(put_netmem);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

