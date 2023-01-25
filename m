Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5A4C27C76
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 09:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB1A61129;
	Wed, 25 Jan 2023 09:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDB1A61129
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=e680t7c+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrxXXT8JQnq3; Wed, 25 Jan 2023 09:36:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 522C461100;
	Wed, 25 Jan 2023 09:36:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 522C461100
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2869BC0033;
	Wed, 25 Jan 2023 09:36:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3CA6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99EAE404F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99EAE404F0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=e680t7c+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-dHbBbz7n0O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:35:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 091CD403CA
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 091CD403CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=94cPtMPijRXHZ2atOx7QWcREoDQC5Q27omNgVdsq1y8=; b=e680t7c+TsS9MUZvgFF6hBMlsB
 PwB4CFm9e/PZ+BkWwWKhszdOAHfcWa3IR7xlIXqaukuHR+jfUE+MLnAbaMXb8j2t0OW824ou4CqdQ
 +pCkQ0ENwyJnNHw0CANAaa1zGHqKSqON51RJynP74co29G9J31KlAZahstBzlVJSwuE2C1GdLer9W
 zvkBzPpYXKLB4ub23/08qU5g89vqL7Ret9nXUOQNkrNn1c3WPcupoBXOqyXllljCzxjmMKqoUGDtY
 CpPn75viM7gInC2UgEVkTIDOmSOMvOkUXR0CKOJpISZTT6TNrClVw3CwCQ6rHHuEi/JNHfCRERg8H
 IHOTdFKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pKcB4-002777-33; Wed, 25 Jan 2023 09:34:47 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F39A4300577;
 Wed, 25 Jan 2023 10:35:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id D537520774388; Wed, 25 Jan 2023 10:35:16 +0100 (CET)
Date: Wed, 25 Jan 2023 10:35:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/6] A few cpuidle vs rcu fixes
Message-ID: <Y9D31FHOCaSnO5gS@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <Y9AIj1s5iPPki3dK@FVFF77S0Q05N> <Y9AVtUY8bnF3WjQr@FVFF77S0Q05N>
 <Y9Al0PfSsx/VWL31@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9Al0PfSsx/VWL31@FVFF77S0Q05N>
Cc: juri.lelli@redhat.com, daniel.lezcano@linaro.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, rafael@kernel.org, pv-drivers@vmware.com,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 bsegall@google.com, amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, bp@alien8.de,
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

On Tue, Jan 24, 2023 at 06:39:12PM +0000, Mark Rutland wrote:
> On Tue, Jan 24, 2023 at 05:30:29PM +0000, Mark Rutland wrote:
> > On Tue, Jan 24, 2023 at 04:34:23PM +0000, Mark Rutland wrote:
> > > Hi Peter,
> > > 
> > > On Mon, Jan 23, 2023 at 09:50:09PM +0100, Peter Zijlstra wrote:
> > > > 0-day robot reported graph-tracing made the cpuidle-vs-rcu rework go splat.
> > > 
> > > Do you have a link toe the splat somewhere?
> > > 
> > > I'm assuming that this is partially generic, and I'd like to make sure I test
> > > the right thing on arm64. I'll throw my usual lockdep options at the ftrace
> > > selftests...
> > 
> > Hmm... with the tip sched/core branch, with or without this series applied atop
> > I see a couple of splats which I don't see with v6.2-rc1 (which seems to be
> > entirely clean). I'm not seeing any other splats.
> > 
> > I can trigger those reliably with the 'toplevel-enable.tc' ftrace test:
> > 
> >   ./ftracetest test.d/event/toplevel-enable.tc
> > 
> > Splats below; I'll dig into this a bit more tomorrow.
> > 
> > [   65.729252] ------------[ cut here ]------------
> > [   65.730397] WARNING: CPU: 3 PID: 1162 at include/trace/events/preemptirq.h:55 trace_preempt_on+0x68/0x70
> 
> The line number here is a bit inscrutible, but a bisect led me down to commit
> 
>   408b961146be4c1a ("tracing: WARN on rcuidle")
> 
> ... and it appears this must be the RCUIDLE_COND() warning that adds, and that
> seems to be because trace_preempt_on() calls trace_preempt_enable_rcuidle():
> 
> | void trace_preempt_on(unsigned long a0, unsigned long a1)
> | {
> |         if (!in_nmi())
> |                 trace_preempt_enable_rcuidle(a0, a1);
> |         tracer_preempt_on(a0, a1);
> | }
> 
> It looks like that tracing is dependend upon CONFIG_TRACE_PREEMPT_TOGGLE, and I
> have that because I enabled CONFIG_PREEMPT_TRACER. I reckon the same should
> happen on x86 with CONFIG_PREEMPT_TRACER=y.
> 
> IIUC we'll need to clean up that trace_.*_rcuidle() usage too, but I'm not
> entirely sure how to do that.

tip/sched/core contains the following patch addressing this:

---
commit 9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jan 12 20:43:49 2023 +0100

    tracing, hardirq: No moar _rcuidle() tracing
    
    Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
    _rcuidle() tracepoint through local_irq_{en,dis}able().
    
    For 'sane' configs, these calls will only happen with RCU enabled and
    as such can use the regular tracepoint. This also means it's possible
    to trace them from NMI context again.
    
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Link: https://lore.kernel.org/r/20230112195541.477416709@infradead.org

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 629f2854e12b..f992444a0b1f 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,20 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+/*
+ * Use regular trace points on architectures that implement noinstr
+ * tooling: these calls will only happen with RCU enabled, which can
+ * use a regular tracepoint.
+ *
+ * On older architectures, use the rcuidle tracing methods (which
+ * aren't NMI-safe - so exclude NMI contexts):
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point)	trace_##point
+#else
+#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
+#endif
+
 /*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
@@ -28,8 +42,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -40,8 +53,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -63,8 +75,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 }
@@ -78,8 +89,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
