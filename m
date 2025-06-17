Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412B23B632
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134779; cv=none; b=acIJ92dwxRataIEVTwGvBFMePF0cnMoraskPUcSsdmPEg4LI97rzCcE6nnUa4f9cy9cUnaHNe6daZJnw2Qbqhk6cJyE+W5sDwnJf4OFmoRNljNBaG115tuVoJPgIhsEbU67uX1v8g638syTecUorUArQ7Cn1XfhFnYKMCszNeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134779; c=relaxed/simple;
	bh=7Efr2DcHjMHIkxPORLOyvtBZdxZGWYv5we2eZThllc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tc8SR7wS4Ez7v9k4uxdI4vcJjMxwh+8yabRrvjVLMJVFcTesYZW396sNZ7ECa/xhwQt++zVFsIE8+yBhclKqYjzaMnWc7ceBQdf5GoFI46ZyyF1mS7F3LH/ArkmRP4OZHiWFs087TSJ08uFUBm9G6Ud6YEseKlDG1mt9Bb0FWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ+5rzYv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ+5rzYv"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so4262378a12.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134777; x=1750739577; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ01K2ow09UDDYywMmqZNZsYWpIeR8YfQL254KQmb7E=;
        b=ZZ+5rzYv6V+rf4mnv0KmvKzMg2Y0TVvdAdI1U9ZiGezMUj4MLtm9BPK/8uFXTZNoGF
         iUQX6EuJhoaU0NGhrfZ3gtPhiRtdYGBlyXXcks2st5NpU2WyGEMe6aw90IQ5JYyYGzyj
         2i7XI1QOBzz8AgDKsWnQ7P4mxXjDwJl8u+53vJjO1vrEBinMyF1Y/pPkVB1SqiH7iu+0
         z/KdgFrYHCw17wwnJc4Egb6UxVAaE1aigMGCcBXMnlCzU7Hd3QVL6t36wtCn6gQJmyQL
         VQX6VPV94JlaU7qoloP7pb2RYqWYy4GZtGgRjth1fvtsxgHLy3RKXQj1x8mn5IYgGVYs
         LInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134777; x=1750739577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ01K2ow09UDDYywMmqZNZsYWpIeR8YfQL254KQmb7E=;
        b=chcswjZhiA2TokIN1PpmD1SxGQ1/tAW2G7Ir4f/pllRgI3E75UnASFBiaksyJ3DUSU
         omjFEoDNrc1U8ag1DSAThn3qDfKftwXAcknGCdZJ3K3mT3YAsnyCxHdqZyg/O1AeywSd
         PW4DGs/D1e3p1ocYIrfFvGegQahV+H+SPc/qtwmzgmlVtgyIR9dOQDhYfj/KqDxo0Ksl
         iXFCZqWW4ba1kTegKU3gJWr81XZ5Edf3IUjbkMbRVYoiMB87jXjtZyML1JMemke3jSp/
         GtzJRmcVEvaBLrMxUPznDNHbovq8aHPsxwoQ5jxU4wifFHubjfd/a3q60LepiEfofZdp
         xFKA==
X-Forwarded-Encrypted: i=1; AJvYcCU4RplfJqztGQICy0gbKKJia+Y7TNcOgDGaiuVSZY4oI3i4D1LiDs/rPzdBalmthNX2EZTwULhp1m472DYcgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpZSPVlXxt+VtIiXaHDqCRx9WyQgshs+Aa6/pj0pMKaD9mqINI
	buQuNhogtwTlFL1nfIGB2KUoJdGOaO7RIvG/kXVTRXcVjlLRpbMfxCxa
X-Gm-Gg: ASbGnct+9EcYc3FvvSkpCQytQz7mTNV1ZrpA1TE7cjWam9YLHoTvp1RLxhv/XjK7SRD
	MfQjaHphrgO7zKRv6GBHikGWaheMoCNsD+bzpZEON/K1q/L/0ey4W559WsRMQbyli6SRhL4cgGd
	PhhLc7XdMdK2yx69kqfc/LxWdM7YdsjUyPPI2GIIrLhK1+p3XLIdkvyP1YLwSnA7Qyg3OeL0vNU
	puJ9Gp3MxDCRWQMG0NTL2n0jpC7q3ofPOuLqii8aFolQduy67/qWWOdFgSGnCDoIQWXVnKRbL5p
	/IfPRlI/CSdlzi1JbSV03+l0OYSRiBM05kQHi3px4j8ohYdNnDZlL07PeCs=
X-Google-Smtp-Source: AGHT+IHE/6Vn5YLgKjYSKZNdlfgBKY7zuMuQFBI6H0V1HGZEpIY6C5PiqCL/O1sycxc9EJbkuM+V3g==
X-Received: by 2002:a05:6a20:cd92:b0:215:df62:7d51 with SMTP id adf61e73a8af0-21fbd584d3fmr17784132637.11.1750134776981;
        Mon, 16 Jun 2025 21:32:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a0e7sm7874487a12.16.2025.06.16.21.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:56 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:52 -0700
Subject: [PATCH RFC net-next v4 03/11] vsock: add vsock net ns helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-3-bdd1659c33fb@meta.com>
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

Add helper functions for setting/getting vsock NS modes.  This commit is
in preparation for adding NS support to vsock.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d56e6e135158..e0b9e6732d53 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -256,4 +257,49 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+extern struct net __vsock_global_net;
+static inline struct net *vsock_global_net(void)
+{
+	return &__vsock_global_net;
+}
+
+static inline u8 vsock_net_mode(struct net *net)
+{
+	u8 ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.ns_mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline void vsock_net_set_mode(struct net *net, u8 mode)
+{
+	spin_lock_bh(&net->vsock.lock);
+	net->vsock.ns_mode = mode | VSOCK_NS_MODE_WRITTEN_ONCE;
+	spin_unlock_bh(&net->vsock.lock);
+}
+
+/* Return true if mode has already been written once. Otherwise, return false. */
+static inline bool vsock_net_mode_can_set(struct net *net)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = !(net->vsock.ns_mode & VSOCK_NS_MODE_WRITTEN_ONCE);
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if vsock net mode check passes. Otherwise, return false.
+ *
+ * Read more about modes in comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
+{
+	return net_eq(n1, n2) ||
+	       (vsock_net_mode(n1) & VSOCK_NS_MODE_GLOBAL &&
+		vsock_net_mode(n2) & VSOCK_NS_MODE_GLOBAL);
+}
 #endif /* __AF_VSOCK_H__ */

-- 
2.47.1

