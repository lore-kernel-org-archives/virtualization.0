Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA3FC48BDF
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 11:37:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0A46145C
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 11:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0A46145C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CA15605C1;
	Tue, 15 Jun 2021 11:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vF2H7ySNlYQ; Tue, 15 Jun 2021 11:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 178C96059F;
	Tue, 15 Jun 2021 11:37:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D3AC000E;
	Tue, 15 Jun 2021 11:37:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68A8CC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4900E607E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWNkelAs_iPd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:37:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BC4F6059F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:37:48 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id x8so9592982vso.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 04:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dEMwKaBtIH7S3fAHfNJawJ0VDIFQVTRz5VU7710Dgcs=;
 b=lKbE4yYpPXS/BNvPDx0a35WH0zTnIb7RsYtd63TGAEhBrCwIoiQXwB1gB+grDPby2l
 vjWxz4acvWIVEk7hfgTU1EVF0xDc4U6e2WwWKzLv0PbIPhPa9DEQMKZC88HSYgqjMm0W
 Zbau1MmjcqeAejXRs4H+0FTUK23gSQz8B4X+8UnynsP28anRrDMN678b4FxJWvBgXhBc
 WQ2Nf/WJ7qAZS+23orQ1dvJHB/5/y7POWw84RUz91X+PD3tbxzcP9ZZTCNos7JB6mdJX
 3Lcik86j9vgXwHLkJwE9iRq7656zYyhO/qtcrdMlMesZezLWfWMgaKZgCGImRxlbokt+
 5+tQ==
X-Gm-Message-State: AOAM533O80i544RG1W8aHcjlUkx81Bq4JGxiuAEM05i5306Q3opFOcD8
 BK7X26G1xKMWzT8yz1CFvf/UAqcaoJZ2hxsDVks=
X-Google-Smtp-Source: ABdhPJzWu0ZzQHuXV4PYNLkuX4/zyAG0cMCexlumQE0LzgSqdbPE35wZuXi0z3ynFv+/B+I3sIMNXeQKnTb1W0uliBA=
X-Received: by 2002:a05:6102:c4c:: with SMTP id
 y12mr4274193vss.18.1623757067039; 
 Tue, 15 Jun 2021 04:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
 <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
In-Reply-To: <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Jun 2021 13:37:35 +0200
Message-ID: <CAMuHMdUKNgRgH+=fHW9RZijdFT9syPu-FD=EyA-PkrtUrg3AdQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

Hi Viresh,

On Tue, Jun 15, 2021 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-06-21, 10:22, Geert Uytterhoeven wrote:
> > The same reasoning can apply to your backend daemon, so when using
> > the GPIO aggregator, you can just control a full gpiochip, without
> > having to implement access control on individual GPIO lines.
>
> I tried to look at it and it surely looks very temping and may fit
> well and reduce size of my backend :)
>
> I am now wondering how interrupts can be made to work here. Do you
> have anything in mind for that ?
>
> GPIO sysfs already supports interrupts, just that you need to register
> irq for the specific GPIO pins inside the aggregator ?

So far I hadn't considered interrupts.
Will think about it...

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
