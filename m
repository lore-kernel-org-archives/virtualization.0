Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA2268C50
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377896; cv=none; b=nrbnJfVINVX7jKy4zxfNX5GoopZyhJKHplzftzfJTPQWODvXTAv6oGq1h1xOZhOl5FOBgRMGnPUt1RI3pGIQwdDnA1rhbPN3ZZ0eqBE8i3hamt7OYVkmlY1vHdTXB310BboseOuM3IB5djIgB6vuvYHuOY2/zzeYVadkqsfPuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377896; c=relaxed/simple;
	bh=R1n+zaUcaajUS+QJKbtDHHCIKgGrd7M1r+jqgogtioc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XX2i/v1RfhbXx60e8UncG+BGWuuSw2rbnYFkJJ/O2a1rJ74h4ieqHJ1atZDATwV/4AMQ1HDGoxMS+ZbPHmudVdCaIBWFygaDgu4DDeDHG5TP4QcXnsh5QlCrZscJSuzXMDitS0knmK5qo18G8CmeCih5R1ooQmlSi86oTILdHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQMVD1Pb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQMVD1Pb"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73bfc657aefso4264235b3a.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745377893; x=1745982693; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dj0whsIoLIY8xfxGCTW0cmb/UVxuNztUDb84L0w97oo=;
        b=aQMVD1PbicHr8jodsEUil6YTDMi5hKnF56PIfsLCA1N3ZyiOtP8NhYm53u+3L9AVTl
         mgv+53EEZnJQ3yniAcgWfd9Cc102iFArVDoeo7PWpWDOCpHL/ERwrFG1wMCexmBtwhhu
         g/y1yrImosI4aO8EeRz1y/qnLIOywRE23tjBCO2wCNgK+42LzK5qH1B/SDenRRq9TpAM
         Nh8h8hz67jYd9uGx5j/aJ5mmLaK/+gIuF/fwc41xoExNbOiljs2xo0xNS1d7EtVzvbC7
         SV936/0Dga4uLTAewXVHwug8TioWb+HEASLNefRePNGZt5v9SL8j7XNvafmdWcMrY2Dn
         +emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745377893; x=1745982693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dj0whsIoLIY8xfxGCTW0cmb/UVxuNztUDb84L0w97oo=;
        b=xJULaSI+CX88mNTG3FDqo8oImfJ19MYomUP1LtdUb9UXtpjN1EmnvX8kpLbZ+PphhM
         6DQPs/X7HMpNvA9uvMOitWasCHvl27hYg9U9TSZVHWYKvd9DlivT1vZcXl1a2ui/Hfib
         e1xCH9RcNDw+US6XkNsuk6cPjbarsb/XZJoRuPh/SwHVOZGlm3BOU1kWWD91xxnXS4SP
         3rhPj+kzskYf4hsMOc+0KHeJdFFs6u0UC6GLyZBBe4YvCtY5XAzqKJnIEJaX8Qs5wexB
         kQ1dcwdhOnv/7XDQ6eDACws639eOQIIwk61Ont9wZ8MiElb3jFDxAbfvYk4QF/D34D0O
         I3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW70gt1uJUmSGtDOTNIFB14fbUXsN5EpxcJoquLmf3g/ZzaX6alezku5LY0jtoxo1UfQA2zX61Pk/oJTC2KIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdVacvh5NWZILZomCSL2mWroLIhKnsYJopVptxX2SZmegSMIlF
	Q/0CjAWscD+/tsZy3Yl0wLMrX9HDQHyroTjX7tk2TgyuwtZ2T7l+qGzMTHXj440FXW3pQdszRkT
	jPQQ9WuPnuWY/kxrspR8ZBQ==
X-Google-Smtp-Source: AGHT+IEznertOZQbmSsfV0WFF7VBpVpkcqUX6bXWoLaE6jTBVKTuO7UdKxqSHSGv3VnIIE1gjXxfUrhCi7P19IBIIw==
X-Received: from pge16.prod.google.com ([2002:a05:6a02:2d10:b0:af9:8f44:d7ec])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3399:b0:1fd:f48b:f397 with SMTP id adf61e73a8af0-203cbc76991mr24720535637.23.1745377892877;
 Tue, 22 Apr 2025 20:11:32 -0700 (PDT)
Date: Wed, 23 Apr 2025 03:11:14 +0000
In-Reply-To: <20250423031117.907681-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423031117.907681-8-almasrymina@google.com>
Subject: [PATCH net-next v10 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
enable netmem TX support in that mode.

Declare support for netmem TX in GVE DQO-RDA mode.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v10:
- Move setting dev->netmem_tx to right after priv is initialized
  (Harshitha)

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8aaac91013777..b49c74620799e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2659,12 +2659,16 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto abort_with_wq;
 
+	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
+		dev->netmem_tx = true;
+
 	err = register_netdev(dev);
 	if (err)
 		goto abort_with_gve_init;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
+
 	gve_clear_probe_in_progress(priv);
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
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

