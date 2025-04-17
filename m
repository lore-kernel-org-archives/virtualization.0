Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E422A7E7
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931757; cv=none; b=cIuyrEt6/ALkHCLgHb9Em9+bYmoXToS6yHwtHjBpdeFj4v5IAtlISG23t1fm5xYLhGrG2e3D6u9QDBVyDEHZcvJCyuFTk+d1bRL6KO47M9Wrp6CkPKyhAQIl2nO6RsfzzqHZ82LYqv6fN4YnrQgx88nynw7eH05H2BeFwgdUsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931757; c=relaxed/simple;
	bh=F0GKKLErnS5cWXQ4M2c/x5DdWKboDmTHbSwB27WLCCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cba0aDCH6FEn4LI7yutahDvHZoTvacEgtLrjVwYiDlYLVs7ODaxwnGlBcJGnYxgFrtV/a97+WO6aPiHLZ0G7rNllzN5Knl9bBR1ShT+Kv+8pBvMLJ9LeYVNYcHGW8tclIlDpZyCGgzmEts/b3+cp8Spl8oXtMSnM68e8OwNmZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWhj3PmZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWhj3PmZ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af98c8021b5so1253354a12.2
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931755; x=1745536555; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=keA8cLZYn2EhvLOhQyJggh5VI/j8gWwYxlsH6YE7cPk=;
        b=vWhj3PmZmRXiN5hH8tcl69Co4Xr6l4BjF5JZ4/Vvpdzks9lG7AfBwUfDH/PkiiR7Tj
         ZYrZWxSW9yOzb8k7jL3RsO/D45SFWjaPlRjLwleKv42wSP7wvQXbZxUp2SUC0EdWqIdU
         vV+z2NEDNF9McJIV0skc3w8Zi7vfqCAplgGk/9JaFyXjOh0qgvZgw/WfdZjQHoWRbs0n
         ZWIL1qaDOKvwA5vXAqKDV0Cy89DQbUWD6yXLNE2yJ9hpc266fj0JBlO+AErXZi7hgyyx
         akC9n241Tmk80jGo5eE/eL3xxawRyanO265Oyw1EFkmdKhBiRTuQPFHrR/e0pd2ogvOM
         sFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931755; x=1745536555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keA8cLZYn2EhvLOhQyJggh5VI/j8gWwYxlsH6YE7cPk=;
        b=vByu/aTj+RY4SDdxgaqbdulTHN566IToQl4sTJs6OkXC+u4MJ7FznNJd6jOS8ubwFI
         o6fFpnuej/4lmGoxwUYcfKuv+sqWcTRWpbjy5kvL2FM3rlveCbqttDY2CEEzYoW53sbX
         xiJKROXDv+AKqrH/y680FJD0DZ1KPoAB4l/AIsSLhhtIjykJcUorTgIdMHubCeZKoUYb
         FmgyGRuoLLG5MNQUGN86fs9xIwJlWVbSy9g0qPNexA/VNhW0sPnZdA/z2zUjdTH9udHj
         K5widjk5rKoGYeMhto2LLlhIPjrkncRXIMO6xaezAqo73pPDziy0tm7uBTDJUiM0TvH4
         aWfA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0TE4Y0UROOarTXSa60Sz11CeRHQpXGP/u2BW11EeTloR1sGw8XRtLz3RgCieSQrcUS6BqIrykZuV4gqDMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNigs3K96hH/BoxBwL76GRJiJN4He5Gy0Z+2AIXSb1zW5AhvsL
	PpPDSM+vT/IuSJaByW6PqzEhJRbaexUkqlUh9dxELJcyTkCNM4h67yJVYy+Cb8YNo+UvS3YY/L4
	vvj/4vHtyZ4gTsvhzN+evnw==
X-Google-Smtp-Source: AGHT+IGb+loOWZvF3vdPElIoHoXweBZXnm5mXY3AMefNEyexNpJjsIc0YuX+K+7pyVxBPAV5r6ttZ5zAsPcY51p4NA==
X-Received: from pgbdm2.prod.google.com ([2002:a05:6a02:d82:b0:b0b:2c1f:b8b3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3298:b0:1f5:8622:5ed5 with SMTP id adf61e73a8af0-203cbbee8b4mr1117256637.3.1744931754777;
 Thu, 17 Apr 2025 16:15:54 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:38 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-8-almasrymina@google.com>
Subject: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
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

---

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8aaac9101377..430314225d4d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
index 2eba868d8037..a27f1574a733 100644
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

