Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F47C388F7
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126322223F
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ing+lxro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126322223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E820B87484;
	Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Epovt0vA7P6x; Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 557AD87464;
	Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40C74C0891;
	Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8CD3C0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A02C887474
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id omWEKHPGs2nF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9502687464
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y87cPiKi+KTWXY2cSxCtGVqk2vtdxTcbFuGGyIn+EBk=;
 b=Ing+lxroS8dW2NmMOUlWe757p1ZTYModoOFTUb6rwJ3oliZqIPzmdwdTpvcKMS500M2BlH
 P6GtqiV/cd9V8u8uYNIqhqWGvLRhqDY4oUrTEnr/bL43eG/0R1iT2h1b4KLfcX15Jv+PwR
 nOmIeC2u3Ik0FKISc1lz9QWxwJStcPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-CI_yqR2uOYqqBfFVO0Cb3Q-1; Fri, 13 Nov 2020 08:48:03 -0500
X-MC-Unique: CI_yqR2uOYqqBfFVO0Cb3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C83E51084CA2;
 Fri, 13 Nov 2020 13:48:01 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB8BB19C66;
 Fri, 13 Nov 2020 13:47:52 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Date: Fri, 13 Nov 2020 14:47:04 +0100
Message-Id: <20201113134712.69744-5-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

From: Max Gurtovoy <mgurtovoy@nvidia.com>

This will allow running vDPA for virtio block protocol.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: various cleanups/fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- Removed unused headers
- Used cpu_to_vdpasim*() to store config fields
- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
  option can not depend on other [Jason]
- Start with a single queue for now [Jason]
- Add comments to memory barriers
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 124 +++++++++++++++++++++++++++
 drivers/vdpa/Kconfig                 |   9 ++
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
new file mode 100644
index 000000000000..386dbb2f7138
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VDPA simulator for block device.
+ *
+ * Copyright (c) 2020, Mellanox Technologies. All rights reserved.
+ *
+ */
+
+#include <linux/module.h>
+
+#include "vdpa_sim.h"
+
+#define VDPASIM_BLK_FEATURES	((1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
+				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
+				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
+				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
+				 (1ULL << VIRTIO_BLK_F_MQ))
+
+#define VDPASIM_BLK_CAPACITY 0x40000
+#define VDPASIM_BLK_SIZE_MAX 0x1000
+#define VDPASIM_BLK_SEG_MAX 32
+#define VDPASIM_BLK_VQ_NUM 1
+
+static struct vdpasim *vdpasim_blk_dev;
+
+static void vdpasim_blk_work(struct work_struct *work)
+{
+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	u8 status = VIRTIO_BLK_S_OK;
+	int i;
+
+	spin_lock(&vdpasim->lock);
+
+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
+	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
+		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
+
+		if (!vq->ready)
+			continue;
+
+		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
+					    &vq->head, GFP_ATOMIC) > 0) {
+
+			int write;
+
+			vq->iov.i = vq->iov.used - 1;
+			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
+			if (write <= 0)
+				break;
+
+			/* Make sure data is wrote before advancing index */
+			smp_wmb();
+
+			vringh_complete_iotlb(&vq->vring, vq->head, write);
+
+			/* Make sure used is visible before rasing the interrupt. */
+			smp_wmb();
+
+			if (vringh_need_notify_iotlb(&vq->vring) > 0)
+				vringh_notify(&vq->vring);
+
+			local_bh_disable();
+			if (vq->cb)
+				vq->cb(vq->private);
+			local_bh_enable();
+		}
+	}
+out:
+	spin_unlock(&vdpasim->lock);
+
+}
+
+static int __init vdpasim_blk_init(void)
+{
+	struct vdpasim_init_attr attr = {};
+	struct virtio_blk_config *config;
+	int ret;
+
+	attr.device_id = VIRTIO_ID_BLOCK;
+	attr.features = VDPASIM_FEATURES | VDPASIM_BLK_FEATURES;
+	attr.work_fn = vdpasim_blk_work;
+	vdpasim_blk_dev = vdpasim_create(&attr);
+	if (IS_ERR(vdpasim_blk_dev)) {
+		ret = PTR_ERR(vdpasim_blk_dev);
+		goto out;
+	}
+
+	config = (struct virtio_blk_config *)vdpasim_blk_dev->config;
+	config->capacity = cpu_to_vdpasim64(vdpasim_blk_dev, VDPASIM_BLK_CAPACITY);
+	config->size_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SIZE_MAX);
+	config->seg_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SEG_MAX);
+	config->num_queues = cpu_to_vdpasim16(vdpasim_blk_dev, VDPASIM_BLK_VQ_NUM);
+	config->min_io_size = cpu_to_vdpasim16(vdpasim_blk_dev, 1);
+	config->opt_io_size = cpu_to_vdpasim32(vdpasim_blk_dev, 1);
+	config->blk_size = cpu_to_vdpasim32(vdpasim_blk_dev, 512);
+
+	ret = vdpa_register_device(&vdpasim_blk_dev->vdpa);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	put_device(&vdpasim_blk_dev->vdpa.dev);
+out:
+	return ret;
+}
+
+static void __exit vdpasim_blk_exit(void)
+{
+	struct vdpa_device *vdpa = &vdpasim_blk_dev->vdpa;
+
+	vdpa_unregister_device(vdpa);
+}
+
+module_init(vdpasim_blk_init)
+module_exit(vdpasim_blk_exit)
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE(DRV_LICENSE);
+MODULE_AUTHOR("Max Gurtovoy <mgurtovoy@nvidia.com>");
+MODULE_DESCRIPTION("vDPA Device Simulator for block device");
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index fdb1a9267347..0fb63362cd5d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -24,6 +24,15 @@ config VDPA_SIM_NET
 	  to RX. This device is used for testing, prototyping and
 	  development of vDPA.
 
+config VDPA_SIM_BLOCK
+	tristate "vDPA simulator for block device"
+	depends on VDPA_SIM
+	default n
+	help
+	  vDPA block device simulator which terminates IO request in a
+	  memory buffer. This device is used for testing, prototyping and
+	  development of vDPA.
+
 config IFCVF
 	tristate "Intel IFC VF vDPA driver"
 	depends on PCI_MSI
diff --git a/drivers/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
index 79d4536d347e..d458103302f2 100644
--- a/drivers/vdpa/vdpa_sim/Makefile
+++ b/drivers/vdpa/vdpa_sim/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim.o
 obj-$(CONFIG_VDPA_SIM_NET) += vdpa_sim_net.o
+obj-$(CONFIG_VDPA_SIM_BLOCK) += vdpa_sim_blk.o
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
