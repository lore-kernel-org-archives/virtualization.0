Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82299C64E7D
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:27:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD7D21741
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHwaa+XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD7D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D30B876A4;
	Thu, 26 Nov 2020 09:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3wvWe4el4BS; Thu, 26 Nov 2020 09:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DF788769C;
	Thu, 26 Nov 2020 09:27:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39828C0891;
	Thu, 26 Nov 2020 09:27:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2C13C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D1CFD87694
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GiXPAKA6vKlJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E320F876A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606382815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmbxnePLfcAghZps14WSyI06cxF/Rg3DrEYfTCuuSd8=;
 b=cHwaa+XY3r77fZLYtvq7MSTXcMdtfqYnAKJMzwD1HIkPt/TRY2OU/O7NpsBYkh6rvdIMpT
 GXMt0tliu4etqTc0IJn47iEopW5MbYKC02sJ6nbPW6M5GDkt8r8NIEpPd1ONqtzhhwxw5N
 j3iI58uYw8t29CxxX3kFZ+Q8MRSy4Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-PkwJy1JIPmyGD7VHAGNfDg-1; Thu, 26 Nov 2020 04:26:53 -0500
X-MC-Unique: PkwJy1JIPmyGD7VHAGNfDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 551B91084D60;
 Thu, 26 Nov 2020 09:26:52 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7874F19C71;
 Thu, 26 Nov 2020 09:26:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/14] vdpa: introduce virtio pci driver
Date: Thu, 26 Nov 2020 17:26:04 +0800
Message-Id: <20201126092604.208033-15-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

This patch introduce a vDPA driver for virtio-pci device. It bridges
the virtio-pci control command to the vDPA bus. This will be used for
features prototyping and testing.

Note that get/restore virtqueue state is not supported which needs
extension on the virtio specification.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Kconfig              |   6 +
 drivers/vdpa/Makefile             |   1 +
 drivers/vdpa/virtio_pci/Makefile  |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c | 450 ++++++++++++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index d7d32b656102..4cca53114cc4 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -47,4 +47,10 @@ config MLX5_VDPA_NET
 	  be executed by the hardware. It also supports a variety of stateless
 	  offloads depending on the actual device used and firmware version.
 
+config VP_VDPA
+	tristate "Virtio PCI bridge vDPA driver"
+	depends on PCI_MSI && VIRTIO_PCI_MODERN
+	help
+	  This kernel module that bridges virtio PCI device to vDPA bus.
+
 endif # VDPA
diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index d160e9b63a66..67fe7f3d6943 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_VDPA) += vdpa.o
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
 obj-$(CONFIG_IFCVF)    += ifcvf/
 obj-$(CONFIG_MLX5_VDPA) += mlx5/
+obj-$(CONFIG_VP_VDPA)    += virtio_pci/
diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
new file mode 100644
index 000000000000..231088d3af7d
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
new file mode 100644
index 000000000000..6458fa470566
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vDPA bridge driver for modern virtio-pci device
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ * Author: Jason Wang <jasowang@redhat.com>
+ *
+ * Based on virtio_pci_modern.c.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_pci.h>
+#include <linux/virtio_pci_modern.h>
+
+#define VP_VDPA_QUEUE_MAX 256
+#define VP_VDPA_DRIVER_NAME "vp_vdpa"
+
+struct vp_vring {
+	void __iomem *notify;
+	char msix_name[256];
+	struct vdpa_callback cb;
+	int irq;
+};
+
+struct vp_vdpa {
+	struct vdpa_device vdpa;
+	struct virtio_pci_modern_device mdev;
+	struct vp_vring *vring;
+	struct vdpa_callback cb;
+	char msix_name[256];
+	int config_irq;
+	int queues;
+	int vectors;
+};
+
+static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
+{
+	return container_of(vdpa, struct vp_vdpa, vdpa);
+}
+
+static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	return &vp_vdpa->mdev;
+}
+
+static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_features(mdev);
+}
+
+static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_features(mdev, features);
+
+	return 0;
+}
+
+static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_status(mdev);
+}
+
+static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
+	int i;
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
+			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
+			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
+				      &vp_vdpa->vring[i]);
+			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		}
+	}
+
+	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
+		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
+		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
+		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+	}
+
+	if (vp_vdpa->vectors) {
+		pci_free_irq_vectors(pdev);
+		vp_vdpa->vectors = 0;
+	}
+}
+
+static irqreturn_t vp_vdpa_vq_handler(int irq, void *arg)
+{
+	struct vp_vring *vring = arg;
+
+	if (vring->cb.callback)
+		return vring->cb.callback(vring->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
+{
+	struct vp_vdpa *vp_vdpa = arg;
+
+	if (vp_vdpa->cb.callback)
+		return vp_vdpa->cb.callback(vp_vdpa->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
+	int i, ret, irq;
+	int queues = vp_vdpa->queues;
+	int vectors = queues + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
+	if (ret != vectors) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
+			vectors, ret);
+		return ret;
+	}
+
+	vp_vdpa->vectors = vectors;
+
+	for (i = 0; i < queues; i++) {
+		snprintf(vp_vdpa->vring[i].msix_name, 256,
+			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
+		irq = pci_irq_vector(pdev, i);
+		ret = devm_request_irq(&pdev->dev, irq,
+				       vp_vdpa_vq_handler,
+				       0, vp_vdpa->vring[i].msix_name,
+				       &vp_vdpa->vring[i]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+		}
+		vp_modern_queue_vector(mdev, i, i);
+		vp_vdpa->vring[i].irq = irq;
+	}
+
+	snprintf(vp_vdpa->msix_name, 256, "vp-vdpa[%s]-config\n",
+		 pci_name(pdev));
+	irq = pci_irq_vector(pdev, queues);
+	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
+			       vp_vdpa->msix_name, vp_vdpa);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+	}
+	vp_modern_config_vector(mdev, queues);
+	vp_vdpa->config_irq = irq;
+
+	return 0;
+err:
+	vp_vdpa_free_irq(vp_vdpa);
+	return ret;
+}
+
+static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 s = vp_vdpa_get_status(vdpa);
+
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
+	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		vp_vdpa_request_irq(vp_vdpa);
+	}
+
+	vp_modern_set_status(mdev, status);
+
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
+		vp_vdpa_free_irq(vp_vdpa);
+}
+
+static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+{
+	return VP_VDPA_QUEUE_MAX;
+}
+
+static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
+				struct vdpa_vq_state *state)
+{
+	/* Note that this is not supported by virtio specification, so
+	 * we return -EOPNOTSUPP here. This means we can't support live
+	 * migration, vhost device start/stop.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
+				const struct vdpa_vq_state *state)
+{
+	/* Note that this is not supported by virtio specification, so
+	 * we return -ENOPOTSUPP here. This means we can't support live
+	 * migration, vhost device start/stop.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
+			      struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->vring[qid].cb = *cb;
+}
+
+static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
+				 u16 qid, bool ready)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_enable(mdev, qid, ready);
+}
+
+static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_queue_enable(mdev, qid);
+}
+
+static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+			       u32 num)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_size(mdev, qid, num);
+}
+
+static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
+				  u64 desc_area, u64 driver_area,
+				  u64 device_area)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_queue_address(mdev, qid, desc_area,
+				driver_area, device_area);
+
+	return 0;
+}
+
+static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
+}
+
+static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_ioread8(&mdev->common->config_generation);
+}
+
+static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.device;
+}
+
+static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.vendor;
+}
+
+static u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
+{
+	return PAGE_SIZE;
+}
+
+static void vp_vdpa_get_config(struct vdpa_device *vdpa,
+			       unsigned int offset,
+			       void *buf, unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 old, new;
+	u8 *p;
+	int i;
+
+	do {
+		old = vp_ioread8(&mdev->common->config_generation);
+		p = buf;
+		for (i = 0; i < len; i++)
+			*p++ = vp_ioread8(mdev->device + offset + i);
+
+		new = vp_ioread8(&mdev->common->config_generation);
+	} while (old != new);
+}
+
+static void vp_vdpa_set_config(struct vdpa_device *vdpa,
+			       unsigned int offset, const void *buf,
+			       unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	const u8 *p = buf;
+	int i;
+
+	for (i = 0; i < len; i++)
+		vp_iowrite8(*p++, mdev->device + offset + i);
+}
+
+static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
+				  struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->cb = *cb;
+}
+
+static const struct vdpa_config_ops vp_vdpa_ops = {
+	.get_features	= vp_vdpa_get_features,
+	.set_features	= vp_vdpa_set_features,
+	.get_status	= vp_vdpa_get_status,
+	.set_status	= vp_vdpa_set_status,
+	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
+	.get_vq_state	= vp_vdpa_get_vq_state,
+	.set_vq_state	= vp_vdpa_set_vq_state,
+	.set_vq_cb	= vp_vdpa_set_vq_cb,
+	.set_vq_ready	= vp_vdpa_set_vq_ready,
+	.get_vq_ready	= vp_vdpa_get_vq_ready,
+	.set_vq_num	= vp_vdpa_set_vq_num,
+	.set_vq_address	= vp_vdpa_set_vq_address,
+	.kick_vq	= vp_vdpa_kick_vq,
+	.get_generation	= vp_vdpa_get_generation,
+	.get_device_id	= vp_vdpa_get_device_id,
+	.get_vendor_id	= vp_vdpa_get_vendor_id,
+	.get_vq_align	= vp_vdpa_get_vq_align,
+	.get_config	= vp_vdpa_get_config,
+	.set_config	= vp_vdpa_set_config,
+	.set_config_cb  = vp_vdpa_set_config_cb,
+};
+
+static void vp_vdpa_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct virtio_pci_modern_device *mdev;
+	struct device *dev = &pdev->dev;
+	struct vp_vdpa *vp_vdpa;
+	u16 notify_off;
+	int ret, i;
+
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
+				    dev, &vp_vdpa_ops);
+	if (vp_vdpa == NULL) {
+		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
+		return -ENOMEM;
+	}
+
+	mdev = &vp_vdpa->mdev;
+	mdev->pci_dev = pdev;
+
+	if (vp_modern_probe(mdev)) {
+		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
+		goto err;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vp_vdpa);
+
+	vp_vdpa->vdpa.dma_dev = &pdev->dev;
+	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
+
+	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed for adding devres for freeing irq vectors\n");
+		goto err;
+	}
+
+	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
+				      sizeof(*vp_vdpa->vring),
+				      GFP_KERNEL);
+	if (!vp_vdpa->vring) {
+		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
+		goto err;
+	}
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		notify_off = vp_modern_get_queue_notify_off(mdev, i);
+		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		vp_vdpa->vring[i].notify = mdev->notify_base +
+			notify_off * mdev->notify_offset_multiplier;
+	}
+	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+
+	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	put_device(&vp_vdpa->vdpa.dev);
+	return ret;
+}
+
+static void vp_vdpa_remove(struct pci_dev *pdev)
+{
+	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
+
+	vdpa_unregister_device(&vp_vdpa->vdpa);
+}
+
+static struct pci_driver vp_vdpa_driver = {
+	.name		= "vp-vdpa",
+	.id_table	= NULL, /* only dynamic ids */
+	.probe		= vp_vdpa_probe,
+	.remove		= vp_vdpa_remove,
+};
+
+module_pci_driver(vp_vdpa_driver);
+
+MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
+MODULE_DESCRIPTION("vp-vdpa");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
