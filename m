Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6E17E473
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518479; cv=none; b=PkBWkXRa8bzAcDLXmZnkSZk7gNERp+SXb4G1XIMc/7E7SYucJGgBravxZ6JwMYbSuoBlQLRDL6HJy+KnSxZRZ8a3XsYs47Ea+9ShCtGi9Rh868b90CRN5TrD34VqZ8fs2gVFiGXwaUY7xhn97g5IifxsHl5RXhL5pRtBEG0R1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518479; c=relaxed/simple;
	bh=VGJCqhpGaVc2ovuJGhYcg89xBw7yZJAn0/UF+SLw0yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvSH6jsuHTt2kQog7eJjhU6UQo/x53UWudwU+Q3wLSO/q231FdOL8xizrLhLSm/fImfhRJwlNOK9rTB58JdfeAinxBep8KPv8Oasu2TkUpTbu/b+4cKXM3RAxZWBj2JdP3BmXhu8hA60F3+oeuEwxL1lLkPSXA5dIcEqR9kQU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec7E8MMd; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec7E8MMd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95EC481BA8
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRdRmzi5etLP for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jun 2024 06:14:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B12C781A46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B12C781A46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ec7E8MMd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B12C781A46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518476; x=1750054476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VGJCqhpGaVc2ovuJGhYcg89xBw7yZJAn0/UF+SLw0yQ=;
  b=Ec7E8MMdeRH+2haVtg+orAMu0pq1uO+VTvS3kjjKAJWE/DmPx/esapRX
   hT2DZtDz/X4I6u6M1GOFwBBY8oVOyLhEFbG3gelKKNWeDD2cdtprIBG1r
   Z9qV0Ynlj/4ptrt0QAiYsDJZD1dOGh2LWTFp3/2oNLrG3qms5QBQtG5A0
   IeXDvZl7Sh2CjHPoi0eZBuJw6Cb8E11xd54UI8tkzAMNsxHVs1b7Calvu
   eo1QiIu8kb6oxMR6dcOm97Km9GlhxTbXhl6TpjfvUxf+c8qABtnkkhDnr
   dg+8Mt9tVY/eJjdqpCyZNaMhUXxDMitea5aym0jR8JNLDG2+m+7ZgZQ09
   w==;
X-CSE-ConnectionGUID: Ys+p021MTEWKMmZuQ8WI/A==
X-CSE-MsgGUID: avC+tXN5Sn+eyYzrTHbX0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290032"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290032"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:35 -0700
X-CSE-ConnectionGUID: ASXlQxRBQbmLcWMi249rNQ==
X-CSE-MsgGUID: H1wrsArPSuy+dXrbf1AIiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748163"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:32 -0700
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
Subject: [PATCH v7 04/10] iommu: Extend domain attach group with handle support
Date: Sun, 16 Jun 2024 14:11:49 +0800
Message-Id: <20240616061155.169343-5-baolu.lu@linux.intel.com>
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
 drivers/iommu/iommu-priv.h |   8 +++
 drivers/iommu/iommu.c      | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

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
index 5a7e874abb36..708103263522 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3478,3 +3478,105 @@ iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int
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
+	if (handle)
+		handle->domain = domain;
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

