Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE6FC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 15:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4D2260C26;
	Wed,  8 Jun 2022 15:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bK3jo-rUFUjx; Wed,  8 Jun 2022 15:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19779600B9;
	Wed,  8 Jun 2022 15:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3003C0032;
	Wed,  8 Jun 2022 15:48:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ABE4C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75C0E60A88
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrsWtcIspqSa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:48:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11891600B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wkrvwwo/ehTnPQ2GyODy/ZpUUMe6HOjJCITHLe45W7c=; b=PhHp+PJmr+2T6rnBijz+YHTCqo
 Q3sRs0kB+1HF2TzaTXkAa8+nJlCba8qwWkYHuYUvJIz6d+sUwN3QATDRrp6HkFJtxuDUGlK2esQFG
 B6FqhNDw4mzKWIndiKngqO5+uVumTrnZhLB4eRFSER0mlLEnLKmACyt/N0zRX6B8QnMdEd1jF93Qv
 +F3wXq8WpQgBGoI9TYubNiobTj3byuz+cOLmJDoCRAcPPkDwjHQiqUYBc/eVlZdt6y9xI16C13ivT
 9RycLHrYGa8XbNQes8S9gNmrNcQe8ImgWY0Ct9y735wKSNGr9BXQRTA4U6CQXwwbi/h2tLQ2WHupK
 g4TPoOhQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nyxuv-00ClXO-Bt; Wed, 08 Jun 2022 15:48:21 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1781E301093;
 Wed,  8 Jun 2022 17:48:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id F027020C0D33A; Wed,  8 Jun 2022 17:48:16 +0200 (CEST)
Date: Wed, 8 Jun 2022 17:48:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <YqDEwMDSL1YXdHFH@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gW-zD8Mgghy70f3rFz0QoozCwZ9idyrqtFgA6SWHK5XQ@mail.gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>, Benjamin Segall <bsegall@google.com>,
 Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-arch <linux-arch@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 dl-linux-imx <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
 xen-devel@lists.xenproject.org, mattst88@gmail.com, lpieralisi@kernel.org,
 sammy@sammy.net, Petr Mladek <pmladek@suse.com>,
 Linux PM <linux-pm@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, rth@twiddle.net,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 Sven Schnelle <svens@linux.ibm.com>, jolsa@kernel.org,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>, jcmvbkbc@gmail.com,
 Thierry Reding <thierry.reding@gmail.com>, kernel@xen0n.name,
 quic_neeraju@quicinc.com, linux-s390@vger.kernel.org, vschneid@redhat.com,
 John Ogness <john.ogness@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Fabio Estevam <festevam@gmail.com>, Helge Deller <deller@gmx.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Frederic Weisbecker <frederic@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-xtensa@linux-xtensa.org, Sascha Hauer <kernel@pengutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-alpha@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Stafford Horne <shorne@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, chris@zankel.net,
 Stephen Boyd <sboyd@kernel.org>, dinguyen@kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Kevin Hilman <khilman@kernel.org>, linux-csky@vger.kernel.org,
 pv-drivers@vmware.com, linux-snps-arc@lists.infradead.org,
 Mel Gorman <mgorman@suse.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, ulli.kroll@googlemail.com, vgupta@kernel.org,
 linux-clk <linux-clk@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, bcain@quicinc.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 David Miller <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Tony Lindgren <tony@atomide.com>, amakhalov@vmware.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>, anton.ivanov@cambridgegreys.com,
 jonas@southpole.se, Yury Norov <yury.norov@gmail.com>,
 Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, namhyung@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jpoimboe@kernel.org,
 Juergen Gross <jgross@suse.com>, Michal Simek <monstr@monstr.eu>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 ink@jurassic.park.msu.ru, Johannes Berg <johannes@sipsolutions.net>,
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

On Wed, Jun 08, 2022 at 05:01:05PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > Xeons") wrecked intel_idle in two ways:
> >
> >  - must not have tracing in idle functions
> >  - must return with IRQs disabled
> >
> > Additionally, it added a branch for no good reason.
> >
> > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> And do I think correctly that this can be applied without the rest of
> the series?

Yeah, I don't think this relies on any of the preceding patches. If you
want to route this through the pm/fixes tree that's fine.

Thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
