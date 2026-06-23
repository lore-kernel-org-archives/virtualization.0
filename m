Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262F377ED2;
	Tue, 23 Jun 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209883; cv=none; b=FOggaWLmFdbNwmbVX+tIeZB/JZ0c4/wt77p0ReNkBTIzsmDRTvHCMt1fGh9sbluFnSVsgKLKWXN0jx3Nm+PArQzth5pCgd7sRbTN+G5/5Hk39LQTIDc/FuPtne3nW2hSEzd6o9v2MML9mn/jdjxPpH2NXEzUks0nyDtcP0VTVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209883; c=relaxed/simple;
	bh=H4zvvayqdMs7j1EEVBPlQMdCv+zXGkB3rSyoGAde8Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si+eKJJgdR7sDbG3sJ3xhNTZa3+u8ahzZeAdJjAqXcecRU1/TTbnIWWgQHu26GvU2ihnP6xnm8yxAkRFEBuhyJOOxt9cEb2GIc7xg4WkT4wOtpNToeVqjO/spO6sg636fEExQrfBmaq+Q5mn1+0N08SdoNlT1Hzuqfk0XfYO/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dpu9nVbl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dpu9nVbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209881; x=1813745881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H4zvvayqdMs7j1EEVBPlQMdCv+zXGkB3rSyoGAde8Dk=;
  b=Dpu9nVblxWZIckhEdypRZZ5S3UbsO6kYQB0LU2KjKP07/kzD+D266fDo
   LoVJv1+rUUKiVL0Hwexda5z9eeiw/roglg02TjGOXjc8t9Ak5x8lltpKQ
   6WuZ46Pqx/a+Wilxku1hkDR+HbIAcWSZN2xj5fE2GDIpoyntXTgxGRS7s
   aqvoTypwWFGFra0SgMJp+Y57Owcx+wAAYSY1L0R3HZ/4jwbJFW0wdbX9U
   IQLEf4QWF5laVS1mE6yOf49GxGqgPg5C7qVXgo9ECd4Ie+rF47Mu+BpO7
   BlXMOr+E4ZUmglwbNG1d1BJG59Dy0IGOg5qdNbhkrLa+/S0Uj5JrP6OA9
   Q==;
X-CSE-ConnectionGUID: B88aoR9qTvWHpYPsX1cdeA==
X-CSE-MsgGUID: 02CS/1+pTWSDllzwCjgi3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717797"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717797"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:18:01 -0700
X-CSE-ConnectionGUID: rGb4XWdoRk+PyjEgv0I/Fg==
X-CSE-MsgGUID: W9a+3f9YRRCrCRqMa22k8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339846"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:57 -0700
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
Subject: [RFCv2 PATCH 2/6] efi/unaccepted: Set unaccepted bits for all hotplug memory
Date: Tue, 23 Jun 2026 06:17:33 -0400
Message-ID: <20260623101739.79695-3-zhenzhong.duan@intel.com>
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

In coco guests, hotpluggable memory ranges are initially unaccepted.
While a previous change expanded the unaccepted memory bitmap boundaries
to include these hotplug spaces, the actual bits inside the bitmap are
not yet marked as unaccepted.

Walks SRAT a second time after the bitmap is allocated and sets the bits
corresponding to hotpluggable ranges.

This ensures the bitmap state accurately reflects all static and hotplug
memory ranges before booting kernel.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 .../firmware/efi/libstub/unaccepted_memory.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index bfbb78bd7b8a..01bed8e751ca 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -92,6 +92,23 @@ static void update_mem_boundaries(struct acpi_srat_mem_affinity *mem, struct sra
 		*(ctx->mem_end) = range_end;
 }
 
+static void mark_hotplug_memory_unaccepted(struct acpi_srat_mem_affinity *mem,
+					   struct srat_parse_ctx *ctx)
+{
+	u64 unit_size = unaccepted_table->unit_size;
+	u64 start, end;
+
+	start = round_up(mem->base_address, unit_size);
+	end = round_down(mem->base_address + mem->length, unit_size);
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted_table->phys_base;
+	end -= unaccepted_table->phys_base;
+
+	bitmap_set(unaccepted_table->bitmap,
+		   start / unit_size, (end - start) / unit_size);
+}
+
 efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map)
 {
@@ -169,6 +186,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 	unaccepted_table->phys_base = unaccepted_start;
 	unaccepted_table->size = bitmap_size;
 	memset(unaccepted_table->bitmap, 0, bitmap_size);
+	parse_acpi_srat_regions(mark_hotplug_memory_unaccepted, &ctx);
 
 	status = efi_bs_call(install_configuration_table,
 			     &unaccepted_table_guid, unaccepted_table);
-- 
2.52.0

