Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463CC153
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782871; cv=none; b=Yy9uQ+h1/scBkbQR9GjzxYA2Oj6XJBttA0FHjYLEO8GBvjwN281+VqwuFZr8YLyj6jnEkBpcAv7zCrtzUEF5pobx2Uvu3IjeiWpE7zwSEOgPQe3/DPtfJqWnRWu20CIzZO/1gPGw98twKGVDPRzN/g9LhP+qtJ54LnknUVPHCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782871; c=relaxed/simple;
	bh=J9wCRtxD0gbdHyIEhv/YJB4bZC0qR/j8eeGR5NVu5qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q152+P4oBkzXETwLyqLE7PEbqKCOcw44STXWJd+jd7G15rHOT7flsJ/C/TpaAb0IqGCtXSPGSd9Olt2LgGKQ2HOajaxfYSkLhIBMcu64aXRiMDRHNWIuN6/PvgdaMNDJ+FPLguALWbj6pjokOO6YZYFKTLzCoSIP/3UHGhCCCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyteMkrp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyteMkrp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0999606DF
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1nYjRfvd5VE for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 04:07:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F239A6067F
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F239A6067F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GyteMkrp
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F239A6067F
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782868; x=1748318868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9wCRtxD0gbdHyIEhv/YJB4bZC0qR/j8eeGR5NVu5qM=;
  b=GyteMkrpFX4ZDTkR5caKqqHLPsYY++w6784ocA5ztCwgchPX48groMY1
   zsr60uuTtc1xWSZkFwQgj6l7KnQ9w87W57GnanNlovtp7ZAxOYhYG3D/H
   ohJuXuBhKIvlbG/y0V3RwmyrUm9LmS5dK1Catm9CoHBdgsY1uYd66JnAu
   ffkr+L0fpNl8r5VP4p8l7FKU3SsBYrssRYC3uWMoYjfmF13+vo80qiBhW
   1yNIuI0AjtrXN533mqJ5RZ3DEcusu2NibAa/XkDB71wH23oNAprfvy2cm
   /tukXB+XGu1C4pG7vUjichumHlrTrH7AGsfoBfLtL+6MQ/70Rm0Q0VvkC
   w==;
X-CSE-ConnectionGUID: CmkdWeVgQA6H4LnTmOSJNw==
X-CSE-MsgGUID: gBsoKF2JTWWaf/MR4hgF9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022667"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:29 -0700
X-CSE-ConnectionGUID: KFSkJIPGShaByYscKSv2uw==
X-CSE-MsgGUID: AmXwEEv/S3+dzE7OfZJ60Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399874"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:25 -0700
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
Subject: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Date: Mon, 27 May 2024 12:05:08 +0800
Message-Id: <20240527040517.38561-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
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
---
 include/linux/iommu.h     | 18 +++++++++++++++---
 drivers/dma/idxd/init.c   |  2 +-
 drivers/iommu/iommu-sva.c | 13 ++++++++-----
 drivers/iommu/iommu.c     | 23 +++++++++++++----------
 4 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..b89404acacd6 100644
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
index 9df7cc75c1bc..efd281ddfa63 100644
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
@@ -3382,11 +3383,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	if (ret)
 		goto out_unlock;
-	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
 	if (ret)
@@ -3414,7 +3413,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid, domain);
-	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
+	xa_erase(&group->pasid_array, pasid);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
@@ -3439,15 +3438,19 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
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

