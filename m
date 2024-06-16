Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7751802AC
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518482; cv=none; b=UTxJ2MhiVyW8whVloIZpJtX6WYpjxUA+3fdrVCi1LGub6m6gHRtA70DK9T3eO9DXTIMhTU7R0Tkruqq1yaoyHdN+s2LHZ24I+YgRY+y0LbNPIrV6b8G28ss+41dAqumJciCHsznc8CGNRILi3E93SJCfZyjsye9QYss5VwK6zRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518482; c=relaxed/simple;
	bh=aLGsugUEiksa0H2A/nbQKQsDAz1AlA/KrgpmQomaKhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ft/jjes+mI0t981JBLZ9GVpkPr+wxTq0rFMPsQS46/WtbzyiI6nc6vLavwPv9K5g+1hn8KnVuTClEnvK7TKzfWUAnpNbbh7SGlYWSubOvBeIJ/wR9VXgPUq4nTp+/HIhWEun0u+jTxvFuMNFSk6o9SfDpK4m6hYgZKl/kiPgtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewYewHF0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewYewHF0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC42B81BA8
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ek8oxpnv8ePg for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jun 2024 06:14:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 045BE81A46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 045BE81A46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ewYewHF0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 045BE81A46
	for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518479; x=1750054479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLGsugUEiksa0H2A/nbQKQsDAz1AlA/KrgpmQomaKhA=;
  b=ewYewHF0gvaAwUr6r/pSU9NZYgTzMD3UF1BdXu73xlKgaZ23tkggeXpw
   HqfylR+Vui1RJKnGA5FpGM4Z/Epgq7aMoYfnBUNcRrq6PWs5ARCwKxUFN
   0rlY4SFwrlwyMRvORgYACPTc9Uvi7QByG6bSlw9w8I0sPVxnyTyLpFggQ
   6mjYBvKv/w0E3C7EHHH3A7xeXZscODkyp3uJGpZr8OGtkDRc14JfUd4p6
   8RgFwRJd5tnGosEwQ/MQAS9/SwGvqZ9sY5+sPvc9dQ/a8Htt8yh5zZpED
   mXdl7H2Teehg0/Lpg5E3cMHP2iU84uB1rbw612fDT0cBajiUNmoSg7BJY
   Q==;
X-CSE-ConnectionGUID: +t0XOmypSpCYdtYlxcZCCA==
X-CSE-MsgGUID: 9IvZQPOqTdCjRes5f1jlaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290049"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:38 -0700
X-CSE-ConnectionGUID: RFkxFeq6SjOpET29ZN9klg==
X-CSE-MsgGUID: cnpjl7MWTFa4ZAXCiBli4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748175"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:35 -0700
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
Subject: [PATCH v7 05/10] iommufd: Add fault and response message definitions
Date: Sun, 16 Jun 2024 14:11:50 +0800
Message-Id: <20240616061155.169343-6-baolu.lu@linux.intel.com>
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

