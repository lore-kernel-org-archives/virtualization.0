Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E033A381D;
	Tue, 14 Jul 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997993; cv=none; b=CIHpboDI5q5NtbTWhedIlSGJOUS6Laq3Kz/+Xl1J+B+fAxO1PspREoickQvijAeoqq8Zwcde8lEY7l2C6HhoV/hWA3EofRDFsH1u7LYL0kLhTFJoxWFFfFPZOOT3E94y2h+mD0bapk0jYdy6LI/0DjlCnuxljVn7iipJgeg4ZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997993; c=relaxed/simple;
	bh=U4zm0NbUyWOtwjIaogLD31LYoHgMaECzne8hEE3A+FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyel2y+WCJupVHGkHWOjD1pibPeyUIVMkaailmCqV2gb33jNVB8N+mZqaqmIeCRH1pWwtM+NxXTNeRvUZHfHmeFP1amSBcQbR7SIL/Q+BMqRK89MCJ/uX4J+WELZ6V2HsCubFqmXy7QL2mIvp/tQx9EGs57D0S3uJYFnO/5TPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J58lV9VP; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J58lV9VP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=T5
	cE0KN11dI/E52Yvv7eqo+cESpCYIhwJSXgrjLqYyQ=; b=J58lV9VPw/vvkt6724
	bNPKPQENki4SxJkJ3wygKCY3ctytfYQ5JQ6g5ynV6I3Ms+BnoGwEVuNM+H3OmsmO
	I1IaCZKkRwnRRcWRWIz3s5G5UYJ+0N6PTSdnOg93ErHqJAl8zgOzoVpkiUBbpLKf
	JePPImSFl3kCjIBPNCPNAY4zs=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3b_8CplVqBxNXJA--.48351S3;
	Tue, 14 Jul 2026 10:59:22 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v1 1/2] iommu/virtio: Set driver data before enabling virtqueues
Date: Tue, 14 Jul 2026 10:59:13 +0800
Message-ID: <20260714025914.193580-2-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714025914.193580-1-15927021679@163.com>
References: <20260714025914.193580-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b_8CplVqBxNXJA--.48351S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyDur1rWF13CFW3XrWxCrg_yoW8Ww43pF
	4DCas8GrWjqFyfGa43Jw4UZFWYvwsava4IgFW5Xan5Wr1Ykr90yFy2yFyUtw1xArWkGa1a
	va48X3ZFyFn8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jseOXUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QqbJGpVpgqTpQAA3B

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

