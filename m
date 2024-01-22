Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EA210F9
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909490; cv=none; b=mUVP5xNI4QqlmcZozMaGF3ehG0mV5kj7HDc56VslPsXLYdsRNptBmi+JbDGe67qyqYHD0X9nNoavsp+bBS33oW4iZ2OJuQEPxx6kezh10or4Gn+Ilq2rTBh1pVRD8VMWH3mNrPaWM4fYZDMK3gvKTqQwmfECxj/fRMbALvq1wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909490; c=relaxed/simple;
	bh=hmEQvRWi8eIAqM5TdiirQYEfxUrAqPd7+aexCnYV6h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efBy7jqBMA6X+fhlu/Z9F0HD6DxpkpTs5NJ4D9mflodhdzxGO6wPeewsMfPRPWUjSCUk6b/nErij/gC1GLdeV75M5tOSumMqJVrrYIpRHRA1+Oslgh3NlOHWewm/PhBoW8N8cdSc1Ja3bwVDlZKfLmCyY8/isLwy06LeFAqqkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCWMUAxG; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCWMUAxG"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C0B8820D6
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 07:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C0B8820D6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mCWMUAxG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-0G7BEsp_Ql
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 07:44:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9467D820D2
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 07:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9467D820D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909487; x=1737445487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmEQvRWi8eIAqM5TdiirQYEfxUrAqPd7+aexCnYV6h4=;
  b=mCWMUAxGR93uu/JvQyUTd+w0fCYoxvHREt2sOnYKwqvjH7scZSmEHAh4
   8SZJJRXe517nW7GCRulYMhlbdxqZrkkRlIvjOzInuWloInSCZLJMdvWnl
   ihyP8COY+9Sdm1dQFZLXyKBseIwgRNJGLVHkW6p++RdXFkkMGf78QnvG3
   gO3d3XvlLvBRU3hP6laHy7IhQXX6DCvCZmER7AmJyaGXFl3jqhMYQDrBx
   C0tCqE56CTPE7tfIMpu2Dzu/MmuOwPnSckdDe6E8JGKeQM0A+G+R53TE8
   uYDyfXTcga7Az82nm3FgKBSviAW9xVfWSoWehUQb1UWFKClX5wWzpqOsD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611564"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611564"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778504977"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778504977"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:40 -0800
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
Subject: [PATCH v3 3/8] iommufd: Add fault and response message definitions
Date: Mon, 22 Jan 2024 15:38:58 +0800
Message-Id: <20240122073903.24406-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122073903.24406-1-baolu.lu@linux.intel.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
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
identify an outstanding iopf group for a device. The @addr field,
which matches the fault address of the last fault in the group, will
be used by the kernel for a sanity check.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..d59e839ae49e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -692,4 +692,71 @@ struct iommu_hwpt_invalidate {
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
+ * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
+ * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission
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
+ * @addr: page address
+ */
+struct iommu_hwpt_pgfault {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 perm;
+	__u64 addr;
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @size: sizeof(struct iommu_hwpt_page_response)
+ * @flags: Must be set to 0
+ * @dev_id: device ID of target device for the response
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: response code. The supported codes include:
+ *        0: Successful; 1: Response Failure; 2: Invalid Request.
+ * @addr: The fault address. Must match the addr field of the
+ *        last iommu_hwpt_pgfault of a reported iopf group.
+ */
+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+	__u64 addr;
+};
 #endif
-- 
2.34.1

