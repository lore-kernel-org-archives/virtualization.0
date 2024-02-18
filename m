Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC534EB4D
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253748; cv=none; b=CP1K4o2yqm4GIfD4JDzAlmUuJdegd5S1U+po96RoipE0AsiTtNcvwYAVMfYSE9Wr7fYJN0t7h0k9k5JZVK3wl/x0A5tJ+dK8L3K1jlrue8kLvGg+K2FLQ5b82O6aXCDUhKBK0sII+zWH1L2bdn6q6W7ePY6A+4H73R9txO+bjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253748; c=relaxed/simple;
	bh=HIYSuVNHqblqz/YXmx8/a1b3lXpVi1WNQTlzGJ3DFMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/OGOH5ZGTQL+8RVjrKREIB5yD19lHxqM9GZMjofdLuLzaGyOaw4lt5/p+xxU6GTHawE0Dmsasc7vvC4xx8AkGjOKCYkeivxg+jq2Qary7OfAoWBeD1PlXGPTnuxFHvgKQ7BI8/YV/gY0jTcBx4twoRWY4Alm3joq2aGOvYbc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqVvsbm6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqVvsbm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253746; x=1739789746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIYSuVNHqblqz/YXmx8/a1b3lXpVi1WNQTlzGJ3DFMY=;
  b=XqVvsbm6C/Ulm3lwh7qpk1kRVXy4AUV6RjkVyrg3L5sfNgrVnR/CLje3
   zabboRNPWAThn7cJd3NgfNFIMf5F+Dc8FA57/Qe5M3I4MtFwQxhtjiKoU
   8n6LLF6/UT8t83kN4YclEXKC5zaT/wmiPC7G7BkaT5IP+0q+IXjw/E3oC
   cKu+kQx8ByXN9Ma8i0KQQw61sODKtpdMd7aUwRcpJd7upqblOH2e5rShf
   xIj/tmar0ruyJ/qexEbUNzcVnkkl02GPpAZf2XbQuF7q0y6xGpRKFYcsr
   XCla9tv0ZSmh3fRtWopDsaCNFJiqdIkbRiPNzDFKuHhKy1q/PUYXRXRLO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204623"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204623"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691637"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691637"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:44 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 04/10] vDPA: report virtio-block max segments in a request to user space
Date: Mon, 19 Feb 2024 02:56:00 +0800
Message-Id: <20240218185606.13509-5-lingshan.zhu@intel.com>
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

This commit allows vDPA reporting the maximum number of
segments in a request of virtio-block devices to
user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index cc8f41d24c9c..8d00e9976aba 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -985,6 +985,20 @@ vdpa_dev_blk_block_size_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE, val_u32);
 }
 
+static int
+vdpa_dev_blk_seg_max_config_fill(struct sk_buff *msg, u64 features,
+				 const struct virtio_blk_config *config)
+{
+	u32 val_u32;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_SEG_MAX)) == 0)
+		return 0;
+
+	val_u32 = __virtio32_to_cpu(true, config->seg_max);
+
+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_MAX, val_u32);
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1008,6 +1022,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_block_size_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_seg_max_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index f3baf7ea7d6d..2dc92fca2052 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -59,6 +59,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

