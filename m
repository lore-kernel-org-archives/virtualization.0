Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D02C4332F
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 681C74055E;
	Sun, 24 Apr 2022 02:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxOcNRKg2JQt; Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1151C4090E;
	Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEFC9C0032;
	Sun, 24 Apr 2022 02:41:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FDEC007E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBF944055E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgFyL1NVzLTV
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com
 [47.90.199.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4B0D40641
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzbmsJ_1650768056; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzbmsJ_1650768056) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:57 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/16] virtio_ring: packed: introduce
 vring_reuse_bufs_packed()
Date: Sun, 24 Apr 2022 10:40:42 +0800
Message-Id: <20220424024044.94749-15-xuanzhuo@linux.alibaba.com>
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

vring_reuse_bufs_packed() checks vring.desc forward based on
last_used_idx. The resulting buffers are the order in which they were
committed.

It is beneficial to ensure the order of buffers in the process of reuse.
For example, under virtio-net, if the order is not guaranteed, it may
lead to out-of-order tcp streams.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8ca9985ffb4b..66f71e22ece0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2041,6 +2041,51 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	return true;
 }
 
+static void vring_reuse_bufs_packed(struct vring_virtqueue *vq,
+				    struct vring_virtqueue_packed *vring,
+				    void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_desc_state_packed *state;
+	u32 last_used, id, desc_num = 0;
+	int err = 0;
+	void *buf;
+
+	last_used = vring->last_used_idx;
+
+	do {
+		id = le16_to_cpu(vring->vring.desc[last_used].id);
+
+		state = &vring->desc_state[id];
+
+		if (!state->data) {
+			last_used++;
+			goto next;
+		}
+
+		/* once add to vq fail, no more try add to vq. */
+		if (err >= 0) {
+			err = vring_copy_to_vq_packed(vq, vring, id);
+			if (err >= 0)
+				goto ok;
+		}
+
+		buf = state->data;
+		detach_buf_from_vring_packed(vring, vq, id, 0, NULL);
+		recycle(&vq->vq, buf);
+
+ok:
+		last_used += state->num;
+		desc_num += state->num;
+
+next:
+		if (unlikely(last_used >= vring->vring.num))
+			last_used -= vring->vring.num;
+
+	} while (last_used != vring->last_used_idx);
+
+	WARN_ON(vring->num_left != desc_num);
+}
+
 static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
