Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07082CCA47B
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 18:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0DCE40341;
	Wed,  8 Jun 2022 18:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBWbJ17_9jJX; Wed,  8 Jun 2022 18:13:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77A1B4034A;
	Wed,  8 Jun 2022 18:13:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D64CC0039;
	Wed,  8 Jun 2022 18:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B641FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 18:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A262460EA9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 18:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 743Go_y2dsZx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 18:13:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D436160ACE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 18:13:19 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id r1so9277035ybd.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 11:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQePx5uIM1fUidMEiJVM5nuB6ZzPVeEu38qEpc1UrpE=;
 b=gy2y4uaDQJklZRfaDOfAXxyMuLScxdZbka2Vn1/yk6LqyC1pMTUPsqrAOCbsPdnfa9
 5ienuWvaD4mmhzhgCHj276j5VDL8iqpd2mk/aUlQxIF1ctsOfWjb60jO/FLSrZE/N5I6
 8L0p4z6Q1Qvsc8Z2Kgk80WbuPxQlaEzxAYJYEfmOw0lQtebDKOIdK/LESrPiPdl536TD
 KV5bA9aHkdjseTz+aLPunDHvjz9LJzqFuVzDSBdIn1Xk9IjRNHu1TAOJ0FPxOCe8Z1PL
 ur6WmKL9mdhZPYLm34LidLCiG9mMJYII7bHSFctip48OeLsuXY+FgdRntH7RpdLi+46o
 5bHw==
X-Gm-Message-State: AOAM531Vje8d7vLqp3HMTtJwenh91JOpkJjqW7M+MdT3UXBhf3Z3oyQp
 6XZ/nO8ehiId5Qaua51J5W6oVy3v01xfIooGlp0=
X-Google-Smtp-Source: ABdhPJyd1CrHem+vVK3IGyX/t5xH0MretwaFF4fsfRB0Td7tNKI/Gb3F1VH58WOF1ULS3yEBVcV2AFovGma6uhuJi5U=
X-Received: by 2002:a5b:4a:0:b0:663:7c5b:a5ba with SMTP id
 e10-20020a5b004a000000b006637c5ba5bamr17352131ybp.81.1654711998678; 
 Wed, 08 Jun 2022 11:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144516.047149313@infradead.org>
In-Reply-To: <20220608144516.047149313@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Jun 2022 20:13:07 +0200
Message-ID: <CAJZ5v0g=jcRkMhVoNkZzSaM0viK0C7WN6T5C1_3VQ5GGGQkSzQ@mail.gmail.com>
Subject: Re: [PATCH 02/36] x86/idle: Replace x86_idle with a static_call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
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
 xen-devel@lists.xenproject.org, mattst88@gmail.com,
 Michael Turquette <mturquette@baylibre.com>, sammy@sammy.net,
 Petr Mladek <pmladek@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, acme@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
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
 Linux-sh list <linux-sh@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>,
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
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, lpieralisi@kernel.org,
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

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Typical boot time setup; no need to suffer an indirect call for that.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/process.c |   50 +++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -24,6 +24,7 @@
>  #include <linux/cpuidle.h>
>  #include <linux/acpi.h>
>  #include <linux/elf-randomize.h>
> +#include <linux/static_call.h>
>  #include <trace/events/power.h>
>  #include <linux/hw_breakpoint.h>
>  #include <asm/cpu.h>
> @@ -692,7 +693,23 @@ void __switch_to_xtra(struct task_struct
>  unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
>  EXPORT_SYMBOL(boot_option_idle_override);
>
> -static void (*x86_idle)(void);
> +/*
> + * We use this if we don't have any better idle routine..
> + */
> +void __cpuidle default_idle(void)
> +{
> +       raw_safe_halt();
> +}
> +#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
> +EXPORT_SYMBOL(default_idle);
> +#endif
> +
> +DEFINE_STATIC_CALL_NULL(x86_idle, default_idle);
> +
> +static bool x86_idle_set(void)
> +{
> +       return !!static_call_query(x86_idle);
> +}
>
>  #ifndef CONFIG_SMP
>  static inline void play_dead(void)
> @@ -715,28 +732,17 @@ void arch_cpu_idle_dead(void)
>  /*
>   * Called from the generic idle code.
>   */
> -void arch_cpu_idle(void)
> -{
> -       x86_idle();
> -}
> -
> -/*
> - * We use this if we don't have any better idle routine..
> - */
> -void __cpuidle default_idle(void)
> +void __cpuidle arch_cpu_idle(void)
>  {
> -       raw_safe_halt();
> +       static_call(x86_idle)();
>  }
> -#if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
> -EXPORT_SYMBOL(default_idle);
> -#endif
>
>  #ifdef CONFIG_XEN
>  bool xen_set_default_idle(void)
>  {
> -       bool ret = !!x86_idle;
> +       bool ret = x86_idle_set();
>
> -       x86_idle = default_idle;
> +       static_call_update(x86_idle, default_idle);
>
>         return ret;
>  }
> @@ -859,20 +865,20 @@ void select_idle_routine(const struct cp
>         if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
>                 pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
>  #endif
> -       if (x86_idle || boot_option_idle_override == IDLE_POLL)
> +       if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
>                 return;
>
>         if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
>                 pr_info("using AMD E400 aware idle routine\n");
> -               x86_idle = amd_e400_idle;
> +               static_call_update(x86_idle, amd_e400_idle);
>         } else if (prefer_mwait_c1_over_halt(c)) {
>                 pr_info("using mwait in idle threads\n");
> -               x86_idle = mwait_idle;
> +               static_call_update(x86_idle, mwait_idle);
>         } else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>                 pr_info("using TDX aware idle routine\n");
> -               x86_idle = tdx_safe_halt;
> +               static_call_update(x86_idle, tdx_safe_halt);
>         } else
> -               x86_idle = default_idle;
> +               static_call_update(x86_idle, default_idle);
>  }
>
>  void amd_e400_c1e_apic_setup(void)
> @@ -925,7 +931,7 @@ static int __init idle_setup(char *str)
>                  * To continue to load the CPU idle driver, don't touch
>                  * the boot_option_idle_override.
>                  */
> -               x86_idle = default_idle;
> +               static_call_update(x86_idle, default_idle);
>                 boot_option_idle_override = IDLE_HALT;
>         } else if (!strcmp(str, "nomwait")) {
>                 /*
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
