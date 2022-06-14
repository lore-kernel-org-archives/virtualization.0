Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4792CCA480
	for <virtualization@archiver.kernel.org>; Tue, 14 Jun 2022 14:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60883605EE;
	Tue, 14 Jun 2022 14:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4i9B79is29fw; Tue, 14 Jun 2022 14:37:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F283560E81;
	Tue, 14 Jun 2022 14:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C58DBC0039;
	Tue, 14 Jun 2022 14:37:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D834C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 14:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C9AE83083
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 14:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GZGD7nmT_I1G
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 14:37:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52C978305A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 14:37:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E406B81865;
 Tue, 14 Jun 2022 14:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D478C3411C;
 Tue, 14 Jun 2022 14:37:34 +0000 (UTC)
Date: Tue, 14 Jun 2022 10:37:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Message-ID: <20220614103732.489ba62b@gandalf.local.home>
In-Reply-To: <YqHvXFdIJfvUDI6e@alley>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org> <YqG6URbihTNCk9YR@alley>
 <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
 <CA+_sPaoJGrXhNPCs2dKf2J7u07y1xYrRFZBUtkKwzK9GqcHSuQ@mail.gmail.com>
 <YqHvXFdIJfvUDI6e@alley>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org,
 agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com,
 catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com,
 mturquette@baylibre.com, sammy@sammy.net, linux-pm@vger.kernel.org,
 jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de,
 linux-omap@vger.kernel.org, dietmar.eggemann@arm.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, svens@linux.ibm.com,
 jolsa@kernel.org, paulus@samba.org, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
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
 will@kernel.org, boris.ostrovsky@oracle.com, josh@joshtriplett.org,
 khilman@kernel.org, linux-csky@vger.kernel.org, tony@atomide.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, yury.norov@gmail.com, ulli.kroll@googlemail.com,
 vgupta@kernel.org, linux-clk@vger.kernel.org, monstr@monstr.eu,
 rcu@vger.kernel.org, bp@alien8.de, bcain@quicinc.com,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, sudeep.holla@arm.com,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org,
 Peter Zijlstra <peterz@infradead.org>, amakhalov@vmware.com,
 bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 Arnd Bergmann <arnd@arndb.de>, richard@nod.at, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, aou@eecs.berkeley.edu,
 paulmck@kernel.org, hca@linux.ibm.com, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, paul.walmsley@sifive.com,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 pv-drivers@vmware.com, linux-mips@vger.kernel.org, palmer@dabbelt.com,
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

On Thu, 9 Jun 2022 15:02:20 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > I'm somewhat curious whether we can actually remove that trace event.  
> 
> Good question.
> 
> Well, I think that it might be useful. It allows to see trace and
> printk messages together.

Yes people still use it. I was just asked about it at Kernel Recipes. That
is, someone wanted printk mixed in with the tracing, and I told them about
this event (which they didn't know about but was happy to hear that it
existed).

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
