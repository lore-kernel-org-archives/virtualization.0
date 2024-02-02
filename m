Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF665FDAE
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863149; cv=none; b=sxHnZwyWd8zFk7CsoCOrQRrjGB6gVjoV+dYPrmhIHx3ukb9wVEvcDm+BEhonQNsmKqI9/Ty3TL7D85bTX68vOqQoncjETkqQQ8nD6b48gEKW/O0/XUobqPFxhafIu3hOvBUdZkhkWK7rveaKKJ81wBLvtgUt7QtXLgfmI/MMZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863149; c=relaxed/simple;
	bh=0HwozE4SloTgBXYJGatZQGtmcNjeR+Lj1e4SOnJWNV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlVKhYIIZRIQyx+uZX28S/qE5tIXZtIX6T45YlDohViNpLwnkgOHTrsJhLzFMN9O3eobuP+lKnIm6otquOMkpIPTTymUE/oqNiIzEdnNW0b7vmC06XL2iJzAu054Pe0GWO9R+zgFL/d+p6GQe0S7nd/GYdE4r7AOqvPlFng/x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdUBNg+E; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdUBNg+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863148; x=1738399148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0HwozE4SloTgBXYJGatZQGtmcNjeR+Lj1e4SOnJWNV4=;
  b=CdUBNg+Exwhcl3XS3IwbuGQSMOh7YKpM77+FGoP/U2TzmV3hCcnoPlsf
   oe5ShVsL1y1a61gkH6N69Zp8257LhY+J4vz0aLBusgZ0Cs3STqtb5CGlj
   cASmE4z57CEkBU0Ujicr5D59hNKc2JFQxAdhPfAyIzssCZl4VnNJY+/24
   IllixILkEFhnpBWwHedivrGbSqryauW2AIbqIUAPQbLxwwyVbI3qdhdGf
   rpS1fqKyM3YwqakUBcC74j6nhgSF9//TcVc6YrUqNkpuWX9I2eBXJh/ZN
   RevIJ9LabMOqz5U4lMPq3QAdGqXXKhXlvWyvbPrGo3WDFDZJccpTGEhQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856863"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351506"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351506"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:42 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 02/10] vDPA: introduce get_vq_size to vdpa_config_ops
Date: Sat,  3 Feb 2024 00:38:57 +0800
Message-Id: <20240202163905.8834-3-lingshan.zhu@intel.com>
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

This commit introduces a new interface get_vq_size to
vDPA config ops, this new interface intends to report
the size of a specific virtqueue

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vhost/vdpa.c | 8 ++++++++
 include/linux/vdpa.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..7c2d7c8edb90 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -681,6 +681,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (!ops->set_group_asid)
 			return -EOPNOTSUPP;
 		return ops->set_group_asid(vdpa, idx, s.num);
+	case VHOST_VDPA_GET_VRING_SIZE:
+		if (!ops->get_vq_size)
+			return -EOPNOTSUPP;
+		s.index = idx;
+		s.num = ops->get_vq_size(vdpa, idx);
+		if (copy_to_user(argp, &s, sizeof(s)))
+			return -EFAULT;
+		return 0;
 	case VHOST_GET_VRING_BASE:
 		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
 		if (r)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db15ac07f8a6..4097e8e92860 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -195,6 +195,10 @@ struct vdpa_map_file {
  *				@idx: virtqueue index
  *				Returns int: irq number of a virtqueue,
  *				negative number if no irq assigned.
+ * @get_vq_size:		Get the size of a specific virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Return u16: the size of the virtqueue
  * @get_vq_align:		Get the virtqueue align requirement
  *				for the device
  *				@vdev: vdpa device
@@ -386,6 +390,7 @@ struct vdpa_config_ops {
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 	/* vq irq is not expected to be changed once DRIVER_OK is set */
 	int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
+	u16 (*get_vq_size)(struct vdpa_device *vdev, u16 idx);
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
-- 
2.39.3

