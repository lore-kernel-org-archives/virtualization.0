Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA04C433FE
	for <virtualization@archiver.kernel.org>; Tue,  4 Oct 2022 11:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AF8940B3B;
	Tue,  4 Oct 2022 11:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AF8940B3B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OhrgekEJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ld89bMHpWrlN; Tue,  4 Oct 2022 11:10:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D31DA400CE;
	Tue,  4 Oct 2022 11:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D31DA400CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A989FC0032;
	Tue,  4 Oct 2022 11:10:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA433C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 949CE82C98
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 949CE82C98
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OhrgekEJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0HZ-dPZ_fNa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:09:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B11068132A
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B11068132A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:09:58 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id j71so6285875pge.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Oct 2022 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=Z7fvRiwPcYU72K21mcsEeWsle1VHrp2FoZLK7rnaPdE=;
 b=OhrgekEJA2e8cdAwMtySnzVGP1IXX7u0VkwcrOOu54GZ2JxdWY9lEfVkhASIMdH6iJ
 3CS7i3bHpSnDattX7vdcbOy/0Ru61hlzqZKw12qszXyQ8c8k8+VbmoP3khJqXB2u34OK
 r0R6w3Chhty48bs5fIPiEqpNsjqgSOd25DYZPmh/eJumMJEGGWz83W+3fdR0JwF+vFO5
 mEEbHpfpQY24Mu19zAFZi2TsiyCRpZk9s0G1O2wNLxMVY3JMpx0s8hV3tsChMbk0eh7y
 zwRqOOW8NupYp/v5bTpNygY4XFLMrr9CtK+i2O/hqSFWvl5B0S5XIVxlEXDh/AnokWSK
 1UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Z7fvRiwPcYU72K21mcsEeWsle1VHrp2FoZLK7rnaPdE=;
 b=g3e1PEYj1m0ylQv1O3ffAYLNaXOQoRnFUsZx6ifGUuDaF3oEHhdAox7NjMp2fTR2WY
 JsStJpKJyVkd6JNmtc02mHZnAzguDJRx2ovs5EY0Ed5i5OhO+lIRZ3fk0ZAavX+zbw/m
 hlZhARya2QWD0hCN/qdxbg05lxfglurQ3mcB7rVbNSkGh4UYtm+t+919ryf/ciScn+1g
 Dd0hY6v04hn83shA3gJzungz1W9QOkHOj1AsPhasKyv7DQpOVDhDvLDnYS8Dd6RxPueN
 6xTaT8zRFPXSZHnx2bRG3y785gQfYGqDY7/lfFuSHFL+ujrjkxEKppnUfHYbyBnG0MUo
 RYMg==
X-Gm-Message-State: ACrzQf1KPo4lEJiVfFyhl1jHp14Jc2yDyFXLUORg4mHDMwhEsXDQwYy1
 GTfwB5vqnyYXgGu3OBT3jMTc9P3hj6K2kg9xHzDvRA==
X-Google-Smtp-Source: AMsMyM7VbOFlVrwp8sat5c2fOoVrC6O5AG2BNs0Q/N/ssPahKqJyAog1GJURpNPkzC/i2wh0dKpKol7XCM05LlISp3k=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr18985801pgk.595.1664881798027; Tue, 04
 Oct 2022 04:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org>
 <20220919101522.975285117@infradead.org>
In-Reply-To: <20220919101522.975285117@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Oct 2022 13:09:21 +0200
Message-ID: <CAPDyKFqoBJPgehVODY0DGuUcnqJE5rpZjRPfdMCzOP0=JrvKNw@mail.gmail.com>
Subject: Re: [PATCH v2 39/44] cpuidle,clk: Remove trace_.*_rcuidle()
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

On Mon, 19 Sept 2022 at 12:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> OMAP was the one and only user.

OMAP? :-)

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/clk/clk.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -978,12 +978,12 @@ static void clk_core_disable(struct clk_
>         if (--core->enable_count > 0)
>                 return;
>
> -       trace_clk_disable_rcuidle(core);
> +       trace_clk_disable(core);
>
>         if (core->ops->disable)
>                 core->ops->disable(core->hw);
>
> -       trace_clk_disable_complete_rcuidle(core);
> +       trace_clk_disable_complete(core);
>
>         clk_core_disable(core->parent);
>  }
> @@ -1037,12 +1037,12 @@ static int clk_core_enable(struct clk_co
>                 if (ret)
>                         return ret;
>
> -               trace_clk_enable_rcuidle(core);
> +               trace_clk_enable(core);
>
>                 if (core->ops->enable)
>                         ret = core->ops->enable(core->hw);
>
> -               trace_clk_enable_complete_rcuidle(core);
> +               trace_clk_enable_complete(core);
>
>                 if (ret) {
>                         clk_core_disable(core->parent);
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
