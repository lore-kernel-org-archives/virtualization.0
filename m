Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C535026C
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253759; cv=none; b=FdFhJ+rG2AUWWIwz6BqXBNLQbTB30WCZNIAilzJYQ4ayFfGfinkE6BWFeH81iB+jHSfaYCj1yc9rj+8/p6OSKpOxAuLZJXFIxAjF3D6MyWMALPXRj8wVFARnoiGvMytgCjJXj1Gceno5RTsXDSvwah28V05URGOpgxo6UZ9ylZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253759; c=relaxed/simple;
	bh=Jrz409lPkTkkLUj3615VxVKyx5rilQs7BVI3Xby7SLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enc7bLHTMgl8rgYsgeos2WYPX19kYfuxLMPTtWUcx4absmyOrR+OBoJSEAMd48J4H8Kxvsubtce1NcWZR8XWZFYL/AySCk7g2IhxCbVBSQLNoYHHf1scNmE3Ig22t0tBjYeillEd8jyZHaKwLwMrzpKEwQjigUsa9C5AYP8j+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3Q817J8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3Q817J8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253758; x=1739789758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jrz409lPkTkkLUj3615VxVKyx5rilQs7BVI3Xby7SLU=;
  b=Z3Q817J86j4/62AumD873L678BQlk25lMzY4nkAzw9ra8U0bLz1YuuKt
   Fgb7gB8MsoKBTxbql/qewog/BQxDe1ArPthvGcxxlIkB8Sx78nrpVZyHK
   XJ4k4UTvCBFngyRfQlW483olcDE8UT9m8QXxbUFzbF7kXa+iTVfeDtfdM
   +0Jz0/Rp1c6QZvXNHE3M3g/dic7hM3xUj4+d5pQrkrgCfZq8nV9IpHk4d
   egLdtFXa8bQgL8kkwd4iaz+9EGbeQRE0njKjpjD6sdTyhFlA1bp0kE7HO
   8RsjaGqI65WNFlnfBqZwhbfhWPAAzmnPcgqPd8VqvVga83AZSHReQwkkU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204678"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204678"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691663"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691663"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:55 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 10/10] vDPA: report virtio-blk flush info to user space
Date: Mon, 19 Feb 2024 02:56:06 +0800
Message-Id: <20240218185606.13509-11-lingshan.zhu@intel.com>
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

This commit reports whether a virtio-blk device
support cache flush command to user space

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 14 ++++++++++++++
 include/uapi/linux/vdpa.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d6fd3cadc44f..95e1440dbfaa 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1095,6 +1095,17 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
 	return 0;
 }
 
+static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
+{
+	u8 flush;
+
+	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1136,6 +1147,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_ro_config_fill(msg, features_device))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_flush_config_fill(msg, features_device))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 4be8e3a15874..43c51698195c 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -71,6 +71,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
+	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

