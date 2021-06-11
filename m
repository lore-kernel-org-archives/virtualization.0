Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DDC48BD1
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 08:22:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CC760FD8
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 08:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CC760FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A86D83B1B;
	Fri, 11 Jun 2021 08:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9gkwoRBRm3hM; Fri, 11 Jun 2021 08:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6DC783A7C;
	Fri, 11 Jun 2021 08:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A6DBC000D;
	Fri, 11 Jun 2021 08:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E244C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7C1340564
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1ZWg4Rb60Rr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:22:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C7604055F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:22:43 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id p9so2294960uar.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 01:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DaNuOXRSxAprVjd9ifIAHGPCmMrvZ/ZSFrIGL+2Y/dE=;
 b=n8idMftYvZIvgdBCxfdc+CYLhmP25Mkb2KAlavR/mBuQoVxuyQFSXExx1TbJ02OARO
 bOK4eHgthn8l33gsVIk91lbGDfPPJQNT4vHIYXuIv367tV3BDG3TuefsWx1jwML+wYQU
 J8eaC86CrLJC2gICGcR9OPFyftr4+z82fdudyMsjdV8yocnppbd9dnMAzLbbJ5MOXlbY
 QbVIabA09geN0rf3EbV1ep/diV6/0yI6337SL3Zkg6N6yZtreFR/K2dtKxTR1aKMdRQP
 Y5DL/TwDVFCLRyTcIWqyUlPm8GgwSLr9prR8049tBGFXhJp1gNnJhcxUaJ7lhNZmnXoS
 /PRg==
X-Gm-Message-State: AOAM5336U/Pofi4h6Bb8b14rghwXI6PMs4QZK8OfL4pGWHtxsENouqTm
 YgSy3HDuBJpNt0jQi7J2PbZ1/EQ5DiFT2oASmC0=
X-Google-Smtp-Source: ABdhPJyq4EqZlgDmCn8qqnGSQ1vrn3RQ/ZL8+yV4kreGJqiceay6WnvbNfvZoUE7c6JDA+lO6bKUsRxnP775QgEyE8M=
X-Received: by 2002:ab0:71d9:: with SMTP id n25mr1885900uao.2.1623399762314;
 Fri, 11 Jun 2021 01:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
In-Reply-To: <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Jun 2021 10:22:30 +0200
Message-ID: <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
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

On Fri, Jun 11, 2021 at 10:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-06-21, 09:42, Geert Uytterhoeven wrote:
> > On Fri, Jun 11, 2021 at 5:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 10-06-21, 22:46, Linus Walleij wrote:
> > > > thanks for working on this, it's a really interesting driver.
> > > >
> > > > My first question is conceptual:
> > > >
> > > > We previously have Geerts driver for virtualization:
> > > > drivers/gpio/gpio-aggregator.c
> > > >
> > > > The idea with the aggregator is that a host script sets up a
> > > > unique gpiochip for the virtualized instance using some poking
> > > > in sysfs and pass that to the virtual machine.
> > > > So this is Linux acting as virtualization host by definition.
> >
> > The gpio-aggregator is running on the host...
> >
> > > > I think virtio is more abstract and intended for the usecase
> > > > where the hypervisor is not Linux, so this should be mentioned
> > > > in the commit, possibly also in Kconfig so users immediately
> > > > know what usecases the two different drivers are for.
> >
> > ... while the virtio-gpio driver is meant for the guest kernel.
> >
> > I my PoC "[PATCH QEMU v2 0/5] Add a GPIO backend"[1], I didn't have
> > a virtio transport, but just hooked into the PL061 GPIO emulation
> > in QEMU.  The PL061 QEMU driver talked to the GPIO backend, which
> > talked to /dev/gpiochipN on the host.
>
> Hmm, interesting.
>
> > > Well, not actually.
> > >
> > > The host can actually be anything. It can be a Xen based dom0, which
> > > runs some proprietary firmware, or Qemu running over Linux.
> > >
> > > It is left for the host to decide how it wants to club together the
> > > GPIO pins from host and access them, with Linux host userspace it
> > > would be playing with /dev/gpiochipN, while for a raw one it may
> > > be accessing registers directly.
> > >
> > > And so the backend running at host, needs to pass the gpiochip
> > > configurations and only the host understand it.
> >
> > So QEMU has to translate the virtio-gpio communication to e.g.
> > /dev/gpiochipN on the host (or a different backend on non-Linux or
> > bare-metal HV).
>
> No, QEMU passes the raw messages to the backend daemon running in host
> userspace (which shares a socket with qemu). The backend understands
> the virtio/vhost protocols and so won't be required to change at all
> if we move from Qemu to something else. And that's what we (Linaro)
> are looking to do here with Project Stratos.
>
> Create virtio based hypervisor agnostic backends.

OK, IC.

> > > The way I test it for now is by running this with Qemu over my x86
> > > box, so my host side is indeed playing with sysfs Linux.
> >
> > Can you please share a link to the QEMU patches?
>
> Unfortunately, they aren't in good shape right now and the backend is
> a bit hacky (Just checking the data paths, but not touching
> /dev/gpiochipN at all for now).
>
> I didn't implement one as I am going to implement the backend in Rust
> and not Qemu. So it doesn't depend on Qemu at all.

OK.

> To give you an idea of the whole thing, here is what we have done for
> I2c for example, GPIO one will look very similar.

Oh, you also have i2c. Nice!

> The Qemu patches:
>
> https://yhbt.net/lore/all/cover.1617278395.git.viresh.kumar@linaro.org/T/
>
> The stuff from tools/vhost-user-i2c/ directory (or patch 4/6) isn't
> used anymore and the following Rust implementation replaces it:
>
> https://github.com/vireshk/vhost-device/tree/master/src/i2c

Thanks for the links!

> > The GPIO aggregator came into play after talking to Alexander Graf and
> > Peter Maydell.  To reduce the attack surface, they didn't want QEMU
> > to be responsible for exporting to the guest a subset of all GPIOs of
> > a gpiochip, only a full gpiochip.  However, the full gpiochip may
> > contain critical GPIOs you do not want the guest to tamper with.
> > Hence the GPIO aggregator was born, to take care of aggregating all
> > GPIOs you want to export to a guest into a new virtual gpiochip.
> >
> > You can find more information about the GPIO Aggregator's use cases in
> > "[PATCH v7 0/6] gpio: Add GPIO Aggregator"[2].
>
> So I was actually looking to do some kind of aggregation on the host
> side's backend daemon to share only a subset of GPIO pins, I will see
> if that is something I can reuse. Thanks for sharing details.

The same reasoning can apply to your backend daemon, so when using
the GPIO aggregator, you can just control a full gpiochip, without
having to implement access control on individual GPIO lines.

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
