Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483576057
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292139; cv=none; b=njujJMoIgIn+5d9+0BwkITmFKmKzTaq7Dq5Gn5C62hy2B8AgyDDeae/uhiZW3q0fPqPdH9ulVxX9mwIIbW3BXvEy0/mTAE+FCR40CMQE2o/4koATtz7x81mTlK+6MudGGI/NilC9Qd5Uzw7Xrx/06FsbO9zEnl4Y3/ozxXG1OfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292139; c=relaxed/simple;
	bh=nfJcShROxet1Zcs9SjZc/rXdynjgyC+wVMctU8YOdM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyPRxdL/uck4RzrA96FAdi5RfwpoVGP2bKAeaKeVTBZcVQDsp3DoAECAmp2WFd3E3cnHeuyCA5aVteLoRc+1LG5qcv1GXK6XGpIWJYN/ooch8KpV29Dp/cpfX+xEUUBajdK3nm27Knaz09lDE7+FeFLwJjigLf2GVrXcrCLXWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5nLepXe; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5nLepXe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3DAF80C41
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ssY7-3k2WBa9 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:48:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7546580BE7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7546580BE7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o5nLepXe
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7546580BE7
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A15556220F;
	Tue, 21 May 2024 11:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1475C4AF09;
	Tue, 21 May 2024 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292134;
	bh=nfJcShROxet1Zcs9SjZc/rXdynjgyC+wVMctU8YOdM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5nLepXejKU2VOMdC1SRZPZvOZANI4opdVRkd8+TPMDK5sR0P07NwX2ZJc79N4eQZ
	 bfaqTkEl6t3lFSwKwGIAvi6aKuwLCtjqA4R28DwMCONu+LBEGDp5huVkPzSrGGxpd3
	 eAcze83sdvqq0s5ijrEJlIMQhBoRLsPinLO1fb+pp/i5dnM4oCQdFZahjroxJU+tqs
	 ZfAsw+QYO295mUt8WJNF8A1EuNCBtYJdN32QaUsHu3K8cxyCjruvL8/XB8PAlIhEie
	 b/8oz9DQETq8tgzZZdrqszIj0S0PXOjWIcDgLIx3Il4t+3513huBPyuUBrwrHotznV
	 5JmJyHV48MBQA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/9] riscv: mm: Pre-allocate vmemmap/direct map PGD entries
Date: Tue, 21 May 2024 13:48:23 +0200
Message-Id: <20240521114830.841660-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
all userland page tables, which means that if the PGD level table is
changed, other page tables has to be updated as well.

Instead of having the PGD changes ripple out to all tables, the
synchronization can be avoided by pre-allocating the PGD entries/pages
at boot, avoiding the synchronization all together.

This is currently done for the bpf/modules, and vmalloc PGD regions.
Extend this scheme for the PGD regions touched by memory hotplugging.

Prepare the RISC-V port for memory hotplug by pre-allocate
vmemmap/direct map entries at the PGD level. This will roughly waste
~128 worth of 4K pages when memory hotplugging is enabled in the
kernel configuration.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kasan.h | 4 ++--
 arch/riscv/mm/init.c           | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index 0b85e363e778..e6a0071bdb56 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -6,8 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_KASAN
-
 /*
  * The following comment was copied from arm64:
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
@@ -34,6 +32,8 @@
  */
 #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
+
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
 void kasan_init(void);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b66f846e7634..c98010ede810 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -27,6 +27,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
+#include <asm/kasan.h>
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
 	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
 }
 
+#define PAGE_END KASAN_SHADOW_START
+
 void __init pgtable_cache_init(void)
 {
 	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
 	if (IS_ENABLED(CONFIG_MODULES))
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
+		preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");
+	}
 }
 #endif
-- 
2.40.1

