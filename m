Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D8C433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:43:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9079864DDE
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9079864DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D8B6786E21;
	Thu, 28 Jan 2021 14:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8Wq1gTsyfkd; Thu, 28 Jan 2021 14:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15C5286E3F;
	Thu, 28 Jan 2021 14:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00A24C0FA8;
	Thu, 28 Jan 2021 14:43:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6989C08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C1236873B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xW1fheCn0xDI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C96358737E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611844987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7HCM/SNmx4ZimiXL2rXx+7Y6RyIQSv6irjastxz4Gs=;
 b=NaN1WTLdE0b+TSxNCU61lEwKzPhzhzppfmfaU2NeN3PIjitxmXeAn9XWpYlv/OVTeY65Qp
 fgMWSHUtDDWvdG6U/E7LhxJSzpJyXFd34FO822vBTdzQO677/mnh77kDRQ/r2wK9U15Y/m
 N+AaVfDjzn5C9ji0knbOhySnMiY0Kws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-_t3eUBPMNIGQYdF2gTYMLg-1; Thu, 28 Jan 2021 09:43:04 -0500
X-MC-Unique: _t3eUBPMNIGQYdF2gTYMLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CFF78030A5;
 Thu, 28 Jan 2021 14:43:03 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20B0F10023B1;
 Thu, 28 Jan 2021 14:43:00 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Date: Thu, 28 Jan 2021 15:41:25 +0100
Message-Id: <20210128144127.113245-9-sgarzare@redhat.com>
In-Reply-To: <20210128144127.113245-1-sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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
v2:
- rebased on top of other changes (dev_attr, get_config(), notify(), etc.)
- memset to 0 the config structure in vdpasim_blk_get_config()
- used vdpasim pointer in vdpasim_blk_get_config()

v1:
- Removed unused headers
- Used cpu_to_vdpasim*() to store config fields
- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
  option can not depend on other [Jason]
- Start with a single queue for now [Jason]
- Add comments to memory barriers
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 145 +++++++++++++++++++++++++++
 drivers/vdpa/Kconfig                 |   7 ++
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
new file mode 100644
index 000000000000..999f9ca0b628
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VDPA simulator for block device.
+ *
+ * Copyright (c) 2020, Mellanox Technologies. All rights reserved.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/vringh.h>
+#include <linux/vdpa.h>
+#include <uapi/linux/virtio_blk.h>
+
+#include "vdpa_sim.h"
+
+#define DRV_VERSION  "0.1"
+#define DRV_AUTHOR   "Max Gurtovoy <mgurtovoy@nvidia.com>"
+#define DRV_DESC     "vDPA Device Simulator for block device"
+#define DRV_LICENSE  "GPL v2"
+
+#define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
+				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
+				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
+				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
+				 (1ULL << VIRTIO_BLK_F_MQ))
+
+#define VDPASIM_BLK_CAPACITY	0x40000
+#define VDPASIM_BLK_SIZE_MAX	0x1000
+#define VDPASIM_BLK_SEG_MAX	32
+#define VDPASIM_BLK_VQ_NUM	1
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
+		while (vringh_getdesc_iotlb(&vq->vring, &vq->out_iov,
+					    &vq->in_iov, &vq->head,
+					    GFP_ATOMIC) > 0) {
+			int write;
+
+			vq->in_iov.i = vq->in_iov.used - 1;
+			write = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
+						      &status, 1);
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
+			local_bh_disable();
+			if (vringh_need_notify_iotlb(&vq->vring) > 0)
+				vringh_notify(&vq->vring);
+			local_bh_enable();
+		}
+	}
+out:
+	spin_unlock(&vdpasim->lock);
+}
+
+static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
+{
+	struct virtio_blk_config *blk_config =
+		(struct virtio_blk_config *)config;
+
+	memset(config, 0, sizeof(struct virtio_blk_config));
+
+	blk_config->capacity = cpu_to_vdpasim64(vdpasim, VDPASIM_BLK_CAPACITY);
+	blk_config->size_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SIZE_MAX);
+	blk_config->seg_max = cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_SEG_MAX);
+	blk_config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
+	blk_config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
+	blk_config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
+	blk_config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
+}
+
+static int __init vdpasim_blk_init(void)
+{
+	struct vdpasim_dev_attr dev_attr = {};
+	int ret;
+
+	dev_attr.id = VIRTIO_ID_BLOCK;
+	dev_attr.supported_features = VDPASIM_BLK_FEATURES;
+	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
+	dev_attr.config_size = sizeof(struct virtio_blk_config);
+	dev_attr.get_config = vdpasim_blk_get_config;
+	dev_attr.work_fn = vdpasim_blk_work;
+	dev_attr.buffer_size = PAGE_SIZE;
+
+	vdpasim_blk_dev = vdpasim_create(&dev_attr);
+	if (IS_ERR(vdpasim_blk_dev)) {
+		ret = PTR_ERR(vdpasim_blk_dev);
+		goto out;
+	}
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
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION(DRV_DESC);
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 21a23500f430..b8bd92cf04f9 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -26,6 +26,13 @@ config VDPA_SIM_NET
 	help
 	  vDPA networking device simulator which loops TX traffic back to RX.
 
+config VDPA_SIM_BLOCK
+	tristate "vDPA simulator for block device"
+	depends on VDPA_SIM
+	help
+	  vDPA block device simulator which terminates IO request in a
+	  memory buffer.
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
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
