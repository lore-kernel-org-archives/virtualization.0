Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4AC48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 07:08:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E1A61370
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 07:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E1A61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0053283AB7;
	Mon, 14 Jun 2021 07:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyzTmyBxrl4K; Mon, 14 Jun 2021 07:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9231E83AB1;
	Mon, 14 Jun 2021 07:08:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51DD3C000E;
	Mon, 14 Jun 2021 07:08:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96AF3C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71DD540428
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uhy8QpRzvBKo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:08:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35362403ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 07:08:05 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id u18so9831944pfk.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 00:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cE3BItc0etFTtT3DKKS6LEXcYghKEYuPi31YretVNcI=;
 b=hWGT7pC/nY1a2nMRch8iUAFWwQsjRaVi4BiGQljxV/RwRoCWJ01uKjH5GmCBiGtGkB
 GLLf/GjcUX7EgxD5tTYCyHuRD4t0QfSopGKWadTOWw8aSoO4NC+U2JYiiIsvzVkqqozS
 2PI1oTA4Y3K+cj2SqXFa2JzN3fvJZVJylNsG4UttFA6yYMP2ViTnkFWBGvZE2yqmZmqT
 gUsKmEBGP7NGyTCPge1i5aQHj5dCqzRCVjV/hBavRvjBgLI4wfnCpSrhiyyMKW6Nqmj9
 PD0v6gSlTaAhbmmz+VUpIQ/0IEapL5qUYbW9GBTULD78lJ2JPu/MkHHPvIZjPMKelz2u
 mpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cE3BItc0etFTtT3DKKS6LEXcYghKEYuPi31YretVNcI=;
 b=GvnxIjbCdyATK227XncBdAIHDAfHRxkns4pmwy6FC5AGdYA90N4weWD8t80w924PDp
 enRvOlYlSmp17VigsHpUokCYTs0b6JbGaontBn1OsXORUW4gnz15tk6LOJW7DRL4YLEw
 SdHKeH70uUUqlM4ws2t9p+ZW+OEPJTqAXZscfPMSyvhfoM8toCsEXvrFeecIJHTm5Fq6
 aEff5LfVZzEeBOqCVbDUmVAJmrAaYvFxca/C+HVie6jG2ViTIhJ1Cxn6DR+HmcrpZ4qn
 cxCXn7XjuU9uGVuib1JvH7Y3aWe0J3e62GaZ5ljV+XtKo5U8lo3Oap5UXwMjVW2LXrLT
 fJoA==
X-Gm-Message-State: AOAM530JSj5VzeQhoOqiw/mUU2TiEioxPxo+QLGN+YLGQ4PnMcQYWOc9
 zo6jHn+Ok0xoi4SATTbTsbzLrA==
X-Google-Smtp-Source: ABdhPJwv8FULBhRjCLmONqNqPjUMDKsZ3zKpN+cND2VwYFv5+MAD8+DlWsZbZGvBVCHy0VZ4Wi3A0g==
X-Received: by 2002:aa7:949c:0:b029:2fa:c881:dd0 with SMTP id
 z28-20020aa7949c0000b02902fac8810dd0mr639470pfk.9.1623654484468; 
 Mon, 14 Jun 2021 00:08:04 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id t143sm13203696pgb.93.2021.06.14.00.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 00:08:03 -0700 (PDT)
Date: Mon, 14 Jun 2021 12:38:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 2/3] gpio: virtio: Add IRQ support
Message-ID: <20210614070801.5tbkebxmz4gvcpai@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <911941d4bf19f18abdc9700abca9f26b3c04c343.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdYHMtG_X3FgiArbQW49kTwJwOGn90peDvAV5Bs5oDiC7A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdYHMtG_X3FgiArbQW49kTwJwOGn90peDvAV5Bs5oDiC7A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bill Mills <bill.mills@linaro.org>, stratos-dev@op-lists.linaro.org
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

On 10-06-21, 23:30, Linus Walleij wrote:
> On Thu, Jun 10, 2021 at 2:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +static void virtio_gpio_irq_unmask(struct irq_data *d)
> > +{
> > +       struct gpio_chip *gc = irq_data_to_gpio_chip(d);
> > +       struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
> > +       struct vgpio_line *line = &vgpio->lines[d->hwirq];
> > +
> > +       line->masked = false;
> > +       line->masked_pending = true;
> > +}
> 
> This looks dangerous in combination with this:
> 
> > +static void virtio_gpio_interrupt(struct virtqueue *vq)
> > +{
> (...)
> > +       local_irq_disable();
> > +       ret = generic_handle_irq(irq);
> > +       local_irq_enable();
> 
> Nominally slow IRQs like those being marshalled over
> virtio should be nested, handle_nested_irq(irq);
> but are they?

Hmm, this is the call trace:

Call trace:
 virtio_gpio_interrupt+0x34/0x168
 vring_interrupt+0x64/0x98
 vp_vring_interrupt+0x5c/0xa8
 vp_interrupt+0x40/0x78
 __handle_irq_event_percpu+0x5c/0x180
 handle_irq_event_percpu+0x38/0x90
 handle_irq_event+0x48/0xe0
 handle_fasteoi_irq+0xb0/0x138
 generic_handle_irq+0x30/0x48
 __handle_domain_irq+0x60/0xb8
 gic_handle_irq+0x58/0x128
 el1_irq+0xb0/0x180
 arch_cpu_idle+0x18/0x28
 default_idle_call+0x24/0x5c
 do_idle+0x1ec/0x288
 cpu_startup_entry+0x28/0x68
 rest_init+0xd8/0xe8
 arch_call_rest_init+0x10/0x1c
 start_kernel+0x508/0x540

I don't see a threaded interrupt in the path and vp_vring_interrupt()
already takes spin_lock_irqsave().

This is what handle_nested_irq() says:

 *	Handle interrupts which are nested into a threaded interrupt
 *	handler. The handler function is called inside the calling
 *	threads context.

So AFAICT, handle_nested_irq() is relevant if the irq-chip's handler
is called in threaded context instead of hard one. In this case it is
called from hard-irq context and so calling generic_handle_irq() looks
to be the right thing.

Right ?

> Or are they just quite slow not super slow?

It doesn't use another slow bus like I2C, but this should be slow
anyway.

> If a threaded IRQF_ONESHOT was requested the
> IRQ core will kick the thread and *MASK* this IRQ,
> which means it will call back to your .irq_mask() function
> and expect it to be masked from this
> point.
> 
> But the IRQ will not actually be masked until you issue
> your callbacks in the .irq_bus_sync_unlock() callback
> right?

Yes.

> So from this point until .irq_bus_sync_unlock()
> get called and actually mask the IRQ, it could be
> fired again?

Since we are defining the spec right now, this is up to us to decide
how we want to do it.

> I suppose the IRQ handler is reentrant?

It shouldn't happen because of the locking in place in the virtqueue
core (vp_vring_interrupt()).

> This would violate the API.
> 
> I would say that from this point and until you sync
> you need a spinlock or other locking primitive to
> stop this IRQ from fireing again, and a spinlock will
> imply local_irq_disable() so this gets really complex.
> 
> I would say only using nesting IRQs or guarantee this
> some other way, one way would be to specify that
> whatever is at the other side of virtio cannot send another
> GPIO IRQ message before the last one is handled,
> so you would need to send a specific (new)
> VIRTIO_GPIO_REQ_IRQ_ACK after all other messages
> have been sent in .irq_bus_sync_unlock()
> so that the next GPIO IRQ can be dispatched after that.

I was thinking of mentioning this clearly in the spec at first, but
now after checking the sequence of things it looks like Linux will do
it anyway. Though adding this clearly in the spec can be better. We
should just send a response message here instead of another message
type VIRTIO_GPIO_REQ_IRQ_ACK.

> (Is this how messaged signalled interrupts work? No idea.
> When in doubt ask the IRQ maintainers.)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
