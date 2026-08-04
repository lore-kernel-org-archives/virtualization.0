Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BA43CE52
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835580; cv=none; b=cj5Rfus26hV+iJwK1XZaY19SGFTEKX5MbPNLGl13YrP5yIG2DTMNIHWz8bN1rlaxs1vZMevq7MsH/K4tW/uK5U0Ov2bdEwtiBodJW8zNHaVythfZEz8GP5Jl+jXNih2U9q0RGMtMPnPNpMUxaqHIPeV3j3lVSP8xsJIPm+zdYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835580; c=relaxed/simple;
	bh=2AXI3M0uRLGnkFpRXMTUxSKUXVP451lYuUeB4xdzIa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3z4MnRYgqVptV4BPF7Sp0BCSek/lpMqghluDsmqFQDHsXxpwGSZWGm1o9gLeVDiXLgW5KgsBc7pWl+8ykOdqZBAnDj3f9sq4Kp2PhPi5IGdBLQp8wwzFaGzVxPHSm10dS3RgDc7UKSwUGiW0+N4nhhoLQWGGA3UqjPaBnvBxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 87bb2bbe8fe611f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c1554f79-f4a7-4716-8479-46933fe46e2e,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:15b1c9aa0205a02cffe457036dbff5fa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 87bb2bbe8fe611f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 299532701; Tue, 04 Aug 2026 17:26:10 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa: alibaba: Keep DRIVER_OK clear if IRQ setup fails
Date: Tue,  4 Aug 2026 17:26:07 +0800
Message-ID: <20260804092608.1344269-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If requesting MSI-X interrupts fails while DRIVER_OK is being set, leave
the device status unchanged instead of advertising a ready device without
working interrupts.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index e476504db..d67bdf5ab 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -216,7 +216,10 @@ static void eni_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		eni_vdpa_request_irq(eni_vdpa);
+		if (eni_vdpa_request_irq(eni_vdpa)) {
+			WARN_ON(1);
+			return;
+		}
 	}
 
 	vp_legacy_set_status(ldev, status);
-- 
2.43.0

