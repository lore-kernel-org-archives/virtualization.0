Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E361BC4742C
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E68422201
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSKdvN8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E68422201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 681A88757D;
	Fri, 13 Nov 2020 13:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mW0hbsZVD4mH; Fri, 13 Nov 2020 13:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E3A087527;
	Fri, 13 Nov 2020 13:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35865C0891;
	Fri, 13 Nov 2020 13:47:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D52DC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78EA0877FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KnXlAkUYbIpD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 740B3877F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAQav1fBIqPqdo/zQY8212U1aeWb6xahiX49XYQcPaE=;
 b=eSKdvN8MzyOO0XIqbgDJ/fia0GnBFcu/z8wIKLYyq+tnRYSi+XJNMN690aYhpsmfgaCZBg
 gvLjVeQcsayoTEIM/49aBr5usxgQRzHUER5AMqhtWvQ7yitIBIImfCvCyPS3Thpg/vFrdu
 7WYoEtK/LG3QlmoMWlPhfUlQLp9/XtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-cyopPrOhM1a0Dbhj-Kh-QQ-1; Fri, 13 Nov 2020 08:47:28 -0500
X-MC-Unique: cyopPrOhM1a0Dbhj-Kh-QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04FB8030B6;
 Fri, 13 Nov 2020 13:47:26 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92EE36198C;
 Fri, 13 Nov 2020 13:47:24 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
Date: Fri, 13 Nov 2020 14:47:02 +0100
Message-Id: <20201113134712.69744-3-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
preparation for adding a vdpa simulator module for block devices.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: various cleanups/fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- Removed unused headers
- Removed empty module_init() module_exit()
- Moved vdpasim_is_little_endian() in vdpa_sim.h
- Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
- Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
  option can not depend on other [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 110 +++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 285 ++++++---------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 153 ++++++++++++++
 drivers/vdpa/Kconfig                 |   7 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 5 files changed, 329 insertions(+), 227 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
new file mode 100644
index 000000000000..33613c49888c
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ */
+
+#ifndef _VDPA_SIM_H
+#define _VDPA_SIM_H
+
+#include <linux/vringh.h>
+#include <linux/vdpa.h>
+#include <linux/vhost_iotlb.h>
+#include <uapi/linux/virtio_config.h>
+#include <uapi/linux/virtio_net.h>
+#include <uapi/linux/virtio_blk.h>
+
+#define DRV_VERSION  "0.1"
+#define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
+#define DRV_LICENSE  "GPL v2"
+
+#define VDPASIM_QUEUE_ALIGN PAGE_SIZE
+#define VDPASIM_QUEUE_MAX 256
+#define VDPASIM_VENDOR_ID 0
+#define VDPASIM_VQ_NUM 0x2
+
+#define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
+				 (1ULL << VIRTIO_F_VERSION_1)  | \
+				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
+
+struct vdpasim;
+
+struct vdpasim_virtqueue {
+	struct vringh vring;
+	struct vringh_kiov iov;
+	unsigned short head;
+	bool ready;
+	u64 desc_addr;
+	u64 device_addr;
+	u64 driver_addr;
+	u32 num;
+	void *private;
+	irqreturn_t (*cb)(void *data);
+};
+
+struct vdpasim_init_attr {
+	u32		device_id;
+	u64		features;
+	work_func_t	work_fn;
+	int		batch_mapping;
+};
+
+/* State of each vdpasim device */
+struct vdpasim {
+	struct vdpa_device vdpa;
+	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
+	struct work_struct work;
+	/* spinlock to synchronize virtqueue state */
+	spinlock_t lock;
+	/* virtio config according to device type */
+	void *config;
+	struct vhost_iotlb *iommu;
+	void *buffer;
+	u32 device_id;
+	u32 status;
+	u32 generation;
+	u64 features;
+	u64 supported_features;
+	/* spinlock to synchronize iommu table */
+	spinlock_t iommu_lock;
+};
+
+struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr);
+
+/* TODO: cross-endian support */
+static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
+{
+	return virtio_legacy_is_little_endian() ||
+		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
+static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
+{
+	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
+{
+	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline u32 vdpasim32_to_cpu(struct vdpasim *vdpasim, __virtio32 val)
+{
+	return __virtio32_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio32 cpu_to_vdpasim32(struct vdpasim *vdpasim, u32 val)
+{
+	return __cpu_to_virtio32(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline u64 vdpasim64_to_cpu(struct vdpasim *vdpasim, __virtio64 val)
+{
+	return __virtio64_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio64 cpu_to_vdpasim64(struct vdpasim *vdpasim, u64 val)
+{
+	return __cpu_to_virtio64(vdpasim_is_little_endian(vdpasim), val);
+}
+
+#endif
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..04f9dc9ce8c8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -1,107 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * VDPA networking device simulator.
+ * VDPA simulator core.
  *
  * Copyright (c) 2020, Red Hat Inc. All rights reserved.
  *     Author: Jason Wang <jasowang@redhat.com>
  *
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/uuid.h>
-#include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
-#include <linux/sysfs.h>
-#include <linux/file.h>
-#include <linux/etherdevice.h>
-#include <linux/vringh.h>
-#include <linux/vdpa.h>
-#include <linux/virtio_byteorder.h>
-#include <linux/vhost_iotlb.h>
-#include <uapi/linux/virtio_config.h>
-#include <uapi/linux/virtio_net.h>
-
-#define DRV_VERSION  "0.1"
-#define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
-#define DRV_DESC     "vDPA Device Simulator"
-#define DRV_LICENSE  "GPL v2"
-
-static int batch_mapping = 1;
-module_param(batch_mapping, int, 0444);
-MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
-
-static char *macaddr;
-module_param(macaddr, charp, 0);
-MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
-
-struct vdpasim_virtqueue {
-	struct vringh vring;
-	struct vringh_kiov iov;
-	unsigned short head;
-	bool ready;
-	u64 desc_addr;
-	u64 device_addr;
-	u64 driver_addr;
-	u32 num;
-	void *private;
-	irqreturn_t (*cb)(void *data);
-};
-
-#define VDPASIM_QUEUE_ALIGN PAGE_SIZE
-#define VDPASIM_QUEUE_MAX 256
-#define VDPASIM_DEVICE_ID 0x1
-#define VDPASIM_VENDOR_ID 0
-#define VDPASIM_VQ_NUM 0x2
-#define VDPASIM_NAME "vdpasim-netdev"
-
-static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			      (1ULL << VIRTIO_F_VERSION_1)  |
-			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			      (1ULL << VIRTIO_NET_F_MAC);
-
-/* State of each vdpasim device */
-struct vdpasim {
-	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
-	struct work_struct work;
-	/* spinlock to synchronize virtqueue state */
-	spinlock_t lock;
-	struct virtio_net_config config;
-	struct vhost_iotlb *iommu;
-	void *buffer;
-	u32 status;
-	u32 generation;
-	u64 features;
-	/* spinlock to synchronize iommu table */
-	spinlock_t iommu_lock;
-};
-
-/* TODO: cross-endian support */
-static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
-{
-	return virtio_legacy_is_little_endian() ||
-		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
-}
-
-static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
-{
-	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
-}
-
-static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
-{
-	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
-}
 
-static struct vdpasim *vdpasim_dev;
+#include "vdpa_sim.h"
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
@@ -119,7 +28,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
 			  VDPASIM_QUEUE_MAX, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
@@ -128,7 +37,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->device_addr);
 }
 
-static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
+static void vdpasim_vq_reset(struct vdpasim *vdpasim,
+			     struct vdpasim_virtqueue *vq)
 {
 	vq->ready = false;
 	vq->desc_addr = 0;
@@ -136,8 +46,8 @@ static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
 	vq->device_addr = 0;
 	vq->cb = NULL;
 	vq->private = NULL;
-	vringh_init_iotlb(&vq->vring, vdpasim_features, VDPASIM_QUEUE_MAX,
-			  false, NULL, NULL, NULL);
+	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
+			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
 }
 
 static void vdpasim_reset(struct vdpasim *vdpasim)
@@ -145,7 +55,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	int i;
 
 	for (i = 0; i < VDPASIM_VQ_NUM; i++)
-		vdpasim_vq_reset(&vdpasim->vqs[i]);
+		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_reset(vdpasim->iommu);
@@ -156,80 +66,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	++vdpasim->generation;
 }
 
-static void vdpasim_work(struct work_struct *work)
-{
-	struct vdpasim *vdpasim = container_of(work, struct
-						 vdpasim, work);
-	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
-	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
-	ssize_t read, write;
-	size_t total_write;
-	int pkts = 0;
-	int err;
-
-	spin_lock(&vdpasim->lock);
-
-	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		goto out;
-
-	if (!txq->ready || !rxq->ready)
-		goto out;
-
-	while (true) {
-		total_write = 0;
-		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
-					   &txq->head, GFP_ATOMIC);
-		if (err <= 0)
-			break;
-
-		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
-					   &rxq->head, GFP_ATOMIC);
-		if (err <= 0) {
-			vringh_complete_iotlb(&txq->vring, txq->head, 0);
-			break;
-		}
-
-		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
-						     vdpasim->buffer,
-						     PAGE_SIZE);
-			if (read <= 0)
-				break;
-
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
-						      vdpasim->buffer, read);
-			if (write <= 0)
-				break;
-
-			total_write += write;
-		}
-
-		/* Make sure data is wrote before advancing index */
-		smp_wmb();
-
-		vringh_complete_iotlb(&txq->vring, txq->head, 0);
-		vringh_complete_iotlb(&rxq->vring, rxq->head, total_write);
-
-		/* Make sure used is visible before rasing the interrupt. */
-		smp_wmb();
-
-		local_bh_disable();
-		if (txq->cb)
-			txq->cb(txq->private);
-		if (rxq->cb)
-			rxq->cb(rxq->private);
-		local_bh_enable();
-
-		if (++pkts > 4) {
-			schedule_work(&vdpasim->work);
-			goto out;
-		}
-	}
-
-out:
-	spin_unlock(&vdpasim->lock);
-}
-
 static int dir_to_perm(enum dma_data_direction dir)
 {
 	int perm = -EFAULT;
@@ -342,26 +178,42 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 	.free = vdpasim_free_coherent,
 };
 
-static const struct vdpa_config_ops vdpasim_net_config_ops;
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
+static const struct vdpa_config_ops vdpasim_config_ops;
+static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-static struct vdpasim *vdpasim_create(void)
+struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 {
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
+	u32 device_id;
 	struct device *dev;
-	int ret = -ENOMEM;
+	int i, size, ret = -ENOMEM;
 
-	if (batch_mapping)
-		ops = &vdpasim_net_batch_config_ops;
+	device_id = attr->device_id;
+	/* Currently, we only accept the network and block devices. */
+	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (attr->batch_mapping)
+		ops = &vdpasim_batch_config_ops;
 	else
-		ops = &vdpasim_net_config_ops;
+		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
 	if (!vdpasim)
 		goto err_alloc;
 
-	INIT_WORK(&vdpasim->work, vdpasim_work);
+	if (device_id == VIRTIO_ID_NET)
+		size = sizeof(struct virtio_net_config);
+	else
+		size = sizeof(struct virtio_blk_config);
+	vdpasim->config = kzalloc(size, GFP_KERNEL);
+	if (!vdpasim->config)
+		goto err_iommu;
+
+	vdpasim->device_id = device_id;
+	vdpasim->supported_features = attr->features;
+	INIT_WORK(&vdpasim->work, attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
@@ -379,23 +231,10 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	if (macaddr) {
-		mac_pton(macaddr, vdpasim->config.mac);
-		if (!is_valid_ether_addr(vdpasim->config.mac)) {
-			ret = -EADDRNOTAVAIL;
-			goto err_iommu;
-		}
-	} else {
-		eth_random_addr(vdpasim->config.mac);
-	}
-
-	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
-	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
+	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
-	ret = vdpa_register_device(&vdpasim->vdpa);
-	if (ret)
-		goto err_iommu;
 
 	return vdpasim;
 
@@ -404,6 +243,7 @@ static struct vdpasim *vdpasim_create(void)
 err_alloc:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(vdpasim_create);
 
 static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				  u64 desc_area, u64 driver_area,
@@ -498,28 +338,34 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 
 static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 {
-	return vdpasim_features;
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	return vdpasim->supported_features;
 }
 
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-	struct virtio_net_config *config = &vdpasim->config;
 
 	/* DMA mapping must be done by driver */
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return -EINVAL;
 
-	vdpasim->features = features & vdpasim_features;
+	vdpasim->features = features & vdpasim->supported_features;
 
 	/* We generally only know whether guest is using the legacy interface
 	 * here, so generally that's the earliest we can set config fields.
 	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
 	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
 	 */
+	if (vdpasim->device_id == VIRTIO_ID_NET) {
+		struct virtio_net_config *config =
+			(struct virtio_net_config *)vdpasim->config;
+
+		config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+		config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+	}
 
-	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
-	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 	return 0;
 }
 
@@ -536,7 +382,9 @@ static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
 
 static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
 {
-	return VDPASIM_DEVICE_ID;
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	return vdpasim->device_id;
 }
 
 static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
@@ -572,8 +420,12 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
+	if (vdpasim->device_id == VIRTIO_ID_BLOCK &&
+	    (offset + len < sizeof(struct virtio_blk_config)))
+		memcpy(buf, vdpasim->config + offset, len);
+	else if (vdpasim->device_id == VIRTIO_ID_NET &&
+		 (offset + len < sizeof(struct virtio_net_config)))
+		memcpy(buf, vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
@@ -659,9 +511,10 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
+	kfree(vdpasim->config);
 }
 
-static const struct vdpa_config_ops vdpasim_net_config_ops = {
+static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
@@ -688,7 +541,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.free                   = vdpasim_free,
 };
 
-static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
+static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
 	.set_vq_num             = vdpasim_set_vq_num,
 	.kick_vq                = vdpasim_kick_vq,
@@ -714,27 +567,7 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
 	.free                   = vdpasim_free,
 };
 
-static int __init vdpasim_dev_init(void)
-{
-	vdpasim_dev = vdpasim_create();
-
-	if (!IS_ERR(vdpasim_dev))
-		return 0;
-
-	return PTR_ERR(vdpasim_dev);
-}
-
-static void __exit vdpasim_dev_exit(void)
-{
-	struct vdpa_device *vdpa = &vdpasim_dev->vdpa;
-
-	vdpa_unregister_device(vdpa);
-}
-
-module_init(vdpasim_dev_init)
-module_exit(vdpasim_dev_exit)
-
 MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE(DRV_LICENSE);
 MODULE_AUTHOR(DRV_AUTHOR);
-MODULE_DESCRIPTION(DRV_DESC);
+MODULE_DESCRIPTION("vDPA Simulator core");
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
new file mode 100644
index 000000000000..c68d5488ab54
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VDPA simulator for networking device.
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ *     Author: Jason Wang <jasowang@redhat.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/etherdevice.h>
+
+#include "vdpa_sim.h"
+
+#define VDPASIM_NET_FEATURES	(1ULL << VIRTIO_NET_F_MAC)
+
+static int batch_mapping = 1;
+module_param(batch_mapping, int, 0444);
+MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 - Enable; 0 - Disable");
+
+static char *macaddr;
+module_param(macaddr, charp, 0);
+MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
+
+static struct vdpasim *vdpasim_net_dev;
+
+static void vdpasim_net_work(struct work_struct *work)
+{
+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
+	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
+	ssize_t read, write;
+	size_t total_write;
+	int pkts = 0;
+	int err;
+
+	spin_lock(&vdpasim->lock);
+
+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
+	if (!txq->ready || !rxq->ready)
+		goto out;
+
+	while (true) {
+		total_write = 0;
+		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
+					   &txq->head, GFP_ATOMIC);
+		if (err <= 0)
+			break;
+
+		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
+					   &rxq->head, GFP_ATOMIC);
+		if (err <= 0) {
+			vringh_complete_iotlb(&txq->vring, txq->head, 0);
+			break;
+		}
+
+		while (true) {
+			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
+						     vdpasim->buffer,
+						     PAGE_SIZE);
+			if (read <= 0)
+				break;
+
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
+						      vdpasim->buffer, read);
+			if (write <= 0)
+				break;
+
+			total_write += write;
+		}
+
+		/* Make sure data is wrote before advancing index */
+		smp_wmb();
+
+		vringh_complete_iotlb(&txq->vring, txq->head, 0);
+		vringh_complete_iotlb(&rxq->vring, rxq->head, total_write);
+
+		/* Make sure used is visible before rasing the interrupt. */
+		smp_wmb();
+
+		local_bh_disable();
+		if (txq->cb)
+			txq->cb(txq->private);
+		if (rxq->cb)
+			rxq->cb(rxq->private);
+		local_bh_enable();
+
+		if (++pkts > 4) {
+			schedule_work(&vdpasim->work);
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock(&vdpasim->lock);
+}
+
+static int __init vdpasim_net_init(void)
+{
+	struct vdpasim_init_attr attr = {};
+	struct virtio_net_config *config;
+	int ret;
+
+	attr.device_id = VIRTIO_ID_NET;
+	attr.features = VDPASIM_FEATURES | VDPASIM_NET_FEATURES;
+	attr.work_fn = vdpasim_net_work;
+	attr.batch_mapping = batch_mapping;
+	vdpasim_net_dev = vdpasim_create(&attr);
+	if (IS_ERR(vdpasim_net_dev)) {
+		ret = PTR_ERR(vdpasim_net_dev);
+		goto out;
+	}
+
+	config = (struct virtio_net_config *)vdpasim_net_dev->config;
+
+	if (macaddr) {
+		mac_pton(macaddr, config->mac);
+		if (!is_valid_ether_addr(config->mac)) {
+			ret = -EADDRNOTAVAIL;
+			goto put_dev;
+		}
+	} else {
+		eth_random_addr(config->mac);
+	}
+
+	ret = vdpa_register_device(&vdpasim_net_dev->vdpa);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	put_device(&vdpasim_net_dev->vdpa.dev);
+out:
+	return ret;
+}
+
+static void __exit vdpasim_net_exit(void)
+{
+	struct vdpa_device *vdpa = &vdpasim_net_dev->vdpa;
+
+	vdpa_unregister_device(vdpa);
+}
+
+module_init(vdpasim_net_init);
+module_exit(vdpasim_net_exit);
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE(DRV_LICENSE);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("vDPA Device Simulator for networking device");
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index d7d32b656102..fdb1a9267347 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -9,11 +9,16 @@ menuconfig VDPA
 if VDPA
 
 config VDPA_SIM
-	tristate "vDPA device simulator"
+	tristate "vDPA simulator core"
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select DMA_OPS
 	select VHOST_RING
 	default n
+
+config VDPA_SIM_NET
+	tristate "vDPA simulator for networking device"
+	depends on VDPA_SIM
+	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
 	  to RX. This device is used for testing, prototyping and
diff --git a/drivers/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
index b40278f65e04..79d4536d347e 100644
--- a/drivers/vdpa/vdpa_sim/Makefile
+++ b/drivers/vdpa/vdpa_sim/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim.o
+obj-$(CONFIG_VDPA_SIM_NET) += vdpa_sim_net.o
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
