Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3824CCCA496
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 14:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A75761456;
	Wed,  8 Jun 2022 14:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXRxjowMLG8r; Wed,  8 Jun 2022 14:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F184A6144E;
	Wed,  8 Jun 2022 14:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A55FC0081;
	Wed,  8 Jun 2022 14:47:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4C3EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CA7A4116B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTfnEMtt8LEj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B976141174
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=O62myI6pQAS8t81lbED6UulH15u+VxDiccCxL8l46b0=; b=gT8EMkBd6bMPLcSrcn+tIlmqrQ
 gTlIn15eBCUJQJ7odUKeDR2ZWGk6cr6CL+IgYOg0zC0XwW4KvSjAi4QIaQShcZztyyB5uW4tjGOZ+
 Xx0k619Zyq8PzUIepWyk++0mEYVwQwRDrMoV5OMsBFqmPNytGFdVmw1KNESQJd2/bvekElwzIcwfq
 h9dM8RgSuGh8dAJ/hoh8FLTtUTAzinFeiF1y1HPLwogXCp0Uo4fTbKBO+SfwljZRT7cvOxCuC5v2c
 rVPi+OaAn7J4nbIx17Sn50Rh+9lBzO0j0yDzRiHN+flr/WJFb/Do9/yGDSiiRsQ1W4fIUFcfmvAbk
 rGLVyLLg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nywww-0066AY-GC; Wed, 08 Jun 2022 14:46:23 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B1E63021D5;
 Wed,  8 Jun 2022 16:46:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 3CA0E20C0F9A5; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144516.047149313@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 02/36] x86/idle: Replace x86_idle with a static_call
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org,
 agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com,
 catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com,
 mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org,
 paulus@samba.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 mathieu.desnoyers@efficios.com, frederic@kernel.org, lenb@kernel.org,
 linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, shorne@gmail.com,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, sboyd@kernel.org,
 dinguyen@kernel.org, bristot@redhat.com, alexander.shishkin@linux.intel.com,
 lpieralisi@kernel.org, linux@rasmusvillemoes.dk, joel@joelfernandes.org,
 will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
 linux-csky@vger.kernel.org, pv-drivers@vmware.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, vgupta@kernel.org, linux-clk@vger.kernel.org,
 josh@joshtriplett.org, rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net,
 dalias@libc.org, tony@atomide.com, amakhalov@vmware.com,
 bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se, yury.norov@gmail.com,
 richard@nod.at, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 aou@eecs.berkeley.edu, paulmck@kernel.org, hca@linux.ibm.com,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 paul.walmsley@sifive.com, linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
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

Typical boot time setup; no need to suffer an indirect call for that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/process.c |   50 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -24,6 +24,7 @@
 #include <linux/cpuidle.h>
 #include <linux/acpi.h>
 #include <linux/elf-randomize.h>
+#include <linux/static_call.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
@@ -692,7 +693,23 @@ void __switch_to_xtra(struct task_struct
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-static void (*x86_idle)(void);
+/*
+ * We use this if we don't have any better idle routine..
+ */
+void __cpuidle default_idle(void)
+{
+	raw_safe_halt();
+}
+#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+EXPORT_SYMBOL(default_idle);
+#endif
+
+DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
+
+static bool x86_idle_set(void)
+{
+	return !!static_call_query(x86_idle);
+}
 
 #ifndef CONFIG_SMP
 static inline void play_dead(void)
@@ -715,28 +732,17 @@ void arch_cpu_idle_dead(void)
 /*
  * Called from the generic idle code.
  */
-void arch_cpu_idle(void)
-{
-	x86_idle();
-}
-
-/*
- * We use this if we don't have any better idle routine..
- */
-void __cpuidle default_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
-	raw_safe_halt();
+	static_call(x86_idle)();
 }
-#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
-EXPORT_SYMBOL(default_idle);
-#endif
 
 #ifdef CONFIG_XEN
 bool xen_set_default_idle(void)
 {
-	bool ret = !!x86_idle;
+	bool ret = x86_idle_set();
 
-	x86_idle = default_idle;
+	static_call_update(x86_idle, default_idle);
 
 	return ret;
 }
@@ -859,20 +865,20 @@ void select_idle_routine(const struct cp
 	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
-	if (x86_idle || boot_option_idle_override == IDLE_POLL)
+	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
 		return;
 
 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
 		pr_info("using AMD E400 aware idle routine\n");
-		x86_idle = amd_e400_idle;
+		static_call_update(x86_idle, amd_e400_idle);
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
-		x86_idle = mwait_idle;
+		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		x86_idle = tdx_safe_halt;
+		static_call_update(x86_idle, tdx_safe_halt);
 	} else
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 }
 
 void amd_e400_c1e_apic_setup(void)
@@ -925,7 +931,7 @@ static int __init idle_setup(char *str)
 		 * To continue to load the CPU idle driver, don't touch
 		 * the boot_option_idle_override.
 		 */
-		x86_idle = default_idle;
+		static_call_update(x86_idle, default_idle);
 		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
 		/*


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
