Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F2140380
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587689; cv=none; b=dijgKBmc57v0ydRs+O7nW9OHIH0f8+bIrrez2Imu0j7Z6XLmWaGX+TA/jpiRGjsXIZUoVQkCyVzxdhdZntD2MyAKDa8LHf1Ir4ivlM5AiNouhgxUJXIG9n1+G0mysdJghVEi5iV1plUCln7KBxq4sBEyfurNp7F6gxmrnMcomZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587689; c=relaxed/simple;
	bh=HsHTP5EMBxXRbP7gHM9U5cuEmdv/0OsepSBXxmcR9vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm5C+8geCFwas2/gIZb3Q8Etp1t1rOUz3iq+Wb3hQvm2iOuzSDfuwQuQk/JttEZv3K9TSY93FL5BCIZQHwbi94OMySoCKud3otLM0rPOduFjI8jCr7HU0eA3lnJnOpZPDn1OoCFjTTZ1D75o6OFEaeX+/031sL7YYHL9B2ont4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HATjXYku; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HATjXYku"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EADD414BD
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mplp0cnH9hfp for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC811414DE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC811414DE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HATjXYku
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC811414DE
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 83D64CE1784;
	Wed,  5 Jun 2024 11:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A38C32781;
	Wed,  5 Jun 2024 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587683;
	bh=HsHTP5EMBxXRbP7gHM9U5cuEmdv/0OsepSBXxmcR9vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HATjXYkuNGAJd6ZLv+T2v73tr+Mc6k2jRhJItwlkYIAMhhwWJcS9UAkccUyjIGocm
	 FpT5Qk21uUbdooqRUAgy0kZUw+P/J0vSaZ/BBxDRdx4Ux/+hf7kGQ9N5Qrv6wvPA7i
	 nDivxB55BW0xjUIvNRnHMGR086mp0iiVgd/1dXwNc6PCovq009SjJTw4oRIZcmWQYR
	 jCrbPH4Os670nJF5DH11/jvO5GP+uTC5v335/W5W7nBd01MhUwdEyweJtBVvSA7sad
	 ALF4qUwr8X3xtfo2/HtKrJcfrhAbSKFg21UaNds30Hdi0KwftR7UHoI+cd51TBVay7
	 nivI6FKPDR+hA==
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
Subject: [PATCH v4 02/11] riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
Date: Wed,  5 Jun 2024 13:40:45 +0200
Message-ID: <20240605114100.315918-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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
vmemmap/direct map/kasan entries at the PGD level. This will roughly
waste ~128 (plus 32 if KASAN is enabled) worth of 4K pages when memory
hotplugging is enabled in the kernel configuration.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kasan.h | 4 ++--
 arch/riscv/mm/init.c           | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index fe5072f66c8c..a5b3bc1f3b88 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,6 +28,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
+#include <asm/kasan.h>
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -1493,11 +1494,19 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
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
+		if (IS_ENABLED(CONFIG_KASAN))
+			preallocate_pgd_pages_range(KASAN_SHADOW_START, KASAN_SHADOW_END, "kasan");
+	}
 }
 #endif
 
-- 
2.43.0

