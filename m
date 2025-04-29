Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF9275114
	for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897223; cv=none; b=FruXT/9+4TL16jOmrv/Y0ATC3YLw3RrZ7Z4mPNyj7id3ZhA6dTh4sWqWcD8ntZdZkagnfb2tGLdPSu6AXMem+GwsJ+WShmGdcdj3Wd64Xik8p7iXjEtVwzQZWnXOvjB2r8RktpuY+wLbNMJDkC8ZIwp9VHlVHY3MBluzXrpfyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897223; c=relaxed/simple;
	bh=Z68cpH5fxZGeLfS2U33TAcTiBeuN2mj7/zWyxfXYDl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gt8Q2EHOwrBFcjHEjyOkG4VE/MT9ZYr43fsURAnaxFSaz3RpOa1HMFo7vMhCkv6ZhB+szP2PPWj3EIDiWE2MEky4dW6dyBGpIcBtHx6V5dZNqQv+JUXevtzTAFlc7YS1i8ESWr5vCRGnrOWnMIay4LKIRPpcp7Gs3Jj7D1kNnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFzobhNw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFzobhNw"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso8132673a91.0
        for <virtualization@lists.linux.dev>; Mon, 28 Apr 2025 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897220; x=1746502020; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8LoBj5QkNQ61HAUzl5WW8jyz94OzO6sbAtFCnjrTQU=;
        b=vFzobhNw6ujaUgmsGJXJaNhAI7+zQFNDfn0eNi1MwRhJWCBNio9Pnx3m1TSy7Wz2lB
         vYmQBUZxhOv/JfFZW6shSzF1779qABYCpJV59jmmO6bKdVGRkMQIUXazM6Hl8kKS9W6w
         mGNAV43QBqJ9VTPCYmM87i5L3x80YfDnj6r1emEnnf5BRbbznOiu8HfWkckp2A9S8+YW
         h2VXO1TUFNqul3M4Lyo31D7pJwhl3wAvkhc+1yt/7+xdSIxDyUyXKcrxu4QK6XU1L2VN
         DDUQA0RHq0C0GJkewhiVOlgtUvAVDgfhQkk+3To0uO+ysSkWFTWIMtJqpYdw58PTZmCD
         QB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897220; x=1746502020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8LoBj5QkNQ61HAUzl5WW8jyz94OzO6sbAtFCnjrTQU=;
        b=Mg8O8ljK3a9M4xVaTXNu12Lc2c9R+LuotS8A9dHpk5hdqAwxk8vHSm+fMIDGOqutGx
         7u/WwM2V0Z11oevJ4G9MbKZ6sJuo6CS3oZMsqlJfgYGVdq5iKvmqmQnWx+u5/0RTG7dm
         CRkpm+23dKNe7BuGKqvoaXq68LX0tndwwQrj/Nf8IT3eUg0TtuD6gdyB4fpezo991v0Q
         QkD15DrU2bKHbpAoKaw2xsDFs9iGSvO3dvfw+iNqepmNov2fW5xUjmLzi+CxKQs1sL48
         8wOUHEN97KVtXnDq5PRBtAbsPm2IsQ+vsIXmWTD2iA3S05ywuVbUoWgqT42eILeYcQpK
         IDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVblaLplJkhPHWEyG6gsYCrpTTvAR5uuWWnp+KDl2oInbKw8hcGXyC3F1HgaOQJ0U4WwOXk0lWNthzA6Q13w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK6RobloXt8IqskWgu2H6KtCbCHno+tGSMbsIzLHvjTdv+wuNf
	7Gh5oPwFgwh81nqh+v5Ebi+GQ1RmqHCm1tnauc95lbYxdRp9Ql9sIR5e3nzPRBFDtJshnb1Nsrn
	NozW+DHddxPPiWkzJLgTLwg==
X-Google-Smtp-Source: AGHT+IH1lqsX8YSUWmxKt4wH8YxPdTvxLmFAq8QU54Wh5cs1YGokpWg+zAzqbk5N7Wr1gfY0alNdXpMcYe8P+4i2Rw==
X-Received: from pjbsk17.prod.google.com ([2002:a17:90b:2dd1:b0:2ff:4ba2:f3a5])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c09:b0:2ff:64c3:3bd4 with SMTP id 98e67ed59e1d1-30a2159bd80mr2907614a91.31.1745897220307;
 Mon, 28 Apr 2025 20:27:00 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:43 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-8-almasrymina@google.com>
Subject: [PATCH net-next v13 7/9] gve: add netmem TX support to GVE DQO-RDA mode
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

Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
enable netmem TX support in that mode.

Declare support for netmem TX in GVE DQO-RDA mode.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

---

v11:
- Fix whitespace (Harshitha)

v10:
- Move setting dev->netmem_tx to right after priv is initialized
  (Harshitha)

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 3 +++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 446e4b6fd3f17..e1ffbd561fac6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2659,6 +2659,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto abort_with_wq;
 
+	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
+		dev->netmem_tx = true;
+
 	err = register_netdev(dev);
 	if (err)
 		goto abort_with_gve_init;
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 2eba868d80370..a27f1574a7337 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -660,7 +660,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 			goto err;
 
 		dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
-		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
+					  dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
 		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
@@ -1038,8 +1039,9 @@ static void gve_unmap_packet(struct device *dev,
 	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
 			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
 	for (i = 1; i < pkt->num_bufs; i++) {
-		dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
-			       dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE);
+		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
+					    dma_unmap_len(pkt, len[i]),
+					    DMA_TO_DEVICE, 0);
 	}
 	pkt->num_bufs = 0;
 }
-- 
2.49.0.901.g37484f566f-goog

