Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0FC48BD1
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 03:56:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE266023C
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 03:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE266023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07080401EA;
	Fri, 11 Jun 2021 03:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2B3-02nWuFVl; Fri, 11 Jun 2021 03:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86015400BF;
	Fri, 11 Jun 2021 03:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE1CC000E;
	Fri, 11 Jun 2021 03:56:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2701C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9CA583A46
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzSvitfMg9N2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:56:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08B7783883
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:56:25 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 m13-20020a17090b068db02901656cc93a75so5044395pjz.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=y2qSt5MTPC4i/yZdbT2U8qNkMyz0fUe0S4KpmrMnVM0=;
 b=Pp54dHVW2lnIM30U3BV+erjZRwPxWl9KORNqmsFACq8HbKd5iPcisfpwWc91sIL5Ij
 9S771WrqAVUEKhWx7BqzNbsS5RF80FgTojcY/EGfrtgbqjeDp/LmqmWxO5D8EPPnfVxr
 xPX3zlRloqrk+x4GWXKe4dHJpJFv3yOGGjjKW2mm3RJxhkXsVtZgMPCtQj+EooWZddvZ
 hM5t8W2h9iE076WyTRmzN6YfCuF2c+7ZcUODvU46ko+T0SCOYbZtXwqvQ/hohb2B0d41
 INHeHvqoarmtJaERP8nL++YxGKksgDcSxw+x1ezbmqK8LApbkQbcvC8yhOXIyIsP0sk2
 lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=y2qSt5MTPC4i/yZdbT2U8qNkMyz0fUe0S4KpmrMnVM0=;
 b=DrHU9rw//QU/i22NupU5CHkW6BLCHIyuQ+0U/tjUHFTvs2YC9CTvugqb0fVcdmXaMl
 2rZtJbirN/VDbSINyulI7BiG0oN/J8sEcjgtP4h/XYtT2iLLduiNYM2r4khLRP98/23z
 tjIQGe3uZmskQu4SBuOTENnyhCVtOGrDKIAeT6YG8gX1J+no6u5CXji5y276WCpClvQe
 NxatN4rB8ADSmy+lSxnl3wcdy0elCvut7S7QbBZVLOZodcdgLp588+7BGGjY4joAWEzu
 zKmesEv7yYCb+UTauEEDkOYyb6oX4tvpRZ/O52Eek6mQ1f7NL3/MnVqb0UBOrTmTCOSY
 mvlw==
X-Gm-Message-State: AOAM531K+fi5IElnslQiR9VuzkfQeKF5+OuGp+OqpwvYd4w3Xi505iOZ
 rZCZ/xLej1mElbDK40SjJ1epYg==
X-Google-Smtp-Source: ABdhPJzxIiGetfFhS9ztQIZMMt8HMOkWddsWstwWGvKVrQ/FQp/VBvvqy+rgJCiiMFWYHJR4YkU9QA==
X-Received: by 2002:a17:902:8695:b029:fd:6105:c936 with SMTP id
 g21-20020a1709028695b02900fd6105c936mr2013079plo.25.1623383785323; 
 Thu, 10 Jun 2021 20:56:25 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id g8sm3889378pgo.10.2021.06.10.20.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 20:56:24 -0700 (PDT)
Date: Fri, 11 Jun 2021 09:26:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

Hi Linus,

On 10-06-21, 22:46, Linus Walleij wrote:
> Hi Viresh!
> 
> thanks for working on this, it's a really interesting driver.
> 
> My first question is conceptual:
> 
> We previously have Geerts driver for virtualization:
> drivers/gpio/gpio-aggregator.c
> 
> The idea with the aggregator is that a host script sets up a
> unique gpiochip for the virtualized instance using some poking
> in sysfs and pass that to the virtual machine.
> So this is Linux acting as virtualization host by definition.
> 
> I think virtio is more abstract and intended for the usecase
> where the hypervisor is not Linux, so this should be mentioned
> in the commit, possibly also in Kconfig so users immediately
> know what usecases the two different drivers are for.

Well, not actually.

The host can actually be anything. It can be a Xen based dom0, which
runs some proprietary firmware, or Qemu running over Linux.

It is left for the host to decide how it wants to club together the
GPIO pins from host and access them, with Linux host userspace it
would be playing with /dev/gpiochipN, while for a raw one it may
be accessing registers directly.

And so the backend running at host, needs to pass the gpiochip
configurations and only the host understand it.

The way I test it for now is by running this with Qemu over my x86
box, so my host side is indeed playing with sysfs Linux.

> Possibly both could be used: aggregator to pick out the GPIOs
> you want into a synthetic GPIO chip, and the actual talk
> between the hypervisor/host and the guest using virtio, even
> with linux-on-linux.

Not sure if I understand the aggregator thing for now, but we see the
backend running at host (which talks to this Linux driver at guest) as
a userspace thing and not a kernel driver. Not sure if aggregator can
be used like that, but anyway..

> Yet another usecase would be to jit this with remoteproc/rpmsg
> and let a specific signal processor or real-time executive on
> another CPU with a few GPIOs around present these to
> Linux using this mechanism. Well that would certainly interest
> Bjorn and other rpmsg stakeholders, so they should have
> a look so that this provides what they need they day they
> need it. (CCed Bjorn and also Google who may want this for
> their Android emulators.)

I am not very clear on the rpmsg thing, I know couple of folks at
project Stratos were talking about it :)

@Alex, want to chime in here for me ? :)

> On Thu, Jun 10, 2021 at 2:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > +static const char **parse_gpio_names(struct virtio_device *vdev,
> > +                              struct virtio_gpio_config *config)
> 
> I really like this end-to-end plug-and-play that even provides
> the names over virtio.

The credit goes to Enrico for this :)

> I think my patch to the gpiolib to make it mandatory for names to
> be unique per-chip made it in, but please make that part of the spec
> so that we don't get the problem with non-unique names here.

Oh, that's nice. I will surely do that.

> I suppose the spec can be augmented later to also accept config
> settings like open drain pull up/down etc but no need to specify
> more than the basic for now.

That's the plan.

> But to be able to add more in the future, the client needs some
> kind of query mechanism or version number so the driver can
> adapt and not announce something the underlying virtio device
> cannot do. Do we have this? A bitmask for features, a version
> number that increase monotonically for new features to be
> presented or similar?
> 
> Because otherwise we have to bump this:
> +#define VIRTIO_ID_GPIO                 41 /* virtio GPIO */
> 
> every time we add something new (and we will).

Yes, Virtio presents features for this. The patch 2/3 already uses one
for IRQs. We won't need to bump up the IDs :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
