Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A86CCA483
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87CDA400A6;
	Fri, 24 Jun 2022 02:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87CDA400A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCkSJhgBqReJ; Fri, 24 Jun 2022 02:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E84B140524;
	Fri, 24 Jun 2022 02:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E84B140524
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23AF4C0083;
	Fri, 24 Jun 2022 02:56:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B1BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44C74410AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44C74410AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Me5u5aWgg2rh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74D8640998
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74D8640998
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHF1U5t_1656039383; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHF1U5t_1656039383) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:56:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 01/41] remoteproc: rename len of rpoc_vring to num
Date: Fri, 24 Jun 2022 10:55:41 +0800
Message-Id: <20220624025621.128843-2-xuanzhuo@linux.alibaba.com>
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

Rename the member len in the structure rpoc_vring to num. And remove 'in
bytes' from the comment of it. This is misleading. Because this actually
refers to the size of the virtio vring to be created. The unit is not
bytes.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/remoteproc/remoteproc_core.c   |  4 ++--
 drivers/remoteproc/remoteproc_virtio.c | 10 +++++-----
 include/linux/remoteproc.h             |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..2d2f3bab5888 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -334,7 +334,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	size_t size;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_size(rvring->num, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
@@ -401,7 +401,7 @@ rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
 		return -EINVAL;
 	}
 
-	rvring->len = vring->num;
+	rvring->num = vring->num;
 	rvring->align = vring->align;
 	rvring->rvdev = rvdev;
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 70ab496d0431..d43d74733f0a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -87,7 +87,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	struct fw_rsc_vdev *rsc;
 	struct virtqueue *vq;
 	void *addr;
-	int len, size;
+	int num, size;
 
 	/* we're temporarily limited to two virtqueues per rvdev */
 	if (id >= ARRAY_SIZE(rvdev->vring))
@@ -104,20 +104,20 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 	rvring = &rvdev->vring[id];
 	addr = mem->va;
-	len = rvring->len;
+	num = rvring->num;
 
 	/* zero vring */
-	size = vring_size(len, rvring->align);
+	size = vring_size(num, rvring->align);
 	memset(addr, 0, size);
 
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
-		id, addr, len, rvring->notifyid);
+		id, addr, num, rvring->notifyid);
 
 	/*
 	 * Create the new vq, and tell virtio we're not interested in
 	 * the 'weak' smp barriers, since we're talking with a real device.
 	 */
-	vq = vring_new_virtqueue(id, len, rvring->align, vdev, false, ctx,
+	vq = vring_new_virtqueue(id, num, rvring->align, vdev, false, ctx,
 				 addr, rproc_virtio_notify, callback, name);
 	if (!vq) {
 		dev_err(dev, "vring_new_virtqueue %s failed\n", name);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c943f0a2fc4..aea79c77db0f 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -597,7 +597,7 @@ struct rproc_subdev {
 /**
  * struct rproc_vring - remoteproc vring state
  * @va:	virtual address
- * @len: length, in bytes
+ * @num: vring size
  * @da: device address
  * @align: vring alignment
  * @notifyid: rproc-specific unique vring index
@@ -606,7 +606,7 @@ struct rproc_subdev {
  */
 struct rproc_vring {
 	void *va;
-	int len;
+	int num;
 	u32 da;
 	u32 align;
 	int notifyid;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
