Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8719AC433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 08:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B8461013;
	Thu, 24 Feb 2022 08:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tx-Smgr0eDPo; Thu, 24 Feb 2022 08:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFF4761019;
	Thu, 24 Feb 2022 08:11:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A74EC0037;
	Thu, 24 Feb 2022 08:11:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1511C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E059C831CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eq0m5qvNjhxR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com
 [47.90.199.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF60E831C1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V5NJNBd_1645690279; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5NJNBd_1645690279) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 16:11:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 08/26] virtio_ring: extract the logic of freeing vring
Date: Thu, 24 Feb 2022 16:10:44 +0800
Message-Id: <20220224081102.80224-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: bd1c915e263f
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Introduce vring_free() to free the vring of vq.

Prevent double free by setting vq->reset.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 25 ++++++++++++++++++++-----
 include/linux/virtio.h       |  8 ++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 039015823c53..0b5360052ac2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2442,14 +2442,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-void vring_del_virtqueue(struct virtqueue *_vq)
+static void __vring_free(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	spin_lock(&vq->vq.vdev->vqs_list_lock);
-	list_del(&_vq->list);
-	spin_unlock(&vq->vq.vdev->vqs_list_lock);
-
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2480,6 +2476,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 	}
+}
+
+static void vring_free(struct virtqueue *vq)
+{
+	__vring_free(vq);
+	vq->reset = VIRTIO_VQ_RESET_STEP_VRING_RELEASE;
+}
+
+void vring_del_virtqueue(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	spin_lock(&vq->vq.vdev->vqs_list_lock);
+	list_del(&_vq->list);
+	spin_unlock(&vq->vq.vdev->vqs_list_lock);
+
+	if (_vq->reset != VIRTIO_VQ_RESET_STEP_VRING_RELEASE)
+		__vring_free(_vq);
+
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d59adc4be068..e3714e6db330 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,6 +10,13 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 
+enum virtio_vq_reset_step {
+	VIRTIO_VQ_RESET_STEP_NONE,
+	VIRTIO_VQ_RESET_STEP_DEVICE,
+	VIRTIO_VQ_RESET_STEP_VRING_RELEASE,
+	VIRTIO_VQ_RESET_STEP_VRING_ATTACH,
+};
+
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
  * @list: the chain of virtqueues for this device
@@ -33,6 +40,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	void *priv;
+	enum virtio_vq_reset_step reset;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
