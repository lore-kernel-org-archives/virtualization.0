Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8847EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  4 Oct 2022 11:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D6594012F;
	Tue,  4 Oct 2022 11:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D6594012F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ALPYtY9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WrvSAOuSh3mL; Tue,  4 Oct 2022 11:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD1AE408CB;
	Tue,  4 Oct 2022 11:05:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD1AE408CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7489C0033;
	Tue,  4 Oct 2022 11:05:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C406C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46FF160B5C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:05:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46FF160B5C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ALPYtY9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2BL5BvLfYhaI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4B2560B46
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4B2560B46
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 11:05:34 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id 70so12571455pjo.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Oct 2022 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=8dOAtcXqtbDTbOtGHdeMRx2lSxGZ/p81xoeulWg88O8=;
 b=ALPYtY9NECpkdz09jpHMZbs0aH+hKiq7zCwXfK1hWKvM2elz9mNR/JJb0byGfir59h
 CWc9izoQX0glvUd9bdjzB+GxZIKg7cZ1wWKnb5xSlDD9fDdUtUduD7qTiOAX8rgJzNMY
 16i4fnybYgh61uFsRfFa0jFHaMm217pAorBQUItONSq5D0pjQfmpgEbFEG0ovD83XmiY
 JRBnUwctQs5MU4QsxdCrYJ2mV5ubOvxFCDZOs+xf+eBgsrQVN1CIV6SHGqFX6RFQbzq7
 D2ARCpgG/orA8SpRSFPIMnoc2IRLOYljdFwc8QX3tXFa2vpA/P7Kkd/ZsaWnXMh+ArFb
 1Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=8dOAtcXqtbDTbOtGHdeMRx2lSxGZ/p81xoeulWg88O8=;
 b=E9PUIpAo5MtWv4jcp9grRN5mpBzXEdAbyfxyUpX9z82vVX7PS8/Hx1UODGq6b2MQdN
 yFfUonVhGPCPyjU6Hkyn1mgJnjFMEW/oeQeersmecgGivgAk0TGEX26W228yHDw7izOQ
 Hjz+J4Ss13mgmRWZ47yxRFEpMQ5XjQ8Yrleys2zivGRiCAga8++fK0UCya7heoXehVFi
 WEoJ/2lDAFHHK96BIU97gbSvz4aYqC9qYp/c3UvHqtaZC5IFxBLxBkXeB6xzgywqPxZz
 xT285n+zgyE6Q33h4ksyf49mSjeUGFwlrU9v0rH3ipGXD1fPtb2mnZH7S0cuxCAxqh5+
 KBZA==
X-Gm-Message-State: ACrzQf16dL3GW9xfIIjKBbNrdDId/HHGmUclrFOXyPfU9Ks/Ls1TJjDL
 6r2f+W/UQR1o95BHKpeiusWZuRn7TPLHQrgOmf4gtw==
X-Google-Smtp-Source: AMsMyM4crcx6LouSmUkordoRMp2FZSPTtuc3An5Wuzy+BH6M/IICg47GwaPPyycgbJ/QSQxkTeG6xy+CkgFRgaEAD/g=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr17203785pjb.164.1664881533975; Tue, 04
 Oct 2022 04:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220919095939.761690562@infradead.org>
 <20220919101521.274051658@infradead.org>
In-Reply-To: <20220919101521.274051658@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Oct 2022 13:04:57 +0200
Message-ID: <CAPDyKFquBVkYmKsriPD+BfVrrz62ih7oCxb7HwOML+Zzs-5U_Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/44] cpuidle,
 cpu_pm: Remove RCU fiddling from cpu_pm_{enter, exit}()
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
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
 Andrew Morton <akpm@linux-foundation.org>, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 dennis@kernel.org, lenb@kernel.org, linux-xtensa@linux-xtensa.org,
 kernel@pengutronix.de, gor@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 loongarch@lists.linux.dev, shorne@gmail.com, chris@zankel.net,
 sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 alexander.shishkin@linux.intel.com, fweisbec@gmail.com, lpieralisi@kernel.org,
 atishp@atishpatra.org, linux@rasmusvillemoes.dk, kasan-dev@googlegroups.com,
 will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
 linux-csky@vger.kernel.org, pv-drivers@vmware.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, linux-clk@vger.kernel.org, rostedt@goodmis.org,
 ink@jurassic.park.msu.ru, bcain@quicinc.com, tsbogend@alpha.franken.de,
 linux-parisc@vger.kernel.org, ryabinin.a.a@gmail.com, sudeep.holla@arm.com,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org, tony@atomide.com,
 amakhalov@vmware.com, konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
 glider@google.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincenzo.frascino@arm.com, anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 richard.henderson@linaro.org, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, acme@kernel.org, paul.walmsley@sifive.com,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, dvyukov@google.com,
 jgross@suse.com, monstr@monstr.eu, linux-mips@vger.kernel.org,
 palmer@dabbelt.com, anup@brainfault.org, bp@alien8.de,
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
> All callers should still have RCU enabled.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  kernel/cpu_pm.c |    9 ---------
>  1 file changed, 9 deletions(-)
>
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_eve
>  {
>         int ret;
>
> -       /*
> -        * This introduces a RCU read critical section, which could be
> -        * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
> -        * this.
> -        */
> -       ct_irq_enter_irqson();
>         rcu_read_lock();
>         ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
>         rcu_read_unlock();
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
> @@ -49,11 +42,9 @@ static int cpu_pm_notify_robust(enum cpu
>         unsigned long flags;
>         int ret;
>
> -       ct_irq_enter_irqson();
>         raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>         ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
>         raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
> -       ct_irq_exit_irqson();
>
>         return notifier_to_errno(ret);
>  }
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
