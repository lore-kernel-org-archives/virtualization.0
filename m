Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894333997
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107010; cv=none; b=i3ZdFij3qr2wBJuW76NYpnKtXhhcutTKpjdkF2y0SDLNos9Nzpsw/vaRkN7wSW66OgimxltMdjHU1y/Ookup/6ErV4Aa3fA+T4t8M+kY4JKNlIdQGvFOb8D8vpGkcbKdkhnq3g51RnoupnP0SDs7NsifAcbMpq1KVPc1TcrvlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107010; c=relaxed/simple;
	bh=b7TJ0f955tOKCT0EcM00BUcCZoKgdNaMTCXKLFWx9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQo4hJG1ffOO5VCCL21IJRLmoIQsonCZkF0UxrlF2MCsTqISg6AoBRUXs3lAzMzoPih0QN0foyldaV2TceW39ZJj/BBfWpnu+otDYR5VJjIXNIjwRSit6pyPKwdbOpPUCrE5Tsp+LGkDnM+mC7rw85/wHicnzcCsLkquOf961O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4MhoAj5; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4MhoAj5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6B0640B72
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4SjWpoHrwJvu for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Apr 2024 01:16:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B4B70402DC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4B70402DC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e4MhoAj5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4B70402DC
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712107008; x=1743643008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7TJ0f955tOKCT0EcM00BUcCZoKgdNaMTCXKLFWx9x4=;
  b=e4MhoAj59P0UIGHlKZ8siMZPlmGFEEEBxEQd4SxrDHCPZnxTCv52XQR9
   RwK4vMtlR02YQCqFQh66B+X1u0tXZZDu958vjTtKvXrIzBiqhDDxgfpsh
   FyY2wysnLgTUSWQoDm9ZQsbVjVWPm+MwkBHgSqcoJDfgjwHest/jPStqp
   DShMedk8ogPxgurpKApwa1RGpnZYBX366KUFI/8RvdkWC6QyDnkPsQbuO
   uNWdFEU5t5LsTuD+HbMECXSrSdXUo03JP1FEBLMtA7+K7taWyC+B9dZoQ
   V7lUqTl7oahilpmTpe4u/IK2H8XibwzhwGmmv42WBCzbXXQ8tge8wwNd+
   g==;
X-CSE-ConnectionGUID: ByiovO2CRz2o7xo1MUnTwQ==
X-CSE-MsgGUID: J7HGthK2TB+ypKmAd57M7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439811"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:47 -0700
X-CSE-ConnectionGUID: iQL+MAlSQbCguAZ9/PzDpA==
X-CSE-MsgGUID: ikxUkevlRwaGnGq73QaT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953316"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:45 -0700
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
Subject: [PATCH v4 7/9] iommufd: Associate fault object with iommufd_hw_pgtable
Date: Wed,  3 Apr 2024 09:15:17 +0800
Message-Id: <20240403011519.78512-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403011519.78512-1-baolu.lu@linux.intel.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a user iommufd_hw_pagetable, the user space is allowed to
associate a fault object with the hw_pagetable by specifying the fault
object ID in the page table allocation data and setting the
IOMMU_HWPT_FAULT_ID_VALID flag bit.

On a successful return of hwpt allocation, the user can retrieve and
respond to page faults by reading and writing the file interface of the
fault object.

Once a fault object has been associated with a hwpt, the hwpt is
iopf-capable, indicated by fault_capable set to true. Attaching,
detaching, or replacing an iopf-capable hwpt to an RID or PASID will
differ from those that are not iopf-capable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 10 +++++++
 include/uapi/linux/iommufd.h            |  8 ++++++
 drivers/iommu/iommufd/fault.c           | 20 ++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    | 36 +++++++++++++++++++------
 4 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8dad1150eaf0..0c2f5fee4130 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -293,6 +293,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct iommufd_fault *fault;
 	bool fault_capable;
 };
 
@@ -456,8 +457,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline struct iommufd_fault *
+iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_FAULT),
+			    struct iommufd_fault, obj);
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
+int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1819b28e9e6b..3d566c1ffcc6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
  *                                the parent HWPT in a nesting configuration.
  * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
  *                                   enforced on device attachment
+ * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
+ *                             valid.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
 };
 
 /**
@@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
  * @data_type: One of enum iommu_hwpt_data_type
  * @data_len: Length of the type specific data
  * @data_uptr: User pointer to the type specific data
+ * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
+ *            IOMMU_HWPT_FAULT_ID_VALID is set.
+ * @__reserved2: Padding to 64-bit alignment. Must be 0.
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
@@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
 	__u32 data_type;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
+	__u32 fault_id;
+	__u32 __reserved2;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index f16f15e7edd4..ffe948b6a5b5 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -350,3 +350,23 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_fault *fault;
+
+	if (!group->attach_handle)
+		return -EINVAL;
+
+	hwpt = group->attach_handle->domain->fault_data;
+	fault = hwpt->fault;
+
+	mutex_lock(&fault->mutex);
+	list_add_tail(&group->node, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+
+	return 0;
+}
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..95ea943f5be5 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,15 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
+	if (hwpt->fault)
+		iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+}
+
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hwpt_paging *hwpt_paging =
@@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 					 hwpt_paging->common.domain);
 	}
 
-	if (hwpt_paging->common.domain)
-		iommu_domain_free(hwpt_paging->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_paging->common);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
@@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 	struct iommufd_hwpt_nested *hwpt_nested =
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
-	if (hwpt_nested->common.domain)
-		iommu_domain_free(hwpt_nested->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_nested->common);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags || !user_data->len || !ops->domain_alloc_user)
+	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	    !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
@@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
-	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
 					      parent->common.domain, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
@@ -308,6 +314,20 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
+		struct iommufd_fault *fault;
+
+		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		if (IS_ERR(fault)) {
+			rc = PTR_ERR(fault);
+			goto out_hwpt;
+		}
+		hwpt->fault = fault;
+		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->fault_data = hwpt;
+		hwpt->fault_capable = true;
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-- 
2.34.1

