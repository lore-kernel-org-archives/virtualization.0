Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C51CAA78
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376235; cv=none; b=RF5r/ZhUrOB1Krj+yezQZwZSPNrrxIZuBnIFKO+W0TdEVoZJlSkZNFS0l3A+ld7ijarian8aG9gPHYGHabvcykY0KLI1W/UPu8c4QDebsDrXwKQSS7zKsAf85yb+v0ifCX4nUOvSAyXedWab1vUbzeJ2LD9BUhE7BGcoKRNdDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376235; c=relaxed/simple;
	bh=FR9fdyFTG1rKPCtdddsLtrPOa9X3tHn9krp8q2H0Ooo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWgmRRVqc8u0DoR4F+7H27QCsB1ICcIC5p94GgyLe4PsUsdJZAtsf8NBE7ehPNDNPSok/scu1ABJ5NPWo8YAUSrtLt6GH//vRF78bgErkUn+aNSDKLiUvX5y5W+8tTBzWDAAAfScN6wibAwB1u153+/trtKrU2CoWbpDK8+vuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b4dZLBVd; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b4dZLBVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KL
	ryOKMuh5v/VzMMwRtVLovk0/K170sZ694pDdOCQZQ=; b=b4dZLBVd2Do8QuMD7u
	02NHi0aliDELDY3yLBWdXHqgCgwnVXXfCJLzS1BiIFQWQ3FdT3QKVROj0NoDX49O
	/X6s4sOhy1p3l4F9M2/5+46U5x2uuQS8leqcDgQKm0TqAITkgEoqwg3O+cs+YwA4
	ToPdpXF1D9E/A/8VZwosW2bZY=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnb5oc5zxq9aLPFg--.52298S2;
	Thu, 25 Jun 2026 16:30:20 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: virtualization@lists.linux.dev
Cc: jasowang@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Subject: [PATCH] vdpa_sim: fix cleanup after worker creation failure
Date: Thu, 25 Jun 2026 16:30:16 +0800
Message-ID: <20260625083017.497842-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnb5oc5zxq9aLPFg--.52298S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1rJr1rAw48uF1kGrWxWFg_yoW5GF4fpr
	4akw1kKFs7X3WxJFn8Ca17Zwn5Kr18Kr43KFyDta4UCw15JryDZas7Jr98Zr1Fkr1rAr13
	ur45GrsrKF9rJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8_-PUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AGrNGo85yHgmAAA3C

From: Xiong Weimin <xiongweimin@kylinos.cn>

vdpasim_create() leaves vdpasim->worker as an ERR_PTR when
kthread_run_worker() fails. The error path then drops the device
reference, which releases the partially initialized simulator.

vdpasim_free() unconditionally passes the worker pointer to
kthread_destroy_worker(), so the ERR_PTR is dereferenced and can
trigger a general protection fault.

Store the worker error, clear the pointer, and make the release path
only clean up resources that were successfully initialized before
the failure.

Tested on openEuler VM with kernel 6.16.8: module build, reload,
and vdpa dev add via vdpasim_net.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 1111111..2222222 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -231,8 +231,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
 	vdpasim->worker = kthread_run_worker(0, "vDPA sim worker: %s",
 						dev_attr->name);
-	if (IS_ERR(vdpasim->worker))
+	if (IS_ERR(vdpasim->worker)) {
+		ret = PTR_ERR(vdpasim->worker);
+		vdpasim->worker = NULL;
 		goto err_iommu;
+	}
 
 	mutex_init(&vdpasim->mutex);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -750,18 +753,24 @@ static void vdpasim_free(struct vdpa_device *vdpa)
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
2.39.0

