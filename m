Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3371755A
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782878; cv=none; b=H6EJL3EYKkDGHihAL2VppDaozXDPaLDdmMr+MnpEZpcQM+qaBq0C6AUAfXe9DKTANYwTJj+xukl8D5EX/VJQ/SXVpoLBgAFZKwhV1JmvCbRqODUWO/MUoiaJ/CGgmGOJIud2QD3GOVbLzHAHB76Mv98jzk/Sqi3mNwCgyy2LglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782878; c=relaxed/simple;
	bh=xeDpc6y+D8uSW+ULNIeE3Wqi4B8D6lEG8uPBD3ayIuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnh/zPdhrGrgeW8Q1zcxzPRkv/mlXkgAhuX5alfZGzA+NJtqdfFFzp6f9cT6Otr9SIcBtLmgMgBjJNqGYvgeHAWdt2hmapXI5p4YqviQfwTEv66L/oxDOKgjY1zAQEshM5dXcWs/O5NVZubHJdx0YZ7nnthpfXcsK4UMmegONBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEs2B3Wy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEs2B3Wy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E43E36067F
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id muz9ckmp0ANA for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 04:07:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D727F605C4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D727F605C4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lEs2B3Wy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D727F605C4
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782875; x=1748318875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xeDpc6y+D8uSW+ULNIeE3Wqi4B8D6lEG8uPBD3ayIuU=;
  b=lEs2B3WyjaOOderQRKO/MhCwCxqft4zBXm+g48Hy4zL7YjRJdJKKO1iH
   Au5uTSqDYojsL3+912nVis35AlheBrypwjXU3hYpxVGX8mtUhavE341Pl
   +5+oYYOJYp4oOtF6RCz9rOXVYpJjbJpuvbh2F/I1f5HpOhHr5oY39+b5R
   E9jDBxWwrMdGTY7rh8WZ1UvRJr+7zwUONjf13CVsI/6UpVXKYz24RtJGw
   xyQE1/qOqPEnd26J+JMThAHxKQAPoKdL7pxgTujjS88NXLYPayMsJB3kF
   IV1EbQKIonO3ILLF9a9tcGKl/4BTQl2kuU4i/2Im5tB6Tt6i6QQHPXo+u
   w==;
X-CSE-ConnectionGUID: 0acgR7hATcO42VL1VJ3NBQ==
X-CSE-MsgGUID: 7vsarocXS2C6ZvuDc+LRcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022735"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022735"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:36 -0700
X-CSE-ConnectionGUID: O5qiNgNhQLyJBSoO/z1/uQ==
X-CSE-MsgGUID: KqbDLQ4WQQCSjKaXKNpjnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399901"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:32 -0700
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
Subject: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Date: Mon, 27 May 2024 12:05:10 +0800
Message-Id: <20240527040517.38561-4-baolu.lu@linux.intel.com>
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

Previously, the domain that a page fault targets is stored in an
iopf_group, which represents a minimal set of page faults. With the
introduction of attach handle, replace the domain with the handle
so that the fault handler can obtain more information as needed
when handling the faults.

iommu_report_device_fault() is currently used for SVA page faults,
which handles the page fault in an internal cycle. The domain is retrieved
with iommu_get_domain_for_dev_pasid() if the pasid in the fault message
is valid. This doesn't work in IOMMUFD case, where if the pasid table of
a device is wholly managed by user space, there is no domain attached to
the PASID of the device, and all page faults are forwarded through a
NESTING domain attaching to RID.

Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
indicates if the IOMMU driver supports user-managed PASID tables. In the
iopf deliver path, if no attach handle found for the iopf PASID, roll
back to RID domain when the IOMMU driver supports this capability.

iommu_get_domain_for_dev_pasid() is no longer used and can be removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 18 +++++-------
 drivers/iommu/io-pgfault.c | 59 +++++++++++++++++++++-----------------
 drivers/iommu/iommu-sva.c  |  3 +-
 drivers/iommu/iommu.c      | 39 -------------------------
 4 files changed, 41 insertions(+), 78 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 823fa3bcc2c6..4067ebdd6232 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,7 +127,7 @@ struct iopf_group {
 	/* list node for iommu_fault_param::faults */
 	struct list_head pending_node;
 	struct work_struct work;
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
 };
@@ -249,6 +249,12 @@ enum iommu_cap {
 	 */
 	IOMMU_CAP_DEFERRED_FLUSH,
 	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
+	/*
+	 * IOMMU driver supports user-managed IOASID table. There is no
+	 * user domain for each PASID and the I/O page faults are forwarded
+	 * through the user domain attached to the device RID.
+	 */
+	IOMMU_CAP_USER_IOASID_TABLE,
 };
 
 /* These are the possible reserved region types */
@@ -1064,9 +1070,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct iommu_attach_handle *handle);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
-struct iommu_domain *
-iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
-			       unsigned int type);
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
 void iommu_free_global_pasid(ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
@@ -1408,13 +1411,6 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 {
 }
 
-static inline struct iommu_domain *
-iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
-			       unsigned int type)
-{
-	return NULL;
-}
-
 static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 {
 	return IOMMU_PASID_INVALID;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 06d78fcc79fd..c62fcb67ef02 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -59,30 +59,6 @@ void iopf_free_group(struct iopf_group *group)
 }
 EXPORT_SYMBOL_GPL(iopf_free_group);
 
-static struct iommu_domain *get_domain_for_iopf(struct device *dev,
-						struct iommu_fault *fault)
-{
-	struct iommu_domain *domain;
-
-	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
-		if (IS_ERR(domain))
-			domain = NULL;
-	} else {
-		domain = iommu_get_domain_for_dev(dev);
-	}
-
-	if (!domain || !domain->iopf_handler) {
-		dev_warn_ratelimited(dev,
-			"iopf (pasid %d) without domain attached or handler installed\n",
-			 fault->prm.pasid);
-
-		return NULL;
-	}
-
-	return domain;
-}
-
 /* Non-last request of a group. Postpone until the last one. */
 static int report_partial_fault(struct iommu_fault_param *fault_param,
 				struct iommu_fault *fault)
@@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain)
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
+							       fault->prm.pasid,
+							       0);
+		if (IS_ERR(group->attach_handle)) {
+			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
+				goto err_abort;
+
+			/*
+			 * The iommu driver for this device supports user-
+			 * managed PASID table. Therefore page faults for
+			 * any PASID should go through the NESTING domain
+			 * attached to the device RID.
+			 */
+			group->attach_handle =
+				iommu_attach_handle_get(dev->iommu_group,
+							IOMMU_NO_PASID,
+							IOMMU_DOMAIN_NESTED);
+			if (IS_ERR(group->attach_handle))
+				goto err_abort;
+		}
+	} else {
+		group->attach_handle =
+			iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
+		if (IS_ERR(group->attach_handle))
+			goto err_abort;
+	}
+
+	if (!group->attach_handle->domain->iopf_handler)
 		goto err_abort;
 
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
 	 * iopf_free_group()
 	 */
-	if (group->domain->iopf_handler(group))
+	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
 	return;
 
 err_abort:
+	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
+			     fault->prm.pasid);
 	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
 	if (group == &abort_group)
 		__iopf_free_group(group);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index e85f4ccc9dcc..36d2862941de 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -265,7 +265,8 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 		if (status != IOMMU_PAGE_RESP_SUCCESS)
 			break;
 
-		status = iommu_sva_handle_mm(&iopf->fault, group->domain->mm);
+		status = iommu_sva_handle_mm(&iopf->fault,
+					     group->attach_handle->domain->mm);
 	}
 
 	iopf_group_response(group, status);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0263814cba6b..c506185a2fad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3418,45 +3418,6 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
 
-/*
- * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
- * @dev: the queried device
- * @pasid: the pasid of the device
- * @type: matched domain type, 0 for any match
- *
- * This is a variant of iommu_get_domain_for_dev(). It returns the existing
- * domain attached to pasid of a device. Callers must hold a lock around this
- * function, and both iommu_attach/detach_dev_pasid() whenever a domain of
- * type is being manipulated. This API does not internally resolve races with
- * attach/detach.
- *
- * Return: attached domain on success, NULL otherwise.
- */
-struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
-						    ioasid_t pasid,
-						    unsigned int type)
-{
-	/* Caller must be a probed driver on dev */
-	struct iommu_group *group = dev->iommu_group;
-	struct iommu_attach_handle *handle;
-	struct iommu_domain *domain = NULL;
-
-	if (!group)
-		return NULL;
-
-	xa_lock(&group->pasid_array);
-	handle = xa_load(&group->pasid_array, pasid);
-	if (handle)
-		domain = handle->domain;
-
-	if (type && domain && domain->type != type)
-		domain = NULL;
-	xa_unlock(&group->pasid_array);
-
-	return domain;
-}
-EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_pasid);
-
 ioasid_t iommu_alloc_global_pasid(struct device *dev)
 {
 	int ret;
-- 
2.34.1

