Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E5262FE4
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736894; cv=none; b=CXdtJGpsA9hCG0ZPlFPrjQqJLhmhPzaW2rYZ4jJcDoGVPwopkIQB6klPEDZ2jcv5YQahzxEt/RAt+UhXb8JMQUyKBp76Uwwz0W5TqoxL61DTcLRten7sz+q6ozaaMq/8fyVsWygE67nJg3xVSiIrOVwTEb4JPFq+RpjQzloFN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736894; c=relaxed/simple;
	bh=k38cYc1Ip9S/bqj4xsIIBTbOHiwesPhXlvxcbLMeoeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijHjTigKk5UsLdorH9A0EZCQ8ZUysS0jQwnVnxZZ/ufkZakDSB+Pm4ki+A2hK+EZXmXwuRzGGmT09wEgPCmW0f0FzKKTLMeHjKi0hWUDJORO/UCW5Ykqvi8uhbYnccx2qvVZXnJlcOpQL59HrnjA2z77ZcpSgGAaLBqMXWx/KcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PdnGbg6k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PdnGbg6k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PdnGbg6k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PdnGbg6k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7685E336CB;
	Mon,  6 Oct 2025 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aImX120WIX3OxAQ8XVXjQ/wotZtRL1VJpjpoDvr/EQ=;
	b=PdnGbg6ktNBw0Q6h2dhYBsH66XExPF6x/50m/sikaDUhH1Q0+8YhwmkX/bFiJfCZ8x5q8e
	okpOeH51MFVqQ8zRpRSglYf8EQUBXgWAaOhQxNR+Dg+F8vddLyq1mMdKoIp0y1l4VXSUjU
	rmD9RVszAbC/b+WF+pZgl336dG/yQZw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aImX120WIX3OxAQ8XVXjQ/wotZtRL1VJpjpoDvr/EQ=;
	b=PdnGbg6ktNBw0Q6h2dhYBsH66XExPF6x/50m/sikaDUhH1Q0+8YhwmkX/bFiJfCZ8x5q8e
	okpOeH51MFVqQ8zRpRSglYf8EQUBXgWAaOhQxNR+Dg+F8vddLyq1mMdKoIp0y1l4VXSUjU
	rmD9RVszAbC/b+WF+pZgl336dG/yQZw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08A0F13A7E;
	Mon,  6 Oct 2025 07:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aSlFADp042jPHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:48:10 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 20/21] x86/paravirt: Specify pv_ops array in paravirt macros
Date: Mon,  6 Oct 2025 09:46:05 +0200
Message-ID: <20251006074606.1266-21-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

In order to prepare having multiple pv_ops arrays, specify the array
in the paravirt macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/paravirt.h       | 166 +++++++++++++-------------
 arch/x86/include/asm/paravirt_types.h | 140 +++++++++++-----------
 2 files changed, 153 insertions(+), 153 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index ba6b14b6f36a..ec274d13bae0 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -31,11 +31,11 @@ void __init paravirt_set_cap(void);
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(pv_ops, cpu.io_delay);
 #ifdef REALLY_SLOW_IO
-	PVOP_VCALL0(cpu.io_delay);
-	PVOP_VCALL0(cpu.io_delay);
-	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(pv_ops, cpu.io_delay);
+	PVOP_VCALL0(pv_ops, cpu.io_delay);
+	PVOP_VCALL0(pv_ops, cpu.io_delay);
 #endif
 }
 
@@ -47,57 +47,57 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
 
 static inline void __flush_tlb_local(void)
 {
-	PVOP_VCALL0(mmu.flush_tlb_user);
+	PVOP_VCALL0(pv_ops, mmu.flush_tlb_user);
 }
 
 static inline void __flush_tlb_global(void)
 {
-	PVOP_VCALL0(mmu.flush_tlb_kernel);
+	PVOP_VCALL0(pv_ops, mmu.flush_tlb_kernel);
 }
 
 static inline void __flush_tlb_one_user(unsigned long addr)
 {
-	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
+	PVOP_VCALL1(pv_ops, mmu.flush_tlb_one_user, addr);
 }
 
 static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 				      const struct flush_tlb_info *info)
 {
-	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
+	PVOP_VCALL2(pv_ops, mmu.flush_tlb_multi, cpumask, info);
 }
 
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
-	PVOP_VCALL1(mmu.exit_mmap, mm);
+	PVOP_VCALL1(pv_ops, mmu.exit_mmap, mm);
 }
 
 static inline void notify_page_enc_status_changed(unsigned long pfn,
 						  int npages, bool enc)
 {
-	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
+	PVOP_VCALL3(pv_ops, mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
 static __always_inline void arch_safe_halt(void)
 {
-	PVOP_VCALL0(irq.safe_halt);
+	PVOP_VCALL0(pv_ops, irq.safe_halt);
 }
 
 static inline void halt(void)
 {
-	PVOP_VCALL0(irq.halt);
+	PVOP_VCALL0(pv_ops, irq.halt);
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
-	PVOP_VCALL1(cpu.load_sp0, sp0);
+	PVOP_VCALL1(pv_ops, cpu.load_sp0, sp0);
 }
 
 /* The paravirtualized CPUID instruction. */
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	PVOP_VCALL4(cpu.cpuid, eax, ebx, ecx, edx);
+	PVOP_VCALL4(pv_ops, cpu.cpuid, eax, ebx, ecx, edx);
 }
 
 /*
@@ -105,69 +105,69 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
  */
 static __always_inline unsigned long paravirt_get_debugreg(int reg)
 {
-	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
+	return PVOP_CALL1(unsigned long, pv_ops, cpu.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
 static __always_inline void set_debugreg(unsigned long val, int reg)
 {
-	PVOP_VCALL2(cpu.set_debugreg, reg, val);
+	PVOP_VCALL2(pv_ops, cpu.set_debugreg, reg, val);
 }
 
 static inline unsigned long read_cr0(void)
 {
-	return PVOP_CALL0(unsigned long, cpu.read_cr0);
+	return PVOP_CALL0(unsigned long, pv_ops, cpu.read_cr0);
 }
 
 static inline void write_cr0(unsigned long x)
 {
-	PVOP_VCALL1(cpu.write_cr0, x);
+	PVOP_VCALL1(pv_ops, cpu.write_cr0, x);
 }
 
 static __always_inline unsigned long read_cr2(void)
 {
-	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
+	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, mmu.read_cr2,
 				"mov %%cr2, %%rax;", ALT_NOT_XEN);
 }
 
 static __always_inline void write_cr2(unsigned long x)
 {
-	PVOP_VCALL1(mmu.write_cr2, x);
+	PVOP_VCALL1(pv_ops, mmu.write_cr2, x);
 }
 
 static inline unsigned long __read_cr3(void)
 {
-	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
+	return PVOP_ALT_CALL0(unsigned long, pv_ops, mmu.read_cr3,
 			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_ALT_VCALL1(mmu.write_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
+	PVOP_ALT_VCALL1(pv_ops, mmu.write_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
 }
 
 static inline void __write_cr4(unsigned long x)
 {
-	PVOP_VCALL1(cpu.write_cr4, x);
+	PVOP_VCALL1(pv_ops, cpu.write_cr4, x);
 }
 
 static inline u64 paravirt_read_msr(u32 msr)
 {
-	return PVOP_CALL1(u64, cpu.read_msr, msr);
+	return PVOP_CALL1(u64, pv_ops, cpu.read_msr, msr);
 }
 
 static inline void paravirt_write_msr(u32 msr, u64 val)
 {
-	PVOP_VCALL2(cpu.write_msr, msr, val);
+	PVOP_VCALL2(pv_ops, cpu.write_msr, msr, val);
 }
 
 static inline int paravirt_read_msr_safe(u32 msr, u64 *val)
 {
-	return PVOP_CALL2(int, cpu.read_msr_safe, msr, val);
+	return PVOP_CALL2(int, pv_ops, cpu.read_msr_safe, msr, val);
 }
 
 static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 {
-	return PVOP_CALL2(int, cpu.write_msr_safe, msr, val);
+	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
 #define rdmsr(msr, val1, val2)			\
@@ -214,154 +214,154 @@ static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
 
 static __always_inline u64 rdpmc(int counter)
 {
-	return PVOP_CALL1(u64, cpu.read_pmc, counter);
+	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
 }
 
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
-	PVOP_VCALL2(cpu.alloc_ldt, ldt, entries);
+	PVOP_VCALL2(pv_ops, cpu.alloc_ldt, ldt, entries);
 }
 
 static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 {
-	PVOP_VCALL2(cpu.free_ldt, ldt, entries);
+	PVOP_VCALL2(pv_ops, cpu.free_ldt, ldt, entries);
 }
 
 static inline void load_TR_desc(void)
 {
-	PVOP_VCALL0(cpu.load_tr_desc);
+	PVOP_VCALL0(pv_ops, cpu.load_tr_desc);
 }
 static inline void load_gdt(const struct desc_ptr *dtr)
 {
-	PVOP_VCALL1(cpu.load_gdt, dtr);
+	PVOP_VCALL1(pv_ops, cpu.load_gdt, dtr);
 }
 static inline void load_idt(const struct desc_ptr *dtr)
 {
-	PVOP_VCALL1(cpu.load_idt, dtr);
+	PVOP_VCALL1(pv_ops, cpu.load_idt, dtr);
 }
 static inline void set_ldt(const void *addr, unsigned entries)
 {
-	PVOP_VCALL2(cpu.set_ldt, addr, entries);
+	PVOP_VCALL2(pv_ops, cpu.set_ldt, addr, entries);
 }
 static inline unsigned long paravirt_store_tr(void)
 {
-	return PVOP_CALL0(unsigned long, cpu.store_tr);
+	return PVOP_CALL0(unsigned long, pv_ops, cpu.store_tr);
 }
 
 #define store_tr(tr)	((tr) = paravirt_store_tr())
 static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 {
-	PVOP_VCALL2(cpu.load_tls, t, cpu);
+	PVOP_VCALL2(pv_ops, cpu.load_tls, t, cpu);
 }
 
 static inline void load_gs_index(unsigned int gs)
 {
-	PVOP_VCALL1(cpu.load_gs_index, gs);
+	PVOP_VCALL1(pv_ops, cpu.load_gs_index, gs);
 }
 
 static inline void write_ldt_entry(struct desc_struct *dt, int entry,
 				   const void *desc)
 {
-	PVOP_VCALL3(cpu.write_ldt_entry, dt, entry, desc);
+	PVOP_VCALL3(pv_ops, cpu.write_ldt_entry, dt, entry, desc);
 }
 
 static inline void write_gdt_entry(struct desc_struct *dt, int entry,
 				   void *desc, int type)
 {
-	PVOP_VCALL4(cpu.write_gdt_entry, dt, entry, desc, type);
+	PVOP_VCALL4(pv_ops, cpu.write_gdt_entry, dt, entry, desc, type);
 }
 
 static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
 {
-	PVOP_VCALL3(cpu.write_idt_entry, dt, entry, g);
+	PVOP_VCALL3(pv_ops, cpu.write_idt_entry, dt, entry, g);
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 static inline void tss_invalidate_io_bitmap(void)
 {
-	PVOP_VCALL0(cpu.invalidate_io_bitmap);
+	PVOP_VCALL0(pv_ops, cpu.invalidate_io_bitmap);
 }
 
 static inline void tss_update_io_bitmap(void)
 {
-	PVOP_VCALL0(cpu.update_io_bitmap);
+	PVOP_VCALL0(pv_ops, cpu.update_io_bitmap);
 }
 #endif
 
 static inline void paravirt_enter_mmap(struct mm_struct *next)
 {
-	PVOP_VCALL1(mmu.enter_mmap, next);
+	PVOP_VCALL1(pv_ops, mmu.enter_mmap, next);
 }
 
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
 {
-	return PVOP_CALL1(int, mmu.pgd_alloc, mm);
+	return PVOP_CALL1(int, pv_ops, mmu.pgd_alloc, mm);
 }
 
 static inline void paravirt_pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	PVOP_VCALL2(mmu.pgd_free, mm, pgd);
+	PVOP_VCALL2(pv_ops, mmu.pgd_free, mm, pgd);
 }
 
 static inline void paravirt_alloc_pte(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(mmu.alloc_pte, mm, pfn);
+	PVOP_VCALL2(pv_ops, mmu.alloc_pte, mm, pfn);
 }
 static inline void paravirt_release_pte(unsigned long pfn)
 {
-	PVOP_VCALL1(mmu.release_pte, pfn);
+	PVOP_VCALL1(pv_ops, mmu.release_pte, pfn);
 }
 
 static inline void paravirt_alloc_pmd(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(mmu.alloc_pmd, mm, pfn);
+	PVOP_VCALL2(pv_ops, mmu.alloc_pmd, mm, pfn);
 }
 
 static inline void paravirt_release_pmd(unsigned long pfn)
 {
-	PVOP_VCALL1(mmu.release_pmd, pfn);
+	PVOP_VCALL1(pv_ops, mmu.release_pmd, pfn);
 }
 
 static inline void paravirt_alloc_pud(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(mmu.alloc_pud, mm, pfn);
+	PVOP_VCALL2(pv_ops, mmu.alloc_pud, mm, pfn);
 }
 static inline void paravirt_release_pud(unsigned long pfn)
 {
-	PVOP_VCALL1(mmu.release_pud, pfn);
+	PVOP_VCALL1(pv_ops, mmu.release_pud, pfn);
 }
 
 static inline void paravirt_alloc_p4d(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(mmu.alloc_p4d, mm, pfn);
+	PVOP_VCALL2(pv_ops, mmu.alloc_p4d, mm, pfn);
 }
 
 static inline void paravirt_release_p4d(unsigned long pfn)
 {
-	PVOP_VCALL1(mmu.release_p4d, pfn);
+	PVOP_VCALL1(pv_ops, mmu.release_p4d, pfn);
 }
 
 static inline pte_t __pte(pteval_t val)
 {
-	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
+	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, pv_ops, mmu.make_pte, val,
 					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pteval_t pte_val(pte_t pte)
 {
-	return PVOP_ALT_CALLEE1(pteval_t, mmu.pte_val, pte.pte,
+	return PVOP_ALT_CALLEE1(pteval_t, pv_ops, mmu.pte_val, pte.pte,
 				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline pgd_t __pgd(pgdval_t val)
 {
-	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, mmu.make_pgd, val,
+	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, pv_ops, mmu.make_pgd, val,
 					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pgdval_t pgd_val(pgd_t pgd)
 {
-	return PVOP_ALT_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd,
+	return PVOP_ALT_CALLEE1(pgdval_t, pv_ops, mmu.pgd_val, pgd.pgd,
 				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
@@ -371,7 +371,7 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned
 {
 	pteval_t ret;
 
-	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, vma, addr, ptep);
+	ret = PVOP_CALL3(pteval_t, pv_ops, mmu.ptep_modify_prot_start, vma, addr, ptep);
 
 	return (pte_t) { .pte = ret };
 }
@@ -380,41 +380,41 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned
 					   pte_t *ptep, pte_t old_pte, pte_t pte)
 {
 
-	PVOP_VCALL4(mmu.ptep_modify_prot_commit, vma, addr, ptep, pte.pte);
+	PVOP_VCALL4(pv_ops, mmu.ptep_modify_prot_commit, vma, addr, ptep, pte.pte);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
+	PVOP_VCALL2(pv_ops, mmu.set_pte, ptep, pte.pte);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	PVOP_VCALL2(mmu.set_pmd, pmdp, native_pmd_val(pmd));
+	PVOP_VCALL2(pv_ops, mmu.set_pmd, pmdp, native_pmd_val(pmd));
 }
 
 static inline pmd_t __pmd(pmdval_t val)
 {
-	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, mmu.make_pmd, val,
+	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, pv_ops, mmu.make_pmd, val,
 					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pmdval_t pmd_val(pmd_t pmd)
 {
-	return PVOP_ALT_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd,
+	return PVOP_ALT_CALLEE1(pmdval_t, pv_ops, mmu.pmd_val, pmd.pmd,
 				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	PVOP_VCALL2(mmu.set_pud, pudp, native_pud_val(pud));
+	PVOP_VCALL2(pv_ops, mmu.set_pud, pudp, native_pud_val(pud));
 }
 
 static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
 
-	ret = PVOP_ALT_CALLEE1(pudval_t, mmu.make_pud, val,
+	ret = PVOP_ALT_CALLEE1(pudval_t, pv_ops, mmu.make_pud, val,
 			       "mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (pud_t) { ret };
@@ -422,7 +422,7 @@ static inline pud_t __pud(pudval_t val)
 
 static inline pudval_t pud_val(pud_t pud)
 {
-	return PVOP_ALT_CALLEE1(pudval_t, mmu.pud_val, pud.pud,
+	return PVOP_ALT_CALLEE1(pudval_t, pv_ops, mmu.pud_val, pud.pud,
 				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
@@ -435,12 +435,12 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	p4dval_t val = native_p4d_val(p4d);
 
-	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
+	PVOP_VCALL2(pv_ops, mmu.set_p4d, p4dp, val);
 }
 
 static inline p4d_t __p4d(p4dval_t val)
 {
-	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
+	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, pv_ops, mmu.make_p4d, val,
 					"mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (p4d_t) { ret };
@@ -448,13 +448,13 @@ static inline p4d_t __p4d(p4dval_t val)
 
 static inline p4dval_t p4d_val(p4d_t p4d)
 {
-	return PVOP_ALT_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d,
+	return PVOP_ALT_CALLEE1(p4dval_t, pv_ops, mmu.p4d_val, p4d.p4d,
 				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	PVOP_VCALL2(mmu.set_pgd, pgdp, native_pgd_val(pgd));
+	PVOP_VCALL2(pv_ops, mmu.set_pgd, pgdp, native_pgd_val(pgd));
 }
 
 #define set_pgd(pgdp, pgdval) do {					\
@@ -493,28 +493,28 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
 {
-	PVOP_VCALL1(cpu.start_context_switch, prev);
+	PVOP_VCALL1(pv_ops, cpu.start_context_switch, prev);
 }
 
 static inline void arch_end_context_switch(struct task_struct *next)
 {
-	PVOP_VCALL1(cpu.end_context_switch, next);
+	PVOP_VCALL1(pv_ops, cpu.end_context_switch, next);
 }
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(mmu.lazy_mode.enter);
+	PVOP_VCALL0(pv_ops, mmu.lazy_mode.enter);
 }
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(mmu.lazy_mode.leave);
+	PVOP_VCALL0(pv_ops, mmu.lazy_mode.leave);
 }
 
 static inline void arch_flush_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(mmu.lazy_mode.flush);
+	PVOP_VCALL0(pv_ops, mmu.lazy_mode.flush);
 }
 
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
@@ -529,29 +529,29 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 							u32 val)
 {
-	PVOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
+	PVOP_VCALL2(pv_ops, lock.queued_spin_lock_slowpath, lock, val);
 }
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
+	PVOP_ALT_VCALLEE1(pv_ops, lock.queued_spin_unlock, lock,
 			  "movb $0, (%%" _ASM_ARG1 ");",
 			  ALT_NOT(X86_FEATURE_PVUNLOCK));
 }
 
 static __always_inline void pv_wait(u8 *ptr, u8 val)
 {
-	PVOP_VCALL2(lock.wait, ptr, val);
+	PVOP_VCALL2(pv_ops, lock.wait, ptr, val);
 }
 
 static __always_inline void pv_kick(int cpu)
 {
-	PVOP_VCALL1(lock.kick, cpu);
+	PVOP_VCALL1(pv_ops, lock.kick, cpu);
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
-	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
+	return PVOP_ALT_CALLEE1(bool, pv_ops, lock.vcpu_is_preempted, cpu,
 				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
@@ -564,18 +564,18 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
-	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
+	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%rax;",
 				ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_disable, "cli;", ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_enable, "sti;", ALT_NOT_XEN);
 }
 
 static __always_inline unsigned long arch_local_irq_save(void)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 1e50f13e6543..01a485f1a7f1 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -212,7 +212,7 @@ struct paravirt_patch_template {
 
 extern struct paravirt_patch_template pv_ops;
 
-#define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
+#define paravirt_ptr(array, op)	[paravirt_opptr] "m" (array.op)
 
 /*
  * This generates an indirect call based on the operation type number.
@@ -362,19 +362,19 @@ extern struct paravirt_patch_template pv_ops;
  *   feature is not active, the direct call is used as above via the
  *   ALT_FLAG_DIRECT_CALL special case and the "always on" feature.
  */
-#define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
+#define ____PVOP_CALL(ret, array, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_ptr(op),			\
+			     : paravirt_ptr(array, op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
-#define ____PVOP_ALT_CALL(ret, op, alt, cond, call_clbr,		\
+#define ____PVOP_ALT_CALL(ret, array, op, alt, cond, call_clbr,		\
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
@@ -382,102 +382,102 @@ extern struct paravirt_patch_template pv_ops;
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_ptr(op),			\
+			     : paravirt_ptr(array, op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
-#define __PVOP_CALL(rettype, op, ...)					\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op,				\
+#define __PVOP_CALL(rettype, array, op, ...)				\
+	____PVOP_CALL(PVOP_RETVAL(rettype), array, op,			\
 		      PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS, ##__VA_ARGS__)
 
-#define __PVOP_ALT_CALL(rettype, op, alt, cond, ...)			\
-	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op, alt, cond,		\
+#define __PVOP_ALT_CALL(rettype, array, op, alt, cond, ...)		\
+	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), array, op, alt, cond,	\
 			  PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS,		\
 			  ##__VA_ARGS__)
 
-#define __PVOP_CALLEESAVE(rettype, op, ...)				\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op.func,			\
+#define __PVOP_CALLEESAVE(rettype, array, op, ...)			\
+	____PVOP_CALL(PVOP_RETVAL(rettype), array, op.func,		\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
-#define __PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, ...)		\
-	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op.func, alt, cond,	\
+#define __PVOP_ALT_CALLEESAVE(rettype, array, op, alt, cond, ...)	\
+	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), array, op.func, alt, cond, \
 			  PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-#define __PVOP_VCALL(op, ...)						\
-	(void)____PVOP_CALL(, op, PVOP_VCALL_CLOBBERS,			\
+#define __PVOP_VCALL(array, op, ...)					\
+	(void)____PVOP_CALL(, array, op, PVOP_VCALL_CLOBBERS,		\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
-#define __PVOP_ALT_VCALL(op, alt, cond, ...)				\
-	(void)____PVOP_ALT_CALL(, op, alt, cond,			\
+#define __PVOP_ALT_VCALL(array, op, alt, cond, ...)			\
+	(void)____PVOP_ALT_CALL(, array, op, alt, cond,			\
 				PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,	\
 				##__VA_ARGS__)
 
-#define __PVOP_VCALLEESAVE(op, ...)					\
-	(void)____PVOP_CALL(, op.func,					\
+#define __PVOP_VCALLEESAVE(array, op, ...)				\
+	(void)____PVOP_CALL(, array, op.func,				\
 			    PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
-#define __PVOP_ALT_VCALLEESAVE(op, alt, cond, ...)			\
-	(void)____PVOP_ALT_CALL(, op.func, alt, cond,			\
+#define __PVOP_ALT_VCALLEESAVE(array, op, alt, cond, ...)		\
+	(void)____PVOP_ALT_CALL(, array, op.func, alt, cond,		\
 				PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-#define PVOP_CALL0(rettype, op)						\
-	__PVOP_CALL(rettype, op)
-#define PVOP_VCALL0(op)							\
-	__PVOP_VCALL(op)
-#define PVOP_ALT_CALL0(rettype, op, alt, cond)				\
-	__PVOP_ALT_CALL(rettype, op, alt, cond)
-#define PVOP_ALT_VCALL0(op, alt, cond)					\
-	__PVOP_ALT_VCALL(op, alt, cond)
-
-#define PVOP_CALLEE0(rettype, op)					\
-	__PVOP_CALLEESAVE(rettype, op)
-#define PVOP_VCALLEE0(op)						\
-	__PVOP_VCALLEESAVE(op)
-#define PVOP_ALT_CALLEE0(rettype, op, alt, cond)			\
-	__PVOP_ALT_CALLEESAVE(rettype, op, alt, cond)
-#define PVOP_ALT_VCALLEE0(op, alt, cond)				\
-	__PVOP_ALT_VCALLEESAVE(op, alt, cond)
-
-
-#define PVOP_CALL1(rettype, op, arg1)					\
-	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1))
-#define PVOP_VCALL1(op, arg1)						\
-	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1))
-#define PVOP_ALT_VCALL1(op, arg1, alt, cond)				\
-	__PVOP_ALT_VCALL(op, alt, cond, PVOP_CALL_ARG1(arg1))
-
-#define PVOP_CALLEE1(rettype, op, arg1)					\
-	__PVOP_CALLEESAVE(rettype, op, PVOP_CALL_ARG1(arg1))
-#define PVOP_VCALLEE1(op, arg1)						\
-	__PVOP_VCALLEESAVE(op, PVOP_CALL_ARG1(arg1))
-#define PVOP_ALT_CALLEE1(rettype, op, arg1, alt, cond)			\
-	__PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, PVOP_CALL_ARG1(arg1))
-#define PVOP_ALT_VCALLEE1(op, arg1, alt, cond)				\
-	__PVOP_ALT_VCALLEESAVE(op, alt, cond, PVOP_CALL_ARG1(arg1))
-
-
-#define PVOP_CALL2(rettype, op, arg1, arg2)				\
-	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
-#define PVOP_VCALL2(op, arg1, arg2)					\
-	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
-
-#define PVOP_CALL3(rettype, op, arg1, arg2, arg3)			\
-	__PVOP_CALL(rettype, op, PVOP_CALL_ARG1(arg1),			\
+#define PVOP_CALL0(rettype, array, op)					\
+	__PVOP_CALL(rettype, array, op)
+#define PVOP_VCALL0(array, op)						\
+	__PVOP_VCALL(array, op)
+#define PVOP_ALT_CALL0(rettype, array, op, alt, cond)			\
+	__PVOP_ALT_CALL(rettype, array, op, alt, cond)
+#define PVOP_ALT_VCALL0(array, op, alt, cond)				\
+	__PVOP_ALT_VCALL(array, op, alt, cond)
+
+#define PVOP_CALLEE0(rettype, array, op)				\
+	__PVOP_CALLEESAVE(rettype, array, op)
+#define PVOP_VCALLEE0(array, op)					\
+	__PVOP_VCALLEESAVE(array, op)
+#define PVOP_ALT_CALLEE0(rettype, array, op, alt, cond)			\
+	__PVOP_ALT_CALLEESAVE(rettype, array, op, alt, cond)
+#define PVOP_ALT_VCALLEE0(array, op, alt, cond)				\
+	__PVOP_ALT_VCALLEESAVE(array, op, alt, cond)
+
+
+#define PVOP_CALL1(rettype, array, op, arg1)				\
+	__PVOP_CALL(rettype, array, op, PVOP_CALL_ARG1(arg1))
+#define PVOP_VCALL1(array, op, arg1)					\
+	__PVOP_VCALL(array, op, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALL1(array, op, arg1, alt, cond)			\
+	__PVOP_ALT_VCALL(array, op, alt, cond, PVOP_CALL_ARG1(arg1))
+
+#define PVOP_CALLEE1(rettype, array, op, arg1)				\
+	__PVOP_CALLEESAVE(rettype, array, op, PVOP_CALL_ARG1(arg1))
+#define PVOP_VCALLEE1(array, op, arg1)					\
+	__PVOP_VCALLEESAVE(array, op, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_CALLEE1(rettype, array, op, arg1, alt, cond)		\
+	__PVOP_ALT_CALLEESAVE(rettype, array, op, alt, cond, PVOP_CALL_ARG1(arg1))
+#define PVOP_ALT_VCALLEE1(array, op, arg1, alt, cond)			\
+	__PVOP_ALT_VCALLEESAVE(array, op, alt, cond, PVOP_CALL_ARG1(arg1))
+
+
+#define PVOP_CALL2(rettype, array, op, arg1, arg2)			\
+	__PVOP_CALL(rettype, array, op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
+#define PVOP_VCALL2(array, op, arg1, arg2)				\
+	__PVOP_VCALL(array, op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2))
+
+#define PVOP_CALL3(rettype, array, op, arg1, arg2, arg3)		\
+	__PVOP_CALL(rettype, array, op, PVOP_CALL_ARG1(arg1),		\
 		    PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
-#define PVOP_VCALL3(op, arg1, arg2, arg3)				\
-	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1),				\
+#define PVOP_VCALL3(array, op, arg1, arg2, arg3)			\
+	__PVOP_VCALL(array, op, PVOP_CALL_ARG1(arg1),			\
 		     PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
 
-#define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
-	__PVOP_CALL(rettype, op,					\
+#define PVOP_CALL4(rettype, array, op, arg1, arg2, arg3, arg4)		\
+	__PVOP_CALL(rettype, array, op,					\
 		    PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),		\
 		    PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
-#define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
-	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
+#define PVOP_VCALL4(array, op, arg1, arg2, arg3, arg4)			\
+	__PVOP_VCALL(array, op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2), \
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
 #endif	/* __ASSEMBLER__ */
-- 
2.51.0

