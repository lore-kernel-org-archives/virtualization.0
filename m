Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B331C678D4
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 19:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19ACD820DF;
	Thu, 12 Jan 2023 19:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19ACD820DF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WVuIFhrj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEQo2JGNQOE1; Thu, 12 Jan 2023 19:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACDB58201A;
	Thu, 12 Jan 2023 19:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACDB58201A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08FDBC008A;
	Thu, 12 Jan 2023 19:58:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85281C0089
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39A1981FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39A1981FFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lL2l8hMNsxYu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 116FB81FBD
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 116FB81FBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=US/ew+5Vik6jGnrGGiz1QKoghqD4+Lgz+zGR8hxwH/s=; b=WVuIFhrj78QG37MwfM8cwsGLW2
 6RIQ2dKuiBYGWybloHLp61YaKj0cdn/+fLnH2q0WBRmwtWG3yFLWrnccqDo7As6Ov+J9nISGa2R5A
 xzyVRpltpBTMUkFNRLUgPKwxWYfzryyd1cFJPVVp4kqW5FroibddKersX+5xp1NAN0mX2n/IX8uo5
 u3jIptEd8I2RoyVn4KMqbm+bH70AJzyzt5X9Z33H0C0Ne5yJWRvX5w2XDeRGpi6wP1+0NwsgdfANb
 Qs0TXnigQ3IWTW5HruR9gzoAZACuq68YDeONfYzScB1OF3/BKUWdpvZ2B5iPfLpEFiGMDiOvz9iPi
 Ew4yKZpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pG3hH-0045pK-38; Thu, 12 Jan 2023 19:57:14 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B61D2303449;
 Thu, 12 Jan 2023 20:57:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 2953C2CCF62B7; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.233779815@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 12 Jan 2023 20:43:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH v3 31/51] cpuidle,nospec: Make noinstr clean
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

vmlinux.o: warning: objtool: mwait_idle+0x47: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xa2: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0x91: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_s2idle+0x8c: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0xaa: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -310,7 +310,7 @@ static __always_inline void mds_user_cle
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
-static inline void mds_idle_clear_cpu_buffers(void)
+static __always_inline void mds_idle_clear_cpu_buffers(void)
 {
 	if (static_branch_likely(&mds_idle_clear))
 		mds_clear_cpu_buffers();


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
