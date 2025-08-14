Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341911991BF;
	Thu, 14 Aug 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190051; cv=none; b=Wi0lnMKShNFc3/4PfHoCTr8ZcLUENSCkfYDwE22TJu+3EN+KWq+v03kpwHelXgGzgqmUdBXUc4bBEeBGSm9BHPn0pEkM0sqocAdOHLMSTh6VYAzgUstiC9x8/kOYfGn328cDzwEBJyDEXIbQlcCoP3z2PrUH26IkR5/DZZKhbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190051; c=relaxed/simple;
	bh=RZ39O8LRy1DmXEIYFGqThJTu+hwEpbt7xjcvbQVF8+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jt7Zw79+7TmDNMlyA+em27WwwijhFGuIn0Nph+JZxcYYeGstXJpZNE+719EHdCA1tpYAkPCGc/P0lHvjVi/5FRYu6CuEGcM2lGsRiNxbuwL41jYhhq1B64Rrsf+c2TNEWTfKeRdw5QQikNHZUPW5DIyTf0KYuVqTqikNJBdh/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 526841691;
	Thu, 14 Aug 2025 09:47:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77AF63F738;
	Thu, 14 Aug 2025 09:47:26 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org,
	jean-philippe@linaro.org
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	eric.auger@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v2] iommu/virtio: Make instance lookup robust
Date: Thu, 14 Aug 2025 17:47:16 +0100
Message-Id: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much like arm-smmu in commit 7d835134d4e1 ("iommu/arm-smmu: Make
instance lookup robust"), virtio-iommu appears to have the same issue
where iommu_device_register() makes the IOMMU instance visible to other
API callers (including itself) straight away, but internally the
instance isn't ready to recognise itself for viommu_probe_device() to
work correctly until after viommu_probe() has returned. This matters a
lot more now that bus_iommu_probe() has the DT/VIOT knowledge to probe
client devices the way that was always intended. Tweak the lookup and
initialisation in much the same way as for arm-smmu, to ensure that what
we register is functional and ready to go.

Cc: stable@vger.kernel.org
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Of course generic bus_find_device_by_fwnode() didn't work, since
    it's dev->parent we need to check rather than dev itself, sigh...
---
 drivers/iommu/virtio-iommu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 532db1de201b..b39d6f134ab2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -998,8 +998,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static const struct iommu_ops viommu_ops;
-static struct virtio_driver virtio_iommu_drv;
+static const struct bus_type *virtio_bus_type;
 
 static int viommu_match_node(struct device *dev, const void *data)
 {
@@ -1008,8 +1007,9 @@ static int viommu_match_node(struct device *dev, const void *data)
 
 static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
-						fwnode, viommu_match_node);
+	struct device *dev = bus_find_device(virtio_bus_type, NULL, fwnode,
+					     viommu_match_node);
+
 	put_device(dev);
 
 	return dev ? dev_to_virtio(dev)->priv : NULL;
@@ -1160,6 +1160,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (!viommu)
 		return -ENOMEM;
 
+	/* Borrow this for easy lookups later */
+	virtio_bus_type = dev->bus;
+
 	spin_lock_init(&viommu->request_lock);
 	ida_init(&viommu->domain_ids);
 	viommu->dev = dev;
@@ -1229,10 +1232,10 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
-
 	vdev->priv = viommu;
 
+	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
 	dev_info(dev, "page mask: %#llx\n", viommu->pgsize_bitmap);
-- 
2.39.2.101.g768bb238c484.dirty

