Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFC181B99
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518489; cv=none; b=YZGBxEF2U4JLgqiC87gRHyLoIcBUEfPlyn1p0cMIhvdMAv8YMSZ/T4VdQqMfmKLT2PTJoEY4IbwweiVYVMy/vQ6kTsXZBQIl4yy+ukpQ/lDr6DWaoNDHkxnCAOG+sApSBob0ElmAfO1F7GzlgCJb+FMsBeydVkzoU2oEN7Za6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518489; c=relaxed/simple;
	bh=9b3M3MA5gdEVgznGAvwgNvwxuj/7B6/TUJxXVMNH9hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=os2YPx/6n+X6q9HZ5CnnzXGM19J7QzsWvAS2dS9tRk8RrwtQtbfwrU1UCM15UAl0Nsqhkt+TFRQMDXciuh5uaw44K7mUxiIOuflh0Aui1ALhptyCaMnV+qmOQP6QdRZ0q3RKvDb49LPYYalV81o9/yMKn+KKx5mxzPAdB+2I8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPFRGza8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPFRGza8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C6E81BA8
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGln7VMQe4e7 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jun 2024 06:14:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 081DE81A46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 081DE81A46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YPFRGza8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 081DE81A46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518486; x=1750054486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9b3M3MA5gdEVgznGAvwgNvwxuj/7B6/TUJxXVMNH9hA=;
  b=YPFRGza8IXI/60kYAyOBidPjPfszICWlkYtbLsKB/3Fz1COsqaNf6FkF
   NCbfaiuFyEkPNhaFXKtyycMBW7nPFduMJTmSzBDgbBnVyOX7Mne2fgPsb
   2Y8PtZ+6DEH6xilxgGZHcIoUXBJVTtaISPLY+5dKfb7qRMrG9g0pJAyQc
   DuVmKiLSpqitL2JbHPfcS8QyPbT1Mrg6bti19sgXmXmNNelUHvixjc/+5
   1VGFEPPxTkQ+XkkY+WTlksCnmZBjIcbB2dnxtMNdd4JAZrkxajbmzDU83
   jSWan5I9OElXKRnltG5tfOjGxrWtAMAMZ8KPZLJxkCjU70vjkTe69sk48
   w==;
X-CSE-ConnectionGUID: 0G9QqJSMT5K1w+A1M0ksqA==
X-CSE-MsgGUID: /5bMEjgbQvm08Z4MXUSLxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290076"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:45 -0700
X-CSE-ConnectionGUID: /90wdJUoTgiKTRE07sAaXg==
X-CSE-MsgGUID: 6yJ1Z6NtRUqipDZ7+JCt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748195"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:42 -0700
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
Subject: [PATCH v7 07/10] iommufd: Fault-capable hwpt attach/detach/replace
Date: Sun, 16 Jun 2024 14:11:52 +0800
Message-Id: <20240616061155.169343-8-baolu.lu@linux.intel.com>
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
 drivers/iommu/iommufd/iommufd_private.h |  41 +++++
 drivers/iommu/iommufd/device.c          |   7 +-
 drivers/iommu/iommufd/fault.c           | 190 ++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c8a4519f1405..aa4c26c87cb9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -11,6 +11,7 @@
 #include <linux/iommu.h>
 #include <linux/iova_bitmap.h>
 #include <uapi/linux/iommufd.h>
+#include "../iommu-priv.h"
 
 struct iommu_domain;
 struct iommu_group;
@@ -293,6 +294,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct iommufd_fault *fault;
 };
 
 struct iommufd_hwpt_paging {
@@ -396,6 +398,9 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* protect iopf_enabled counter */
+	struct mutex iopf_lock;
+	unsigned int iopf_enabled;
 };
 
 static inline struct iommufd_device *
@@ -456,6 +461,42 @@ struct iommufd_attach_handle {
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
+static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
+					     struct iommufd_device *idev)
+{
+	if (hwpt->fault)
+		return iommufd_fault_domain_attach_dev(hwpt, idev);
+
+	return iommu_attach_group(hwpt->domain, idev->igroup->group);
+}
+
+static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
+					      struct iommufd_device *idev)
+{
+	if (hwpt->fault)
+		iommufd_fault_domain_detach_dev(hwpt, idev);
+
+	iommu_detach_group(hwpt->domain, idev->igroup->group);
+}
+
+static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+					      struct iommufd_hw_pagetable *hwpt,
+					      struct iommufd_hw_pagetable *old)
+{
+	if (old->fault || hwpt->fault)
+		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
+
+	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+}
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..9a7ec5997c61 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -215,6 +215,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	mutex_init(&idev->iopf_lock);
 
 	/*
 	 * If the caller fails after this success it must call
@@ -376,7 +377,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+		rc = iommufd_hwpt_attach_device(hwpt, idev);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -402,7 +403,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		iommufd_hwpt_detach_device(hwpt, idev);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -497,7 +498,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 68ff94671d48..4934ae572638 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/iommufd.h>
+#include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
@@ -15,6 +16,195 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+{
+	struct device *dev = idev->dev;
+	int ret;
+
+	/*
+	 * Once we turn on PCI/PRI support for VF, the response failure code
+	 * should not be forwarded to the hardware due to PRI being a shared
+	 * resource between PF and VFs. There is no coordination for this
+	 * shared capability. This waits for a vPRI reset to recover.
+	 */
+	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
+		return -EINVAL;
+
+	mutex_lock(&idev->iopf_lock);
+	/* Device iopf has already been on. */
+	if (++idev->iopf_enabled > 1) {
+		mutex_unlock(&idev->iopf_lock);
+		return 0;
+	}
+
+	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		--idev->iopf_enabled;
+	mutex_unlock(&idev->iopf_lock);
+
+	return ret;
+}
+
+static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+{
+	mutex_lock(&idev->iopf_lock);
+	if (!WARN_ON(idev->iopf_enabled == 0)) {
+		if (--idev->iopf_enabled == 0)
+			iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	}
+	mutex_unlock(&idev->iopf_lock);
+}
+
+static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->idev = idev;
+	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					&handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev)
+{
+	int ret;
+
+	if (!hwpt->fault)
+		return -EINVAL;
+
+	ret = iommufd_fault_iopf_enable(idev);
+	if (ret)
+		return ret;
+
+	ret = __fault_domain_attach_dev(hwpt, idev);
+	if (ret)
+		iommufd_fault_iopf_disable(idev);
+
+	return ret;
+}
+
+static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
+					 struct iommufd_attach_handle *handle)
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
+		if (group->attach_handle != &handle->handle)
+			continue;
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+
+	xa_for_each(&fault->response, index, group) {
+		if (group->attach_handle != &handle->handle)
+			continue;
+		xa_erase(&fault->response, index);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	mutex_unlock(&fault->mutex);
+}
+
+static struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (!handle)
+		return NULL;
+
+	return to_iommufd_handle(handle);
+}
+
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	iommufd_auto_response_faults(hwpt, handle);
+	iommufd_fault_iopf_disable(idev);
+	kfree(handle);
+}
+
+static int __fault_domain_replace_dev(struct iommufd_device *idev,
+				      struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *handle, *curr = NULL;
+	int ret;
+
+	if (old->fault)
+		curr = iommufd_device_get_attach_handle(idev);
+
+	if (hwpt->fault) {
+		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+		if (!handle)
+			return -ENOMEM;
+
+		handle->handle.domain = hwpt->domain;
+		handle->idev = idev;
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, &handle->handle);
+	} else {
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
+	}
+
+	if (!ret && curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+
+	return ret;
+}
+
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old)
+{
+	bool iopf_off = !hwpt->fault && old->fault;
+	bool iopf_on = hwpt->fault && !old->fault;
+	int ret;
+
+	if (iopf_on) {
+		ret = iommufd_fault_iopf_enable(idev);
+		if (ret)
+			return ret;
+	}
+
+	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	if (ret) {
+		if (iopf_on)
+			iommufd_fault_iopf_disable(idev);
+		return ret;
+	}
+
+	if (iopf_off)
+		iommufd_fault_iopf_disable(idev);
+
+	return 0;
+}
+
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
-- 
2.34.1

