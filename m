Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0634F24B;
	Thu,  4 Jun 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565793; cv=none; b=o7EYmLFg76eVD4htX+EU8gvzLwlMXVeq++zx5lDDHnRkks0zZxZKLHEIuV1VzCXS6kh6Zm5ej0X3GZyobNQPkIsWEKYAsSr2+ovlBKpeQpbozECuE8vHFu+Ov1/bO623XkuxmwNp9VUOoNTjh9vqLGNXvVfEmX26Gj0Vmc7mKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565793; c=relaxed/simple;
	bh=vQ+0bXUeGsFkql9TL2Ei6x4UXxGV/lt8a2RwxDm5sTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omYtUWw+TVLJldxfdNZgJSeuVzATm1rml7D+inAzEKixgges2zgdC9oy8Y/VT6zdDu8gJvINzzgW5IX12BDNENba4Z52aBhqvuAzhjZZylho/5qJv0gMff8zBNa4H+Huo8mT+6r725cllKszbT1S7WCoGQi/JH8BmTitH5rcAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xxq9jc+n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xxq9jc+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565792; x=1812101792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQ+0bXUeGsFkql9TL2Ei6x4UXxGV/lt8a2RwxDm5sTY=;
  b=Xxq9jc+nk/4EbLEzSJ+HAI9Vn8boE3bx9JXJ5Qu1UaYW0/by37ZZ1mrH
   TChx9ZNtCF1nIJPqvRmNyLs2FTr+f/ladszMyMatqDLowvODhhpMMCx6i
   2MICl7vHDjK2LMI/ealwoIB+eRrTKJo0SkWqYWobGSlhZkfBPMBv0Wpqw
   F+bZnKpj3ref4NJgkSN8/UuU6tcf1/6BA3BtxYzi4mfVDEPDjf1o4hA3t
   9yc4bubSOXjq1esgr2xIoWp9F5oBV8OEw/D78Fe5p/YTLSc23NhBRRkmL
   x1H0cJkiSexwe89LnXchwvnFiH+C7Aa0eFiPo2WDSYm7uAMCI8i6VPxfF
   A==;
X-CSE-ConnectionGUID: 8SGaxPiDSCexfVfbjZ6dIg==
X-CSE-MsgGUID: 3k+RJ4NKRzeOD38uG/fV9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963756"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963756"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:32 -0700
X-CSE-ConnectionGUID: DwkJXHW3RpKukFMOF92sYg==
X-CSE-MsgGUID: gdZ9mf8USL+aYf+V9Zt/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037659"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:27 -0700
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
Subject: [RFC PATCH 4/6] x86/tdx: Register memory post-plug callback for TDX guests
Date: Thu,  4 Jun 2026 05:35:49 -0400
Message-ID: <20260604093551.1511079-5-zhenzhong.duan@intel.com>
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

Register a callback to handle memory acceptance after memory plugging in
TDX guests. When memory is added by virtio-mem or other memory hotplug
drivers, the TDX guest must accept the memory pages using
TDG.MEM.PAGE.ACCEPT TDCALL before they can be safely accessed.

The callback uses the existing tdx_accept_memory() function to accept all
pages in the newly plugged memory range. Without this callback, newly
added memory would remain in "unaccepted" state, and any access to these
pages would trigger VM exits and potentially cause guest crashes. The
callback is registered during TDX setup and remains active for the
lifetime of the guest, ensuring all dynamically added memory is properly
accepted before being made available to the kernel's memory management
subsystem.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/coco/tdx/tdx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..d93ba092d311 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -326,6 +326,25 @@ static void reduce_unnecessary_ve(void)
 	enable_cpu_topology_enumeration();
 }
 
+static int tdx_memory_post_plug(u64 addr, u64 size)
+{
+	u64 end;
+
+	if (!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	if (check_add_overflow(addr, size, &end))
+		return -EINVAL;
+
+	if (tdx_accept_memory(addr, end))
+		return 0;
+
+	pr_err("Failed to accept memory [0x%llx, 0x%llx)\n",
+	       (unsigned long long)addr, (unsigned long long)end);
+
+	return -EINVAL;
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -359,6 +378,8 @@ static void tdx_setup(u64 *cc_mask)
 	disable_sept_ve(td_attr);
 
 	reduce_unnecessary_ve();
+
+	set_memory_post_plug_callback(tdx_memory_post_plug);
 }
 
 /*
-- 
2.52.0

