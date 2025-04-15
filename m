Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049ED2C2AA1
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757280; cv=none; b=o2MKiNYDOTiwbV1Wdx2ZYSaXb7yM2TD0aNgwCLbBgpKObOr3uf7c6w6DroKrRP3xBl0mDXecOK6OnkIe2lwSK5oKvjVZnzjxrAmr8RhLldzhYqijR2goRusXXuZ/8E7C02CpuHpwfJEKeg2Jz4D37K9NJacnYft/Ur4Ejcn8pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757280; c=relaxed/simple;
	bh=cQDqckBf0hmDXK4g9ynIco3ZrZkTnIyGRhG/+zQ4Cws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dt7m+CrIaTprd2K2CWVbRGc/aZbsCITovgeyiYqZO5xCnmxSantgrQuE2gSTXGheKmQ8JPnqCZJzCjhoT5/Vr7pYHWiE06iG43A5CpUb1wQROzxChbdxApRZncLuyRBImCr37WM1InLSNax+AR6JbgKVpilxzfQj/zOdSIgq6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFFDEH2O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFFDEH2O"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so5913101a91.2
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744757278; x=1745362078; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMYJ9mghgsGT04ywh+6f5ef6ONFOD7mnlTWJ6KE3E4s=;
        b=XFFDEH2O/tA1sXrfMDTGknlW9ZBOe+lJlmFu+rHACPAN3V4Rk06K/zNFCtiilIC6PK
         ozusINo9QJikRmqxpIE/QihZ9XBQayG8Cw7XWoEUUj7zYOLk5gO9bdmUt8vWFibBVQai
         p+1/RSs8OdVSrCwcT0PU9lqTsLleAmXhtQa/0WG2YQkw4ea2YKZMlGNu26lhTBhTRMHr
         PR5PM6w9mBlnOsp7r9xaIQUcxmPxEWQA0/ANn9+jRPzj2H3uf0P0XiA1OMJSu3wiSmQL
         VNJum1KTTdWyL3g3yHQcUgKr4X684wSn0PoZTdIgzboB5wfWmGGsmGScUPoHFW5KIL4m
         zQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757278; x=1745362078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMYJ9mghgsGT04ywh+6f5ef6ONFOD7mnlTWJ6KE3E4s=;
        b=D2t6DZ5yzViRUCKNweENGO1U+3JPYJxCraeq3nzqzOfd/GtjqE1Pc6p3KjAysBSBpH
         vdCB7rQPUgNjiXIkfujbazJ1oufn+MxWw3gywg+YG7dnFf9gkgT8e3oiBy+Z/HiFwJNE
         Pf8i/XOdzBmgONImLqx64tGIrNlLAc660oXSuhGyRaGDi4pZEbLuphrwThzqw06l5rAe
         kBUd4RGjpn2FX069JUzCp+awXZEgerU+K4dswR6o+7FQDykKYBRspPE1qLeSNg1Idl0F
         nxrqHEC4i4vRoBcIp3yBtHTe4f94bXxrHd9YRFNXAWlRgZNoq/CpswICskCWDC015FwJ
         ITbA==
X-Forwarded-Encrypted: i=1; AJvYcCXTz9ldiUgRJrbuZoqVNxbUqPa5YnmO4TVD0eTACi1rD7qcQSqO5NEguK+rCnodvhbQa5y9pK9ZctTQUkKSXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+ay/pglPIBjeh9vAuRvnukDSdnaTR4VzAfosKR2GrXuxwWoQF
	Xb1S7cUupfXE7VEhH6eaXQSWPqCF9Z2aj0eWhgo3bn+EgnfQ8Kn8DBuCQ2dEUcsnwfnFchQnvXV
	Kw4+ewXZ7Vc0uiE+s4QvaQw==
X-Google-Smtp-Source: AGHT+IGJWEyQPog40oxrMqoGsHI/uR3lYwzFocZD/EUJPpg1Ph4n4p94UxN7V/pG7QlDhDYzCI99CzW4KOsDU+Dcvw==
X-Received: from pjbso12.prod.google.com ([2002:a17:90b:1f8c:b0:2fc:13d6:b4cb])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c8a:b0:308:5273:4dee with SMTP id 98e67ed59e1d1-3085ef200bemr1637324a91.15.1744757278334;
 Tue, 15 Apr 2025 15:47:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 22:47:48 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415224756.152002-1-almasrymina@google.com>
Subject: [PATCH net-next v8 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch


fix iouring

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b4..64af9a288c80 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,8 +20,17 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
+enum net_iov_type {
+	NET_IOV_DMABUF,
+	NET_IOV_IOURING,
+
+	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
+	 */
+	NET_IOV_MAX = ULONG_MAX,
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0f46e0404c04..17a54e74ed5d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -247,6 +247,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
+		niov->type = NET_IOV_IOURING;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..f5c3a7e6dbb7 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,7 +30,7 @@ static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
 {
-	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+	return niov->type == NET_IOV_DMABUF;
 }
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -266,6 +266,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 		for (i = 0; i < owner->area.num_niovs; i++) {
 			niov = &owner->area.niovs[i];
+			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));

base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.49.0.777.g153de2bbd5-goog

