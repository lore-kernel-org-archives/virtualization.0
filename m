Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83864C4743D
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 07:42:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB930613AE
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 07:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB930613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B01DF83404;
	Fri, 11 Jun 2021 07:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDvztR6hn_fe; Fri, 11 Jun 2021 07:42:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 405EA831F1;
	Fri, 11 Jun 2021 07:42:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C978C000E;
	Fri, 11 Jun 2021 07:42:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0923DC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 07:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF8FB606EF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 07:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gPOVBpA8UXg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 07:42:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEF17606EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 07:42:34 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id d18so2248299ual.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 00:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=38AX8dJKliZcm5SjDtUlGVi/FFnBmE/O/3FCvxTZd8o=;
 b=KjSYoLw4L0BtvZ8fxh9QZea7Sv7VVpHVClmQ+PRPz6Cldhvg9SmzeSxO0CgZA5MAp2
 8QDg63cqIpdGF4MhSFsvGhDYmgJBgBPGjMYHFWprm1aKDxLJM7PVTcB/4SXt8Y0MbDXv
 6h2J2AaocuZr61LzXtyPiUcDeSZMlQJGDI2BjN0o9EAkN7iwHP0f08pO4upCfOs3avM1
 pA1NB9qNqb7QdyMXBQLvqeAU/9ot4/RSUlbDw9ogM+08XU7FLJyA39d3tl5sJW9AmffT
 CgELLr9lL0lG0p3xZAs7mweSV7+rdBv80SWqGvIeWZ25S2AtTB1Y54wbvEvymxjijkdc
 p4Fg==
X-Gm-Message-State: AOAM531bdrsA2/ks1vHtRvpxUDklfS7Wk9GcA+QyHnKljKaQIFWCiDwz
 FB2R8GOCk3xXXm8I3o4OTgdnIfWoKQsxMRx4XmM=
X-Google-Smtp-Source: ABdhPJyC0lhpoHIsnRTYb/jBHTXjzOjCm5sNgTxgszrrtuP+35/7N0zzkKE5Xb0wL4kG5xU1+tZftlhPDtoDlti9U/0=
X-Received: by 2002:ab0:63d9:: with SMTP id i25mr1758952uap.106.1623397353672; 
 Fri, 11 Jun 2021 00:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
In-Reply-To: <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Jun 2021 09:42:22 +0200
Message-ID: <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 stratos-dev@op-lists.linaro.org
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

Hi Viresh, Linus,

On Fri, Jun 11, 2021 at 5:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-06-21, 22:46, Linus Walleij wrote:
> > thanks for working on this, it's a really interesting driver.
> >
> > My first question is conceptual:
> >
> > We previously have Geerts driver for virtualization:
> > drivers/gpio/gpio-aggregator.c
> >
> > The idea with the aggregator is that a host script sets up a
> > unique gpiochip for the virtualized instance using some poking
> > in sysfs and pass that to the virtual machine.
> > So this is Linux acting as virtualization host by definition.

The gpio-aggregator is running on the host...

> > I think virtio is more abstract and intended for the usecase
> > where the hypervisor is not Linux, so this should be mentioned
> > in the commit, possibly also in Kconfig so users immediately
> > know what usecases the two different drivers are for.

... while the virtio-gpio driver is meant for the guest kernel.

I my PoC "[PATCH QEMU v2 0/5] Add a GPIO backend"[1], I didn't have
a virtio transport, but just hooked into the PL061 GPIO emulation
in QEMU.  The PL061 QEMU driver talked to the GPIO backend, which
talked to /dev/gpiochipN on the host.

> Well, not actually.
>
> The host can actually be anything. It can be a Xen based dom0, which
> runs some proprietary firmware, or Qemu running over Linux.
>
> It is left for the host to decide how it wants to club together the
> GPIO pins from host and access them, with Linux host userspace it
> would be playing with /dev/gpiochipN, while for a raw one it may
> be accessing registers directly.
>
> And so the backend running at host, needs to pass the gpiochip
> configurations and only the host understand it.

So QEMU has to translate the virtio-gpio communication to e.g.
/dev/gpiochipN on the host (or a different backend on non-Linux or
bare-metal HV).

> The way I test it for now is by running this with Qemu over my x86
> box, so my host side is indeed playing with sysfs Linux.

Can you please share a link to the QEMU patches?

> > Possibly both could be used: aggregator to pick out the GPIOs
> > you want into a synthetic GPIO chip, and the actual talk
> > between the hypervisor/host and the guest using virtio, even
> > with linux-on-linux.
>
> Not sure if I understand the aggregator thing for now, but we see the
> backend running at host (which talks to this Linux driver at guest) as
> a userspace thing and not a kernel driver. Not sure if aggregator can
> be used like that, but anyway..

The GPIO aggregator came into play after talking to Alexander Graf and
Peter Maydell.  To reduce the attack surface, they didn't want QEMU
to be responsible for exporting to the guest a subset of all GPIOs of
a gpiochip, only a full gpiochip.  However, the full gpiochip may
contain critical GPIOs you do not want the guest to tamper with.
Hence the GPIO aggregator was born, to take care of aggregating all
GPIOs you want to export to a guest into a new virtual gpiochip.

You can find more information about the GPIO Aggregator's use cases in
"[PATCH v7 0/6] gpio: Add GPIO Aggregator"[2].

[1] https://lore.kernel.org/linux-gpio/20200423090118.11199-1-geert+renesas@glider.be
[2] https://lore.kernel.org/linux-doc/20200511145257.22970-1-geert+renesas@glider.be/

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
