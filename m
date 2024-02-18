Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1A4F203
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253744; cv=none; b=jobyKnO/kU0nr2LBs4+EIl1jliBkZrKcWk6w4R26lXBpylMO4+V1OCwYqegax5MHHRFiUUuZecAJI808H5NBTEKmGDM0bDYRPhLV0Ah+X3kyfqkGlqFy9ZMEhlwXOxdCRL4juTKTvvNuvlrNGxbe4QRYBskENAfMh39loZd8sVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253744; c=relaxed/simple;
	bh=+BdQj9cWXWw09ctmpUnVkidKNevwsinDjY7dQ+FPBYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dv73SOJ068VnMIr8Cu4CN7EqPYgceTeaAZhnfj+nBGk0/Dv4MfuHZd0ZNIwc7pCFftKaASBHMz+YKov+a4C5w+0PRnk2cPg9fXq1ggQHbwqWv9QenTCLgIEpVhG1hBf1cvNcuTQNmH6h3peHL0oPeFVgTqsJuLHHCFXyE1Jx6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfRTYrvu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfRTYrvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253743; x=1739789743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+BdQj9cWXWw09ctmpUnVkidKNevwsinDjY7dQ+FPBYs=;
  b=LfRTYrvuf0JmUDPEgv/xCI5A7/F/jq8pxgQDRckh+rF6RLHLqsgYwvgC
   rbhk/TtUpaNb+6M8zb6Cg8t6UvV4pj1xIRZPUsf8Y2gUmAJrWlrU3pu4j
   caVgLXMnUXvYxcTJp7YDra1iDmnIIwj92aRJjkQfhk8ItzFOnd1KndjL7
   /YfdI/OWG7XF2iAojyhMZ5Xwur5RAvCmnZr3LMj3Vh/VYByleW3O9gwGS
   gelNfmrvt5UQLT59do9ibDoGNPjIJGxIGmw83YjfafM63Txa8IQQmPh4z
   M7/2WLFL/ocnWUOkZL+yeW/2L0wsn1O7zGat35tpyMyiUrFY8QGOZHTja
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204615"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691623"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691623"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:41 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 02/10] vDPA: report virtio-block max segment size to user space
Date: Mon, 19 Feb 2024 02:55:58 +0800
Message-Id: <20240218185606.13509-3-lingshan.zhu@intel.com>
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

This commit allows reporting the max size of any
single segment of virtio-block devices to user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d5ccb618de2b..ee1472d32b0d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -956,6 +956,20 @@ vdpa_dev_blk_capacity_config_fill(struct sk_buff *msg,
 				 val_u64, VDPA_ATTR_PAD);
 }
 
+static int
+vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
+				  const struct virtio_blk_config *config)
+{
+	u32 val_u32;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_SIZE_MAX)) == 0)
+		return 0;
+
+	val_u32 = __virtio32_to_cpu(true, config->size_max);
+
+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -973,6 +987,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_capacity_config_fill(msg, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_seg_size_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 1bf69226cb96..586bce3c906a 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -57,6 +57,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
 
 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
+	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

