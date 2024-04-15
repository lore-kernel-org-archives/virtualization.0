Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6951C11
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150649; cv=none; b=eAS8IAXWAjqFPTNcYyVZZm3UYTcGgGP2Rvoe5/WLdCpM7U2tOaqNkzApPeGUfkGDZHKpa5i/a9hnt5yiCs4UDGflcIxp34xCbkvixiWOzymCP8Xx7u3bMmCronorBhUV+Aoker+68SBI/r9ecxIa8TNWvq683bIHEiLS42xVBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150649; c=relaxed/simple;
	bh=Aozkls0v/ko4ZVKoOZY7LTnx3V5ue5duDFqxBNYb7u0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rh7xrAM51ZuZZIwKFszWse0cl5dkS7QaqvVZAIyJMSgZxhg3SeF1CtIYU+PvD7Id+QW0XgeIwU+FE5zoBAQErV8vTttIrU8fBu1prT2qmEuixETrepQTtm1dz8evkPQhMuUjND60ZyD4+khnrW4MlUu96ILMcInBH8JK4SVci4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSTYUFCH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSTYUFCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713150646; x=1744686646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aozkls0v/ko4ZVKoOZY7LTnx3V5ue5duDFqxBNYb7u0=;
  b=bSTYUFCHZuDEHc53n/Mhpu4e2tSYeOHcsdwmIa6BiPWJyZTL9XoKkI0m
   Bb6Mc17jCT8OSFi0vdXorVZV+uAVE07tapTzo/MuYJx4KFscMSYDYFkEM
   u9xZnGrT4F4ef5lrsD36I1rcOEVLBgEt72Mx+P6p467bnVLImG1+dfcnw
   togvScacaDToSkbkJtgniyOxJvZfClMseFQka4xBNCtepqot5IMvDuheH
   5HYiD/T3uW8jBt8IJURur86EzwIBLLN0YSAKkrQ+FAHcrYKXYxQgFMY6x
   CFOLv2k71NqVesFZr2JUjEyrWUfd3LuFhpyeYg6mKO8pzAqAVbyOCFFce
   A==;
X-CSE-ConnectionGUID: yymXRHZDRV+xpBvPWQYwgg==
X-CSE-MsgGUID: OBP6/sLsQEu9VyuV6nMfag==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12369253"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12369253"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 20:10:46 -0700
X-CSE-ConnectionGUID: 6yLEAbs/TFWztiA2UjMzuQ==
X-CSE-MsgGUID: 5eEJm03iSTqgPLFnqvFErA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26578612"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 20:10:44 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: sgarzare@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V2] vDPA: code clean for vhost_vdpa uapi
Date: Mon, 15 Apr 2024 19:10:47 +0800
Message-Id: <20240415111047.1047774-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit cleans up the upai for vhost_vdpa by
better naming some of the enums which report blk
information to user space, and they are not
in any official releases yet.

Fixes: 1ac61ddfee93 ("vDPA: report virtio-blk flush info to user space")
Fixes: ae1374b7f72c ("vDPA: report virtio-block read-only info to user space")
Fixes: 330b8aea6924 ("vDPA: report virtio-block max segment size to user space")
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

