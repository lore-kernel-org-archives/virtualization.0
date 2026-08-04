Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EC43E9C5
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835605; cv=none; b=UtbM21nvvg6jKW1pRTgyqjUv0WfM4DfadOkIul7KEze2PQ3dssKRde6cG7nZ4NJWE9O2IIRfjK+pgNvNI9JEtBtBrAAAgaQYR5sKZG51iYk1xfnj4Jw1owxkU7x1+0cL3UN3hYBCaFWI9dPNo0e4eobWNQCAkSp8POMXAOvqj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835605; c=relaxed/simple;
	bh=fVb2JTN4LigATAlUV0kJLx/g6u146TirR7fpFOSK2JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdTqpUww/qBCOvQ3hIafSRyEErqtOApCbD9PYS3Pn1dDOod+jVmbCl+KVxM0IQOn7VL9fGzTm3Up29PW2GXq97dd0Gc6xPaiqUBMC8BYGQM33SHwRBW514jYKFEahuccUEWhkcVY/1F19U5M42blRU0Wwj/kLoSms8fvlkBky4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 98ccb9d68fe611f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d5e6f432-c9fd-4426-a4e7-8014fa52708c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:4d66888b016ecadcadc380bbf4a89236,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 98ccb9d68fe611f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 411247458; Tue, 04 Aug 2026 17:26:39 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: schalla@marvell.com,
	vattunuru@marvell.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa: octeon_ep: Check dev_set_name() in dev add
Date: Tue,  4 Aug 2026 17:26:36 +0800
Message-ID: <20260804092636.1344431-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle dev_set_name() failures before registering the vDPA device so
allocation is unwound through the existing put_device() path.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 5b3599375..8f8e87890 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -602,6 +602,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		ret = dev_set_name(&vdpa_dev->dev, "%s", name);
 	else
 		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
+	if (ret)
+		goto vdpa_dev_put;
 
 	ret = _vdpa_register_device(&oct_vdpa->vdpa, oct_hw->nr_vring);
 	if (ret) {
-- 
2.43.0

