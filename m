Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186135;
	b=JCHdKcJLCn+FBe/w4iV7nk9S424CsHRE8+A6Kdn3CK3C7/Vm7Ru7LRB7sxZ+oRshLOTQ
	 tmMEMgLr+mhTEY46K2ojCghchuIJdyP+HYHbTtc3teXsJdhUJ2o/ZS5VS8scotXBeEgJg
	 8f7uoY+Je4a2EK0DyOLUtRiYsAL+gK5hSNiQNfhhAWwu5H71rF9SwGPkPFfPneKw59pah
	 ri0bziu2JfS1RASz1J3a6E4YaKyOM9vUj7Kkj9bSRC5tCPOPGjR7x/G1QlTn/AhI714El
	 PaDPt2kGpNpj8HxnzjAofYAigkfR37JTfLkEntmVz3BSOPzOyTgloOGnuznCPaGGkmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186135;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7D+iGOe/KpM/TS77r7xebwxtnpAOr+lYRPP6a0rvnqI=;
	b=2S/oerhyADj/3jtvysn+SQhFDadOKGObd5tFZPvIOwtcHM84ZeAPsyaAVZP0Y0tFU7c3
	 xJbeL3EPecai4Tagc9L6UaiPcX9s9pUev+4oMtiMyc/PZ4OG9ZoikJoZBP+OOs2ZbOhQP
	 AhyOGqYkYNptqylzUtPe0k/zBz4BDWC4uIaPhdDw18SzqH2Jp9zjIL+TP/T9slTGRTkjt
	 BBDneDdV9PqXAD7kfW6v4jhHGbYIfrEVOYhtTt3GPwU3zo6sbQfuDD6b1U7IvVJj5nSUh
	 w2ldiihs/NV+N9mYQG2BjTUy22DlLODzUwvYCK0MrFtyP1nuxCr5ATGW68m1pQTLuwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b="VYV8+/wG";
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D3606A326
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 14:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=VYV8+/wG
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1795186110; bh=7D+iGOe/KpM/TS77r7xebwx
	tnpAOr+lYRPP6a0rvnqI=; b=VYV8+/wGjSctNVH/vkN2cXA7AQygrOigiAPjV5J/GQ3KlVvWs6
	nMVvjGl0ydQADFRpVKAMn01k46MvIA4Nf+VtAlB54l9T7Zku9tXHsjYdFwjyz4bCpXtMmSGtgev
	u+trRgi3JO/eLiJw3Dg6k7Da/vGXbEeODORev+oY+gbir0nYNrkqUcscYooWFAmy20oe1k6ACn6
	STzi8ID6vjoewR8a3Npw7h81VDoOpswakaH2HHzfPuiddbgVPxoXlDQBZ4WMR+F7I9Gz/HPndK0
	VhvtKJ456Lb5u49Z3ILMr3Bo44SMJt47DzsSIPjTURnPevWMYO81P40uv3CrNUNbG/A==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolai Kalinin <nikolai@kalinidze.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] virtio_net: check RX buffer length before DMA sync
Date: Fri, 20 Nov 2026 15:48:28 +0100
Message-ID: <20261120144828.1573321-1-vladimir@dfb.sh>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 29dfa436bc488056a84ee423ba82336db453e2a6 ]

An RX queue that uses the DMA API (rq->use_page_pool_dma, for example
with VIRTIO_F_ACCESS_PLATFORM) syncs each received buffer with
page_pool_dma_sync_for_cpu() using the length the device wrote to the
used ring, and checks that length against the posted buffer only after
the sync.

With SWIOTLB bouncing (swiotlb=force, or a confidential-computing
guest), the sync copies from the shared bounce buffer into the guest's
private page, so an oversized length also copies the bytes the device
wrote past the posted buffer over the neighbouring page pool fragments.
The later check drops the packet, but the copy has already happened. A
malicious device, such as a host the confidential guest does not
trust, can overwrite guest kernel memory next to an RX buffer with
bytes it chooses, which is enough to take an unprivileged guest
process to root.

Check the length before the sync in the per-fragment loops.
receive_buf() has to sync the header before the length check, because
the mergeable error path reads num_buffers from it, so limit that sync
to the posted length. A device that reports correct lengths sees no
change.

The driver has synced with the device's length since
commit 295525e29a5b ("virtio_net: merge dma operations when filling
mergeable buffers"), at first in virtnet_rq_unmap(). Commit 24fbd3967f3f
("virtio_net: add page_pool support for buffer allocation") moved the
sync to the page_pool call sites that this patch changes, so the patch
applies to v7.1 and later. Older kernels need a separate backport that
limits the sync in virtnet_rq_unmap().

Found by an LLM code review agent auditing users of the DMA API; the
fix and this changelog were also written with an LLM coding assistant
and reviewed by us. Reproduced in QEMU with swiotlb=force and
iommu_platform=on, a test-only device change that reports a used length
64 bytes past the posted buffer and writes a marker there, and a guest
kprobe module that reads the buffer after the sync: without this patch
the marker reaches the guest page for small and mergeable buffers; with
it the packets are dropped and counted in rx_length_errors. The
virtio_net selftest basic_features.sh passes with and without mergeable
buffers.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Cc: stable@vger.kernel.org
Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Link: https://patch.msgid.link/20261110-b4-virtionet-rxlen-v2-1-6ec5aa0edf9f@dfb.sh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ vladimir: 6.6.y has no page_pool RX buffers. A queue in premapped
  mode (rq->do_dma) syncs small and mergeable RX buffers in
  virtnet_rq_get_buf() with the length from the used ring, before any
  length check. Limit that sync to the length of the posted buffer; the
  existing checks then drop the packet. Tested with the reproducer
  described above: without this patch the marker reaches the guest page
  for small and mergeable buffers; with it the sync stops at the posted
  length and the packets are counted in rx_length_errors. ]
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
---
 drivers/net/virtio_net.c | 51 +++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe0e647808cd..d1e4052c6a25 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -488,19 +488,32 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
-static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
-			       unsigned int len)
+/* Length of the mergeable buffer that add_recvbuf_mergeable() posted. */
+static unsigned int mergeable_ctx_to_buflen(void *mrg_ctx)
 {
-	unsigned int headroom, tailroom, room, truesize;
+	unsigned int headroom, tailroom, room;
 
-	truesize = mergeable_ctx_to_truesize(mrg_ctx);
 	headroom = mergeable_ctx_to_headroom(mrg_ctx);
 	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	room = SKB_DATA_ALIGN(headroom + tailroom);
 
-	if (len > truesize - room) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)(truesize - room));
+	return mergeable_ctx_to_truesize(mrg_ctx) - room;
+}
+
+/* Length of the small buffer that add_recvbuf_small() posts. */
+static unsigned int small_buflen(const struct virtnet_info *vi)
+{
+	return vi->hdr_len + GOOD_PACKET_LEN;
+}
+
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int buflen = mergeable_ctx_to_buflen(mrg_ctx);
+
+	if (len > buflen) {
+		pr_debug("%s: rx error: len %u exceeds buffer length %u\n",
+			 dev->name, len, buflen);
 		DEV_STATS_INC(dev, rx_length_errors);
 		return -1;
 	}
@@ -645,11 +658,27 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	void *buf_ctx;
+	u32 buflen;
 	void *buf;
 
-	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
-		virtnet_rq_unmap(rq, buf, *len);
+	if (!rq->do_dma)
+		return virtqueue_get_buf_ctx(rq->vq, len, ctx);
+
+	buf = virtqueue_get_buf_ctx(rq->vq, len, &buf_ctx);
+	if (!buf)
+		return NULL;
+
+	/* The device chooses *len. Sync only the buffer that was posted, so
+	 * that a larger *len cannot copy over the buffers next to it.
+	 */
+	buflen = vi->mergeable_rx_bufs ? mergeable_ctx_to_buflen(buf_ctx) :
+					 small_buflen(vi);
+	virtnet_rq_unmap(rq, buf, min(*len, buflen));
+
+	if (ctx)
+		*ctx = buf_ctx;
 
 	return buf;
 }
@@ -1905,7 +1934,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	buf += VIRTNET_RX_PAD + xdp_headroom;
 
-	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
+	virtnet_rq_init_one_sg(rq, buf, small_buflen(vi));
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-- 
2.54.0

