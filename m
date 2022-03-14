Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EFAC43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34F8483E3A;
	Mon, 14 Mar 2022 09:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZKeAZu4K1u4; Mon, 14 Mar 2022 09:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C503D83E2F;
	Mon, 14 Mar 2022 09:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E877CC0089;
	Mon, 14 Mar 2022 09:35:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4C2C001D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B3DD4157E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JCaS6f1GP6Ep
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B31C4157C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V77QzE2_1647250508; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V77QzE2_1647250508) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 15/16] virtio_ring: packed: implement
 virtqueue_resize_packed()
Date: Mon, 14 Mar 2022 17:34:54 +0800
Message-Id: <20220314093455.34707-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d6feaa0fb7e7
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

virtio ring packed supports resize.

Only after the new vring is successfully allocated based on the new num,
we will release the old vring. In any case, an error is returned,
indicating that the vring still points to the old vring. In the case of
an error, we will re-initialize the state of the vring to ensure that
the vring can be used.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 73abc9e472ce..fb0abf9a2f57 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1968,6 +1968,34 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return NULL;
 }
 
+static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	struct vring_packed vring;
+	int err;
+
+	err = vring_alloc_queue_packed(&vring, vdev, num);
+	if (err)
+		goto err_queue;
+
+	err = vring_alloc_state_extra_packed(num, &vring);
+	if (err)
+		goto err_state_extra;
+
+	__vring_free(&vq->vq);
+
+	vring_virtqueue_attach_packed(vq, &vring);
+	vring_virtqueue_init_packed(vq, vdev);
+	return 0;
+
+err_state_extra:
+	vring_free_vring_packed(&vring, vdev);
+err_queue:
+	vring_virtqueue_init_packed(vq, vdev);
+	return -ENOMEM;
+}
+
 
 /*
  * Generic functions and exported symbols.
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
