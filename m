Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2983890E2;
	Thu,  4 Jun 2026 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565784; cv=none; b=cJ1cG62CHPUW9L4PKL8czNseuqTwKPRUVXIMcYXDh8WI6bgMcTCPM1P8T3Upmhrxn457Dso62wU2fUIbzPNP3X6g7F19d9Qz1LlrEbp7hZL5h80IubfHfozO+UfdO+ZydtvVQe/sGFny9gBSaLc0NE2SL6xdHfncT7rENB3nAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565784; c=relaxed/simple;
	bh=AmkEnJafLBDe7NhPZmcM6s+NU/+tS7FpzAl5wSSvklU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz0iX0FOpsxo7TXUBVgINiwNSa4gIeakEpnHd6Izt0ZISsLDd9eJuLu0vZQZAITM50vN+4CVkPaj9TPkJcgV/+cYZPyZhRslhj9QkzzJOFw2435fzezTBgYKLLsAn7DfWWMWYWKYsdy1AAfMYRZiKE8qW5cA5LYheR61kiK4DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4uy6Pcb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4uy6Pcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565783; x=1812101783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmkEnJafLBDe7NhPZmcM6s+NU/+tS7FpzAl5wSSvklU=;
  b=f4uy6Pcb+35KC2faegecsvIzRVpm2p07AQB01WDd/NEdEnZSQWP/AK5k
   +dFjgt/Vzen0NOGbWTADZmeIPmyuWww2albyqNTRB4KOr/1wATi9abP5M
   gYomYbI7K7N1qf+pLHFZNeYPCLePlS9Fx5J6ZOUx0CHDvOResw5PQnypa
   GumICs4DeCEKlSTUAvDBZH9sgOrLRksGeCYtEzLySOPoOdp5HJwLfJCbn
   19O/rHiYxnP1ipMS1Fy48ddivRUljuGb9Id4/66KcmUBRVP2G7GuXuiT7
   +YyctgWPxofwMNGMEwTHPTr+cyVQnF/VD+JiFRQCY/T5x5Gm58DX46tER
   g==;
X-CSE-ConnectionGUID: QRj3xi8rSmCYjiWs116M8Q==
X-CSE-MsgGUID: jRpuYbj9SoaX+swvL20txw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963717"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963717"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:23 -0700
X-CSE-ConnectionGUID: 9RSrr9LcTs+8yn8RsiMjog==
X-CSE-MsgGUID: a31rwg1MTxmrHxaq9ISRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037587"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:19 -0700
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
Subject: [RFC PATCH 2/6] mm/memory_hotplug: Add memory pre-unplug callback infrastructure
Date: Thu,  4 Jun 2026 05:35:47 -0400
Message-ID: <20260604093551.1511079-3-zhenzhong.duan@intel.com>
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

In confidential computing environments like TDX, memory that was
previously accepted by the guest could be explicitly "released" back to
the hypervisor before it is unplugged, because hypervisor can do no-op
for the unplug operation without guest awares, then replug will fail
with re-accept error.

This callback infrastructure allows the TDX guest code to register a
handler that will be invoked after kernel removes memory from its memory
management subsystem but before it is unplugged, ensuring all memory
pages are properly released via TDG.MEM.PAGE.RELEASE TDCALL. Then re-plug
triggers TDG.MEM.PAGE.ACCEPT on pages in "unaccepted" state and succeed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 39f0a35a5112..5bb77670b6cf 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -29,6 +29,7 @@ enum mmop {
 };
 
 typedef int (*memory_post_plug_callback_t)(u64 addr, u64 size);
+typedef int (*memory_pre_unplug_callback_t)(u64 addr, u64 size);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
@@ -278,6 +279,9 @@ extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
 
+void set_memory_pre_unplug_callback(memory_pre_unplug_callback_t callback);
+int memory_pre_unplug_call(u64 addr, u64 size);
+
 #else
 static inline void try_offline_node(int nid) {}
 
@@ -293,6 +297,12 @@ static inline int remove_memory(u64 start, u64 size)
 }
 
 static inline void __remove_memory(u64 start, u64 size) {}
+
+static inline void set_memory_pre_unplug_callback(memory_pre_unplug_callback_t callback) {}
+static inline int memory_pre_unplug_call(u64 addr, u64 size)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 73054ed016fd..fcb6f85c40d0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2451,4 +2451,24 @@ int offline_and_remove_memory(u64 start, u64 size)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
+
+static memory_pre_unplug_callback_t memory_pre_unplug_callback __ro_after_init;
+
+void set_memory_pre_unplug_callback(memory_pre_unplug_callback_t callback)
+{
+	/* Fatal error to set callback twice in boot stage */
+	if (memory_pre_unplug_callback)
+		panic("memory_pre_unplug_callback is already registered\n");
+
+	memory_pre_unplug_callback = callback;
+}
+
+int memory_pre_unplug_call(u64 addr, u64 size)
+{
+	if (!memory_pre_unplug_callback)
+		return 0;
+
+	return (*memory_pre_unplug_callback)(addr, size);
+}
+EXPORT_SYMBOL_GPL(memory_pre_unplug_call);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.52.0

