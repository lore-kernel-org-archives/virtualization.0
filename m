Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D915FDBD
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863155; cv=none; b=ia8kW+t0oa8j3axhYZEXdBHbdfPBvh3egKOLNEWUoiS5F2Zgo3VpEXK93bzjF+Pde+VXs3rLaloYxcE7zK8QArA7JoxYo1Q/6S/ZQRjwKJmrPKBCixOx4Wg65NGynKpd6iPDWyQ3Y3bphaAFuoC2DOU0EK5EpouC1nSiBH9phlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863155; c=relaxed/simple;
	bh=3WjSzuZGhykrWsG/SMOvc6080xJnIFyXc/yoAsAOfxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RO+EVWdzlnS/B0yfKPyM5jTqM0r99KUXRGNzMgqgGzYJAMGup8MtIIYapXTH0W/osjesEk08Vr6v2Mj1r9CtCYsLa8Z+4m1TRMnwK46h7sSKHIUIzvW+wV7lHHsFHlc3Rgdzot+BTGtMtjhdMyrV9EgzXmtJZOa5OcwUxy+VhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViBrqyyD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViBrqyyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863153; x=1738399153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3WjSzuZGhykrWsG/SMOvc6080xJnIFyXc/yoAsAOfxA=;
  b=ViBrqyyDHrAC+lByr2jhDKJ8suGVBxtNWOlGajVh5JK+IC83unwwMsS5
   gV/7pajGFwQ1fm9FKZXWN5ElMmUd0v7TF7kVE6TnG1BL3kxh5rTxKW7EX
   D2ok2nsUTDXMpy3hIlrqjz01eXytWz8gt4NAiWDzMfzMfAPCG2BYgQXDB
   fDNYO04/iYEN+ebO8PIKesErc4LERzLoJyw2TuSLernZk2OY7bKhq9ZGH
   GbVHHWZyYcGj+xEcAhmTpg+SEZ8EZeAmziCXMrjhyuDfbRtSlvdGnxFEn
   MmWwW6MwKmM3602LLT+Q3YF9oK5U5VAziH/tO3U+bjyO5rhivbfiSdHMg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10857163"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10857163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351551"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351551"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:54 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 10/10] vDPA/ifcvf: implement vdpa_config_ops.get_vq_num_min
Date: Sat,  3 Feb 2024 00:39:05 +0800
Message-Id: <20240202163905.8834-11-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240202163905.8834-1-lingshan.zhu@intel.com>
References: <20240202163905.8834-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFCVF HW supports operation with vq size less than the max size,
as the spec required.

This commit implements vdpa_config_ops.get_vq_num_min to report
the minimal size of the virtqueues, which gives vDPA framework
a chance to reduce the vring size.

We need at least one descriptor to be functional, but it is better
no less than 64 to meet ceratin performance requirements.
Actually the framework would allocate at least a PAGE for the vq.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.h | 1 +
 drivers/vdpa/ifcvf/ifcvf_main.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 5a4be3a4f939..0f347717021a 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -28,6 +28,7 @@
 #define IFCVF_PCI_MAX_RESOURCE	6
 
 #define IFCVF_LM_BAR			4
+#define IFCVF_MIN_VQ_SIZE		64
 
 #define IFCVF_ERR(pdev, fmt, ...)	dev_err(&pdev->dev, fmt, ##__VA_ARGS__)
 #define IFCVF_DBG(pdev, fmt, ...)	dev_dbg(&pdev->dev, fmt, ##__VA_ARGS__)
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index cd4e9cb020c4..80d0a0460885 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -456,6 +456,11 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 	return ifcvf_get_max_vq_size(vf);
 }
 
+static u16 ifcvf_vdpa_get_vq_num_min(struct vdpa_device *vdpa_dev)
+{
+	return IFCVF_MIN_VQ_SIZE;
+}
+
 static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
 				   struct vdpa_vq_state *state)
 {
@@ -632,6 +637,7 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.set_status	= ifcvf_vdpa_set_status,
 	.reset		= ifcvf_vdpa_reset,
 	.get_vq_num_max	= ifcvf_vdpa_get_vq_num_max,
+	.get_vq_num_min	= ifcvf_vdpa_get_vq_num_min,
 	.get_vq_state	= ifcvf_vdpa_get_vq_state,
 	.set_vq_state	= ifcvf_vdpa_set_vq_state,
 	.set_vq_cb	= ifcvf_vdpa_set_vq_cb,
-- 
2.39.3

