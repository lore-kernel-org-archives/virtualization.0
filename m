Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EDFCCA486
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8286684849;
	Fri, 24 Jun 2022 02:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8286684849
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ndX2Me_FUxsE; Fri, 24 Jun 2022 02:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 099EC84839;
	Fri, 24 Jun 2022 02:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 099EC84839
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC602C0032;
	Fri, 24 Jun 2022 02:57:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07B98C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2C5B405D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2C5B405D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id URMWy0SyCpJz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9443E40CB5
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9443E40CB5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:37 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHEuW6w_1656039449; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHEuW6w_1656039449) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:57:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 30/41] virtio_pci: extract the logic of active vq for
 modern pci
Date: Fri, 24 Jun 2022 10:56:10 +0800
Message-Id: <20220624025621.128843-31-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fef800c86cd2
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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

Introduce vp_active_vq() to configure vring to backend after vq attach
vring. And configure vq vector if necessary.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 46 ++++++++++++++++++------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e7e0b8c850f6..9041d9a41b7d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -176,6 +176,29 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_synchronize_vectors(vdev);
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
