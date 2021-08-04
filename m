Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A2C4320E
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 07:05:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEA360EEA
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 07:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EEA360EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C673405CF;
	Wed,  4 Aug 2021 07:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXxNON-XpV7b; Wed,  4 Aug 2021 07:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC26D40580;
	Wed,  4 Aug 2021 07:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B39C4C0010;
	Wed,  4 Aug 2021 07:05:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3F01C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2D3F405C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9c-puHstartM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3AA940580
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:05:34 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 pj14-20020a17090b4f4eb029017786cf98f9so2284972pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xDSd0Sk7OOVTJLj0Kr0rQVLGfrtRCoQjOaaQ0mH27Zc=;
 b=fxsKekn9JqnpNnefBJPwd6/QD8EB7YVxndmXqB12cVPdkohoFoTF1C6irb1p8woFOV
 YwA1PZQBC5ZtUJGTnXpK8sUfJQcX02ruLcRwjlr/EzK9HG3G1wJ9D7aF5P93Z2kIMaeF
 HueontkvDeYtzD3vFtWkPDBtJ+JTNQLIV8clSzQ41M9svM+XDDAy4QKAbvzdYUerA7Xn
 Yqz5cod5kAdMQ7Uyrpgz0bJoLREjvyiY3sNeY/PfO6U1E3Da6Kf1Q4Do32Ngux8ut9Ol
 WcL/66S4ncTnvw5Co+l6c1CEBFALS2yls/ebtbzTi8ekvFsZqmrqm7wBRWfQeEVVXOn7
 XU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xDSd0Sk7OOVTJLj0Kr0rQVLGfrtRCoQjOaaQ0mH27Zc=;
 b=Vu9R4+gMuzIm3f4mmxTtFaIhrwxaO5iFr4bC3lwWHh71/cBtjIkG+D1yd5Ltvz4SAd
 xa7H5YJAqyho4i341OvX5f6XojtDkuEKBnhM/ik6Nyyz+kqdAYb/05QTBwmmIBqL4Tqe
 U6hQqkM3IP1JY9QN+DlCTKNnRqCyfaG+IqpHyvnn59LG/xa5mRv4Z9t++JBMe8IWKpZC
 9ydK31PzP58iq7LmSzrJgJ6S8egYooWmBgIUebzUgiQutbUNvUKNSWMLyEgLqTOS1zJs
 uV+5SdGBTkhMqC29aCiopCuP7CYF7/RxOUQTob5aztfy//m63k3CUtW4ohbwWA2YdO0K
 nfbA==
X-Gm-Message-State: AOAM530hm7Va92vWYhjg0VnvrOuB86/efaidyr3S5rHFjHPVJOI3AHti
 KEXKeDwuQJ/rs5K8LSSIe2D7nw==
X-Google-Smtp-Source: ABdhPJwVg3WujjcjF/nTzPLHSowRjAx5x8su7mXB5PqRTS/R6Pkzz9WKHeu21n3s7YJl987X9va5Zg==
X-Received: by 2002:a17:90a:eb0a:: with SMTP id
 j10mr26253461pjz.16.1628060734234; 
 Wed, 04 Aug 2021 00:05:34 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id n1sm1823083pgt.63.2021.08.04.00.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 00:05:33 -0700 (PDT)
Date: Wed, 4 Aug 2021 12:35:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210804070531.w3h3jm6rou2hpgqj@vireshk-i7>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
 <75c8e6e5e8dfa1889938f3a6b2d991763c7a3717.1627989586.git.viresh.kumar@linaro.org>
 <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
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

On 03-08-21, 17:01, Arnd Bergmann wrote:
> On Tue, Aug 3, 2021 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +struct vgpio_irq_line {
> > +       u8 type;
> > +       bool masked;
> > +       bool update_pending;
> > +       bool queued;
> > +
> > +       struct virtio_gpio_irq_request ireq;
> > +       struct virtio_gpio_irq_response ires;
> > +};
> 
> I think the last two members should be marked as __cacheline_aligned,
> since they are transferred separately over DMA.

Right.

> > +static void virtio_gpio_irq_eoi(struct irq_data *d)
> > +{
> > +       /*
> > +        * Queue buffers, by calling virtio_gpio_irq_prepare(), from
> > +        * virtio_gpio_event_vq() itself, after taking into consideration the
> > +        * masking status of the interrupt.
> > +        */
> > +}
> 
> Shouldn't this just requeue the interrupt? There is no reason to
> defer this, and I think we want the normal operation to not have
> to involve any scheduling.
> 
> > +static void virtio_gpio_irq_unmask(struct irq_data *d)
> > +{
> > +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +       struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> > +       struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> > +
> > +       irq_line->masked = false;
> > +       irq_line->update_pending = true;
> > +}
> 
> Same here. unmask is probably less important, but it's the
> same operation: if you want interrupts to become active
> again when they are not, just queue the request

We can't because its a slow bus ? And unmask can be called from
irq-context. That's exactly why we had the irq_bus_lock/unlock
discussion earlier.

> > +static void virtio_gpio_irq_mask(struct irq_data *d)
> > +{
> > +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +       struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> > +       struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> > +
> > +       irq_line->masked = true;
> > +       irq_line->update_pending = true;
> > +}
> 
> This is of course the tricky bit, I was hoping you had found a solution
> based on what I wrote above for eio() and unmask().
> 
> > +static void vgpio_work_handler(struct work_struct *work)
> > +{
> > +       struct virtio_gpio *vgpio = container_of(work, struct virtio_gpio,
> > +                                                work);
> > +       struct device *dev = &vgpio->vdev->dev;
> > +       struct vgpio_irq_line *irq_line;
> > +       int irq, gpio, ret;
> > +       unsigned int len;
> > +
> > +       mutex_lock(&vgpio->irq_lock);
> > +
> > +       while (true) {
> > +               irq_line = virtqueue_get_buf(vgpio->event_vq, &len);
> > +               if (!irq_line)
> > +                       break;
> 
> Related to above, I think all the eventq handling should be moved into the
> virtio_gpio_event_vq() function directly.

You mean without scheduling a work ?

> > +               /* The interrupt may have been disabled by now */
> > +               if (irq_line->update_pending && irq_line->masked)
> > +                       update_irq_type(vgpio, gpio, VIRTIO_GPIO_IRQ_TYPE_NONE);
> 
> This is a part I'm not sure about, and I suppose it's the same part that
> Marc was also confused by.
> 
> As far as I can tell, the update_irq_type() message would lead to the
> interrupt getting delivered when it was armed and is now getting disabled,
> but I don't see why we would call update_irq_type() as a result of the
> eventq notification.

Lemme try to explain answer to all other question together here.

The irq related functions get called in two scenarios:

- request_irq() or irq_set_irq_type(), enable/disable_irq(), etc:

  The call sequence here is like this:

  ->irq_bus_lock()

  ->spin-lock-irqsave
  ->irq_mask()/irq_unmask()/irq_set_type()..
  ->spin-unlock-irqsave

  ->irq_bus_unlock()


  So the mask/unmask/set-type routines can't issue virtio requests and
  we need to do that from irq_bus_unlock(). This shall answer your
  question about mask/unmask, right ? Or maybe I misunderstood them
  then ?


- Interrupt: i.e. buffer sent back by the host over virtio.

  virtio_gpio_event_vq() schedules a work item, which processes the
  items from the eventq virtqueue and eventually calls
  generic_handle_irq(). The irq-core can issue calls to
  ->irq_mask/unmask() here without a prior call to
  irq_bus_lock/unlock(), normally they will balance out by the end,
  but I am not sure if it is guaranteed. Moreover, interrupt should be
  re-enabled only after unmask() is called (for ONESHOT) and not at
  EOI, right ?

  I chose not to queue the buffers back from eoi() as it is possible
  that we won't want to queue them at all, as the interrupt needs to
  be disabled by the time generic_handle_irq() returns. And so I did
  everything from the end of vgpio_work_handler()'s loop, i.e. either
  disable the interrupts with VIRTIO_GPIO_IRQ_TYPE_NONE or enable the
  interrupt again by re-queuing the buffer.

Regarding irq handling using work-item, I had to move to that to take
care of locking for re-queuing the buffers for a GPIO line from
irq-handler and bus-unlock. Nothing else seemed to work, though I am
continuing to look into that to see if there is an alternative here.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
