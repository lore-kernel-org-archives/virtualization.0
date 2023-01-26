Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5BC54E94
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 09:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 080CD81F00;
	Thu, 26 Jan 2023 09:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 080CD81F00
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fjkzkzH2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5XAfNLuuMkU; Thu, 26 Jan 2023 09:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 53777817C0;
	Thu, 26 Jan 2023 09:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53777817C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F0B4C0032;
	Thu, 26 Jan 2023 09:30:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF79C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 09:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25AF360D5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 09:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25AF360D5B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=fjkzkzH2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hzsbo6UhlOYo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 09:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAF096068A
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAF096068A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3DdXzjyKWRO1frq1uuF2XoBRpaROEpjsdhpGwWGHFaM=; b=fjkzkzH2IL3D6CrXISfe5PDcJ3
 nztCrKwnbbOsZd0b82sGhquv+EaQOZ9Okui7uVta/2gIuypyOmn8GlL36oAU4PnwgNm4FNAgEpCq5
 YhVrkwtSatfICZgLZiAPfUN22bSLyXhmY8G3b5vGqwePAXF6kKxN/077aXcXJ/5oO58M2rh+zZxMf
 Oas6C0dmM8Lg0kpBU1T1jQUb9HGCAlWAnkAEaEBb5p8prYGJ8g3D87kEn+XLoBUWOOC2rGadDf2Q0
 5iCHrtMm1C7li0PCgJytcgjKapLEv6D2cKXaxaa5eiP6qNP09v3EzOmsVsyItiQc5gwv6eHS96Q3d
 b0pTc7hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pKyYx-006bpo-9p; Thu, 26 Jan 2023 09:28:55 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DFEC300137;
 Thu, 26 Jan 2023 10:28:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 271E9212FFF4C; Thu, 26 Jan 2023 10:28:51 +0100 (CET)
Date: Thu, 26 Jan 2023 10:28:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <Y9JH0/Z06254ZJ2g@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
 <20230123165304.370121e7@gandalf.local.home>
 <20230123170753.7ac9419e@gandalf.local.home>
 <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
 <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
 <Y9EI0Gn/NUJt6GEk@hirez.programming.kicks-ass.net>
 <20230125184658.GL2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230125184658.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Cc: Mark Rutland <mark.rutland@arm.com>, juri.lelli@redhat.com,
 daniel.lezcano@linaro.org, wanpengli@tencent.com, kvm@vger.kernel.org,
 rafael@kernel.org, pv-drivers@vmware.com,
 Frederic Weisbecker <fweisbec@gmail.com>, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, Steven Rostedt <rostedt@goodmis.org>, bp@alien8.de,
 vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mhiramat@kernel.org,
 pbonzini@redhat.com, bristot@redhat.com
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

On Wed, Jan 25, 2023 at 10:46:58AM -0800, Paul E. McKenney wrote:

> > Ofc. Paul might have an opinion on this glorious bodge ;-)
> 
> For some definition of the word "glorious", to be sure.  ;-)
> 
> Am I correct that you have two things happening here?  (1) Preventing
> trace recursion and (2) forcing RCU to pay attention when needed.

Mostly just (1), we're in an error situation, I'm not too worried about
(2).

> I cannot resist pointing out that you have re-invented RCU_NONIDLE(),
> though avoiding much of the overhead when not needed.  ;-)

Yeah, this was the absolute minimal bodge I could come up with that
shuts up the rcu_derefence warning thing.

> I would have objections if this ever leaks out onto a non-error code path.

Agreed.

> There are things that need doing when RCU starts and stops watching,
> and this approach omits those things.  Which again is OK in this case,
> where this code is only ever executed when something is already broken,
> but definitely *not* OK when things are not already broken.

And agreed.

Current version of the bodge looks like so (will repost the whole series
a little later today).

I managed to tickle the recursion so that it was a test-case for the
stack guard...

With this on, it prints just the one WARN and lives.

---
Subject: bug: Disable rcu_is_watching() during WARN/BUG
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jan 25 13:57:49 CET 2023

In order to avoid WARN/BUG from generating nested or even recursive
warnings, force rcu_is_watching() true during
WARN/lockdep_rcu_suspicious().

Notably things like unwinding the stack can trigger rcu_dereference()
warnings, which then triggers more unwinding which then triggers more
warnings etc..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/context_tracking.h |   27 +++++++++++++++++++++++++++
 kernel/locking/lockdep.c         |    3 +++
 kernel/panic.c                   |    5 +++++
 lib/bug.c                        |   15 ++++++++++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -130,9 +130,36 @@ static __always_inline unsigned long ct_
 	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
+static __always_inline bool warn_rcu_enter(void)
+{
+	bool ret = false;
+
+	/*
+	 * Horrible hack to shut up recursive RCU isn't watching fail since
+	 * lots of the actual reporting also relies on RCU.
+	 */
+	preempt_disable_notrace();
+	if (rcu_dynticks_curr_cpu_in_eqs()) {
+		ret = true;
+		ct_state_inc(RCU_DYNTICKS_IDX);
+	}
+
+	return ret;
+}
+
+static __always_inline void warn_rcu_exit(bool rcu)
+{
+	if (rcu)
+		ct_state_inc(RCU_DYNTICKS_IDX);
+	preempt_enable_notrace();
+}
+
 #else
 static inline void ct_idle_enter(void) { }
 static inline void ct_idle_exit(void) { }
+
+static __always_inline bool warn_rcu_enter(void) { return false; }
+static __always_inline void warn_rcu_exit(bool rcu) { }
 #endif /* !CONFIG_CONTEXT_TRACKING_IDLE */
 
 #endif
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
+#include <linux/context_tracking.h>
 
 #include <asm/sections.h>
 
@@ -6555,6 +6556,7 @@ void lockdep_rcu_suspicious(const char *
 {
 	struct task_struct *curr = current;
 	int dl = READ_ONCE(debug_locks);
+	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
 	pr_warn("\n");
@@ -6595,5 +6597,6 @@ void lockdep_rcu_suspicious(const char *
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -34,6 +34,7 @@
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
 #include <linux/sysfs.h>
+#include <linux/context_tracking.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -679,6 +680,7 @@ void __warn(const char *file, int line,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
+	bool rcu = warn_rcu_enter();
 	struct warn_args args;
 
 	pr_warn(CUT_HERE);
@@ -693,11 +695,13 @@ void warn_slowpath_fmt(const char *file,
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
 #else
 void __warn_printk(const char *fmt, ...)
 {
+	bool rcu = warn_rcu_enter();
 	va_list args;
 
 	pr_warn(CUT_HERE);
@@ -705,6 +709,7 @@ void __warn_printk(const char *fmt, ...)
 	va_start(args, fmt);
 	vprintk(fmt, args);
 	va_end(args);
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL(__warn_printk);
 #endif
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/sched.h>
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
+#include <linux/context_tracking.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -153,7 +154,7 @@ struct bug_entry *find_bug(unsigned long
 	return module_find_bug(bugaddr);
 }
 
-enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	const char *file;
@@ -209,6 +210,18 @@ enum bug_trap_type report_bug(unsigned l
 	return BUG_TRAP_TYPE_BUG;
 }
 
+enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+{
+	enum bug_trap_type ret;
+	bool rcu = false;
+
+	rcu = warn_rcu_enter();
+	ret = __report_bug(bugaddr, regs);
+	warn_rcu_exit(rcu);
+
+	return ret;
+}
+
 static void clear_once_table(struct bug_entry *start, struct bug_entry *end)
 {
 	struct bug_entry *bug;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
