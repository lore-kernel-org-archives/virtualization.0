Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DD16F293
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518470; cv=none; b=ilnZP4N4PRhdH1UVfk03QgCjkDSZr5FU/W6pG7/iVhWzXla1VHwPqvBjK4waJNL5psbWuUB0Rsqftu/jeRXm8zeSYRrgOsB47aeTrPOJKytD9vihvD+DQLgMz3PnEMcsipXjXXIktB6fU+8qS9SG2UzrA6/2LXo4FZ3wlsX2qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518470; c=relaxed/simple;
	bh=k40v0efbQJzZcmQLhP/tNFCFXiDf0t0lDQ8Sui1SMiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HteB07bg/ikru7jq0dY2+H7d4YRr8v/dIw1XjeHZhnhaFjfJD752qxl2dbybdKJebjSdVqfdyy0T72fSZjovhzJRj17272n9bTflAXAQdKJ0AlyExCwP0v0Fq1lM3LQPjb7iD2rtHU47XTCSV4S4MQPMfq9T5+ALZstrESSHZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mu7a2rir; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu7a2rir"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4140781D46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvFTOQq7lf2l for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jun 2024 06:14:26 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4320981A46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4320981A46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mu7a2rir
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4320981A46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518466; x=1750054466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k40v0efbQJzZcmQLhP/tNFCFXiDf0t0lDQ8Sui1SMiI=;
  b=Mu7a2rir7SgJKyxRChrXmlACBVgxbRZJ5p4JjPf59zCiN3jhXFsoXbgP
   ZewrTClmOulQywBR8IyKI6H5OGCd5xNGAamC2dR8yKHEoRVFosNrzBc2l
   1w2DunV3FDQU55ObMOau6B4qXokn4hFPRWM9DC9JsWwFZcVuz98vQYbz8
   otuAYEhhqnJStY68dZR/k1q/Ww17QJO8D47b62Ve+d9qtqrUV8FTBumk4
   q4pEIqh222yelEPTgPAxDerbqSgoKDX74XmccYv9x7gfYmETetD0pv8HB
   9tDnOmsKvqmiPpl5TOySrOoX+ugDOWFX9edGPXXqFAwHly6klcXzv/+IE
   g==;
X-CSE-ConnectionGUID: HRbhbjksQsCLTEY/4aXltw==
X-CSE-MsgGUID: 5OrXTTF6QqO2CPiN3goE3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18289981"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18289981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:25 -0700
X-CSE-ConnectionGUID: 77K0M+wWS+mRrax1f//KKg==
X-CSE-MsgGUID: JrpAsbt6RVe25Q+FGRaEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748136"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:22 -0700
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
Subject: [PATCH v7 01/10] iommu: Introduce domain attachment handle
Date: Sun, 16 Jun 2024 14:11:46 +0800
Message-Id: <20240616061155.169343-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
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

