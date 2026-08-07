Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC23806D7
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066356; cv=none; b=gBD8QM8hJ4P9NtTg+O2/BMqjLvzDRBn/QDXFwecsN0CGiYYwnvghnF7QeyL66hdTSiP+P5Up3sAwDQXi57YgaHsOxM8jNv2uS9VboMM3evH1wH+ecwAfKZHHGKofpiiJvHkjHuvzmY2UutH3lR4ZWI4dFo6TDce03WqxRRiD1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066356; c=relaxed/simple;
	bh=VFX53KzQM2qEgP9mFKjgry9XD7/Ah7IVDbXDv5M0AiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nj+XsYWeNsRaVP6a1wIHEYnfphd7/9Mxt7lOHDkpsOehmYY/53onH3k6NVcxo5q9nhZf2gwVXqTvAfIXSnt/t039qVzhlTNRO6E/q+BJHB1uOaDeeNs9H1JQZrX+EpH9v4/gtoHkl8WKMq2pirQIQM0wBn8U34771427kjew0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d748795a91ff11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2230873a-e80d-4119-8a7d-cd4b679327d8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:321251d9f6ffadff5b29864f53d29c4e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d748795a91ff11f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 57141345; Fri, 07 Aug 2026 09:32:23 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: netdev@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] virtio_net: fix AF_XDP pool disable after queue shrink
Date: Fri,  7 Aug 2026 09:32:19 +0800
Message-ID: <20260807013220.2130441-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xp_clear_dev() calls the driver to unbind an AF_XDP pool, then frees
the pool.  virtnet_xsk_pool_disable() currently rejects qid >=
curr_queue_pairs, so if XDP detach (or another path) has already shrunk
curr_queue_pairs below a still-bound qid, disable returns -EINVAL.
The core only WARNs, clears the netdev pool pointer, and destroys the
pool, which leaks the driver's DMA mappings and xsk_buffs and leaves
rq/sq->xsk_pool dangling for a use-after-free if those queues are
brought back later.

Use max_queue_pairs for the bounds check so cleanup can still run,
null the freed pointers, and avoid refill on inactive queues when
unbinding.  Also unmap the shared TX header with sq->vq on the enable
error path to match the mapping side (no functional change while
rq/sq share a DMA device).

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
v2:
- rewrite as a real fix for disable-after-shrink (leak / UAF)
- drop the previous "check queue index before use" reorder patch
- fold sq->vq unmap symmetry here as NFC (no separate Fixes for that)

 drivers/net/virtio_net.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a587..d07ccef 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5848,7 +5848,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	rq->xsk_pool = pool;
 
-	virtnet_rx_resume(vi, rq, true);
+	virtnet_rx_resume(vi, rq, qindex < vi->curr_queue_pairs);
 
 	if (pool)
 		return 0;
@@ -5959,10 +5959,11 @@ err_sq:
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
-	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
+	rq->xsk_buffs = NULL;
 	return err;
 }
 
@@ -5974,7 +5975,12 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct send_queue *sq;
 	int err;
 
-	if (qid >= vi->curr_queue_pairs)
+	/* rq/sq are sized by max_queue_pairs.  Allow cleanup even if
+	 * curr_queue_pairs has shrunk below qid (e.g. after XDP detach),
+	 * otherwise disable fails, leaks mappings/xsk_buffs, and leaves
+	 * dangling rq/sq->xsk_pool pointers to a soon-to-be-freed pool.
+	 */
+	if (qid >= vi->max_queue_pairs)
 		return -EINVAL;
 
 	sq = &vi->sq[qid];
@@ -5985,11 +5991,17 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);
 
-	xsk_pool_dma_unmap(pool, 0);
+	if (pool)
+		xsk_pool_dma_unmap(pool, 0);
+
+	if (sq->xsk_hdr_dma_addr) {
+		virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
+					     vi->hdr_len, DMA_TO_DEVICE, 0);
+		sq->xsk_hdr_dma_addr = 0;
+	}
 
-	virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
-				     vi->hdr_len, DMA_TO_DEVICE, 0);
 	kvfree(rq->xsk_buffs);
+	rq->xsk_buffs = NULL;
 
 	return err;
 }
-- 
2.43.0

