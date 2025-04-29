Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04326FDBA
	for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897211; cv=none; b=AdYMwijzWzwv3SjpWtUiSDxSFapPd/T0tPiIKExsf3YBdfN31q+miD+UMVoyIwIxQyKEc6hz/jgQhRRUaruoRJ/uj15ugguXfEx52PjX7+nUEkkEMR90H/2BeZxjB4uOn1d+qEcLeLBriO4eG6QhhRK4QlUsyoelmvTB0g5Ctfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897211; c=relaxed/simple;
	bh=B5PX9Lf3hHlAc8nT31777G6uaChSicsoUzSQ2m3f7Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZUYEdoRM8og3/f8wzqsLqq6H2d8OAdC4qVWrOGKqJ51HutY3qNL72mUV3/7l4DRpX1GCLGeNzn7wxYtUQn8mA6WGDG7cWIVaPpbGAQfi7crCVQimptaIgLHIkdjKbUtD5tW/SKQFHwrPlCHt49nh5fyVObpK/J6BlfSBkvdg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mieodIK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mieodIK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so5007761a91.1
        for <virtualization@lists.linux.dev>; Mon, 28 Apr 2025 20:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897209; x=1746502009; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpbhZibP6J4Ym1z1HUBlnZxX7S6WzB4+iykVCt9EBk=;
        b=3mieodIK/XsPwiW6qFeX2TnVNCEEx2nQisUfEVHP2/88JNdrwtVuu7fK13MBcKHKzF
         rFL1UUS8Z9SO0A5q6KY9ypj3d4R1f2nzUqcfieV4vB9HYTs334PwxxMcI4jLJSRKqWz4
         Q22aAS3pAuOx2C9ifqYvfclsEZZGSFRLawYeAgjzqJrxCqo4Y2gQHg2RqaSvUrtrSHvv
         +T1FGukSPANn6+ier65PLh1QuRIpRXE6DXH18mll0o+OQSTtpWcKyGZopo/Pz+3zctdG
         oDRcUUiFaWN130kXl/33wTRdjnKPMkFTsJeL5R5ca2r9hCu516kyADgH9vAz6VRmyvXK
         kHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897209; x=1746502009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlpbhZibP6J4Ym1z1HUBlnZxX7S6WzB4+iykVCt9EBk=;
        b=G/L3Hbk5cGOV0udhenl0eILC2eahrh8c3/0sHz/n0jIoLoinDSxnQLI9xmR5mMYFPJ
         ns3YH0hzLFZt8WzbcDotUk+5el49iaDR/SEMx6fmCctHmJsbyjK5tJizH8CoQt9WAgZR
         tRa6W3c4tupuxD5GH/wVo7wA98kBa3A+lCj/Qoew2ab6mJoQvYea2AQgZ8UJl4k/XgHE
         BnldiTO1zjsvRGVvFJ/hc91EAtMonVXwQpkHujBHWn6eTfaRxfwdXsTus1dRa890U9zI
         jy+z6LSsD93FXt6nOm1+xseR12qvw69eQ/rGGHpODxbHDXCLn1uUo6bAUmikoSjQR6h0
         /3PA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFzxQ77lqPDpZ3YF/ph6xpc5nWgPjO6w2btrt4A9HptXd/Xd0LT7xo8K6ePl86x+xa+npKQze4ogL0rRvag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfHn27E7GlNv0s5SBswWH+8r16NT+Wlm4KajuXrNLX8OoGEwU8
	8FIxmhWP7XM6SCh2bboiwm7w9DCthnAy8S1ZNcpbCm7FXymLSgyOt2pl0JqwsR8c1DprdsSiCZE
	gyZ7I28lPXMROB2bCkhti8g==
X-Google-Smtp-Source: AGHT+IFEU4uTolsX1GkreQA/P5In6m7v2jFirSteGRMuvBCJ0OIMbuFpYzKl1Jqa+aOglE1u9mh6TsXJY4aqADZhIg==
X-Received: from pjbsd12.prod.google.com ([2002:a17:90b:514c:b0:301:4260:4d23])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c4:b0:309:fac6:44f9 with SMTP id 98e67ed59e1d1-30a013bcbc8mr14918054a91.31.1745897209158;
 Mon, 28 Apr 2025 20:26:49 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:37 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-2-almasrymina@google.com>
Subject: [PATCH net-next v13 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
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

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v13:
- Fix nit: remove trailing comma at the end of enum (Christoph).

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b42..973fdbcfef38b 100644
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
+	NET_IOV_MAX = ULONG_MAX
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index fe86606b9f304..a07ad38935c86 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -259,6 +259,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
+		niov->type = NET_IOV_IOURING;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d04935..f5c3a7e6dbb7b 100644
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
-- 
2.49.0.901.g37484f566f-goog

