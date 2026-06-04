Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9F38B7C4;
	Thu,  4 Jun 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565781; cv=none; b=aMHSs8eM4BuHUxfEp3TcA8pzr5DQjY4Y8DCQEURVJ0jeg3/hXx0q9aoJ+6VtAiibz8pJCPKMTFGO5WWmtMS+AaaVGKBCqAMVF7UCt2yhkudSdx7OGaxUmForqnllIr9a9/OxoSZUTfyGN6ctouJ80LvgXhJJFTBDsA3Ko8OCv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565781; c=relaxed/simple;
	bh=U0zddfQbL5lPFbIImB5VeCsmymbumc8vHA4oMmdAu9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp+EIxv6DAQnjkjbx4R5/p32t81+LZQUHp8WN7IsO16IJ4oyUs43aFHOIisalzT9NpZhOVhEMBK6RgGOYtjBWFuGu9GGZ8PLahtEmMhg2fLaTtU7efngo3+1BXRn98xn8cOfFoJSy2Jw0f1RP7hjZ2GXh55tnQPRYJt/acw1fzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRTT0KHx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRTT0KHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565779; x=1812101779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0zddfQbL5lPFbIImB5VeCsmymbumc8vHA4oMmdAu9Q=;
  b=KRTT0KHxWy5A07wrtHXftcWdwqQq9c+JbGtVMrBO3M2eBlxRPiS+Nb5G
   TmyOFIjtGoLr2ytIsr9T0AMCr816A7Dqz+/G7EUiDJQ809O4DMhK353A3
   g2U72adIk4+G//IWjF+5axYdppzhMxTB2tr4u6Fj80igoK1025F6FrZ+e
   xp5XWXD31M3O3ZfGZK0Q/bWAfl+inwpDHUPSGg+zNo9lJYIS3SEBX+2Yy
   FOQkykSR86hsAoITHBGBIUrQ8rljB7xiuFt2pxHJz14Mr9iHICJQqTkLZ
   xkkCvZOyd+FZs5V2BfJTTk+088N0GjLnaAJY/p8qrB86JC6ysPa5KUcI5
   Q==;
X-CSE-ConnectionGUID: cvmFtvXAR325LAOuTMh37w==
X-CSE-MsgGUID: hUfOyVSOTGmicwAbQyzYRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963710"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:19 -0700
X-CSE-ConnectionGUID: gTss0eFSQvmmPTlZJqiR5g==
X-CSE-MsgGUID: n9Wav+34ShinUNsUtmzqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037562"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:14 -0700
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
Subject: [RFC PATCH 1/6] mm/memory_hotplug: Add memory post-plug callback infrastructure
Date: Thu,  4 Jun 2026 05:35:46 -0400
Message-ID: <20260604093551.1511079-2-zhenzhong.duan@intel.com>
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

In confidential computing environments like TDX, newly added memory must be
explicitly "accepted" by the guest before it can be safely accessed. When
virtio-mem or other memory hotplug drivers add memory to a TDX guest, the
memory pages are initially in an "unaccepted" state. Accessing unaccepted
memory triggers VM exits and can cause guest crashes. The guest must call
TDX hypercalls to accept each page before use.

This callback infrastructure allows the TDX guest code to register a
handler that will be invoked after memory is plugged, ensuring all newly
added memory is properly accepted before being made available to the
kernel's memory management subsystem.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/linux/memory_hotplug.h | 11 +++++++++++
 mm/memory_hotplug.c            | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 815e908c4135..39f0a35a5112 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -28,6 +28,8 @@ enum mmop {
 	MMOP_ONLINE_MOVABLE,
 };
 
+typedef int (*memory_post_plug_callback_t)(u64 addr, u64 size);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
 
@@ -176,6 +178,9 @@ static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat)
 	mutex_init(&pgdat->kswapd_lock);
 }
 
+void set_memory_post_plug_callback(memory_post_plug_callback_t callback);
+int memory_post_plug_call(u64 addr, u64 size);
+
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 #define pfn_to_online_page(pfn)			\
 ({						\
@@ -221,6 +226,12 @@ static inline bool mhp_supports_memmap_on_memory(void)
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
+
+static inline void set_memory_post_plug_callback(memory_post_plug_callback_t callback) {}
+static inline int memory_post_plug_call(u64 addr, u64 size)
+{
+	return 0;
+}
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 40c7915dabe0..73054ed016fd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1729,6 +1729,26 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
 	return false;
 }
 
+static memory_post_plug_callback_t memory_post_plug_callback __ro_after_init;
+
+void set_memory_post_plug_callback(memory_post_plug_callback_t callback)
+{
+	/* Fatal error to set callback twice in boot stage */
+	if (memory_post_plug_callback)
+		panic("memory_post_plug_callback is already registered\n");
+
+	memory_post_plug_callback = callback;
+}
+
+int memory_post_plug_call(u64 addr, u64 size)
+{
+	if (!memory_post_plug_callback)
+		return 0;
+
+	return (*memory_post_plug_callback)(addr, size);
+}
+EXPORT_SYMBOL_GPL(memory_post_plug_call);
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * Scan pfn range [start,end) to find movable/migratable pages (LRU and
-- 
2.52.0

