Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944263DA7E1;
	Thu,  4 Jun 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565801; cv=none; b=n4G887svW8btrApYH8ewNECYxPOBFXcSvAoU/kzJ6mM3vz047wGb4dn+FeS9orYQcK6hIYezTo2BbIRBud/1wyVb0g/Dj+AD+u4UjVDVyFG7GXL0cJMuRQRDwC2V8/gO0JsHt4xyYYCjdcUCikF4f8Rg0eLpxIo06zCwtSiGvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565801; c=relaxed/simple;
	bh=6jYclPervmH6HlTTAT2t7gUE3dTslX3C/i5gj/N/3xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSLG46xs/ybojQkiqjHxmo+OL46uERDz3W19s3BPxJK+uDEoOO/xm8wi9AIfhZiHt43yK0TVMBOi58Nl2Q06GS7FAzcKr1DVf9nk6vMO7aPJg5GbdYsskGxz3to9r7HGGP6guYRSrUhtLu3mWMyNObqcMVa9caPpSG1hcYO7pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+NziKD3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+NziKD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565801; x=1812101801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6jYclPervmH6HlTTAT2t7gUE3dTslX3C/i5gj/N/3xg=;
  b=L+NziKD36OnI56KrxVM6uE1/Xd3BsenoYHtphyGqWIK7FqtiBkgvJO/5
   64yEbkQZl8YBcY9RFLfRtFtH7iWfvj6qvuvSfkmTpmwM0tAkMyZGLwRk4
   ndyvg6HKu/HeK2b9YCQwxUBJxogf/gZ/mOykTYockAoV9k0bOQRIIoGdZ
   DZ1BR3lKDSBlC9eIGm9bxZmQ4Z2O1z7X9T01ZcgE7GcrbPyqpD14WIoYx
   BthFo624TdEV4uzrlsG+s5Kb8/PdtHoImK4lfJL2fs+/6gx0X7e+dXZ2B
   zpwx3z66Mk9JxsTRHhfe3/T6MGKAYoAnvoZUQwPC7lK1NsQFfqmeMLJnI
   A==;
X-CSE-ConnectionGUID: NuybiY8nRVO1wC4CK9MITQ==
X-CSE-MsgGUID: UeNz4/x1QwmBnDZQ97gZxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963773"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:41 -0700
X-CSE-ConnectionGUID: 8or6kYnXSZu78BSejaYkRw==
X-CSE-MsgGUID: sQvjen+cTcmzB6ahawbShw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037694"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: marcandre.lureau@redhat.com,
	david@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	prsampat@amd.com,
	pbonzini@redhat.com,
	mst@redhat.com,
	peterx@redhat.com,
	chenyi.qiang@intel.com,
	elena.reshetova@intel.com,
	michaeluth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFC PATCH 6/6] x86/tdx: Release private memory before private->shared conversion
Date: Thu,  4 Jun 2026 05:35:51 -0400
Message-ID: <20260604093551.1511079-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
References: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX supports a PAGE.RELEASE feature, when configured, host can only
remove a private page until guest releases it and puts it in a PENDING
state through TDG.MEM.PAGE.RELEASE.

When TDX PAGE.RELEASE is supported, release private memory pages before
converting them to shared state, this ensures pages transition from
accepted to pending state.

The release operation helps handle scenarios where the hypervisor may
retain old private pages during conversion. Without proper release,
subsequent shared->private conversions could encounter re-acceptance
errors when attempting to accept pages that are still in accepted state.

If the release operation fails, abort the conversion to prevent
inconsistent memory state. Note that if tdx_map_gpa() fails after
successful release, we cannot safely rollback because the GPA mapping may
have partially succeeded, creating a mix of shared and private pages that
cannot be reliably tracked or recovered.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/coco/tdx/tdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0abfb3505093..ecee6df92395 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -1121,7 +1121,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
 	phys_addr_t start = __pa(vaddr);
 	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	bool release_required = !enc && tdx_page_release_supported;
 
+	/*
+	 * For private->shared conversion, release memory pages first.
+	 * This transitions pages from accepted to pending state to be
+	 * more robust with buggy VMM, e.g., VMM may keep old pages,
+	 * when converting back to private, re-accept error triggers.
+	 */
+	if (release_required && !tdx_release_memory(start, end))
+		return false;
+
+	/*
+	 * Update the GPA mapping state. If this fails, we cannot rollback
+	 * by calling tdx_accept_memory() because tdx_map_gpa() may have
+	 * partially succeeded, creating a mix of shared and private pages.
+	 * Attempting to accept the entire range would fail on pages that
+	 * are still in shared state, and we have no way to determine which
+	 * pages are in which state after partial failure.
+	 */
 	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
-- 
2.52.0

