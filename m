Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE24F20A
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253750; cv=none; b=cbJxci1t4qPlHoLTgOBK4LQAIv9xjfVstser+Hm7og8GMH7t+o/G/f2yoTSWSlu5cXZgsq4CS+rC3DNBnEDhVTIWFyd4kJhUTqkLWxJOGec/hUyWn9JS4h3tPF5FkgKxsB47gCYkO+4wHXXqOjgNTk7V9Vvq5egBq/hKoilWPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253750; c=relaxed/simple;
	bh=xF3lvhFX+T/l5j0+e6KNiiC6jvqG2ElTNU3GNJhI4C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0ulNhhkFdpRVfD2sopRmUh6ALEdCCAyOMx7kJ8IJVMYd6FGo5zBEyIw/r2Byuojb1BA8xkoOBKZSGdUw6lJhsWOT4egAs6/Je4bgIbESYPUY3A5NoK/jJL3UeUA86gLwkns/rCXPCb7McMnsHTljyUMtqw8M6xHrWxdDA+2nfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USp3BRUC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USp3BRUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253748; x=1739789748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xF3lvhFX+T/l5j0+e6KNiiC6jvqG2ElTNU3GNJhI4C4=;
  b=USp3BRUCAZQoOAL7KbWL9ww/kd0oGLD0MRWbu2Q751WuKeNbVZRCTCxl
   JoUjBitvYfanHDqzZztxvsjjLWIXqJ0f64UER0FtGwg7V+09il8u4yRT/
   LgyWEfcbkDXTI6Pq5ATLhP2UY6xDmiexO+gW+j1/NXSHVq9OH8BPlp7j0
   cZPB+ibNQyu8UO7WXd4U1DODZUYkm/+JkPbBROnBJWMoRdo/j7zlNUAg5
   qtO6K0FSKxFOtf+JYQ0xuBdQ8lVBBmRlJRqzOtl4HaUwANeDpSstfJeJ/
   0+gpNpqPbElv9oP0m2NuSMNaquWwRnMnvXJ84X82l13V7mgPOMUoFhdsw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204630"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204630"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691643"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691643"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:46 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 05/10] vDPA: report virtio-block MQ info to user space
Date: Mon, 19 Feb 2024 02:56:01 +0800
Message-Id: <20240218185606.13509-6-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240218185606.13509-1-lingshan.zhu@intel.com>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commits allows vDPA reporting virtio-block multi-queue
configuration to user sapce.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 16 ++++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8d00e9976aba..26e8768b869a 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -999,6 +999,19 @@ vdpa_dev_blk_seg_max_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_MAX, val_u32);
 }
 
+static int vdpa_dev_blk_mq_config_fill(struct sk_buff *msg, u64 features,
+				       const struct virtio_blk_config *config)
+{
+	u16 val_u16;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_MQ)) == 0)
+		return 0;
+
+	val_u16 = __virtio16_to_cpu(true, config->num_queues);
+
+	return nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES, val_u16);
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1025,6 +1038,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_seg_max_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_mq_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 2dc92fca2052..3c8e3c87a864 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -60,6 +60,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

