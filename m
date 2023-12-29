Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E679CD
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E317082EC7
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E317082EC7
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2J0a27Z0MINk
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 07:31:18 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8DBBC82EE1
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DBBC82EE1
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQtf.q_1703835071;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQtf.q_1703835071)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 02/27] virtio_net: unify the code for recycling the xmit ptr
Date: Fri, 29 Dec 2023 15:30:43 +0800
Message-Id: <20231229073108.57778-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

There are two completely similar and independent implementations. This
is inconvenient for the subsequent addition of new types. So extract a
function from this piece of code and call this function uniformly to
recover old xmit ptr.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 66 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7929f5d9d059..b01afd19061f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -351,6 +351,30 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static void __free_old_xmit(struct send_queue *sq, bool in_napi,
+			    u64 *bytes, u64 *packets)
+{
+	unsigned int len;
+	void *ptr;
+
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		if (!is_xdp_frame(ptr)) {
+			struct sk_buff *skb = ptr;
+
+			pr_debug("Sent skb %p\n", skb);
+
+			*bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			*bytes += xdp_get_frame_len(frame);
+			xdp_return_frame(frame);
+		}
+		(*packets)++;
+	}
+}
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -759,27 +783,9 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	unsigned int len;
-	unsigned int packets = 0;
-	unsigned int bytes = 0;
-	void *ptr;
-
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(!is_xdp_frame(ptr))) {
-			struct sk_buff *skb = ptr;
-
-			pr_debug("Sent skb %p\n", skb);
+	u64 bytes = 0, packets = 0;
 
-			bytes += skb->len;
-			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		}
-		packets++;
-	}
+	__free_old_xmit(sq, in_napi, &bytes, &packets);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -929,14 +935,11 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct receive_queue *rq = vi->rq;
+	u64 bytes = 0, packets = 0;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-	unsigned int len;
-	int packets = 0;
-	int bytes = 0;
 	int nxmit = 0;
 	int kicks = 0;
-	void *ptr;
 	int ret;
 	int i;
 
@@ -955,20 +958,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(is_xdp_frame(ptr))) {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		} else {
-			struct sk_buff *skb = ptr;
-
-			bytes += skb->len;
-			napi_consume_skb(skb, false);
-		}
-		packets++;
-	}
+	__free_old_xmit(sq, false, &bytes, &packets);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
-- 
2.32.0.3.g01195cf9f

