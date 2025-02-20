Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A31E0DCC
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017376; cv=none; b=aqYzsJ4LCQZc1RHuv5fZrNP0F35gxUifWzASUYZ1qY9ONKAEZcJhQxkxDH1sGwiNMPrxInigiTnwojLro5+gYMiXjhVtEqg5bOxwhPDl+jha14swEM4dFHIi1HlJ1gNcyKMEK3aLwVr66UbQmiaZd/FJDkjsveuZdsHN41hEtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017376; c=relaxed/simple;
	bh=4a9/ASNRGrjKbqFRJBcsMKUl4XJqLT98iBtNZ9Vd0eg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+XHCMUaavtTumuZ20HkOjbThun0OIYDGRakYgrxi8RFj6LMpxyOkC9gv2HitQvBbUfEh7L42T07BtO3aWWBsFMBTTirQA9JXXM21gB/LHaPoNiGHcuvN/HD2DyPsgKp6VTZx2oC1B0ITD6hSf7JtCQjIaD6pgTfJTSxwlLREek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdwtqBa0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdwtqBa0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so927982a91.0
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 18:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017373; x=1740622173; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRh16gD1ltrznZeRyUXa85QXYB+P/DDrWPKAZGQNy08=;
        b=cdwtqBa0cAFPMrIcILVHP/p38F+Lin5N8kNM1CSs776BYhyYNcYRNswwOM0Q6dxBvT
         StT+OWI35ldl4yFrMNYSxytDhTWzSmpUM/GY1K462hIlYT0iwbSJeGQokQH6vBv1VT/U
         l/svezNLL5C+Gu1hOK2uqNZcmgcCWfvDwcC0Efu/+Nwt+o7kt9pdyeMZnI29iA4Pkm7h
         F5ihnCtsvGNseXOoUeO3yR5cToSODALJmW8KSkAI8+EYIY+dkGz2Shwkg9uiFUy3X690
         7DSjWh3Vkgn/i2ErFuSdecmlHHqTQFP7QdhFCQOc01gkpF1dtHjD7QnDraJ7IZlF6HrS
         qZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017373; x=1740622173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRh16gD1ltrznZeRyUXa85QXYB+P/DDrWPKAZGQNy08=;
        b=U+LvoNGg36PeixMsNWg6L7w0I8LMFO3uroQ5SlUVXIqcrCuzLyV/hWo/4rjaOpFuIh
         lyu4aPdSbhsBlUN673cRJuv7vqQn5NY6ReccF8A8NqTbKEPNMoAEe/f+rOl7RLvLAcEW
         6YiaL1z2OBLBSKlT6PpR12tJOM8bGebjD7Sup6FhE8lMXAev+oEY6yuBVQSM87qMfxTa
         /UzKrrKc1eZMmaGOjfbrPuVu6+buYaQ5jjNZwAFT0gHwOcZJOyaIPBDYrnSVYDDNE5qB
         uF6EkNDpsr7avue6/89jkdCyOhqMswfAPs1nuNYTE2TKDbVOvsvub1+9M72FrVQLkAo+
         wKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmYYFLR0tU+n9oUqyuRux6fubOt1BuOeHOrKE8XtcQuK7IU5DpmJ9JBRlCiCRq8TjY7bxwh/2ouEFdsIuyCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXw+oHrERph7SIy0j1Yuh0ZUt6prjWyc2yoPSKaQlaMzT5Pm0G
	6BeEjWkW7rIxpuRRhs5eGp46X34QXxd5kSOe9DL7zpvgbNUE1UudcoJpAt7Ar/8xVeQtcLXCmcs
	CK52wjvIx3J3Iqz6+YaMt7w==
X-Google-Smtp-Source: AGHT+IFv7gdFT+Y+75bNV/cPnBGsSoo+TGhAr3nWoydKdBJ94MrpNFek3G2h7TMlX0xSNhdiJ1pw2YWAResKG+nBaQ==
X-Received: from pjtd9.prod.google.com ([2002:a17:90b:49:b0:2ef:78ff:bc3b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2710:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2fcd0ca3ad6mr1322765a91.17.1740017372717;
 Wed, 19 Feb 2025 18:09:32 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:12 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-8-almasrymina@google.com>
Subject: [PATCH net-next v4 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
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
index 533e659b15b3..5047d4e260fb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2731,6 +2731,10 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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

