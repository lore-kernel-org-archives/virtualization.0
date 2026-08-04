Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1D420468
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829019; cv=none; b=dhSvcqy5JcrUG7y2mQLrMnKJD5wHByq/RtWgkuSoSbifC90v613Uqr4Dqr967XFlzoMfMchSB/IMBHX/PpczKWMrB+SO9vUQi9ArW1KO7kPjFT8ExPQr2rHbx/kPDpVkKlulD5oRgLEr1h/d1X8s5lX0o8TiaNqGI37p3uTkID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829019; c=relaxed/simple;
	bh=G/Pcb/h+3JpB3QfTdB9vHc6k/yZ8eD4pxRBA+HT5vzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZI2DDXlark4bZWYJCoBWSqf49A/JFPGW7jcXyJsdpVl2/6SDpezz1if7/eWzHxk+01g4sUidKwlEWGeQC4TK/4NKxUB8rmY81ycXU/eTDsx6L3hXDeSVMKwy8QoJ11UemB9HHN11McgoyxTVQQUSFp7KPNQUguMD6vJkycPDvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3fe6d73e8fd711f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:53275e99-abd1-407f-b5c5-218d0a946064,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f256f38ca1310feb695d2d6bf3d2df88,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3fe6d73e8fd711f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1331519018; Tue, 04 Aug 2026 15:36:47 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa/vdpa_sim: guard partial device teardown
Date: Tue,  4 Aug 2026 15:36:41 +0800
Message-ID: <20260804073643.1293172-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdpasim_create() unwinds early allocation failures with put_device(),
which invokes the vdpa free callback even when the worker, virtqueues or
IOTLB arrays have not all been initialized.  vdpasim_free() currently
assumes the fully initialized path and can dereference NULL or ERR_PTR
state during those failures.

Make the free callback tolerate partially initialized simulator devices
before destroying the worker or walking optional arrays.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8cb1cc2ea..77966e957 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -743,17 +743,22 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	int i;
 
 	kthread_cancel_work_sync(&vdpasim->work);
-	kthread_destroy_worker(vdpasim->worker);
+	if (!IS_ERR_OR_NULL(vdpasim->worker))
+		kthread_destroy_worker(vdpasim->worker);
 
-	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
-		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
-		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
+	if (vdpasim->vqs) {
+		for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
+			vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
+			vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
+		}
 	}
 
 	vdpasim->dev_attr.free(vdpasim);
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
-		vhost_iotlb_reset(&vdpasim->iommu[i]);
+	if (vdpasim->iommu) {
+		for (i = 0; i < vdpasim->dev_attr.nas; i++)
+			vhost_iotlb_reset(&vdpasim->iommu[i]);
+	}
 	kfree(vdpasim->iommu);
 	kfree(vdpasim->iommu_pt);
 	kfree(vdpasim->vqs);
-- 
2.43.0

