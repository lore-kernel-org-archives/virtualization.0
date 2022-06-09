Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686CC43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 09:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B65C340BF8;
	Thu,  9 Jun 2022 09:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8Pw9qZLXSxC; Thu,  9 Jun 2022 09:48:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D11E4000B;
	Thu,  9 Jun 2022 09:48:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04DB4C0032;
	Thu,  9 Jun 2022 09:48:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CC07C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 09:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DE7840734
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 09:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A0oo5jDh621t
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 09:48:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF0544000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9jA4mchnYQoJ5XaXo73/qgoc6iaW5C3P1k7XaYKsS1U=; b=cB9XFjQVxWqfDyzeN0qaxTZuLD
 YLcvVXkDGRGNOtMLtEgH+zL1QwGa+jRQrKiDu6o+KwcqUIios781clMIKdQSQtEcXojjpXyjmvj46
 euyjd4m+n/z+pXAWpiww5AHKVJISuO8dbwfn2kdK+vnbm4iQMh9u58KvobfYp6DKnGfTofnM78Yt0
 Jz76LJDB6p5dvl91aPCez/Dj+sFAkswEne+HjI0PWGc0G7Uh6QasF9s0y9AlvQ8RjyVaUQ4ilXQ62
 Z4qivKfe5pGVxrpCjV/g6X6ndctS6ICj5/6oYIabFd8D02kUsNuFDdK3DNDO+pifvTslSQOhwvIep
 NfI5oq7A==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nzElj-00DR5R-4H; Thu, 09 Jun 2022 09:47:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 100CA981287; Thu,  9 Jun 2022 11:47:58 +0200 (CEST)
Date: Thu, 9 Jun 2022 11:47:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
Message-ID: <YqHBzbAiqaZeoipw@worktop.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144518.010587032@infradead.org>
 <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
 <YqGjqgSrTRseJW6M@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqGjqgSrTRseJW6M@atomide.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Rafael Wysocki <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>, Ben Segall <bsegall@google.com>,
 Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-arch <linux-arch@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 NXP Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Matt Turner <mattst88@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Sam Creasey <sammy@sammy.net>,
 Petr Mladek <pmladek@suse.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um <linux-um@lists.infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Richard Henderson <rth@twiddle.net>, gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Sven Schnelle <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 "open list:IA64 \(Itanium\) PLATFORM" <linux-ia64@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Xuerui Wang <kernel@xen0n.name>, quic_neeraju@quicinc.com,
 linux-s390 <linux-s390@vger.kernel.org>, vschneid@redhat.com,
 John Ogness <john.ogness@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Frederic Weisbecker <frederic@kernel.org>, Len Brown <lenb@kernel.org>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Sascha Hauer <kernel@pengutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Stafford Horne <shorne@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Stephen Boyd <sboyd@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, lpieralisi@kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joel Fernandes <joel@joelfernandes.org>, Fabio Estevam <festevam@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Kevin Hilman <khilman@kernel.org>, linux-csky@vger.kernel.org,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 Mel Gorman <mgorman@suse.de>, jacob.jun.pan@linux.intel.com,
 Arnd Bergmann <arnd@arndb.de>, Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Vineet Gupta <vgupta@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, Borislav Petkov <bp@alien8.de>, bcain@quicinc.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 David Miller <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Pv-drivers <pv-drivers@vmware.com>, amakhalov@vmware.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, Yury Norov <yury.norov@gmail.com>,
 Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Openrisc <openrisc@lists.librecores.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jpoimboe@kernel.org,
 Juergen Gross <jgross@suse.com>, Michal Simek <monstr@monstr.eu>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, Jun 09, 2022 at 10:39:22AM +0300, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [220608 18:18]:
> > On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > arch_cpu_idle() is a very simple idle interface and exposes only a
> > > single idle state and is expected to not require RCU and not do any
> > > tracing/instrumentation.
> > >
> > > As such, omap_sram_idle() is not a valid implementation. Replace it
> > > with the simple (shallow) omap3_do_wfi() call. Leaving the more
> > > complicated idle states for the cpuidle driver.
> 
> Agreed it makes sense to limit deeper idle states to cpuidle. Hopefully
> there is some informative splat for attempting to use arch_cpu_ide()
> for deeper idle states :)

The arch_cpu_idle() interface doesn't allow one to express a desire for
deeper states. I'm not sure how anyone could even attempt this.

But given what OMAP needs to go deeper, this would involve things that
require RCU, combine that with the follow up patches that rip out all
the trace_.*_rcuidle() hackery from the power and clock domain code,
PROVE_RCU should scream if anybody were to attempt it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
