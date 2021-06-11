Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD90C48BE0
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 08:01:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BB961027
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BB961027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F809406B9;
	Fri, 11 Jun 2021 08:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxdxwilHSmoZ; Fri, 11 Jun 2021 08:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48BC3406AB;
	Fri, 11 Jun 2021 08:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225A5C000E;
	Fri, 11 Jun 2021 08:01:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B17EC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20E9683BAC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8lm_NP_l-4kx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:01:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2845A83AC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 08:01:25 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id o9so1828085pgd.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dDD6ozQuHkfsjJXIeMviIaHXaasyFUacyXt/Ls+8R/4=;
 b=H2vJeZvjIh9pgu2UG0sKGBhDj+x8aQhG/MfT1Cxtztd+CblLvs4QSwrLvNWyQ01BVy
 i6rUSqwWT6YxqHNCSJ0o4eDEUa0E51TjjqikU8ZGPtTjHvKJxcqAci0jvgffQrMqqyPl
 5GWj7dgoSke+cSE0YiCPmRTujqWqKuHKMMo10p8azW1mM7x/cuOtHMabsZUBU5OBD2+a
 lUX+G37CNYrOL0Gt8PzG3CIysFGvU9gqaETpWcWCaPrG5IBtUfmv9N79D9bToGBjgCRR
 i2ThzGT/BoEAOF2sV+5EkiQxPUywzJwdzzTtLePbsw7q6Z2f4vkYfFjgP4ws+Otgcu8Q
 G/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dDD6ozQuHkfsjJXIeMviIaHXaasyFUacyXt/Ls+8R/4=;
 b=eTkzV88W3+pdSYlIXUwWcAS7Ao1050DrueVfiwTGVRHk6EYmdy06HzE75NeE55X5Ps
 7VcTV6cJrHcPh4YO1DhoaHoEQ0cfOyVQpBOBiYfIrmaw1MUyTJjZCydmiT1n5JH5x2Uf
 saH0ykUtwYnkbZA7KkPKWj2L6xg8JMZw7pxCVUbSlY9btePDcNe6m+kVleMCNp4dngBu
 347uWei0Bdxzr2wYqDQzPIqccYBU9PckSUFbcC1MB2V0qC696XKAAsoyt7LiJPfU2isB
 NyxOAOwQhj7jFKMa452SG2uv8Caw152N++f/U5H8iTbz7wIrDelPxUEXaZyedzv9xCg4
 r1Mg==
X-Gm-Message-State: AOAM533xNpdHRRP+qodS9TzWElNaivqAeUxaaJkfNA829Yw+Mbrmc/yl
 zuYXgFNt1kUCYdToQWmohO4udQ==
X-Google-Smtp-Source: ABdhPJzQqL9BA7ZqXfmHsqjU1YOZ0ByTX9+TANEafYUiavQpaP9W5HLlNZKSJtUVqq4l4MmWcghzvA==
X-Received: by 2002:a62:2c92:0:b029:2ef:6118:a934 with SMTP id
 s140-20020a622c920000b02902ef6118a934mr7063663pfs.80.1623398484479; 
 Fri, 11 Jun 2021 01:01:24 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id j4sm4258445pfj.111.2021.06.11.01.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 01:01:23 -0700 (PDT)
Date: Fri, 11 Jun 2021 13:31:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On 11-06-21, 09:42, Geert Uytterhoeven wrote:
> Hi Viresh, Linus,
> 
> On Fri, Jun 11, 2021 at 5:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 10-06-21, 22:46, Linus Walleij wrote:
> > > thanks for working on this, it's a really interesting driver.
> > >
> > > My first question is conceptual:
> > >
> > > We previously have Geerts driver for virtualization:
> > > drivers/gpio/gpio-aggregator.c
> > >
> > > The idea with the aggregator is that a host script sets up a
> > > unique gpiochip for the virtualized instance using some poking
> > > in sysfs and pass that to the virtual machine.
> > > So this is Linux acting as virtualization host by definition.
> 
> The gpio-aggregator is running on the host...
> 
> > > I think virtio is more abstract and intended for the usecase
> > > where the hypervisor is not Linux, so this should be mentioned
> > > in the commit, possibly also in Kconfig so users immediately
> > > know what usecases the two different drivers are for.
> 
> ... while the virtio-gpio driver is meant for the guest kernel.
> 
> I my PoC "[PATCH QEMU v2 0/5] Add a GPIO backend"[1], I didn't have
> a virtio transport, but just hooked into the PL061 GPIO emulation
> in QEMU.  The PL061 QEMU driver talked to the GPIO backend, which
> talked to /dev/gpiochipN on the host.

Hmm, interesting.

> > Well, not actually.
> >
> > The host can actually be anything. It can be a Xen based dom0, which
> > runs some proprietary firmware, or Qemu running over Linux.
> >
> > It is left for the host to decide how it wants to club together the
> > GPIO pins from host and access them, with Linux host userspace it
> > would be playing with /dev/gpiochipN, while for a raw one it may
> > be accessing registers directly.
> >
> > And so the backend running at host, needs to pass the gpiochip
> > configurations and only the host understand it.
> 
> So QEMU has to translate the virtio-gpio communication to e.g.
> /dev/gpiochipN on the host (or a different backend on non-Linux or
> bare-metal HV).

No, QEMU passes the raw messages to the backend daemon running in host
userspace (which shares a socket with qemu). The backend understands
the virtio/vhost protocols and so won't be required to change at all
if we move from Qemu to something else. And that's what we (Linaro)
are looking to do here with Project Stratos.

Create virtio based hypervisor agnostic backends.

> > The way I test it for now is by running this with Qemu over my x86
> > box, so my host side is indeed playing with sysfs Linux.
> 
> Can you please share a link to the QEMU patches?

Unfortunately, they aren't in good shape right now and the backend is
a bit hacky (Just checking the data paths, but not touching
/dev/gpiochipN at all for now).

I didn't implement one as I am going to implement the backend in Rust
and not Qemu. So it doesn't depend on Qemu at all.

To give you an idea of the whole thing, here is what we have done for
I2c for example, GPIO one will look very similar.

The Qemu patches:

https://yhbt.net/lore/all/cover.1617278395.git.viresh.kumar@linaro.org/T/

The stuff from tools/vhost-user-i2c/ directory (or patch 4/6) isn't
used anymore and the following Rust implementation replaces it:

https://github.com/vireshk/vhost-device/tree/master/src/i2c

I can share the GPIO code once I have the Rust implementation ready.

> The GPIO aggregator came into play after talking to Alexander Graf and
> Peter Maydell.  To reduce the attack surface, they didn't want QEMU
> to be responsible for exporting to the guest a subset of all GPIOs of
> a gpiochip, only a full gpiochip.  However, the full gpiochip may
> contain critical GPIOs you do not want the guest to tamper with.
> Hence the GPIO aggregator was born, to take care of aggregating all
> GPIOs you want to export to a guest into a new virtual gpiochip.
> 
> You can find more information about the GPIO Aggregator's use cases in
> "[PATCH v7 0/6] gpio: Add GPIO Aggregator"[2].

So I was actually looking to do some kind of aggregation on the host
side's backend daemon to share only a subset of GPIO pins, I will see
if that is something I can reuse. Thanks for sharing details.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
