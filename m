Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D114C594
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606831; cv=none; b=TLYG7HnHiJfzSAcxz2+ODvtox5GgEwaHQW9/wca99T87TH2CL4/msqpanEdaXMlxfYetyxRAHrFkdWePOge2nIUXFtLYv3Jg33U2C+NYeJAKBXHC4bhX89Hgvt8MJawR7X8GqvZdOn7er1LiINyiyb6vPlrWbPQ2kmJBuvM2rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606831; c=relaxed/simple;
	bh=hmps5RBuKIZksqMIX5bY5zvbhi388ls+b+1s/1j/mxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJHFIZmbRETRc5yrcFEO5txd1Wuqi8oOt7PrjxIeDJYfgDPY/v1uVCrN/PWsWt7ByDQUyypaI9UOuQ0e7uiZM0YS05PEtvG1pI5cxyXpdd7kTUB4NpNh9qaId26/ivg8mS3l5vizwGm34NANTBsMDyQrqd4UwHMG4Jz5bWm3eqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqUNKyGm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqUNKyGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715606830; x=1747142830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hmps5RBuKIZksqMIX5bY5zvbhi388ls+b+1s/1j/mxk=;
  b=VqUNKyGm7hXAmj+5PqIulXUkg+7SPMkZbcrAOw6DqD9pQxjkcxz8PZMI
   Mrhk3Zic5HvQYqg3jtP08KlR2yzEwkYTgTqfaCDk5lV5iyBEKeiOWlI0f
   bwIzt0vd5mxAaQmcOZp87U/X7hs9hsujN29IyGYtBDx6VN+i4jrDhaQ6V
   xG1hhnHA8I7hUX3sUhHz4Fny9rhWlaW3MqP7SD2T86uKGrOCxphgEEjFv
   Vrr+TGFzGsHibcrVg/1yn0UF+26wKkJL59cvgH8UVp4BjRqmuyCronxND
   YXm2oOWOgqD70w9vEIcPnLkpNjs999QZlHk/6HdjUPSTL4lKELpVKPD7a
   w==;
X-CSE-ConnectionGUID: kv9vmNh9QzS0AiIKy7rUwQ==
X-CSE-MsgGUID: GlYfD5KXRHmhMhjLAdFglA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11483526"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11483526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:27:09 -0700
X-CSE-ConnectionGUID: EYOfW/vaTyixywSdawuv2Q==
X-CSE-MsgGUID: 4QRRZQMKQVOJKqDdJhPL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30745042"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:27:08 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: lingshan.zhu@kernel.org,
	virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] MAINTAINERS: Change lingshan's email to kernel.org
Date: Tue, 14 May 2024 05:27:50 +0800
Message-ID: <20240513212750.10158-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes lingshan's email from intel.com
to kernel.org.

This commit also changes the title since ifcvf drives
standard virtio pci devices now.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d75527f7bb0d..b69239cf30a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10465,8 +10465,8 @@ F:	include/net/nl802154.h
 F:	net/ieee802154/
 F:	net/mac802154/
 
-Intel VIRTIO DATA PATH ACCELERATOR
-M:	Zhu Lingshan <lingshan.zhu@intel.com>
+Intel AND STANDARD VIRTIO DATA PATH ACCELERATOR
+M:	Zhu Lingshan <lingshan.zhu@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Supported
 F:	drivers/vdpa/ifcvf/
-- 
2.43.0

