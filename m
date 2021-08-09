Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F0C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:30:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F1C61051
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2F1C61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88434400F2;
	Mon,  9 Aug 2021 07:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfIUxwBS1ABA; Mon,  9 Aug 2021 07:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 944E8400BE;
	Mon,  9 Aug 2021 07:30:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6150BC001A;
	Mon,  9 Aug 2021 07:30:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 103E3C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0940F400F2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yiPZFX5hAwz8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:30:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1F5E400BE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:30:23 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 mq2-20020a17090b3802b0290178911d298bso5683679pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6AaH/QvzJmMTb/tLFdsE2g2dSuN00KFriVjp+nrWMKo=;
 b=n3JUpjnMCUehTXcRC2vvYvjrX4sIYgtTBEdqO95/Jt9Hn9OnclNx9GduauyhRey287
 8nLtSx5vopa18swm/eS0hMKso9qA3Fhd83TVyljzMEEPfFFGRM/VvDb3XNmXiPrTvfKd
 lVlxk2E8NZOZXs4nO1t/xEGMRdcfrsC/n2KdKJwKvcsMlinlYgPB4iSY3rK5an8sEFH9
 bmTsjn94+sKBDYBbjRA3tJQCluMZeCV5VDnIXdMBDYMAxKSoCXIukdBvFwuF7xPlC4f+
 VRH6yUcShJeOGMF6Q1fDQffqMLo0AenRzsdrZqQqUA+vZAQQhjmb0MFQIgOFjajTZLsc
 x/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6AaH/QvzJmMTb/tLFdsE2g2dSuN00KFriVjp+nrWMKo=;
 b=aQFt6zVPjLEpwxqEQTSyap8zkZ1rAV27sv8IPgeWtkpL9jEiSaD0QSlFLgl0yKMhQG
 8Bp0nfjNI7/P02sTpSKwXbL3iwQwnElmyljo6aV4SzvfZOYFWDYDDI7HnpfbABNCt0ES
 n6EcMC4GQ0biy7gBjHLg45+YBcddSlPq896doeoz4LceU9wA8YS6h9hs6iFQT8t4gR4k
 33T6pkBvzrXdyrsQw6rahx9c2oOqa/H7NZuvoLdoWUUsn8gzHxxCFVBT+Lb+1PMzBJ73
 4breoXUQ/swkw54JPD+O5mAqhPa0hhHidkC+ger3NihHs0XVJmiDwPxrTXwjY5ydH0Z8
 m6pQ==
X-Gm-Message-State: AOAM533BeT4rKAqyiRVdPGpRoiqd5PgK1x/ha+XeVLMAoNDQ9NJY6OtZ
 YLY+0WCvtlvRqFtvJePMSRxW8w==
X-Google-Smtp-Source: ABdhPJxeoZhdVD34qHvFm3x0OrPEUWTYjI47uQbkZF5kBJ2jSlkeRPl7vBozGIeSrM03ZFEKr0P5+A==
X-Received: by 2002:a17:90a:17a3:: with SMTP id
 q32mr3416980pja.195.1628494223102; 
 Mon, 09 Aug 2021 00:30:23 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id r17sm23592320pgu.8.2021.08.09.00.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 00:30:22 -0700 (PDT)
Date: Mon, 9 Aug 2021 13:00:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [Stratos-dev] [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210809073020.y6ruibdm37xnx7hg@vireshk-i7>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
 <75c8e6e5e8dfa1889938f3a6b2d991763c7a3717.1627989586.git.viresh.kumar@linaro.org>
 <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
 <0100017b1610f711-c53c79f2-9e28-4c45-bb42-8db09688b18e-000000@email.amazonses.com>
 <CAK8P3a0DWkfQcZpmyfKcdNt1MHf8ha6a9L2LmLt1Tv-j0HDr3w@mail.gmail.com>
 <20210805124922.j7lts7tfmm4t2kpf@vireshk-i7>
 <CAK8P3a0kbmPLGCBrjAv7-dW=JWq-pdSBeGUHCxUFmMKvKhCg7w@mail.gmail.com>
 <0100017b1a6c0a05-e41dc16c-b326-4017-a63d-a24a6c1fde70-000000@email.amazonses.com>
 <CAK8P3a2rrueXJHZxuiiShgVmLD916RaxW7xQHHjQXNFkM3Fpvg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2rrueXJHZxuiiShgVmLD916RaxW7xQHHjQXNFkM3Fpvg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>
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

On 06-08-21, 10:00, Arnd Bergmann wrote:
> On Fri, Aug 6, 2021 at 9:44 AM Viresh Kumar via Stratos-dev
> <stratos-dev@op-lists.linaro.org> wrote:
> >
> > On 05-08-21, 15:10, Arnd Bergmann wrote:
> > > I hope this can still be simplified by working out better which state
> > > transitions are needed exactly. In particular, I would expect that we
> > > can get away with not sending a VIRTIO_GPIO_MSG_IRQ_TYPE
> > > for 'mask' state changes at all, but use that only for forcing 'enabled'
> > > state changes.
> >
> > Something like this ?
> 
> > static void virtio_gpio_irq_mask(struct irq_data *d)
> > {
> >         /* Nothing to do here */
> > }
> 
> You'd have to do /something/ here I think, if only setting the flag
> that we don't want to deliver the next interrupt.
> 
> > static void virtio_gpio_irq_unmask(struct irq_data *d)
> > {
> >         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> >         struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> >
> >         /* Queue the buffer unconditionally on unmask */
> >         virtio_gpio_irq_prepare(vgpio, d->hwirq);
> > }
> 
> And check the flag here to not requeue it if it's masked.

I am not sure I understand why this would be required. If the
interrupt is getting disabled, then unmask will not get called here
and so we won't requeue anything. Same will happen with threaded
handlers where the interrupt gets unmasked at a later point of time.

> Now, there is already a flag in the irq descriptor, so rather than
> having double accounting, the easy way may be to
> just use irqd_irq_masked()/irq_state_set_masked(), or
> have the irq core take care of this.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
