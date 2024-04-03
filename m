Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78E134BD
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107003; cv=none; b=Ff5aeAjLi1nah7zbMLXhLijCGv04l7BtjmaMrrb5lkfv+LT2trxTTnWIF14PXokV0yEnvsfBWKdocuShPRqB1k4zBt7C8gTX2zvjrud1Yp45JAAwla+MCrbbJfXW2G3NEkE3zi4ykrxXqnZgoUTyZbkxFYT0XV/PkFXgiYRf3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107003; c=relaxed/simple;
	bh=tvoic8JEg5iwsCj9YBFoEAx3/4HZliI5/5DJbrdIfjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQTZ0utz1HsrUZJYb/QmtIbyB23+pcY1wy+rCK2jwH3ytsRo00AxLleQO6qNP9D+EqnQYwcGp3nWg+0DftqsbQaqrMCt5B+nqqDm0BrKmYACZNhesqSb0X2s1RUSpMJIOut5vn+IuUwaSt0Isqnk9QVu3IsZKeW/tq98aYNouuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCmQVOak; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCmQVOak"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D777740B72
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWrhnmY8GjB3 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Apr 2024 01:16:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC579402DC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC579402DC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OCmQVOak
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC579402DC
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712107001; x=1743643001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tvoic8JEg5iwsCj9YBFoEAx3/4HZliI5/5DJbrdIfjQ=;
  b=OCmQVOak0+fK4aq+GzrW3iaTvaJZtvA63ppRgC9sZe73vY0QMUR20chj
   AeZQH7G/JO77LmHVnJSa1KQz1AOmPaUkNIt53hCpBrwKxDQZPkEgpDKVb
   T8I3I9WuDRni5K/kB6pe+LWn1aKr2eucbermUszKSyuBsBR44/A1nNHgx
   1tlAjzh3RbmjyGbM/tVkynfuaaeEtB7PAL6iQSCcpgSEQoe7R/f7l1CQK
   z60WCzTbF1NPSCUTaM4ZLEfor8K1HTXzBKAraeWSuJsgZzCpsy8htPgqu
   9ngzYekcYMe5bXDYhzKo8tRJnMGDRzkiqSFYAzJmDpwZK+mdyT5g/woAY
   g==;
X-CSE-ConnectionGUID: iB/TKuNfSHu3qpuUYsDbgw==
X-CSE-MsgGUID: acijCmvWRp27vrVgU1C/ZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439783"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439783"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:41 -0700
X-CSE-ConnectionGUID: ejLrWSjdRfuR2nGliBxExQ==
X-CSE-MsgGUID: SJHBJIhNSEarsqoBdvGlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953289"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:38 -0700
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
Subject: [PATCH v4 5/9] iommufd: Add fault and response message definitions
Date: Wed,  3 Apr 2024 09:15:15 +0800
Message-Id: <20240403011519.78512-6-baolu.lu@linux.intel.com>
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
 include/uapi/linux/iommufd.h | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..83b45dce94a4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -692,4 +692,100 @@ struct iommu_hwpt_invalidate {
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
+ * @size: sizeof(struct iommu_hwpt_pgfault)
+ * @flags: Combination of enum iommu_hwpt_pgfault_flags
+ * @dev_id: id of the originated device
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @addr: Page address
+ * @length: a hint of how much data the requestor is expecting to fetch. For
+ *          example, if the PRI initiator knows it is going to do a 10MB
+ *          transfer, it could fill in 10MB and the OS could pre-fault in
+ *          10MB of IOVA. It's default to 0 if there's no such hint.
+ * @cookie: kernel-managed cookie identifying a group of fault messages. The
+ *          cookie number encoded in the last page fault of the group should
+ *          be echoed back in the response message.
+ */
+struct iommu_hwpt_pgfault {
+	__u32 size;
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
+ * @IOMMUFD_PAGE_RESP_INVALID: General error. Drop all subsequent faults
+ *                             from this device if possible. This is the
+ *                             "Response Failure" in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_FAILURE: Could not handle this fault, don't retry the
+ *                             access. This is the "Invalid Request" in PCI
+ *                             10.4.2.1.
+ */
+enum iommufd_page_response_code {
+	IOMMUFD_PAGE_RESP_SUCCESS = 0,
+	IOMMUFD_PAGE_RESP_INVALID,
+	IOMMUFD_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @size: sizeof(struct iommu_hwpt_page_response)
+ * @flags: Must be set to 0
+ * @dev_id: device ID of target device for the response
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: One of response code in enum iommufd_page_response_code.
+ * @cookie: The kernel-managed cookie reported in the fault message.
+ */
+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+	__u32 cookie;
+	__u32 reserved;
+};
 #endif
-- 
2.34.1

