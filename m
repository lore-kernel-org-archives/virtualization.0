Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C5C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 049D781D70;
	Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sIaQEmATcJmb; Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B0AA81C67;
	Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 634BBC007E;
	Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 198BBC007A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D5AD81AC4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTO12GpsfUG4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F72A81A39
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzpPIr_1650768049; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzpPIr_1650768049) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/16] virtio_ring: split: introduce
 vring_reuse_bufs_split()
Date: Sun, 24 Apr 2022 10:40:34 +0800
Message-Id: <20220424024044.94749-7-xuanzhuo@linux.alibaba.com>
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

This patch will resubmit the buffers to the new vq in the order in which
they were submitted.

In order to get these buffers in order, the patch will get the buffers
from the avail ring. We can know the current position of the avail ring
from vring.avail->idx.

First, check backward from idx. If a state appears repeatedly, it means
that the buffer corresponding to this state has been consumed by the
device and resubmitted. We will remove the subsequent state from the
queue. Then move forward from the position where idx ends, the buffers
encountered at this time are the order in which they were submitted.

It is beneficial to ensure the order of buffers in the process of reuse.
For example, under virtio-net, if the order is not guaranteed, it may
lead to out-of-order tcp streams.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 167442cfdb2a..02d4ffcc0a3b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,6 +69,7 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	bool checked;
 };
 
 struct vring_desc_state_packed {
@@ -1007,6 +1008,70 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 	return true;
 }
 
+static void vring_reuse_bufs_split(struct vring_virtqueue *vq,
+				   struct vring_virtqueue_split *vring,
+				   void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	u32 head, num, idx, oidx, i, desc_num = 0;
+	u16 null, *p;
+	int err = 0;
+	void *buf;
+
+	num = vring->vring.num;
+
+	oidx = le16_to_cpu(vring->vring.avail->idx) - 1;
+	null = vring->vring.avail->ring[oidx & (num - 1)];
+
+	/*
+	 * Check in the opposite direction in the avail ring. If a state appears
+	 * repeatedly, it means that the state has been used and rejoined the
+	 * avail ring.
+	 */
+	for (i = 0, idx = oidx; i < num; ++i, --idx) {
+		p = &vring->vring.avail->ring[idx & (num - 1)];
+
+		head = virtio32_to_cpu(vq->vq.vdev, *p);
+
+		if (vring->desc_state[head].checked) {
+			*p = null;
+			continue;
+		}
+
+		vring->desc_state[head].checked = true;
+	}
+
+	/*
+	 * Checking the avail ring forward, the non-null states encountered are
+	 * the order in which they were added to the avail ring.
+	 */
+	for (i = 0, ++idx; i < num; ++i, ++idx) {
+		p = &vring->vring.avail->ring[idx & (num - 1)];
+		if (*p == null && idx != oidx)
+			continue;
+
+		head = virtio32_to_cpu(vq->vq.vdev, *p);
+
+		if (!vring->desc_state[head].data)
+			continue;
+
+		/* once add to vq fail, no more try add to vq. */
+		if (err >= 0) {
+			err = vring_copy_to_vq_split(vq, vring, head);
+			if (err >= 0) {
+				desc_num += err;
+				continue;
+			}
+		}
+
+		buf = vring->desc_state[head].data;
+		desc_num += detach_buf_from_vring_split(vring, vq, head, 0,
+							NULL);
+		recycle(&vq->vq, buf);
+	}
+
+	WARN_ON(vring->num_left != desc_num);
+}
+
 static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
