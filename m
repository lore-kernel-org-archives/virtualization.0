Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D44BC43217
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 16:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4CCA8202E;
	Tue, 22 Nov 2022 16:05:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4CCA8202E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sxgb7Ndw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewWWGNhWab97; Tue, 22 Nov 2022 16:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B65981433;
	Tue, 22 Nov 2022 16:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B65981433
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 109DBC0033;
	Tue, 22 Nov 2022 16:05:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDF80C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 16:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4FC381444
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 16:05:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4FC381444
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6HbBXXBm6RqN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 16:05:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D228881433
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D228881433
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 16:05:10 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id q1so14426986pgl.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mKqixJN/8zapPMiYOY0ZA2E36N6vIQg16uLiOxlikFI=;
 b=Sxgb7NdwQ/FjyYXzMQLr2Ufh8inWhewppyg2kEhKfSMa5+4xLhcDZFgBkLe+YVojYR
 b1j/8R8eepdhz2QNEoN59UWxI0C8HtPNMN2hfsnJ2VXdsyzTbL+tlNksQKPnsWg/NtBp
 chCgU4N95aPK2lbuS5RzKtW5ffOhO3rTLhquzizFSUU3p/ux1MbE2BMO0btBQyCrWeJK
 WXzMJ1H0fbnItfONfrC7qjjeZVQUnHu7QZDLXM8ZsS1OkeorqU4Yt3+bnHeBb63EIVUM
 ARM0B0wTMD/PlD/5zjrBQjmOnBQvgdxEwxF1FwYHEN8lHlbB5RkK/8WK1b4hFP6jFplD
 FuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKqixJN/8zapPMiYOY0ZA2E36N6vIQg16uLiOxlikFI=;
 b=vy20jclmLE5PNfy2fh3zUksVotEepIral3kdWV7kXRrYXt9VvlHtGbOnPXzFBkfk1Y
 e3S814qFMb4YeDW35N+kNe8M1WqMuq8vN7KyVQRMC8BTvoYL1JZvhqATdlOWvP5cZqrv
 s6EKVErp7sjnhZnJMbbwSJHC8lS31KOCW2tX6YQ8WvJ0Kk3iJOOL/vEtK7IOPwdb24bA
 PHX3WDls2KXkq4vupSe9BW4BCJf6rEc1cf7lkyTxDsaHKMePIFwvOKogNwTCm+xJi3cW
 dWf/webRnA4qTuy3pxzvdX/5XGJBCFYc7VHK26mGVzI877deqwgMMXlah8m/Dw62XBMe
 BezQ==
X-Gm-Message-State: ANoB5pn5UsbvEioNZ+/6hz3EBbtnQWZfahOJsUoH4NozVVi1rEgJZSGf
 WcmIQrQSaqmXtUpKLQc4z6JNCfB6L+lqosDCqQ1VoA==
X-Google-Smtp-Source: AA0mqf6JSvaqlcRgOCqphXQ3MBWuxLvJ9cnb0DNFGeizoGOcIFvJAwjnOuz3SuqXXwFDZ3Z3O+rn4vXVPvsxTfgKOLE=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr3900068pgb.541.1669133109958; Tue, 22
 Nov 2022 08:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org>
 <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
 <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Nov 2022 17:04:33 +0100
Message-ID: <CAPDyKFqzmJdVVrcuJ6Hmr5nNgtpd9Oke_exmUKuTGZEb=PjvjQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
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

On Wed, 16 Nov 2022 at 16:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Sorry; things keep getting in the way of finishing this :/
>
> As such, I need a bit of time to get on-track again..
>
> On Tue, Oct 04, 2022 at 01:03:57PM +0200, Ulf Hansson wrote:
>
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> > >                 state->target_residency = lpi->min_residency;
> > >                 if (lpi->arch_flags)
> > >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> >
> > I assume the state index here will never be 0?
> >
> > If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> > CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> > idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.
>
> I'm not quite sure I see how. AFAICT this condition above implies
> acpi_processor_ffh_lpi_enter() gets called, no?
>
> Which in turn is an unconditional __CPU_PM_CPU_IDLE_ENTER() user, so
> even if idx==0, it ends up in ct_idle_{enter,exit}().

Seems like I was overlooking something here, you are right, this
shouldn't really be a problem.

>
> >
> > >                 state->enter = acpi_idle_lpi_enter;
> > >                 drv->safe_state_index = i;
> > >         }
> > > --- a/drivers/cpuidle/cpuidle-arm.c
> > > +++ b/drivers/cpuidle/cpuidle-arm.c
> > > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> > >          * handler for idle state index 0.
> > >          */
> > >         .states[0] = {
> > > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> >
> > Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> > series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> > state (state zero), but only for the arm64 and psci cases (mostly
> > arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> > too, as that is what most arm32 idle-drivers are using. My point is,
> > the code becomes a bit inconsistent.
>
> True.
>
> > Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> > all of the ARM WFI idle states, for both arm64 and arm32?
>
> As per the below?
>
> >
> > >                 .enter                  = arm_enter_idle_state,
> > >                 .exit_latency           = 1,
> > >                 .target_residency       = 1,
>
> > > --- a/include/linux/cpuidle.h
> > > +++ b/include/linux/cpuidle.h
> > > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> > >         int __ret = 0;                                                  \
> > >                                                                         \
> > >         if (!idx) {                                                     \
> > > +               ct_idle_enter();                                        \
> >
> > According to my comment above, we should then drop these calls to
> > ct_idle_enter and ct_idle_exit() here. Right?
>
> Yes, if we ensure idx==0 never has RCU_IDLE set then these must be
> removed.
>
> > >                 cpu_do_idle();                                          \
> > > +               ct_idle_exit();                                         \
> > >                 return idx;                                             \
> > >         }                                                               \
> > >                                                                         \
> > >         if (!is_retention)                                              \
> > >                 __ret =  cpu_pm_enter();                                \
> > >         if (!__ret) {                                                   \
> > > +               ct_idle_enter();                                        \
> > >                 __ret = low_level_idle_enter(state);                    \
> > > +               ct_idle_exit();                                         \
> > >                 if (!is_retention)                                      \
> > >                         cpu_pm_exit();                                  \
> > >         }                                                               \
> > >
>
> So the basic premise is that everything that needs RCU inside the idle
> callback must set CPUIDLE_FLAG_RCU_IDLE and by doing that promise to
> call ct_idle_{enter,exit}() themselves.
>
> Setting RCU_IDLE is required when there is RCU usage, however even if
> there is no RCU usage, setting RCU_IDLE is fine, as long as
> ct_idle_{enter,exit}() then get called.

Right, I was thinking that it could make sense to shrink the window
for users getting this wrong. In other words, we shouldn't set the
CPUIDLE_FLAG_RCU_IDLE unless we really need to.

And as I said, consistent behaviour is also nice to have.

>
>
> So does the below (delta) look better to you?

Yes, it does!

Although, one minor comment below.

>
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1218,7 +1218,7 @@ static int acpi_processor_setup_lpi_stat
>                 state->target_residency = lpi->min_residency;
>                 if (lpi->arch_flags)
>                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> -               if (lpi->entry_method == ACPI_CSTATE_FFH)
> +               if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>                         state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>                 state->enter = acpi_idle_lpi_enter;
>                 drv->safe_state_index = i;
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -53,7 +53,7 @@ static struct cpuidle_driver arm_idle_dr
>          * handler for idle state index 0.
>          */
>         .states[0] = {
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,

Nitpick: I don't think we need to explicitly clear the flag, as it
should already be zeroed by the compiler from its static declaration.
Right?

>                 .enter                  = arm_enter_idle_state,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -357,7 +357,7 @@ static int psci_idle_init_cpu(struct dev
>          * PSCI idle states relies on architectural WFI to be represented as
>          * state index 0.
>          */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = psci_enter_idle_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -72,7 +72,7 @@ static struct cpuidle_driver qcom_spm_id
>         .owner = THIS_MODULE,
>         .states[0] = {
>                 .enter                  = spm_enter_idle_state,
> -               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> +               .flags                  = 0,
>                 .exit_latency           = 1,
>                 .target_residency       = 1,
>                 .power_usage            = UINT_MAX,
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -337,7 +337,7 @@ static int sbi_cpuidle_init_cpu(struct d
>         drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>
>         /* RISC-V architectural WFI to be represented as state index 0. */
> -       drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
> +       drv->states[0].flags = 0;
>         drv->states[0].enter = sbi_cpuidle_enter_state;
>         drv->states[0].exit_latency = 1;
>         drv->states[0].target_residency = 1;
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -282,9 +282,7 @@ extern s64 cpuidle_governor_latency_req(
>         int __ret = 0;                                                  \
>                                                                         \
>         if (!idx) {                                                     \
> -               ct_idle_enter();                                        \
>                 cpu_do_idle();                                          \
> -               ct_idle_exit();                                         \
>                 return idx;                                             \
>         }                                                               \
>                                                                         \

Kind regards
Uffe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
