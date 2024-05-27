Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D4200A9
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782881; cv=none; b=FE0mOy6dyzadX6Yepk0Wi09Za+1yjXlay5hyjVe3z00z+ti27akGMOSqvccbjtscnOB3lsibqGQbzG0Bn3vmdNZAWtj082TcccaS0AbGjse5rogL72IItexmq1ZEAqa5Gvxr5eALT9fSJxyHUtdywuKk2kTUl9HJP3hhRQpE2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782881; c=relaxed/simple;
	bh=zqFfjljFQ7bL1eow/Jlw1FxofoCmHNFJrcdwJL8lKvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhO5Q/cTX5x+Zul0/EHOhe6zz0Au0yk1tEFfSeBQhdYoyivlKaoxc8eu+OWrSj7l+0KUX6RQwLbx8mp/htnuahi72Fl+gsFuLo+Y8hNQlncFDYxcqNWn6zzaoyaYVIDE3Pulpk5YbTzWcEB4/V2X7nGewRDhtbdCNwimorJZNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIu0+57U; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIu0+57U"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D49A8606DF
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mOx1bJf0kCK for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 04:07:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EAC8A605C4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAC8A605C4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jIu0+57U
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAC8A605C4
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782877; x=1748318877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqFfjljFQ7bL1eow/Jlw1FxofoCmHNFJrcdwJL8lKvE=;
  b=jIu0+57UdyhZqBUmUU3hCcy9itSBA0TEEmZ9JSQFKvQrXf3QlwQ7I9/1
   b65Mxt8H9J/c/CILornBuB+pPwEIPai59yEU5OujitOP9z90onHOnqzR5
   YgQcmqEfByQ2KjLCvNnPzI5FfxozriV+jyTbQzHNoGUnj80hDWCatNBMl
   pfAKEUv5IxjeaeuHLiOm4+RupqcfHfMGRY8KtuDK7U6aSGqkNcrmWdoLD
   B0UJ0QXRNSD07uwlaHC3Bj1JCaJP7m+kNmZR1v+5ad73bhw8lrOxuxQWR
   Xiu2UU1toMN/DWxix36+N0p1qC4tJpdubCrPwok1u2cDDreS9L/DuqW6a
   g==;
X-CSE-ConnectionGUID: RR2PumocR0eRf6SOJq+3GQ==
X-CSE-MsgGUID: dFwFCzXTRoaO6imigT+6bQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022758"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022758"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:40 -0700
X-CSE-ConnectionGUID: xjVXVygwQPatCCxROdW6hw==
X-CSE-MsgGUID: Bauamti5QJeECuzxBFWsEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399914"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:36 -0700
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
Subject: [PATCH v6 04/10] iommu: Extend domain attach group with handle support
Date: Mon, 27 May 2024 12:05:11 +0800
Message-Id: <20240527040517.38561-5-baolu.lu@linux.intel.com>
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

Unlike the SVA case where each PASID of a device has an SVA domain
attached to it, the I/O page faults are handled by the fault handler
of the SVA domain. The I/O page faults for a user page table might
be handled by the domain attached to RID or the domain attached to
the PASID, depending on whether the PASID table is managed by user
space or kernel. As a result, there is a need for the domain attach
group interfaces to have attach handle support. The attach handle
will be forwarded to the fault handler of the user domain.

Add some variants of the domain attaching group interfaces so that they
could support the attach handle and export them for use in IOMMUFD.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu-priv.h |  8 +++
 drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index f1536a5ebb0d..c37801c32f33 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -31,4 +31,12 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
+int iommu_attach_group_handle(struct iommu_domain *domain,
+			      struct iommu_group *group,
+			      struct iommu_attach_handle *handle);
+void iommu_detach_group_handle(struct iommu_domain *domain,
+			       struct iommu_group *group);
+int iommu_replace_group_handle(struct iommu_group *group,
+			       struct iommu_domain *new_domain,
+			       struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c506185a2fad..78e29fc97236 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3475,3 +3475,102 @@ iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int
 	return handle;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ * @handle: attach handle
+ *
+ * Returns 0 on success and error code on failure.
+ *
+ * This is a variant of iommu_attach_group(). It allows the caller to provide
+ * an attach handle and use it when the domain is attached. This is currently
+ * used by IOMMUFD to deliver the I/O page faults.
+ */
+int iommu_attach_group_handle(struct iommu_domain *domain,
+			      struct iommu_group *group,
+			      struct iommu_attach_handle *handle)
+{
+	int ret;
+
+	mutex_lock(&group->mutex);
+	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	if (ret)
+		goto err_unlock;
+
+	ret = __iommu_attach_group(domain, group);
+	if (ret)
+		goto err_erase;
+	mutex_unlock(&group->mutex);
+
+	return 0;
+err_erase:
+	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+err_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_group_handle, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_detach_group_handle - Detach an IOMMU domain from an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ *
+ * Detach the specified IOMMU domain from the specified IOMMU group.
+ * It must be used in conjunction with iommu_attach_group_handle().
+ */
+void iommu_detach_group_handle(struct iommu_domain *domain,
+			       struct iommu_group *group)
+{
+	mutex_lock(&group->mutex);
+	__iommu_group_set_core_domain(group);
+	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_replace_group_handle - replace the domain that a group is attached to
+ * @group: IOMMU group that will be attached to the new domain
+ * @new_domain: new IOMMU domain to replace with
+ * @handle: attach handle
+ *
+ * This is a variant of iommu_group_replace_domain(). It allows the caller to
+ * provide an attach handle for the new domain and use it when the domain is
+ * attached.
+ */
+int iommu_replace_group_handle(struct iommu_group *group,
+			       struct iommu_domain *new_domain,
+			       struct iommu_attach_handle *handle)
+{
+	struct iommu_domain *old_domain = group->domain;
+	void *curr;
+	int ret;
+
+	if (!new_domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		goto err_unlock;
+	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	if (handle) {
+		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+		if (xa_err(curr)) {
+			ret = xa_err(curr);
+			goto err_restore;
+		}
+	}
+	mutex_unlock(&group->mutex);
+
+	return 0;
+err_restore:
+	__iommu_group_set_domain(group, old_domain);
+err_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, IOMMUFD_INTERNAL);
-- 
2.34.1

