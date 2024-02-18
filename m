Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF950240
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253753; cv=none; b=NWIJq5muHj9pXzUgVK+pn2J4yYxuA0wYEC72QGj/w6mOtYYUS9S6K2uzroZHxpoN6uiFsXMhwZGMSFlLeXl0J52bPG5I/+ZnXXB9tyGWJQAGx6I7rHhBUA6+0it2yx5qAGVo3Lt1M+E1YcI/Qp0GlxGidwrsnlgGdeeOGkkjaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253753; c=relaxed/simple;
	bh=NdqFlUx93BhVMdSblZFsYfg8PqPkcXMhOMOtPfEu7D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcjwCf7grxijRChVTuM7D6EABcBd/5BZtER1jtfC4yYz6IV9FVGfMCJxV2a2gm/zg+D6vzev8fwK8/JD3H+h1tZ1Sl0QH7OroL0iNFmlbCpsf3NxUbzY/XYPPgL+UgE0/Iwt9JF1gvikL4xELrC9hTXIx80YMdwBkYRkUrOh3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQFRweNU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQFRweNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253752; x=1739789752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdqFlUx93BhVMdSblZFsYfg8PqPkcXMhOMOtPfEu7D8=;
  b=BQFRweNUTI9xkkP0psjlQtOAsIdu2tanNvS++VRrNE+tG+CMI4sgKKx7
   ThMXJO1VTjNZSBaIkx2vCXQCFgWDchuLYuEJqsXHwCl7ad813twbitgov
   TSJitJkLe00UAJ3BUx7KXS8+s/E/QnS/Idv8kdJXH9gAaJScqVhOfKKlF
   PFv3wYaRSJLP209l85iEPBu9y+LhtmqZAYM+NnqL3WPAFqX1B9RCmmqag
   zRC+oZiQwMP5SRFBwRbRAkQxpRN5Q1UD+jP3jI/xtk7Plb+kTXDLIS3nI
   71T2YjQnEfkI6Q3HVpaAUEC+h0gzgoBGxa1NXXAVYbsixPh3HN8jUk0ol
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204662"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691650"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691650"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:50 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 07/10] vDPA: report virtio-block discarding configuration to user space
Date: Mon, 19 Feb 2024 02:56:03 +0800
Message-Id: <20240218185606.13509-8-lingshan.zhu@intel.com>
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

This commit reports virtio-blk discarding configuration
to user space,includes:
1) the maximum discard sectors
2) maximum number of discard segments for the block driver to use
3) the alignment for splitting a discarding request

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/vdpa.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index dfd9aa5779dc..bf3fa90908a7 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1041,6 +1041,29 @@ static int vdpa_dev_blk_topology_config_fill(struct sk_buff *msg, u64 features,
 	return 0;
 }
 
+static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
+				       const struct virtio_blk_config *config)
+{
+	u32 val_u32;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_DISCARD)) == 0)
+		return 0;
+
+	val_u32 = __virtio32_to_cpu(true, config->max_discard_sectors);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC, val_u32))
+		return -EMSGSIZE;
+
+	val_u32 = __virtio32_to_cpu(true, config->max_discard_seg);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG, val_u32))
+		return -EMSGSIZE;
+
+	val_u32 = __virtio32_to_cpu(true, config->discard_sector_alignment);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN, val_u32))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1073,6 +1096,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_topology_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_discard_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 5cc70614c97a..30887931a220 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -65,6 +65,9 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,	/* u8 */
 	VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE,	/* u16 */
 	VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE,	/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC,	/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG,	/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

