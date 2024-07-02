Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11B12CD8B
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902258; cv=none; b=vBoFyowVXg9HFP5aSU1vdaBlDTToEOt65egUxx2vviy5WGP6YRiE07NedneZnbmZKKhupi4x8OclaQ1OFPa/67aTw6wWPsCSpMzv9LyHHNCQFwIvY64APKPNN5SSwTyHAszweoieHeo0YFjbmfJ3SFKdvnKkPvTJMzEhHIWt84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902258; c=relaxed/simple;
	bh=BZSDz0KzxucLY0QHtPPPO1kqDaVfkMKtM4/CokGnRhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMTGNhyspNqk/U6QFNLpclvPbCac2zPSvhXHmdXU1vuuymtldPM8tiWkEthKB1U92fA6n8V7p9gd0zFhGQCzMA50ZmGQWmiXAd+bD8JlpUDbaUxNb2y0A2SJXvjdwRbJ4Jb82yUxdPLsBQgzkjFY9x84zyfZkljXFoToDN6LJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsCQrd5v; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsCQrd5v"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27C3E60804
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VEAZbG8oYmZe for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Jul 2024 06:37:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 20CA7607D2
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20CA7607D2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bsCQrd5v
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20CA7607D2
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902255; x=1751438255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZSDz0KzxucLY0QHtPPPO1kqDaVfkMKtM4/CokGnRhQ=;
  b=bsCQrd5v3Cci82ESh8gtmfB67x3W1ak65IJwOKY1na75K5nq02LsQ+SU
   9v65AJ/m5qwUZkUiVmVFoH7OEsC7EQ2Gi5NT7LwUI6wsu03mJKdkVdOr3
   mB2Prridp2P2odd4LaG2VjJdD/E0mBzy/IiNa7XUbiedsHK7Dr47ERMaj
   1L2fHXDX9oIs20z1dHohhozd4L2T72E+BRvOQVhuY6ooXi9VcZLkAKLVi
   UfLAg7uyHDvuuAzOgps4sXoJ6hR5GV/GVC98ALPWFWBtFk7BjAbr5zYYX
   SRQEx5djhwVcHW/YtCb+j/IhW9Ex9g/Nee5hXJCfIi1rBxqddZ/JlvJfa
   g==;
X-CSE-ConnectionGUID: s6KTtqGHRryfyQaSbP6Hiw==
X-CSE-MsgGUID: Kc3zn9HhQiyqL4sQ6dovPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455577"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:37:35 -0700
X-CSE-ConnectionGUID: /GQfl16ETLW9bOhKZ8salA==
X-CSE-MsgGUID: IJj62i/mTGebSDJKVcQ6ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137111"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:37:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 01/10] iommu: Introduce domain attachment handle
Date: Tue,  2 Jul 2024 14:34:35 +0800
Message-Id: <20240702063444.105814-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702063444.105814-1-baolu.lu@linux.intel.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when attaching a domain to a device or its PASID, domain is
stored within the iommu group. It could be retrieved for use during the
window between attachment and detachment.

With new features introduced, there's a need to store more information
than just a domain pointer. This information essentially represents the
association between a domain and a device. For example, the SVA code
already has a custom struct iommu_sva which represents a bond between
sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
a place to store the iommufd_device pointer in the core, so that the
device object ID could be quickly retrieved in the critical fault handling
path.

Introduce domain attachment handle that explicitly represents the
attachment relationship between a domain and a device or its PASID.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h     | 18 +++++++++++++++---
 drivers/dma/idxd/init.c   |  2 +-
 drivers/iommu/iommu-sva.c | 13 ++++++++-----
 drivers/iommu/iommu.c     | 26 ++++++++++++++++----------
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17b3f36ad843..afc5af0069bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -989,12 +989,22 @@ struct iommu_fwspec {
 /* ATS is supported */
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
 
+/*
+ * An iommu attach handle represents a relationship between an iommu domain
+ * and a PASID or RID of a device. It is allocated and managed by the component
+ * that manages the domain and is stored in the iommu group during the time the
+ * domain is attached.
+ */
+struct iommu_attach_handle {
+	struct iommu_domain		*domain;
+};
+
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
 struct iommu_sva {
+	struct iommu_attach_handle	handle;
 	struct device			*dev;
-	struct iommu_domain		*domain;
 	struct list_head		handle_item;
 	refcount_t			users;
 };
@@ -1052,7 +1062,8 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner);
 void iommu_device_release_dma_owner(struct device *dev);
 
 int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid);
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_attach_handle *handle);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 struct iommu_domain *
@@ -1388,7 +1399,8 @@ static inline int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 }
 
 static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
-					    struct device *dev, ioasid_t pasid)
+					    struct device *dev, ioasid_t pasid,
+					    struct iommu_attach_handle *handle)
 {
 	return -ENODEV;
 }
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7295943fa22..385c488c9cd1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -584,7 +584,7 @@ static int idxd_enable_system_pasid(struct idxd_device *idxd)
 	 * DMA domain is owned by the driver, it should support all valid
 	 * types such as DMA-FQ, identity, etc.
 	 */
-	ret = iommu_attach_device_pasid(domain, dev, pasid);
+	ret = iommu_attach_device_pasid(domain, dev, pasid, NULL);
 	if (ret) {
 		dev_err(dev, "failed to attach device pasid %d, domain type %d",
 			pasid, domain->type);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 18a35e798b72..0fb923254062 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -99,7 +99,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
+		handle->handle.domain = domain;
+		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
+						&handle->handle);
 		if (!ret) {
 			domain->users++;
 			goto out;
@@ -113,7 +115,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_handle;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
+	handle->handle.domain = domain;
+	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
+					&handle->handle);
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -124,7 +128,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
-	handle->domain = domain;
 	return handle;
 
 out_free_domain:
@@ -147,7 +150,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  */
 void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
-	struct iommu_domain *domain = handle->domain;
+	struct iommu_domain *domain = handle->handle.domain;
 	struct iommu_mm_data *iommu_mm = domain->mm->iommu_mm;
 	struct device *dev = handle->dev;
 
@@ -170,7 +173,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	struct iommu_domain *domain = handle->domain;
+	struct iommu_domain *domain = handle->handle.domain;
 
 	return mm_get_enqcmd_pasid(domain->mm);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..a712b0cc3a1d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3352,16 +3352,17 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
  * @domain: the iommu domain.
  * @dev: the attached device.
  * @pasid: the pasid of the device.
+ * @handle: the attach handle.
  *
  * Return: 0 on success, or an error.
  */
 int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid)
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_attach_handle *handle)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
-	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
@@ -3382,11 +3383,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+	if (handle)
+		handle->domain = domain;
+
+	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	if (ret)
 		goto out_unlock;
-	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
 	if (ret)
@@ -3414,7 +3416,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid, domain);
-	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	xa_erase(&group->pasid_array, pasid);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
@@ -3439,15 +3441,19 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *handle;
+	struct iommu_domain *domain = NULL;
 
 	if (!group)
 		return NULL;
 
 	xa_lock(&group->pasid_array);
-	domain = xa_load(&group->pasid_array, pasid);
+	handle = xa_load(&group->pasid_array, pasid);
+	if (handle)
+		domain = handle->domain;
+
 	if (type && domain && domain->type != type)
-		domain = ERR_PTR(-EBUSY);
+		domain = NULL;
 	xa_unlock(&group->pasid_array);
 
 	return domain;
-- 
2.34.1

