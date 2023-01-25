Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DCAC27C76
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 09:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EDBF41685;
	Wed, 25 Jan 2023 09:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EDBF41685
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nQunn52b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTCAm3XzWp7I; Wed, 25 Jan 2023 09:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EA62415E7;
	Wed, 25 Jan 2023 09:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EA62415E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62758C0033;
	Wed, 25 Jan 2023 09:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B41E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8247C8211A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:40:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8247C8211A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=nQunn52b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpvOrRf0kkCU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:40:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78B4682029
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78B4682029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mAgJz+pic6BVmXYxBN+VWs/MMMnUkDDE/YC6Sdu0ab4=; b=nQunn52byOr6gIM3Gee8jkXqqf
 P6ahezAXaOoJgEZU94N64D+DY4WwzdeoQuN4TSrB2re+n+FRNKB313f7pWE3Axto20QcMUBKawlfC
 V1XlCuQ0HNEXvSEVlc9MCGGDKp9M9zX1BjIEPu/fEx26+EqvosBwmbH9b7QG7nRTmlygLzXEHtwKa
 mJAB4xNAatoGxBX1ofJIpGgNLMwT/i7t85iVTBKKH0Q4JXlZDCPTj6rQBK6UpcUUCjr/3q3NQMTAi
 6qzJSabUvHh49Pf9klLM7hSY7ZwtdmvWkG9b3eRbmn6kPYULi21KJSaokx6M+bIa4JJK6jTNUkaUe
 dH8i0crA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pKcGP-005onB-Pz; Wed, 25 Jan 2023 09:40:19 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29E27300137;
 Wed, 25 Jan 2023 10:40:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1094A21477E2E; Wed, 25 Jan 2023 10:40:17 +0100 (CET)
Date: Wed, 25 Jan 2023 10:40:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/6] A few cpuidle vs rcu fixes
Message-ID: <Y9D5AfnOukWNOZ5q@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <Y9AIj1s5iPPki3dK@FVFF77S0Q05N> <Y9AVtUY8bnF3WjQr@FVFF77S0Q05N>
 <Y9Al0PfSsx/VWL31@FVFF77S0Q05N>
 <Y9D31FHOCaSnO5gS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9D31FHOCaSnO5gS@hirez.programming.kicks-ass.net>
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

On Wed, Jan 25, 2023 at 10:35:16AM +0100, Peter Zijlstra wrote:
> tip/sched/core contains the following patch addressing this:
> 
> ---
> commit 9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Jan 12 20:43:49 2023 +0100
> 
>     tracing, hardirq: No moar _rcuidle() tracing
>     
>     Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
>     _rcuidle() tracepoint through local_irq_{en,dis}able().
>     
>     For 'sane' configs, these calls will only happen with RCU enabled and
>     as such can use the regular tracepoint. This also means it's possible
>     to trace them from NMI context again.
>     
>     Reported-by: kernel test robot <lkp@intel.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>     Link: https://lore.kernel.org/r/20230112195541.477416709@infradead.org
> 
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 629f2854e12b..f992444a0b1f 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -19,6 +19,20 @@
>  /* Per-cpu variable to prevent redundant calls when IRQs already off */
>  static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  
> +/*
> + * Use regular trace points on architectures that implement noinstr
> + * tooling: these calls will only happen with RCU enabled, which can
> + * use a regular tracepoint.
> + *
> + * On older architectures, use the rcuidle tracing methods (which
> + * aren't NMI-safe - so exclude NMI contexts):
> + */
> +#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#define trace(point)	trace_##point
> +#else
> +#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
> +#endif
> +
>  /*
>   * Like trace_hardirqs_on() but without the lockdep invocation. This is
>   * used in the low level entry code where the ordering vs. RCU is important

For some reason I missed the trace_preempt_{on,off} things, so that then
gets the below on top or so.

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f992444a0b1f..ea96b41c8838 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -100,15 +100,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	if (!in_nmi())
-		trace_preempt_enable_rcuidle(a0, a1);
+	trace(preempt_enable)(a0, a1);
 	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	if (!in_nmi())
-		trace_preempt_disable_rcuidle(a0, a1);
+	trace(preempt_disable)(a0, a1);
 	tracer_preempt_off(a0, a1);
 }
 #endif
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
