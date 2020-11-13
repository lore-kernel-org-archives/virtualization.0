Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A730C4742C
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:49:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F0722201
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2+G5vX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F0722201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9BE268745B;
	Fri, 13 Nov 2020 13:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bituuflZRh9A; Fri, 13 Nov 2020 13:49:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0590187464;
	Fri, 13 Nov 2020 13:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B65C0891;
	Fri, 13 Nov 2020 13:49:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79C9CC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6869D86974
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0--5x7Rxst4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 76F6486936
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3r8/B+7cC6X7RvaWGidvwKg/ni8ZPyPCRRKcbTbrJM=;
 b=d2+G5vX2BiP/wawcjOdClPTejq2pT72TT3bY46lnQYTjrjyb7pcgeOgzboO0xwBSOkzqn0
 /QubdIYi+vZLLsrs1YJ/beQQHwSQp7BjcvoJu4ew4XVt1Dmpfr3nv9XSD3vZqoaSH8ohm3
 qzCeGL1zCCrwrVY6UsvjxNbM+yI5GNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-8jc7Dpz7NXe4sBQBG-oZEQ-1; Fri, 13 Nov 2020 08:49:19 -0500
X-MC-Unique: 8jc7Dpz7NXe4sBQBG-oZEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FAE21882FBD;
 Fri, 13 Nov 2020 13:49:18 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4CA5C1C7;
 Fri, 13 Nov 2020 13:49:07 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Date: Fri, 13 Nov 2020 14:47:12 +0100
Message-Id: <20201113134712.69744-13-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

The previous implementation wrote only the status of each request.
This patch implements a more accurate block device simulator,
providing a ramdisk-like behavior.

Also handle VIRTIO_BLK_T_GET_ID request, always answering the
"vdpa_blk_sim" string.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 151 +++++++++++++++++++++++----
 1 file changed, 133 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 8e41b3ab98d5..68e74383322f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/blkdev.h>
 #include <uapi/linux/virtio_blk.h>
 
 #include "vdpa_sim.h"
@@ -24,10 +25,137 @@
 
 static struct vdpasim *vdpasim_blk_dev;
 
+static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
+				  struct vdpasim_virtqueue *vq)
+{
+	size_t wrote = 0, to_read = 0, to_write = 0;
+	struct virtio_blk_outhdr hdr;
+	uint8_t status;
+	uint32_t type;
+	ssize_t bytes;
+	loff_t offset;
+	int i, ret;
+
+	vringh_kiov_cleanup(&vq->riov);
+	vringh_kiov_cleanup(&vq->wiov);
+
+	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
+				   &vq->head, GFP_ATOMIC);
+	if (ret != 1)
+		return ret;
+
+	for (i = 0; i < vq->wiov.used; i++)
+		to_write += vq->wiov.iov[i].iov_len;
+	to_write -= 1; /* last byte is the status */
+
+	for (i = 0; i < vq->riov.used; i++)
+		to_read += vq->riov.iov[i].iov_len;
+
+	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(hdr));
+	if (bytes != sizeof(hdr))
+		return 0;
+
+	to_read -= bytes;
+
+	type = le32_to_cpu(hdr.type);
+	offset = le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
+	status = VIRTIO_BLK_S_OK;
+
+	switch (type) {
+	case VIRTIO_BLK_T_IN:
+		if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
+			dev_err(&vdpasim->vdpa.dev,
+				"reading over the capacity - offset: 0x%llx len: 0x%lx\n",
+				offset, to_write);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov,
+					      vdpasim->buffer + offset,
+					      to_write);
+		if (bytes < 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"vringh_iov_push_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
+				bytes, offset, to_write);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		wrote += bytes;
+		break;
+
+	case VIRTIO_BLK_T_OUT:
+		if (offset + to_read > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
+			dev_err(&vdpasim->vdpa.dev,
+				"writing over the capacity - offset: 0x%llx len: 0x%lx\n",
+				offset, to_read);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov,
+					      vdpasim->buffer + offset,
+					      to_read);
+		if (bytes < 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"vringh_iov_pull_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
+				bytes, offset, to_read);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+		break;
+
+	case VIRTIO_BLK_T_GET_ID: {
+		char id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
+
+		bytes = vringh_iov_push_iotlb(&vq->vring,
+					      &vq->wiov, id,
+					      VIRTIO_BLK_ID_BYTES);
+		if (bytes < 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"vringh_iov_push_iotlb() error: %ld\n", bytes);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		wrote += bytes;
+		break;
+	}
+
+	default:
+		dev_warn(&vdpasim->vdpa.dev,
+			 "Unsupported request type %d\n", type);
+		status = VIRTIO_BLK_S_IOERR;
+		break;
+	}
+
+	/* if VIRTIO_BLK_T_IN or VIRTIO_BLK_T_GET_ID fail, we need to skip
+	 * the remaining bytes to put the status in the last byte
+	 */
+	if (to_write - wrote > 0) {
+		vringh_iov_push_iotlb(&vq->vring, &vq->wiov, NULL,
+				      to_write - wrote);
+	}
+
+	/* last byte is the status */
+	bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
+	if (bytes != 1)
+		return 0;
+
+	wrote += bytes;
+
+	/* Make sure data is wrote before advancing index */
+	smp_wmb();
+
+	vringh_complete_iotlb(&vq->vring, vq->head, wrote);
+
+	return ret;
+}
+
 static void vdpasim_blk_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
-	u8 status = VIRTIO_BLK_S_OK;
 	int i;
 
 	spin_lock(&vdpasim->lock);
@@ -41,21 +169,7 @@ static void vdpasim_blk_work(struct work_struct *work)
 		if (!vq->ready)
 			continue;
 
-		while (vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
-					    &vq->head, GFP_ATOMIC) > 0) {
-
-			int write;
-
-			vq->wiov.i = vq->wiov.used - 1;
-			write = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
-			if (write <= 0)
-				break;
-
-			/* Make sure data is wrote before advancing index */
-			smp_wmb();
-
-			vringh_complete_iotlb(&vq->vring, vq->head, write);
-
+		while (vdpasim_blk_handle_req(vdpasim, vq) > 0) {
 			/* Make sure used is visible before rasing the interrupt. */
 			smp_wmb();
 
@@ -67,6 +181,7 @@ static void vdpasim_blk_work(struct work_struct *work)
 				vq->cb(vq->private);
 			local_bh_enable();
 		}
+
 	}
 out:
 	spin_unlock(&vdpasim->lock);
@@ -84,7 +199,7 @@ static void vdpasim_blk_update_config(struct vdpasim *vdpasim)
 	config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
 	config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
 	config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
-	config->blk_size = cpu_to_vdpasim32(vdpasim, 512);
+	config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
 }
 
 static int __init vdpasim_blk_init(void)
@@ -100,7 +215,7 @@ static int __init vdpasim_blk_init(void)
 	attr.device.update_config = vdpasim_blk_update_config;
 
 	attr.work_fn = vdpasim_blk_work;
-	attr.buffer_size = PAGE_SIZE;
+	attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
 
 	vdpasim_blk_dev = vdpasim_create(&attr);
 	if (IS_ERR(vdpasim_blk_dev)) {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
