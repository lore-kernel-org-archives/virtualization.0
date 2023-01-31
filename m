Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B04C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 08:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B302F813A9;
	Tue, 31 Jan 2023 08:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B302F813A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=P99yUkPK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kz2AWV4hRZ8o; Tue, 31 Jan 2023 08:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CD41813A4;
	Tue, 31 Jan 2023 08:51:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CD41813A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 030B6C0032;
	Tue, 31 Jan 2023 08:51:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB6EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BCDF813A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 08:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BCDF813A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvEh81nN4Emb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 08:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 950428135C
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 950428135C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dIxm+aCWThEzSn6DIW8FvWBq3c9pv2ibQNS0mHEtmHY=; b=P99yUkPKlFO6Em1noB0wAC0mbH
 VVTyTjchkZs8oTDX6DrLsSDzY4w1iEM7Eq83RPSTC6hbJWvJvsD7eNhZ6CKLRYtCAAjCdFdS+HfI1
 aX4w//t5QEWYp1BLw0UGYf+SnVlyPZDFZr+8ujXvuZH/6C0CnmipvNW6SUlpSmcuGWKGNZMwyJ/C8
 osew0SUGCAOdIAXP1ZD/FUbFzZME+QADr0FIX1E5t0otYJ4Dusdj+9abhDnbB2ZqoTh+qFCJmYY3R
 D1CwEnmecBYG7aaYsUp+dFCskwvnPYeyrAx9mqsIK0clEyzBgdS0EIpPCyxgDKlzHyzLEU+GDj/kH
 qNiRlCmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMmLe-00BA4r-Iv; Tue, 31 Jan 2023 08:50:39 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDED43002BF;
 Tue, 31 Jan 2023 09:50:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A1741208358FD; Tue, 31 Jan 2023 09:50:36 +0100 (CET)
Date: Tue, 31 Jan 2023 09:50:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH v2.1 4/9] tracing, preempt: Squash _rcuidle tracing
Message-ID: <Y9jWXKgkxY5EZVwW@hirez.programming.kicks-ass.net>
References: <20230126150829.087606759@infradead.org>
 <20230126151323.526275416@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230126151323.526275416@infradead.org>
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 pv-drivers@vmware.com, lpieralisi@kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, mingo@redhat.com, mgorman@suse.de,
 longman@redhat.com, frederic@kernel.org, linux-trace-kernel@vger.kernel.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, bp@alien8.de, vincent.guittot@linaro.org,
 boris.ostrovsky@oracle.com, dietmar.eggemann@arm.com, jgross@suse.com,
 seanjc@google.com, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
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


Extend commit 9aedeaed6fc6 ("tracing, hardirq: No moar _rcuidle()
tracing") to also cover trace_preempt_{on,off}() which were
mysteriously untouched.

Fixes: 9aedeaed6fc6 ("tracing, hardirq: No moar _rcuidle() tracing")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/Y9D5AfnOukWNOZ5q@hirez.programming.kicks-ass.net
---
 kernel/trace/trace_preemptirq.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -15,10 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-/* Per-cpu variable to prevent redundant calls when IRQs already off */
-static DEFINE_PER_CPU(int, tracing_irq_cpu);
-
 /*
  * Use regular trace points on architectures that implement noinstr
  * tooling: these calls will only happen with RCU enabled, which can
@@ -33,6 +29,10 @@ static DEFINE_PER_CPU(int, tracing_irq_c
 #define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
 #endif
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+/* Per-cpu variable to prevent redundant calls when IRQs already off */
+static DEFINE_PER_CPU(int, tracing_irq_cpu);
+
 /*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
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
