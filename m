Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1589AC433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:32:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24ED22D04
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0sTLMzAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24ED22D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77EB62035D;
	Thu,  6 Aug 2020 11:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uw4OTsy6Qick; Thu,  6 Aug 2020 11:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A861B203C8;
	Thu,  6 Aug 2020 11:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51F00C0050;
	Thu,  6 Aug 2020 11:32:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12411C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 11:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F33B688270
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 11:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zspz68LaYQpi
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 11:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A8BA88267
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HOHNK/Wwh4r+dLOwnbPsU+//UraXJR2JWx5StwnIbMY=; b=0sTLMzAiW/vkKYsNYbSBHPq85f
 7mIVV3rtllIgLSoMUwHAx9bADSCyheIH3Vr9XuIsGYReUNEAeMFktXRBu1XGBWeKZkxtRReusdh5U
 JP2iR2+gZwXB7UvdMSRaKIlxmNQzO4osCTSBUOsGVvHgXjH/oys9VGYosHPXvwyai9EngYMt+4WJ1
 Lqj0FhWGWo/eSn4zUPc+aABDW5olIlv2gNInI59OVWK28yozeQFOlUGnqVEd3qFbE+rc462ZjgGNA
 mtKAu9/0zoXyyrb+scimVCT3nXnZz/RDf8/lv9RxevxiT/NPDVfZn41zArdgtRIFA3o4G3bZXHiyU
 YgEHUOZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3e8V-0006OU-91; Thu, 06 Aug 2020 11:32:39 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33BE7300446;
 Thu,  6 Aug 2020 13:32:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0DD6F2B61F1E7; Thu,  6 Aug 2020 13:32:36 +0200 (CEST)
Date: Thu, 6 Aug 2020 13:32:36 +0200
From: peterz@infradead.org
To: Marco Elver <elver@google.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
 <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net>
 <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806074723.GA2364872@elver.google.com>
Cc: jgross@suse.com, fenghua.yu@intel.com, yu-cheng.yu@intel.com, "Luck,
 Tony" <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 the arch/x86 maintainers <x86@kernel.org>
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

On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> Testing my hypothesis that raw then nested non-raw
> local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
> below. This is at least 1 case I can think of that we're bound to hit.

Aaargh!

> diff --git a/init/main.c b/init/main.c
> index 15bd0efff3df..0873319dcff4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1041,6 +1041,22 @@ asmlinkage __visible void __init start_kernel(void)
>  	sfi_init_late();
>  	kcsan_init();
>  
> +	/* DEBUG CODE */
> +	lockdep_assert_irqs_enabled(); /* Pass. */
> +	{
> +		unsigned long flags1;
> +		raw_local_irq_save(flags1);

This disables IRQs but doesn't trace..

> +		{
> +			unsigned long flags2;
> +			lockdep_assert_irqs_enabled(); /* Pass - expectedly blind. */

Indeed, we didn't trace the above disable, so software state is still
on.

> +			local_irq_save(flags2);

So here we save IRQ state, and unconditionally disable IRQs and trace
them disabled.

> +			lockdep_assert_irqs_disabled(); /* Pass. */
> +			local_irq_restore(flags2);

But here, we restore IRQ state to 'disabled' and explicitly trace it
disabled *again* (which is a bit daft, but whatever).

> +		}
> +		raw_local_irq_restore(flags1);

This then restores the IRQ state to enable, but no tracing.

> +	}
> +	lockdep_assert_irqs_enabled(); /* FAIL! */

And we're out of sync... :/

/me goes ponder things...

How's something like this then?

---
 include/linux/sched.h |  3 ---
 kernel/kcsan/core.c   | 62 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 06ec60462af0..2f5aef57e687 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1193,9 +1193,6 @@ struct task_struct {
 
 #ifdef CONFIG_KCSAN
 	struct kcsan_ctx		kcsan_ctx;
-#ifdef CONFIG_TRACE_IRQFLAGS
-	struct irqtrace_events		kcsan_save_irqtrace;
-#endif
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9147ff6a12e5..9c4436bf0561 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -291,17 +291,50 @@ static inline unsigned int get_delay(void)
 				0);
 }
 
-void kcsan_save_irqtrace(struct task_struct *task)
+/*
+ * KCSAN hooks are everywhere, which means they're NMI like for interrupt
+ * tracing. In order to present a 'normal' as possible context to the code
+ * called by KCSAN when reporting errors we need to update the irq-tracing
+ * state.
+ *
+ * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
+ * runtime is entered for every memory access, and potentially useful
+ * information is lost if dirtied by KCSAN.
+ */
+
+struct kcsan_irq_state {
+	unsigned long		flags;
+#ifdef CONFIG_TRACE_IRQFLAGS
+	int			hardirqs;
+	struct irqtrace_events	irqtrace;
+#endif
+};
+
+void kcsan_save_irqtrace(struct kcsan_irq_state *irq_state)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
-	task->kcsan_save_irqtrace = task->irqtrace;
+	irq_state->irqtrace = task->irqtrace;
+	irq_state->hardirq = lockdep_hardirqs_enabled();
 #endif
+	if (!kcsan_interrupt_watcher) {
+		raw_local_irq_save(irq_state->flags);
+		lockdep_hardirqs_off(CALLER_ADDR0);
+	}
 }
 
-void kcsan_restore_irqtrace(struct task_struct *task)
+void kcsan_restore_irqtrace(struct kcsan_irq_state *irq_state)
 {
+	if (!kcsan_interrupt_watcher) {
+#ifdef CONFIG_TRACE_IRQFLAGS
+		if (irq_state->hardirqs) {
+			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			lockdep_hardirqs_on(CALLER_ADDR0);
+		}
+#endif
+		raw_local_irq_restore(irq_state->flags);
+	}
 #ifdef CONFIG_TRACE_IRQFLAGS
-	task->irqtrace = task->kcsan_save_irqtrace;
+	task->irqtrace = irq_state->irqtrace;
 #endif
 }
 
@@ -350,11 +383,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
-		kcsan_save_irqtrace(current);
+		struct kcsan_irq_state irqstate;
+
+		kcsan_save_irqtrace(&irqstate);
 		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
 			     watchpoint - watchpoints);
-		kcsan_restore_irqtrace(current);
+		kcsan_restore_irqtrace(&irqstate);
 	} else {
 		/*
 		 * The other thread may not print any diagnostics, as it has
@@ -387,7 +422,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
-	unsigned long irq_flags = 0;
+	struct kcsan_irq_state irqstate;
 
 	/*
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
@@ -412,14 +447,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
-	/*
-	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
-	 * runtime is entered for every memory access, and potentially useful
-	 * information is lost if dirtied by KCSAN.
-	 */
-	kcsan_save_irqtrace(current);
-	if (!kcsan_interrupt_watcher)
-		local_irq_save(irq_flags);
+	kcsan_save_irqtrace(&irqstate);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -559,9 +587,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	remove_watchpoint(watchpoint);
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	if (!kcsan_interrupt_watcher)
-		local_irq_restore(irq_flags);
-	kcsan_restore_irqtrace(current);
+	kcsan_restore_irqtrace(&irqstate);
 out:
 	user_access_restore(ua_flags);
 }


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
