Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE60C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EDA6143C
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EDA6143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 924CC405C1;
	Thu, 10 Jun 2021 08:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4CZyZjCOap1; Thu, 10 Jun 2021 08:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B2FE405BD;
	Thu, 10 Jun 2021 08:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE5ACC000D;
	Thu, 10 Jun 2021 08:22:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37CB4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2250460834
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7GlVylhV2-Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DBB1606F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R521e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0UbxH89Y_1623313332; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbxH89Y_1623313332) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 07/15] virtio-net: standalone virtnet_aloc_frag
 function
Date: Thu, 10 Jun 2021 16:22:01 +0800
Message-Id: <20210610082209.91487-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

This logic is used by small and merge when adding buf, and the
subsequent patch will also use this logic, so it is separated as an
independent function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d791543a8dd8..3fd87bf2b2ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -264,6 +264,22 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static char *virtnet_alloc_frag(struct receive_queue *rq, unsigned int len,
+				int gfp)
+{
+	struct page_frag *alloc_frag = &rq->alloc_frag;
+	char *buf;
+
+	if (unlikely(!skb_page_frag_refill(len, alloc_frag, gfp)))
+		return NULL;
+
+	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
+	get_page(alloc_frag->page);
+	alloc_frag->offset += len;
+
+	return buf;
+}
+
 static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 			    struct virtnet_sq_stats *stats)
 {
@@ -1190,7 +1206,6 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 			     gfp_t gfp)
 {
-	struct page_frag *alloc_frag = &rq->alloc_frag;
 	char *buf;
 	unsigned int xdp_headroom = virtnet_get_headroom(vi);
 	void *ctx = (void *)(unsigned long)xdp_headroom;
@@ -1199,12 +1214,10 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	if (unlikely(!skb_page_frag_refill(len, alloc_frag, gfp)))
+	buf = virtnet_alloc_frag(rq, len, gfp);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	get_page(alloc_frag->page);
-	alloc_frag->offset += len;
 	sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
 		    vi->hdr_len + GOOD_PACKET_LEN);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
@@ -1295,13 +1308,11 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 * disabled GSO for XDP, it won't be a big issue.
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
-	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
+	buf = virtnet_alloc_frag(rq, len + room, gfp);
+	if (unlikely(!buf))
 		return -ENOMEM;
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
 	buf += headroom; /* advance address leaving hole at front of pkt */
-	get_page(alloc_frag->page);
-	alloc_frag->offset += len + room;
 	hole = alloc_frag->size - alloc_frag->offset;
 	if (hole < len + room) {
 		/* To avoid internal fragmentation, if there is very likely not
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
