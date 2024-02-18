Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F574F20A
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253747; cv=none; b=F4i2GqR6b+UcInyvpzp1CLEgEdB1PJ9FjJvdZ7S7wSWiyGUYrDanxDsdMGrta6063rh0BVZLL5kkE46pSvJGOh8G1uPMfZxp/jZ7ImZW91Jn8krx5Ia8bukHVudAD2nOXl5T7wiAGo37P/DT5n82mRdltzBBLfmvpcvRCEq4S6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253747; c=relaxed/simple;
	bh=Ps0fcnyJ80G/u7BU8lXQPfkiNS/f/7OnU2wSnQvUe1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkzHl6pLmq5Fe1ni6DCj+0Tsdn3/3B26u0IkLV/D2TUTA5jW0iX5LeCCCirc+zhTYJwLQEo7wj/nZnrVI1qwkQPs1vRyM/PjGTN6RdChLTFoMMtMZ/wns023315Spd22OZbe46s8wJRRR0BKzRG2HHEnTu4J4n1kP/6j61+1p5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwhLX181; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwhLX181"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253745; x=1739789745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ps0fcnyJ80G/u7BU8lXQPfkiNS/f/7OnU2wSnQvUe1Q=;
  b=GwhLX1811Pt1857Q/UIsH17fo5YjOpSFzFKy6TXMRQebs9mZK8ZzHb/+
   Gs/MJuEPeLCMRpUXDOEaOEn6BXYmWnQlesrucm7ohYg7Odoz2dePyzNgt
   8uhsVpOFG4hkT0GHOsGfhFfjTDrFWgiBLdOYoBVXceS6G28D9epjlQ33y
   M+Gx3i1BztyEPKUWl8pNJdNXxKQfqBbJO8ytkIoa4uwXsbDVRuAoWmkk2
   EXGBAaSfQ4poisMAeJjaGihNe95KM67i4DvDHD2Y/qPkvNoNTY7En3J/s
   B8Xk3/ekfIMkUAgNCMDTu5tSzNhRhUhEZdMCrpvfFIBAq40bRzAPM2kY7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204620"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204620"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691628"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691628"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:42 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 03/10] vDPA: report virtio-block block-size to user space
Date: Mon, 19 Feb 2024 02:55:59 +0800
Message-Id: <20240218185606.13509-4-lingshan.zhu@intel.com>
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

This commit allows reporting the block size of a
virtio-block device to user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 18 ++++++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index ee1472d32b0d..cc8f41d24c9c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -970,6 +970,21 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
 }
 
+/* fill the block size*/
+static int
+vdpa_dev_blk_block_size_config_fill(struct sk_buff *msg, u64 features,
+				    const struct virtio_blk_config *config)
+{
+	u32 val_u32;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_BLK_SIZE)) == 0)
+		return 0;
+
+	val_u32 = __virtio32_to_cpu(true, config->blk_size);
+
+	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE, val_u32);
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -990,6 +1005,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_seg_size_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_block_size_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 586bce3c906a..f3baf7ea7d6d 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -58,6 +58,7 @@ enum vdpa_attr {
 
 	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
 	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

