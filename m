Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBC1C4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:44:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED535610FD
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED535610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6EB740258;
	Fri,  6 Aug 2021 07:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9FxD0jfvlJU; Fri,  6 Aug 2021 07:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41F7C40249;
	Fri,  6 Aug 2021 07:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB85C001A;
	Fri,  6 Aug 2021 07:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D1D0C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A70B82AF8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O35Fu_X-BJ5g
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:44:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EB5982AC8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:44:46 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 dw2-20020a17090b0942b0290177cb475142so21372065pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HLoPc1uP3W6cbVHev0+XuSTJyiY+fEhdaCUYmE93+kk=;
 b=lYq4fiRmC6kteclmEVNZkBsF97AjsC+PJ746EbB3Go9ITSt+2udR5j/biuCNZslSig
 MmarzGrN1NNnBIik/E0K/VvTY7qsX0372b34O8qnHvdH6e1uXaFKuXJT/sBYzWm+eb+u
 xper1W4OpmKO6de7oMVBdZFghgF/cuODS4ofnHoVwe1rdGCMRQOvRqxPmhvqlQhJq/bg
 Mqt7GIbkSDSsRgs3bD4qOE6xqhKxGLVSe6Ke+VM0cqkQPBHCuuBzVU5wVzczj8OmD/Fx
 xZskcIVspC963xU3EhiF5yUsUI8AiR8rTbM07FX6TR5sYm/UMglvpUUKGNW8Q3T9qbQT
 hQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HLoPc1uP3W6cbVHev0+XuSTJyiY+fEhdaCUYmE93+kk=;
 b=ZmpXieX6YU+UhwndGGoFpJItdiY/xBr/Calo2HPgoMZlDAjCb52PJpbXxKEr70CXow
 rkB1eljZEDcXAM5kRpn+AIfZAny/m7OXg4h2MUrPWsZkbkPa1M5KMFtogdjKrn2ktWE4
 +hEz9TFbjjtk2i17IRLJT0Ydq/Inxz2hdD/r56pTr0qBB1f2u2gSDcm+8sWIX7k+klWg
 RxmDctGQ28/+vOGuLPQdgdLpomftD48PyLz4g9mwN1p3MghhFfzFurEShudmemNmwLGw
 eJsmllKFbZN3dONkSs/kyStKnqM+KTf//ISiI0K4Gl81EvqU/vtVLy6QcVtC/zYMlJh3
 twEA==
X-Gm-Message-State: AOAM532HlfP16/P07r5TOVjNMg8pPv+HlfW3CC+Oc0NWfyZF3sp/ntdb
 OOAjMtHvHyafT5TmFv9DoR0daQ==
X-Google-Smtp-Source: ABdhPJyrfoYXeQrSbRRrPna+3iA3J7eBpuiUp18COesHdOnPDAz3eag54rg83K3WYN0xnCE3R1HYnw==
X-Received: by 2002:a17:902:b282:b029:12c:4ce3:8852 with SMTP id
 u2-20020a170902b282b029012c4ce38852mr7566606plr.31.1628235886440; 
 Fri, 06 Aug 2021 00:44:46 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id w2sm8099623pjq.5.2021.08.06.00.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 00:44:45 -0700 (PDT)
Date: Fri, 6 Aug 2021 13:14:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [Stratos-dev] [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210806074444.zsxwb2pmgjcq2dl2@vireshk-i7>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
 <75c8e6e5e8dfa1889938f3a6b2d991763c7a3717.1627989586.git.viresh.kumar@linaro.org>
 <CAK8P3a29NfFWwtGHhqos1P8f_SmzPJTXvEY5BZJAEMbV2SKe-Q@mail.gmail.com>
 <0100017b1610f711-c53c79f2-9e28-4c45-bb42-8db09688b18e-000000@email.amazonses.com>
 <CAK8P3a0DWkfQcZpmyfKcdNt1MHf8ha6a9L2LmLt1Tv-j0HDr3w@mail.gmail.com>
 <20210805124922.j7lts7tfmm4t2kpf@vireshk-i7>
 <CAK8P3a0kbmPLGCBrjAv7-dW=JWq-pdSBeGUHCxUFmMKvKhCg7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0kbmPLGCBrjAv7-dW=JWq-pdSBeGUHCxUFmMKvKhCg7w@mail.gmail.com>
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

On 05-08-21, 15:10, Arnd Bergmann wrote:
> I hope this can still be simplified by working out better which state
> transitions are needed exactly. In particular, I would expect that we
> can get away with not sending a VIRTIO_GPIO_MSG_IRQ_TYPE
> for 'mask' state changes at all, but use that only for forcing 'enabled'
> state changes.

Something like this ?

struct vgpio_irq_line {
	u8 type;
	bool masked;
	bool update_pending;
	bool queued;

	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
	struct virtio_gpio_irq_response ires ____cacheline_aligned;
};

static void virtio_gpio_irq_disable(struct irq_data *d)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];

	irq_line->masked = true;
	irq_line->update_pending = true;
}

static void virtio_gpio_irq_enable(struct irq_data *d)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];

	irq_line->masked = false;
	irq_line->update_pending = true;

	/* Queue the buffer unconditionally on enable */
	virtio_gpio_irq_prepare(vgpio, d->hwirq);
}

static void virtio_gpio_irq_mask(struct irq_data *d)
{
	/* Nothing to do here */
}

static void virtio_gpio_irq_unmask(struct irq_data *d)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);

	/* Queue the buffer unconditionally on unmask */
	virtio_gpio_irq_prepare(vgpio, d->hwirq);
}

static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int type)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];

	switch (type) {
	case IRQ_TYPE_NONE:
		type = VIRTIO_GPIO_IRQ_TYPE_NONE;
		break;
	case IRQ_TYPE_EDGE_RISING:
		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING;
		break;
	case IRQ_TYPE_EDGE_FALLING:
		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING;
		break;
	case IRQ_TYPE_EDGE_BOTH:
		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH;
		break;
	case IRQ_TYPE_LEVEL_LOW:
		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW;
		break;
	case IRQ_TYPE_LEVEL_HIGH:
		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH;
		break;
	default:
		dev_err(&vgpio->vdev->dev, "unsupported irq type: %u\n", type);
		return -EINVAL;
	}

	irq_line->type = type;
	irq_line->update_pending = true;

	return 0;
}

static void update_irq_type(struct virtio_gpio *vgpio, u16 gpio, u8 type)
{
	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_IRQ_TYPE, gpio, type, NULL);
}

static void virtio_gpio_irq_bus_lock(struct irq_data *d)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);

	mutex_lock(&vgpio->irq_lock);
}

static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
{
	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
	u8 type = irq_line->masked ? VIRTIO_GPIO_IRQ_TYPE_NONE : irq_line->type;

	if (irq_line->update_pending) {
		irq_line->update_pending = false;
		update_irq_type(vgpio, d->hwirq, type);
	}

	mutex_unlock(&vgpio->irq_lock);
}

static struct irq_chip vgpio_irq_chip = {
	.name			= "virtio-gpio",
	.irq_enable		= virtio_gpio_irq_enable,
	.irq_disable		= virtio_gpio_irq_disable,
	.irq_mask		= virtio_gpio_irq_mask,
	.irq_unmask		= virtio_gpio_irq_unmask,
	.irq_set_type		= virtio_gpio_irq_set_type,

	/* These are required to implement irqchip for slow busses */
	.irq_bus_lock		= virtio_gpio_irq_bus_lock,
	.irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock,
};

> One part that I think is missing though is remembering the case
> when an eventq message came in after an interrupt got masked
> when the message was already armed. In this case, the
> virtio_gpio_event_vq() function would not call the irq handler,
> but the subsequent "unmask" callback would need to arrange
> having it called.

I will come back to this.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
