Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114813D248
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902261; cv=none; b=c/7auKHrjTL3zn6f7IcjZ1JWWi4sZdnsDd3vDgnJZnm9tcadRkLpbET+HHU5NrAQ+rtlRRLh19by1Y37SQ+PuYOXD2FFayLhwN2aIytyMT9gXFRNlt4NGKry1GQL7e8IZGQ9uK3qA/GrG6H44wC//OT3yLlsAxN3lWby+yuA/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902261; c=relaxed/simple;
	bh=8+iX1NsitGtjrQyHSg7mn0zvhh5F8O52l6x99Zx88WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGAMosDpKynf6X0enIihgllSHa3i3l4zfSrCkD/1v7RG1fuYaPTjBeW0VduYjSYZxW01hPfbENlw18vkgUOXYU/PMhh8gmfLt3KSsbO7agK1ps6o0nB2ZvULj9tl4jDlf9ckyV4d/fh3BlV4+zdfJBqqUVYmUGdygbqhwYX4WZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCLfT3jk; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCLfT3jk"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84FC60804
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xta19J3yxYwK for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Jul 2024 06:37:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D4F7C607D2
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4F7C607D2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCLfT3jk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4F7C607D2
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902259; x=1751438259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+iX1NsitGtjrQyHSg7mn0zvhh5F8O52l6x99Zx88WY=;
  b=CCLfT3jkIgymoAMyRs+B9yVKY3Pk8x3JX1cGTaXqybj3kpdPU22GerCv
   ZHQnfN615D4m2bi61fpP1FqDt0LkP4zBXSDycJG/6uAxG3YN2RoojsXGV
   v2JjDm2A8mjetsx077iuQ3OhZtGM/+oaUGueKg4XUcDIJBVGvKLLZVqm1
   62rK0fIC/qCGDa/EdtHltTWVhwCP2n256iLHCMl9hfFSgjr9vINSwk8Nw
   XCwu6F2UTAqh36C2O2Mi4Ml50ok/VoMiI3dhy0mxmZKNciOvC/3GSwFuq
   u1Sjl3udVK+M54+VpaVzzJv+Q4f5uBpBShuQRaBnfuo7s7iccgL9tdI6t
   w==;
X-CSE-ConnectionGUID: h7XcSj+YSgmDRBBFKYbpxw==
X-CSE-MsgGUID: cGBYL/cPS/elFlUPjwJnuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455591"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455591"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:37:39 -0700
X-CSE-ConnectionGUID: QIFYx1P3SeOJPKRYYrGTCA==
X-CSE-MsgGUID: N7ZCtmPNTKeMTKnpessyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137130"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:37:35 -0700
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
Subject: [PATCH v8 02/10] iommu: Remove sva handle list
Date: Tue,  2 Jul 2024 14:34:36 +0800
Message-Id: <20240702063444.105814-3-baolu.lu@linux.intel.com>
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

The struct sva_iommu represents an association between an SVA domain and
a PASID of a device. It's stored in the iommu group's pasid array and also
tracked by a list in the per-mm data structure. Removes duplicate tracking
of sva_iommu by eliminating the list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h      |  2 --
 drivers/iommu/iommu-priv.h |  3 +++
 drivers/iommu/iommu-sva.c  | 30 ++++++++++++++++++++----------
 drivers/iommu/iommu.c      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index afc5af0069bb..87ebcc29020e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1005,14 +1005,12 @@ struct iommu_attach_handle {
 struct iommu_sva {
 	struct iommu_attach_handle	handle;
 	struct device			*dev;
-	struct list_head		handle_item;
 	refcount_t			users;
 };
 
 struct iommu_mm_data {
 	u32			pasid;
 	struct list_head	sva_domains;
-	struct list_head	sva_handles;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..f1536a5ebb0d 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,4 +28,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
+						    ioasid_t pasid,
+						    unsigned int type);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 0fb923254062..9b7f62517419 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -41,7 +41,6 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	}
 	iommu_mm->pasid = pasid;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
-	INIT_LIST_HEAD(&iommu_mm->sva_handles);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
 	 * initialization to iommu_mm fields. If it does, readers may see a
@@ -69,11 +68,16 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *attach_handle;
 	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
 	int ret;
 
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
@@ -83,12 +87,22 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
-		if (handle->dev == dev) {
-			refcount_inc(&handle->users);
-			mutex_unlock(&iommu_sva_lock);
-			return handle;
+	/* A bond already exists, just take a reference`. */
+	attach_handle = iommu_attach_handle_get(group, iommu_mm->pasid, IOMMU_DOMAIN_SVA);
+	if (!IS_ERR(attach_handle)) {
+		handle = container_of(attach_handle, struct iommu_sva, handle);
+		if (attach_handle->domain->mm != mm) {
+			ret = -EBUSY;
+			goto out_unlock;
 		}
+		refcount_inc(&handle->users);
+		mutex_unlock(&iommu_sva_lock);
+		return handle;
+	}
+
+	if (PTR_ERR(attach_handle) != -ENOENT) {
+		ret = PTR_ERR(attach_handle);
+		goto out_unlock;
 	}
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
@@ -99,7 +113,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		handle->handle.domain = domain;
 		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
 						&handle->handle);
 		if (!ret) {
@@ -115,7 +128,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_handle;
 	}
 
-	handle->handle.domain = domain;
 	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
 					&handle->handle);
 	if (ret)
@@ -125,7 +137,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 out:
 	refcount_set(&handle->users, 1);
-	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
 	return handle;
@@ -159,7 +170,6 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		mutex_unlock(&iommu_sva_lock);
 		return;
 	}
-	list_del(&handle->handle_item);
 
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a712b0cc3a1d..7890bd21dff6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3486,3 +3486,34 @@ void iommu_free_global_pasid(ioasid_t pasid)
 	ida_free(&iommu_global_pasid_ida, pasid);
 }
 EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
+
+/**
+ * iommu_attach_handle_get - Return the attach handle
+ * @group: the iommu group that domain was attached to
+ * @pasid: the pasid within the group
+ * @type: matched domain type, 0 for any match
+ *
+ * Return handle or ERR_PTR(-ENOENT) on none, ERR_PTR(-EBUSY) on mismatch.
+ *
+ * Return the attach handle to the caller. The life cycle of an iommu attach
+ * handle is from the time when the domain is attached to the time when the
+ * domain is detached. Callers are required to synchronize the call of
+ * iommu_attach_handle_get() with domain attachment and detachment. The attach
+ * handle can only be used during its life cycle.
+ */
+struct iommu_attach_handle *
+iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
+{
+	struct iommu_attach_handle *handle;
+
+	xa_lock(&group->pasid_array);
+	handle = xa_load(&group->pasid_array, pasid);
+	if (!handle)
+		handle = ERR_PTR(-ENOENT);
+	else if (type && handle->domain->type != type)
+		handle = ERR_PTR(-EBUSY);
+	xa_unlock(&group->pasid_array);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
-- 
2.34.1

