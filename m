Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617802D193E
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757291; cv=none; b=RoGETjwrzGeE31Z0S4++qTs1f6uZKAmmvASmWt5d3BGkTepfSeqzSe1XcVwpOiqYTLaSm45Xxu4Z0s88iOw43+qQ/q4d8Q9D5UuqSEoiz22bGt7Cn+GwXrAxs09+T+SZ5BV6ZGo0wkriwoGKbc3wr7sEkGUSr3wTAKG1p8nneBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757291; c=relaxed/simple;
	bh=Cqzn0jIx+ICXy20erkdmco/hDp3aOf21xpNbmkO7QhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUhtnXDevet5MqHt/nKUoDscI2qYzvcEzVjcSQfMWrE1uAy/9u6osNm3CKYjflUoJkApx66BUJUvihPYpH32jTjM7tPKeZDH2D2GEC3rEVeb+42IeE3NeuvmAayMfW/8BVi6AppsgQFfgq1H1gJbzaO16bZcH0+asENoXP2x4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiO9WnV2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiO9WnV2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so4277455b3a.0
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744757289; x=1745362089; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y0gt4KGR4y8gxIG8GX1gRAmwKzn/ocefSDNpr0C4Oc=;
        b=NiO9WnV2zmNmgomRAXTUREuxO/KExBjnKimeHHLYbj/qMqiEfpX0E4yh6Z6m/iH8M8
         EEhTu1d+AHEvmZlfDNakxSDmOW5iTlJCTE0MfU9l7AtwbaLmbNCTAJmyC2Je2rH/Fntr
         IgvDxJt9GGCD/8cjos3OdalNSz3ZJ5OhZaeh78ooBBURs4Xl/Q3BpUWQYPzJp1FM/zvx
         lyfZM1QhyNFbI2qtIfRfulH5PCmkhkNmy+/VtwiHq0Sfcc16Mx2Nu83if0eDn6GzPEMW
         Z4MCs9F4ypEeIOySpvgbqMune6pR63PPkZCOrvAK7MddtkTgmy5n5z+SeUOE7AIPKl/o
         a3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757289; x=1745362089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y0gt4KGR4y8gxIG8GX1gRAmwKzn/ocefSDNpr0C4Oc=;
        b=VPsnFbhbixPkWzGmUgHH8yu2+KRB7wZc+hUutLXB3fpvh7r/QL9vyz276ajO9qMmJX
         EEXdEi+26FBL4oKgAChnU/RwGWSR+U7vjA8haLptAnN0a8ABQnyY6DIfjzibWwh8SRtw
         Vp7ei6z/h6yT3qWIieEmmUhoZVbdqkiqksi15Jcbn7SmO7DW81gaqU5yW/jv40yiive7
         LRwDd94IvzbwWGRqYNgDGO+hoJ6QgvwoWx0xjhpoaH5/DoA8cNkE9k4jcxZnih8FKtvQ
         v58ispLaPYrlp5fgJ3he6ZARysqnRFmFQKzFZH/hCRqNsFLi1bpWgsDnfUN9c8cKQQo3
         adLg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/xdMBJOxXcCH1iJQMunUyZbFoMGBlincTA8zAoPOQA/b6KiyMwn9UmqX9YdCY6fdZJYRRSgsedjuLTKbJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+yFQPV3EJxyY/FzYjaEydGb330CyfM+dgqH91x1Pnl4DLkboD
	p1HpyCt4ODWY86+ho2YVhzk9nZyoWQZxTitx+U8OktbQcDNHwRsOwhifnHFXBbzBYMMFSLybFJr
	RaJdRVv2vRPp85/Gz28eSdg==
X-Google-Smtp-Source: AGHT+IG5NdGfYD5N9W8W7UHWdGCQl03DIg/olddW2S6Vpl+mwIRiJnb8xyrZV4MMvX8nbx7uCAGqaaZxX+2uVhCWMg==
X-Received: from pfbi30.prod.google.com ([2002:a05:6a00:af1e:b0:736:4313:e6bc])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:21c4:b0:730:9946:5973 with SMTP id d2e1a72fcca58-73c1f8c6c69mr1778523b3a.5.1744757288544;
 Tue, 15 Apr 2025 15:48:08 -0700 (PDT)
Date: Tue, 15 Apr 2025 22:47:54 +0000
In-Reply-To: <20250415224756.152002-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250415224756.152002-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415224756.152002-7-almasrymina@google.com>
Subject: [PATCH net-next v8 7/9] gve: add netmem TX support to GVE DQO-RDA mode
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
2.49.0.777.g153de2bbd5-goog

