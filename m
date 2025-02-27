Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F8218ABB
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629545; cv=none; b=k6/qS8dXlQtDiAjvYeug7owvbpDoA1/hAkObRCtGwyJmNajs43Be6bHY84nV9cxe+57M+NP71AZdBNshUwkb3vD62LD2HgEy2prBWB7ZWYyt4W5wH8eXdXgoexHGo6fYX/EQTGRh1jWQmwAgVNtPSy0qa344z3WVoXvjWSeBdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629545; c=relaxed/simple;
	bh=lBHVKsoCoEgF3bW4CEOzs0StxmW/iNQWIYUttIHfQDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6cPIq+mgBVzL70nkUUWV202jDhRJE6LNYe/MSBTRh7q0pMNF1Eg3EssM893FqxGDWrRs1vWCNDZRqr6t+Epv8SasM0ZnXIo37dtx3CCKCHpzxy+thkICDhcHYTThcCIXYnUlFIKSh60pv8a3GJ5BQJE2kpu4ZdCTDKri31VRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePcXr7zd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePcXr7zd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e04e67e2so13060155ad.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 20:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629542; x=1741234342; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0JHVgHhHQYEE34tPqFbSIw0W293JeUSSt2z5OQCwE=;
        b=ePcXr7zdnt/zdnb3G6N77txddNWCkJ/YcPeO25Gbu38cNu0StyeD79s52/T/8PEjd5
         QwCagsNEhsMP1u8VTXMa4+SNFM766GLUOPvTdhS3HT84pKX5PRaRBKqw9x5ZGHxCCNJC
         FWfLXg3UZInhX+ysKFwsiOyFdpANMJoQqpFLGMSn5Y+zmhuzTY8WXsTJn0K5vP7wGDs4
         7kdUG1/RMpoFa7pV2oA88xFmoJRuIrWpNPWiC6ta4Ddt/A6109+kP9/95wIn0hC78htV
         21TVR/mg3qA/Z2N5HPVp1zdDuEbUPNYO2a2KN3yWhYZZCdPGQGLcGNxMz6Ed9VY8mHjg
         MB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629542; x=1741234342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0JHVgHhHQYEE34tPqFbSIw0W293JeUSSt2z5OQCwE=;
        b=lmrWBUHslnZL9BWqULptZ57lmk/CWnQWYNPIf0rJB5yaMZ9Pg6unClhf375Mh9B412
         zjK9suTX2zZ1dsZpEN2SGYQVcXrpGQzayC5x74XysWorTuu/jYJrRayYlD5h6x1jmVt1
         7qwl3Wo/W4BoYnEVb2dEl0b8NMBA+hRCAdgqGYE2Rzb+BGdKCV3+TW2csDKl9M0h9XUE
         B/RsY/FdBvKPAAoDnO/kEMXuPr6WOklA4Ll2Yh576rqHgdkuq2Ajaatf2ECfyTiOZkRf
         rfWQNPAZlT67pZZe3VQkweO7Ks5fw2TS2VEU2A1x4+DJGeYxMAtONx+1OwDov/LZoM8n
         yP3A==
X-Forwarded-Encrypted: i=1; AJvYcCWN6zhxFLddc8EwhzdWvvy/kF4703/57jnmfvVBzq1sISBfnvH2BLqLrohC/x3rF5Gc0sm3vgmyJmqij/l4Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdqXjXfN47bhr4DtJ6Tlg79tVgrmyJkvZNT0ReU/4IJPIS6mSb
	5X0mp5hZ2P1gZheJnHI+VCZMfKAzVveTz3Rq8KvUN9fF+/EmgNyWUZcuxFRJ2Mh47pIjpWZFYA1
	5qGAMHGhxSBHZIX6PC6ivrg==
X-Google-Smtp-Source: AGHT+IFNaUt79J+Fb8AMW/Fz6OdO9a2Y/vF7HhxDsqKeMT5mD/d76Hd15XMQCxK+nePqad+2ARZWGsDMfho8wFl38g==
X-Received: from plbjx3.prod.google.com ([2002:a17:903:1383:b0:220:bc6c:e6ad])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4ce:b0:221:7955:64c3 with SMTP id d9443c01a7336-223200af968mr96903595ad.23.1740629542171;
 Wed, 26 Feb 2025 20:12:22 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:07 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-7-almasrymina@google.com>
Subject: [PATCH net-next v6 6/8] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
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
2.48.1.658.g4767266eb4-goog

