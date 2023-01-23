Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423ABC25B50
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 20:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA77C40B75;
	Mon, 23 Jan 2023 20:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA77C40B75
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=mnTOOg0X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yF3CIEfcTwCD; Mon, 23 Jan 2023 20:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E3694010F;
	Mon, 23 Jan 2023 20:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E3694010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05497C0032;
	Mon, 23 Jan 2023 20:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 735F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5332B60FC0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5332B60FC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=mnTOOg0X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jwnt2FkI_pJQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7811360E9D
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7811360E9D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=YEKkyvTZ05I2hq93YUH2assl5KDOT02g9Cn+Y86W8Rg=; b=mnTOOg0XrV4WQaWs8SDkyTd870
 AOXy0F8U69ylAPKd0Bj22aigz2fTag/FIRvErdlguRoxjrnM0OypFDE6S1vWQrjBZGeWY4Ll4eifA
 2TYoxsVgfCELCo2LAmT6StQd77sf54f/X3g9dtv6SlV7B+6SfiH8vo6Afz0D4LyN041bW5oVZQEmL
 wJTKOfFCTUiDtudmB5IBHXNLseVMvpkZfx2j3aqj6nukdEvfME1cMgkAvHeKpa2Gl4sVEk2GzwFUI
 SsquzAD1nbcZnlRrjSBi8t8ssbNVb3NCiWW+m9k8hxMwJDW9OgardpBYukVrHGMgSneTYsH144L+e
 a2YqqZTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pK3se-004WU2-SZ; Mon, 23 Jan 2023 20:57:29 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AB95300C22;
 Mon, 23 Jan 2023 21:57:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id D40E02075A6FB; Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Message-ID: <20230123205515.175774650@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 23 Jan 2023 21:50:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH 5/6] sched/clock: Make local_clock() noinstr
References: <20230123205009.790550642@infradead.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, bp@alien8.de,
 vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, pbonzini@redhat.com,
 bristot@redhat.com
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

With sched_clock() noinstr, provide a noinstr implementation of
local_clock().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/clock.h |    8 +++-----
 kernel/sched/clock.c        |   27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 11 deletions(-)

--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -45,7 +45,7 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock();
 }
 
-static inline u64 local_clock(void)
+static __always_inline u64 local_clock(void)
 {
 	return sched_clock();
 }
@@ -79,10 +79,8 @@ static inline u64 cpu_clock(int cpu)
 	return sched_clock_cpu(cpu);
 }
 
-static inline u64 local_clock(void)
-{
-	return sched_clock_cpu(raw_smp_processor_id());
-}
+extern u64 local_clock(void);
+
 #endif
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -93,7 +93,7 @@ struct sched_clock_data {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct sched_clock_data, sched_clock_data);
 
-notrace static inline struct sched_clock_data *this_scd(void)
+static __always_inline struct sched_clock_data *this_scd(void)
 {
 	return this_cpu_ptr(&sched_clock_data);
 }
@@ -244,12 +244,12 @@ late_initcall(sched_clock_init_late);
  * min, max except they take wrapping into account
  */
 
-notrace static inline u64 wrap_min(u64 x, u64 y)
+static __always_inline u64 wrap_min(u64 x, u64 y)
 {
 	return (s64)(x - y) < 0 ? x : y;
 }
 
-notrace static inline u64 wrap_max(u64 x, u64 y)
+static __always_inline u64 wrap_max(u64 x, u64 y)
 {
 	return (s64)(x - y) > 0 ? x : y;
 }
@@ -260,7 +260,7 @@ notrace static inline u64 wrap_max(u64 x
  *  - filter out backward motion
  *  - use the GTOD tick value to create a window to filter crazy TSC values
  */
-notrace static u64 sched_clock_local(struct sched_clock_data *scd)
+static __always_inline u64 sched_clock_local(struct sched_clock_data *scd)
 {
 	u64 now, clock, old_clock, min_clock, max_clock, gtod;
 	s64 delta;
@@ -287,13 +287,28 @@ notrace static u64 sched_clock_local(str
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (!try_cmpxchg64(&scd->clock, &old_clock, clock))
+	if (!arch_try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
 }
 
-notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
+noinstr u64 local_clock(void)
+{
+	u64 clock;
+
+	if (static_branch_likely(&__sched_clock_stable))
+		return sched_clock() + __sched_clock_offset;
+
+	preempt_disable_notrace();
+	clock = sched_clock_local(this_scd());
+	preempt_enable_notrace();
+
+	return clock;
+}
+EXPORT_SYMBOL_GPL(local_clock);
+
+static notrace u64 sched_clock_remote(struct sched_clock_data *scd)
 {
 	struct sched_clock_data *my_scd = this_scd();
 	u64 this_clock, remote_clock;


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
