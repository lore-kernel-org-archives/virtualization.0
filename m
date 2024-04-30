Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D46176FB2
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489154; cv=none; b=EM7as6UrCF3TMyLH/i2xF9LaHnoxDZAJ0aUdSZ9uxX2mN92kf2xlsVb3NOoJ1TJs2rToZxB0l+2TuF+amHb9o4H+BSi9KuNrGjmyHQLiXJMI0ExA0cWUd6wbCsKle5JwSgL1AteZX5w7JMlwLn9XkfMKOcBOKBfNdojDb6zozp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489154; c=relaxed/simple;
	bh=RbRitu0aNliYqOdOFIez38o3G2ZOc9u3LX3xSh1/REk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkSiXF4GBTmg6cqZxEN0HlcVNLtncwoKw8+xtzQOb8/BkWx3UpaHEKMO6IsLHeOhmElNpkvwbzQCjpFf96hlh4x95Bhtqd8nlBUdCmoXM1vsu0P8T8OEKaBCCMdc33SFWNgdWmeEXUsFscrgqkWp1U47trNV8Cdpn6b+dXo0MRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae7HQGVL; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae7HQGVL"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA91180C38
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1JOM3lZD-59 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 14:59:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8623280E3B
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8623280E3B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ae7HQGVL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8623280E3B
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489152; x=1746025152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RbRitu0aNliYqOdOFIez38o3G2ZOc9u3LX3xSh1/REk=;
  b=Ae7HQGVLZjvjwzccAS1gSphpXM6f6rSuize/CRvg4ath1x9z/9wD46oS
   kJRtP1JYIoxMjIFAYyIszuY4bTZWSDwhbOBvbdlJw2fMBHlj2zoR/+WOB
   0R6GRQRgS33vCTopcEK3uY7LV8fbJuJmUC8qQVHEqEysIgdt9VCQFrSYC
   W+IrAduGufvQ9EpdbD71h952Q/rTwTbimlUr8vKHMds7c/wlc1uplhyxv
   HxzVcs2ciXbkIHMkc2/dHMg/Jeoqb15GgKqSuUG9uHDnkAcq1mL5d4b60
   1BSwkWWdNUTQS+Cqo0sUJ4Nx5FT0M1/dHhoapxPFOWWI5AYvIsKggT114
   g==;
X-CSE-ConnectionGUID: mE3QAf9vTKeNf9gMLmcwTA==
X-CSE-MsgGUID: 0+ebE1JfQCa+7l4vzUhVrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059918"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:59:11 -0700
X-CSE-ConnectionGUID: TJv/Tz6xR0qroJPOE1VCyw==
X-CSE-MsgGUID: l12weAd+RBOqJLRpcxy+aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282223"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:59:08 -0700
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
Subject: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Date: Tue, 30 Apr 2024 22:57:07 +0800
Message-Id: <20240430145710.68112-7-baolu.lu@linux.intel.com>
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

Add iopf-capable hw page table attach/detach/replace helpers. The pointer
to iommufd_device is stored in the domain attachment handle, so that it
can be echo'ed back in the iopf_group.

The iopf-capable hw page tables can only be attached to devices that
support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
the device. Similarly, after the last iopf-capable hwpt is detached from
the device, the IOPF feature is disabled on the device.

The current implementation allows a replacement between iopf-capable and
non-iopf-capable hw page tables. This matches the nested translation use
case, where a parent domain is attached by default and can then be
replaced with a nested user domain with iopf support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  10 ++
 drivers/iommu/iommufd/device.c          |  15 ++-
 drivers/iommu/iommufd/fault.c           | 118 ++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index acb89bbf9f8e..18c8d7d38dcd 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -293,6 +293,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct iommufd_fault *fault;
 };
 
 struct iommufd_hwpt_paging {
@@ -396,6 +397,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool iopf_enabled;
 	/* outstanding faults awaiting response indexed by fault group id */
 	struct xarray faults;
 };
@@ -450,6 +452,14 @@ struct iommufd_fault {
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
 
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev);
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 22e22969363a..2bee3f399ec7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -377,7 +377,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault)
+			rc = iommufd_fault_domain_attach_dev(hwpt, idev);
+		else
+			rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -403,7 +406,10 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault)
+			iommufd_fault_domain_detach_dev(hwpt, idev);
+		else
+			iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -498,7 +504,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (old_hwpt->fault || hwpt->fault)
+		rc = iommufd_fault_domain_replace_dev(idev, hwpt, old_hwpt);
+	else
+		rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 13125c0feecb..6357229bf3b4 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -15,6 +15,124 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+{
+	int ret;
+
+	if (idev->iopf_enabled)
+		return 0;
+
+	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	idev->iopf_enabled = true;
+
+	return 0;
+}
+
+static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+{
+	if (!idev->iopf_enabled)
+		return;
+
+	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	idev->iopf_enabled = false;
+}
+
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+	int ret;
+
+	if (!hwpt->fault)
+		return -EINVAL;
+
+	ret = iommufd_fault_iopf_enable(idev);
+	if (ret)
+		return ret;
+
+	ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
+	if (ret) {
+		iommufd_fault_iopf_disable(idev);
+		return ret;
+	}
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	handle->idev = idev;
+
+	return 0;
+}
+
+static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
+					 struct iommufd_device *idev)
+{
+	struct iommufd_fault *fault = hwpt->fault;
+	struct iopf_group *group, *next;
+	unsigned long index;
+
+	if (!fault)
+		return;
+
+	mutex_lock(&fault->mutex);
+	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+		if (group->domain != hwpt->domain ||
+		    group->fault_param->dev != idev->dev)
+			continue;
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+
+	xa_for_each(&idev->faults, index, group) {
+		if (group->domain != hwpt->domain)
+			continue;
+		xa_erase(&idev->faults, index);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	mutex_unlock(&fault->mutex);
+}
+
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	iommu_detach_group(hwpt->domain, idev->igroup->group);
+	iommufd_fault_iopf_disable(idev);
+	iommufd_auto_response_faults(hwpt, idev);
+}
+
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old)
+{
+	struct iommu_attach_handle *handle;
+	int ret;
+
+	if (hwpt->fault)
+		ret = iommufd_fault_iopf_enable(idev);
+	else
+		iommufd_fault_iopf_disable(idev);
+
+	ret = iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	if (ret)
+		goto out_cleanup;
+
+	iommufd_auto_response_faults(old, idev);
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	handle->idev = idev;
+
+	return 0;
+out_cleanup:
+	if (old->fault)
+		ret = iommufd_fault_iopf_enable(idev);
+	else
+		iommufd_fault_iopf_disable(idev);
+
+	return ret;
+}
+
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
-- 
2.34.1

