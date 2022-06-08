Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35AFCCA486
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 14:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 613B141188;
	Wed,  8 Jun 2022 14:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVuQohzlUZi8; Wed,  8 Jun 2022 14:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A673A40592;
	Wed,  8 Jun 2022 14:47:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDD23C0084;
	Wed,  8 Jun 2022 14:47:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 136B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BD2542491
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id llu0Ss3wyEvH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A58B441A4F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=n+8kbD5k3joQL4tu1DQuka314sY5HtbiPc/MGM3uXCw=; b=CFsFgByJSeY2PmftE59lIwd61A
 fjJ72jju0l9GwBYm1tDQavNTQt1uwtfxtPtqec7K6IBFRtI8mUyMjSb23xu2nggDLQ3Izti62YLZ9
 81i/g9DPcf892kC/BAGwIehJW/W7Fewyul66uCAJh+Bsk0BWV05Jio2VzipiczXpOVQR7AS6M8em5
 wh3T1DJLe1ciqy+OR6gyRoeQARA3peLCGum9kfZYaXxBeujZ3coueZc7Rw5XccGKhOx8fJer5LVm7
 DK6L3i+rJEhIKvEmmEfkmunPBAh5TavkMzTbRzPaMqLIGOwpl+o4n2Ge2dXsInCxEuWYARNglpkyB
 ylWDIb/Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nywx3-0066CO-6k; Wed, 08 Jun 2022 14:46:30 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A15F3302ECB;
 Wed,  8 Jun 2022 16:46:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 8D44D20C10ED6; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144517.251109029@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 21/36] x86/tdx: Remove TDX_HCALL_ISSUE_STI
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org,
 agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com,
 catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com,
 mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org,
 paulus@samba.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 mathieu.desnoyers@efficios.com, frederic@kernel.org, lenb@kernel.org,
 linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, shorne@gmail.com,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, sboyd@kernel.org,
 dinguyen@kernel.org, bristot@redhat.com, alexander.shishkin@linux.intel.com,
 lpieralisi@kernel.org, linux@rasmusvillemoes.dk, joel@joelfernandes.org,
 will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
 linux-csky@vger.kernel.org, pv-drivers@vmware.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, vgupta@kernel.org, linux-clk@vger.kernel.org,
 josh@joshtriplett.org, rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net,
 kirill.shutemov@linux.intel.com, dalias@libc.org, tony@atomide.com,
 amakhalov@vmware.com, bjorn.andersson@linaro.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv@lists.infradead.org, Isaku Yamahata <isaku.yamahata@gmail.com>,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se, yury.norov@gmail.com,
 richard@nod.at, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 aou@eecs.berkeley.edu, paulmck@kernel.org, hca@linux.ibm.com,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 paul.walmsley@sifive.com, linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
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

Now that arch_cpu_idle() is expected to return with IRQs disabled,
avoid the useless STI/CLI dance.

Per the specs this is supposed to work, but nobody has yet relied up
this behaviour so broken implementations are possible.

Cc: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: kirill.shutemov@linux.intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/coco/tdx/tdcall.S        |   13 -------------
 arch/x86/coco/tdx/tdx.c           |   23 ++++-------------------
 arch/x86/include/asm/shared/tdx.h |    1 -
 3 files changed, 4 insertions(+), 33 deletions(-)

--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -139,19 +139,6 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
-	/*
-	 * For the idle loop STI needs to be called directly before the TDCALL
-	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
-	 * interrupts only one instruction later. If there is a window between
-	 * STI and the instruction that emulates the HALT state, there is a
-	 * chance for interrupts to happen in this window, which can delay the
-	 * HLT operation indefinitely. Since this is the not the desired
-	 * result, conditionally call STI before TDCALL.
-	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
-	jz .Lskip_sti
-	sti
-.Lskip_sti:
 	tdcall
 
 	/*
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -124,7 +124,7 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
 
-static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
+static u64 __cpuidle __halt(const bool irq_disabled)
 {
 	struct tdx_hypercall_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
@@ -144,20 +144,14 @@ static u64 __cpuidle __halt(const bool i
 	 * can keep the vCPU in virtual HLT, even if an IRQ is
 	 * pending, without hanging/breaking the guest.
 	 */
-	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
+	return __tdx_hypercall(&args, 0);
 }
 
 static bool handle_halt(void)
 {
-	/*
-	 * Since non safe halt is mainly used in CPU offlining
-	 * and the guest will always stay in the halt state, don't
-	 * call the STI instruction (set do_sti as false).
-	 */
 	const bool irq_disabled = irqs_disabled();
-	const bool do_sti = false;
 
-	if (__halt(irq_disabled, do_sti))
+	if (__halt(irq_disabled))
 		return false;
 
 	return true;
@@ -165,22 +159,13 @@ static bool handle_halt(void)
 
 void __cpuidle tdx_safe_halt(void)
 {
-	 /*
-	  * For do_sti=true case, __tdx_hypercall() function enables
-	  * interrupts using the STI instruction before the TDCALL. So
-	  * set irq_disabled as false.
-	  */
 	const bool irq_disabled = false;
-	const bool do_sti = true;
 
 	/*
 	 * Use WARN_ONCE() to report the failure.
 	 */
-	if (__halt(irq_disabled, do_sti))
+	if (__halt(irq_disabled))
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
-
-	/* XXX I can't make sense of what @do_sti actually does */
-	raw_local_irq_disable();
 }
 
 static bool read_msr(struct pt_regs *regs)
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -8,7 +8,6 @@
 #define TDX_HYPERCALL_STANDARD  0
 
 #define TDX_HCALL_HAS_OUTPUT	BIT(0)
-#define TDX_HCALL_ISSUE_STI	BIT(1)
 
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
