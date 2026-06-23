Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A0377574;
	Tue, 23 Jun 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209886; cv=none; b=sgD+U2CnhwkWCsZWcXT8ooZHzzBdSUbrQTbSezu49rsIn7Yxa7cMthNjsluviqemtWBaFZreDdBp0CrrffWxOvs1ZGB1D60I/K1n4RV5k35gqBifx/TZlxyt7WIb13GbEDdDBM/ZrjpOyKWO990S7+5Ad0sdZQM0W4uOVMs2ZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209886; c=relaxed/simple;
	bh=2XtHX+S9SU1hEUP3vxFUF/mP71ZqMeYwBGDFpaS3Enk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6knp4m2Q0rjd43h2/WUCpB8+zb4f/FMqpxqUrZzdJBNqTWwmNm8mQebcdx2KjWJkBBQSaUh92ijpMMOS5lQrcZ3lLhh6VQE1UTC6imrqKOF++s7kBD6mXGiDpZsh82cWaT/KIi2iU/VD6uNhUTUxNT5CKQLsK3ob7a/QtaQnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1xBwJas; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1xBwJas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209885; x=1813745885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XtHX+S9SU1hEUP3vxFUF/mP71ZqMeYwBGDFpaS3Enk=;
  b=F1xBwJaspmNHejNqGh2XnveY1qWMiHyE/48lPWTTsAQWUwSOjX2tt+SV
   BIcHNj10sf9DydyYownAjYXUGHESDmEK1gF1QMs8vxnzQ18MTa2sy7bw0
   2kYkukIsKWP4j0Oagn6FexcbvUc5ijgVPSKkv6bKdfKzsbeLeDqG716iR
   wAFP/4jU4sS0dZ0PY14enae1GksZxkLYBN8xqAGAi3Iy3K/bGx42T/WM0
   1ltK0b9njZ7kcvZtgwvBE2//mCpiyU7zKcCPEnh3TOvFu3Ph/Vy25XQOE
   qWAzG3gafRtcJFElXrnj13P83MyD8W5ArNs2HPJBjFtoOZAWzYrMBj25N
   w==;
X-CSE-ConnectionGUID: TMuEi8yBSIO7iEO0eLY/mg==
X-CSE-MsgGUID: dcSeWmSgRgu6y568ffEm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717810"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717810"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:05 -0700
X-CSE-ConnectionGUID: z/jjyrZaTDq9130SYYxn3Q==
X-CSE-MsgGUID: kb+XZ2zwSXylcUfOT6kdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339869"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:01 -0700
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
Subject: [RFCv2 PATCH 3/6] efi/unaccepted: Create plugged bitmap to support hotplug memory in coco guest
Date: Tue, 23 Jun 2026 06:17:34 -0400
Message-ID: <20260623101739.79695-4-zhenzhong.duan@intel.com>
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

The load_unaligned_zeropad() function can cause unintended memory loads
across page boundaries. To safely handle these unaligned reads in a
confidential computing guest, the kernel implicitly accepts an extra
unit_size block of memory to serve as a safety guard.

However, near hotplug boundaries, this extra acceptance can fall within
unpopulated gaps between hotplugged memory ranges, triggering a guest
kernel crash.

To protect these boundaries against out-of-bounds access, introduce a
"plugged" bitmap positioned immediately following the unaccepted memory
bitmap.

Initial static boot memory ranges have their corresponding bits marked
as plugged by default during early initialization. For hotpluggable
memory ranges, the memory driver must explicitly set the proper bits
when a memory block is plugged, and clear them upon an unplug event.

Update accept_memory() and range_contains_unaccepted_memory() to check
the intersection of both bitmaps. The kernel now combines them to
determine exactly which plugged, unaccepted pages require acceptance.

Additionally, bump the unaccepted memory table layout version from 1
to 2. This strict layout enforcement guarantees that a version 1 table
passed to a new kernel, or a version 2 table passed to an old kernel,
will explicitly fail kexec early due to the version mismatch.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/linux/efi.h                           |  5 ++++
 arch/x86/boot/compressed/mem.c                |  2 +-
 drivers/firmware/efi/efi.c                    |  4 +--
 .../firmware/efi/libstub/unaccepted_memory.c  | 16 +++++++----
 drivers/firmware/efi/unaccepted_memory.c      | 28 +++++++++++++++----
 5 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccbc35479684..579d102f128a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -551,6 +551,11 @@ struct efi_unaccepted_memory {
 	unsigned long bitmap[];
 };
 
+static inline void *plugged_bitmap_of(struct efi_unaccepted_memory *u)
+{
+	return (void *)u->bitmap + u->size;
+}
+
 /*
  * Architecture independent structure for describing a memory map for the
  * benefit of efi_memmap_init_early(), and for passing context between
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 40e9c81a2206..61b8d0edd2f6 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -69,7 +69,7 @@ bool init_unaccepted_memory(void)
 	if (!table)
 		return false;
 
-	if (table->version != 1)
+	if (table->version != 2)
 		error("Unknown version of unaccepted memory table\n");
 
 	/*
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 318d1cc9a066..7f7341634c13 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -701,7 +701,7 @@ static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
 	phys_addr_t start, end;
 
 	start = PAGE_ALIGN_DOWN(efi.unaccepted);
-	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size);
+	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size * 2);
 
 	memblock_add(start, end - start);
 	memblock_reserve(start, end - start);
@@ -837,7 +837,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
 		if (unaccepted) {
 
-			if (unaccepted->version == 1) {
+			if (unaccepted->version == 2) {
 				reserve_unaccepted(unaccepted);
 			} else {
 				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 01bed8e751ca..5b0deb6c91f1 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -113,7 +113,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map)
 {
 	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
-	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
+	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size, total_size;
 	struct srat_parse_ctx ctx;
 	efi_status_t status;
 	int i;
@@ -124,7 +124,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 	/* Check if the table is already installed */
 	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
 	if (unaccepted_table) {
-		if (unaccepted_table->version != 1) {
+		if (unaccepted_table->version != 2) {
 			efi_err("Unknown version of unaccepted memory table\n");
 			return EFI_UNSUPPORTED;
 		}
@@ -173,19 +173,22 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
 				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
 
+	/* There is a plugged bitmap after unaccepted bitmap */
+	total_size = bitmap_size << 1;
+
 	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*unaccepted_table) + bitmap_size,
+			     sizeof(*unaccepted_table) + total_size,
 			     (void **)&unaccepted_table);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to allocate unaccepted memory config table\n");
 		return status;
 	}
 
-	unaccepted_table->version = 1;
+	unaccepted_table->version = 2;
 	unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
 	unaccepted_table->phys_base = unaccepted_start;
 	unaccepted_table->size = bitmap_size;
-	memset(unaccepted_table->bitmap, 0, bitmap_size);
+	memset(unaccepted_table->bitmap, 0, total_size);
 	parse_acpi_srat_regions(mark_hotplug_memory_unaccepted, &ctx);
 
 	status = efi_bs_call(install_configuration_table,
@@ -287,6 +290,9 @@ void process_unaccepted_memory(u64 start, u64 end)
 	 */
 	bitmap_set(unaccepted_table->bitmap,
 		   start / unit_size, (end - start) / unit_size);
+	/* Set plugged bits for static memory and never unset */
+	bitmap_set(plugged_bitmap_of(unaccepted_table),
+		   start / unit_size, (end - start) / unit_size);
 }
 
 void accept_memory(phys_addr_t start, unsigned long size)
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 4a8ec8d6a571..c290b16c5142 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -38,6 +38,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	unsigned long flags;
 	phys_addr_t end;
 	u64 unit_size;
+	void *plugged_bitmap;
 
 	unaccepted = efi_get_unaccepted_table();
 	if (!unaccepted)
@@ -126,12 +127,23 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	 */
 	list_add(&range.list, &accepting_list);
 
-	range_start = range.start;
-	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
-				   range.end) {
+	plugged_bitmap = plugged_bitmap_of(unaccepted);
+
+	for (range_start = range.start; range_start < range.end; range_start = range_end) {
 		unsigned long phys_start, phys_end;
-		unsigned long len = range_end - range_start;
+		unsigned long len;
+		unsigned long unaccepted_zero, plugged_zero;
+
+		range_start = find_next_and_bit(plugged_bitmap, unaccepted->bitmap,
+						range.end, range_start);
+
+		if (range_start >= range.end)
+			break;
 
+		unaccepted_zero = find_next_zero_bit(unaccepted->bitmap, range.end, range_start);
+		plugged_zero = find_next_zero_bit(plugged_bitmap, range.end, range_start);
+		range_end = min(unaccepted_zero, plugged_zero);
+		len = range_end - range_start;
 		phys_start = range_start * unit_size + unaccepted->phys_base;
 		phys_end = range_end * unit_size + unaccepted->phys_base;
 
@@ -167,6 +179,7 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 	bool ret = false;
 	phys_addr_t end;
 	u64 unit_size;
+	void *plugged_bitmap;
 
 	unaccepted = efi_get_unaccepted_table();
 	if (!unaccepted)
@@ -201,9 +214,14 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
 		end = unaccepted->size * unit_size * BITS_PER_BYTE;
 
+	plugged_bitmap = plugged_bitmap_of(unaccepted);
+
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	while (start < end) {
-		if (test_bit(start / unit_size, unaccepted->bitmap)) {
+		unsigned long range_start = start / unit_size;
+
+		if (test_bit(range_start, plugged_bitmap) &&
+		    test_bit(range_start, unaccepted->bitmap)) {
 			ret = true;
 			break;
 		}
-- 
2.52.0

