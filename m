Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E23C4332F
	for <virtualization@archiver.kernel.org>; Tue,  4 Oct 2022 11:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D16158134F;
	Tue,  4 Oct 2022 11:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D16158134F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EnhlO7Dc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQfXX-vf-j5g; Tue,  4 Oct 2022 11:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6ACB781307;
	Tue,  4 Oct 2022 11:08:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6ACB781307
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4105EC0033;
	Tue,  4 Oct 2022 11:08:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80CA3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F2BC81307
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F2BC81307
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcVdgHM8xKkl
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:08:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32D43812C7
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32D43812C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:08:38 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 v10-20020a17090a634a00b00205e48cf845so18261250pjs.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Oct 2022 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=Gtwwkxm3K9zy3ub+GhlddjjtZ7fh91sG2Y46OOYgmCM=;
 b=EnhlO7DcICPKJpPG1jb7KTMLBU7DAMNWLzZM/l8aLFUsRZkWp+mkSVMMBmLZ1zgxaC
 wxY3CYIRcHyRXss5NtxD4hq5yFum2Xsa/Xfa8NFMZbQ3tgmqUq13E1Fcil8BIgM2OEw6
 m+P6TSNsaCcBVdUXpgo0TEJ7VOVGVt6KKPFMuMhn/bj0r2dm5zCuaEvX7UiZOqeeJEdX
 h1wGhs9cmKjNMVwi5bkackIBv98JM8+NjLMoMPaPS3klw1yQNu9dahurEQIN+cDnqkmM
 Hbcu0L1M6U3Rd654P0n2Hh4Q6bzGWuS7xOAcwB9SuDvPVBJ1Tctv5MAKRuD35o1eodHl
 dgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Gtwwkxm3K9zy3ub+GhlddjjtZ7fh91sG2Y46OOYgmCM=;
 b=zXrC5sooK1yxConRJWv73ECsrfLouQ/g4MsBYR9q74j5eMIWETCk8Ocz/QD5qsp1Hb
 oxzUWQtm3grj52QlowAuolB4sCdq0s9odDdkmtfEOPnDktFmyMQqObRQq8ERi/WNsCnA
 NLyUUH68zqbwDPywxevPTn6QOOLPr6BRu8L7T/gQVvbHkvf9P/e18Hsu35Ks9i5U04mB
 13s66ZTTzf4rkjPT7gLkDl5ENXn9SN3H90fJ4mmjZEK2E4xBIKlJGaa33hyyE9wtqs7L
 eW7ULR6SUX58JbSx9vv//AaJ3T7ejSLM4ySud1BhB7N0uGkNBtdLnzpMSW/seWoKFNVT
 J7Zg==
X-Gm-Message-State: ACrzQf1FkOykS04F7f0SVLPkL7DpiigAdS3cMVQk58D4vVncji2mmI41
 mTnvHZhtt0AvCVdzU3eqYyf1MtdozX7JbwZcPtWeCw==
X-Google-Smtp-Source: AMsMyM6cCdnxuhXSy92rYBN/YepwF/hndLawv3zc1vUJoDTHY6JL7u1f8y1gp2OsfAUCoRgnjKuog3OS/wqaN/v/F3w=
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id
 nu6-20020a17090b1b0600b00202cce02148mr17035330pjb.84.1664881717434; Tue, 04
 Oct 2022 04:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org>
 <20220919101521.886766952@infradead.org>
In-Reply-To: <20220919101521.886766952@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Oct 2022 13:08:00 +0200
Message-ID: <CAPDyKFoMidikoTPe0Xd+wZQdBBJSoy+CZ2ZmJShfLkbGZZRYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/44] arm,smp: Remove trace_.*_rcuidle() usage
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, mpe@ellerman.id.au, linux-sh@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org, mingo@redhat.com,
 geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com,
 lpieralisi@kernel.org, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de,
 linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 svens@linux.ibm.com, kernel@pengutronix.de, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, festevam@gmail.com, deller@gmx.de,
 daniel.lezcano@linaro.org, jonathanh@nvidia.com, dennis@kernel.org,
 lenb@kernel.org, linux-xtensa@linux-xtensa.org, jolsa@kernel.org,
 gor@linux.ibm.com, linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev, shorne@gmail.com,
 chris@zankel.net, sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 chenhuacai@kernel.org, alexander.shishkin@linux.intel.com, fweisbec@gmail.com,
 mturquette@baylibre.com, paul.walmsley@sifive.com, linux@rasmusvillemoes.dk,
 christophe.leroy@csgroup.eu, will@kernel.org, boris.ostrovsky@oracle.com,
 khilman@kernel.org, linux-csky@vger.kernel.org, tony@atomide.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, rostedt@goodmis.org, ink@jurassic.park.msu.ru,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 anup@brainfault.org, ryabinin.a.a@gmail.com, linux-alpha@vger.kernel.org,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org,
 pv-drivers@vmware.com, hpa@zytor.com, konrad.dybcio@somainline.org,
 bjorn.andersson@linaro.org, glider@google.com, amakhalov@vmware.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincenzo.frascino@arm.com, anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk,
 agross@kernel.org, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 richard.henderson@linaro.org, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, acme@kernel.org, atishp@atishpatra.org,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, dvyukov@google.com,
 jgross@suse.com, monstr@monstr.eu, linux-mips@vger.kernel.org,
 palmer@dabbelt.com, linux-hexagon@vger.kernel.org, bp@alien8.de,
 johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
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

On Mon, 19 Sept 2022 at 12:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> None of these functions should ever be ran with RCU disabled anymore.
>
> Specifically, do_handle_IPI() is only called from handle_IPI() which
> explicitly does irq_enter()/irq_exit() which ensures RCU is watching.
>
> The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
> _rcuidle for smp_cross_call() tracepoints"), that
> cpuidle_enter_state_coupled() already had RCU disabled, but that's
> long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
> deeper into the idle path").
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/kernel/smp.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
>         unsigned int cpu = smp_processor_id();
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_entry(ipi_types[ipinr]);
>
>         switch (ipinr) {
>         case IPI_WAKEUP:
> @@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
>         }
>
>         if ((unsigned)ipinr < NR_IPI)
> -               trace_ipi_exit_rcuidle(ipi_types[ipinr]);
> +               trace_ipi_exit(ipi_types[ipinr]);
>  }
>
>  /* Legacy version, should go away once all irqchips have been converted */
> @@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
>
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> -       trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> +       trace_ipi_raise(target, ipi_types[ipinr]);
>         __ipi_send_mask(ipi_desc[ipinr], target);
>  }
>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
