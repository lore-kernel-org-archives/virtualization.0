Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215114A612
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902272; cv=none; b=KK67Q0kFutXuBZQZLb3Wb6OQQd3ghBZby0QcT5LkPZTqA4/YWM5J+XWdKnoOcFXGVeVnpEfytJZkxxb//Sr9pfUVkWkO8odBOmQ/xdi6KHql++Nm2GU4bCT5pQzQTlp0SRHTM/6i88AYoswggYA1empN5ix9tTbJ7mjDZ/5Y7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902272; c=relaxed/simple;
	bh=fpDco05MC2sXG8Odatxtzhwad+XNQaPRHu/aJgHwPh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NL1EvI/fM3wObOSJW7KRs88pUGlZCiJJbIWCZBZgJDiY7zeaodcWUeG70Uj96m4+EnTFWfcHoQ/pNS7Rmw33801z2AEMh0nqWztfGmxKV3QCvJ8Yn2NjKs8zeI76I/hBzmHfa8BxdaOhdHmSy4WiVUoNF00q519JO4v/AeyFe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECvKGeYP; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECvKGeYP"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9ACA60804
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eS5aqJbYRDyi for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Jul 2024 06:37:50 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E1356607D2
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1356607D2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ECvKGeYP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1356607D2
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902270; x=1751438270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpDco05MC2sXG8Odatxtzhwad+XNQaPRHu/aJgHwPh8=;
  b=ECvKGeYPDwYHQHQ8KtH74GoZ0FX/HwD2VJveUudfZq/bv6n2Z4FVw55I
   MqOv4M2yYp7EBAbRqq7hmnU7ow/FEIfLJD79a0uVVyx0mnmBVMBhmb+ca
   r5us65L7NV+F2THsHEuBldkU2D1GZOHW1dbat/kVGbesY5CSqT2hRAYGJ
   O5QPsNnNm6naEPfh6cUyHW2/JsmGdPHUPa7G/bP+xgY2+ow8+ixdyfohd
   HfJeDpyOqZAIcVKqAIYPgYBQb87TXI6H68XU2jEB0Tbb8CSqA5SVrGFBo
   MRAv90hRPJoecFZVkhinAqVBPj+6Dziiugcj0cVBqz11x/MJ+0JUFuHns
   A==;
X-CSE-ConnectionGUID: n2UTCdjvT2ONRC01BuLwSA==
X-CSE-MsgGUID: nwnaW3tdSkuygg4I8h4bjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455626"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455626"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:37:50 -0700
X-CSE-ConnectionGUID: fO+8mGL9Ti+fCMroa9g/Gw==
X-CSE-MsgGUID: jK4lQfQnRtWH9AcVNkNhXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137210"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:37:46 -0700
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
Subject: [PATCH v8 05/10] iommufd: Add fault and response message definitions
Date: Tue,  2 Jul 2024 14:34:39 +0800
Message-Id: <20240702063444.105814-6-baolu.lu@linux.intel.com>
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

iommu_hwpt_pgfaults represent fault messages that the userspace can
retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
iommu_hwpt_pgfault.

An iommu_hwpt_page_response is a response message that the userspace
should send to the kernel after finishing handling a group of fault
messages. The @dev_id, @pasid, and @grpid fields in the message
identify an outstanding iopf group for a device. The @cookie field,
which matches the cookie field of the last fault in the group, will
be used by the kernel to look up the pending message.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/uapi/linux/iommufd.h | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..4d89ed97b533 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -692,4 +692,87 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
+ *                                   valid.
+ * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
+ */
+enum iommu_hwpt_pgfault_flags {
+	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
+	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
+};
+
+/**
+ * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_PERM_READ: request for read permission
+ * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
+ * @IOMMU_PGFAULT_PERM_EXEC: (PCIE 10.4.1) request with a PASID that has the
+ *                           Execute Requested bit set in PASID TLP Prefix.
+ * @IOMMU_PGFAULT_PERM_PRIV: (PCIE 10.4.1) request with a PASID that has the
+ *                           Privileged Mode Requested bit set in PASID TLP
+ *                           Prefix.
+ */
+enum iommu_hwpt_pgfault_perm {
+	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
+	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
+	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
+	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
+};
+
+/**
+ * struct iommu_hwpt_pgfault - iommu page fault data
+ * @flags: Combination of enum iommu_hwpt_pgfault_flags
+ * @dev_id: id of the originated device
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @addr: Fault address
+ * @length: a hint of how much data the requestor is expecting to fetch. For
+ *          example, if the PRI initiator knows it is going to do a 10MB
+ *          transfer, it could fill in 10MB and the OS could pre-fault in
+ *          10MB of IOVA. It's default to 0 if there's no such hint.
+ * @cookie: kernel-managed cookie identifying a group of fault messages. The
+ *          cookie number encoded in the last page fault of the group should
+ *          be echoed back in the response message.
+ */
+struct iommu_hwpt_pgfault {
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 perm;
+	__u64 addr;
+	__u32 length;
+	__u32 cookie;
+};
+
+/**
+ * enum iommufd_page_response_code - Return status of fault handlers
+ * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *                             populated, retry the access. This is the
+ *                             "Success" defined in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *                             access. This is the "Invalid Request" in PCI
+ *                             10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
+ *                             this device if possible. This is the "Response
+ *                             Failure" in PCI 10.4.2.1.
+ */
+enum iommufd_page_response_code {
+	IOMMUFD_PAGE_RESP_SUCCESS = 0,
+	IOMMUFD_PAGE_RESP_INVALID,
+	IOMMUFD_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @cookie: The kernel-managed cookie reported in the fault message.
+ * @code: One of response code in enum iommufd_page_response_code.
+ */
+struct iommu_hwpt_page_response {
+	__u32 cookie;
+	__u32 code;
+};
 #endif
-- 
2.34.1

