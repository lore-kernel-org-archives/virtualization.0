Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4420B805
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251735; cv=none; b=cl3tC/ZTEhr3PanvFGpE6EK+R0wo+Ir5v4NrHyBHsf99ePO4+alIoDXnoerw7QjoIwTZB8XuxAfn+7mbhFPcWZ2YjSerK9NnelOnA7VxBlzFJQGivEGChAemx3sQ8I2GLTkq0q87jVnmTshJg6VU7I6gGnLnE9GGR13jLbBaCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251735; c=relaxed/simple;
	bh=S4WIdcIymEnObCKW8hFtjmYPsUwr3C9vEUbedDCBePY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fr1hX8xL9/qikpX9MJPHX4aASHPOYZ82hCrXVy0Tu6E82/4eH0lAXjRXcvMJBEOGF0xaPR588NiORpkddHi0czViXH8F49GiJzOCP9lqOJSvDKjmM/Anpsv0+3w6BO4tS/SMBlN7+oXVF/Up3Qp6WtMKD7bRmZraXLEzjcR6G24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gku1PzXF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gku1PzXF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so6756307a91.2
        for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251732; x=1740856532; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=biWDWCpFQb1l1Z/yT0zgxnecEVUj+cBj8CVtcecqD6k=;
        b=gku1PzXFyeAH39XkreoCE4TdHHt/TfjzDwB5VsbEVlQ0sfy3HKLBJJPU+QAbIY831T
         bf4myFPUv9m27Lv/BrZ6G4oEAedyQiDNrRCuHYHg9pLEBDs+FcWyma/iAo9iPMwFXkGv
         IaxfDo5oESZ+Awq4C+pZ6HLCsaNBUTl/uTNFTVecyCFENA9yr5KKMutqj3rk05gnMR+3
         YV3fR+DcxSA4Z6t3YxaKTmwfwZ6z0eJHLGJJwgJIVC0vzXV6d+8tEPaQB/7jSLPJt2EI
         M1EOYB1Vs/GEv2O9ugc/PtE8v4jfffVT9v6ZOV406eoHd80+tk9GXrWqgxtM0TJNy+nd
         skAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251732; x=1740856532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biWDWCpFQb1l1Z/yT0zgxnecEVUj+cBj8CVtcecqD6k=;
        b=E+D3XSDHU4/bR7hx0QUwh8zEK889B4g3fAKMaN39cAddpk4Nx6tRJmAP0/uHxa1SVK
         56nFFnIk1PJ6L7rgt29MXSQ3CJfrJyx/krH43WO+L7u3wxSlaS+nPpqMJqs9sHf/JZCF
         3BpdYhIe/2Solk2gQvPDQ+SsW0BAeoxtwlH8oISogl+HCsutbhfxCZnuOmPUmHTpxKHU
         zX1IX2yGdyoDlMEUegn6Td/EXAB3qzdiiCDUoFLmE/RGK/ID4qZAqaO9O7WVEzA9TCva
         b7AA8pkAs1LqrhObcVcxKK3WQeKHaqgYNBdXOFI/3f3rD1wDFUjslwb1FaJsM/zKOesC
         rmDw==
X-Forwarded-Encrypted: i=1; AJvYcCXpMJ7THvQ3vPZ73ebr/m5ncj/eplPsYU8k/iBGYLwnJRFJroNQVT+qTCNPMYsFyvpts2QK37T9119d9M8hmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTuwSz17QfsEsjTZfO/PAlB8AIL8fU+ASBale7lTqA8rQnkij7
	hxMrHOI4+MRkaYisvSfao4MwsiaawmvzcSFRBIp/iBm5tx4FU0ScO88NxjG3nxWomojdyzn2K8B
	2QS1801/RARP4PjvlAZm/oQ==
X-Google-Smtp-Source: AGHT+IF3RH6VzHVCehHRbpJJLJjV+rVcxv8rDd/2+CtDFFrrVHzDHLPS8NaJht7KEp7lWFwHwxhOI4KSFp5QbSD+AA==
X-Received: from pjbdj7.prod.google.com ([2002:a17:90a:d2c7:b0:2fc:2b96:2d4b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b4a:b0:2fa:1a8a:cffc with SMTP id 98e67ed59e1d1-2fce875d403mr10219694a91.34.1740251732332;
 Sat, 22 Feb 2025 11:15:32 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:15 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-8-almasrymina@google.com>
Subject: [PATCH net-next v5 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
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

Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
enable netmem TX support in that mode.

Declare support for netmem TX in GVE DQO-RDA mode.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 029be8342b7b..0f11c8455149 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2817,6 +2817,10 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
+
+	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
+		dev->netmem_tx = true;
+
 	gve_clear_probe_in_progress(priv);
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 394debc62268..e74580dc7ebe 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -667,7 +667,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 			goto err;
 
 		dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
-		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
+					  dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
 		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
@@ -1045,8 +1046,9 @@ static void gve_unmap_packet(struct device *dev,
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
2.48.1.601.g30ceb7b040-goog

