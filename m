Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770743E4B9
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835591; cv=none; b=JJmCtSWd5ZUkqKpyz7329t8Cn7hOleC74sX25xNxY6CDrI7cBt72O1fOehm0oGwYd9XYE+yWpQa4YyjGF2fsO96VX5G61/O13Ty2xWm8r85sC0aB/XXyxwb/nmzz5t4uYBOG2kyVtLq2FxXP5ai0QsEuMVmGCDIBmodRYm+agso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835591; c=relaxed/simple;
	bh=x1ZQvbTfm0xWzM4V0WDKtFuLhKG3+2p7OrxxO9vht/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6lJm3C4/iRYI9Zb+XSBWS13r9kR4R2K3RaSJfXhzXGhqjt2shwPMbm9LbWRAMvu59DeIZzvCIAQRsWNRlcJoCb2nPEhn8k9L6DcrjzZVmT204rmwv7BWaKKa2gHplC3ohzl0J2p6eOz/i2W3MDHu0liI1WolDppzHnMPAWKyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8d8fc3f68fe611f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a6e7749d-c73c-40e3-b71b-ba5b574f30c8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3de8e088ee1931cda1a7b2e9314b4aa1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8d8fc3f68fe611f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 859344554; Tue, 04 Aug 2026 17:26:20 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa: solidrun: Free IRQs after request failure
Date: Tue,  4 Aug 2026 17:26:17 +0800
Message-ID: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unwind any IRQs already requested by snet_request_irqs() before returning
an error so a later retry starts from a clean state.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/solidrun/snet_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 28d55315d..aa3ae3876 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -407,7 +407,7 @@ static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
 			       snet->cfg_irq_name, snet);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request IRQ\n");
-		return ret;
+		goto err_free_irqs;
 	}
 	snet->cfg_irq = irq;
 
@@ -418,11 +418,15 @@ static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
 				       snet->vqs[i]->irq_name, snet->vqs[i]);
 		if (ret) {
 			SNET_ERR(pdev, "Failed to request IRQ\n");
-			return ret;
+			goto err_free_irqs;
 		}
 		snet->vqs[i]->irq = irq;
 	}
 	return 0;
+
+err_free_irqs:
+	snet_free_irqs(snet);
+	return ret;
 }
 
 static void snet_set_status(struct vdpa_device *vdev, u8 status)
-- 
2.43.0

