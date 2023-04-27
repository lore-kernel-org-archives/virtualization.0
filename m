Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8C4C77B73
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 10:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48B4183C99;
	Thu, 27 Apr 2023 10:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48B4183C99
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=fk4uHwxG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GP480fjzcrqm; Thu, 27 Apr 2023 10:44:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35D3683C9A;
	Thu, 27 Apr 2023 10:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35D3683C9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BECDC0037;
	Thu, 27 Apr 2023 10:44:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B893C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EBCAC41D71
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBCAC41D71
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=fk4uHwxG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCREjpElG6Lu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4588341C21
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4588341C21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:41 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-63b4a64c72bso6459291b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592281; x=1685184281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuGxNFWZ279Sw3cBMo5HAiWYJHXZBaL0deabF1awimM=;
 b=fk4uHwxGWe7B1rw+aSNoKEFfdT744Dk5mB2IDcElJM5MZ4zkpwPQGSZQnXhb4ukgOI
 H6T/8B8lhdqV5ujAA2LH4VvMI1Craiaat5TaDy8Vx54Q3Ihqt3wo9QatnP8hhmarRXIP
 zQA8PZYt/YlRFFGGf28bzV3moUyrMrP9+bDtH8vFq813CWwukTCVK2ORN/ekK61z1c/j
 ZII5JgIhgv+710ADIZjNTUTXyZ82hdbOENe676Dg577Lvru/O9B7yC8FBSwETKucuDhi
 NX97x/Vy5x1Z7GNjMlIFOLhqxv6eo28yaF7IiIqgFwEqmAdG01fttxb2Vb0bLrNoHY5Z
 2M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682592281; x=1685184281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuGxNFWZ279Sw3cBMo5HAiWYJHXZBaL0deabF1awimM=;
 b=ZVwmhavyJma3cSEVXMUWq2DFntjj5sEwxKoRIpLyudcYLKlQWmslTTMdVnRgYmnK8v
 YGb/oW9qZNbBoHBNbRrFF79ynEB4/c2G3MGwLU+rdi/GvzVoqUNbWYv1C5LEenRxPFib
 tewx/1R7wpUn9JD7ZShTQt33gSKjoNIEBKOL9FsiEd2uwX6jw8sGSHREzbV4G5lci5Hh
 lwFpEdrFWum5uEyy6RFzpcSGuCEi4mM26cyY/1efoAfJ0FEzje/i4746OWJE1ak0xtzP
 rpT5LECgWMgAiasuQwgToSrdU3IWPhXAkYIR+Az+vV6DRBqfQKYeFzJuaLrMyjJTwWpt
 yXSw==
X-Gm-Message-State: AC+VfDzJExHiuZw9hfZtDfvrrD0Sg+OACOKM9LweANw7F4pNUTOywXET
 Lnba/eBo5ADW+je/9pivC6R7MQ==
X-Google-Smtp-Source: ACHHUZ7xs+fOrXbRCschKZzgUOw+xqjqjMj2LWr4n2d4/vHSx+UzKEy/4vC+gRAetcNVAPVTqqMM0w==
X-Received: by 2002:a05:6a20:728b:b0:eb:69b3:116c with SMTP id
 o11-20020a056a20728b00b000eb69b3116cmr1507650pzk.52.1682592281043; 
 Thu, 27 Apr 2023 03:44:41 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 03:44:40 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH v2 1/3] PCI: endpoint: introduce a helper to implement pci
 ep virtio function
Date: Thu, 27 Apr 2023 19:44:26 +0900
Message-Id: <20230427104428.862643-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
References: <20230427104428.862643-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
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

The Linux PCIe Endpoint framework supports to implement PCIe endpoint
functions using a PCIe controller operating in endpoint mode.
It is possble to realize the behavior of PCIe device, such as virtio PCI
device. This patch introduces a setof helper functions and data structures
to implement a PCIe endpoint function that behaves as a virtio device.

Those functions enable the implementation PCIe endpoint function that
comply with the virtio lecacy specification. Because modern virtio
specifications require devices to implement custom PCIe capabilities, which
are not currently supported by either PCIe controllers/drivers or the PCIe
endpoint framework.

The helper functions work with the new struct epf_virtio, which is
initialized and finalized using the following functions:

- int epf_virtio_init();
- void epf_virtio_final()

Once initialized, the PCIe configuration space can be read and written
using the following functions:

- epf_virtio_cfg_{read,write}#size()
- epf_virtio_cfg_{set,clear}#size()
- epf_virtio_cfg_memcpy_toio()

The size is supported 8, 16 and 32bits. The content of configuration space
varies depending on the type of virtio device.

After the setup, launch the kernel thread for negotiation with host virtio
drivers and detection virtqueue notifications with the function:

- epf_virtio_launch_bgtask()

Also there are functions to shutdown and reset the kthread.

- epf_virtio_terminate_bgtask()
- epf_virtio_terminate_reset()

Data transfer function is also provide.

- epf_virtio_memcpy_kiov2kiov()

While this patch provides functions for negotiating with host drivers and
copying data, each PCIe function driver must impl ement operations that
depend on each specific device, such as network, block, etc.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---

Changes from v2:
- Improve the memcpy function between kiov and kiov on local ram and
remote ram via pcie bus.

 drivers/pci/endpoint/functions/Kconfig        |   7 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 .../pci/endpoint/functions/pci-epf-virtio.c   | 458 ++++++++++++++++++
 .../pci/endpoint/functions/pci-epf-virtio.h   | 126 +++++
 4 files changed, 592 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-virtio.h

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 9fd560886871..fa1a6a569a8f 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -37,3 +37,10 @@ config PCI_EPF_VNTB
 	  between PCI Root Port and PCIe Endpoint.
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
+
+config PCI_EPF_VIRTIO
+	tristate
+	depends on PCI_ENDPOINT
+	select VHOST_RING_IOMEM
+	help
+	  Helpers to implement PCI virtio Endpoint function
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 5c13001deaba..a96f127ce900 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
+obj-$(CONFIG_PCI_EPF_VIRTIO)		+= pci-epf-virtio.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-virtio.c b/drivers/pci/endpoint/functions/pci-epf-virtio.c
new file mode 100644
index 000000000000..f67610dd247d
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-virtio.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers to implement PCIe virtio EP function.
+ */
+#include <linux/virtio_pci.h>
+#include <linux/virtio_config.h>
+#include <linux/kthread.h>
+
+#include "pci-epf-virtio.h"
+
+static void epf_virtio_unmap_vq(struct pci_epf *epf, void __iomem *vq_virt,
+				phys_addr_t vq_phys, unsigned int num)
+{
+	size_t vq_size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
+
+	pci_epc_unmap_addr(epf->epc, epf->func_no, epf->vfunc_no, vq_phys,
+			   vq_virt, vq_size);
+	pci_epc_mem_free_addr(epf->epc, vq_phys, vq_virt, vq_size);
+}
+
+static void __iomem *epf_virtio_map_vq(struct pci_epf *epf,
+				       phys_addr_t vq_pci_addr,
+				       unsigned int num, phys_addr_t *vq_phys)
+{
+	int err;
+	size_t vq_size;
+	void __iomem *vq_virt;
+
+	vq_size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
+
+	vq_virt = pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_no,
+				   vq_pci_addr, vq_phys, vq_size);
+	if (IS_ERR(vq_virt)) {
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
+static void epf_virtio_free_vringh(struct pci_epf *epf, struct epf_vringh *evrh)
+{
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->num);
+	kfree(evrh);
+}
+
+static struct epf_vringh *epf_virtio_alloc_vringh(struct pci_epf *epf,
+						  u64 features,
+						  phys_addr_t pci_addr,
+						  unsigned int num)
+{
+	int err;
+	struct vring vring;
+	struct epf_vringh *evrh;
+
+	evrh = kmalloc(sizeof(*evrh), GFP_KERNEL);
+	if (!evrh) {
+		err = -ENOMEM;
+		goto err_unmap_vq;
+	}
+
+	evrh->num = num;
+
+	evrh->virt = epf_virtio_map_vq(epf, pci_addr, num, &evrh->phys);
+	if (IS_ERR(evrh->virt))
+		return evrh->virt;
+
+	vring_init(&vring, num, evrh->virt, VIRTIO_PCI_VRING_ALIGN);
+
+	err = vringh_init_iomem(&evrh->vrh, features, num, false, vring.desc,
+				vring.avail, vring.used);
+	if (err)
+		goto err_free_epf_vq;
+
+	return evrh;
+
+err_free_epf_vq:
+	kfree(evrh);
+
+err_unmap_vq:
+	epf_virtio_unmap_vq(epf, evrh->virt, evrh->phys, evrh->num);
+
+	return ERR_PTR(err);
+}
+
+#define VIRTIO_PCI_LEGACY_CFG_BAR 0
+
+static void __iomem *epf_virtio_alloc_bar(struct pci_epf *epf, size_t size)
+{
+	struct pci_epf_bar *config_bar = &epf->bar[VIRTIO_PCI_LEGACY_CFG_BAR];
+	const struct pci_epc_features *features;
+	void __iomem *bar;
+	int err;
+
+	features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!features) {
+		pr_debug("Failed to get PCI EPC features\n");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (features->reserved_bar & BIT(VIRTIO_PCI_LEGACY_CFG_BAR)) {
+		pr_debug("Cannot use the PCI BAR for legacy virtio pci\n");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (features->bar_fixed_size[VIRTIO_PCI_LEGACY_CFG_BAR]) {
+		if (size >
+		    features->bar_fixed_size[VIRTIO_PCI_LEGACY_CFG_BAR]) {
+			pr_debug("PCI BAR size is not enough\n");
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	bar = pci_epf_alloc_space(epf, size, VIRTIO_PCI_LEGACY_CFG_BAR,
+				  features->align, PRIMARY_INTERFACE);
+	if (!bar) {
+		pr_debug("Failed to allocate virtio-net config memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	config_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	err = pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no,
+			      config_bar);
+	if (err) {
+		pr_debug("Failed to set PCI BAR");
+		goto err_free_space;
+	}
+
+	return bar;
+
+err_free_space:
+
+	pci_epf_free_space(epf, bar, VIRTIO_PCI_LEGACY_CFG_BAR,
+			   PRIMARY_INTERFACE);
+
+	return ERR_PTR(err);
+}
+
+static void epf_virtio_free_bar(struct pci_epf *epf, void __iomem *bar)
+{
+	struct pci_epf_bar *config_bar = &epf->bar[VIRTIO_PCI_LEGACY_CFG_BAR];
+
+	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no, config_bar);
+	pci_epf_free_space(epf, bar, VIRTIO_PCI_LEGACY_CFG_BAR,
+			   PRIMARY_INTERFACE);
+}
+
+static void epf_virtio_init_bar(struct epf_virtio *evio, void __iomem *bar)
+{
+	evio->bar = bar;
+
+	epf_virtio_cfg_write32(evio, VIRTIO_PCI_HOST_FEATURES, evio->features);
+	epf_virtio_cfg_write16(evio, VIRTIO_PCI_ISR, VIRTIO_PCI_ISR_QUEUE);
+	epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NUM, evio->vqlen);
+	epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NOTIFY, evio->nvq);
+	epf_virtio_cfg_write8(evio, VIRTIO_PCI_STATUS, 0);
+}
+
+/**
+ * epf_virtio_init - initialize struct epf_virtio and setup BAR for virtio
+ * @evio: struct epf_virtio to initialize.
+ * @hdr: pci configuration space to show remote host.
+ * @bar_size: pci BAR size it depends on the virtio device type.
+ *
+ * Returns zero or a negative error.
+ */
+int epf_virtio_init(struct epf_virtio *evio, struct pci_epf_header *hdr,
+		    size_t bar_size)
+{
+	struct pci_epf *epf = evio->epf;
+	void __iomem *bar;
+	int err;
+
+	err = pci_epc_write_header(epf->epc, epf->func_no, epf->vfunc_no, hdr);
+	if (err)
+		return err;
+
+	bar = epf_virtio_alloc_bar(epf, bar_size);
+	if (IS_ERR(bar))
+		return PTR_ERR(bar);
+
+	epf_virtio_init_bar(evio, bar);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(epf_virtio_init);
+
+/**
+ * epf_virtio_final - finalize struct epf_virtio. it frees bar and memories
+ * @evio: struct epf_virtio to finalize.
+ */
+void epf_virtio_final(struct epf_virtio *evio)
+{
+	epf_virtio_free_bar(evio->epf, evio->bar);
+
+	for (int i = 0; i < evio->nvq; i++)
+		epf_virtio_free_vringh(evio->epf, evio->vrhs[i]);
+
+	kfree(evio->vrhs);
+}
+EXPORT_SYMBOL_GPL(epf_virtio_final);
+
+static int epf_virtio_negotiate_vq(struct epf_virtio *evio)
+{
+	u32 pfn;
+	u16 sel;
+	int i = 0;
+	struct _pair {
+		u32 pfn;
+		u16 sel;
+	} *tmp;
+	int err = 0;
+	size_t nvq = evio->nvq;
+
+	tmp = kmalloc_array(nvq, sizeof(tmp[0]), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	/*
+	 * PCIe EP framework has no capability to hook access PCI BAR space from
+	 * remote host driver, so poll the specific register, queue pfn to detect
+	 * the writing from the driver.
+	 *
+	 * This implementation assumes that the address of each virtqueue is
+	 * written only once.
+	 */
+	for (i = 0; i < nvq; i++) {
+		while (!(pfn = epf_virtio_cfg_read32(evio,
+						     VIRTIO_PCI_QUEUE_PFN)) &&
+		       evio->running)
+			;
+
+		sel = epf_virtio_cfg_read16(evio, VIRTIO_PCI_QUEUE_SEL);
+
+		epf_virtio_cfg_write32(evio, VIRTIO_PCI_QUEUE_PFN, 0);
+
+		tmp[i].pfn = pfn;
+		tmp[i].sel = sel;
+	}
+
+	if (!evio->running)
+		goto err_out;
+
+	evio->vrhs = kmalloc_array(nvq, sizeof(evio->vrhs[0]), GFP_KERNEL);
+	if (!evio->vrhs) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < nvq; i++) {
+		phys_addr_t pci = tmp[i].pfn << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
+
+		evio->vrhs[i] = epf_virtio_alloc_vringh(
+			evio->epf, evio->features, pci, evio->vqlen);
+		if (IS_ERR(evio->vrhs[i])) {
+			err = PTR_ERR(evio->vrhs[i]);
+			goto err_free_evrhs;
+		}
+	}
+
+	kfree(tmp);
+
+	return 0;
+
+err_free_evrhs:
+	for (i -= 1; i > 0; i--)
+		epf_virtio_free_vringh(evio->epf, evio->vrhs[i]);
+
+	kfree(evio->vrhs);
+
+err_out:
+	kfree(tmp);
+
+	return err;
+}
+
+static void epf_virtio_monitor_qnotify(struct epf_virtio *evio)
+{
+	const u16 qn_default = evio->nvq;
+	u16 tmp;
+
+	/* Since there is no way to synchronize between the host and EP functions,
+	 * it is possible to miss multiple notifications.
+	 */
+	while (evio->running) {
+		tmp = epf_virtio_cfg_read16(evio, VIRTIO_PCI_QUEUE_NOTIFY);
+		if (tmp == qn_default)
+			continue;
+
+		epf_virtio_cfg_write16(evio, VIRTIO_PCI_QUEUE_NOTIFY,
+				       qn_default);
+
+		evio->qn_callback(evio->qn_param);
+	}
+}
+
+static int epf_virtio_bgtask(void *param)
+{
+	struct epf_virtio *evio = param;
+	int err;
+
+	err = epf_virtio_negotiate_vq(evio);
+	if (err < 0) {
+		pr_err("failed to negoticate configs with driver\n");
+		return err;
+	}
+
+	while (!(epf_virtio_cfg_read8(evio, VIRTIO_PCI_STATUS) &
+		 VIRTIO_CONFIG_S_DRIVER_OK) &&
+	       evio->running)
+		;
+
+	if (evio->ic_callback && evio->running)
+		evio->ic_callback(evio->ic_param);
+
+	epf_virtio_monitor_qnotify(evio);
+
+	return 0;
+}
+
+/**
+ * epf_virtio_launch_bgtask - spawn a kthread that emulates virtio device
+ * operations.
+ * @evio: It should be initialized prior with epf_virtio_init().
+ *
+ * Returns zero or a negative error.
+ */
+int epf_virtio_launch_bgtask(struct epf_virtio *evio)
+{
+	evio->bgtask = kthread_create(epf_virtio_bgtask, evio,
+				      "pci-epf-virtio/bgtask");
+	if (IS_ERR(evio->bgtask))
+		return PTR_ERR(evio->bgtask);
+
+	evio->running = true;
+
+	sched_set_fifo(evio->bgtask);
+	wake_up_process(evio->bgtask);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(epf_virtio_launch_bgtask);
+
+/**
+ * epf_virtio_terminate_bgtask - shutdown a device emulation kthread.
+ * @evio: struct epf_virtio it already launched bgtask.
+ */
+void epf_virtio_terminate_bgtask(struct epf_virtio *evio)
+{
+	evio->running = false;
+
+	kthread_stop(evio->bgtask);
+}
+EXPORT_SYMBOL_GPL(epf_virtio_terminate_bgtask);
+
+/**
+ * epf_virtio_reset - reset virtio status
+ * @evio: struct epf_virtio to reset
+ *
+ * Returns zero or a negative error.
+ */
+int epf_virtio_reset(struct epf_virtio *evio)
+{
+	epf_virtio_terminate_bgtask(evio);
+	epf_virtio_init_bar(evio, evio->bar);
+
+	return epf_virtio_launch_bgtask(evio);
+}
+EXPORT_SYMBOL_GPL(epf_virtio_reset);
+
+int epf_virtio_getdesc(struct epf_virtio *evio, int index,
+		       struct vringh_kiov *riov, struct vringh_kiov *wiov,
+		       u16 *head)
+{
+	struct vringh *vrh = &evio->vrhs[index]->vrh;
+
+	return vringh_getdesc_iomem(vrh, riov, wiov, head, GFP_KERNEL);
+}
+
+void epf_virtio_abandon(struct epf_virtio *evio, int index, int num)
+{
+	struct vringh *vrh = &evio->vrhs[index]->vrh;
+
+	vringh_abandon_iomem(vrh, num);
+}
+
+void epf_virtio_iov_complete(struct epf_virtio *evio, int index, u16 head,
+			     size_t total_len)
+{
+	struct vringh *vrh = &evio->vrhs[index]->vrh;
+
+	vringh_complete_iomem(vrh, head, total_len);
+}
+
+int epf_virtio_memcpy_kiov2kiov(struct epf_virtio *evio,
+				struct vringh_kiov *siov,
+				struct vringh_kiov *diov,
+				enum dma_transfer_direction dir)
+{
+	struct pci_epf *epf = evio->epf;
+	size_t slen, dlen;
+	u64 sbase, dbase;
+	phys_addr_t phys;
+	void *dst, *src;
+
+	for (; siov->i < siov->used; siov->i++, diov->i++) {
+		slen = siov->iov[siov->i].iov_len;
+		sbase = (u64)siov->iov[siov->i].iov_base;
+		dlen = diov->iov[diov->i].iov_len;
+		dbase = (u64)diov->iov[diov->i].iov_base;
+
+		if (dlen < slen) {
+			pr_info("not enough buffer\n");
+			return -EINVAL;
+		}
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = phys_to_virt(sbase);
+
+			dst = pci_epc_map_addr(epf->epc, epf->func_no,
+					       epf->vfunc_no, dbase, &phys,
+					       slen);
+			if (IS_ERR(dst)) {
+				pr_err("failed to map pci mmoery spact to local\n");
+				return PTR_ERR(dst);
+			}
+		} else {
+			src = pci_epc_map_addr(epf->epc, epf->func_no,
+					       epf->vfunc_no, sbase, &phys,
+					       slen);
+			if (IS_ERR(src)) {
+				pr_err("failed to map pci mmoery spact to local\n");
+				return PTR_ERR(src);
+			}
+
+			dst = phys_to_virt(dbase);
+		}
+
+		memcpy_fromio(dst, src, slen);
+
+		if (dir == DMA_MEM_TO_DEV) {
+			pci_epc_unmap_addr(epf->epc, epf->func_no,
+					   epf->vfunc_no, phys, dst, slen);
+		} else {
+			pci_epc_unmap_addr(epf->epc, epf->func_no,
+					   epf->vfunc_no, phys, src, slen);
+		}
+	}
+
+	return 1;
+}
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/endpoint/functions/pci-epf-virtio.h b/drivers/pci/endpoint/functions/pci-epf-virtio.h
new file mode 100644
index 000000000000..80e18ff70c1c
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-virtio.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_EPF_VIRTIO_H__
+#define __PCI_EPF_VIRTIO_H__
+
+#include <linux/pci-epf.h>
+#include <linux/pci-epc.h>
+#include <linux/vringh.h>
+#include <linux/dmaengine.h>
+
+struct epf_vringh {
+	struct vringh vrh;
+	void __iomem *virt;
+	phys_addr_t phys;
+	unsigned int num;
+};
+
+struct epf_virtio {
+	/* Base PCI endpoint function */
+	struct pci_epf *epf;
+
+	/* Virtio parameters */
+	u64 features;
+	size_t bar_size;
+	size_t nvq;
+	size_t vqlen;
+
+	/* struct to access virtqueue on remote host */
+	struct epf_vringh **vrhs;
+
+	/* struct for thread to emulate virtio device */
+	struct task_struct *bgtask;
+
+	/* Virtual address of pci configuration space */
+	void __iomem *bar;
+
+	/* Callback function and parameter for queue notifcation
+	 * Note: PCI EP function cannot detect qnotify accurately, therefore this
+	 * callback function should check all of virtqueue's changes.
+	 */
+	void (*qn_callback)(void *param);
+	void *qn_param;
+
+	/* Callback function and parameter for initialize complete */
+	void (*ic_callback)(void *param);
+	void *ic_param;
+
+	bool running;
+};
+
+#define DEFINE_EPF_VIRTIO_CFG_READ(size)                 \
+	static inline u##size epf_virtio_cfg_read##size( \
+		struct epf_virtio *evio, size_t offset)  \
+	{                                                \
+		void __iomem *base = evio->bar + offset; \
+		return ioread##size(base);               \
+	}
+
+DEFINE_EPF_VIRTIO_CFG_READ(8)
+DEFINE_EPF_VIRTIO_CFG_READ(16)
+DEFINE_EPF_VIRTIO_CFG_READ(32)
+
+#define DEFINE_EPF_VIRTIO_CFG_WRITE(size)                              \
+	static inline void epf_virtio_cfg_write##size(                 \
+		struct epf_virtio *evio, size_t offset, u##size value) \
+	{                                                              \
+		void __iomem *base = evio->bar + offset;               \
+		iowrite##size(value, base);                            \
+	}
+
+DEFINE_EPF_VIRTIO_CFG_WRITE(8);
+DEFINE_EPF_VIRTIO_CFG_WRITE(16);
+DEFINE_EPF_VIRTIO_CFG_WRITE(32);
+
+#define DEFINE_EPF_VIRTIO_CFG_SET(size)                                \
+	static inline void epf_virtio_cfg_set##size(                   \
+		struct epf_virtio *evio, size_t offset, u##size value) \
+	{                                                              \
+		void __iomem *base = evio->bar + offset;               \
+		iowrite##size(ioread##size(base) | value, base);       \
+	}
+
+DEFINE_EPF_VIRTIO_CFG_SET(8)
+DEFINE_EPF_VIRTIO_CFG_SET(16)
+DEFINE_EPF_VIRTIO_CFG_SET(32)
+
+#define DEFINE_EPF_VIRTIO_CFG_CLEAR(size)                              \
+	static inline void epf_virtio_cfg_clear##size(                 \
+		struct epf_virtio *evio, size_t offset, u##size value) \
+	{                                                              \
+		void __iomem *base = evio->bar + offset;               \
+		iowrite##size(ioread##size(base) & ~value, base);      \
+	}
+
+DEFINE_EPF_VIRTIO_CFG_CLEAR(8)
+DEFINE_EPF_VIRTIO_CFG_CLEAR(16)
+DEFINE_EPF_VIRTIO_CFG_CLEAR(32)
+
+static inline void epf_virtio_cfg_memcpy_toio(struct epf_virtio *evio,
+					      size_t offset, void *buf,
+					      size_t len)
+{
+	void __iomem *base = evio->bar + offset;
+
+	memcpy_toio(base, buf, len);
+}
+
+int epf_virtio_init(struct epf_virtio *evio, struct pci_epf_header *hdr,
+		    size_t bar_size);
+void epf_virtio_final(struct epf_virtio *evio);
+int epf_virtio_launch_bgtask(struct epf_virtio *evio);
+void epf_virtio_terminate_bgtask(struct epf_virtio *evio);
+int epf_virtio_reset(struct epf_virtio *evio);
+
+int epf_virtio_getdesc(struct epf_virtio *evio, int index,
+		       struct vringh_kiov *riov, struct vringh_kiov *wiov,
+		       u16 *head);
+void epf_virtio_abandon(struct epf_virtio *evio, int index, int num);
+void epf_virtio_iov_complete(struct epf_virtio *evio, int index, u16 head,
+			     size_t total_len);
+
+int epf_virtio_memcpy_kiov2kiov(struct epf_virtio *evio,
+				struct vringh_kiov *siov,
+				struct vringh_kiov *diov,
+				enum dma_transfer_direction dir);
+
+#endif /* __PCI_EPF_VIRTIO_H__ */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
