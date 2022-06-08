Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0228CCCA48F
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 14:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DD3742517;
	Wed,  8 Jun 2022 14:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pC46oMX7jU_i; Wed,  8 Jun 2022 14:47:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0ED60424D7;
	Wed,  8 Jun 2022 14:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43FA1C008B;
	Wed,  8 Jun 2022 14:47:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A884C0083
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 456A083EEC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeMsO4JUdhyg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16CF283EE9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=p3ITF8gI2GW93+lJzbbS6NFG2q6U7tMgsXybvfaCekw=; b=IZXaFH74aF36MwDA0OcR+zpVbA
 fK18DkOhaaN9C1eG5s1+L4J5X2rdyrZWtHWtryVrvRYiz9kbVuWHWIVzgsfJfxFZ8UgI4eMrcfFM5
 ly+cYznO6PhU6shFXLnvDd0b/G1PXNb75sy24LC6bprnB0FmxiDeLgilEva9+AdZsD25bPgSLsRpe
 GUlfX77jG3iIxErkRylfvAiLV5VrXlgN4oApJfGBzUS+eVMlY/iFt5TC7UePOXm4aRWTFo8vVwc5V
 N9prIiiaKfHEwyVF5x1V2xztOpfeiRRaQZej2V9pcRWXnMPtP3IswDsfj7t5zg4WvO1/IMs6PKgfh
 Vu2f1Ucw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nywww-00ChVo-B5; Wed, 08 Jun 2022 14:46:22 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58CC930008D;
 Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 3237720C0F991; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608142723.103523089@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 00/36] cpuidle,rcu: Cleanup the mess
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi All! (omg so many)

These here few patches mostly clear out the utter mess that is cpuidle vs rcuidle.

At the end of the ride there's only 2 real RCU_NONIDLE() users left

  arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
  drivers/perf/arm_pmu.c:                 RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
  kernel/cfi.c:   RCU_NONIDLE({

(the CFI one is likely dead in the kCFI rewrite) and there's only a hand full
of trace_.*_rcuidle() left:

  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
  kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
  kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
  kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);

All of them are in 'deprecated' code that is unused for GENERIC_ENTRY.

I've touched a _lot_ of code that I can't test and likely broken some of it :/
In particular, the whole ARM cpuidle stuff was quite involved with OMAP being
the absolute 'winner'.

I'm hoping Mark can help me sort the remaining ARM64 bits as he moves that to
GENERIC_ENTRY. I've also got a note that says ARM64 can probably do a WFE based
idle state and employ TIF_POLLING_NRFLAG to avoid some IPIs.

---
 arch/alpha/kernel/process.c          |    1 
 arch/alpha/kernel/vmlinux.lds.S      |    1 
 arch/arc/kernel/process.c            |    3 +
 arch/arc/kernel/vmlinux.lds.S        |    1 
 arch/arm/include/asm/vmlinux.lds.h   |    1 
 arch/arm/kernel/process.c            |    1 
 arch/arm/kernel/smp.c                |    6 +--
 arch/arm/mach-gemini/board-dt.c      |    3 +
 arch/arm/mach-imx/cpuidle-imx6q.c    |    4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c   |    5 ++
 arch/arm/mach-omap2/cpuidle34xx.c    |   16 ++++++++
 arch/arm/mach-omap2/cpuidle44xx.c    |   29 +++++++++------
 arch/arm/mach-omap2/pm.h             |    2 -
 arch/arm/mach-omap2/pm34xx.c         |   14 +++++--
 arch/arm/mach-omap2/powerdomain.c    |   10 ++---
 arch/arm64/kernel/idle.c             |    1 
 arch/arm64/kernel/smp.c              |    4 +-
 arch/arm64/kernel/vmlinux.lds.S      |    1 
 arch/csky/kernel/process.c           |    1 
 arch/csky/kernel/smp.c               |    2 -
 arch/csky/kernel/vmlinux.lds.S       |    1 
 arch/hexagon/kernel/process.c        |    1 
 arch/hexagon/kernel/vmlinux.lds.S    |    1 
 arch/ia64/kernel/process.c           |    1 
 arch/ia64/kernel/vmlinux.lds.S       |    1 
 arch/loongarch/kernel/vmlinux.lds.S  |    1 
 arch/m68k/kernel/vmlinux-nommu.lds   |    1 
 arch/m68k/kernel/vmlinux-std.lds     |    1 
 arch/m68k/kernel/vmlinux-sun3.lds    |    1 
 arch/microblaze/kernel/process.c     |    1 
 arch/microblaze/kernel/vmlinux.lds.S |    1 
 arch/mips/kernel/idle.c              |    8 +---
 arch/mips/kernel/vmlinux.lds.S       |    1 
 arch/nios2/kernel/process.c          |    1 
 arch/nios2/kernel/vmlinux.lds.S      |    1 
 arch/openrisc/kernel/process.c       |    1 
 arch/openrisc/kernel/vmlinux.lds.S   |    1 
 arch/parisc/kernel/process.c         |    2 -
 arch/parisc/kernel/vmlinux.lds.S     |    1 
 arch/powerpc/kernel/idle.c           |    5 +-
 arch/powerpc/kernel/vmlinux.lds.S    |    1 
 arch/riscv/kernel/process.c          |    1 
 arch/riscv/kernel/vmlinux-xip.lds.S  |    1 
 arch/riscv/kernel/vmlinux.lds.S      |    1 
 arch/s390/kernel/idle.c              |    1 
 arch/s390/kernel/vmlinux.lds.S       |    1 
 arch/sh/kernel/idle.c                |    1 
 arch/sh/kernel/vmlinux.lds.S         |    1 
 arch/sparc/kernel/leon_pmc.c         |    4 ++
 arch/sparc/kernel/process_32.c       |    1 
 arch/sparc/kernel/process_64.c       |    3 +
 arch/sparc/kernel/vmlinux.lds.S      |    1 
 arch/um/kernel/dyn.lds.S             |    1 
 arch/um/kernel/process.c             |    1 
 arch/um/kernel/uml.lds.S             |    1 
 arch/x86/coco/tdx/tdcall.S           |   15 +-------
 arch/x86/coco/tdx/tdx.c              |   25 +++----------
 arch/x86/events/amd/brs.c            |   13 ++-----
 arch/x86/include/asm/irqflags.h      |   11 ++---
 arch/x86/include/asm/mwait.h         |   14 +++----
 arch/x86/include/asm/nospec-branch.h |    2 -
 arch/x86/include/asm/paravirt.h      |    6 ++-
 arch/x86/include/asm/perf_event.h    |    2 -
 arch/x86/include/asm/shared/io.h     |    4 +-
 arch/x86/include/asm/shared/tdx.h    |    1 
 arch/x86/include/asm/special_insns.h |    6 +--
 arch/x86/include/asm/xen/hypercall.h |    2 -
 arch/x86/kernel/paravirt.c           |   14 ++++++-
 arch/x86/kernel/process.c            |   65 +++++++++++++++++------------------
 arch/x86/kernel/vmlinux.lds.S        |    1 
 arch/x86/xen/enlighten_pv.c          |    2 -
 arch/x86/xen/irq.c                   |    2 -
 arch/xtensa/kernel/process.c         |    1 
 arch/xtensa/kernel/vmlinux.lds.S     |    1 
 drivers/acpi/processor_idle.c        |   46 ++++++++++++++----------
 drivers/base/power/runtime.c         |   24 ++++++------
 drivers/clk/clk.c                    |    8 ++--
 drivers/cpuidle/cpuidle-arm.c        |    1 
 drivers/cpuidle/cpuidle-big_little.c |    8 +++-
 drivers/cpuidle/cpuidle-mvebu-v7.c   |    7 +++
 drivers/cpuidle/cpuidle-psci.c       |   10 +++--
 drivers/cpuidle/cpuidle-qcom-spm.c   |    1 
 drivers/cpuidle/cpuidle-riscv-sbi.c  |   10 +++--
 drivers/cpuidle/cpuidle-tegra.c      |   21 ++++++++---
 drivers/cpuidle/cpuidle.c            |   21 +++++------
 drivers/cpuidle/dt_idle_states.c     |    2 -
 drivers/cpuidle/poll_state.c         |   10 ++++-
 drivers/idle/intel_idle.c            |   29 ++++++++++++---
 include/asm-generic/vmlinux.lds.h    |    9 +---
 include/linux/compiler_types.h       |    8 +++-
 include/linux/cpu.h                  |    3 -
 include/linux/cpuidle.h              |   33 +++++++++++++++++
 include/linux/cpumask.h              |    4 +-
 include/linux/sched/idle.h           |   40 ++++++++++++++++-----
 include/linux/thread_info.h          |   18 +++++++++
 include/linux/tracepoint.h           |   13 ++++++-
 kernel/cpu_pm.c                      |    9 ----
 kernel/printk/printk.c               |    2 -
 kernel/rcu/tree.c                    |    9 +---
 kernel/sched/idle.c                  |   47 +++++++------------------
 kernel/time/tick-broadcast-hrtimer.c |   29 ++++++---------
 kernel/time/tick-broadcast.c         |    6 ++-
 kernel/trace/trace.c                 |    3 +
 tools/objtool/check.c                |   15 +++++++-
 104 files changed, 449 insertions(+), 342 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
