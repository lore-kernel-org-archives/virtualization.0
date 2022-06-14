Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FCC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Jun 2022 16:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 477E683231;
	Tue, 14 Jun 2022 16:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3iaoaz4x4ZRJ; Tue, 14 Jun 2022 16:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEFEF83267;
	Tue, 14 Jun 2022 16:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 806AEC0039;
	Tue, 14 Jun 2022 16:41:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B55AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 700C983267
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLqaWxiNKhj6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4A4A83388
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rwYFO4jRp4ZmBbbpQ/dlmC/s4443nixCio2KC7D4yLw=; b=V4CcOtoya4fx7a+TewbwfbMpHX
 S0U58dFbvhEs4+z6vlti2b1yaN2nHZdtpLUhV6b26DfB0W9QaiXCJNgWY1iLqP6JemwxKD8If1zXi
 Dc58dnvyG/zHW9b8hYkgX3+ltwbe4kfS6mygL93PVj25PQUAkTI43bgkav/UP2phwqaLH6Jmg4htB
 +7dwsqbHSMo9jJy12dA4V5J1yPFkpBzcClSfYYGQs5HHmF9AKeJnyxvwMhdlvB0wf7ej1fwQvbSdj
 +cGoUoQpbmvkdPfLd6lFQZf+8q0srIdNcxJPdxc0YJaBq/7VVmZ25B5dD+OpzZBdLGRfiZRDfHRqR
 AHE5YJ2g==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o19b8-000KNd-ML; Tue, 14 Jun 2022 16:40:58 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5DF9300372;
 Tue, 14 Jun 2022 18:40:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A4FD82868A9BF; Tue, 14 Jun 2022 18:40:53 +0200 (CEST)
Date: Tue, 14 Jun 2022 18:40:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 14/36] cpuidle: Fix rcu_idle_*() usage
Message-ID: <Yqi6Fd38ZCsDUnQG@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.808451191@infradead.org>
 <YqiB6YpVqq4wuDtO@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqiB6YpVqq4wuDtO@FVFF77S0Q05N>
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
 paulus@samba.org, linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
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

On Tue, Jun 14, 2022 at 01:41:13PM +0100, Mark Rutland wrote:
> On Wed, Jun 08, 2022 at 04:27:37PM +0200, Peter Zijlstra wrote:
> > --- a/kernel/time/tick-broadcast.c
> > +++ b/kernel/time/tick-broadcast.c
> > @@ -622,9 +622,13 @@ struct cpumask *tick_get_broadcast_onesh
> >   * to avoid a deep idle transition as we are about to get the
> >   * broadcast IPI right away.
> >   */
> > -int tick_check_broadcast_expired(void)
> > +noinstr int tick_check_broadcast_expired(void)
> >  {
> > +#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
> > +	return arch_test_bit(smp_processor_id(), cpumask_bits(tick_broadcast_force_mask));
> > +#else
> >  	return cpumask_test_cpu(smp_processor_id(), tick_broadcast_force_mask);
> > +#endif
> >  }
> 
> This is somewhat not-ideal. :/

I'll say.

> Could we unconditionally do the arch_test_bit() variant, with a comment, or
> does that not exist in some cases?

Loads of build errors ensued, which is how I ended up with this mess ...
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
