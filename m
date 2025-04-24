Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE91F30BB
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745467399; cv=none; b=Czh+WPj1yIF2lcFJlama/2fhC3PwYcowX4ZTBtFzAXh89OXtu5m8EMAbkNDiA0oiIl9rOXaCle7I85B+O7G35M4st88JDNeOKvyAEiLWcSgxV7c2QxK0TuaaH30dn9A5zpUdhFYt4n1nmeSS8qhutSCDGkXGa8iLNm6zUH8PBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745467399; c=relaxed/simple;
	bh=G/WocB7aC91WXa3o0zsJehcs+v1ffo648SDyxbN0QrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HH0SqyO1+Ai3wnZ5pmcaSWD/my10euI8XeRfYO0YngiwBSgqAnW4HIV+Rh2WPEKFumU/odIoSKia18tZfdHrOlC2e/4PcIlZk3nLsUFFKT4hMiwVvTtuGxOOTUb8aDoe//ogPYtNXeVOCdhodQTv5vFU1Gg2jE4P0koZgXmhZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1aoS7D9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1aoS7D9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso800047a91.2
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 21:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745467397; x=1746072197; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPSgvf3wO98YN/W102VPKsPEBpygUJCFjK6qLw3/I9w=;
        b=L1aoS7D9CRHut67jdnIHxmaCRUNk92n/0AVGGmDTpKB1twZhgaB4K00fNyT5iIS537
         dLtqrYwmgAZ2YFcf3jMJBe7KypZPIUoMtnErmmLyCY7npo8m/l4OvqZDGCNjHBt9cDqc
         UetX+3okEE5fbjPmrrfbPjy6pULD6LA3Gst6ol0qpBePu8vHC8cksDkfMSbAiC7Av1o1
         sMv5NVIrn9xWHYGz9ulRrjy23CoRtvhqrT+PMQUz1AzmnIHKDp3GiyKi51Qia1M1bkGP
         w9P3DJ/EDzUcbrrvMb5jcwF1iJvCXjucQQDChdQw0Bi8by4NpThdtVGpxxKnxEG9DV3U
         4AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745467397; x=1746072197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPSgvf3wO98YN/W102VPKsPEBpygUJCFjK6qLw3/I9w=;
        b=SND/iW5cwuwPIqJeP5gkGgdhTBYm9QWe5rCJJ2dJFHyVi6KRO7tip7ckxQlbzGA+Ro
         do5eZV2/5PvFbsW7umbQLOhEOirhUrxEntYYuewsHoBxkMRVsiTqBAPt0EipQp/NW6Vz
         Z0tRrSghSzaTl1P3TmiuHeXw+HPj+6u6PCj7sAys5ltEMErVPHC8XBoy6uLPOmW0Vfnj
         sw/2fK2XEmrzsScKvwQCtQdAAXkjIQLHdN/ZJ1Nz3HbqRjMMKjGL1ANUnrXV81sOKFvW
         FZTvDiX6/V+jbLk5FNtQurRakEhD5qcRgqVDAtwrWaxTCNlBMZkon18vx6iDNKU+6fcS
         DumA==
X-Forwarded-Encrypted: i=1; AJvYcCVR2qdO3fISD3PBhB53x5lamt0nZREFURWkEsXO8JqJdNB0/18LqUF3UUVGRhdQkYjE2nM/jg3g/9Eas7R8PA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6TWUfTifV9/lfVjxN6/9e3GB8/MlBokKc0jzkQBVXdVEHTBMy
	q+3JVAXiFKymx5xEFmBAksCOwKgp9U/7W6MmVQyiX9NTepWCBLlABeElysrtNq9ew7DAycSzMyF
	wo4IMNndGK18Ic7n7pu7ZYw==
X-Google-Smtp-Source: AGHT+IHGiGawAQJXdYMac6t0R9ZXFSXnUAt0bqsviOtJQgSYLeN5QUXxoG5Rxjv5VMEf9TjsXXbYR81x8xGB5ZTQ3w==
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2fc:3022:36b8])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d88:b0:309:d115:b5f7 with SMTP id 98e67ed59e1d1-309ed313729mr1983532a91.24.1745467396836;
 Wed, 23 Apr 2025 21:03:16 -0700 (PDT)
Date: Thu, 24 Apr 2025 04:02:59 +0000
In-Reply-To: <20250424040301.2480876-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250424040301.2480876-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424040301.2480876-8-almasrymina@google.com>
Subject: [PATCH net-next v11 7/8] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
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
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, sdf@fomichev.me, dw@davidwei.uk, 
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
2.49.0.805.g082f7c87e0-goog

