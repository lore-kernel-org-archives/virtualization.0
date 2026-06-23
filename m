Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C43749F0;
	Tue, 23 Jun 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209906; cv=none; b=rnScT8QJ91xO8EpCMvgOstFN3RsQW/QoQ1sHZoj+D1Y81YiXawby+dG+lLorXYwyxsW2CPvOZMRdyfY/64bY2bHMpQBUvoYaTmw5JI+xz7Li6Ix4MAqjwXWkfGQGA1PiC9Ko9N2wtYHGUazFHOL7s4BJb63+A1ek8n+WiWLO6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209906; c=relaxed/simple;
	bh=SKEWX9AxoyegkMDeYKqNUC2LV+o7lpagY0HCCrDXgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxGgmMu/lN9G9v8Gr2xytGTYWhZLkbuI5AsuKdWd0IYn/N9Qo0evXlA+jXSlq9Dq3O3sifPG5vUtPWDTzIdFY8Nte8p7Y5e4YPIvTQM2C7c3uWRCg55h9Uo6Fa+YfwG5qXB6Fuax2US6r1SGwxF+Q3YaYhzAOHgapv7BOx32j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXSAIk8e; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXSAIk8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209905; x=1813745905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKEWX9AxoyegkMDeYKqNUC2LV+o7lpagY0HCCrDXgFk=;
  b=mXSAIk8elU7DC8EXTIYb0c+rd1WTFJNf+fuLRP7tgFFjtsREXvr2Pvl0
   wP2BUa0NNMcEilSS2nmWYc93kVhBPE0/J/OATRo5FqrgJc7br5nVCQvlF
   fVk/9YSJoFweXeCAh8r6N7q18Rj5Nix/1zDVOki6e2DPAn2+TGyeKbI3G
   FHBa4A87ah1lGjxT/S25bFuTwSvZUYP74jiM7j6+N/8QHq+igaYvOFkDQ
   0s8Yq83kxBt9AGcpcqwl0WMfbfXBcfX83/KMusaURWWju87ZLe9SbeFKc
   fh8S6PSoWYgenWrpz5oMOWmj2SwR6xsBoe4VXneLF5tyzZq5pYqXOic8h
   Q==;
X-CSE-ConnectionGUID: MVxF2npXQ7+mLSv2t9xLRQ==
X-CSE-MsgGUID: rCMBIVxSTg+9MUC6xoajqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717844"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717844"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:13 -0700
X-CSE-ConnectionGUID: 9rL0Qj4sTTO8GJlPEZpi6Q==
X-CSE-MsgGUID: xXmAGH9nSUauUT3c+AVjsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339911"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:09 -0700
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
Subject: [RFCv2 PATCH 5/6] mm/memory_hotplug: Support ACPI hotplug/unplug for coco guest
Date: Tue, 23 Jun 2026 06:17:36 -0400
Message-ID: <20260623101739.79695-6-zhenzhong.duan@intel.com>
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

Integrate coco memory management operations into the core memory hotplug
subsystem to handle the lifecycle of hotplug memory.

In add_memory_resource(), invoke coco_set_plugged_bitmap(..., true) to mark
memory plugged before adding the memory block, because self hosted memmap
initialization needs their plugged bits set before acceptance. There is no
explicit call to accept_memory() for normal pages, because they can be
lazily accepted by the core memory management subsystem after the memory
block is onlined.

In try_remove_memory(), before finalizing the physical removal of the
memory blocks, invoke unaccept_memory(). This allows the guest to take
direct control of its own memory state and release the pages itself,
eliminating the dependency on the VMM to implicitly hole-punch the memory.
It loops through the targeted ranges using find_next_andnot_bit(), matching
pages that are marked plugged and accepted, and releases them back to the
host. Following the unacceptance step, clear the ranges from the plugged
bitmap.

These operations guarantee that both the unaccepted and plugged tracking
states stay completely synchronized with the actual dynamic memory
configurations of the guest.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/linux/mm.h                       | 11 +++
 drivers/firmware/efi/unaccepted_memory.c | 94 ++++++++++++++++++++++++
 mm/memory_hotplug.c                      | 16 ++++
 3 files changed, 121 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fc2acedf0b76..4c094038872a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5105,6 +5105,8 @@ int set_anon_vma_name(unsigned long addr, unsigned long size,
 
 bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
 void accept_memory(phys_addr_t start, unsigned long size);
+void unaccept_memory(phys_addr_t start, unsigned long size);
+int coco_set_plugged_bitmap(phys_addr_t start, unsigned long size, bool set);
 
 #else
 
@@ -5118,6 +5120,15 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
+static inline void unaccept_memory(phys_addr_t start, unsigned long size)
+{
+}
+
+static inline int coco_set_plugged_bitmap(phys_addr_t start, unsigned long size, bool set)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index c290b16c5142..f35f7016af53 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -233,6 +233,100 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 	return ret;
 }
 
+static int coco_hotplug_range_check(struct efi_unaccepted_memory *unaccepted,
+				    phys_addr_t start, unsigned long size)
+{
+	u64 unit_size = unaccepted->unit_size;
+	u64 phys_base = unaccepted->phys_base;
+	u64 phys_end = phys_base + unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	if (!IS_ALIGNED(start | size, unit_size))
+		return -EINVAL;
+
+	if (start < phys_base || start + size > phys_end)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Only used by hotplug memory, we don't unaccept static memory */
+void unaccept_memory(phys_addr_t start, unsigned long size)
+{
+	unsigned long range_start, range_end, bitmap_size, flags;
+	struct efi_unaccepted_memory *unaccepted;
+	void *plugged_bitmap;
+	u64 unit_size;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return;
+
+	if (WARN_ON(coco_hotplug_range_check(unaccepted, start, size)))
+		return;
+
+	unit_size = unaccepted->unit_size;
+	range_start = (start - unaccepted->phys_base) / unit_size;
+	bitmap_size = range_start + size / unit_size;
+	plugged_bitmap = plugged_bitmap_of(unaccepted);
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	for (; range_start < bitmap_size; range_start = range_end) {
+		unsigned long phys_start, phys_end;
+		unsigned long unaccepted_one, plugged_zero;
+
+		range_start = find_next_andnot_bit(plugged_bitmap, unaccepted->bitmap,
+						   bitmap_size, range_start);
+
+		if (range_start >= bitmap_size)
+			break;
+
+		unaccepted_one = find_next_bit(unaccepted->bitmap, bitmap_size, range_start);
+		plugged_zero = find_next_zero_bit(plugged_bitmap, bitmap_size, range_start);
+		range_end = min(unaccepted_one, plugged_zero);
+
+		phys_start = range_start * unit_size + unaccepted->phys_base;
+		phys_end = range_end * unit_size + unaccepted->phys_base;
+
+		arch_unaccept_memory(phys_start, phys_end);
+		bitmap_set(unaccepted->bitmap, range_start, range_end - range_start);
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+/*
+ * Only used by hotplug memory, plugged bits of static memory are handled
+ * in process_unaccepted_memory()
+ */
+int coco_set_plugged_bitmap(phys_addr_t start, unsigned long size, bool set)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, flags;
+	void *plugged_bitmap;
+	u64 unit_size;
+	int ret;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return 0;
+
+	ret = coco_hotplug_range_check(unaccepted, start, size);
+	if (ret)
+		return ret;
+
+	unit_size = unaccepted->unit_size;
+	range_start = (start - unaccepted->phys_base) / unit_size;
+	plugged_bitmap = plugged_bitmap_of(unaccepted);
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	if (set)
+		bitmap_set(plugged_bitmap, range_start, size / unit_size);
+	else
+		bitmap_clear(plugged_bitmap, range_start, size / unit_size);
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_VMCORE
 static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 						unsigned long pfn)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 40c7915dabe0..2f71514a0616 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1429,6 +1429,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		arch_remove_memory(cur_start, memblock_size, altmap);
 
+		unaccept_memory(cur_start, PFN_PHYS(altmap->free));
+
 		/* Verify that all vmemmap pages have actually been freed. */
 		WARN(altmap->alloc, "Altmap not fully unmapped");
 		kfree(altmap);
@@ -1459,9 +1461,13 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 			goto out;
 		}
 
+		/* Accept self hosted memmap array before access it */
+		accept_memory(cur_start, PFN_PHYS(mhp_altmap.free));
+
 		/* call arch's memory hotadd */
 		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
 		if (ret < 0) {
+			unaccept_memory(cur_start, PFN_PHYS(mhp_altmap.free));
 			kfree(params.altmap);
 			goto out;
 		}
@@ -1471,6 +1477,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 						  params.altmap, group);
 		if (ret) {
 			arch_remove_memory(cur_start, memblock_size, NULL);
+			unaccept_memory(cur_start, PFN_PHYS(mhp_altmap.free));
 			kfree(params.altmap);
 			goto out;
 		}
@@ -1540,6 +1547,10 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		new_node = true;
 	}
 
+	ret = coco_set_plugged_bitmap(start, size, true);
+	if (ret)
+		goto error_offline_node;
+
 	/*
 	 * Self hosted memmap array
 	 */
@@ -1584,6 +1595,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	return ret;
 error:
+	WARN_ON(coco_set_plugged_bitmap(start, size, false));
+error_offline_node:
 	if (new_node) {
 		node_set_offline(nid);
 		unregister_node(nid);
@@ -2282,6 +2295,9 @@ static int try_remove_memory(u64 start, u64 size)
 	if (nid != NUMA_NO_NODE)
 		try_offline_node(nid);
 
+	unaccept_memory(start, size);
+	WARN_ON(coco_set_plugged_bitmap(start, size, false));
+
 	mem_hotplug_done();
 	return 0;
 }
-- 
2.52.0

