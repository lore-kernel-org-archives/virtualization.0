Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BDCC54EAA
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 15:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 128B4414E8;
	Wed, 25 Jan 2023 15:20:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 128B4414E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wnr_cVvJDvqc; Wed, 25 Jan 2023 15:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 711754118B;
	Wed, 25 Jan 2023 15:20:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 711754118B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D92CC0033;
	Wed, 25 Jan 2023 15:20:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBAB2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 15:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8608060FE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 15:20:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8608060FE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rtM6W7ZQHWVn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 15:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8201360F9E
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8201360F9E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 15:20:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF144B3;
 Wed, 25 Jan 2023 07:21:02 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com
 [10.1.31.176])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EEAD3F71E;
 Wed, 25 Jan 2023 07:20:16 -0800 (PST)
Date: Wed, 25 Jan 2023 15:20:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] A few cpuidle vs rcu fixes
Message-ID: <Y9FIqD21+DZU2kjV@FVFF77S0Q05N.cambridge.arm.com>
References: <20230123205009.790550642@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230123205009.790550642@infradead.org>
Cc: juri.lelli@redhat.com, daniel.lezcano@linaro.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, rafael@kernel.org, pv-drivers@vmware.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
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

Hi Peter,

On Mon, Jan 23, 2023 at 09:50:09PM +0100, Peter Zijlstra wrote:
> 0-day robot reported graph-tracing made the cpuidle-vs-rcu rework go splat.
> 
> These patches appear to cure this, the ftrace selftest now runs to completion
> without spamming scary messages to dmesg.

In addition to the other bits for arm64, we'll need the following patch. Are
you happy to add that to the start of this series?

I've tested this on an arm64 Juno board with a full-fat ftrace config,
CONFIG_PROVE_LOCKING + CONFIG_DEBUG_LOCKDEP, and CONFIG_DEBUG_VIRTUAL=y, and
build tested for 32-bit arm.

Thanks,
Mark.

---->8----
From 30ab9eba19e952cb51c9f599d2ac9b8a302cb63d Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 25 Jan 2023 14:20:49 +0000
Subject: [PATCH] drivers: firmware: psci: don't instrument suspend code

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
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 drivers/firmware/psci/psci.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f3a044fa4652a..c12847b4736de 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -108,9 +108,10 @@ bool psci_power_state_is_valid(u32 state)
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
 
@@ -118,9 +119,10 @@ static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
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
 
@@ -128,7 +130,7 @@ static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
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
 
@@ -177,13 +180,15 @@ static int __psci_cpu_suspend(u32 fn, u32 state, unsigned long entry_point)
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
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
