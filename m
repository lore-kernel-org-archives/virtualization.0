Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D635026C
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253756; cv=none; b=eDoGFnEwlq85QobZCLG7iu5wmJGtgPuB00uir4dTgdlUmEnS0hek32t37iZ83MC4QzuR6JgMnzlLTiZ7g+a6C74HFExU8VaN/arX5mWUoHJepH7wtTRgAU3209WplV2AbUl4BfznGO813JLt09Ar8CIS5Airhpjgl7Btu5mWSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253756; c=relaxed/simple;
	bh=L3ZrKY/necYapztF5VG4L3b8VT/MyxJWceM/DWZ4ReQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5OF4fsDV06ATR9KLPJlHSWmwJQnxaMLAoc+RmlGdk7CDZ4frBuIJicHsbzLE4hMXfv1qe/ezP7caG1tJVdqqtqwSdhP8jTk+GoYuUX5ynmO+TeQzmWELmZTxx1FeQT+ccqQ+65RHGcY7U+hRZZOUlHSavaxaucbnid0A45nZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxVBf3p1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxVBf3p1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253755; x=1739789755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3ZrKY/necYapztF5VG4L3b8VT/MyxJWceM/DWZ4ReQ=;
  b=SxVBf3p1ODZBZrQrSfvsQXp9OtS+BK+tSlxSh3jDZXsKuE2TbheXXrQ9
   EsTJOzZJFJXlBMSBvnIPep/fJFA6Mswl8hsJSZb8UYbf9fI/pZihqUag8
   R17QuRHnMCe8FiFcDbYi8xLeZpHqsKrXQeaHNoDsBCOQjel/WgjOEZLGg
   J09OVtf4xCEnLl5YNKadY653wu1h+vg9XIHv1LpOT4uyUmPL/gFBrXAuq
   +rb6ZEHRKLzEerdXy0pJgltrmRxboAOd3AhrQv15O/Ut6Ue9ZMAlMMESc
   t7ypKPVjCNASNfyjH8bxqxguUrSYJBtnSsbI4hT1Y2HzqATReP5FLj1nG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204672"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691658"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691658"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:53 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 09/10] vDPA: report virtio-block read-only info to user space
Date: Mon, 19 Feb 2024 02:56:05 +0800
Message-Id: <20240218185606.13509-10-lingshan.zhu@intel.com>
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

This commit report read-only information of
virtio-blk devices to user space.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 14 ++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index adbcbc7b18b2..d6fd3cadc44f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1084,6 +1084,17 @@ vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
 	return 0;
 }
 
+static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
+{
+	u8 ro;
+
+	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1122,6 +1133,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_ro_config_fill(msg, features_device))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 797d5708492f..4be8e3a15874 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -70,6 +70,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

