Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FCA3D62
	for <virtualization@lists.linux.dev>; Sun, 17 Dec 2023 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaFxhR+Z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e5bf8a6f06so5703777b3.1
        for <virtualization@lists.linux.dev>; Sun, 17 Dec 2023 00:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702800562; x=1703405362; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjUSNe+bIsKYLrf1i8KK45ElvyWQbESYTUWNmf5dvpE=;
        b=iaFxhR+ZsANbNH2idaM7R+VP0nsoTX6+ibbKmt3S7IzcACKFo48yQtvUS1ey4JryjD
         UoHjovePFkk/suGintzjZz4k37o9WDK9eGVNhMGVXo1RSSsFIYbXK60p/eernxpqwwng
         FOE5Sr9vO06a/AkqmuNUb0xrc3Lyrl05o4+lxwTn1hx0QBJsGoppK8Kc8uZFgkqrgWIm
         e58626T5jMVSIKXB5pJrb4Z6GgIyiUVJMzXwbxrwOtU6X7hOg4O+gAzrKGiyVqm4kONd
         OWus7+3abanWAZVq1gk+Ek32EYmHbL8irhjGir7nrl5oewXLzOakxOTCs+knEQK5vQdc
         zA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800562; x=1703405362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjUSNe+bIsKYLrf1i8KK45ElvyWQbESYTUWNmf5dvpE=;
        b=o3m4+7jEInI3UB87xgSeMC2EtHahO7Uq+FUVNQ2b73cKZ2Hry2pLuUS5DcZBiTWDE3
         OsDOBX8DmCHrSqRUJUQOJNLmPwGgPVvOJUiAainf1kzL4e/v0DCwEr0EyK9OcNdSUodX
         NC67LNLfxPCxeQRB7FuGBZA18RJdLJA+4i5oNRNHU0+EQsC8o4va4xsbzpH28gB36Hkf
         xSi2kuFftW1vUIOvD8iYg3Pe2yCnmcIE/e/zi3YJStz45URPQf7aposk17nYTNZNsCm4
         6gME4v+asLPxoPWDcTBE1+jPZFIE3C/gWF7hcZlmwyb4htLqQlr4vzpT7CDSURFFp/UE
         QG5w==
X-Gm-Message-State: AOJu0YxbY3Qoji4LuC/DgVutfkvb/fVateaehoND0ij6r+bBvcKx+aEv
	MvZk5Ug26XH0q8JJwizaXOog2q6++Jp/KIP5lg==
X-Google-Smtp-Source: AGHT+IEk69ugEQxkS8QhkN2m7ULUqQhtERRZfMer+dPR3UXS3OTGyFS+Wx9Wm+2Kxy1YuSoHcfkw1ezou9Bj9TkSPQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3eb4:e132:f78a:5ba9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:2c83:b0:5e5:d445:d9a9 with
 SMTP id ep3-20020a05690c2c8300b005e5d445d9a9mr237216ywb.3.1702800562290; Sun,
 17 Dec 2023 00:09:22 -0800 (PST)
Date: Sun, 17 Dec 2023 00:09:10 -0800
In-Reply-To: <20231217080913.2025973-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231217080913.2025973-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231217080913.2025973-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/3] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_t type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type from the net stack. Currently parts of
the net stack use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_t is introduced to abstract the underlying memory type. Currently
it's a no-op abstraction that is always a struct page underneath. In
parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:

- Use container_of instead of a type cast (David).
---
 include/net/netmem.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..b60b00216704
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * netmem.h
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ *	Copyright (C) 2023 Google LLC
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+struct netmem {
+	union {
+		struct page page;
+
+		/* Stub to prevent compiler implicitly converting from page*
+		 * to netmem_t* and vice versa.
+		 *
+		 * Other memory type(s) net stack would like to support
+		 * can be added to this union.
+		 */
+		void *addr;
+	};
+};
+
+static inline struct page *netmem_to_page(struct netmem *netmem)
+{
+	return &netmem->page;
+}
+
+static inline struct netmem *page_to_netmem(struct page *page)
+{
+	return container_of(page, struct netmem, page);
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.472.g3155946c3a-goog

