Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAD52F98
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016310; cv=none; b=dSCq/xvUx/lu/PcmfkGwitcBL6FdecU06pZVAA/QoiA4tIYPyvA10mOsfMaYY1Vm/A9QvYVOaQEsvLbHDcMoDsG45n6/8rjwbvr09a7rXhmMpZjsGtD1c5+3ERVziNOr2suzwNb2zPTdth0FgFofxjFLS6HRwfOeBrYNp0OH8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016310; c=relaxed/simple;
	bh=V9gQhvkEcqEVAxwEADIVvkpHNlHX/nWcQPaS16BALbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POySaIFxm1nw/iVX4bEhFEwDL4NjT7BYrPYsLz8c2bWYz/j7E0z7tCjwUAiD7zxGSB8l1T9NsT8wiKI4Lqdz7AH0FY/FyHTyFsVa8oEGet3LltXctwGQ7Bo4NDL6JBu9Wa+JHPZHoFDa/1WXrKa3drTYRjJ2LvbnD854TA7R2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/ISQ23q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/ISQ23q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709016309; x=1740552309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V9gQhvkEcqEVAxwEADIVvkpHNlHX/nWcQPaS16BALbs=;
  b=W/ISQ23q2V/+4PMEadhRP7baHG3dsGV6nXlofuNjlbxCfsv8pd7ZbsZu
   8GPKqjOscgQkNuvkltPQwlJOyhegHxNSW5KY8L14z8exs36N8BskQg2OV
   YdFr35Y6m0FWvH3QtAZkvuObZCqf59wf1OZHlVkRmcy/SYZG+rt/GsfDE
   lz2SBpxQEysvsHKRLkQ9JC3CaVmtbyEPfFzV12CfOZdLvrJ+6o3mX/mBo
   SNKv3xQxVXDpizIjIITtqKozM2hYFDD17MWX2DyJllSFdN6vnIJbVU7yN
   NhcbY+89AdZWHxuPoPbBcq4qGAjzo7237wTfmaTX+Z5YvdCGFng2R5Are
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14765624"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14765624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7144127"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:45:06 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
Date: Tue, 27 Feb 2024 22:45:18 +0800
Message-Id: <20240227144519.555554-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit applies maintainer role of Intel vDPA
driver for myself.

I am the author of this driver and have been contributing to
it for long time, I would like to help this solution evolve
in future.

This driver is still under virito maintenance.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..128ec843eb19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10365,8 +10365,10 @@ F:	include/net/nl802154.h
 F:	net/ieee802154/
 F:	net/mac802154/
 
-IFCVF VIRTIO DATA PATH ACCELERATOR
-R:	Zhu Lingshan <lingshan.zhu@intel.com>
+Intel VIRTIO DATA PATH ACCELERATOR
+M:	Zhu Lingshan <lingshan.zhu@intel.com>
+L:	virtualization@lists.linux.dev
+S:	Supported
 F:	drivers/vdpa/ifcvf/
 
 IFE PROTOCOL
-- 
2.39.3

