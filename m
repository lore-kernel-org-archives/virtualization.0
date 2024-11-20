Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CD15B99E
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086442; cv=none; b=i4nmL50xqpJssJtnvWRLU7gVjDgxdnaYhU7gFhWxA+XoF3H2sKM0nJFgqS7WiaHSdSBCwUAZPuPGpaRTHb+PatnEbpYN8ZTO4NtY9WIblIGLAAO0ZHC40XXjEAH563hzKwaYXWUwH7AwJ8wo09J3av3t+GwcyVXrq4F3ICHG4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086442; c=relaxed/simple;
	bh=QjpJbq013nostxLse9Lh8wIY37svrRC5Caf3PObOb+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cv/fkHXF/SLGekgSLbr8x2zQMoW10TUMxcAdyUbsqFVVNJDh8KdLAQ91dTvGTs7c9Z9nHP59zFWC1tfTimp+oJrDoYpCS1S/42DBQRjmf9123g0aKiV9M47o+XQJMsx/U6gLkYdlO8qLrAkZGwZ0yNgXLPjp6H27hj9pN1ND3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IdWXlVOY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IdWXlVOY"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMmeed003104;
	Tue, 19 Nov 2024 23:07:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	FXD3AS2KBH6vnHmuro+c0L6OCeD3n8FHywMgLoBwR8=; b=IdWXlVOYey5bn1KE1
	yWeIfgPITuxJLrEDdunNJzfSTCP5F3jNHsU6VH9WxE4JG5hmk2U8I1hAYdF7rmpJ
	ZkphJI7bn3xhFtsvUMiQGfka/ql0u1kUZadM77jR1yibyna66AzN/pYmENX6JeME
	sE002vMxxpN/3NJJvTaDWIjx/zdP1OlnY9T+3Sid/Yh7J5UBwX+HAo7BIPnKjqtE
	AXkIBM+rnGMrGKFaHdtc41LLKWM4WaocpsnPA6W4c/QsrFsWcXfAxJJoia0JG3TJ
	KO3ZjZd7z1MSxqoX/X5p3+SdmAdkyiaHAU4Pjvam8rWDjsN0IOMjiFEwckzaQnEh
	O8TgQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4313t10xjr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:07:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 23:07:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 19 Nov 2024 23:07:07 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 76AC13F7062;
	Tue, 19 Nov 2024 23:07:03 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] vdpa/octeon_ep: add interrupt handler for virtio crypto device
Date: Wed, 20 Nov 2024 12:34:53 +0530
Message-ID: <20241120070508.789508-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m3W3Ereg19Xt5hLzETEOPamsCbsT3a_k
X-Proofpoint-GUID: m3W3Ereg19Xt5hLzETEOPamsCbsT3a_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Introduced an interrupt handler for the virtio crypto device, as its
queue usage differs from that of network devices. While virtio network
device receives packets only on even-indexed queues, virtio crypto
device utilize all available queues for processing data.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 51 +++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 6ead42d76415..1b65cb697fa5 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -44,7 +44,35 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
 	return oct_vdpa->oct_hw;
 }
 
-static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
+static irqreturn_t octep_vdpa_crypto_irq_handler(int irq, void *data)
+{
+	struct octep_hw *oct_hw = data;
+	int i;
+
+	/* Each device interrupt (nb_irqs) maps to specific receive rings
+	 * (nr_vring) in a round-robin fashion.
+	 *
+	 * For example, if nb_irqs = 8 and nr_vring = 64:
+	 * 0 -> 0, 8, 16, 24, 32, 40, 48, 56;
+	 * 1 -> 1, 9, 17, 25, 33, 41, 49, 57;
+	 * ...
+	 * 7 -> 7, 15, 23, 31, 39, 47, 55, 63;
+	 */
+	for (i = irq - oct_hw->irqs[0]; i < oct_hw->nr_vring; i += oct_hw->nb_irqs) {
+		if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {
+			/* Acknowledge the per ring notification to the device */
+			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
+
+			if (likely(oct_hw->vqs[i].cb.callback))
+				oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+			break;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t octep_vdpa_net_irq_handler(int irq, void *data)
 {
 	struct octep_hw *oct_hw = data;
 	int i, ring_start, ring_stride;
@@ -85,6 +113,18 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t (*octep_vdpa_get_irq_handler(u32 dev_id))(int, void *)
+{
+	switch (dev_id) {
+	case VIRTIO_ID_NET:
+		return octep_vdpa_net_irq_handler;
+	case VIRTIO_ID_CRYPTO:
+		return octep_vdpa_crypto_irq_handler;
+	default:
+		return NULL;
+	}
+}
+
 static void octep_free_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
@@ -103,6 +143,7 @@ static void octep_free_irqs(struct octep_hw *oct_hw)
 
 static int octep_request_irqs(struct octep_hw *oct_hw)
 {
+	irqreturn_t (*irq_handler)(int irq, void *data);
 	struct pci_dev *pdev = oct_hw->pdev;
 	int ret, irq, idx;
 
@@ -119,10 +160,16 @@ static int octep_request_irqs(struct octep_hw *oct_hw)
 	}
 
 	memset(oct_hw->irqs, -1, sizeof(oct_hw->irqs));
+	irq_handler = octep_vdpa_get_irq_handler(oct_hw->dev_id);
+	if (!irq_handler) {
+		dev_err(&pdev->dev, "Invalid device id %d\n", oct_hw->dev_id);
+		ret = -EINVAL;
+		goto free_irqs;
+	}
 
 	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
 		irq = pci_irq_vector(pdev, idx);
-		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
+		ret = devm_request_irq(&pdev->dev, irq, irq_handler, 0,
 				       dev_name(&pdev->dev), oct_hw);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
-- 
2.25.1

