Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA8BC54EED
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E17460D73;
	Thu, 26 Jan 2023 15:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E17460D73
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SCwG+pI8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QN6zxXmqTAjP; Thu, 26 Jan 2023 15:15:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA35B60BFE;
	Thu, 26 Jan 2023 15:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA35B60BFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B425CC0032;
	Thu, 26 Jan 2023 15:15:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF61C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AAA0415BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AAA0415BD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=SCwG+pI8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7LmktO6SNEHZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DDB4400B9
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DDB4400B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=pyTrMe3jhurI/BaMPEZBtDxCzUP65k9hfIEEnQDx/dc=; b=SCwG+pI8dtXiXs5fHX2T03qFh2
 FxmbB75QLDwxETIRu7SzBr44AIZPxkRheMoOz2leFrDzr7pCwCg96bSIE3YZ7ixOkCI8zeqUnWkeq
 yhMxx9kJ12vTPTX4yd9cZWPhKEpliYGXUXd6AlvngD7wny+Xocx/BBzCKGB02L8jbUewkukPrldTL
 g0wdXPHGwND+vSctF5py0h78sDcQ35z39TocjSH26Z2JWyeJTe/zQGOWfraVT7GlVvrLoKlJbnwgL
 m4iNuVXSYpt6iRhgxyWU6g7BLDonTQNB8dyyViN6YqjQXpJ44ZGL9o+Q8XtceVirkr/I2Ed3hkxap
 O+p80HNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pL3xn-006qUE-F4; Thu, 26 Jan 2023 15:14:56 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 298AA300657;
 Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 0AE0D2084C4A9; Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Message-ID: <20230126151323.349423061@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 26 Jan 2023 16:08:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH v2 1/9] drivers: firmware: psci: Dont instrument suspend code
References: <20230126150829.087606759@infradead.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, lpieralisi@kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mingo@redhat.com,
 mgorman@suse.de, longman@redhat.com, frederic@kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org,
 linux-pm@vger.kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 bp@alien8.de, vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
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

From: Mark Rutland <mark.rutland@arm.com>

The PSCI suspend code is currently instrumentable, which is not safe as
instrumentation (e.g. ftrace) may try to make use of RCU during idle
periods when RCU is not watching.

To fix this we need to ensure that psci_suspend_finisher() and anything
it calls are not instrumented. We can do this fairly simply by marking
psci_suspend_finisher() and the psci*_cpu_suspend() functions as
noinstr, and the underlying helper functions as __always_inline.

When CONFIG_DEBUG_VIRTUAL=y, __pa_symbol() can expand to an out-of-line
instrumented function, so we must use __pa_symbol_nodebug() within
psci_suspend_finisher().

The raw SMCCC invocation functions are written in assembly, and are not
subject to compiler instrumentation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/firmware/psci/psci.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -108,9 +108,10 @@ bool psci_power_state_is_valid(u32 state
 	return !(state & ~valid_mask);
 }
 
-static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
+static __always_inline unsigned long
+__invoke_psci_fn_hvc(unsigned long function_id,
+		     unsigned long arg0, unsigned long arg1,
+		     unsigned long arg2)
 {
 	struct arm_smccc_res res;
 
@@ -118,9 +119,10 @@ static unsigned long __invoke_psci_fn_hv
 	return res.a0;
 }
 
-static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
+static __always_inline unsigned long
+__invoke_psci_fn_smc(unsigned long function_id,
+		     unsigned long arg0, unsigned long arg1,
+		     unsigned long arg2)
 {
 	struct arm_smccc_res res;
 
@@ -128,7 +130,7 @@ static unsigned long __invoke_psci_fn_sm
 	return res.a0;
 }
 
-static int psci_to_linux_errno(int errno)
+static __always_inline int psci_to_linux_errno(int errno)
 {
 	switch (errno) {
 	case PSCI_RET_SUCCESS:
@@ -169,7 +171,8 @@ int psci_set_osi_mode(bool enable)
 	return psci_to_linux_errno(err);
 }
 
-static int __psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
+static __always_inline int
+__psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
 {
 	int err;
 
@@ -177,13 +180,15 @@ static int __psci_cpu_suspend(u32 fn, u3
 	return psci_to_linux_errno(err);
 }
 
-static int psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
+static __always_inline int
+psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	return __psci_cpu_suspend(psci_0_1_function_ids.cpu_suspend,
 				  state, entry_point);
 }
 
-static int psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
+static __always_inline int
+psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	return __psci_cpu_suspend(PSCI_FN_NATIVE(0_2, CPU_SUSPEND),
 				  state, entry_point);
@@ -447,10 +452,12 @@ late_initcall(psci_debugfs_init)
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-static int psci_suspend_finisher(unsigned long state)
+static noinstr int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
-	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
+	phys_addr_t pa_cpu_resume;
+
+	pa_cpu_resume = __pa_symbol_nodebug((unsigned long)cpu_resume);
 
 	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
