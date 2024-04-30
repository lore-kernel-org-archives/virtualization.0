Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516A77113
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489139; cv=none; b=TdziT1bEUs262094orKQPBWy8N6gDCb2e6baLq9gjs8P59IScH2OSBCUJekNXBbaj3wzfBEIAm4C8T6ghmQImg2iRycWndedZCcacy0BM0f/y7yUcd+3dQAn1uM7jNhbleLzqgGgR9JRZht8yr4rphaklfYt6cQ6ruuXHS+oZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489139; c=relaxed/simple;
	bh=eJg1IrEO+bhzHqqK9L/urRgNg+D/QfOmUZT/VIVb4o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtYuIzw/Ks1rpgBqjliGiVOpaewkAFd4bjANthmhFFn8KbCMAdhU2obiLYOoJMzImsRK+1GNnfj+cXNpOt9dT23NBuIgFO9fhp29T2NLYxgWCNlatNcn3dtgK6rBrgNPCuknTpDq+jf8OQcfXXWcDDzabJ57LBW1A1AkeXKz96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdwVS50h; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdwVS50h"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85E8280C14
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m09IY6OMw2Cn for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 14:58:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7AD6480C04
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AD6480C04
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VdwVS50h
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7AD6480C04
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489137; x=1746025137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJg1IrEO+bhzHqqK9L/urRgNg+D/QfOmUZT/VIVb4o0=;
  b=VdwVS50h5cx2oflK0HLfiddfZbeDjBiJ8+1CZMx73lItLbb9bnUEws9/
   YhjNbreqYaRRjE1Go3YrzFsrvh6arsMN8U+mrXhIQDj+5y1J96BAzsiKL
   ybI6ChjCW6ItWz6N5dPpL59KTnYaB7HPTpCK9hOEwcjUry3Xz4YEYnZ6L
   Yaf+UufsAGWsJNP23+OWoWN2Ebp4IGuiCD8h3TgGwPCb3D3wTVzQEJBZm
   Afs9YSoofA8ELRc7eCYujf6bMOqNJCxItLANUWHTiBodWj00wSJUcAWIe
   XB+zwP2YDRudHE5wyQdhidEH2XzjgqsqA+aYQy/INKrkpV+CbkfSz9mY1
   g==;
X-CSE-ConnectionGUID: v0LWMevNRPOHUngtkTrgQg==
X-CSE-MsgGUID: wUpCQV7+Rw6tcSZBACJ1zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059857"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:58:56 -0700
X-CSE-ConnectionGUID: XW85v6VRSEit2332MDq5/w==
X-CSE-MsgGUID: AMhI6ujXSMiFFbrJ+Stzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282147"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:58:52 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Date: Tue, 30 Apr 2024 22:57:03 +0800
Message-Id: <20240430145710.68112-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145710.68112-1-baolu.lu@linux.intel.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct sva_iommu represents a bond of an SVA domain and a device.
It is functionally equivalent to the iommu_attach_handle. To avoid
code duplication, replace sva_iommu with the iommu_attach_handle and
remove the code that manages sva_iommu.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 28 +++++++------------------
 include/linux/uacce.h      |  2 +-
 drivers/dma/idxd/idxd.h    |  2 +-
 drivers/iommu/iommu-priv.h |  7 +++++++
 drivers/dma/idxd/cdev.c    |  4 ++--
 drivers/iommu/iommu-sva.c  | 43 ++++++++++++++++++--------------------
 drivers/misc/uacce/uacce.c |  2 +-
 7 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..be9c9a10169d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -39,7 +39,6 @@ struct iommu_domain;
 struct iommu_domain_ops;
 struct iommu_dirty_ops;
 struct notifier_block;
-struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
 
@@ -986,20 +985,9 @@ struct iommu_fwspec {
 /* ATS is supported */
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
 
-/**
- * struct iommu_sva - handle to a device-mm bond
- */
-struct iommu_sva {
-	struct device			*dev;
-	struct iommu_domain		*domain;
-	struct list_head		handle_item;
-	refcount_t			users;
-};
-
 struct iommu_mm_data {
 	u32			pasid;
 	struct list_head	sva_domains;
-	struct list_head	sva_handles;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -1527,24 +1515,24 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 void mm_pasid_drop(struct mm_struct *mm);
-struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
-u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+struct iommu_attach_handle *iommu_sva_bind_device(struct device *dev,
+						  struct mm_struct *mm);
+void iommu_sva_unbind_device(struct iommu_attach_handle *handle);
+u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle);
 struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
 #else
-static inline struct iommu_sva *
+static inline struct iommu_attach_handle *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
-static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+static inline void iommu_sva_unbind_device(struct iommu_attach_handle *handle)
 {
 }
 
-static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+static inline u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index e290c0269944..1548119c89ae 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -97,7 +97,7 @@ struct uacce_queue {
 	struct mutex mutex;
 	enum uacce_q_state state;
 	u32 pasid;
-	struct iommu_sva *handle;
+	struct iommu_attach_handle *handle;
 	struct address_space *mapping;
 };
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7b98944135eb..45588156ca60 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -335,7 +335,7 @@ struct idxd_device {
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	unsigned int pasid;
 
 	int num_groups;
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index da1addaa1a31..ae65e0b85d69 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -30,6 +30,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 
 struct iommu_attach_handle {
 	struct iommu_domain		*domain;
+	union {
+		/* attach data for SVA domain */
+		struct {
+			struct device	*dev;
+			refcount_t	users;
+		};
+	};
 };
 
 struct iommu_attach_handle *
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index c095a2c8f659..f8ac47bdfc4c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -45,7 +45,7 @@ struct idxd_user_context {
 	unsigned int pasid;
 	struct mm_struct *mm;
 	unsigned int flags;
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	struct idxd_dev idxd_dev;
 	u64 counters[COUNTER_MAX];
 	int id;
@@ -225,7 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 640acc804e8c..d49737e43de2 100644
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
@@ -67,13 +66,17 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
  *
  * On error, returns an ERR_PTR value.
  */
-struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+struct iommu_attach_handle *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *handle;
 	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
-	struct iommu_sva *handle;
 	int ret;
 
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
@@ -83,17 +86,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
-		if (handle->dev == dev) {
-			refcount_inc(&handle->users);
-			mutex_unlock(&iommu_sva_lock);
-			return handle;
-		}
+	/* A bond already exists, just take a reference`. */
+	handle = iommu_attach_handle_get(group, iommu_mm->pasid, IOMMU_DOMAIN_SVA);
+	if (!IS_ERR(handle)) {
+		refcount_inc(&handle->users);
+		mutex_unlock(&iommu_sva_lock);
+		return handle;
 	}
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle) {
-		ret = -ENOMEM;
+	if (handle == ERR_PTR(-EBUSY)) {
+		ret = PTR_ERR(handle);
 		goto out_unlock;
 	}
 
@@ -110,7 +111,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	domain = iommu_sva_domain_alloc(dev, mm);
 	if (!domain) {
 		ret = -ENOMEM;
-		goto out_free_handle;
+		goto out_unlock;
 	}
 
 	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
@@ -120,17 +121,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	list_add(&domain->next, &mm->iommu_mm->sva_domains);
 
 out:
+	handle = iommu_attach_handle_get(group, iommu_mm->pasid, 0);
 	refcount_set(&handle->users, 1);
-	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
-	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
-	handle->domain = domain;
+	mutex_unlock(&iommu_sva_lock);
+
 	return handle;
 
 out_free_domain:
 	iommu_domain_free(domain);
-out_free_handle:
-	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
 	return ERR_PTR(ret);
@@ -145,7 +144,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  * not be issuing any more transaction for this PASID. All outstanding page
  * requests for this PASID must have been flushed to the IOMMU.
  */
-void iommu_sva_unbind_device(struct iommu_sva *handle)
+void iommu_sva_unbind_device(struct iommu_attach_handle *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 	struct iommu_mm_data *iommu_mm = domain->mm->iommu_mm;
@@ -156,7 +155,6 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		mutex_unlock(&iommu_sva_lock);
 		return;
 	}
-	list_del(&handle->handle_item);
 
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
@@ -164,11 +162,10 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		iommu_domain_free(domain);
 	}
 	mutex_unlock(&iommu_sva_lock);
-	kfree(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
-u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bdc2e6fda782..b325097421c1 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -106,7 +106,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
 static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 {
 	u32 pasid;
-	struct iommu_sva *handle;
+	struct iommu_attach_handle *handle;
 
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
-- 
2.34.1

