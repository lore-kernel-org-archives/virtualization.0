Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A0C43219
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 11:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66455832E8;
	Thu, 24 Feb 2022 11:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mdzEc65dg-lA; Thu, 24 Feb 2022 11:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF3E5832D9;
	Thu, 24 Feb 2022 11:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB62C0021;
	Thu, 24 Feb 2022 11:04:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D911FC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6A6C416C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HdBMV-AoH_zl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFEE3416BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V5Nr1si_1645700652; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5Nr1si_1645700652) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 19:04:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 9/9] virtio_net: xdp xmit use virtio dma api
Date: Thu, 24 Feb 2022 19:04:02 +0800
Message-Id: <20220224110402.108161-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d02e086a8668
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

XDP xmit uses virtio dma api for DMA operations. No longer let virtio
core manage DMA address.

To record the DMA address, allocate a space in the xdp_frame headroom to
store the DMA address.

Introduce virtnet_return_xdp_frame() to release the xdp frame and
complete the dma unmap operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..0efbf7992a95 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -321,6 +321,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void virtnet_return_xdp_frame(struct send_queue *sq,
+				     struct xdp_frame *frame)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	dma_addr_t *p_addr, addr;
+
+	p_addr = frame->data - sizeof(*p_addr);
+	addr = *p_addr;
+
+	virtio_dma_unmap(&vi->vdev->dev, addr, frame->len, DMA_TO_DEVICE);
+
+	xdp_return_frame(frame);
+}
+
 static void virtqueue_napi_schedule(struct napi_struct *napi,
 				    struct virtqueue *vq)
 {
@@ -504,9 +518,11 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 				   struct xdp_frame *xdpf)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
+	struct device *dev = &vi->vdev->dev;
+	dma_addr_t addr, *p_addr;
 	int err;
 
-	if (unlikely(xdpf->headroom < vi->hdr_len))
+	if (unlikely(xdpf->headroom < vi->hdr_len + sizeof(addr)))
 		return -EOVERFLOW;
 
 	/* Make room for virtqueue hdr (also change xdpf->headroom?) */
@@ -516,10 +532,21 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 	memset(hdr, 0, vi->hdr_len);
 	xdpf->len   += vi->hdr_len;
 
-	sg_init_one(sq->sg, xdpf->data, xdpf->len);
+	p_addr = xdpf->data - sizeof(addr);
+
+	addr = virtio_dma_map(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+
+	if (virtio_dma_mapping_error(dev, addr))
+		return -ENOMEM;
+
+	*p_addr = addr;
+
+	sg_init_table(sq->sg, 1);
+	sq->sg->dma_address = addr;
+	sq->sg->length = xdpf->len;
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdp_to_ptr(xdpf),
-				   GFP_ATOMIC);
+	err = virtqueue_add_outbuf_premapped(sq->vq, sq->sg, 1,
+					     xdp_to_ptr(xdpf), GFP_ATOMIC);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -600,7 +627,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
 			bytes += frame->len;
-			xdp_return_frame(frame);
+			virtnet_return_xdp_frame(sq, frame);
 		} else {
 			struct sk_buff *skb = ptr;
 
@@ -1486,7 +1513,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
 			bytes += frame->len;
-			xdp_return_frame(frame);
+			virtnet_return_xdp_frame(sq, frame);
 		}
 		packets++;
 	}
@@ -2815,7 +2842,8 @@ static void free_unused_bufs(struct virtnet_info *vi)
 			if (!is_xdp_frame(buf))
 				dev_kfree_skb(buf);
 			else
-				xdp_return_frame(ptr_to_xdp(buf));
+				virtnet_return_xdp_frame(vi->sq + i,
+							 ptr_to_xdp(buf));
 		}
 	}
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
