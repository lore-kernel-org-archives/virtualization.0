Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D5C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 20:18:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB5D206DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 20:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zULSQsAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB5D206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 37F9922008;
	Tue, 11 Aug 2020 20:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCQN4uUMYy-w; Tue, 11 Aug 2020 20:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5FFC2037A;
	Tue, 11 Aug 2020 20:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC43C07FF;
	Tue, 11 Aug 2020 20:18:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 380F0C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 20:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 26EE085AB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 20:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zho-LbBNtNSB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 20:18:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 310228560C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LQfBOeOjjqS/nBAqElZF8KgMdzWHn+FKx6prXkYnbW4=; b=zULSQsAh02JS664sm85VUUbGih
 cK0gSoPEAcgmphhHuR6xfQKwwNeiaSPzZdVm8c0+NmHKrfBNMnDj4DH1ek/yhguOrGGiokFTIb59N
 cDFnYJIMPY9OSMCNQe/9MuJQ2ktHe4yJoJW20pHNXzsOVZL3TZkyEi7f5Ks/Zni6WVZa64xBjd6Hk
 GdlX1s4Rl2UFmitejGXIaSdHmReyFQAqWyS2FfKRe+bs21IRTe694scXMKUdKyoENFiGwG96ZkAU9
 9S+gC2u7Ic/MBCLGFHPOMB4lGVw2DLP/dhRz4p42OeQj/saxo1Zm/22ZmHRqOCWjelmGh1Vob0W8x
 z+BvRtPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5aid-0001H9-J1; Tue, 11 Aug 2020 20:17:59 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 916843012C3;
 Tue, 11 Aug 2020 22:17:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 76B9D2B05AEA1; Tue, 11 Aug 2020 22:17:55 +0200 (CEST)
Date: Tue, 11 Aug 2020 22:17:55 +0200
From: peterz@infradead.org
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200811201755.GI35926@hirez.programming.kicks-ass.net>
References: <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
 <20200811092054.GB2674@hirez.programming.kicks-ass.net>
 <20200811094651.GH35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200811094651.GH35926@hirez.programming.kicks-ass.net>
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, Marco Elver <elver@google.com>, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, the arch/x86 maintainers <x86@kernel.org>
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

On Tue, Aug 11, 2020 at 11:46:51AM +0200, peterz@infradead.org wrote:

> So let me once again see if I can't find a better solution for this all.
> Clearly it needs one :/

So the below boots without triggering the debug code from Marco -- it
should allow nesting local_irq_save/restore under raw_local_irq_*().

I tried unconditional counting, but there's some _reallly_ wonky /
asymmetric code that wrecks that and I've not been able to come up with
anything useful.

This one starts counting when local_irq_save() finds it didn't disable
IRQs while lockdep though it did. At that point, local_irq_restore()
will decrement and enable things again when it reaches 0.

This assumes local_irq_save()/local_irq_restore() are nested sane, which
is mostly true.

This leaves #PF, which I fixed in these other patches, but I realized it
needs fixing for all architectures :-( No bright ideas there yet.

---
 arch/x86/entry/thunk_32.S       |  5 ----
 include/linux/irqflags.h        | 45 +++++++++++++++++++-------------
 init/main.c                     | 16 ++++++++++++
 kernel/locking/lockdep.c        | 58 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_preemptirq.c | 33 +++++++++++++++++++++++
 5 files changed, 134 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 3a07ce3ec70b..f1f96d4d8cd6 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,11 +29,6 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index bd5c55755447..67e2a16d3846 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -23,12 +23,16 @@
   extern void lockdep_hardirqs_on_prepare(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_save(unsigned long ip, unsigned long flags);
+  extern void lockdep_hardirqs_restore(unsigned long ip, unsigned long flags);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on_prepare(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
+  static inline void lockdep_hardirqs_save(unsigned long ip, unsigned long flags) { }
+  static inline void lockdep_hardirqs_restore(unsigned long ip, unsigned long flags) { }
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -49,10 +53,13 @@ struct irqtrace_events {
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
-  extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_finish(void);
-  extern void trace_hardirqs_on(void);
-  extern void trace_hardirqs_off(void);
+extern void trace_hardirqs_on_prepare(void);
+extern void trace_hardirqs_off_finish(void);
+extern void trace_hardirqs_on(void);
+extern void trace_hardirqs_off(void);
+extern void trace_hardirqs_save(unsigned long flags);
+extern void trace_hardirqs_restore(unsigned long flags);
+
 # define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
@@ -120,17 +127,19 @@ do {						\
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
 # define trace_hardirqs_off_finish()		do { } while (0)
-# define trace_hardirqs_on()		do { } while (0)
-# define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context()	0
-# define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled()	0
-# define lockdep_softirqs_enabled(p)	0
-# define lockdep_hardirq_enter()	do { } while (0)
-# define lockdep_hardirq_threaded()	do { } while (0)
-# define lockdep_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define trace_hardirqs_on()			do { } while (0)
+# define trace_hardirqs_off()			do { } while (0)
+# define trace_hardirqs_save(flags)		do { } while (0)
+# define trace_hardirqs_restore(flags)		do { } while (0)
+# define lockdep_hardirq_context()		0
+# define lockdep_softirq_context(p)		0
+# define lockdep_hardirqs_enabled()		0
+# define lockdep_softirqs_enabled(p)		0
+# define lockdep_hardirq_enter()		do { } while (0)
+# define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit()			do { } while (0)
+# define lockdep_softirq_enter()		do { } while (0)
+# define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
 # define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
@@ -185,18 +194,18 @@ do {						\
 	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
 #define local_irq_disable() \
 	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		trace_hardirqs_save(flags);		\
 	} while (0)
 
-
 #define local_irq_restore(flags)			\
 	do {						\
 		if (raw_irqs_disabled_flags(flags)) {	\
 			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
+			trace_hardirqs_restore(flags);	\
 		} else {				\
 			trace_hardirqs_on();		\
 			raw_local_irq_restore(flags);	\
diff --git a/init/main.c b/init/main.c
index 15bd0efff3df..0873319dcff4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,22 @@ asmlinkage __visible void __init start_kernel(void)
 	sfi_init_late();
 	kcsan_init();
 
+	/* DEBUG CODE */
+	lockdep_assert_irqs_enabled(); /* Pass. */
+	{
+		unsigned long flags1;
+		raw_local_irq_save(flags1);
+		{
+			unsigned long flags2;
+			lockdep_assert_irqs_enabled(); /* Pass - expectedly blind. */
+			local_irq_save(flags2);
+			lockdep_assert_irqs_disabled(); /* Pass. */
+			local_irq_restore(flags2);
+		}
+		raw_local_irq_restore(flags1);
+	}
+	lockdep_assert_irqs_enabled(); /* FAIL! */
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3617abb08e31..2c88574b817c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3763,6 +3763,30 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
 
+static DEFINE_PER_CPU(int, hardirqs_disabled);
+
+void lockdep_hardirqs_restore(unsigned long ip, unsigned long flags)
+{
+	if (unlikely(!debug_locks))
+		return;
+
+	if (in_nmi()) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+		return;
+
+	if (__this_cpu_read(hardirqs_disabled) &&
+	    __this_cpu_dec_return(hardirqs_disabled) == 0) {
+
+		lockdep_hardirqs_on_prepare(ip);
+		lockdep_hardirqs_on(ip);
+	} else {
+		lockdep_hardirqs_off(ip);
+	}
+}
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_restore);
+
 /*
  * Hardirqs were disabled:
  */
@@ -3805,6 +3829,40 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
 
+void lockdep_hardirqs_save(unsigned long ip, unsigned long flags)
+{
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * Matching lockdep_hardirqs_on(), allow NMIs in the middle of lockdep;
+	 * they will restore the software state. This ensures the software
+	 * state is consistent inside NMIs as well.
+	 */
+	if (in_nmi()) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+		return;
+
+	/*
+	 * If IRQs were disabled, but IRQ tracking state said enabled we
+	 * 'missed' an update (or are nested inside raw_local_irq_*()) and
+	 * cannot rely on IRQ state to tell us when we should enable again.
+	 *
+	 * Count our way through this.
+	 */
+	if (raw_irqs_disabled_flags(flags)) {
+		if (__this_cpu_read(hardirqs_enabled)) {
+			WARN_ON_ONCE(__this_cpu_read(hardirqs_disabled) != 0);
+			__this_cpu_write(hardirqs_disabled, 1);
+		} else if (__this_cpu_read(hardirqs_disabled))
+			__this_cpu_inc(hardirqs_disabled);
+	}
+	lockdep_hardirqs_off(ip);
+}
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_save);
+
 /*
  * Softirqs will be enabled:
  */
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f10073e62603..080deaa1d9c9 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -85,6 +85,36 @@ void trace_hardirqs_off(void)
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
 
+void trace_hardirqs_save(unsigned long flags)
+{
+	lockdep_hardirqs_save(CALLER_ADDR0, flags);
+
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	}
+}
+EXPORT_SYMBOL(trace_hardirqs_save);
+NOKPROBE_SYMBOL(trace_hardirqs_save);
+
+void trace_hardirqs_restore(unsigned long flags)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+
+	lockdep_hardirqs_restore(CALLER_ADDR0, flags);
+}
+EXPORT_SYMBOL(trace_hardirqs_restore);
+NOKPROBE_SYMBOL(trace_hardirqs_restore);
+
+#ifdef __s390__
+
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
@@ -113,6 +143,9 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
+
+#endif /* __s390__ */
+
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
