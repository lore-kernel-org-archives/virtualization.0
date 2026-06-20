Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83941C6A
	for <virtualization@lists.linux.dev>; Sat, 20 Jun 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950534; cv=none; b=aMnFUHIWiZX/q52Sdk9otjvHN4ZIUToLmc58XWhGIvP46g3De4i8H/5klMnYgSh2fTQh65edFDvB5zLE8rdFrYIb9MmyEH61qCqLEVUMDxpY46sLEmNu7g/3TUBmbVQb0z8cTrvqrjc7K5GWOtvMP+yQ0rxC+9pV7q52Sv5+4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950534; c=relaxed/simple;
	bh=HC2Q3Zt7CKN7ntF9ldblOVwf5Ntm6tAROQdmBAyqsMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NPLLm3pDpFl3/m+FYeu1QcunXiMRPG408D6R8DTysZezpHxJPvTaHAsu5IEoxlAp+JmJ4UxgMcNDkOAfvG0A+7rXp8v2Mava2Eh24zJ7P/Xlszs0CxUznJW0rNdfQEBh1vXt2hF2Azej0vVOCndoptpQ9UF9BjGl+y9vcysF3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=V7OTUw/w; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="V7OTUw/w"
Received: from kvmind.. (adaptive-ssl-xc-proxy0-entmail-virt174.gy.ntes [60.12.8.171])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4319bbcdc;
	Sat, 20 Jun 2026 18:10:08 +0800 (GMT+08:00)
From: Linfeng Sun <slf@hdu.edu.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linfeng Sun <slf@hdu.edu.cn>
Subject: [PATCH v2] vdpa_sim: fix cleanup after worker creation failure
Date: Sat, 20 Jun 2026 18:09:59 +0800
Message-ID: <20260620100959.2070316-1-slf@hdu.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee4825ad603a1kunm7c58a66cf3901
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0gaVk9OS0tDQkkZSUIfTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlNS1VKSVVDVUpMSllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=V7OTUw/w42gQ+WYaDPe+xvzggF84Kk/rAfbdQSh3y3szpmBmEUITMPtBtfElEdzVAWB466Y37jvt6ZQpURXxUGUxlHXZviQF/mjo/cnjMuLFgVs+ytvmrOt+PysROu9eqHtF/PhevbLNAa0aG7dxx4lYdZUJTFfX+0H22YzYyn4=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=VlX0TPUlkOXji4fcWuYb4a42ThddEnR3EqruwUNVMo8=;
	h=date:mime-version:subject:message-id:from;

vdpasim_create() leaves vdpasim->worker as an ERR_PTR when
kthread_run_worker() fails. The error path then drops the device
reference, which releases the partially initialized simulator.

vdpasim_free() unconditionally passes the worker pointer to
kthread_destroy_worker(), so the ERR_PTR is dereferenced and can trigger
a general protection fault.

Store the worker error, clear the pointer, and only clean up the worker
when it was successfully initialized. Also make the release path tolerate
partially initialized objects by guarding virtqueue and IOTLB cleanup,
since the same release path can be reached from other initialization
failures.

I found this bug myself, though the patch was written with AI assistance.

Fixes: 76acfa7bc54f ("vdpa_sim: use kthread worker")
Assisted-by: OpenAI-Codex:GPT-5
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Linfeng Sun <slf@hdu.edu.cn>
---
v1 -> v2:
- Remove the unnecessary vdpasim->iommu_pt check from IOTLB cleanup.
- Update the commit message to clarify the cleanup path for partially
  initialized devices.
- Add Fixes and Assisted-by tags.
- Link to v1: https://lore.kernel.org/r/20260612105054.1850453-1-slf@hdu.edu.cn/

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8cb1cc2ea139..2aa34df4d0ad 100644
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
+	if (vdpasim->iommu) {
+		for (i = 0; i < vdpasim->dev_attr.nas; i++)
+			vhost_iotlb_reset(&vdpasim->iommu[i]);
+	}
 	kfree(vdpasim->iommu);
 	kfree(vdpasim->iommu_pt);
 	kfree(vdpasim->vqs);
-- 
2.43.0

