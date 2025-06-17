Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AC23B608
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134777; cv=none; b=e1ilHnGjIWhRv8KGpdVim4ogjCjVrarJXgNA3Y8u5Sr50fv5XV2QcDnyISiRzL4Hn+FdxuU48oTOXzKS7RmC56nQs+ItbYO3pEzXeuFJLkQaduzPvLzwkyIkfOZgzQlUoFo6HeeBxiWmYqz8rfnIdxMWhoPnmoXPFG0gqpzgztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134777; c=relaxed/simple;
	bh=XMTDR15bVq1YCZLijwAIRIhb0QtK2FVowursT7gd180=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IakLTqexC6HGy/1Z/xbrxDRcwToNQ8p/7SDP2AFiYp49f+yDQ3i4EV8FNw3mIYIsr6I8s3chqMJafY5zZllaeWpWk9yvxfeXl5rPz9WedjWkKTzwPrlwdIWGRGZe1kdxzMBXNKPeTJso4bQQRDj53OgMJ6d0b4d4+ikuR/FHKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfynEoTM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfynEoTM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2350b1b9129so36478345ad.0
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134775; x=1750739575; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7GRFjLCtYMBnTd1HWFkFToBtNX7DzGE0tByfQl3zSM=;
        b=RfynEoTMBARp0CQGuKyaYj69I+k4GyfDl39WLmyY7YH8zZuP76QNg3ECNe+L3KVeZ3
         K6I1nZNVggWWmGM943f7gEBuBTOqkPovrcBLbYFcPmOKtC/AVvKL6DSNJN81WQjhOPhK
         kmz/Hee91mYwC1baJ5+SmPYNVv93ZutH0NeFHrlir7tst5GcTnGMt8CuEp+9WGcvsP4+
         kEtyWAIDAap0A1nF44/hg7ZIJWr6B10Mzx3vdRVduh7+ERCvWM4/ocq/MpRE59a7HPaT
         +5SNNHfx6aOCYofGc2+ExPO/hlHlx3cYVahY7ZJh5ituhAtrmbX3MLyx3f8iIb7HEyo0
         1y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134775; x=1750739575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7GRFjLCtYMBnTd1HWFkFToBtNX7DzGE0tByfQl3zSM=;
        b=oClDznPXhQiAKjwi7uYctLK8gTOHDORJtNcICVnOR0nyC1AFbtA93HPYJSMpsBaoZ7
         SdjMoGKuHZVSh4l+IX3tdycNsVyVScf5t/LXQzOSFSpGmpJ59P3mXPMdCqg9sTyhixGg
         iUvcj7fSYwz3/JEQ4NKLyAsmtc2jlEQ3HbY2uDTDGuWf34WtEaEKN3vN5eRQnRwcpT1M
         G9lJe6ZeVnCpCPRWtOMGgeFmNkclLj0ZUUXPE/pzrOwGY038YrCgIko1hTORz+PI2cYc
         Iq0mpVguutWG8k25OyIiIWWScsCr9abFkX0qdmDSVbYKyouiBkFtdMu6+MRoptwmWvxA
         vdlw==
X-Forwarded-Encrypted: i=1; AJvYcCUQjROTo4ji1dEFNld5ACH68FvzOwazuafbLmSFDUygzgchzfTZzeHdXVahTG0YbZ4YVTRDfX2koUxkT8LfFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlQTLeWFEJPPfUqshMARVMZq/klnjMsh4g+iJq4cNtepuRENnk
	WIjbHgZ9452bBj0wRoWtM0b9C0+D8UnGpdu2+pQFQUMmtcpmXHZ+QPGX
X-Gm-Gg: ASbGnctHjYv9F2z0+KUt55DFdml0v7PoCUEqKmVKo9ueXw3FRVGYYEcprnt8L6Bq36V
	NlRGUZzYaKdYJuk+nBdy77dBKOR8JXFC8wAlBF//5dDaM6asdiknj2uewR1fSS+6XXgK+av6FSV
	ug8buor4v7EhuB6DgXB0KHsYAQXXs3wVP4tKUoPgmZy6jHArwyFo63M+Wo5kpqrI9Z6UKeUqUQU
	DUjJ95uEGI4XYDiS4qM4wGWLWcWiGde1lc+ZqQk1Q9moB7FS6HckP0C0lWcqCdrqUOfoy9nfslf
	2QJR0JVDtNmDxzWvh3MztKElfD8gsjXPJ+rLgpXA1SAgVFzPOIRq1TykzU0=
X-Google-Smtp-Source: AGHT+IF23dOLSSVd/bkPFQcDWGiYXTfx0Wmn0PL/ratRnnqT9FQS95X0J9Qb/FnCqL00zJlKlQ2idQ==
X-Received: by 2002:a17:90b:3fcd:b0:312:e445:fdd9 with SMTP id 98e67ed59e1d1-313f1cc51demr19790632a91.10.1750134775296;
        Mon, 16 Jun 2025 21:32:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b826asm9622012a91.3.2025.06.16.21.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:54 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:51 -0700
Subject: [PATCH RFC net-next v4 02/11] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-2-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode necessary and some of the definitions, but does not
integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 MAINTAINERS                 |  1 +
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 507c5ff6f620..bf9015498854 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26149,6 +26149,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
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
index 000000000000..ea14b46ed437
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+// TODO: rename to VSOCK_NET_* ?
+#define VSOCK_NS_MODE_GLOBAL	1
+#define VSOCK_NS_MODE_LOCAL	(1 << 1)
+#define VSOCK_NS_MODE_INVALID	(~0)
+/* VSOCK_NS_MODE_WRITTEN_ONCE indicates "write-once" write has occurred */
+#define VSOCK_NS_MODE_WRITTEN_ONCE	(1 << 7)
+
+struct netns_vsock {
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+	u8 ns_mode;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.1

