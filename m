Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842416D30F
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518476; cv=none; b=BdilYuGaQ16sqDIo2OUz78Z2Ff9qvnXU04mPmmbQeZG4Mh1rLlEG+SIP8VyZkmlah6wRwwNEt1eAg60f/VDUoJHAUBIv/SjYwGpHpls4S2W0q4Ks3vAOg+jS/cxJhq4z/zocgSxyDylXNJzDsDXcnHklqrAaGWc629GiiJ9aJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518476; c=relaxed/simple;
	bh=X7RyyU+ih4QN/omYZPR7OU6KfWvUgnFy57rHDVUoDZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BseuIPtD025pst2G738XL0+5T6NfvufN4Hg4Ad2LGG0giJHZ/hnlceppmng34NfqkA3emVvQf98bbsLLlagDtYL6hEfPjHaFGuYDYu384suX6QrFie+UobntpfpUnNb9HKOO/COmb8nDVy7pUXHj9rzcPUYYj8acqnlI83jso88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XygrKdWg; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XygrKdWg"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89BD481D46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9bc_iiLYV0P for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jun 2024 06:14:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8575A81A46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8575A81A46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XygrKdWg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8575A81A46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518472; x=1750054472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7RyyU+ih4QN/omYZPR7OU6KfWvUgnFy57rHDVUoDZ8=;
  b=XygrKdWgEgUdvm5aCkarL5/R0uY4NVZzbYuLjVuirg762gwg/kTdQTlJ
   mf6XZm8/65EWizop+Lz0h+WYivRp3HwxhOBU5QxkcHvajBmje+tidwste
   ttuGiVw2z7VL+z16ohKwrGuF0l+MveXo3QDCEK6Zw8bTFZnoOxNbLw8UT
   Pga4mwLMa1KLTNkQxk5/XofApGEhCxKXHMMwpD132k0DwBfJWU3UxT5fN
   RoxUisat+CmCXtheQZd1fvjfA0aPi4a0Y9jHYy7G+yLdqkQuUn3KjqKI3
   qrikY84syqmgZxpdkQ1BP+TV462sW4rnLcEEgClP35AXY7jUHNk9sfWYp
   g==;
X-CSE-ConnectionGUID: /BX6Xs7WSsG2uefLfgPc2w==
X-CSE-MsgGUID: x2PidQnnTEOHNkRhtPvfhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290018"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290018"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:32 -0700
X-CSE-ConnectionGUID: GS73/zRMQKyhca9BPHLz3Q==
X-CSE-MsgGUID: epOfKD0uQ6+Vt0zOZgvGZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748156"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:29 -0700
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
Subject: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
Date: Sun, 16 Jun 2024 14:11:48 +0800
Message-Id: <20240616061155.169343-4-baolu.lu@linux.intel.com>
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
 include/linux/iommu.h      | 17 ++++-------
 drivers/iommu/io-pgfault.c | 61 +++++++++++++++++++++-----------------
 drivers/iommu/iommu-sva.c  |  3 +-
 drivers/iommu/iommu.c      | 39 ------------------------
 4 files changed, 42 insertions(+), 78 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87ebcc29020e..910aec80886e 100644
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
@@ -547,6 +547,10 @@ static inline int __iommu_copy_struct_from_user_array(
  * @default_domain: If not NULL this will always be set as the default domain.
  *                  This should be an IDENTITY/BLOCKED/PLATFORM domain.
  *                  Do not use in new drivers.
+ * @user_pasid_table: IOMMU driver supports user-managed PASID table. There is
+ *                    no user domain for each PASID and the I/O page faults are
+ *                    forwarded through the user domain attached to the device
+ *                    RID.
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
@@ -590,6 +594,7 @@ struct iommu_ops {
 	struct iommu_domain *blocked_domain;
 	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
+	u8 user_pasid_table:1;
 };
 
 /**
@@ -1064,9 +1069,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct iommu_attach_handle *handle);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
-struct iommu_domain *
-iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid,
-			       unsigned int type);
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
 void iommu_free_global_pasid(ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
@@ -1408,13 +1410,6 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
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
index 06d78fcc79fd..7c9011992d3f 100644
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
@@ -206,20 +182,51 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain)
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
+							       fault->prm.pasid,
+							       0);
+		if (IS_ERR(group->attach_handle)) {
+			const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+			if (!ops->user_pasid_table)
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
index 9b7f62517419..69cde094440e 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -272,7 +272,8 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 		if (status != IOMMU_PAGE_RESP_SUCCESS)
 			break;
 
-		status = iommu_sva_handle_mm(&iopf->fault, group->domain->mm);
+		status = iommu_sva_handle_mm(&iopf->fault,
+					     group->attach_handle->domain->mm);
 	}
 
 	iopf_group_response(group, status);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7890bd21dff6..5a7e874abb36 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3421,45 +3421,6 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
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

