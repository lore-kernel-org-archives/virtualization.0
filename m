Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BB390219
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261781; cv=none; b=GRqPdNuKGaJhCkmn/Rsmj6sGfeQ9IzzkGCJmzq+neboWfPt33evZ7qKAGBEtGyMFH5xH7wUHqn0424mbzt6iZJDwhUmlXspNgVhXGgPO/roLfAqQvtGp6sYhaO78vsex7CerqAcyWtLIURGLGnwuUEGHgTIBP/DDGW5HDfdnsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261781; c=relaxed/simple;
	bh=D/3SHdKMYDOjPEUYWmPGQjOfgh3l3S6/oiGDEY+p7Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTvGum1TphoQ2HstVtqp4T2ob8hIWyf/oVYiw0wFVIBOxo0yNZD/Rw87Oj9Iz1/c4KHDKwQ1nGChqUNTZ13APRkp9M1F0KKUkn0CS4X7JAV2BFADRFWNXObTOjbSmr/+2IuR8lFZrLcxNUx6e5Lc5oipkgEyb36UqQrOa2ok7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=lsASMR5O; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="lsASMR5O"
Received: from kvmind.. (adaptive-ssl-xc-proxy4-entmail-virt119.gy.ntes [60.12.8.171])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4227e682e;
	Fri, 12 Jun 2026 18:50:59 +0800 (GMT+08:00)
From: Linfeng Sun <slf@hdu.edu.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linfeng Sun <slf@hdu.edu.cn>
Subject: [PATCH] vdpa_sim: fix cleanup after worker creation failure
Date: Fri, 12 Jun 2026 18:50:54 +0800
Message-ID: <20260612105054.1850453-1-slf@hdu.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ebb74ddc903a1kunm1da0a1c419767e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHU0dVk5OGkkYSRoeSkoeS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlNS1VKSVVDVUpMSllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=lsASMR5OUOh8IaagDVGA+F4ATID3VM0ECoITp5l7CK3EvDXcZyfChzdyUVevPf//v2jwRpYmZCiCVz2omHtF7VB8847m1T5VIXlSy/GzxmsO1BK0Ip1ABysvhWIipolHiEZDb6EXXe+zR6HY2l2+aoXAjAiwnA/U++pFbfBFrzI=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=atzExre4soddbyVBhn3NMb1boxCD8nxBreMRFV/9Jns=;
	h=date:mime-version:subject:message-id:from;

vdpasim_create() leaves vdpasim->worker as an ERR_PTR when
kthread_run_worker() fails. The error path then drops the device
reference, which releases the partially initialized simulator.

vdpasim_free() unconditionally passes the worker pointer to
kthread_destroy_worker(), so the ERR_PTR is dereferenced and can
trigger a general protection fault.

Store the worker error, clear the pointer, and make the release path
only clean up resources that were successfully initialized before
the failure.

Signed-off-by: Linfeng Sun <slf@hdu.edu.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8cb1cc2ea139..6a4e28c49d2d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -230,9 +230,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 
 	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
 	vdpasim->worker = kthread_run_worker(0, "vDPA sim worker: %s",
-						dev_attr->name);
-	if (IS_ERR(vdpasim->worker))
+					     dev_attr->name);
+	if (IS_ERR(vdpasim->worker)) {
+		ret = PTR_ERR(vdpasim->worker);
+		vdpasim->worker = NULL;
 		goto err_iommu;
+	}
 
 	mutex_init(&vdpasim->mutex);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -742,18 +745,24 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	kthread_cancel_work_sync(&vdpasim->work);
-	kthread_destroy_worker(vdpasim->worker);
+	if (vdpasim->worker) {
+		kthread_cancel_work_sync(&vdpasim->work);
+		kthread_destroy_worker(vdpasim->worker);
+	}
 
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
+	if (vdpasim->iommu && vdpasim->iommu_pt) {
+		for (i = 0; i < vdpasim->dev_attr.nas; i++)
+			vhost_iotlb_reset(&vdpasim->iommu[i]);
+	}
 	kfree(vdpasim->iommu);
 	kfree(vdpasim->iommu_pt);
 	kfree(vdpasim->vqs);
-- 
2.43.0

