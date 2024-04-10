Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90C13D607
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738249; cv=none; b=n92KmZcc7+cm81Kok6kxsHrHvaUHZzBpym6DVUDYV54L5F00z0zFPTOsDwExRjXcb7fDDn7KOJO/xOWXIqcjX/vqbtyBK3ZiTw2cMWmZzGasv/9B360ZICOqAUWBg2dvQI3f8BypIuB9fD85xuB9KnJgkgY35PVHEsCz8ARWXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738249; c=relaxed/simple;
	bh=RHpVSfKt+UhgH1VZbPpELadPP2o1XGWZpLP1k7rnwv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZQrNuDKCISnEkzq+YzV99/s2XE1LTLkXe+XAwBGUpQhTn0zlZKAMbGaYckDSFwZnwWFRb7i23Cb6H6lG9eKcf0YUTNQqhP4NM8aA5XhoCFh3mTvtEtZTmBAZUEZS6FNp/13Y70RxL0auNtCl62RgH5u/on5i7qseCie4VigQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiHyyes+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiHyyes+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712738247; x=1744274247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RHpVSfKt+UhgH1VZbPpELadPP2o1XGWZpLP1k7rnwv8=;
  b=WiHyyes+RvOYllZIg6xFeib7IuTuSSE8PuYBaYPBdi8v6YtTb9lqX4+u
   n7DjzmZYNrPZWEWULDQsL34ThggTwdrkiBYGXcKRGg9rbu1MmcWXCNZvH
   AUYezrH5z/pCnpLKhWZrzfAEI7WArxLm/Z9XsP/ghQDIF2hJ+jcNgslHE
   TqyLx9f4MWsfuu3LEzUtEmq4Ul2JkjeMGtqMtz3WF7423J9zLSHk/Zf9i
   tMcTIVo/WDKiolatMsZelMbB3ZV2Eq2/x7wFbT3Xthinpr5jp5WAQ/AO+
   tchLJIorh6BAMCyBA9jiKAUQbCeJBbuwwQeKaB6ZsaWhlc4HVE4povu1S
   A==;
X-CSE-ConnectionGUID: RP099agmRiCZlcnVdYa8sQ==
X-CSE-MsgGUID: 3dzh4nO4Rumdrx3Xshh1rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25529792"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25529792"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:37:05 -0700
X-CSE-ConnectionGUID: NyaVODiYRwyJqNA7GCVuHA==
X-CSE-MsgGUID: QEFJWEX1TRO3yfIAS8MO/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25175303"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:37:03 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: sgarzare@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] vDPA: code clean for vhost_vdpa uapi
Date: Thu, 11 Apr 2024 00:37:16 +0800
Message-Id: <20240410163716.699708-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit cleans up the upai for vhost_vdpa by
better naming some of the macros which report blk
information to user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 6 +++---
 include/uapi/linux/vdpa.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index b246067e074b..6cb96a1e8b7d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
 
 	val_u32 = __virtio32_to_cpu(true, config->size_max);
 
-	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
 }
 
 /* fill the block size*/
@@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
 	u8 ro;
 
 	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
-	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
 		return -EMSGSIZE;
 
 	return 0;
@@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
 	u8 flush;
 
 	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
-	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 43c51698195c..842bf1201ac4 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -57,7 +57,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
 
 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
-	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
@@ -70,8 +70,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
-	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
-	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
+	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
+	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

