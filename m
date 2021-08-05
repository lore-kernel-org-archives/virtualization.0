Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59586C4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 07:05:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE606105A
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 07:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDE606105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3B26403A4;
	Thu,  5 Aug 2021 07:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ET3H7B0xAtl9; Thu,  5 Aug 2021 07:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BA96402E5;
	Thu,  5 Aug 2021 07:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06DE7C0010;
	Thu,  5 Aug 2021 07:05:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8051C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6AE7605D5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQ_K6Ut8CGMy
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:05:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA67A605BF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:05:38 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id c16so5952273plh.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FxHHuwRa022IYUpHzp8PytbjIjdvdslF6xPwTOr4scE=;
 b=PnZSsVQppiMftx9XAoP2jHE7p7gt88wSLY43rk+K5mszCd/AgD0tkmG+Wwtk3qEE5E
 kbxQmqI+25CfGeUrwQhdpOJpZIMhChvAP089r9bAOaTuwoNZVwOLIbC9PITQXGrrPG6J
 0wZnVly6bHbY3JsItrJZ7L3ccRLAzCt0spZT6bT0gG3sD7flYYZDRpj9SLUNRlzfBJeP
 6Dblpv2Yz8JjSob7NlaQPl2+bgH3JuidhA2K9xCJnASFsLS964d7vZiO2QHoK4lRMuIQ
 XhhQPYqPNXGKeV2snjx4zymwss/Q+4tnjsD5C0Nv/O+18LscFeNk0tDpAHd/0JUIw3hD
 A1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FxHHuwRa022IYUpHzp8PytbjIjdvdslF6xPwTOr4scE=;
 b=lmDIRXLXdxltPOkuoIBHMRv6RzZFjbGyPC6vjvmnfT1cRSQ/1aYgLQDWXKP0FTU0Hq
 J1tU2cU/uERfjFJXxuOnZ6A7VQByiB8s3w2G94Ftwecoqo1NXKekugb8WGiIYKoK9CXo
 +zzgr1UydRvS9mlXBjJMMdCdKzDxcjhLv1I5RTC1oMnl5dHGvNJ1/yIAQzWdi5ZpaOsV
 ZhMgDPKygcwAYHe+nZc9qILMn/xh6G7LrcTpNfM/29jGRF0uu0rn4zEAnUI02aZZZ1F/
 0EKI70tWrTY3P3nvGGNE6aOdPNNzhlIT4WNBEIONcgtWH9K3iQgQrgikdVtUEENtC41e
 PvDg==
X-Gm-Message-State: AOAM533RbAfVL+uTVTMFdJG6ZulxmY9NCfN9utb6aYfqXIAcEG0h8hdn
 dOdfELftcQNwXbCTKkHyNOruQw==
X-Google-Smtp-Source: ABdhPJz9GPgd7WBGMGktlIchOl0wZ/x/nX/NNuIBF+bGBdyQkk3ZaIp0SU4+uWUtnHYBuugcVZzUbQ==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id
 b10-20020a056a000a8ab0290356be617f18mr3404921pfl.29.1628147137949; 
 Thu, 05 Aug 2021 00:05:37 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id 21sm5191968pfp.211.2021.08.05.00.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 00:05:37 -0700 (PDT)
Date: Thu, 5 Aug 2021 12:35:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210805070534.lia6bc5c2l73d7cf@vireshk-i7>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
 <75c8e6e5e8dfa1889938f3a6b2d991763c7a3717.1627989586.git.viresh.kumar@linaro.org>
 <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
 <20210804070531.w3h3jm6rou2hpgqj@vireshk-i7>
 <CAK8P3a0vBhP6ZJuqCxAUVZG_eAPu1Lk_Nw8FEarnHb286pPPyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0vBhP6ZJuqCxAUVZG_eAPu1Lk_Nw8FEarnHb286pPPyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>, "Enrico Weigelt,
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

On 04-08-21, 10:27, Arnd Bergmann wrote:
> On Wed, Aug 4, 2021 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 03-08-21, 17:01, Arnd Bergmann wrote:
> > > >
> > > > +static void virtio_gpio_irq_unmask(struct irq_data *d)
> > > > +{
> > > > +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > > > +       struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> > > > +       struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> > > > +
> > > > +       irq_line->masked = false;
> > > > +       irq_line->update_pending = true;
> > > > +}
> > >
> > > Same here. unmask is probably less important, but it's the
> > > same operation: if you want interrupts to become active
> > > again when they are not, just queue the request
> >
> > We can't because its a slow bus ? And unmask can be called from
> > irq-context. That's exactly why we had the irq_bus_lock/unlock
> > discussion earlier.
> 
> I thought only 'mask' is slow, since that has to wait for the completion,
> but 'unmask' just involves sending the eventq request without having
> to wait for it.

Ahh, so you are suggesting of just sending the request without waiting
for the response. We can do it, but I am not sure if it is going to be
worth it considering the additional complexity in the driver.

Maybe lets come back to this later, if this is going to make anything
better, once the basic support for irqs look good here.

> I don't think it is correct that you cannot issue virtio requests from
> atomic context, only that you cannot wait for the reply.

Yes, you are right. I was having a mess because of all the races and
different ways things were getting called.

> For 'unmask', there is no waiting, since the reply is the actual IRQ
> event. For the others, the sequence makes sense.
 
> > - Interrupt: i.e. buffer sent back by the host over virtio.
> >
> >   virtio_gpio_event_vq() schedules a work item, which processes the
> >   items from the eventq virtqueue and eventually calls
> >   generic_handle_irq(). The irq-core can issue calls to
> >   ->irq_mask/unmask() here without a prior call to
> >   irq_bus_lock/unlock(), normally they will balance out by the end,
> >   but I am not sure if it is guaranteed. Moreover, interrupt should be
> >   re-enabled only after unmask() is called (for ONESHOT) and not at
> >   EOI, right ?
> >
> >   I chose not to queue the buffers back from eoi() as it is possible
> >   that we won't want to queue them at all, as the interrupt needs to
> >   be disabled by the time generic_handle_irq() returns. And so I did
> >   everything from the end of vgpio_work_handler()'s loop, i.e. either
> >   disable the interrupts with VIRTIO_GPIO_IRQ_TYPE_NONE or enable the
> >   interrupt again by re-queuing the buffer.
> >
> > Regarding irq handling using work-item, I had to move to that to take
> > care of locking for re-queuing the buffers for a GPIO line from
> > irq-handler and bus-unlock. Nothing else seemed to work, though I am
> > continuing to look into that to see if there is an alternative here.
> 
> I don't think it makes sense to optimize for the rare case that the
> irq handler disables the irq, when that makes the common case
> (irq remains unmasked and enabled) much slower.

I am not worried about that case only, i.e. where the
interrupt-handler disables the interrupt. It should work fine though,
even if it isn't optimized.

A) If the client has registered with irq with IRQF_ONESHOT, irq core
   will call ->irq_mask(), irq-handler(), ->irq_eoi(), and finally
   ->irq_unmask(). Looking at this basic sequence itself, irq_eoi()
   shouldn't enable the interrupt again by re-queuing the buffer,
   rather it should happen from unmask in this case.

B) If the client has registered a threaded-irq, it gets even more
   complex. The core does this in that case:

   call ->irq_mask(), ->irq_eoi(), and return control back to
   virtio_gpio_event_vq().

   The thread gets scheduled then and calls the irq-handler and then
   the irq-core calls irq-bus-lock(), ->irq_unmask(),
   irq-bus-unlock().

Looking at these, eoi shouldn't be queuing the buffer. Also, I wonder
if we should use handle_fasteoi_irq() here or something else.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
