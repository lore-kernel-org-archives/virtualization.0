Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2264CDB482
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 911CB6FAA9;
	Thu, 19 Oct 2023 09:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 911CB6FAA9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=FcVlmKJs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-n6k4Ex-t8D; Thu, 19 Oct 2023 09:15:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B85EF60FC0;
	Thu, 19 Oct 2023 09:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B85EF60FC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92BCEC0039;
	Thu, 19 Oct 2023 09:15:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8184C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B02DB4214D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B02DB4214D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=FcVlmKJs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2PIFlBaiiZG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82AA942163
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82AA942163
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A9781FD92;
 Thu, 19 Oct 2023 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697706929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SktsBRaT0WfP83H70+6Aqz0kX9lsT33YwrE6d/KceQ=;
 b=FcVlmKJsbSHxticTnIdtzCbL2oQKZUcqvXe4WAEaEeCOkyevWwBkkNALq1+gE5AYLYmNC3
 aCyKGz4j9u9FzkaHGOMXneWE2CNgrLOoOl3khGMNRzvlFPdFsN6kCroPou4nothpcyeGFl
 y3UVWNUZekaHj/f7QFu+mE6S68dzyek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2494139C2;
 Thu, 19 Oct 2023 09:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n7wLLrDzMGXFVAAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 19 Oct 2023 09:15:28 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH v3 1/5] x86/paravirt: move some functions and defines to
 alternative
Date: Thu, 19 Oct 2023 11:15:16 +0200
Message-Id: <20231019091520.14540-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019091520.14540-1-jgross@suse.com>
References: <20231019091520.14540-1-jgross@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[19];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Cc: Juergen Gross <jgross@suse.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

As a preparation for replacing paravirt patching completely by
alternative patching, move some backend functions and #defines to
alternative code and header.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h        | 16 ++++++++++++
 arch/x86/include/asm/paravirt.h           | 12 ---------
 arch/x86/include/asm/paravirt_types.h     |  4 +--
 arch/x86/include/asm/qspinlock_paravirt.h |  4 +--
 arch/x86/kernel/alternative.c             | 10 ++++++++
 arch/x86/kernel/kvm.c                     |  4 +--
 arch/x86/kernel/paravirt.c                | 30 +++++++----------------
 arch/x86/xen/irq.c                        |  2 +-
 8 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 9c4da699e11a..67e50bd40bb8 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -330,6 +330,22 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
 
+/* Macro for creating assembler functions avoiding any C magic. */
+#define DEFINE_ASM_FUNC(func, instr, sec)		\
+	asm (".pushsection " #sec ", \"ax\"\n"		\
+	     ".global " #func "\n\t"			\
+	     ".type " #func ", @function\n\t"		\
+	     ASM_FUNC_ALIGN "\n"			\
+	     #func ":\n\t"				\
+	     ASM_ENDBR					\
+	     instr "\n\t"				\
+	     ASM_RET					\
+	     ".size " #func ", . - " #func "\n\t"	\
+	     ".popsection")
+
+void x86_BUG(void);
+void x86_nop(void);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6c8ff12140ae..ed5c7342f2ef 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -726,18 +726,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #undef PVOP_VCALL4
 #undef PVOP_CALL4
 
-#define DEFINE_PARAVIRT_ASM(func, instr, sec)		\
-	asm (".pushsection " #sec ", \"ax\"\n"		\
-	     ".global " #func "\n\t"			\
-	     ".type " #func ", @function\n\t"		\
-	     ASM_FUNC_ALIGN "\n"			\
-	     #func ":\n\t"				\
-	     ASM_ENDBR					\
-	     instr "\n\t"				\
-	     ASM_RET					\
-	     ".size " #func ", . - " #func "\n\t"	\
-	     ".popsection")
-
 extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 772d03487520..9f84dc074f88 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -542,8 +542,6 @@ int paravirt_disable_iospace(void);
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
-void _paravirt_nop(void);
-void paravirt_BUG(void);
 unsigned long paravirt_ret0(void);
 #ifdef CONFIG_PARAVIRT_XXL
 u64 _paravirt_ident_64(u64);
@@ -553,7 +551,7 @@ void pv_native_irq_enable(void);
 unsigned long pv_native_read_cr2(void);
 #endif
 
-#define paravirt_nop	((void *)_paravirt_nop)
+#define paravirt_nop	((void *)x86_nop)
 
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 85b6e3609cb9..ef9697f20129 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -56,8 +56,8 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 	"pop    %rdx\n\t"						\
 	FRAME_END
 
-DEFINE_PARAVIRT_ASM(__raw_callee_save___pv_queued_spin_unlock,
-		    PV_UNLOCK_ASM, .spinlock.text);
+DEFINE_ASM_FUNC(__raw_callee_save___pv_queued_spin_unlock,
+		PV_UNLOCK_ASM, .spinlock.text);
 
 #else /* CONFIG_64BIT */
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..1c8dd8e05f3f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -385,6 +385,16 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 	}
 }
 
+/* Low-level backend functions usable from alternative code replacements. */
+DEFINE_ASM_FUNC(x86_nop, "", .entry.text);
+EXPORT_SYMBOL_GPL(x86_nop);
+
+noinstr void x86_BUG(void)
+{
+	BUG();
+}
+EXPORT_SYMBOL_GPL(x86_BUG);
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b8ab9ee5896c..4ca59dccc15a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -803,8 +803,8 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
  "setne  %al\n\t"
 
-DEFINE_PARAVIRT_ASM(__raw_callee_save___kvm_vcpu_is_preempted,
-		    PV_VCPU_PREEMPTED_ASM, .text);
+DEFINE_ASM_FUNC(__raw_callee_save___kvm_vcpu_is_preempted,
+		PV_VCPU_PREEMPTED_ASM, .text);
 #endif
 
 static void __init kvm_guest_init(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 97f1436c1a20..32792b033de2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -34,14 +34,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/gsseg.h>
 
-/*
- * nop stub, which must not clobber anything *including the stack* to
- * avoid confusing the entry prologues.
- */
-DEFINE_PARAVIRT_ASM(_paravirt_nop, "", .entry.text);
-
 /* stub always returning 0. */
-DEFINE_PARAVIRT_ASM(paravirt_ret0, "xor %eax,%eax", .entry.text);
+DEFINE_ASM_FUNC(paravirt_ret0, "xor %eax,%eax", .entry.text);
 
 void __init default_banner(void)
 {
@@ -49,12 +43,6 @@ void __init default_banner(void)
 	       pv_info.name);
 }
 
-/* Undefined instruction for dealing with missing ops pointers. */
-noinstr void paravirt_BUG(void)
-{
-	BUG();
-}
-
 static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 				    unsigned long addr, unsigned len)
 {
@@ -64,11 +52,11 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-DEFINE_PARAVIRT_ASM(_paravirt_ident_64, "mov %rdi, %rax", .text);
-DEFINE_PARAVIRT_ASM(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
+DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
+DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_irq_disable, "cli", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
@@ -96,9 +84,9 @@ unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 	unsigned ret;
 
 	if (opfunc == NULL)
-		/* If there's no function, patch it with paravirt_BUG() */
-		ret = paravirt_patch_call(insn_buff, paravirt_BUG, addr, len);
-	else if (opfunc == _paravirt_nop)
+		/* If there's no function, patch it with x86_BUG() */
+		ret = paravirt_patch_call(insn_buff, x86_BUG, addr, len);
+	else if (opfunc == x86_nop)
 		ret = 0;
 	else
 		/* Otherwise call the function. */
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 6092fea7d651..5d132f5a5d7d 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -45,7 +45,7 @@ static const typeof(pv_ops) xen_irq_ops __initconst = {
 		/* Initial interrupt flag handling only called while interrupts off. */
 		.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0),
 		.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop),
-		.irq_enable = __PV_IS_CALLEE_SAVE(paravirt_BUG),
+		.irq_enable = __PV_IS_CALLEE_SAVE(x86_BUG),
 
 		.safe_halt = xen_safe_halt,
 		.halt = xen_halt,
-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
