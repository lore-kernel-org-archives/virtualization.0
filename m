Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28EC54EBE
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 19:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7BAE820FF;
	Thu, 12 Jan 2023 19:58:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7BAE820FF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RaGKpqyq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsY21HlrUCWp; Thu, 12 Jan 2023 19:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2B4081FE0;
	Thu, 12 Jan 2023 19:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2B4081FE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 883C0C0083;
	Thu, 12 Jan 2023 19:58:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68FD4C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48F5D82000
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48F5D82000
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FM_V2TaXmP0a
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7FD081E5C
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7FD081E5C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=FFPKfQhi1RR6oz0II4O36iNGEMWuMWROzeT05TgEQqM=; b=RaGKpqyq/zK9SlNjTC2tjN4ED5
 sTgPIaymFfkI7cWpVV179CKQcVzEOQRVhnIy+noiuqisc8Y3evgKJUiyplvjl1HbKExAwqR1L5cRI
 cIpU16imzCqo4H4t8hHvrKs51Hazpcdis7GPW7WqWYyUnVJMo3glFbEV1YO1/KUq63xmw6zWRni8M
 q+r+jmD1JPS2/5f1tzIob5VJVF1mYTI34eulJXL7stW6BbKeXceClpw/C7VJmcL8rerOH+EyeRXAA
 pl/PB9yx4kOt4qfN/jVJ7FuSltcu2ISKODVX2TsZ0lYjwuJHXYkrRHUgz+IKATkftIztoqhxtkYgC
 NhZ8/Vwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pG3hK-0045pb-0L; Thu, 12 Jan 2023 19:57:25 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1DCA30345C;
 Thu, 12 Jan 2023 20:57:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 41DA72CD01200; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.599561742@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 12 Jan 2023 20:43:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH v3 37/51] cpuidle,omap3: Push RCU-idle into omap_sram_idle()
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

OMAP3 uses full SoC suspend modes as idle states, as such it needs the
whole power-domain and clock-domain code from the idle path.

All that code is not suitable to run with RCU disabled, as such push
RCU-idle deeper still.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    4 +---
 arch/arm/mach-omap2/pm.h          |    2 +-
 arch/arm/mach-omap2/pm34xx.c      |   12 ++++++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -133,9 +133,7 @@ static int omap3_enter_idle(struct cpuid
 	}
 
 	/* Execute ARM wfi */
-	ct_cpuidle_enter();
-	omap_sram_idle();
-	ct_cpuidle_exit();
+	omap_sram_idle(true);
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -29,7 +29,7 @@ static inline int omap4_idle_init(void)
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
-extern void omap_sram_idle(void);
+extern void omap_sram_idle(bool rcuidle);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 
 #if defined(CONFIG_PM_OPP)
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/cpuidle.h>
 
 #include <trace/events/power.h>
 
@@ -174,7 +175,7 @@ static int omap34xx_do_sram_idle(unsigne
 	return 0;
 }
 
-void omap_sram_idle(void)
+void omap_sram_idle(bool rcuidle)
 {
 	/* Variable to tell what needs to be saved and restored
 	 * in omap_sram_idle*/
@@ -254,11 +255,18 @@ void omap_sram_idle(void)
 	 */
 	if (save_state)
 		omap34xx_save_context(omap3_arm_context);
+
+	if (rcuidle)
+		ct_cpuidle_enter();
+
 	if (save_state == 1 || save_state == 3)
 		cpu_suspend(save_state, omap34xx_do_sram_idle);
 	else
 		omap34xx_do_sram_idle(save_state);
 
+	if (rcuidle)
+		ct_cpuidle_exit();
+
 	/* Restore normal SDRC POWER settings */
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
@@ -316,7 +324,7 @@ static int omap3_pm_suspend(void)
 
 	omap3_intc_suspend();
 
-	omap_sram_idle();
+	omap_sram_idle(false);
 
 restore:
 	/* Restore next_pwrsts */


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
