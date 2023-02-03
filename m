Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44874C63797
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA4AA81BF4;
	Fri,  3 Feb 2023 10:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA4AA81BF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ThLyZEMs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uKbFwFMMSsTm; Fri,  3 Feb 2023 10:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49C07820FB;
	Fri,  3 Feb 2023 10:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49C07820FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 248C9C0033;
	Fri,  3 Feb 2023 10:04:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E993DC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7B9961294
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7B9961294
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ThLyZEMs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVj4yqw74NjX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD17E6128A
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD17E6128A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:38 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id w20so3186284pfn.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjcd+Oav0UBf7mF+MYUjzAhzd7Tic9squ8cey9gaJ5E=;
 b=ThLyZEMs5MpZFZwPqY0NLPfCasQMJUPGmqHeF2lg8Zxyk9eydG5QL1/19biFSQMuNh
 cwJaViWMh/eInwndgugBtyEb2HXciI6TDZoSOZsLdlhnbkAigQe68tzq196AyyQnvwtQ
 ERabOd6Ot5Z3u8MqoFkVg2eksuQbknF+NYybq3A+ZGXHmbC0t2RwZdFjmmPuQqH9BBdn
 4t2SoDke11SXIjKJMtbY/J7nnOQpfyDboE8NHeORDNdfvm//dO7iUxbWGVle5wfjdWmm
 lV9DsvV4xCcksTJoLkrhEt9y+gisJQGs/Tf/tTXl4TsYa1YBkYegOm292cpEZfTkY4vK
 uHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjcd+Oav0UBf7mF+MYUjzAhzd7Tic9squ8cey9gaJ5E=;
 b=zlM9WRA4jLQg6f/WloNn9Ip8oQUtQbq7tLm1NOHX+uBlamieM5jra9vSIsv16YM4xj
 RZOzRWvXX8KX7bELOO1MmsEnIOr8MCh80/2SIXviNQsbAWWT3lpDMPr8IJyqUje/JuR5
 7AvSw6bkyerY5sSUtzkr9516NomRZ+tOTkXMeb4E0OJDZp9+J6KcV9rPZ4+MWEolDdvH
 w9/X5qZRFAS7j3dpPVP4dHijGiGjnCIqTQ8oiFhcoEq9HClc5HYi+xpTskz/5xsSao69
 /tXEUHFYnZr5iMgQ5ueSoq7Q3Za2lj83MYCSJ1z9d47zggBDuvJmfFV6OwH8DEn/jml7
 2pAQ==
X-Gm-Message-State: AO0yUKViDBqXjg4YuVV52qrSqsgFJ+aCgWMskouMKVzPMJwFpHGyHbvM
 Hkzz8Z1XKbF8UwKsfbsohqAUHg==
X-Google-Smtp-Source: AK7set/Kj4wCo73JmugdcJhI0++p/hgbNoSnL0M6LUdA+Sx2OQD9zznOb3QIA6X99aX3bEGaycb6qA==
X-Received: by 2002:aa7:88c8:0:b0:594:1769:e9a0 with SMTP id
 k8-20020aa788c8000000b005941769e9a0mr12315216pff.17.1675418678084; 
 Fri, 03 Feb 2023 02:04:38 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:04:37 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 3/4] PCI: endpoint: Introduce virtio library for EP
 functions
Date: Fri,  3 Feb 2023 19:04:17 +0900
Message-Id: <20230203100418.2981144-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

Add a new library to access a virtio ring located on PCIe host memory. The
library generates struct pci_epf_vringh that is introduced in this patch.
The struct has a vringh member, so vringh APIs can be used to access the
virtio ring.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 drivers/pci/endpoint/Kconfig          |   7 ++
 drivers/pci/endpoint/Makefile         |   1 +
 drivers/pci/endpoint/pci-epf-virtio.c | 113 ++++++++++++++++++++++++++
 include/linux/pci-epf-virtio.h        |  25 ++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
 create mode 100644 include/linux/pci-epf-virtio.h

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 17bbdc9bbde0..07276dcc43c8 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -28,6 +28,13 @@ config PCI_ENDPOINT_CONFIGFS
 	   configure the endpoint function and used to bind the
 	   function with a endpoint controller.
 
+config PCI_ENDPOINT_VIRTIO
+	tristate
+	depends on PCI_ENDPOINT
+	select VHOST_IOMEM
+	help
+	  TODO update this comment
+
 source "drivers/pci/endpoint/functions/Kconfig"
 
 endmenu
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b0..95712f0a13d1 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -4,5 +4,6 @@
 #
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
+obj-$(CONFIG_PCI_ENDPOINT_VIRTIO)	+= pci-epf-virtio.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
diff --git a/drivers/pci/endpoint/pci-epf-virtio.c b/drivers/pci/endpoint/pci-epf-virtio.c
new file mode 100644
index 000000000000..7134ca407a03
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf-virtio.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtio library for PCI Endpoint function
+ */
+#include <linux/kernel.h>
+#include <linux/pci-epf-virtio.h>
+#include <linux/pci-epc.h>
+#include <linux/virtio_pci.h>
+
+static void __iomem *epf_virtio_map_vq(struct pci_epf *epf, u32 pfn,
+				       size_t size, phys_addr_t *vq_phys)
+{
+	int err;
+	phys_addr_t vq_addr;
+	size_t vq_size;
+	void __iomem *vq_virt;
+
+	vq_addr = (phys_addr_t)pfn << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
+
+	vq_size = vring_size(size, VIRTIO_PCI_VRING_ALIGN) + 100;
+
+	vq_virt = pci_epc_mem_alloc_addr(epf->epc, vq_phys, vq_size);
+	if (!vq_virt) {
+		pr_err("Failed to allocate epc memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no, *vq_phys,
+			       vq_addr, vq_size);
+	if (err) {
+		pr_err("Failed to map virtuqueue to local");
+		goto err_free;
+	}
+
+	return vq_virt;
+
+err_free:
+	pci_epc_mem_free_addr(epf->epc, *vq_phys, vq_virt, vq_size);
+
+	return ERR_PTR(err);
+}
+
+static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_virt,
+				phys_addr_t vq_phys, size_t size)
+{
+	pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys);
+	pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt,
+			      vring_size(size, VIRTIO_PCI_VRING_ALIGN));
+}
+
+/**
+ * pci_epf_virtio_alloc_vringh() - allocate epf vringh from @pfn
+ * @epf: the EPF device that communicates to host virtio dirver
+ * @features: the virtio features of device
+ * @pfn: page frame number of virtqueue located on host memory. It is
+ *		passed during virtqueue negotiation.
+ * @size: a length of virtqueue
+ */
+struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
+						   u64 features, u32 pfn,
+						   size_t size)
+{
+	int err;
+	struct vring vring;
+	struct pci_epf_vringh *evrh;
+
+	evrh = kmalloc(sizeof(*evrh), GFP_KERNEL);
+	if (!evrh) {
+		err = -ENOMEM;
+		goto err_unmap_vq;
+	}
+
+	evrh->size = size;
+
+	evrh->virt = epf_virtio_map_vq(epf, pfn, size, &evrh->phys);
+	if (IS_ERR(evrh->virt))
+		return evrh->virt;
+
+	vring_init(&vring, size, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
+
+	err = vringh_init_iomem(&evrh->vrh, features, size, false, GFP_KERNEL,
+				vring.desc, vring.avail, vring.used);
+	if (err)
+		goto err_free_epf_vq;
+
+	return evrh;
+
+err_free_epf_vq:
+	kfree(evrh);
+
+err_unmap_vq:
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(pci_epf_virtio_alloc_vringh);
+
+/**
+ * pci_epf_virtio_free_vringh() - release allocated epf vring
+ * @epf: the EPF device that communicates to host virtio dirver
+ * @evrh: epf vringh to free
+ */
+void pci_epf_virtio_free_vringh(struct pci_epf *epf,
+				struct pci_epf_vringh *evrh)
+{
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->size);
+	kfree(evrh);
+}
+EXPORT_SYMBOL_GPL(pci_epf_virtio_free_vringh);
+
+MODULE_DESCRIPTION("PCI EP Virtio Library");
+MODULE_AUTHOR("Shunsuke Mie <mie@igel.co.jp>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-epf-virtio.h b/include/linux/pci-epf-virtio.h
new file mode 100644
index 000000000000..ae09087919a9
--- /dev/null
+++ b/include/linux/pci-epf-virtio.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint Function (EPF) for virtio definitions
+ */
+#ifndef __LINUX_PCI_EPF_VIRTIO_H
+#define __LINUX_PCI_EPF_VIRTIO_H
+
+#include <linux/types.h>
+#include <linux/vringh.h>
+#include <linux/pci-epf.h>
+
+struct pci_epf_vringh {
+	struct vringh vrh;
+	void __iomem *virt;
+	phys_addr_t phys;
+	size_t size;
+};
+
+struct pci_epf_vringh *pci_epf_virtio_alloc_vringh(struct pci_epf *epf,
+						   u64 features, u32 pfn,
+						   size_t size);
+void pci_epf_virtio_free_vringh(struct pci_epf *epf,
+				struct pci_epf_vringh *evrh);
+
+#endif // __LINUX_PCI_EPF_VIRTIO_H
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
