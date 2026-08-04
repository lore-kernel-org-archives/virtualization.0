Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DB4483A3
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833626; cv=none; b=HxWI484qDReFFCFePOgG9/5k5+OvWOZz1AfYzw3OL1k5BtoyeVNTJDyo37W47N8WK5JvNCLO8Cnr8FqFX9ux9AX3W2EOu+sjaLsXnMu9Oqw5LiRrY2BnQPAnaKv/YwlOtsK/e+LwBXudzo+fZgILf2K7ohC9mNYVP4s9GIZq0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833626; c=relaxed/simple;
	bh=bI9DSAx9i2trTWDFpDQycQ+t1GEDr+ijrs/abY7OQxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e26yX/6A2ViWOeAp4pYiTFndKyadeW04eaLSQkavcK01Xjw7CD90eUDE1WYOik/+8XWT00VbhBQYrDdPLckoC8lxnxMSiAgJZBOhBdaW75zUNSpwP8x0YFJ7Pj8+q9CduCV4nJKqS6bba20lnG+wiM9PaBQjhHbHjhTCYOoNkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fa1ac9d08fe111f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fb2e1267-91ea-421d-8b84-2a1e59dce126,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:8420ec9cc404768254ab90c5e6112968,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa1ac9d08fe111f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 420533143; Tue, 04 Aug 2026 16:53:35 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH net 2/2] virtio_net: unmap AF_XDP header with tx virtqueue
Date: Tue,  4 Aug 2026 16:53:29 +0800
Message-ID: <20260804085330.1333242-2-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_xsk_pool_enable() maps the shared AF_XDP transmit header with
the send virtqueue, and the disable path unmaps it with the same queue.
Use sq->vq on the setup error path as well so the DMA unmap matches the
mapping side.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6160aa8ba..a6f90f579 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5959,7 +5959,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
-	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
-- 
2.43.0

