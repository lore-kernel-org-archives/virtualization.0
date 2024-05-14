Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E122F00
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676649; cv=none; b=OK2HYZCBI+AdL9OMVMd84yWUwAK4F+cREn0+1qBuDj0MZcjCZlrE6bEktHujicnGU7ZIZ7JORBqqtwXDGPmUiPS+nDbtoumHBGwfYDbkGRl2TmEXfHZKamZ7QByTpmgubOf2mNZikT0ie8SsEKD34bkycfiYzaEhMzNccxv0Ahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676649; c=relaxed/simple;
	bh=TzyaL1m89YTs/iVAEZX9EZhsdANHj2yCqyuK2+8TITo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwOB4RZLt7KYXVLmIRM+OHn80UfyaBOzOejLY49l8ZUwMYMKCInfRpWKEsJxIAWbsi1lyquNlileYa3KaBbkS60a5y5+4aKLfHbxs+amsQXeaERZx2olqGTahDhpQTp0rswgvaOqgGhT6noSbhNnfbyjQFH+sdNkneibobKtfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHTaFDVn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHTaFDVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715676648; x=1747212648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TzyaL1m89YTs/iVAEZX9EZhsdANHj2yCqyuK2+8TITo=;
  b=VHTaFDVnvSlF9AwLV2KmlIuZXIzAq9cZNZWOf1tXZ4IGjumQ69+h46xj
   ZuSkc9NyowXJ55vOb1N2uHpbyX7oXcnLqGTty53h54fjkMUeYwcq8uAiv
   c7jkOYWxNOvlc3ShcxY6NKN5eF9M1GimzYuJocu6b8MC3IWTCR3coB1If
   Xh5KIVRxnNovWFjKOBhekY6YyJeRGS4gJIK/1I7YjnpfiRHNXwqoCls5n
   Yu0Ps1T444tZwKyABk9Rzn+ZC7D1dI7wGyMjpeDxlXSBq+jgfS0WuIL8V
   sYi0jbuMp+mQfS0VznlszOi4jL2l7NLMw2hFcN2W4u6V7RJ4rv5YZcC2U
   A==;
X-CSE-ConnectionGUID: oOeQABYxRKmRlfVSHvPWKw==
X-CSE-MsgGUID: 0T0JA3FSSO6EcBc5Ja69rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="29163370"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29163370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:50:47 -0700
X-CSE-ConnectionGUID: Oi1QCUw+QiWj+ohXlzZYGA==
X-CSE-MsgGUID: hc45udJSTsin0ZDzZsApVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30447444"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:50:45 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: lingshan.zhu@kernel.org,
	virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V2] MAINTAINERS: Change lingshan's email to kernel.org
Date: Wed, 15 May 2024 00:51:25 +0800
Message-ID: <20240514165125.74802-1-lingshan.zhu@intel.com>
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

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d75527f7bb0d..501b81b61b6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10466,7 +10466,7 @@ F:	net/ieee802154/
 F:	net/mac802154/
 
 Intel VIRTIO DATA PATH ACCELERATOR
-M:	Zhu Lingshan <lingshan.zhu@intel.com>
+M:	Zhu Lingshan <lingshan.zhu@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Supported
 F:	drivers/vdpa/ifcvf/
-- 
2.43.0

