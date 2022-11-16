Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BDBC4332F
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 11:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18D1A40BA3;
	Wed, 16 Nov 2022 11:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18D1A40BA3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=K6uhjY9g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id idmF-WzcFT5C; Wed, 16 Nov 2022 11:05:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A7BD40BB7;
	Wed, 16 Nov 2022 11:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A7BD40BB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CA20C0033;
	Wed, 16 Nov 2022 11:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF923C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 11:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C86F081FC9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 11:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C86F081FC9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=K6uhjY9g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gpIh5L8tvgIX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 11:05:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9013E81FC5
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9013E81FC5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QyKiutDikhqtS5evWJD5nb7g0g7xU4H4zTVUxJYpfM8=; b=K6uhjY9gwFNHqXVdDbhpIEUdLR
 jZRDd+XKhIeALbMBKjreKK/oKfKOULj7trqauk/XtRdJ86A+Loh6GwSb3iwJ9IDCAvchKzSwK16J9
 PcZg0m+r2fApfkx9TKxQHwexAK/Y4m72EMRlgf3RJ6lJ03PMk/kjDe2juQ9aK9AxLutmEPKXO0qoA
 PSp7SoIteknW9c6ZY8hPceu0P9/m4Ike4w7AbOlIqVNm9hkoezH4+42F6NSSt8ZrgGIksHWicgCzL
 b+y7yA+SGJM5wfdVQFspnWK8GrJyAECimgvts4fKBDM1g1HVDmuBf/ORW4cxKhLSXXkXGnFy9LEkg
 Dlk40q8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ovGE1-00HJpL-Dn; Wed, 16 Nov 2022 11:05:01 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5203530002E;
 Wed, 16 Nov 2022 12:04:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3B052201079F4; Wed, 16 Nov 2022 12:04:53 +0100 (CET)
Date: Wed, 16 Nov 2022 12:04:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] x86/paravirt: use common macro for creating simple
 asm paravirt functions
Message-ID: <Y3TD1R9BOb4avCWp@hirez.programming.kicks-ass.net>
References: <20221109134418.6516-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221109134418.6516-1-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wanpeng Li <wanpengli@tencent.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 09, 2022 at 02:44:18PM +0100, Juergen Gross wrote:
> There are some paravirt assembler functions which are sharing a common
> pattern. Introduce a macro DEFINE_PARAVIRT_ASM() for creating them.
> 
> Note that this macro is including explicit alignment of the generated
> functions, leading to __raw_callee_save___kvm_vcpu_is_preempted(),
> _paravirt_nop() and paravirt_ret0() to be aligned at 4 byte boundaries
> now.
> 
> The explicit _paravirt_nop() prototype in paravirt.c isn't needed, as
> it is included in paravirt_types.h already.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> ---

Seems nice; I've made the below little edits, but this is certainly a
bit large for /urgent at this point in time. So how about I merge
locking/urgent into x86/paravirt and munge this on top?

---
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -737,7 +737,7 @@ static __always_inline unsigned long arc
 	     __ALIGN_STR "\n"				\
 	     #func ":\n\t"				\
 	     ASM_ENDBR					\
-	     instr					\
+	     instr "\n\t"				\
 	     ASM_RET					\
 	     ".size " #func ", . - " #func "\n\t"	\
 	     ".popsection")
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -54,8 +54,8 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_
 	"pop    %rdx\n\t"						\
 	FRAME_END
 
-DEFINE_PARAVIRT_ASM(__raw_callee_save___pv_queued_spin_unlock, PV_UNLOCK_ASM,
-		    .spinlock.text);
+DEFINE_PARAVIRT_ASM(__raw_callee_save___pv_queued_spin_unlock,
+		    PV_UNLOCK_ASM, .spinlock.text);
 
 #else /* CONFIG_64BIT */
 
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -802,6 +802,7 @@ extern bool __raw_callee_save___kvm_vcpu
  "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
  "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
  "setne  %al\n\t"
+
 DEFINE_PARAVIRT_ASM(__raw_callee_save___kvm_vcpu_is_preempted,
 		    PV_VCPU_PREEMPTED_ASM, .text);
 #endif
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -40,8 +40,7 @@
 DEFINE_PARAVIRT_ASM(_paravirt_nop, "", .entry.text);
 
 /* stub always returning 0. */
-#define PV_RET0_ASM	"xor %" _ASM_AX ", %" _ASM_AX "\n\t"
-DEFINE_PARAVIRT_ASM(paravirt_ret0, PV_RET0_ASM, .entry.text);
+DEFINE_PARAVIRT_ASM(paravirt_ret0, "xor %eax,%eax", .entry.text);
 
 void __init default_banner(void)
 {
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
