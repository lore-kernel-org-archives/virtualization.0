Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C00C63684
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 07:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0D9140939;
	Wed, 26 Jan 2022 07:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhzjX_fF7ieS; Wed, 26 Jan 2022 07:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19AB940183;
	Wed, 26 Jan 2022 07:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8FF5C0031;
	Wed, 26 Jan 2022 07:35:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE75C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB8B340183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hn4DfvK4A8Ez
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6C104049A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2ubkkx_1643182543; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2ubkkx_1643182543) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 15:35:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 09/17] virtio_ring: queue_reset: add vring_reset_virtqueue()
Date: Wed, 26 Jan 2022 15:35:25 +0800
Message-Id: <20220126073533.44994-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
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

Added vring_reset_virtqueue() for reset vring_virtqueue.

In this process, vq is removed from the vdev->vqs queue. And the memory
of the ring is released

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++++++++-
 include/linux/virtio_ring.h  |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4beb7c7127c1..bba9f3c67b33 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2391,11 +2391,21 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	__vring_del_virtqueue(vq);
+	if (!_vq->reset)
+		__vring_del_virtqueue(vq);
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
 
+void vring_reset_virtqueue(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	__vring_del_virtqueue(vq);
+	_vq->reset = true;
+}
+EXPORT_SYMBOL_GPL(vring_reset_virtqueue);
+
 /* Manipulates transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev)
 {
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index e90323fce4bf..84b55fb8686d 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -124,6 +124,11 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
  */
 void vring_del_virtqueue(struct virtqueue *vq);
 
+/*
+ * Resets a virtqueue. Just frees the ring, not free vq.
+ */
+void vring_reset_virtqueue(struct virtqueue *vq);
+
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
