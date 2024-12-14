Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87ABE65
	for <virtualization@lists.linux.dev>; Sat, 14 Dec 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734160326; cv=none; b=VcPPpV1rha1VtMfr8DQBMHFkS4hAFNyDImk497CB1RGsq/KwmcOgvPGDKeA7EyiDcCVNT9ypljjpk4KLz9His5Dcjocq5bLZ+6teHFBtFScsiuQ0GRavvgY4/yJED5H97/yzKPEe1CsH5LRU3EeexeBGWgZ4dTTuxuEZ9G01siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734160326; c=relaxed/simple;
	bh=PxZqft45WD/CL0+24HIhyHmoZHrjbP38s4FSFx9SY28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=burT3PWyYVeZsQhqAxwl19HZ045oXbv5kyMHlj0+QjRM0do6cs1rbx7DID7jTrLSguMyWOSIizHVkd0wcfVxlq50cJaYP7Jh1X0V2m4N8NGfFBbwuycgqsh64C7icp512FqfaAzsbZ0HawkGMZEcIhKazsc89eplt1Pzp2JF/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KbmqNSY3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KbmqNSY3"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE7BIIY006005;
	Fri, 13 Dec 2024 23:11:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ol+CEpkKQ440/6jZgsB7aTm
	n6job3wha0gYi3sWthoo=; b=KbmqNSY3xBrDmGJDtGi3nJkv0cPTn6Ne9veKRF8
	2/my+smeP86pNmFM1RWjbdpwvc1mz0D+IeZLBPMnUPPQM/3TqilHaK92ZmL+OLdS
	FVEkbth1gQeqXbT/0ZPQM+eENdGlWL6g9PJRqgg4s9k2iOcVDextsQN14/B0ETxm
	+obp3ON95ZfaMS9LZfQ4EpqgVHNUfCwc444M9KsPuonfuqtxB+rlnMLygi8kbnjR
	k+28roEJ+Dv15TS91Gu4xUOjRZHr64/6Y/ZH+W0MLun/aZJ20jXHgxv49/fcSfjJ
	U2N1vncMqPbAGhxAYo5+Xl35fgO3aQaNyWwrgQnCtFwRQMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43h5d3803q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 23:11:56 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Dec 2024 23:11:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 23:11:54 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 253863F7073;
	Fri, 13 Dec 2024 23:11:50 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] vdpa/octeon_ep: enable support for multiple interrupts per device
Date: Sat, 14 Dec 2024 12:36:04 +0530
Message-ID: <20241214070835.568818-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NMyuxKO-ekBi-xN_4YxcGwD9opfCKxnX
X-Proofpoint-GUID: NMyuxKO-ekBi-xN_4YxcGwD9opfCKxnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Updated the driver to utilize all the MSI-X interrupt vectors supported
by each OCTEON endpoint VF, instead of relying on a single vector.
Enabling more interrupts allows packets from multiple rings to be
distributed across multiple cores, improving parallelism and
performance.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
v1:
- https://lore.kernel.org/virtualization/20241120070508.789508-1-sthotton@marvell.com

Changes in v2:
- Handle reset getting called twice.
- Use devm_kcalloc to allocate irq array.
- IRQ is never zero. Adjusted code accordingly.

Changes in v3:
- Made the interrupt handling independent of device type.
- Dropped the patch to add crypto device specific interrupt handler.
- Moved spec specific macro and define to spec header file.

Changes in v4:
- Included comments from spec in the spec header file.
- Added BUILD_BUG_ON to check vendor data structure size.

 drivers/vdpa/octeon_ep/octep_vdpa.h      | 12 ++--
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  2 -
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 87 +++++++++++++++---------
 3 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 046710ec4d42..2cadb878e679 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa.h
+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
@@ -29,12 +29,12 @@
 #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
 #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
 #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
-
-#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
-#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
+#define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
+#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
 
 #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
 #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
+#define OCTEP_MAX_CB_INTR          8
 
 enum octep_vdpa_dev_status {
 	OCTEP_VDPA_DEV_STATUS_INVALID,
@@ -48,9 +48,8 @@ enum octep_vdpa_dev_status {
 struct octep_vring_info {
 	struct vdpa_callback cb;
 	void __iomem *notify_addr;
-	u32 __iomem *cb_notify_addr;
+	void __iomem *cb_notify_addr;
 	phys_addr_t notify_pa;
-	char msix_name[256];
 };
 
 struct octep_hw {
@@ -68,7 +67,8 @@ struct octep_hw {
 	u64 features;
 	u16 nr_vring;
 	u32 config_size;
-	int irq;
+	int nb_irqs;
+	int *irqs;
 };
 
 u8 octep_hw_get_status(struct octep_hw *oct_hw);
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index 1d4767b33315..d5a599f87e18 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -495,8 +495,6 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 	if (!oct_hw->vqs)
 		return -ENOMEM;
 
-	oct_hw->irq = -1;
-
 	dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features);
 	dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
 
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index cd55b1aac151..e9c3e57b321f 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -49,11 +49,25 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 	struct octep_hw *oct_hw = data;
 	int i;
 
-	for (i = 0; i < oct_hw->nr_vring; i++) {
-		if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i].cb_notify_addr)) {
-			/* Acknowledge the per queue notification to the device */
-			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
-			oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+	/* Each device has multiple interrupts (nb_irqs) shared among rings
+	 * (nr_vring). Device interrupts are mapped to the rings in a
+	 * round-robin fashion.
+	 *
+	 * For example, if nb_irqs = 8 and nr_vring = 64:
+	 * 0 -> 0, 8, 16, 24, 32, 40, 48, 56;
+	 * 1 -> 1, 9, 17, 25, 33, 41, 49, 57;
+	 * ...
+	 * 7 -> 7, 15, 23, 31, 39, 47, 55, 63;
+	 */
+
+	for (i = irq - oct_hw->irqs[0]; i < oct_hw->nr_vring; i += oct_hw->nb_irqs) {
+		if (ioread8(oct_hw->vqs[i].cb_notify_addr)) {
+			/* Acknowledge the per ring notification to the device */
+			iowrite8(0, oct_hw->vqs[i].cb_notify_addr);
+
+			if (likely(oct_hw->vqs[i].cb.callback))
+				oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+			break;
 		}
 	}
 
@@ -63,44 +77,53 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 static void octep_free_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
+	int irq;
+
+	if (!oct_hw->irqs)
+		return;
 
-	if (oct_hw->irq != -1) {
-		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
-		oct_hw->irq = -1;
+	for (irq = 0; irq < oct_hw->nb_irqs; irq++) {
+		if (!oct_hw->irqs[irq])
+			break;
+
+		devm_free_irq(&pdev->dev, oct_hw->irqs[irq], oct_hw);
 	}
+
 	pci_free_irq_vectors(pdev);
+	devm_kfree(&pdev->dev, oct_hw->irqs);
+	oct_hw->irqs = NULL;
 }
 
 static int octep_request_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
-	int ret, irq;
+	int ret, irq, idx;
 
-	/* Currently HW device provisions one IRQ per VF, hence
-	 * allocate one IRQ for all virtqueues call interface.
-	 */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	oct_hw->irqs = devm_kcalloc(&pdev->dev, oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);
+	if (!oct_hw->irqs)
+		return -ENOMEM;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to alloc msix vector");
 		return ret;
 	}
 
-	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
-		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
-
-	irq = pci_irq_vector(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
-			       oct_hw->vqs->msix_name, oct_hw);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
-		goto free_irq_vec;
+	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
+		irq = pci_irq_vector(pdev, idx);
+		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
+				       dev_name(&pdev->dev), oct_hw);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
+			goto free_irqs;
+		}
+		oct_hw->irqs[idx] = irq;
 	}
-	oct_hw->irq = irq;
 
 	return 0;
 
-free_irq_vec:
-	pci_free_irq_vectors(pdev);
+free_irqs:
+	octep_free_irqs(oct_hw);
 	return ret;
 }
 
@@ -559,6 +582,7 @@ static void octep_vdpa_setup_task(struct work_struct *work)
 	struct device *dev = &pdev->dev;
 	struct octep_hw *oct_hw;
 	unsigned long timeout;
+	u64 val;
 	int ret;
 
 	oct_hw = &mgmt_dev->oct_hw;
@@ -590,6 +614,13 @@ static void octep_vdpa_setup_task(struct work_struct *work)
 	if (ret)
 		return;
 
+	val = readq(oct_hw->base[OCTEP_HW_MBOX_BAR] + OCTEP_VF_IN_CTRL(0));
+	oct_hw->nb_irqs = OCTEP_VF_IN_CTRL_RPVF(val);
+	if (!oct_hw->nb_irqs || oct_hw->nb_irqs > OCTEP_MAX_CB_INTR) {
+		dev_err(dev, "Invalid number of interrupts %d\n", oct_hw->nb_irqs);
+		goto unmap_region;
+	}
+
 	ret = octep_hw_caps_read(oct_hw, pdev);
 	if (ret < 0)
 		goto unmap_region;
@@ -768,12 +799,6 @@ static int octep_vdpa_pf_setup(struct octep_pf *octpf)
 		return -EINVAL;
 	}
 
-	if (OCTEP_EPF_RINFO_RPVF(val) != BIT_ULL(0)) {
-		val &= ~GENMASK_ULL(35, 32);
-		val |= BIT_ULL(32);
-		writeq(val, addr + OCTEP_EPF_RINFO(0));
-	}
-
 	len = pci_resource_len(pdev, OCTEP_HW_CAPS_BAR);
 
 	octpf->vf_stride = len / totalvfs;
-- 
2.25.1

