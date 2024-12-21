Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FD7E792
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742301; cv=none; b=OGsrcH9eLgFr7T8QXxn7nPFRikHProFXsaxDFBJCpaWrLv65Z0HNzKqlmujr5PEelZmgRItpcrFtyrs7NKudU3FZrkmD19gDdNaNOevCgB7CA686Zuh/76n76eooHBfnUd3oWFKAwcngMR6WrCoXffnR4gZvmPYYgYp05qcMYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742301; c=relaxed/simple;
	bh=NJYVQtSnFpPYRXXneblkJlgbJV6+0PWgWGqywbwgTRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+VrFFkm0QIlJ7CU3UxlzXlRHqi4ERDBjFl7e3SSwHcR4ZfadZnVnYeZBrX/kJ1MFfigoT+PskqeE+NHhrZCFIaLE3XYnkcpAZv5TLmEgaHXRK89P3gts/wGrcZlUHpKhzF9V7ZyGyqTVa8vnr83DscTzVEAxUP3Or0W1pm4wZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epJOLywW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epJOLywW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725eb1e9139so3332756b3a.1
        for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742299; x=1735347099; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mBSL9yXhBVvFNjspCgCNSWimNpbAGgVhzwIwXbDDa0=;
        b=epJOLywW7FnXWXPpWs0LQZnqLtYxrlyvhpNmM37AaoCdGmzDsVR21qad2wzdAPrG5N
         PInwZhKqwA7h9TQB8sl0gmEbHRjIkY9LhfG4oQRfJbc7DfBzu1kH5xLYr+TTL/aPS02N
         ygE4Tv8KGa++obme5fAWXUmW2596C5SxK1S2Rbar55I8U6HIwj+djKu8WsOKg+X6W2fw
         UUTeFpbskGmMOVlT3SjptM9MaymgmH8HzF4gkvLK1seY7fKA5KSst0Tlgq+sotnXbKuo
         otrM09GZ8nJ5gTg37tcG24fTH5K0KRK2cPyk4E6OCDtHx2XSXlK3vRzBzKwWnlW0w+qH
         q6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742299; x=1735347099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mBSL9yXhBVvFNjspCgCNSWimNpbAGgVhzwIwXbDDa0=;
        b=bgiaNK6LNO6Oh3tq1Z+vlQGnyDBVBVL6iM6UHabMaexZq5wFlCxroFZssbEAo/iLTp
         g8B8AzIpE10GdzwRdEupK9SkjpmM+Edg30hyW5mlOF5wWg25HqbJ2qvj8CkOOrs3vanI
         57MbfBa+UmOA+dpvHrX76gemZ2SsNDvGFFw64lfpqElCz4VNvQd2joFoiFV+NEj+QRtU
         bfgKb4Udr0fgbPrlPO0wC7YC/0Y0HVEH+puYStcmyawG9FmwmHBpkmag1kYT5Nr3tLLA
         mEUurGDyi9DBAXpKhoS2eSwyulcRMcsLVOratDfANZwEXuD/0q5iLLWk30kI26Xf0hH6
         4QzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJVBuIymjOVqLmchHxjdtIV5KiXB8LonGxjJZrWU79Zehs4yEkNN5bWPWafjYVhhIfsOqItA1KxKgV9oaNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj5WH7YZHkZWivkEL1A6npzr/UAoa0Gn3JDE8MYiMzDjntKaFB
	xGc4l5sNWWlcp33zbufiBCl2Djm2+txpDweihT/u5nKey/hZmjvU9Yo/ThG12GLjYMAUg31mM6d
	GKhQWIAMZWapkpGa7Pl/xWg==
X-Google-Smtp-Source: AGHT+IH+J7RzJDe7NhBx4Bevu5yjGUwknofvvj4Inwv5XKnR+LfxDzqBhWN45vaZIqRemQ7zYlgZCpxoSq+gw07sAg==
X-Received: from pfbcj5.prod.google.com ([2002:a05:6a00:2985:b0:725:e2fd:dcf9])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2c86:b0:725:f4c6:6b81 with SMTP id d2e1a72fcca58-72abdd4e7a8mr8624153b3a.2.1734742298900;
 Fri, 20 Dec 2024 16:51:38 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:34 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-4-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 3/5] net: add get_netmem/put_netmem support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
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

---
 include/linux/skbuff_ref.h |  4 ++--
 include/net/netmem.h       |  3 +++
 net/core/devmem.c          | 10 ++++++++++
 net/core/devmem.h          | 11 +++++++++++
 net/core/skbuff.c          | 30 ++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

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
index 1b58faa4f20f..d30f31878a09 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -245,4 +245,7 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+void get_netmem(netmem_ref netmem);
+void put_netmem(netmem_ref netmem);
+
 #endif /* _NET_NETMEM_H */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..f7e06a8cba01 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -322,6 +322,16 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 	}
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_get(niov->owner->binding);
+}
+
+void net_devmem_put_net_iov(struct net_iov *niov)
+{
+	net_devmem_dmabuf_binding_put(niov->owner->binding);
+}
+
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 76099ef9c482..54e30fea80b3 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -119,6 +119,9 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 	__net_devmem_dmabuf_binding_free(binding);
 }
 
+void net_devmem_get_net_iov(struct net_iov *niov);
+void net_devmem_put_net_iov(struct net_iov *niov);
+
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
@@ -126,6 +129,14 @@ void net_devmem_free_dmabuf(struct net_iov *ppiov);
 #else
 struct net_devmem_dmabuf_binding;
 
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
index a441613a1e6c..815245d5c36b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -88,6 +88,7 @@
 #include <linux/textsearch.h>
 
 #include "dev.h"
+#include "devmem.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -7290,3 +7291,32 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
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
2.47.1.613.gc27f4b7a9f-goog

