Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344718E01
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863151; cv=none; b=Ootf27XY4jPkU0PAoF0LKkOVyOmZTNWEoTHABD1lbPfnVGX8A6ExOhHGxxtqvdEA6PqLfh2MTKsCNxHRhMZkGGfb1MAUheyGFZWLYj0hQg5gXwecqHnDYAGRMBWLEh/jffBgmIXUHwOxHSPMrSXNXbnqlO4NUP3phcGC4PAcbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863151; c=relaxed/simple;
	bh=SK/kZvs1BMy8Tx/mkV/4kfebdVVBUdOXW5SpmOi8Qlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asn8n4Og3WE+4m5csfkP3333zQaWZfIiKcP3JTVFAVqG9nGMRwB7C4vPcqgFOWFMgyoSpz7uQ+ixhs1lxthwKn6js8N76woSpH/lRETTW3p9JWUxgn7JFbfIJFo0E4EOGs8dUW8uh7oVu0JMPCNrGZxxZFCuVb+0iAiummFFjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsE51NGk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsE51NGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863149; x=1738399149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SK/kZvs1BMy8Tx/mkV/4kfebdVVBUdOXW5SpmOi8Qlo=;
  b=gsE51NGkFtzo33bEoP/PHEX8dMaG8lcY9c6MZEJCYWywR1BV2wOLeC3S
   ChuSILtWYdJeZGyccQf/36z+G007p8ogX76UazoSvIikbmhn4udd2/fHF
   ssDTpnr0eL3is2OYgH0fcmnm92jbZq5ZALiqGulmaxiR+GaUd35/NoDv/
   lu5rmbBHJRk2IYEOWNXhSc9T5aC+3KzVkpFVVFTbzXckDZNX4ePeLIHt+
   dUMtwS4TKcOcRmP0oJ+GJLG/gtyly0b8dFq3fUwe15j+doPiVZjKG/HZ5
   7IGJ/O9eRqQHruxEUvKoKWj5cMHWHEr/cBLU5r4E5J5vv4gQCDVbLNKCk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856983"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351523"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351523"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:46 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 05/10] eni_vdpa: implement vdpa_config_ops.get_vq_size
Date: Sat,  3 Feb 2024 00:39:00 +0800
Message-Id: <20240202163905.8834-6-lingshan.zhu@intel.com>
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

This commit implements get_vq_size which report
per vq size in vdpa_config_ops

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index cce3d1837104..ad7f3447fe90 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -254,6 +254,13 @@ static u16 eni_vdpa_get_vq_num_min(struct vdpa_device *vdpa)
 	return vp_legacy_get_queue_size(ldev, 0);
 }
 
+static u16 eni_vdpa_get_vq_size(struct vdpa_device *vdpa, u16 qid)
+{
+	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
+
+	return vp_legacy_get_queue_size(ldev, qid);
+}
+
 static int eni_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
 				struct vdpa_vq_state *state)
 {
@@ -416,6 +423,7 @@ static const struct vdpa_config_ops eni_vdpa_ops = {
 	.reset		= eni_vdpa_reset,
 	.get_vq_num_max	= eni_vdpa_get_vq_num_max,
 	.get_vq_num_min	= eni_vdpa_get_vq_num_min,
+	.get_vq_size	= eni_vdpa_get_vq_size,
 	.get_vq_state	= eni_vdpa_get_vq_state,
 	.set_vq_state	= eni_vdpa_set_vq_state,
 	.set_vq_cb	= eni_vdpa_set_vq_cb,
-- 
2.39.3

