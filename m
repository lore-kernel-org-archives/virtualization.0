Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30284AF78
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVtuq5Zb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e56d85fa91so3808277b3.2
        for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703108712; x=1703713512; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DyntanP2TiYwqFVgk0wpxjTNS8jI1v6Olu/+yXZqok=;
        b=WVtuq5ZbGsivOiSjoArojZtAxQrNVIWIWu+4+NHXF7WHVwb7/I3AJfWjrAfqShJ9Jf
         nBQ9zjlaEU5fNosXEh4kuI7jHtuRfct/qMjmYgSEkXv7ytkQagBCVBtCiP8JLyCeqSV8
         RXioAe/gb7FxlJyqiXQJIn+t0+/f0FP4VLSHnuNKWyGJkI//9Aud69Jz1TQoqAZtLp8Q
         pV2/tnJZGii4AVzLL2RgOVE0V5rM05g09nQcMtK+HHeQTpy97NmK1A1W8lx3wdRRxAVC
         LecvWItIDF75ZkX2u25c81xpVoaNdToyHmXm1iD830XAfyWr7FRCOPboM+SGm9vz2z2B
         9x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108712; x=1703713512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DyntanP2TiYwqFVgk0wpxjTNS8jI1v6Olu/+yXZqok=;
        b=Fsi7UOLSVApb59vJOpNkbdrCizTUT+hDLcRWFXRdvC9/UIaN06AZFh6KXAG96Oj0Z+
         9n7cMFp5sRs5KH+JHY+jLvGrSN6gLs1+iaqRyg2SMByRInUA1+kd0RAfaOMrEnEzyiej
         8aMNyPCSNToki9ZtM1yWQzWh2jKa3GSO7gb9iZ8jl9ZH1aVukCRHH6xx65B+BYNOZ7zX
         Qh/BE8hnvS+mSZp2TeBf9EhA67fY+ddhY/MuxjxiLEOJbMPlYa2GVx7jgGAxE7HIcOx0
         S7dtJG1wCktjD3HDZX9P7HYb8EYH/BWQY8ioRYB90eZ0rM0wQNns2jNTVp6nJzSJBw4o
         8FgA==
X-Gm-Message-State: AOJu0YyDwdam65L5Aw5ghasv7zr0rgD8jkZGAEXFmdNmvkT3LTmDRF6G
	IiaGupdWb71SX4m/5bMdNdObnimf9JmhWLznWQ==
X-Google-Smtp-Source: AGHT+IEhvRRPXhRIbkUsMDUYI1y9yD6AP93JUuvPEHvk1q4Gg3JVzRIEWkIp64BLMiqACjKB2LfP8ZKyYsRUNNprHQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:13cc:a33:a435:3fe9])
 (user=almasrymina job=sendgmr) by 2002:a25:a28a:0:b0:dbd:b756:983a with SMTP
 id c10-20020a25a28a000000b00dbdb756983amr151334ybi.9.1703108712675; Wed, 20
 Dec 2023 13:45:12 -0800 (PST)
Date: Wed, 20 Dec 2023 13:45:01 -0800
In-Reply-To: <20231220214505.2303297-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220214505.2303297-3-almasrymina@google.com>
Subject: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_ref type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type. Currently parts of the net stack
use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_ref is introduced to abstract the underlying memory type. Currently
it's a no-op abstraction that is always a struct page underneath. In
parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:

- Modify struct netmem from a union of struct page + new types to an opaque
  netmem_ref type.  I went with:

  +typedef void *__bitwise netmem_ref;

  rather than this that Jakub recommended:

  +typedef unsigned long __bitwise netmem_ref;

  Because with the latter the compiler issues warnings to cast NULL to
  netmem_ref. I hope that's ok.

- Add some function docs.

v2:

- Use container_of instead of a type cast (David).
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..edd977326203
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *	Network memory
+ *
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+/**
+ * typedef netmem_ref - a nonexistent type marking a reference to generic
+ * network memory.
+ *
+ * A netmem_ref currently is always a reference to a struct page. This
+ * abstraction is introduced so support for new memory types can be added.
+ *
+ * Use the supplied helpers to obtain the underlying memory pointer and fields.
+ */
+typedef void *__bitwise netmem_ref;
+
+/* This conversion fails (returns NULL) if the netmem_ref is not struct page
+ * backed.
+ *
+ * Currently struct page is the only possible netmem, and this helper never
+ * fails.
+ */
+static inline struct page *netmem_to_page(netmem_ref netmem)
+{
+	return (struct page *)netmem;
+}
+
+/* Converting from page to netmem is always safe, because a page can always be
+ * a netmem.
+ */
+static inline netmem_ref page_to_netmem(struct page *page)
+{
+	return (netmem_ref)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.472.g3155946c3a-goog

