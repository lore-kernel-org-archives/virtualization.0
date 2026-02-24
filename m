Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD436F412
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926803; cv=none; b=rw9fNs0WY9r27D/x8YQVbQ07QC+20eDBTj5YeAwncnM1n9sDRfn8DvQE3uTOSzW/Tyvi7WIweGW5uos5JxrS0MUxqvd6pgAWWnjrBXuDGpeDOLjH0jviibmnrXlh15xHcMhHeagCY0Xw9FEjqzwKfbnkAWW45kO2pKiRejvOCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926803; c=relaxed/simple;
	bh=isIFYOnlB2ACvR77Id4K3/nO4hQtSW72a8R7x/Ljrwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCddsZsgSVDEBHSTzwcpEkgj/+cy1qI2zZ9YZDQSPTPkhbWvHokPes+SKIID3F1CZ2X9EvDtfCJoxIT4tScdwkL1RhxmJuWDndqs6OdWWBLtOfoo44GV07x/GaZQmdTAofMsiG5gfXincEaLwShdHAdrabyQPsShAU+KPrIxVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ch2slk4n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ch2slk4n"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8gcw63270534;
	Tue, 24 Feb 2026 01:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	D1c7BWHC33C2L7s3k/CrJfd3xiheGYGtO4BA5kZQIs=; b=Ch2slk4nL4v/5jkWs
	EyXc+cnMpL6v/cy+GOI/3+V7RNDPWNqFREDyYrMWMk5C07AIGDnnxycSLnAqhXC6
	qjlhEl7zqdVPo6aZSoc5m3sMK1qwmblfOwa2xfwyd84cbYkyvh8NSZjkq+NK721R
	e+qIfZtHNUyozRYjxhqKNyU/hEOL+8hvmXYvC1s7E1kcoxh5WpBTsVxk+d9gB1dq
	ydT3/p9WEORSsVcCuGHFWcAsmQH3VSj8hG8uj0+ahUdcZ54lG+Hg8GicgoQdm4tn
	Z8KThqkpSNKziezj0LpOgWFppwLN5UAz1OUsMZekNoUHcZS23Ub4DXmWMAMc8BqK
	JWocA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkpua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 01:53:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 01:52:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 01:52:41 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 195803F70B6;
	Tue, 24 Feb 2026 01:52:38 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <linmq006@gmail.com>, <phasta@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <vattunuru@marvell.com>, <schalla@marvell.com>
Subject: [PATCH 3/4] vdpa/octeon_ep: Add vDPA device event handling for firmware notifications
Date: Tue, 24 Feb 2026 15:22:25 +0530
Message-ID: <20260224095226.1001151-4-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260224095226.1001151-1-schalla@marvell.com>
References: <20260224095226.1001151-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d750c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=gk2RYyrWd7WZbd5cYZ4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 51mRX1lj3RcqWD6uit7O6_lht2MuPkAP
X-Proofpoint-GUID: 51mRX1lj3RcqWD6uit7O6_lht2MuPkAP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfX/IG0KMk/mMKd
 1igHWn3dMhA5h/6Cw78UAWlGVfEOzb00SssNMJJFfV/+uciB6yU39quEnHFoVyc66856fr5xUW8
 HjuM/SfPOunlsDsUwymvmnFszJ7iYWfgX4RN13va/zPmhWp8mP9cpmr8JBj0Lki5kMPGUj4cubG
 DkcDq+CVtmHB6OBwmbvKLW3PeIjcNGoZVcvt1dEg51ZdCz3pUwnVT/kiN6B2y4XyEUgPQnebQb+
 ASmW152Sh2WI1AraxBFYYXT6/G1bM+KZqtRrQ1B2GfD7TCX1GyNvolnslf+sTRvP0rBi3E4+7SC
 17XqODL1e96yZQCRN0Zk75yqe9Y5h2lBSjUCpwXonJ45CB7Faky8+2NjDyOJiWNMroU1fg+u2wj
 dijs3eEtw5CGtdbjIAYiQpD8+hkcdK441hdBXuhgJbj1RvlLBW5Ls2M2OiDPkqKFd4efB0NFwSw
 nUu+o/IZJ0P/2HZU6MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01

From: Vamsi Attunuru <vattunuru@marvell.com>

Handle vDPA device add and remove events from Octeon firmware. Use
irq 0 for event delivery as device interrupts are multiplexed.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa.h      |  22 ++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 107 ++++++++++++++++++++---
 2 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 53b020b019f7..a67bf50e4075 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa.h
+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
@@ -30,8 +30,10 @@
 #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
 #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
 #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
+#define OCTEP_VF_EVENT_STATE(x) (0x00010030 | ((x) << 17))
+#define OCTEP_VF_EVENT_REG(x) (0x00010060 | ((x) << 17))
 #define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
-#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
+#define OCTEP_VF_IN_CTRL_RPVF(val) (FIELD_GET(GENMASK_ULL(51, 48), val))
 
 #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
 #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
@@ -43,9 +45,26 @@ enum octep_vdpa_dev_status {
 	OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
 	OCTEP_VDPA_DEV_STATUS_INIT,
 	OCTEP_VDPA_DEV_STATUS_READY,
+	OCTEP_VDPA_DEV_STATUS_ADDED,
+	OCTEP_VDPA_DEV_STATUS_REMOVED,
 	OCTEP_VDPA_DEV_STATUS_UNINIT
 };
 
+enum octep_vdpa_dev_event_state {
+	OCTEP_VDPA_DEV_NO_EVENT,
+	OCTEP_VDPA_DEV_NEW_EVENT,
+	OCTEP_VDPA_DEV_EVENT_ACTIVE,
+	OCTEP_VDPA_DEV_EVENT_DONE,
+};
+
+enum octep_vdpa_dev_event {
+	OCTEP_VDPA_DEV_EVENT_NONE,
+	OCTEP_VDPA_DEV_EVENT_ACK,
+	OCTEP_VDPA_DEV_EVENT_NACK,
+	OCTEP_VDPA_DEV_ADD_EVENT,
+	OCTEP_VDPA_DEV_DEL_EVENT,
+};
+
 struct octep_vring_info {
 	struct vdpa_callback cb;
 	void __iomem *notify_addr;
@@ -86,6 +105,7 @@ struct octep_hw {
 	u64 features;
 	u16 nr_vring;
 	u32 config_size;
+	int requested_irqs;
 	int nb_irqs;
 	int *irqs;
 	u8 dev_id;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index deaa8dc7813e..5b9d76632376 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -9,6 +9,7 @@
 #include "octep_vdpa.h"
 
 #define OCTEP_VDPA_DRIVER_NAME "octep_vdpa"
+#define OCTEP_VDPA_NAME_BUFSIZE 16
 
 struct octep_pf {
 	u8 __iomem *base[PCI_STD_NUM_BARS];
@@ -20,6 +21,11 @@ struct octep_pf {
 	u16 vf_devid;
 };
 
+struct octep_vdpa_event_wk {
+	struct work_struct work;
+	void *ctxptr;
+};
+
 struct octep_vdpa {
 	struct vdpa_device vdpa;
 	struct octep_hw *oct_hw;
@@ -34,6 +40,8 @@ struct octep_vdpa_mgmt_dev {
 	struct work_struct setup_task;
 	/* Device status */
 	atomic_t status;
+	struct octep_vdpa *oct_vdpa;
+	struct octep_vdpa_event_wk event_wk;
 };
 
 static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
@@ -45,6 +53,27 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
 	return oct_vdpa->oct_hw;
 }
 
+static inline void octep_vdpa_dev_event_schedule(struct octep_hw *oct_hw)
+{
+	u8 __iomem *addr = oct_hw->base[OCTEP_HW_MBOX_BAR];
+	struct octep_vdpa_mgmt_dev *mgmt_dev;
+
+	mgmt_dev = container_of(oct_hw, struct octep_vdpa_mgmt_dev, oct_hw);
+	writeb(OCTEP_VDPA_DEV_EVENT_ACTIVE, addr + OCTEP_VF_EVENT_STATE(0));
+	schedule_work(&mgmt_dev->event_wk.work);
+}
+
+static irqreturn_t octep_vdpa_dev_event_handler(int irq, void *data)
+{
+	struct octep_hw *oct_hw = data;
+
+	if (readb(oct_hw->base[OCTEP_HW_MBOX_BAR] + OCTEP_VF_EVENT_STATE(0)) ==
+	    OCTEP_VDPA_DEV_NEW_EVENT)
+		octep_vdpa_dev_event_schedule(oct_hw);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 {
 	struct octep_hw *oct_hw = data;
@@ -73,11 +102,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 	}
 
 	/* Check for config interrupt. Config uses the first interrupt */
-	if (unlikely(irq == oct_hw->irqs[0] && ioread8(oct_hw->isr))) {
-		iowrite8(0, oct_hw->isr);
+	if (unlikely(irq == oct_hw->irqs[0])) {
+		if (ioread8(oct_hw->isr)) {
+			iowrite8(0, oct_hw->isr);
 
-		if (oct_hw->config_cb.callback)
-			oct_hw->config_cb.callback(oct_hw->config_cb.private);
+			if (oct_hw->config_cb.callback)
+				oct_hw->config_cb.callback(oct_hw->config_cb.private);
+		}
+		octep_vdpa_dev_event_handler(irq, data);
 	}
 
 	return IRQ_HANDLED;
@@ -101,33 +133,41 @@ static void octep_free_irqs(struct octep_hw *oct_hw)
 	pci_free_irq_vectors(pdev);
 	devm_kfree(&pdev->dev, oct_hw->irqs);
 	oct_hw->irqs = NULL;
+	oct_hw->requested_irqs = 0;
 }
 
-static int octep_request_irqs(struct octep_hw *oct_hw)
+static int octep_request_irqs(struct octep_hw *oct_hw, irqreturn_t (*irq_handler)(int, void *),
+			      int nb_irqs)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
 	int ret, irq, idx;
 
-	oct_hw->irqs = devm_kcalloc(&pdev->dev, oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);
+	if ((oct_hw->requested_irqs != nb_irqs) || (nb_irqs == 1))
+		octep_free_irqs(oct_hw);
+	else
+		return 0;
+
+	oct_hw->irqs = devm_kcalloc(&pdev->dev, nb_irqs, sizeof(int), GFP_KERNEL);
 	if (!oct_hw->irqs)
 		return -ENOMEM;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(pdev, 1, nb_irqs, PCI_IRQ_MSIX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to alloc msix vector");
 		return ret;
 	}
 
-	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
+	for (idx = 0; idx < nb_irqs; idx++) {
 		irq = pci_irq_vector(pdev, idx);
-		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
-				       dev_name(&pdev->dev), oct_hw);
+		ret = devm_request_irq(&pdev->dev, irq, irq_handler, 0, dev_name(&pdev->dev),
+				       oct_hw);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
 			goto free_irqs;
 		}
 		oct_hw->irqs[idx] = irq;
 	}
+	oct_hw->requested_irqs = nb_irqs;
 
 	return 0;
 
@@ -189,7 +229,7 @@ static void octep_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		if (octep_request_irqs(oct_hw))
+		if (octep_request_irqs(oct_hw, octep_vdpa_intr_handler, oct_hw->nb_irqs))
 			status = status_old | VIRTIO_CONFIG_S_FAILED;
 	}
 	octep_hw_set_status(oct_hw, status);
@@ -212,8 +252,10 @@ static int octep_vdpa_reset(struct vdpa_device *vdpa_dev)
 	}
 	octep_hw_reset(oct_hw);
 
-	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
 		octep_free_irqs(oct_hw);
+		octep_request_irqs(oct_hw, octep_vdpa_dev_event_handler, 1);
+	}
 
 	return 0;
 }
@@ -478,7 +520,8 @@ static void octep_vdpa_remove_vf(struct pci_dev *pdev)
 	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
 
 	cancel_work_sync(&mgmt_dev->setup_task);
-	if (status == OCTEP_VDPA_DEV_STATUS_READY)
+	if ((status == OCTEP_VDPA_DEV_STATUS_READY) || (status == OCTEP_VDPA_DEV_STATUS_ADDED) ||
+	    (status == OCTEP_VDPA_DEV_STATUS_REMOVED))
 		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
 
 	if (oct_hw->base[OCTEP_HW_CAPS_BAR])
@@ -488,6 +531,7 @@ static void octep_vdpa_remove_vf(struct pci_dev *pdev)
 		octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_MBOX_BAR);
 
 	octep_vdpa_vf_bar_shrink(pdev);
+	octep_free_irqs(oct_hw);
 }
 
 static void octep_vdpa_remove(struct pci_dev *pdev)
@@ -521,6 +565,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	oct_vdpa->vdpa.mdev = mdev;
 	oct_vdpa->oct_hw = oct_hw;
 	vdpa_dev = &oct_vdpa->vdpa;
+	mgmt_dev->oct_vdpa = oct_vdpa;
 
 	device_features = oct_hw->features;
 	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
@@ -554,6 +599,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		dev_err(&pdev->dev, "Failed to register to vDPA bus");
 		goto vdpa_dev_put;
 	}
+	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ADDED);
 	return 0;
 
 vdpa_dev_put:
@@ -563,7 +609,9 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *vdpa_dev)
 {
+	struct octep_vdpa_mgmt_dev *mgmt_dev = container_of(mdev, struct octep_vdpa_mgmt_dev, mdev);
 	_vdpa_unregister_device(vdpa_dev);
+	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_REMOVED);
 }
 
 static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops = {
@@ -588,6 +636,36 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static void octep_event_work(struct work_struct *work)
+{
+	struct octep_vdpa_event_wk *wk = container_of(work, struct octep_vdpa_event_wk, work);
+	struct octep_vdpa_mgmt_dev *mgmt_dev = (struct octep_vdpa_mgmt_dev *)wk->ctxptr;
+	u8 __iomem *addr = mgmt_dev->oct_hw.base[OCTEP_HW_MBOX_BAR];
+	u8 event = readb(addr + OCTEP_VF_EVENT_REG(0));
+	struct vdpa_dev_set_config config = {0};
+	char name[OCTEP_VDPA_NAME_BUFSIZE];
+	int ret = 0;
+
+	switch (event) {
+	case OCTEP_VDPA_DEV_ADD_EVENT:
+		if (atomic_read(&mgmt_dev->status) != OCTEP_VDPA_DEV_STATUS_ADDED) {
+			snprintf(name, sizeof(name), "%s-%x", "vdpa", mgmt_dev->pdev->devfn);
+			ret = octep_vdpa_dev_add(&mgmt_dev->mdev, name, &config);
+		}
+		break;
+	case OCTEP_VDPA_DEV_DEL_EVENT:
+		if (atomic_read(&mgmt_dev->status) == OCTEP_VDPA_DEV_STATUS_ADDED)
+			octep_vdpa_dev_del(&mgmt_dev->mdev, &mgmt_dev->oct_vdpa->vdpa);
+		break;
+	default:
+		break;
+	}
+
+	event = ret ? OCTEP_VDPA_DEV_EVENT_NACK : OCTEP_VDPA_DEV_EVENT_ACK;
+	writeb(event, addr + OCTEP_VF_EVENT_REG(0));
+	writeb(OCTEP_VDPA_DEV_EVENT_DONE, addr + OCTEP_VF_EVENT_STATE(0));
+}
+
 static void octep_vdpa_setup_task(struct work_struct *work)
 {
 	struct octep_vdpa_mgmt_dev *mgmt_dev = container_of(work, struct octep_vdpa_mgmt_dev,
@@ -653,6 +731,9 @@ static void octep_vdpa_setup_task(struct work_struct *work)
 	}
 
 	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_READY);
+	INIT_WORK(&mgmt_dev->event_wk.work, octep_event_work);
+	mgmt_dev->event_wk.ctxptr = mgmt_dev;
+	octep_request_irqs(&mgmt_dev->oct_hw, octep_vdpa_dev_event_handler, 1);
 
 	return;
 
-- 
2.25.1

