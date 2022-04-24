Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442A5C43219
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D14CD4060F;
	Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZqovVtjJaZLf; Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 592C2405F8;
	Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D4EEC008E;
	Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C64AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AD62403AA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjaCs_IBeyzV
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41A954049F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzbmry_1650768053; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzbmry_1650768053) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/16] virtio_ring: packed: introduce
 vring_virtqueue_detach_packed()
Date: Sun, 24 Apr 2022 10:40:38 +0800
Message-Id: <20220424024044.94749-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

The function vring_virtqueue_detach_packed() is introduced to detach the
vring of the current vq.

Add two new members. last_used_idx is used to record the position where
the current vring desc is used, which can be used to obtain buffers from
the vring in order. Another num_left records how many buffers there are,
which can be used to check the recovery of buffers completed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 436b18184dfe..219e008a4633 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -154,6 +154,10 @@ struct vring_virtqueue_packed {
 	dma_addr_t device_event_dma_addr;
 	size_t ring_size_in_bytes;
 	size_t event_size_in_bytes;
+
+	/* for vring detach */
+	u16 last_used_idx;
+	u32 num_left;
 };
 
 struct vring_virtqueue {
@@ -2090,6 +2094,25 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring)
 	return -ENOMEM;
 }
 
+static void vring_virtqueue_detach_packed(struct vring_virtqueue *vq,
+					  struct vring_virtqueue_packed *vring)
+{
+	vring->vring = vq->packed.vring;
+
+	vring->ring_dma_addr         = vq->packed.ring_dma_addr;
+	vring->driver_event_dma_addr = vq->packed.driver_event_dma_addr;
+	vring->device_event_dma_addr = vq->packed.device_event_dma_addr;
+
+	vring->ring_size_in_bytes    = vq->packed.ring_size_in_bytes;
+	vring->event_size_in_bytes   = vq->packed.event_size_in_bytes;
+
+	vring->desc_state = vq->packed.desc_state;
+	vring->desc_extra = vq->packed.desc_extra;
+
+	vring->last_used_idx = vq->last_used_idx;
+	vring->num_left = vq->packed.vring.num - vq->vq.num_free;
+}
+
 static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
 					  struct vring_virtqueue_packed *vring)
 {
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
