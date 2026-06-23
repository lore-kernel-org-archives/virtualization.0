Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE867376A13;
	Tue, 23 Jun 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209878; cv=none; b=F8H8YONYnI2kvPfLLnOtezHFfh/E1rYWEs4C5I3Y9w+2N7hPtQIkruxOEnJBbCF66wjgKGHPfMj2cz+hzPJ5mJxEPCOXNOqMGUaF/6oDCZ6Nr7TzfVHfrHFwAz25FSHYnMndzLfS41Dl8H17n1Wb+jgH0cKwyAP98zR3bXoyz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209878; c=relaxed/simple;
	bh=JoYMYcCpzgcjM5815/JHfr+12VL/0O/XgmkMrEXdtqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbBzte5yc/HORPrZSuyr/zlqe/DIMAqsanlZQnHnt8FohUrVWT5z+XrkJfj9+SnJ+AMTDw11p5n7tEhGyQTntZqlrFUYgFlPC5Oekd/QTAkxEGQoMC+6f/ojBmRXa2W8xUQ2Mn5GR92StPAScnHjGOzHUkc3aV6gVJ5qV2o8CHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLv2RnZ1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLv2RnZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209877; x=1813745877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JoYMYcCpzgcjM5815/JHfr+12VL/0O/XgmkMrEXdtqM=;
  b=lLv2RnZ1m9BrmyQeUGf0dZlbSo4b+Ug6XDgW16/ImS71v2u8Y+fNwjwO
   KU1gb5PzveK+q4WWq5qJy4hXtXBqxzO/DfoNXLv8oW54EKBnfDTg/Mwpf
   pHPkpuLvAM7SkwnZ5gyr+sMDwhwIkPREyscfCxIejELfFWlRtzg0oLl1d
   2NHA8MwZ5wyveI0+KQKcXjwPyt+3kXNVsi7ykH3N/7wPHjkD629vPICOF
   Vyp0y+/pMUS0PRUfzlTohqsuwkJScncMUj8jEMc4gi9F1aeQUejMNLQD8
   3MTz5Ar3659rp4fie+XQkw9QZ7Xn8eZ7ozla7mH+NH5YO7PFZSq7wnG44
   w==;
X-CSE-ConnectionGUID: 15Hk7XkUTraRvd1riyd7Qw==
X-CSE-MsgGUID: bzewHs7OSnan+ziUuD/W2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717783"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717783"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:57 -0700
X-CSE-ConnectionGUID: hydYAh7eSQ2ShHmCHuYr8g==
X-CSE-MsgGUID: khMUlQEfTMafqKaY7Y4xHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339827"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:52 -0700
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
Subject: [RFCv2 PATCH 1/6] efi/unaccepted: Support hotplug memory in unaccepted bitmap via SRAT
Date: Tue, 23 Jun 2026 06:17:32 -0400
Message-ID: <20260623101739.79695-2-zhenzhong.duan@intel.com>
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

Currently, allocate_unaccepted_bitmap() only scans the initial EFI
boot memory map. This misses hotpluggable ranges described in the
ACPI SRAT. Without early tracking, hotplug pages are accessed without
acceptance and this triggers guest crash.

Introduce a lightweight ACPI SRAT parser to scan these regions early.
If a region has both ACPI_SRAT_MEM_ENABLED and ACPI_SRAT_MEM_HOT_PLUGGABLE
flags, expand the tracking boundaries. This avoids pulling in the full
ACPI subsystem while ensuring the bitmap covers both static memory and
hotplug memory.

Bail out early with success on non-confidential guests to prevent
unnecessary bitmap allocation.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/firmware/efi/libstub/efistub.h        |  6 ++
 arch/x86/boot/compressed/mem.c                |  2 +-
 .../firmware/efi/libstub/unaccepted_memory.c  | 94 +++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index fd91fc15ec81..fc0cd33a5962 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1260,4 +1260,10 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
 efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
 
+bool early_is_tdx_guest(void);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+bool early_is_sevsnp_guest(void);
+#else
+static inline bool early_is_sevsnp_guest(void) { return false; }
+#endif
 #endif
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 0e9f84ab4bdc..40e9c81a2206 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -12,7 +12,7 @@
  *
  * Enumerate TDX directly from the early users.
  */
-static bool early_is_tdx_guest(void)
+bool early_is_tdx_guest(void)
 {
 	static bool once;
 	static bool is_tdx;
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 757dbe734a47..bfbb78bd7b8a 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -1,19 +1,109 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/efi.h>
+#include <linux/acpi.h>
 #include <asm/efi.h>
 #include "efistub.h"
 
 struct efi_unaccepted_memory *unaccepted_table;
 
+struct srat_parse_ctx {
+	u64 *mem_start;
+	u64 *mem_end;
+};
+
+typedef void (*srat_region_handler_t)(struct acpi_srat_mem_affinity *mem,
+				      struct srat_parse_ctx *ctx);
+
+/*
+ * parse_acpi_srat_regions - Loop through ACPI SRAT tables to process
+ * hotpluggable memory regions via a custom callback handler.
+ */
+static void parse_acpi_srat_regions(srat_region_handler_t handler, struct srat_parse_ctx *ctx)
+{
+	u32 hotplug_mask = ACPI_SRAT_MEM_ENABLED | ACPI_SRAT_MEM_HOT_PLUGGABLE;
+	struct acpi_table_header *xsdt, *srat = NULL;
+	struct acpi_table_rsdp *rsdp = NULL;
+	u8 *current_ptr, *end_ptr;
+	u64 *table_pointers;
+	u32 entry_count;
+	unsigned long i;
+
+	rsdp = get_efi_config_table(ACPI_20_TABLE_GUID);
+
+	if (!rsdp || !ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+		return;
+
+	xsdt = (struct acpi_table_header *)(unsigned long)rsdp->xsdt_physical_address;
+	if (!xsdt || !ACPI_COMPARE_NAMESEG(xsdt->signature, ACPI_SIG_XSDT))
+		return;
+
+	if (xsdt->length < sizeof(struct acpi_table_header) + ACPI_XSDT_ENTRY_SIZE)
+		return;
+
+	entry_count = (xsdt->length - sizeof(struct acpi_table_header)) / ACPI_XSDT_ENTRY_SIZE;
+	table_pointers = (u64 *)((u8 *)xsdt + sizeof(struct acpi_table_header));
+
+	for (i = 0; i < entry_count; i++) {
+		struct acpi_table_header *tbl;
+
+		tbl = (struct acpi_table_header *)(unsigned long)table_pointers[i];
+		if (tbl && ACPI_COMPARE_NAMESEG(tbl->signature, ACPI_SIG_SRAT)) {
+			srat = tbl;
+			break;
+		}
+	}
+
+	if (!srat)
+		return;
+
+	current_ptr = (u8 *)srat + sizeof(struct acpi_table_srat);
+	end_ptr = (u8 *)srat + srat->length;
+
+	while (current_ptr < end_ptr) {
+		struct acpi_subtable_header *sub_header;
+		u64 range_end;
+
+		sub_header = (struct acpi_subtable_header *)current_ptr;
+		if (sub_header->length == 0)
+			break;
+
+		if (sub_header->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY &&
+		    sub_header->length >= sizeof(struct acpi_srat_mem_affinity)) {
+			struct acpi_srat_mem_affinity *mem;
+
+			mem = (struct acpi_srat_mem_affinity *)current_ptr;
+			if ((mem->flags & hotplug_mask) == hotplug_mask &&
+			    !check_add_overflow(mem->base_address, mem->length, &range_end))
+				handler(mem, ctx);
+		}
+		current_ptr += sub_header->length;
+	}
+}
+
+static void update_mem_boundaries(struct acpi_srat_mem_affinity *mem, struct srat_parse_ctx *ctx)
+{
+	u64 range_end = mem->base_address + mem->length;
+
+	if (mem->base_address < *(ctx->mem_start))
+		*(ctx->mem_start) = mem->base_address;
+
+	if (range_end > *(ctx->mem_end))
+		*(ctx->mem_end) = range_end;
+}
+
 efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map)
 {
 	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
 	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
+	struct srat_parse_ctx ctx;
 	efi_status_t status;
 	int i;
 
+	if (!early_is_tdx_guest() && !early_is_sevsnp_guest())
+		return EFI_SUCCESS;
+
 	/* Check if the table is already installed */
 	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
 	if (unaccepted_table) {
@@ -38,6 +128,10 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 				     d->phys_addr + d->num_pages * PAGE_SIZE);
 	}
 
+	ctx.mem_start = &unaccepted_start;
+	ctx.mem_end = &unaccepted_end;
+	parse_acpi_srat_regions(update_mem_boundaries, &ctx);
+
 	if (unaccepted_start == ULLONG_MAX)
 		return EFI_SUCCESS;
 
-- 
2.52.0

