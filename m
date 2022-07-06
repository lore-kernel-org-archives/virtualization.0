Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17010CCA47C
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 09:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EE7683DB7;
	Wed,  6 Jul 2022 09:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EE7683DB7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DOpMvEybuL4S; Wed,  6 Jul 2022 09:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EFA2F833CD;
	Wed,  6 Jul 2022 09:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFA2F833CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEA72C0035;
	Wed,  6 Jul 2022 09:51:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4AA0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C7ED8348C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C7ED8348C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OnWyN8wsVbNu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:51:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EE25833CD
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EE25833CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:51:51 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id az35so7148432vkb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 02:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8jOPstF035V3JBIGTjyEra8xnCZ4RAIho4NrHeIzoU=;
 b=NtoIWZEe5D15jTBPx1G7gwiJQVVs4XAE/ZkRFk5M2zuulB0V+/P5pewEwwBUDkue0A
 NxoU2J5icCq5GCuEW+eVKr09Bbty9/2ZCxtWKBHObceRo3+NhGvgbWeCkt3nChUfPl3T
 w0qifOgiroEHTVFXXKg7zCsN4ZwaokPrJJsGN1Hy/DNxjj5ODiTFdwxN7fip6NvnZPaG
 FJs+5FtFjST3JMgleW9NyMZa5HCbV6kSKBouOCgoiNw+4B8q7m+fZeg8ooLxVxhnnJ0F
 srKJn01dnfRI8BtcJLVQFTddWKPoGTEABd+BhCx3B+6OFnlJRD/85vB8LAbpBcGeLYlq
 XqXQ==
X-Gm-Message-State: AJIora/zCD9tzqEeDmupwyxDgLLed66nl3EapcTdEG3okpj0h+G10n8r
 v9dnc2G95KpdUmqxWqw56M1Y/LSo5dCrS/1u
X-Google-Smtp-Source: AGRyM1vliFGzI5EQE/8051mFQ91mMVbjG8HHGKdEf5QwVgV8DNUHzi9GhfyNYGFPJcLvRK5CX9ldPQ==
X-Received: by 2002:ac5:cdcc:0:b0:36c:547d:d9c4 with SMTP id
 u12-20020ac5cdcc000000b0036c547dd9c4mr23210919vkn.2.1657101110271; 
 Wed, 06 Jul 2022 02:51:50 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44]) by smtp.gmail.com with ESMTPSA id
 j78-20020a1f2351000000b00373f71d8a34sm4596879vkj.48.2022.07.06.02.51.49
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 02:51:50 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id x31so248749uaf.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 02:51:49 -0700 (PDT)
X-Received: by 2002:a05:6902:50e:b0:66e:7f55:7a66 with SMTP id
 x14-20020a056902050e00b0066e7f557a66mr6648581ybs.365.1657100796735; Wed, 06
 Jul 2022 02:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144517.124597382@infradead.org>
In-Reply-To: <20220608144517.124597382@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jul 2022 11:46:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4pT+YQfLzLTegFu1M3v9-9vaFDFAama7mc82=x6R__w@mail.gmail.com>
Message-ID: <CAMuHMdW4pT+YQfLzLTegFu1M3v9-9vaFDFAama7mc82=x6R__w@mail.gmail.com>
Subject: Re: [PATCH 19/36] objtool/idle: Validate __cpuidle code as noinstr
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 Linus Walleij <linus.walleij@linaro.org>, bsegall@google.com,
 guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com,
 linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au,
 chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, catalin.marinas@arm.com,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com,
 linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, Richard Henderson <rth@twiddle.net>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 svens@linux.ibm.com, jolsa@kernel.org, paulus@samba.org, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, deller@gmx.de, daniel.lezcano@linaro.org,
 jonathanh@nvidia.com, mathieu.desnoyers@efficios.com, frederic@kernel.org,
 lenb@kernel.org, linux-xtensa@linux-xtensa.org,
 Sascha Hauer <kernel@pengutronix.de>, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, shorne@gmail.com,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, sboyd@kernel.org,
 dinguyen@kernel.org, bristot@redhat.com, alexander.shishkin@linux.intel.com,
 lpieralisi@kernel.org, linux@rasmusvillemoes.dk, joel@joelfernandes.org,
 will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
 linux-csky@vger.kernel.org, pv-drivers@vmware.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, Vineet Gupta <vgupta@kernel.org>,
 linux-clk@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
 rcu@vger.kernel.org, bp@alien8.de, bcain@quicinc.com,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, sudeep.holla@arm.com,
 Shawn Guo <shawnguo@kernel.org>, davem@davemloft.net, dalias@libc.org,
 tony@atomide.com, amakhalov@vmware.com, bjorn.andersson@linaro.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv@lists.infradead.org, anton.ivanov@cambridgegreys.com,
 jonas@southpole.se, yury.norov@gmail.com, richard@nod.at, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, mingo@redhat.com, aou@eecs.berkeley.edu,
 paulmck@kernel.org, hca@linux.ibm.com, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, paul.walmsley@sifive.com,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
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

On Wed, Jun 8, 2022 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Idle code is very like entry code in that RCU isn't available. As
> such, add a little validation.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/kernel/vmlinux-nommu.lds   |    1 -
>  arch/m68k/kernel/vmlinux-std.lds     |    1 -
>  arch/m68k/kernel/vmlinux-sun3.lds    |    1 -

FWIW
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
