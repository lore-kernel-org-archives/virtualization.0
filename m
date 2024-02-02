Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91A5FDBD
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863152; cv=none; b=ecZ6PyUCq9i8IFZb/bVZ5xb/cLba3GEPKTs7KB/JkiCgdYdvmDGec5mTGfPRomD/tEbiwkpidzkzLs+Ry6yeBYyiYdIbKnke+KG1FSWRg+f6gQcRmbuS/2cgH+TcOdBjUAcGp8v4HEdKoJRCcicLVTt/JuSBczJeytGiz+91HPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863152; c=relaxed/simple;
	bh=0g1hNMrQVs5Iee8Dy9fd7jJSLR7KrlKsOaLtdc5p+Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXFIGHa1Sfzc/JxR4z2JT0yW7cVh7PoVSo0qu5xKYAjlzJJhftwzhxnk5HgA0Ewg8Fc9DWA+3T949IGKRvAqLEKrN+c95EUDLLEbqJXUW0UPbgetKFRowAQgeux9r17j63cbXx/WzAqj9j25u/6mRhmoyxoUbvYcTSyP2o2RA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFvYtOTb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFvYtOTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863151; x=1738399151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0g1hNMrQVs5Iee8Dy9fd7jJSLR7KrlKsOaLtdc5p+Us=;
  b=bFvYtOTbyAb2r2SOcdeTAzFy535IN0Rkmk9J9Y92r/G61vnKN/Qz6QMR
   VQdpMtevaqH+Pg3n/LXrf42y/Hy1/7AqN5I7wV07O38Q4lYN0ZorcR71s
   lf1+9258jq4AVMCOjz8ChjbDyVy/+L0gX4vGjv80awYFdfyhmuH+Y9F+N
   aD8AyquDcr+uAPR/WFp5CFgPoRHZMBZ8zzsIpnrBtqfLa/59HnmvZGp7U
   eG5qWC6jwZ8LjmtY22fKdP4NZT4+gJzaYGN+1vXirlDr2POjQdsx4yUoO
   MpF7jherqrSqH4RkUpVOEsyrTPZ/taCMGx8KF5x7AHmbD3mO1H/05nSdk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10857122"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10857122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351546"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351546"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:53 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 09/10] vDPA/ifcvf: get_max_vq_size to return max size
Date: Sat,  3 Feb 2024 00:39:04 +0800
Message-Id: <20240202163905.8834-10-lingshan.zhu@intel.com>
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

Since we already implemented vdpa_config_ops.get_vq_size,
so get_max_vq_size can return the acutal max size of the
virtqueues other than the max allowed safe size.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index d78621fdd621..472daa588a9d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -82,10 +82,6 @@ u16 ifcvf_get_vq_size(struct ifcvf_hw *hw, u16 qid)
 	return queue_size;
 }
 
-/* This function returns the max allowed safe size for
- * all virtqueues. It is the minimal size that can be
- * suppprted by all virtqueues.
- */
 u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw)
 {
 	u16 queue_size, max_size, qid;
@@ -97,7 +93,7 @@ u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw)
 		if (!queue_size)
 			continue;
 
-		max_size = min(queue_size, max_size);
+		max_size = max(queue_size, max_size);
 	}
 
 	return max_size;
-- 
2.39.3

