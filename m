Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCF376A0C;
	Tue, 23 Jun 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209892; cv=none; b=BAONT9zWvW+JG+rSpWSI1/FIGNTyj6LuNcT7PZy89Ep+QkxBgVDUrxV7xz/GEEeZFJSX7vWvZUQn79wLUs+wf6EzSTPMe+nygIc08CcqK+WBKG9ZWa00rBet/Qp9vq5NGX9EpBMsckj48SyjP/fk2REipK1NSjuL06UW7kr2axc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209892; c=relaxed/simple;
	bh=VP8QX7ge3/EwCAM61hiiB/gukjkCBrXZR3bLf5jkAxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNtqBzOtzMwTgVLmfGUqbbJs3IrXWFxLniZmRPROxIOvMGMq9XyNdtnXCjAvkJuN1r0RrHsogu+F0TggWkKnvER4UxTJlU/0pGk8W/HbmIQPzntOtbXz2h9L/PzktBuUFPVlXO0t287ZAVKlDBQT9dP22mQcnON46ahd9Xz+s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzCHZ6sI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzCHZ6sI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209889; x=1813745889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VP8QX7ge3/EwCAM61hiiB/gukjkCBrXZR3bLf5jkAxc=;
  b=KzCHZ6sIylRxzUevzWL64fiXGkjm1bC8VJ4NhyVRVDSzzc2l2aWBaulz
   14P3P8tIz98OH+XQQaRJQXk9GY3OcFUF1zxzhEXAS8FZqZnS6PBtDAl7C
   uGaFcCe23fnCyLlDZstA6m6DP00kkZ+/9sTwTdPKCNTwCl2ELvddZV6TP
   8twPIoDAdCCLQT4lLp7FW5cqEx/1ThnJO9VOrNodbtPls7st5JtxVjzFF
   GCJpVEW0oWLYKor/R9MIiYXChkYezxcbc5ZqFS+3RrmPcb2cVn48szBmZ
   i7/cn4Xy7dFxY3RAixOs0DpBVnIqzF0ZasypBOR0amImBaWDAVKFaOSP/
   A==;
X-CSE-ConnectionGUID: crHSxRVNTL61eT3e2oA8JQ==
X-CSE-MsgGUID: YXFaFaV/ReiZ9nPwQ73SeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717833"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:09 -0700
X-CSE-ConnectionGUID: VaG7Wx6YRU6TU67gF3surA==
X-CSE-MsgGUID: UGWkCa06S+ybWENalUlDag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339893"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:05 -0700
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
	michael.roth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFCv2 PATCH 4/6] x86/tdx: Implement arch_unaccept_memory()
Date: Tue, 23 Jun 2026 06:17:35 -0400
Message-ID: <20260623101739.79695-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623101739.79695-1-zhenzhong.duan@intel.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During memory hot-unplug, if the VMM does not punch hole the memory, the
memory stays in "accepted" state. Consequently, subsequent re-acceptance
of that same memory during a re-plug operation will trigger re-accept
failure. To guard this, a confidential guest must maintain control of
the memory state explicitly, e.g., setting memory to "unaccepted" state
during unplug.

In the context of TDX, the "unaccepted" state maps to the PENDING state,
while the "accepted" state maps to the MAPPED state. Implement
arch_unaccept_memory() for TDX guest via the TDG.MEM.PAGE.RELEASE TDCALL.
It uses 1G/2M/4K page size fallbacks and rolls back on partial failure. A
failure during this rollback step indicates severe corruption of the TDX
module state and triggers a kernel panic.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/include/asm/shared/tdx.h        |   2 +
 arch/x86/include/asm/tdx.h               |   2 +
 arch/x86/include/asm/unaccepted_memory.h |  11 +++
 arch/x86/coco/tdx/tdx.c                  | 120 +++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 049638e3da74..910ec1e57528 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -19,6 +19,7 @@
 #define TDG_MEM_PAGE_ACCEPT		6
 #define TDG_VM_RD			7
 #define TDG_VM_WR			8
+#define TDG_MEM_PAGE_RELEASE		30
 
 /* TDX TD attributes */
 #define TDX_TD_ATTR_DEBUG_BIT		0
@@ -54,6 +55,7 @@
 
 /* TDCS_CONFIG_FLAGS bits */
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
+#define TDCS_CONFIG_PAGE_RELEASE	BIT_ULL(6)
 
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE_BIT	0
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a149740b24e8..8608d33a7db6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,6 +72,8 @@ int tdx_mcall_extend_rtmr(u8 index, u8 *data);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+bool tdx_unaccept_memory(phys_addr_t start, phys_addr_t end);
+
 void __init tdx_dump_attributes(u64 td_attr);
 void __init tdx_dump_td_ctls(u64 td_ctls);
 
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f5937e9866ac..9fd9411d2c44 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -18,6 +18,17 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	}
 }
 
+static inline void arch_unaccept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/* Platform-specific memory-unacceptance call goes here */
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		if (!tdx_unaccept_memory(start, end))
+			panic("TDX: Failed to unaccept memory\n");
+	} else {
+		panic("Cannot unaccept memory: unknown platform\n");
+	}
+}
+
 static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
 {
 	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..1bab8f4687bf 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -326,6 +326,124 @@ static void reduce_unnecessary_ve(void)
 	enable_cpu_topology_enumeration();
 }
 
+static bool tdx_page_release_supported;
+
+static void tdx_detect_page_release_support(void)
+{
+	u64 config = 0;
+
+	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
+
+	tdx_page_release_supported = !!(config & TDCS_CONFIG_PAGE_RELEASE);
+}
+
+static unsigned long try_release_one(phys_addr_t start, unsigned long len,
+				     enum pg_level pg_level)
+{
+	unsigned long release_size = page_level_size(pg_level);
+	struct tdx_module_args args = {};
+	u8 page_size;
+	u64 ret;
+
+	if (!IS_ALIGNED(start, release_size))
+		return 0;
+
+	if (len < release_size)
+		return 0;
+
+	/*
+	 * Pass the page physical address to TDX module to release the
+	 * private page and to put it in PENDING state.
+	 *
+	 * Encode page size in RCX[2:0] using TDX_PS_*
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		page_size = TDX_PS_4K;
+		break;
+	case PG_LEVEL_2M:
+		page_size = TDX_PS_2M;
+		break;
+	case PG_LEVEL_1G:
+		page_size = TDX_PS_1G;
+		break;
+	default:
+		return 0;
+	}
+
+	args.rcx = start | page_size;
+	ret = __tdcall(TDG_MEM_PAGE_RELEASE, &args);
+	if (ret)
+		return 0;
+
+	return release_size;
+}
+
+static bool tdx_release_memory(phys_addr_t start, phys_addr_t end, phys_addr_t *cur)
+{
+	*cur = start;
+
+	while (*cur < end) {
+		unsigned long len = end - *cur;
+		unsigned long release_size;
+
+		/*
+		 * Try larger release first. It speeds up process by cutting
+		 * number of hypercalls (if successful).
+		 */
+
+		release_size = try_release_one(*cur, len, PG_LEVEL_1G);
+		if (!release_size)
+			release_size = try_release_one(*cur, len, PG_LEVEL_2M);
+		if (!release_size)
+			release_size = try_release_one(*cur, len, PG_LEVEL_4K);
+		if (!release_size)
+			return false;
+		*cur += release_size;
+	}
+
+	return true;
+}
+
+/**
+ * Release private memory and put it in PENDING state.
+ *
+ * @start: Physical start address of memory range to release
+ * @end:   Physical end address of memory range to release
+ *
+ * Uses TDG.MEM.PAGE.RELEASE TDCALL to transition private pages back to
+ * PENDING state. If PAGE_RELEASE is not supported by the TDX
+ * configuration, returns true (success) as no action is needed.
+ *
+ * On partial failure, automatically re-accepts any successfully released
+ * pages to restore consistent memory state. Re-acceptance failure is
+ * treated as a fatal error since it indicates severe TDX module issues.
+ *
+ * Returns: true on success, false on failure
+ */
+bool tdx_unaccept_memory(phys_addr_t start, phys_addr_t end)
+{
+	phys_addr_t released = start;
+	bool ret;
+
+	if (!tdx_page_release_supported)
+		return true;
+
+	ret = tdx_release_memory(start, end, &released);
+	if (!ret) {
+		pr_err("Failed to unaccept memory [%pa, %pa)\n", &start, &end);
+		/*
+		 * Re-accept any pages that were successfully released before
+		 * the failure occurred. This should never fail since we're
+		 * just restoring the previous MAPPED state.
+		 */
+		if (!tdx_accept_memory(start, released))
+			panic("%s: Failed to re-accept memory\n", __func__);
+	}
+
+	return ret;
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -359,6 +477,8 @@ static void tdx_setup(u64 *cc_mask)
 	disable_sept_ve(td_attr);
 
 	reduce_unnecessary_ve();
+
+	tdx_detect_page_release_support();
 }
 
 /*
-- 
2.52.0

