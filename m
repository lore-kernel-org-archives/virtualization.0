Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1543F8A0
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835600; cv=none; b=fGao/TjVHRQRvWBBVYugFzsdJ8UvPEeVbKf98theIfV4NP/AEd6xJ4+7ek95sw6GMmGimIWjA//d0K8lVyFtjMe2p0bYQ+af25UfhspTgDc7s4Coi7PpX+Ay5dkK2LsMM6mudwPQB4EyP83EIvCPOvWUpmgkE2qp7jMi+scqtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835600; c=relaxed/simple;
	bh=oMqSj3ZjsnezIoc7W7mdo5lP4oTbGo4DuNHJFcTxwFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8sUakyQide+AkPWAYrj4IuT0GceZLgXBMvBKUSdSyNdE0M+yRkPxPYV3Gf13YH7NXucI4x+tzruD3Smxsw3yYY2DJXWI5OYl2D/No3/7z3ZLIEzTuMLDtBFUz1naqV/j62NN9ZN88oWxVQWkWhhhUlPYdcMnIUdUVHbP4PKwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 92f4cd1e8fe611f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:93f84336-1305-41b7-9190-7d56fbda1fcd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8aa1ec6372333dce2a0cb2acb29ef275,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92f4cd1e8fe611f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 956658770; Tue, 04 Aug 2026 17:26:29 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Zhu Lingshan <lingshan.zhu@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa: ifcvf: Put device on unsupported feature error
Date: Tue,  4 Aug 2026 17:26:26 +0800
Message-ID: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route unsupported provisioned features through the common error path after
vdpa_alloc_device() so the allocated device and adapter pointer are
released consistently.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ab6d6ab3b..3cd2c35db 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -724,7 +724,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		if (config->device_features & ~device_features) {
 			IFCVF_ERR(pdev, "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
 				  config->device_features, device_features);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 		device_features &= config->device_features;
 	}
@@ -748,6 +749,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	return 0;
 
 err:
+	ifcvf_mgmt_dev->adapter = NULL;
 	put_device(&adapter->vdpa.dev);
 	return ret;
 }
-- 
2.43.0

