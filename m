Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0838A733
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654613; cv=none; b=VIED+WV/gB1pvWU5w3tMf5hdpzKGB9XpkMSvjWl9RYo+PebACaekgehN06REPo2z/lwM6sPHmLy1AiLCxG16jj+3OjWeNbujUvkOY7YClfPSj0+i97/XreuF5nSwYT1DI0RI0OIzw5HIDPYh1dwsKwv+sYXX6rZPQFwHThvR/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654613; c=relaxed/simple;
	bh=hX3+I2l4g4gGBI7+Ch5YSUvuVd6yStdKXgzA8mhRgZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4xd0EYrINSNSBsBqrjYD2nQhCFNx6D+kKiH5b1vMLs71q88XQMisKKSmkRQBqiKyoD8mYrW0QWeVDAUYxLr68hTXBAtn72VKNEQPpZUdafhdXtSDW0xdzIaTvAaNoig0GY2/2NMd8bZlkgPib2QV6G/zMV0ltPvL7Rts15hZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PAXJ5Q9p; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PAXJ5Q9p"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc758830601so1000691a12.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654609; x=1791259409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLpMQWp4oIwCSrdCkDjUFbSbG4amFgJT1I1bhegO2zs=;
        b=T1WTKLN2JHI8SnPYW3TVaI48gPmiWA+7BeEdtsNZf0XCdqVShkj0wt8F7cyxv8mlzS
         GEgYtOqVEDRKcBAPqqSZnTwFA2OkIsVki2paZIV1XEFr6z4gkXOWlSkAyWdbpUqXUBO2
         uMoK4Fpgbdid8MSUqRXbQcZbLb43mA8hVGcB5d2ngPr9bEan6oyEo9T/Zm1FXYRkA3PJ
         lSPaDW8dWeE8Dgh3Ogu1FxijCsAaCbvwrVwH4W9cHTmyt2wrqdjZEuhfoAi0tJg9Exr7
         tSeJlV3Fpq79WFvb/AbtFUEZpE5qJ2RqhxGjed61nIrvYRCDnyY5SoRPFuoEvogVGzRh
         SB4g==
X-Forwarded-Encrypted: i=1; AKwUvBxengq/LgHyNeGw7uDez6oWyiP/NZZMg+gmmmljNRfdnwl0/BzhsYYP3wzmbfGMcyJOvPdHnklm+pi1A8nEaw==@lists.linux.dev
X-Gm-Message-State: AFuF++kERdYGrtlO2iELZzLtlMZHsdTJDDKgNGvta0j6KlpSvspowhG/
	Wa36u8VLlsu3iuUu2LzLlTO/Sjr7fmhm5TnKDaikdLu/OWSzYxW/R326QbS288075bkXWRczXA6
	JuKcrxoemP8+UWdej6FICamLF7XUMpNliaZk848m9vsVqbLcFrIpf2cBLCMPw6kOn5i3EFST4xp
	hU2pMy6AnWoRj8D49zdhSnTsFCCCcm7oraCWvK2zFirsiMRmy+1nOcP60pkM6BKfHmfx1TBVmIg
	3m2vtGPoMCksNEtneE=
X-Gm-Gg: AYBFou3QLptBk8roMNppbDmv/g0AfEtCDubhWfTXirtLazQS5lVuTB03yzcjhabwptF
	5sDI0Jf4p9XIOu6EvZTSwBKTwHro9QV/TMj9ejMdTkDtKA6Ts32YDyUauPy68BSiPCUEPVa+R1p
	obzrS55VGHFbGcHSfy4HL0F0PrpN25a/klEkIt++KBLcK+mR7r3NN0u1qzOqU8QubLF+7NOyyu1
	+O3eq3QkUflbZjgHIiK+LxKQAX0aD5QXihNhuBgLOWalOe8mQJJA07Wzb0NsDnPN1BRTUaWOjO2
	f6x4KZilWlsopPl9i1vSZaPOjcxHapG7RXAJ9SBoirDvkZQUjOh+z5WTqasTkEy6XWOnUiQK7JT
	geK3LicO7Asdy9Uo3HNHve0Q30FVTYfBLUeHauMcgOQ5HH5ZdAbKecmdUMU07zIkJ1s1OKYWfa/
	EuXRNs0n/MLH1QfNYh5WEjh1OLjw1ov998
X-Received: by 2002:a05:6a20:6a1d:b0:3de:4662:16f3 with SMTP id adf61e73a8af0-3de466270a8mr7017919637.50.1790654609214;
        Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc787760a08sm7703846a12.5.2026.09.28.21.03.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so1487907eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654607; x=1791259407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLpMQWp4oIwCSrdCkDjUFbSbG4amFgJT1I1bhegO2zs=;
        b=PAXJ5Q9pjmEsRYMLZopmLzH1eJWgE8fGOgiCSt4sQnVWsJO1pH59NFQuQmSunaW4g/
         zOlWv5IF28gVhDTwH3Pltjur6b9BahSzrgakY2tkh9pFi1ngmaatNgyz/DajKUOG0lQz
         zRkYwa+GoDy6YSSbPBLJ7i9J6PHLsdLjv1gdE=
X-Forwarded-Encrypted: i=1; AKwUvBzaivFOFX6WvPEtFnPAEvWufB67GoTQ16yxmgJ2+xE3XeE6r46fOMQTidlN9wodjTzHncPFu38cQNT80GA1qA==@lists.linux.dev
X-Received: by 2002:a05:7301:152a:b0:339:7c91:21f4 with SMTP id 5a478bee46e88-34273252770mr13517022eec.34.1790654607109;
        Mon, 28 Sep 2026 21:03:27 -0700 (PDT)
X-Received: by 2002:a05:7301:152a:b0:339:7c91:21f4 with SMTP id 5a478bee46e88-34273252770mr13516961eec.34.1790654606151;
        Mon, 28 Sep 2026 21:03:26 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:24 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 4/6] x86/mm: Provide common early memory decryption
Date: Tue, 29 Sep 2026 00:02:53 -0400
Message-ID: <20260929040256.543767-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Static per-CPU buffers must be shared before the page allocator is ready.
Provide a page conversion callback with common early page-table splitting,
including the kernel-image alias used by UP data. Flush large translations
before changing attributes and retain the AMD content and SNP transitions.
Drop UP image aliases before SNP kexec makes the backing pages private.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/coco/sev/core.c           |  16 +++++
 arch/x86/include/asm/mem_encrypt.h |   7 ++-
 arch/x86/include/asm/x86_init.h    |   2 +
 arch/x86/mm/mem_encrypt.c          | 117 +++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c      |  12 +++-
 5 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index cc292d7c6fd1..bc1afa366c33 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -541,6 +541,10 @@ static void set_pte_enc(pte_t *kpte, int level, void *va)
 	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 }
 
+#ifndef CONFIG_SMP
+extern char __start_percpu_decrypted[], __end_percpu_decrypted[];
+#endif
+
 static void unshare_all_memory(void)
 {
 	unsigned long addr, end, size, ghcb;
@@ -550,6 +554,18 @@ static void unshare_all_memory(void)
 	pte_t *pte;
 	int cpu;
 
+#ifndef CONFIG_SMP
+	/* Drop image aliases before the direct-map walk makes pages private. */
+	addr = (unsigned long)__start_percpu_decrypted;
+	end = (unsigned long)__end_percpu_decrypted;
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (pte && pte_decrypted(*pte))
+			set_pte(pte, __pte(0));
+	}
+	__flush_tlb_all();
+#endif
+
 	/* Unshare the direct mapping. */
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index ea6494628cb0..4d81f693b1d3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -21,9 +21,13 @@ struct boot_params;
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
 void __init mem_encrypt_setup_arch(void);
+int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
+void __init early_set_page_decrypted(unsigned long addr, unsigned long alias);
 #else
 static inline void mem_encrypt_init(void) { }
 static inline void __init mem_encrypt_setup_arch(void) { }
+static inline int __init
+early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -50,7 +54,6 @@ void __init sme_early_init(void);
 void sme_encrypt_kernel(struct boot_params *bp);
 void sme_enable(struct boot_params *bp);
 
-int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr,
 					    unsigned long size, bool enc);
@@ -86,8 +89,6 @@ static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
 
-static inline int __init
-early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 static inline void __init
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 953d3199408a..e4131402c783 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -75,9 +75,11 @@ struct x86_init_oem {
  *			the kernel pagetables and prepare accessors functions.
  *			Callback must call paging_init(). Called once after the
  *			direct mapping for phys memory is available.
+ * @early_decrypt_page:	Share a direct-mapped page and its optional image alias
  */
 struct x86_init_paging {
 	void (*pagetable_init)(void);
+	int (*early_decrypt_page)(unsigned long addr, unsigned long alias);
 };
 
 /**
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 3aefdef5bcb0..c3e239a47b66 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -12,10 +12,127 @@
 #include <linux/swiotlb.h>
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
+#include <linux/pgalloc.h>
 #include <linux/virtio_anchor.h>
 #include <linux/iommu-dma.h>
 
+#include <asm/sections.h>
+#include <asm/set_memory.h>
 #include <asm/sev.h>
+#include <asm/tlbflush.h>
+#include <asm/x86_init.h>
+
+#include "mm_internal.h"
+
+static pte_t * __init early_lookup_pte(unsigned long addr)
+{
+	unsigned long pfn, step;
+	unsigned int level, i;
+	pgprot_t prot;
+	pte_t *pte, *table;
+
+	for (;;) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_present(*pte))
+			return NULL;
+		if (level == PG_LEVEL_4K)
+			return pte;
+
+		if (level == PG_LEVEL_2M) {
+			pfn = pmd_pfn(*(pmd_t *)pte);
+			prot = pgprot_large_2_4k(pmd_pgprot(*(pmd_t *)pte));
+			step = 1;
+		} else if (level == PG_LEVEL_1G) {
+			pfn = pud_pfn(*(pud_t *)pte);
+			prot = pud_pgprot(*(pud_t *)pte);
+			step = PMD_SIZE >> PAGE_SHIFT;
+		} else {
+			return NULL;
+		}
+
+		table = alloc_low_page();
+		if (!table)
+			return NULL;
+		for (i = 0; i < PTRS_PER_PTE; i++, pfn += step)
+			set_pte(&table[i], pfn_pte(pfn, prot));
+
+		if (level == PG_LEVEL_2M)
+			pmd_populate_kernel(&init_mm, (pmd_t *)pte, table);
+		else
+			pud_populate(&init_mm, (pud_t *)pte, (pmd_t *)table);
+
+		if (addr - PAGE_OFFSET < get_max_mapped()) {
+			update_page_count(level, -1);
+			update_page_count(level - 1, PTRS_PER_PTE);
+		}
+
+		/* Flush the large translation before changing any attributes. */
+		__flush_tlb_all();
+	}
+}
+
+/* The caller has split both mappings before starting the page transition. */
+void __init early_set_page_decrypted(unsigned long addr, unsigned long alias)
+{
+	unsigned int level;
+	pte_t *pte;
+
+	pte = lookup_address(addr, &level);
+	set_pte(pte, __pte(cc_mkdec(pte_val(*pte))));
+	if (alias) {
+		pte = lookup_address(alias, &level);
+		set_pte(pte, __pte(cc_mkdec(pte_val(*pte))));
+	}
+	__flush_tlb_all();
+}
+
+/* Boot CPU only; size is in bytes and the contents are preserved. */
+int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size)
+{
+	unsigned long end, addr, alias, pa;
+	pte_t *pte;
+	int ret;
+
+	if (!size || !cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		return 0;
+	if (!x86_init.paging.early_decrypt_page)
+		return -EOPNOTSUPP;
+	if (size > ULONG_MAX - vaddr)
+		return -EINVAL;
+	end = PAGE_ALIGN(vaddr + size);
+	if (end < vaddr)
+		return -EINVAL;
+
+	for (vaddr &= PAGE_MASK; vaddr < end; vaddr += PAGE_SIZE) {
+		if (vaddr - PAGE_OFFSET >= get_max_mapped() &&
+		    (vaddr < (unsigned long)_text || vaddr >= _brk_end))
+			return -EINVAL;
+
+		pa = __pa(vaddr);
+		addr = (unsigned long)__va(pa);
+		pte = early_lookup_pte(addr);
+		if (!pte || pte_pfn(*pte) != PHYS_PFN(pa))
+			return -EFAULT;
+
+		alias = 0;
+		if (pa >= __pa_symbol(_text) &&
+		    pa <= __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1)) {
+			alias = (unsigned long)_text + pa - __pa_symbol(_text);
+			if (!early_lookup_pte(alias))
+				return -EFAULT;
+		}
+
+		if (pte_decrypted(*pte)) {
+			early_set_page_decrypted(addr, alias);
+			continue;
+		}
+		ret = x86_init.paging.early_decrypt_page(addr, alias);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..e854f3a039f7 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -459,9 +459,15 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 	return ret;
 }
 
-int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size)
+static int __init amd_early_decrypt_page(unsigned long addr, unsigned long alias)
 {
-	return early_set_memory_enc_dec(vaddr, size, false);
+	unsigned int level;
+	pte_t *pte = lookup_address(addr, &level);
+
+	__set_clr_pte_enc(pte, PG_LEVEL_4K, false);
+	early_set_page_decrypted(addr, alias);
+	early_set_mem_enc_dec_hypercall(addr, PAGE_SIZE, false);
+	return 0;
 }
 
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
@@ -479,6 +485,8 @@ void __init sme_early_init(void)
 	if (!sme_me_mask)
 		return;
 
+	x86_init.paging.early_decrypt_page = amd_early_decrypt_page;
+
 	early_pmd_flags = __sme_set(early_pmd_flags);
 
 	__supported_pte_mask = __sme_set(__supported_pte_mask);

-- 
2.53.0

