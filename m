Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9888C43217
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F286417B2;
	Tue,  8 Mar 2022 12:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjesUOCQV5eU; Tue,  8 Mar 2022 12:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0CF81417AB;
	Tue,  8 Mar 2022 12:36:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D66C001D;
	Tue,  8 Mar 2022 12:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7F07C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C491A60FC9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rn8f44rXByif
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 868DE60FDD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V6ebqXo_1646742953; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6ebqXo_1646742953) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 20:35:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 16/26] virtio_pci: queue_reset: extract the logic of active
 vq for modern pci
Date: Tue,  8 Mar 2022 20:35:08 +0800
Message-Id: <20220308123518.33800-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: f06b131dbfed
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

Introduce vp_active_vq() to configure vring to backend after vq attach
vring. And configure vq vector if necessary.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern.c | 46 ++++++++++++++++++------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 86d301f272b8..49a4493732cf 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -176,6 +176,29 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_disable_cbs(vdev);
 }
 
+static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	unsigned long index;
+
+	index = vq->index;
+
+	/* activate the queue */
+	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
+	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
+				virtqueue_get_avail_addr(vq),
+				virtqueue_get_used_addr(vq));
+
+	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
+		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
+		if (msix_vec == VIRTIO_MSI_NO_VECTOR)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
 	return vp_modern_config_vector(&vp_dev->mdev, vector);
@@ -220,32 +243,19 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	vq->num_max = num;
 
-	/* activate the queue */
-	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
-	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
-				virtqueue_get_avail_addr(vq),
-				virtqueue_get_used_addr(vq));
+	err = vp_active_vq(vq, msix_vec);
+	if (err)
+		goto err;
 
 	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
 	if (!vq->priv) {
 		err = -ENOMEM;
-		goto err_map_notify;
-	}
-
-	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
-		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
-			err = -EBUSY;
-			goto err_assign_vector;
-		}
+		goto err;
 	}
 
 	return vq;
 
-err_assign_vector:
-	if (!mdev->notify_base)
-		pci_iounmap(mdev->pci_dev, (void __iomem __force *)vq->priv);
-err_map_notify:
+err:
 	vring_del_virtqueue(vq);
 	return ERR_PTR(err);
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
