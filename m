Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2C30648A;
	Thu, 23 Jul 2026 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771677; cv=none; b=WAHOlt5DFeV98xtBNx1kaqQq67hBLIqMBcKKUtIF+RMUYy7Ec2xdegk1Kl9wV8t1tfadivPn/3gwISzD96dRrEfGMk66laji8X3/zR7dpQNDsdj+nekBRkNFvjAB0KvQJABEmYs3Ebg3Cwpw/6EBpn75cbdRwX0h/V1OGaP/7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771677; c=relaxed/simple;
	bh=BfgF76KU7RHXVWA4ZXhFGsX2rUo/gNA8dPVIGF1WWVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIPL1di3+HljQZapHSBxpptToBG1EJGgoGgLgxU/nK8moSHavj92DFO6PixcyqejtaxFOesPGOudENvkcvnlP1hvko3AGF1FEpyAntclqTdSoEHgHKZIks0+PU57E5Cw3vl7c3Kc0qO3+N+ME2XnfdijJ+xg0dpBmR7tj49cTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g/8cgkyb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g/8cgkyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=5XzJaPSJPHYajyCN8Yh9RHtVXsmTNrL5gOYrVDz+TWM=;
	b=g/8cgkybf07tgmVPRK0kiDXTF6XRJZUsSzITbeL2eD5MDu11aCNOHSrNkkATSA
	ArDokPmzwiKZ4NcU2iW4tDAlJ/00aRBS8doy09Yqhlq60BAMSOg8G/oUqlY+UTSk
	7LLfDoExRmZEYndozhfl9jvcwih8n6+hjTwJresIYmW6E=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Xy5BdGFqQfyBIg--.17302S3;
	Thu, 23 Jul 2026 09:54:10 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iommu/virtio: Set driver data before enabling virtqueues
Date: Thu, 23 Jul 2026 09:54:07 +0800
Message-ID: <20260723095101.1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
References: <20260716012157.88769-2-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3Xy5BdGFqQfyBIg--.17302S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyfXr15CrW7ZF1DWr1kuFg_yoW8Zr4DpF
	4DCas5GrW8tFyfGa43Ja1UZF1Yvws2va40gFWfXa1kur1Ykr90yFy2yFyUtw1fArWkGa1a
	vw1kXanrCF43urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1_M-UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgMgr2phdENk9wAA3t

From: Xiong Weimin <xiongweimin@kylinos.cn>

From: Xiong Weimin <xiongweimin@kylinos.cn>

The event virtqueue callback retrieves the driver state through
vq->vdev->priv. viommu_probe() currently initializes that pointer only
after virtio_device_ready() and after the event queue is populated.

Store the driver data before creating the virtqueues so callbacks always
see initialized driver state once the device is made ready. Clear the
pointer again on probe failure.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 14 ++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..fb19d0bf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1169,11 +1169,12 @@ static int viommu_probe(struct virtio_device *vdev)
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
@@ -1234,9 +1235,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	vdev->priv = viommu;
-
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_free_sysfs;
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1244,8 +1245,12 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_free_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+err_clear_priv:
+	vdev->priv = NULL;
 
 	return ret;
 }
-- 
2.43.0

