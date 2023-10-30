Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C75C41535
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 14:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12B1E854A8;
	Mon, 30 Oct 2023 14:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12B1E854A8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Ki5QuyAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbP4qvuk_yav; Mon, 30 Oct 2023 14:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AAED85414;
	Mon, 30 Oct 2023 14:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AAED85414
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E988BC0039;
	Mon, 30 Oct 2023 14:25:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D036EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B807F40C0D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B807F40C0D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=Ki5QuyAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDrwEI50PgSg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:36 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29BCD43896
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29BCD43896
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 681891FF06;
 Mon, 30 Oct 2023 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698675934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06K/mcUHrXmGJXjb8r0vYqPaJ0gqGYRAaxFFP38c6XI=;
 b=Ki5QuyACd2qwKTo8knNkWs6PXqAhsQvPcjY5FgzCq6DhCorr4viw9jlxKnTA1FCwgWTteM
 39/wzsJaOwzBFV7ALWD1yi+/2nD10Ueo88udK62m8LYZ6LsoS8qBAFNc6UJ44Vm93NQ8Ak
 k3Znz/xe4LC1gRn0IqiMnAq+dj1/wOM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05B0E138F8;
 Mon, 30 Oct 2023 14:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M0ljO928P2UIQQAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 30 Oct 2023 14:25:33 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v4 4/5] x86/paravirt: switch mixed paravirt/alternative calls
 to alternative_2
Date: Mon, 30 Oct 2023 15:25:07 +0100
Message-Id: <20231030142508.1407-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231030142508.1407-1-jgross@suse.com>
References: <20231030142508.1407-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Instead of stacking alternative and paravirt patching, use the new
ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
handling.

This eliminates the need to be careful regarding the sequence of
alternative and paravirt patching.

For call depth tracking callthunks_setup() needs to be adapted to patch
calls at alternative patching sites instead of paravirt calls.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h    |  5 +++--
 arch/x86/include/asm/paravirt.h       |  9 ++++++---
 arch/x86/include/asm/paravirt_types.h | 26 +++++++++-----------------
 arch/x86/kernel/callthunks.c          | 17 ++++++++---------
 arch/x86/kernel/module.c              | 20 +++++---------------
 5 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 2a74a94bd569..07b17bc615a0 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -89,6 +89,8 @@ struct alt_instr {
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
 
+extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+
 /*
  * Debug flag that can be tested to see whether alternative
  * instructions were patched in already:
@@ -104,11 +106,10 @@ extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
 			  s32 *start_cfi, s32 *end_cfi);
 
 struct module;
-struct paravirt_patch_site;
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
-	struct paravirt_patch_site	*pv_start, *pv_end;
+	struct alt_instr		*alt_start, *alt_end;
 };
 
 #ifdef CONFIG_CALL_THUNKS
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 3749311d51c3..9c6c5cfa9fe2 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -740,20 +740,23 @@ void native_pv_lock_init(void) __init;
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_DEBUG_ENTRY
 
 #define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
-#ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),
 		  ANNOTATE_RETPOLINE_SAFE;
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);)
+	ANNOTATE_RETPOLINE_SAFE;
+	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
 .endm
 
-#define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
-				    ALT_NOT_XEN
+#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
+				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
+				 "pushf; pop %rax;", ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 291d794f2344..9b0526967d69 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -278,15 +278,11 @@ extern struct paravirt_patch_template pv_ops;
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
 unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr, unsigned int len);
+#define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
 int paravirt_disable_iospace(void);
 
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
+/* This generates an indirect call based on the operation type number. */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%[paravirt_opptr];"
@@ -319,12 +315,6 @@ int paravirt_disable_iospace(void);
  * However, x86_64 also has to clobber all caller saved registers, which
  * unfortunately, are quite a bit (r8 - r11)
  *
- * The call instruction itself is marked by placing its start address
- * and size into the .parainstructions section, so that
- * apply_paravirt() in arch/i386/kernel/alternative.c can do the
- * appropriate patching under the control of the backend pv_init_ops
- * implementation.
- *
  * Unfortunately there's no way to get gcc to generate the args setup
  * for the call, and then allow the call itself to be generated by an
  * inline asm.  Because of this, we must do the complete arg setup and
@@ -428,9 +418,10 @@ int paravirt_disable_iospace(void);
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
+		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
+				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
+			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
@@ -441,10 +432,11 @@ int paravirt_disable_iospace(void);
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		asm volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),	\
-					 alt, cond)			\
+		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
+				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
+				 alt, cond)				\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
+			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index faa9f2299848..200ea8087ddb 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -238,14 +238,13 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 }
 
 static __init_or_module void
-patch_paravirt_call_sites(struct paravirt_patch_site *start,
-			  struct paravirt_patch_site *end,
-			  const struct core_text *ct)
+patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
+		     const struct core_text *ct)
 {
-	struct paravirt_patch_site *p;
+	struct alt_instr *a;
 
-	for (p = start; p < end; p++)
-		patch_call(p->instr, ct);
+	for (a = start; a < end; a++)
+		patch_call((u8 *)&a->instr_offset + a->instr_offset, ct);
 }
 
 static __init_or_module void
@@ -253,7 +252,7 @@ callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 {
 	prdbg("Patching call sites %s\n", ct->name);
 	patch_call_sites(cs->call_start, cs->call_end, ct);
-	patch_paravirt_call_sites(cs->pv_start, cs->pv_end, ct);
+	patch_alt_call_sites(cs->alt_start, cs->alt_end, ct);
 	prdbg("Patching call sites done%s\n", ct->name);
 }
 
@@ -262,8 +261,8 @@ void __init callthunks_patch_builtin_calls(void)
 	struct callthunk_sites cs = {
 		.call_start	= __call_sites,
 		.call_end	= __call_sites_end,
-		.pv_start	= __parainstructions,
-		.pv_end		= __parainstructions_end
+		.alt_start	= __alt_instructions,
+		.alt_end	= __alt_instructions_end
 	};
 
 	if (!cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5f71a0cf4399..e18914c0e38a 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -276,7 +276,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL,
+		*orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
 		*calls = NULL, *cfi = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
@@ -286,8 +286,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks = s;
-		if (!strcmp(".parainstructions", secstrings + s->sh_name))
-			para = s;
 		if (!strcmp(".orc_unwind", secstrings + s->sh_name))
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
@@ -304,14 +302,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 			ibt_endbr = s;
 	}
 
-	/*
-	 * See alternative_instructions() for the ordering rules between the
-	 * various patching types.
-	 */
-	if (para) {
-		void *pseg = (void *)para->sh_addr;
-		apply_paravirt(pseg, pseg + para->sh_size);
-	}
 	if (retpolines || cfi) {
 		void *rseg = NULL, *cseg = NULL;
 		unsigned int rsize = 0, csize = 0;
@@ -341,7 +331,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
-	if (calls || para) {
+	if (calls || alt) {
 		struct callthunk_sites cs = {};
 
 		if (calls) {
@@ -349,9 +339,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 		}
 
-		if (para) {
-			cs.pv_start = (void *)para->sh_addr;
-			cs.pv_end = (void *)para->sh_addr + para->sh_size;
+		if (alt) {
+			cs.alt_start = (void *)alt->sh_addr;
+			cs.alt_end = (void *)alt->sh_addr + alt->sh_size;
 		}
 
 		callthunks_patch_module_calls(&cs, me);
-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
