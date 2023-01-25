Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1B0C54EED
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 10:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A20F980F4C;
	Wed, 25 Jan 2023 10:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A20F980F4C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZpYPziHi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1wYoUh9BnIA; Wed, 25 Jan 2023 10:48:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 13B1981CDB;
	Wed, 25 Jan 2023 10:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13B1981CDB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD99CC0032;
	Wed, 25 Jan 2023 10:48:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A85A81D11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A85A81D11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGEwoRbAJ5hW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:48:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23A2981CDB
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23A2981CDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ur19YO34lAzxbIJXx6wXRY1oaiq2m1foajEK/7hgelM=; b=ZpYPziHizJDNiS+CWKyXU8QIqI
 J5s2qsIZIy753gFUyE3KoKdxRoe4OP1zfruBlS3ZWEPKf2xy0ctWk/elJ7C3htckgKb8DzenBOWZo
 7VLW54Ik+NbBarF6145B+n665M5u5S+RM9NmmEC3OECuL3PeuJMDw42Byv1/8Kz7oNBCVSzYDBczr
 qE46Pvswf7ig3RxbCjo22A0DvWTBID+AjgOtLFZsz6NvjM/LV+chqd4kClWx/ybS612zy7Lg1agUs
 /KGmrHsHY1OlYnE4auDjCJSvVXiXCbe4RlDSygceYhNDRZ4HsKNdp/CPUclN8oOpCMxolTtWzx4qL
 G9mZsPag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pKdJk-005r3F-IH; Wed, 25 Jan 2023 10:47:49 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9F6430036B;
 Wed, 25 Jan 2023 11:47:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CEBFE2C5B742E; Wed, 25 Jan 2023 11:47:44 +0100 (CET)
Date: Wed, 25 Jan 2023 11:47:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <Y9EI0Gn/NUJt6GEk@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
 <20230123165304.370121e7@gandalf.local.home>
 <20230123170753.7ac9419e@gandalf.local.home>
 <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
 <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
Cc: juri.lelli@redhat.com, daniel.lezcano@linaro.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, rafael@kernel.org, pv-drivers@vmware.com,
 Frederic Weisbecker <fweisbec@gmail.com>, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, Paul McKenney <paulmck@kernel.org>,
 linux-pm@vger.kernel.org, boqun.feng@gmail.com,
 Steven Rostedt <rostedt@goodmis.org>, bp@alien8.de, vincent.guittot@linaro.org,
 boris.ostrovsky@oracle.com, dietmar.eggemann@arm.com, jgross@suse.com,
 seanjc@google.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mhiramat@kernel.org, pbonzini@redhat.com, bristot@redhat.com
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

On Tue, Jan 24, 2023 at 05:12:14PM +0000, Mark Rutland wrote:
> On Tue, Jan 24, 2023 at 03:44:35PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 23, 2023 at 05:07:53PM -0500, Steven Rostedt wrote:
> > 
> > > Actually, perhaps we can just add this, and all you need to do is create
> > > and set CONFIG_NO_RCU_TRACING (or some other name).
> > 
> > Elsewhere I've used CONFIG_ARCH_WANTS_NO_INSTR for this.
> 
> Yes please; if we use CONFIG_ARCH_WANTS_NO_INSTR then arm64 will get this "for
> free" once we add the missing checks (which I assume we need) in our ftrace_prepare_return().
> 
> > Anyway, I took it for a spin and it .... doesn't seems to do the job.
> > 
> > With my patch the first splat is
> > 
> >   "RCU not on for: cpuidle_poll_time+0x0/0x70"
> > 
> > While with yours I seems to get the endless:
> > 
> >   "WARNING: suspicious RCU usage"
> > 
> > thing. Let me see if I can figure out where it goes side-ways.
> 
> Hmmm... for WARN_ONCE() don't we need to wake RCU first also? I thought we
> needed that at least for the printk machinery?

OK, the below seems to work nice for me -- although I'm still on a
hacked up printk, but the recursive RCU not watching fail seems to be
tamed.

Ofc. Paul might have an opinion on this glorious bodge ;-)

---

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index c303f7a114e9..d48cd92d2364 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -135,6 +135,21 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+# define trace_warn_on_no_rcu(ip)					\
+	({								\
+		bool __ret = !rcu_is_watching();			\
+		if (__ret && !trace_recursion_test(TRACE_RECORD_RECURSION_BIT)) { \
+			trace_recursion_set(TRACE_RECORD_RECURSION_BIT); \
+			WARN_ONCE(true, "RCU not on for: %pS\n", (void *)ip); \
+			trace_recursion_clear(TRACE_RECORD_RECURSION_BIT); \
+		}							\
+		__ret;							\
+	})
+#else
+# define trace_warn_on_no_rcu(ip)	false
+#endif
+
 /*
  * Preemption is promised to be disabled when return bit >= 0.
  */
@@ -144,6 +159,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
 
+	if (trace_warn_on_no_rcu(ip))
+		return -1;
+
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
diff --git a/lib/bug.c b/lib/bug.c
index c223a2575b72..0a10643ea168 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/sched.h>
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
+#include <linux/context_tracking.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -153,7 +154,7 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
 
-enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	const char *file;
@@ -209,6 +210,30 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	return BUG_TRAP_TYPE_BUG;
 }
 
+enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+{
+	enum bug_trap_type ret;
+	bool rcu = false;
+
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+	/*
+	 * Horrible hack to shut up recursive RCU isn't watching fail since
+	 * lots of the actual reporting also relies on RCU.
+	 */
+	if (!rcu_is_watching()) {
+		rcu = true;
+		ct_state_inc(RCU_DYNTICKS_IDX);
+	}
+#endif
+
+	ret = __report_bug(bugaddr, regs);
+
+	if (rcu)
+		ct_state_inc(RCU_DYNTICKS_IDX);
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
