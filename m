Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E75C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:04:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACE264DD3
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACE264DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D67787132;
	Mon, 22 Feb 2021 09:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XinRDd0Ks7Jp; Mon, 22 Feb 2021 09:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 134B987111;
	Mon, 22 Feb 2021 09:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E83CDC000B;
	Mon, 22 Feb 2021 09:04:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1FD4C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BEFC87111
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27Y0-GFTof+t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:04:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 39EBE870FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613984650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNUv6f+h9EmVjxSn2xE6+LXVVLD4WKGbZb/d+MUQMfQ=;
 b=Jnn5gLUa20pPYtN0Km3mVD+PRvQlHp7XIBBZgP69IysejRGTqAC8RHW3AEclw9Obyug4Ud
 nxYxA2nr7bVvSkL2khHos+UdO1+uryJ7Uma6jbCsnYlm77TZP8Kqtjv0zk2rFF3tjPRZ9G
 pp5XddmYKYUBYxEthqhi56SdnRxTki8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-B6pj28QrNBalHVhPICtqqg-1; Mon, 22 Feb 2021 04:04:08 -0500
X-MC-Unique: B6pj28QrNBalHVhPICtqqg-1
Received: by mail-wm1-f70.google.com with SMTP id b129so860840wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 01:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rNUv6f+h9EmVjxSn2xE6+LXVVLD4WKGbZb/d+MUQMfQ=;
 b=gKUn8prJrvCuJQrIjZq3Aas2xaG6oS8pj7uVAIYbIvU76iTJ5OYpI5jZjYbECi4zZ6
 3E3fPbqZ05qcALGff8qwDcttfgVTlIxTnXDcQAsOp6BtdDQS3MpOzTHX+blNUeXWgVF3
 2rAgDfH4ei972DHUfzvfyAFfA4zy+vWWBC2f7/CcAzqUlN3913sTqsz5/7yjDAiZo74i
 xdExsG8CnmNGOGdZX0eXGIZsuBmq29cZIXPjmDHtAGRWHkwBHEV6NsjUoe6iP4eR2/E0
 G4woAicK5U8ZyiRC/rci9UOD77s0XlgWHcNK5oGYyWyZ170pcCJx0/AFrqfXfiep7BR3
 S2TA==
X-Gm-Message-State: AOAM5329Ae56R5RFRfRY8dI+iV7iL0wiRlcBS7G5veVE9ftIewT7hQMN
 3PI4+KHVmEMU/WtrfyJRaOn6dZNqQLdPYNPUmdaqpxj7xSaAI7RxKUWGlBfQC022BYmng5kJ6En
 7Eg9Ca2zyv/TILtlwpjcwld81rifhcu52q/0lxzox9w==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr920539wrw.361.1613984646923;
 Mon, 22 Feb 2021 01:04:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylg+mCYL0ybktBUWNN0uMcU4WpRjL9K5OSsM6CEoC100I2+ykexMOxTSPwL3bSGruKItjaeg==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr920520wrw.361.1613984646708;
 Mon, 22 Feb 2021 01:04:06 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v18sm25292299wrf.75.2021.02.22.01.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 01:04:06 -0800 (PST)
Date: Mon, 22 Feb 2021 10:04:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 2/2] vdpa: introduce virtio pci driver
Message-ID: <20210222090404.kstxa4kaj2oevyio@steredhat>
References: <20210220084629.282432-1-jasowang@redhat.com>
 <20210220084629.282432-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210220084629.282432-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, mst@redhat.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Feb 20, 2021 at 04:46:29PM +0800, Jason Wang wrote:
>This patch introduce a vDPA driver for virtio-pci device. It bridges
>the virtio-pci control command to the vDPA bus. This will be used for
>features prototyping and testing.
>
>Note that get/restore virtqueue state is not supported which needs
>extension on the virtio specification.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/Kconfig              |   7 +
> drivers/vdpa/Makefile             |   1 +
> drivers/vdpa/virtio_pci/Makefile  |   2 +
> drivers/vdpa/virtio_pci/vp_vdpa.c | 456 ++++++++++++++++++++++++++++++
> 4 files changed, 466 insertions(+)
> create mode 100644 drivers/vdpa/virtio_pci/Makefile
> create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
>
>diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>index ffd1e098bfd2..aa4fa5a6ebcb 100644
>--- a/drivers/vdpa/Kconfig
>+++ b/drivers/vdpa/Kconfig
>@@ -52,4 +52,11 @@ config MLX5_VDPA_NET
> 	  be executed by the hardware. It also supports a variety of stateless
> 	  offloads depending on the actual device used and firmware version.
>
>+config VP_VDPA
>+	tristate "Virtio PCI bridge vDPA driver"
>+        select VIRTIO_PCI_MODERN
   ^^^^^^^^
checkpatch doesn't say anything, but here there are spaces instead of a 
tab.
I don't know if it's mandatory, but I would replace it because the rest 
of the file uses tabs.

>+	depends on PCI_MSI
>+	help
>+	  This kernel module bridges virtio PCI device to vDPA bus.
>+
> endif # VDPA
>diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
>index d160e9b63a66..67fe7f3d6943 100644
>--- a/drivers/vdpa/Makefile
>+++ b/drivers/vdpa/Makefile
>@@ -3,3 +3,4 @@ obj-$(CONFIG_VDPA) += vdpa.o
> obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
> obj-$(CONFIG_IFCVF)    += ifcvf/
> obj-$(CONFIG_MLX5_VDPA) += mlx5/
>+obj-$(CONFIG_VP_VDPA)    += virtio_pci/
>diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
>new file mode 100644
>index 000000000000..231088d3af7d
>--- /dev/null
>+++ b/drivers/vdpa/virtio_pci/Makefile
>@@ -0,0 +1,2 @@
>+# SPDX-License-Identifier: GPL-2.0
>+obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>new file mode 100644
>index 000000000000..92f79cb26fba
>--- /dev/null
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -0,0 +1,456 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * vDPA bridge driver for modern virtio-pci device
>+ *
>+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
>+ * Author: Jason Wang <jasowang@redhat.com>
>+ *
>+ * Based on virtio_pci_modern.c.
>+ */
>+
>+#include <linux/interrupt.h>
>+#include <linux/module.h>
>+#include <linux/pci.h>
>+#include <linux/vdpa.h>
>+#include <linux/virtio.h>
>+#include <linux/virtio_config.h>
>+#include <linux/virtio_ring.h>
>+#include <linux/virtio_pci.h>
>+#include <linux/virtio_pci_modern.h>
>+
>+#define VP_VDPA_QUEUE_MAX 256
>+#define VP_VDPA_DRIVER_NAME "vp_vdpa"
>+#define VP_VDPA_NAME_SIZE 256
>+
>+struct vp_vring {
>+	void __iomem *notify;
>+	char msix_name[VP_VDPA_NAME_SIZE];
>+	struct vdpa_callback cb;
>+	int irq;
>+};
>+
>+struct vp_vdpa {
>+	struct vdpa_device vdpa;
>+	struct virtio_pci_modern_device mdev;
>+	struct vp_vring *vring;
>+	struct vdpa_callback config_cb;
>+	char msix_name[VP_VDPA_NAME_SIZE];
>+	int config_irq;
>+	int queues;
>+	int vectors;
>+};
>+
>+static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
>+{
>+	return container_of(vdpa, struct vp_vdpa, vdpa);
>+}
>+
>+static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+
>+	return &vp_vdpa->mdev;
>+}
>+
>+static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return vp_modern_get_features(mdev);
>+}
>+
>+static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	vp_modern_set_features(mdev, features);
>+
>+	return 0;
>+}
>+
>+static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return vp_modern_get_status(mdev);
>+}
>+
>+static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>+	struct pci_dev *pdev = mdev->pci_dev;
>+	int i;
>+
>+	for (i = 0; i < vp_vdpa->queues; i++) {
>+		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
>+			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
>+			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
>+				      &vp_vdpa->vring[i]);
>+			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
>+		}
>+	}
>+
>+	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
>+		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
>+		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
>+		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>+	}
>+
>+	if (vp_vdpa->vectors) {
>+		pci_free_irq_vectors(pdev);
>+		vp_vdpa->vectors = 0;
>+	}
>+}
>+
>+static irqreturn_t vp_vdpa_vq_handler(int irq, void *arg)
>+{
>+	struct vp_vring *vring = arg;
>+
>+	if (vring->cb.callback)
>+		return vring->cb.callback(vring->cb.private);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
>+{
>+	struct vp_vdpa *vp_vdpa = arg;
>+
>+	if (vp_vdpa->config_cb.callback)
>+		return vp_vdpa->config_cb.callback(vp_vdpa->config_cb.private);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>+	struct pci_dev *pdev = mdev->pci_dev;
>+	int i, ret, irq;
>+	int queues = vp_vdpa->queues;
>+	int vectors = queues + 1;
>+
>+	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
>+	if (ret != vectors) {
>+		dev_err(&pdev->dev,
>+			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
>+			vectors, ret);
>+		return ret;
>+	}
>+
>+	vp_vdpa->vectors = vectors;
>+
>+	for (i = 0; i < queues; i++) {
>+		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>+			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
>+		irq = pci_irq_vector(pdev, i);
>+		ret = devm_request_irq(&pdev->dev, irq,
>+				       vp_vdpa_vq_handler,
>+				       0, vp_vdpa->vring[i].msix_name,
>+				       &vp_vdpa->vring[i]);
>+		if (ret) {
>+			dev_err(&pdev->dev,
>+				"vp_vdpa: fail to request irq for vq %d\n", i);
>+			goto err;
>+		}
>+		vp_modern_queue_vector(mdev, i, i);
>+		vp_vdpa->vring[i].irq = irq;
>+	}
>+
>+	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
>+		 pci_name(pdev));
>+	irq = pci_irq_vector(pdev, queues);
>+	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
>+			       vp_vdpa->msix_name, vp_vdpa);
>+	if (ret) {
>+		dev_err(&pdev->dev,
>+			"vp_vdpa: fail to request irq for vq %d\n", i);
>+			goto err;
>+	}
>+	vp_modern_config_vector(mdev, queues);
>+	vp_vdpa->config_irq = irq;
>+
>+	return 0;
>+err:
>+	vp_vdpa_free_irq(vp_vdpa);
>+	return ret;
>+}
>+
>+static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>+	u8 s = vp_vdpa_get_status(vdpa);
>+
>+	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>+	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>+		vp_vdpa_request_irq(vp_vdpa);
>+	}
>+
>+	vp_modern_set_status(mdev, status);
>+
>+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>+	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
>+		vp_vdpa_free_irq(vp_vdpa);
>+}
>+
>+static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
>+{
>+	return VP_VDPA_QUEUE_MAX;
>+}
>+
>+static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
>+				struct vdpa_vq_state *state)
>+{
>+	/* Note that this is not supported by virtio specification, so
>+	 * we return -EOPNOTSUPP here. This means we can't support live
>+	 * migration, vhost device start/stop.
>+	 */
>+	return -EOPNOTSUPP;
>+}
>+
>+static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
>+				const struct vdpa_vq_state *state)
>+{
>+	/* Note that this is not supported by virtio specification, so
>+	 * we return -ENOPOTSUPP here. This means we can't support live
>+	 * migration, vhost device start/stop.
>+	 */
>+	return -EOPNOTSUPP;
>+}
>+
>+static void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
>+			      struct vdpa_callback *cb)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+
>+	vp_vdpa->vring[qid].cb = *cb;
>+}
>+
>+static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
>+				 u16 qid, bool ready)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	vp_modern_set_queue_enable(mdev, qid, ready);
>+}
>+
>+static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return vp_modern_get_queue_enable(mdev, qid);
>+}
>+
>+static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
>+			       u32 num)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	vp_modern_set_queue_size(mdev, qid, num);
>+}
>+
>+static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
>+				  u64 desc_area, u64 driver_area,
>+				  u64 device_area)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	vp_modern_queue_address(mdev, qid, desc_area,
>+				driver_area, device_area);
>+
>+	return 0;
>+}
>+
>+static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+
>+	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
>+}
>+
>+static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return vp_modern_generation(mdev);
>+}
>+
>+static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return mdev->id.device;
>+}
>+
>+static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
>+{
>+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>+
>+	return mdev->id.vendor;
>+}
>+
>+static u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
>+{
>+	return PAGE_SIZE;
>+}
>+
>+static void vp_vdpa_get_config(struct vdpa_device *vdpa,
>+			       unsigned int offset,
>+			       void *buf, unsigned int len)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>+	u8 old, new;
>+	u8 *p;
>+	int i;
>+
>+	do {
>+		old = vp_ioread8(&mdev->common->config_generation);
>+		p = buf;
>+		for (i = 0; i < len; i++)
>+			*p++ = vp_ioread8(mdev->device + offset + i);
>+
>+		new = vp_ioread8(&mdev->common->config_generation);
>+	} while (old != new);
>+}
>+
>+static void vp_vdpa_set_config(struct vdpa_device *vdpa,
>+			       unsigned int offset, const void *buf,
>+			       unsigned int len)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>+	const u8 *p = buf;
>+	int i;
>+
>+	for (i = 0; i < len; i++)
>+		vp_iowrite8(*p++, mdev->device + offset + i);
>+}
>+
>+static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
>+				  struct vdpa_callback *cb)
>+{
>+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>+
>+	vp_vdpa->config_cb = *cb;
>+}
>+
>+static const struct vdpa_config_ops vp_vdpa_ops = {
>+	.get_features	= vp_vdpa_get_features,
>+	.set_features	= vp_vdpa_set_features,
>+	.get_status	= vp_vdpa_get_status,
>+	.set_status	= vp_vdpa_set_status,
>+	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
>+	.get_vq_state	= vp_vdpa_get_vq_state,
>+	.set_vq_state	= vp_vdpa_set_vq_state,
>+	.set_vq_cb	= vp_vdpa_set_vq_cb,
>+	.set_vq_ready	= vp_vdpa_set_vq_ready,
>+	.get_vq_ready	= vp_vdpa_get_vq_ready,
>+	.set_vq_num	= vp_vdpa_set_vq_num,
>+	.set_vq_address	= vp_vdpa_set_vq_address,
>+	.kick_vq	= vp_vdpa_kick_vq,
>+	.get_generation	= vp_vdpa_get_generation,
>+	.get_device_id	= vp_vdpa_get_device_id,
>+	.get_vendor_id	= vp_vdpa_get_vendor_id,
>+	.get_vq_align	= vp_vdpa_get_vq_align,
>+	.get_config	= vp_vdpa_get_config,
>+	.set_config	= vp_vdpa_set_config,
>+	.set_config_cb  = vp_vdpa_set_config_cb,
>+};
>+
>+static void vp_vdpa_free_irq_vectors(void *data)
>+{
>+	pci_free_irq_vectors(data);
>+}
>+
>+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>+{
>+	struct virtio_pci_modern_device *mdev;
>+	struct device *dev = &pdev->dev;
>+	struct vp_vdpa *vp_vdpa;
>+	u16 notify_off;
>+	int ret, i;
>+
>+	ret = pcim_enable_device(pdev);
>+	if (ret)
>+		return ret;
>+
>+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
>+				    dev, &vp_vdpa_ops, NULL);
>+	if (vp_vdpa == NULL) {
>+		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>+		return -ENOMEM;
>+	}
>+
>+	mdev = &vp_vdpa->mdev;
>+	mdev->pci_dev = pdev;
>+
>+	if (vp_modern_probe(mdev)) {
>+		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");

Should we set 'ret' with an error value?
Maybe we can reuse the return value of vp_modern_probe().

>+		goto err;
>+	}
>+
>+	pci_set_master(pdev);
>+	pci_set_drvdata(pdev, vp_vdpa);
>+
>+	vp_vdpa->vdpa.dma_dev = &pdev->dev;
>+	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
>+
>+	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
>+	if (ret) {
>+		dev_err(&pdev->dev,
>+			"Failed for adding devres for freeing irq vectors\n");
>+		goto err;
>+	}
>+
>+	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
>+				      sizeof(*vp_vdpa->vring),
>+				      GFP_KERNEL);
>+	if (!vp_vdpa->vring) {
>+		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");

Ditto, but in this case maybe we can set -ENOMEM.

>+		goto err;
>+	}
>+
>+	for (i = 0; i < vp_vdpa->queues; i++) {
>+		notify_off = vp_modern_get_queue_notify_off(mdev, i);
>+		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
>+		vp_vdpa->vring[i].notify = mdev->notify_base +
>+			notify_off * mdev->notify_offset_multiplier;
>+	}
>+	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
>+
>+	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
>+	if (ret) {
>+		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
>+		goto err;
>+	}
>+
>+	return 0;
>+
>+err:
>+	put_device(&vp_vdpa->vdpa.dev);
>+	return ret;
>+}
>+
>+static void vp_vdpa_remove(struct pci_dev *pdev)
>+{
>+	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
>+
>+	vdpa_unregister_device(&vp_vdpa->vdpa);
>+	vp_modern_remove(&vp_vdpa->mdev);
>+}
>+
>+static struct pci_driver vp_vdpa_driver = {
>+	.name		= "vp-vdpa",
>+	.id_table	= NULL, /* only dynamic ids */
>+	.probe		= vp_vdpa_probe,
>+	.remove		= vp_vdpa_remove,
>+};
>+
>+module_pci_driver(vp_vdpa_driver);
>+
>+MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
>+MODULE_DESCRIPTION("vp-vdpa");
>+MODULE_LICENSE("GPL");
>+MODULE_VERSION("1");
>-- 
>2.25.1
>


Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
