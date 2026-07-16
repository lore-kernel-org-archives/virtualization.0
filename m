Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AE329391;
	Thu, 16 Jul 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164948; cv=none; b=jYoy6Aq3Q/99YJrYGk6jetnHeu/K40PzGEGJitEHeoqi3CJoI91EZwrTTksGaBpuZd/3sp3OZo+s9qSgDGoP7KdwBNoo92ECeKz6vUCdvzZ830v+UwI4x319bpF0GACbW7APBHFDpJh1RTE7StnXk6I/aIaFC9nLLkQq9ua8J7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164948; c=relaxed/simple;
	bh=U4zm0NbUyWOtwjIaogLD31LYoHgMaECzne8hEE3A+FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/a73s4815lMJs6AOfNyTMGilVJy57ZitCPRvvBH9vQkXi3ZGUHQF7ulHI4QZUj2e9M7S84zU8+paqVDxUrGyyHltBh1OJxc6LoWwOao2Yx98PT/J+ozavuBzgKcMMgE0uMqptiBK0t2svduVtNv2uVPQHXCBk7m63YEYjgwI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FfuFh/JL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FfuFh/JL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=T5
	cE0KN11dI/E52Yvv7eqo+cESpCYIhwJSXgrjLqYyQ=; b=FfuFh/JLduTN1T1iKh
	rJX2mmrhwk1+Dw3Sq1Nv1tpTMMn9s02RjbwYs1Sufendp3+eceipqpg1FkEVc76y
	5XajCMiB3/Fhi/2F+oBxVrQ4ku+kALmo0jyFms8e0V2RojPC7M8wdtQnCm2EadOH
	p0t01pHje6LvfciuGcR+XE2wo=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHriIxMlhqnYbvHQ--.48099S2;
	Thu, 16 Jul 2026 09:21:54 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: iommu@lists.linux.dev,
	jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/virtio: Set driver data before enabling virtqueues
Date: Thu, 16 Jul 2026 09:21:56 +0800
Message-ID: <20260716012157.88769-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHriIxMlhqnYbvHQ--.48099S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyDur1rWF13CFW3XrWxCrg_yoW8Ww43pF
	4DCas8GrWjqFyfGa43Jw4UZFWYvwsava4IgFW5Xan5Wr1Ykr90yFy2yFyUtw1xArWkGa1a
	va48X3ZFyFn8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_EfOUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzRJJ2GpYMjJbiwAA3s

From: Xiong Weimin <xiongweimin@kylinos.cn>

The event virtqueue callback retrieves the driver state through
vq->vdev->priv. viommu_probe() currently initializes that pointer only
after virtio_device_ready() and after the event queue is populated.

Store the driver data before creating the virtqueues so callbacks always
see initialized driver state once the device is made ready. Clear the
pointer again on probe failure.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 9118377d7..4c91a82d2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1173,11 +1173,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	ida_init(&viommu->domain_ids);
 	viommu->dev = dev;
 	viommu->vdev = vdev;
+	vdev->priv = viommu;
 	INIT_LIST_HEAD(&viommu->requests);
 
 	ret = viommu_init_vqs(viommu);
 	if (ret)
-		return ret;
+		goto err_clear_priv;
 
 	virtio_cread_le(vdev, struct virtio_iommu_config, page_size_mask,
 			&viommu->pgsize_bitmap);
@@ -1238,8 +1239,6 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	vdev->priv = viommu;
-
 	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
 	if (ret)
 		goto err_remove_sysfs;
@@ -1254,6 +1253,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+err_clear_priv:
 	vdev->priv = NULL;
 
 	return ret;
-- 
2.43.0

