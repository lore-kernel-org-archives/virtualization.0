Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139DBC48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 21:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4A961059
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 21:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4A961059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CD9E4064E;
	Thu, 10 Jun 2021 21:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDF3z0iSC9mL; Thu, 10 Jun 2021 21:30:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B97FF4057B;
	Thu, 10 Jun 2021 21:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA44C000D;
	Thu, 10 Jun 2021 21:30:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EFFAC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 21:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EF9440630
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 21:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWfxFe9Xe0OM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 21:30:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C1AA4057B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 21:30:21 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id bn21so6896468ljb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mc0t7dqVDGu20ZDgp1J77BZzzR8pf6dBx6PMN3sIo8c=;
 b=aOEIplv0pyoO+2D1enYzTH7rRMUM5qf5y/qVUZMMn97grwASNtzDCe6NqISGYiZMo/
 ukksvEVMwqEiLXlOk7Xqes3HVR1NjBClrE1UmSQ+glzsnFi3+RbYzGF78dSlKpLFU0JZ
 fdTr/eSTmYpuSXZulL5tGXRJG/I0jBiZbkhkcpdSROdkYtLEck/4uALoj6p0onaq315m
 JtShyX4vbRX1kL2eW4pFO5ne3PKIMIIoI3VPqWTXEo3+d3M4W6uXg7lVNw/lt/VjhUrE
 6A8O8GSKAnoiX+g/msiwrr/WSJCOVPblDBUfbeD3OI0es+O8CDxB3CEA+scJZ1LWc7dI
 gSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mc0t7dqVDGu20ZDgp1J77BZzzR8pf6dBx6PMN3sIo8c=;
 b=E/gtBanfbdolB6RlU5t/DN09yJvVJYsPArpbyCOTnfxAzjYx5HK24H/M5vMk6xXsNN
 ejvl7sHfyBpl3NoeUPlhL2oGMYhwE8waltBo8ORoVeG+lGjzjNMJY2Dtsd3MK/Pimqqo
 VD32qwLzUKksZViibIixo+2HGXu4sBSLtfmqhWuunHoQV6NznaCkQFwf95VBuwqD+K03
 SgZc9eO55keO+f6U9Hw4uljagTo9spAcVtE67WoVCzy1y9nmHWqGfhdgN2NeSjJBhUI0
 Nrg1Piaw+4ABxGEjdvC73M0yQYZAXV6useBK1jpxtL+ecl9AkfG5NjuJfRWYUtdreEaZ
 R9GA==
X-Gm-Message-State: AOAM531GDRYQBXDpDoEv0uR58dnng6o1FZoj2ziAyLz9Dwvm7xm9BQgX
 wMId8MGwO/l+jyies9vU1G5RasFd7w6qIMkyv4hA/g==
X-Google-Smtp-Source: ABdhPJwLHL8jOR3WGl2QJnT+GPWUrRqLDv/5Ut16hTcM8MfJaU0MmKihHfxqkHVnSdiiDFsReGTpITxPhKmBolVuFZo=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr433222lji.273.1623360618946; 
 Thu, 10 Jun 2021 14:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <911941d4bf19f18abdc9700abca9f26b3c04c343.1623326176.git.viresh.kumar@linaro.org>
In-Reply-To: <911941d4bf19f18abdc9700abca9f26b3c04c343.1623326176.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jun 2021 23:30:07 +0200
Message-ID: <CACRpkdYHMtG_X3FgiArbQW49kTwJwOGn90peDvAV5Bs5oDiC7A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
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

Hi Viresh!

thanks for this interesting patch!

On Thu, Jun 10, 2021 at 2:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds IRQ support for the virtio GPIO driver. Note that this
> uses the irq_bus_lock/unlock() callbacks since the operations over
> virtio can sleep.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

>  drivers/gpio/gpio-virtio.c       | 256 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_gpio.h |  15 ++

You also need to
select GPIOLIB_IRQCHIP
in the Kconfig entry for the gpio-virtio driver, because you make
use of it.

> +static void virtio_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_to_gpio_chip(d);
> +       struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
> +       struct vgpio_line *line = &vgpio->lines[d->hwirq];
> +
> +       line->masked = true;
> +       line->masked_pending = true;
> +}
> +
> +static void virtio_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_to_gpio_chip(d);
> +       struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
> +       struct vgpio_line *line = &vgpio->lines[d->hwirq];
> +
> +       line->masked = false;
> +       line->masked_pending = true;
> +}

This looks dangerous in combination with this:

> +static void virtio_gpio_interrupt(struct virtqueue *vq)
> +{
(...)
> +       local_irq_disable();
> +       ret = generic_handle_irq(irq);
> +       local_irq_enable();

Nominally slow IRQs like those being marshalled over
virtio should be nested, handle_nested_irq(irq);
but are they? Or are they just quite slow not super slow?

If a threaded IRQF_ONESHOT was requested the
IRQ core will kick the thread and *MASK* this IRQ,
which means it will call back to your .irq_mask() function
and expect it to be masked from this
point.

But the IRQ will not actually be masked until you issue
your callbacks in the .irq_bus_sync_unlock() callback
right?

So from this point until .irq_bus_sync_unlock()
get called and actually mask the IRQ, it could be
fired again? I suppose the IRQ handler is reentrant?
This would violate the API.

I would say that from this point and until you sync
you need a spinlock or other locking primitive to
stop this IRQ from fireing again, and a spinlock will
imply local_irq_disable() so this gets really complex.

I would say only using nesting IRQs or guarantee this
some other way, one way would be to specify that
whatever is at the other side of virtio cannot send another
GPIO IRQ message before the last one is handled,
so you would need to send a specific (new)
VIRTIO_GPIO_REQ_IRQ_ACK after all other messages
have been sent in .irq_bus_sync_unlock()
so that the next GPIO IRQ can be dispatched after that.

(Is this how messaged signalled interrupts work? No idea.
When in doubt ask the IRQ maintainers.)

Thanks,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
