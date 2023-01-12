Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA65C678D9
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 19:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C44EA414EC;
	Thu, 12 Jan 2023 19:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C44EA414EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Y8LFyBFl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNhibwTXgzNV; Thu, 12 Jan 2023 19:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE6BA414E4;
	Thu, 12 Jan 2023 19:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE6BA414E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF5CEC0094;
	Thu, 12 Jan 2023 19:58:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA00C007D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D85EB60E96
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D85EB60E96
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=Y8LFyBFl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4vcQLLsGlqaQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF09360E00
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF09360E00
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=RrpmTujnodPvC1LE/jXScgO4ZKUrxiQVlZ4+SEf4m04=; b=Y8LFyBFl3JbIwtnCWjFL/hhR5y
 twnVLexiBK1ooMbeDatb6RWwBocZW13sf5pirkWAWAH1nsW2rgd7ecx2Gc/qOdtvY6YZxKvumRcTm
 amulB5kgeQbRdQF87cEBBGyv4iJlugiK9kXbD+c92ulURa+BZ+6IgO0Q1qr4EELRq9g05K3UaslzX
 AWK5oxOOelmKqL4CSrymA461jkib6Q12hrzk8J/XFrR76pcWqThQ8X70scSBkUeWz1SP2e4AHdemR
 4sJ92NwETWbqsv5J5iWtGkWZGwcWClLra0VFFumQGPO8rMb8BpC/UsbZk6Ohp1wUq3mHnYc2/nqyR
 7VPa7mnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pG3hD-0045oB-09; Thu, 12 Jan 2023 19:57:08 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 117A63033FB;
 Thu, 12 Jan 2023 20:57:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id B27F62CCF1F50; Thu, 12 Jan 2023 20:57:07 +0100 (CET)
Message-ID: <20230112195539.883561913@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 12 Jan 2023 20:43:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH v3 09/51] cpuidle,omap3: Push RCU-idle into driver
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
Cc: juri.lelli@redhat.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org,
 nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-arch@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org,
 mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu,
 linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org,
 linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com,
 mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de,
 linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, linux-ia64@vger.kernel.org, alim.akhtar@samsung.com,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, will@kernel.org,
 brgl@bgdev.pl, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 dennis@kernel.org, frederic@kernel.org, lenb@kernel.org,
 linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev, shorne@gmail.com,
 chris@zankel.net, sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 alexander.shishkin@linux.intel.com, lpieralisi@kernel.org,
 atishp@atishpatra.org, linux@rasmusvillemoes.dk, kasan-dev@googlegroups.com,
 festevam@gmail.com, boris.ostrovsky@oracle.com, khilman@kernel.org,
 linux-csky@vger.kernel.org, pv-drivers@vmware.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, linux-clk@vger.kernel.org, rostedt@goodmis.org,
 ink@jurassic.park.msu.ru, bcain@quicinc.com, tsbogend@alpha.franken.de,
 linux-parisc@vger.kernel.org, konrad.dybcio@linaro.org, ryabinin.a.a@gmail.com,
 sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net,
 dalias@libc.org, tony@atomide.com, amakhalov@vmware.com, linux-mm@kvack.org,
 glider@google.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincenzo.frascino@arm.com, anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, mhiramat@kernel.org, aou@eecs.berkeley.edu,
 paulmck@kernel.org, hca@linux.ibm.com, richard.henderson@linaro.org,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 acme@kernel.org, paul.walmsley@sifive.com, linux-tegra@vger.kernel.org,
 namhyung@kernel.org, andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org,
 dvyukov@google.com, jgross@suse.com, monstr@monstr.eu, andersson@kernel.org,
 linux-mips@vger.kernel.org, krzysztof.kozlowski@linaro.org, palmer@dabbelt.com,
 anup@brainfault.org, bp@alien8.de, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org, deller@gmx.de
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

Doing RCU-idle outside the driver, only to then teporarily enable it
again before going idle is daft.

Notably the cpu_pm_*() calls implicitly re-enable RCU for a bit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -133,7 +133,9 @@ static int omap3_enter_idle(struct cpuid
 	}
 
 	/* Execute ARM wfi */
+	ct_idle_enter();
 	omap_sram_idle();
+	ct_idle_exit();
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
@@ -265,6 +267,7 @@ static struct cpuidle_driver omap3_idle_
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2 + 2,
 			.target_residency = 5,
@@ -272,6 +275,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10 + 10,
 			.target_residency = 30,
@@ -279,6 +283,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 50 + 50,
 			.target_residency = 300,
@@ -286,6 +291,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 1500 + 1800,
 			.target_residency = 4000,
@@ -293,6 +299,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2500 + 7500,
 			.target_residency = 12000,
@@ -300,6 +307,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 3000 + 8500,
 			.target_residency = 15000,
@@ -307,6 +315,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10000 + 30000,
 			.target_residency = 30000,
@@ -328,6 +337,7 @@ static struct cpuidle_driver omap3430_id
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 110 + 162,
 			.target_residency = 5,
@@ -335,6 +345,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 106 + 180,
 			.target_residency = 309,
@@ -342,6 +353,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 107 + 410,
 			.target_residency = 46057,
@@ -349,6 +361,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 121 + 3374,
 			.target_residency = 46057,
@@ -356,6 +369,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 855 + 1146,
 			.target_residency = 46057,
@@ -363,6 +377,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7580 + 4134,
 			.target_residency = 484329,
@@ -370,6 +385,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7505 + 15274,
 			.target_residency = 484329,


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
