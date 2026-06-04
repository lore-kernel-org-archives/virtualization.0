Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E23DA7E1;
	Thu,  4 Jun 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565797; cv=none; b=q83F+0IwXLue2tg+Gz2JL/OrMXkGacCLJ+MPR2XV7b4UQCGdxBkNKkQlRSiqUD3oZ/gAASil06WpfT2gz9RCNJssiQGC6JvPgUdqofue8LAqCDREAxo0UFhmgGDiscSD5swDaZPdcyksb5c/v6wJ+N3VLu4n1HVUHfjagl/7lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565797; c=relaxed/simple;
	bh=W+ToqG9UJJgLyoMXwSHACk03TV9dob0lpMj9TjgGNFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cT1LqMwU31Ivva/aDp6YNPxIhCmCwhFhQYVkU7af6zK5i/kt1BxffzqV3BQrEzLFBerNwkOJEggVdU6Q7nxq/LPT2+5puzze7OkJi6nS/FIX97J8+99GbISQw1c+MuUbUYOsfSiAdsAEiDcljh/aFsDPwle0Vno3OcefRC1Qtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g76MlPG1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g76MlPG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565796; x=1812101796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+ToqG9UJJgLyoMXwSHACk03TV9dob0lpMj9TjgGNFU=;
  b=g76MlPG1ku9uxYNdIVI2SHPGfYIjuAuAGMAdtqNi70PXwk9ZiHctNxoK
   yN7qC/SAJw0RBmn5z+YN1SrUMQ3WlY2m8qxkV0MFjV0V985hULSCQlQaV
   zo2imHfKDxjGXDUOiF33aMcv0zfW+hlwrw+wBo9IBgQHBQQNFhUOw7VaE
   ywWSJ4nPC5/LiZFG2xyWmAvUi+XBStB3s/e3X9dkBJMTyh2PIdFaiHqaM
   yCBhzDrJSsRPnoC5VjWK4SD4I8I+Zmii3VHsxK3qwpp/Ah8lFbLw+KT3c
   S7SK0215J0k92CH2U6T9nE7PfT6W0BJShbWMi4LcUWX4lZ6y28MQ2oezV
   w==;
X-CSE-ConnectionGUID: hGNM+Tm1S9i25yTHKqkObA==
X-CSE-MsgGUID: /gjRmvtNQpCsbqER+8lOmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963765"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963765"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:36 -0700
X-CSE-ConnectionGUID: nl1W+94jQ7mTpPyjqyTB6A==
X-CSE-MsgGUID: sHIVbJWnQCmCM6dfC7CTTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037685"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:32 -0700
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
Subject: [RFC PATCH 5/6] x86/tdx: Register memory pre-unplug callback for TDX guests
Date: Thu,  4 Jun 2026 05:35:50 -0400
Message-ID: <20260604093551.1511079-6-zhenzhong.duan@intel.com>
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

Add support for releasing memory pages before unplugging in TDX guests.
When memory is about to be unplugged by virtio-mem or other memory
hotplug drivers, the TDX guest should release the memory pages back to the
hypervisor using TDG.MEM.PAGE.RELEASE TDCALL to be more robust for buggy
VMM behavior, e.g., VMM may do nothing for unplug request.

The implementation detects TDG.MEM.PAGE.RELEASE support and optimizes
release operations by trying larger page sizes 1G/2M before falling back
to 4K pages. If release fails, the function re-accepts any released pages
to maintain consistency. Without proper memory release, re-plugging memory
in TDX guests fails when guest accepts those memory because hypervisor can
do no-op to memory unplug request and memory is already in "accepted"
state.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 arch/x86/include/asm/shared/tdx.h |   2 +
 arch/x86/coco/tdx/tdx.c           | 135 ++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d93ba092d311..0abfb3505093 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -345,6 +345,139 @@ static int tdx_memory_post_plug(u64 addr, u64 size)
 	return -EINVAL;
 }
 
+static bool tdx_page_release_supported;
+
+static void detect_mem_page_release(void)
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
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
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
+static bool _tdx_release_memory(phys_addr_t start, phys_addr_t end, phys_addr_t *cur)
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
+/*
+ * Release memory pages back to the hypervisor in TDX guests.
+ *
+ * @start: Physical start address of memory range to release
+ * @end:   Physical end address of memory range to release
+ *
+ * Uses TDG.MEM.PAGE.RELEASE TDCALL to transition private pages back to
+ * pending state. If PAGE_RELEASE is not supported by the TDX
+ * configuration, returns true (success) as no action is needed.
+ *
+ * On partial failure, automatically re-accepts any successfully released
+ * pages to restore consistent memory state. Re-acceptance failure is
+ * treated as a fatal error since it indicates severe TDX module issues.
+ *
+ * Returns: true on success, false on failure
+ */
+static bool tdx_release_memory(phys_addr_t start, phys_addr_t end)
+{
+	phys_addr_t released = start;
+	bool ret;
+
+	if (!tdx_page_release_supported)
+		return true;
+
+	ret = _tdx_release_memory(start, end, &released);
+	if (!ret) {
+		pr_err("Failed to release memory [0x%llx, 0x%llx)\n",
+		       (unsigned long long)start, (unsigned long long)end);
+
+		/*
+		 * Re-accept any pages that were successfully released before
+		 * the failure occurred. This should never fail since we're
+		 * just restoring the previous accepted state.
+		 */
+		if (!tdx_accept_memory(start, released))
+			panic("%s Failed to re-accept memory\n", __func__);
+	}
+
+	return ret;
+}
+
+static int tdx_memory_pre_unplug(u64 addr, u64 size)
+{
+	u64 end;
+
+	if (!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	if (check_add_overflow(addr, size, &end))
+		return -EINVAL;
+
+	return tdx_release_memory(addr, end) ? 0 : -EINVAL;
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -380,6 +513,8 @@ static void tdx_setup(u64 *cc_mask)
 	reduce_unnecessary_ve();
 
 	set_memory_post_plug_callback(tdx_memory_post_plug);
+	detect_mem_page_release();
+	set_memory_pre_unplug_callback(tdx_memory_pre_unplug);
 }
 
 /*
-- 
2.52.0

