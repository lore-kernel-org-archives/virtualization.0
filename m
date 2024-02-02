Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1985FDA7
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863149; cv=none; b=G5lF/Ql7gpBHYhZQA8EKvFVZw1szoFuj5p5F1DGLLQ+UkTu2WSgaiFdKOE3As0T8uid6Uhrveh/9fHiiKpmIg4uuuFBpULiC7fEbQdhCMpPbqICeyS0cNFBK7zg7YWVpNxxApFZqQK807cfUVey0juVCIt6MLWlJZUTBF5Z17IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863149; c=relaxed/simple;
	bh=7216XmlJQR5S0JrSpOOOX4tk+Nq64HaSZWQB9WVrz80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/+T8AgK2CK5vL25eZ+HSg5ArWwz21df9DbHn8VFdGtvhOhXN6qQ5K0h++1+y9u2u6vvk8PI0ZFosHqF43rePUG+jBO2DpZ33uA8WVELq7pLh5wCoB7VPYTJuXvkAVlexH92VcPQbvA5ekWinEj0rr+Hhli77ZT7ZzfIRPO1onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Agd7KgIK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Agd7KgIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863147; x=1738399147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7216XmlJQR5S0JrSpOOOX4tk+Nq64HaSZWQB9WVrz80=;
  b=Agd7KgIKFftEH53uXLD/gp2U0ldPJZWXLS/EcCu6u2JWyk0NXojIApmV
   ibnhy533wod1QyjWuyQjoT7IeFdQVmqDcOMw69cy0l+TKLBqVekxjFOEQ
   iNP5ERBbFbLrmYsbEsDAxestOFxz66WfLPZ9/DMAbG1KEZt4HeDyxpXcP
   PXZPVuFz3VnhKV2bpS7B73qqX9aNWqIqc0UhcMOmWPYGW2Av6CFDv0lWv
   9ku2uL7E7Nz9s5cq8K77aSiF6QONodC9FA35DYnhx7ItY4dHgB9rNo/UZ
   qoKejfjhHWUzW09C2/hUF1jdb2XngJQHBh++8LFy7ztELNAXa2UvqjQWs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856898"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351512"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351512"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:43 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 03/10] vDPA/ifcvf: implement vdpa_config_ops.get_vq_size
Date: Sat,  3 Feb 2024 00:38:58 +0800
Message-Id: <20240202163905.8834-4-lingshan.zhu@intel.com>
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

This commit implements vdpa_ops.get_vq_size to report
the size of a specific virtqueue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 5 ++++-
 drivers/vdpa/ifcvf/ifcvf_base.h | 1 +
 drivers/vdpa/ifcvf/ifcvf_main.c | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 060f837a4f9f..d78621fdd621 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -69,10 +69,13 @@ static int ifcvf_read_config_range(struct pci_dev *dev,
 	return 0;
 }
 
-static u16 ifcvf_get_vq_size(struct ifcvf_hw *hw, u16 qid)
+u16 ifcvf_get_vq_size(struct ifcvf_hw *hw, u16 qid)
 {
 	u16 queue_size;
 
+	if (qid >= hw->nr_vring)
+		return 0;
+
 	vp_iowrite16(qid, &hw->common_cfg->queue_select);
 	queue_size = vp_ioread16(&hw->common_cfg->queue_size);
 
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index b57849c643f6..5a4be3a4f939 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -131,4 +131,5 @@ void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
 void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features);
 u64 ifcvf_get_driver_features(struct ifcvf_hw *hw);
 u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw);
+u16 ifcvf_get_vq_size(struct ifcvf_hw *hw, u16 qid);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index e98fa8100f3c..cd4e9cb020c4 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -597,6 +597,14 @@ static int ifcvf_vdpa_get_vq_irq(struct vdpa_device *vdpa_dev,
 		return -EINVAL;
 }
 
+static u16 ifcvf_vdpa_get_vq_size(struct vdpa_device *vdpa_dev,
+			     u16 qid)
+{
+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
+
+	return ifcvf_get_vq_size(vf, qid);
+}
+
 static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_device *vdpa_dev,
 							       u16 idx)
 {
@@ -632,6 +640,7 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.set_vq_num	= ifcvf_vdpa_set_vq_num,
 	.set_vq_address	= ifcvf_vdpa_set_vq_address,
 	.get_vq_irq	= ifcvf_vdpa_get_vq_irq,
+	.get_vq_size	= ifcvf_vdpa_get_vq_size,
 	.kick_vq	= ifcvf_vdpa_kick_vq,
 	.get_generation	= ifcvf_vdpa_get_generation,
 	.get_device_id	= ifcvf_vdpa_get_device_id,
-- 
2.39.3

