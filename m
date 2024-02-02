Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759C5FDB1
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863152; cv=none; b=hClqZLOMtwvV2wf5KPpfLdRKsimwlByt5+x6O4cX2VAH6lRSEQvk2upg+DKLID19grJFeP0HYXZ8oXScM7OsVCX9IeiT27AXzE1UbucKsNkar1CzylwZpi+VOqfhchyeei2+rCqfZbmd1w4R/nU2jJf+BwH3ON/L+FJH0O4X8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863152; c=relaxed/simple;
	bh=CIhADTGQPQ8jiryt7WxS12fZlut7iSeEGi7l8MkTJ8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIXJX1ZXfZVWwXtuw8gsaMkzp67aXpmu9hon07knFGHlUuF9gsmnGtALuwvaM9aLhxWbw46NtV5RId65t7ezY/6KjObiMK3uMdZOjdHX/C5Azh3ACtSgMfIp5RQKe9kNwksmlEIqBnXZb2lgdzdcCzXIzh8gvXxMgT/X9qE4Zhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDBY+ym1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDBY+ym1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863150; x=1738399150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIhADTGQPQ8jiryt7WxS12fZlut7iSeEGi7l8MkTJ8E=;
  b=eDBY+ym1BStccieZZoVV/PF2JRqwOpDPd9VHTAo7Qp0kEGFtWPJaCL0/
   +/FUrcNzy2S4M/SacMspE5jZ2ia8NebKxbxsGERoueDTS3gaSmlYsO9KZ
   ybSeBBZVH9VMHrpNREhaUmb4jFVToLrNEqHRq1ofuO8jTYmu1m1i4Y0JR
   SyV2Ey7q418dYYhD/n4Aexrz4H1zaiL1w6yGZufR5L3KGP7vmUmZ6JuBA
   Fs++ZtAvYcZuxRWZyBQZ5cSfq8QqFVBvedxC3ONz6QcgN/g5vlh1VrYKO
   kGTPlIV/rO4G80erVzmbclrk0kBGh2IBugoKsuqXjUY8opGInWdR2gQmO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10857054"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10857054"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351533"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351533"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:50 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 07/10] vduse: implement vdpa_config_ops.get_vq_size for vduse
Date: Sat,  3 Feb 2024 00:39:02 +0800
Message-Id: <20240202163905.8834-8-lingshan.zhu@intel.com>
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

This commit implements get_vq_size for vdpa_config_ops. This
new interface is used to report per vq size.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d24da79c399..200eb260cc4c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -541,6 +541,17 @@ static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
 	vq->num = num;
 }
 
+static u16 vduse_vdpa_get_vq_size(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_virtqueue *vq = dev->vqs[idx];
+
+	if (vq->num)
+		return vq->num;
+	else
+		return vq->num_max;
+}
+
 static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 					u16 idx, bool ready)
 {
@@ -773,6 +784,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.kick_vq		= vduse_vdpa_kick_vq,
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
+	.get_vq_size		= vduse_vdpa_get_vq_size,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
-- 
2.39.3

