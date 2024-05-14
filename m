Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB65145344
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695512; cv=none; b=KeurRa1mg9itHtat8IZQzn5Oor5PqR03kaJNafwugmJ6aGuSuiAG0DZgfngwzhLOSaEUd8Aj1D8uy392sJyPUSFTTzr7WyTnHZv9Z9Z0B6iULX3QLP4/Y46mMGO6/ENOkGsurBVj2UEB/9Aq6IHnPz+EK5e7tHKiMS1fREGLYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695512; c=relaxed/simple;
	bh=oxMeKBSMHMQ7nR2cm5Yl3ZY7RY3tugjaWnxRJMQRo0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAQZ3b1tTqf7ZP1OCKuy/N6Zp3jdiTH67b1GiOUawGB3ueXUnM7wiXHIeyiM4sn0CIGlPeR7pvepFr6EkzUeITganZWa3Xchp/t16TwzVKsh4jbfVGL2t1y3rlgJ4JLMHqm106JxkbwnDKBewaiHFHlX00pCTcCbppUye6U/isE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYtSJeVM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYtSJeVM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 555CC403C7
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5s3ND8wxKdU for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6E416402E8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E416402E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rYtSJeVM
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E416402E8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 618796126D;
	Tue, 14 May 2024 14:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECB4C32781;
	Tue, 14 May 2024 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695509;
	bh=oxMeKBSMHMQ7nR2cm5Yl3ZY7RY3tugjaWnxRJMQRo0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYtSJeVMCifMMvCoAZTlKZARdYfjyGb+3HXKoeh+9gLb/UkaJfTd3fdRakqc0wiiH
	 xli61NfPUMpvvGx5MC2NpP4aFHaN7qIflyQLsdsGYfftEKuMMD4ZDdwSMxKUopldg2
	 epoHMB0A0f3xCqgRT8XnILBwq4c/Qcf+I9hdtDNmbMUoN6M+E4TfZeNPnRXQe7VCEi
	 mVVd21lXjUiNzuH2g3rQ4vZwbs8BiVsB38K+pOqnMbn3sV+WHj2eBwtH9deDcFJFka
	 VMVpGHW1o/zEaD/fzjuO4Rbeu3m9Kilyv7C53dWfpR7M8Aa7K8gCfy9ZFkXpBtkQwB
	 u0bIh5mMUxCRg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/8] riscv: mm: Pre-allocate vmemmap/direct map PGD entries
Date: Tue, 14 May 2024 16:04:39 +0200
Message-Id: <20240514140446.538622-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
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
index 2574f6a3b0e7..5b8cdfafb52a 100644
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

