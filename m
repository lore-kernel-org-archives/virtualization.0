Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC4C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:11:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4156F610D0
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4156F610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9DE64020E;
	Fri, 22 Oct 2021 10:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itbvS-gNZAc2; Fri, 22 Oct 2021 10:11:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9466E40172;
	Fri, 22 Oct 2021 10:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 420DEC0020;
	Fri, 22 Oct 2021 10:11:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC7D2C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 979834053F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NemhDjChhpoI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:11:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94EC140534
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634897488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CT9AhMVst8Rb0tJG5wx2cbFsfJSfVLJq2inhwjhnf3I=;
 b=fbvwsN0Vxi3fIcVKgJN2HqemE7zJ4keH2U2vthxyxO+MOgQ9JM2tcXHMhDEOpXPHnLsCRL
 v8pCTYtJHSGjvzhKs4mhce+LELBrhJtaiyrUuApbKAfcOGUQNkZbbqStFkawAxbGV+xQ0n
 /lppoqJiF2EmCI/GklaAbpY5ZR/hH88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-rdZGvzv6Pl2oeHocs5oZ9g-1; Fri, 22 Oct 2021 06:11:27 -0400
X-MC-Unique: rdZGvzv6Pl2oeHocs5oZ9g-1
Received: by mail-wm1-f69.google.com with SMTP id
 o22-20020a1c7516000000b0030d6f9c7f5fso819696wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 03:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CT9AhMVst8Rb0tJG5wx2cbFsfJSfVLJq2inhwjhnf3I=;
 b=nXuUhkorzj3M6FGy6AY6Auu2/YQTMDCcnN3bzWV0fUcuLi19zBIXdY8v+l7etUdFL8
 MlRIR+tjUEJLyA3Oono+7F8ICQ5bZqYo1hT9m8//GHOEFBcjrcNdBjFBTNhQJWD8xPi0
 YkGKdi2zz9X6t/4NeONfeAMrNdfTA7kchY2eUqKgWRTeu6/Ex0Xr1DEzKlm2vlip5NUy
 qqv8fQkrAlOosZYGYsdffXBEY6widlu7UYEF1XGSHF6IFWsnG0EoFpQaqfDdmotUrKPM
 VhWX8xGBZwqgiEIvd88qwl4wnGCpRFlbGkpPLOYmFGLeFpYznF52MMIqQgXESCodOJuN
 zuCg==
X-Gm-Message-State: AOAM532SZKc+RRU0aD0csKxHYYz1rfuXgizi2BVAh4I7dypHsBkbpCqf
 BlEfyNfBHRH5hfW106gwr5mbtWhS95EdqdOzZzWittRqDDblPhBV92pUDvvelK35xAcTUw/O/oN
 ZD0HRDJzbxSX97apuEwkeGDDQYxCJSHnsf0PLbXRZgA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr14229631wrd.435.1634897486371; 
 Fri, 22 Oct 2021 03:11:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywC3K8m71GWCYmISDFdW9jxEo8hX1P48wGi2RgQXx4MCi5Aozd0ACDSuNDcf6IbJDuA97IpQ==
X-Received: by 2002:adf:b348:: with SMTP id k8mr14229579wrd.435.1634897486096; 
 Fri, 22 Oct 2021 03:11:26 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id a127sm10537961wme.40.2021.10.22.03.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 03:11:25 -0700 (PDT)
Date: Fri, 22 Oct 2021 06:11:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7] gpio: virtio: Add IRQ support
Message-ID: <20211022060746-mutt-send-email-mst@kernel.org>
References: <ae639da42050ee0ffd9ba1fffc2c86a38d66cec4.1634813977.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <ae639da42050ee0ffd9ba1fffc2c86a38d66cec4.1634813977.git.viresh.kumar@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-gpio@vger.kernel.org,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Bill Mills <bill.mills@linaro.org>
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

On Thu, Oct 21, 2021 at 04:34:19PM +0530, Viresh Kumar wrote:
> This patch adds IRQ support for the virtio GPIO driver. Note that this
> uses the irq_bus_lock/unlock() callbacks, since those operations over
> virtio may sleep.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I think this can be merged - while ballot did not close yet
you already have a majority vote Yes. Worst case we'll revert
but I don't expect that.


> ---
> Bartosz,
> 
> The spec changes are close to merging now, I will let you know once the ballot
> is closed and the spec changes are merged. You can then pick this patch for
> 5.16.
> 
> V6->V7:
> - Use generic_handle_domain_irq.
> - Drop check for IRQ_TYPE_NONE, dead code.
> - Avoid breaking line to fit into 80 columns.
> 
> V5->V6:
> - Sent it separately as the other patches are already merged.
> - Queue the buffers only after enabling the irq (as per latest spec).
> - Migrate to raw_spinlock_t.
> 
>  drivers/gpio/Kconfig             |   1 +
>  drivers/gpio/gpio-virtio.c       | 302 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_gpio.h |  25 +++
>  3 files changed, 324 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index fae5141251e5..bfa723ff8e7c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1674,6 +1674,7 @@ config GPIO_MOCKUP
>  config GPIO_VIRTIO
>  	tristate "VirtIO GPIO support"
>  	depends on VIRTIO
> +	select GPIOLIB_IRQCHIP
>  	help
>  	  Say Y here to enable guest support for virtio-based GPIO controllers.
>  
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index d24f1c9264bc..aeec4bf0b625 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/spinlock.h>
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_gpio.h>
>  #include <uapi/linux/virtio_ids.h>
> @@ -28,12 +29,30 @@ struct virtio_gpio_line {
>  	unsigned int rxlen;
>  };
>  
> +struct vgpio_irq_line {
> +	u8 type;
> +	bool disabled;
> +	bool masked;
> +	bool queued;
> +	bool update_pending;
> +	bool queue_pending;
> +
> +	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
> +	struct virtio_gpio_irq_response ires ____cacheline_aligned;
> +};
> +
>  struct virtio_gpio {
>  	struct virtio_device *vdev;
>  	struct mutex lock; /* Protects virtqueue operation */
>  	struct gpio_chip gc;
>  	struct virtio_gpio_line *lines;
>  	struct virtqueue *request_vq;
> +
> +	/* irq support */
> +	struct virtqueue *event_vq;
> +	struct mutex irq_lock; /* Protects irq operation */
> +	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
> +	struct vgpio_irq_line *irq_lines;
>  };
>  
>  static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
> @@ -186,6 +205,238 @@ static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value, NULL);
>  }
>  
> +/* Interrupt handling */
> +static void virtio_gpio_irq_prepare(struct virtio_gpio *vgpio, u16 gpio)
> +{
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[gpio];
> +	struct virtio_gpio_irq_request *ireq = &irq_line->ireq;
> +	struct virtio_gpio_irq_response *ires = &irq_line->ires;
> +	struct scatterlist *sgs[2], req_sg, res_sg;
> +	int ret;
> +
> +	if (WARN_ON(irq_line->queued || irq_line->masked || irq_line->disabled))
> +		return;
> +
> +	ireq->gpio = cpu_to_le16(gpio);
> +	sg_init_one(&req_sg, ireq, sizeof(*ireq));
> +	sg_init_one(&res_sg, ires, sizeof(*ires));
> +	sgs[0] = &req_sg;
> +	sgs[1] = &res_sg;
> +
> +	ret = virtqueue_add_sgs(vgpio->event_vq, sgs, 1, 1, irq_line, GFP_ATOMIC);
> +	if (ret) {
> +		dev_err(&vgpio->vdev->dev, "failed to add request to eventq\n");
> +		return;
> +	}
> +
> +	irq_line->queued = true;
> +	virtqueue_kick(vgpio->event_vq);
> +}
> +
> +static void virtio_gpio_irq_enable(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +
> +	raw_spin_lock(&vgpio->eventq_lock);
> +	irq_line->disabled = false;
> +	irq_line->masked = false;
> +	irq_line->queue_pending = true;
> +	raw_spin_unlock(&vgpio->eventq_lock);
> +
> +	irq_line->update_pending = true;
> +}
> +
> +static void virtio_gpio_irq_disable(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +
> +	raw_spin_lock(&vgpio->eventq_lock);
> +	irq_line->disabled = true;
> +	irq_line->masked = true;
> +	irq_line->queue_pending = false;
> +	raw_spin_unlock(&vgpio->eventq_lock);
> +
> +	irq_line->update_pending = true;
> +}
> +
> +static void virtio_gpio_irq_mask(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +
> +	raw_spin_lock(&vgpio->eventq_lock);
> +	irq_line->masked = true;
> +	raw_spin_unlock(&vgpio->eventq_lock);
> +}
> +
> +static void virtio_gpio_irq_unmask(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +
> +	raw_spin_lock(&vgpio->eventq_lock);
> +	irq_line->masked = false;
> +
> +	/* Queue the buffer unconditionally on unmask */
> +	virtio_gpio_irq_prepare(vgpio, d->hwirq);
> +	raw_spin_unlock(&vgpio->eventq_lock);
> +}
> +
> +static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH;
> +		break;
> +	default:
> +		dev_err(&vgpio->vdev->dev, "unsupported irq type: %u\n", type);
> +		return -EINVAL;
> +	}
> +
> +	irq_line->type = type;
> +	irq_line->update_pending = true;
> +
> +	return 0;
> +}
> +
> +static void virtio_gpio_irq_bus_lock(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +
> +	mutex_lock(&vgpio->irq_lock);
> +}
> +
> +static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
> +	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
> +	u8 type = irq_line->disabled ? VIRTIO_GPIO_IRQ_TYPE_NONE : irq_line->type;
> +	unsigned long flags;
> +
> +	if (irq_line->update_pending) {
> +		irq_line->update_pending = false;
> +		virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_IRQ_TYPE, d->hwirq, type,
> +				NULL);
> +
> +		/* Queue the buffer only after interrupt is enabled */
> +		raw_spin_lock_irqsave(&vgpio->eventq_lock, flags);
> +		if (irq_line->queue_pending) {
> +			irq_line->queue_pending = false;
> +			virtio_gpio_irq_prepare(vgpio, d->hwirq);
> +		}
> +		raw_spin_unlock_irqrestore(&vgpio->eventq_lock, flags);
> +	}
> +
> +	mutex_unlock(&vgpio->irq_lock);
> +}
> +
> +static struct irq_chip vgpio_irq_chip = {
> +	.name			= "virtio-gpio",
> +	.irq_enable		= virtio_gpio_irq_enable,
> +	.irq_disable		= virtio_gpio_irq_disable,
> +	.irq_mask		= virtio_gpio_irq_mask,
> +	.irq_unmask		= virtio_gpio_irq_unmask,
> +	.irq_set_type		= virtio_gpio_irq_set_type,
> +
> +	/* These are required to implement irqchip for slow busses */
> +	.irq_bus_lock		= virtio_gpio_irq_bus_lock,
> +	.irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock,
> +};
> +
> +static bool ignore_irq(struct virtio_gpio *vgpio, int gpio,
> +		       struct vgpio_irq_line *irq_line)
> +{
> +	bool ignore = false;
> +
> +	raw_spin_lock(&vgpio->eventq_lock);
> +	irq_line->queued = false;
> +
> +	/* Interrupt is disabled currently */
> +	if (irq_line->masked || irq_line->disabled) {
> +		ignore = true;
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * Buffer is returned as the interrupt was disabled earlier, but is
> +	 * enabled again now. Requeue the buffers.
> +	 */
> +	if (irq_line->ires.status == VIRTIO_GPIO_IRQ_STATUS_INVALID) {
> +		virtio_gpio_irq_prepare(vgpio, gpio);
> +		ignore = true;
> +		goto unlock;
> +	}
> +
> +	if (WARN_ON(irq_line->ires.status != VIRTIO_GPIO_IRQ_STATUS_VALID))
> +		ignore = true;
> +
> +unlock:
> +	raw_spin_unlock(&vgpio->eventq_lock);
> +
> +	return ignore;
> +}
> +
> +static void virtio_gpio_event_vq(struct virtqueue *vq)
> +{
> +	struct virtio_gpio *vgpio = vq->vdev->priv;
> +	struct device *dev = &vgpio->vdev->dev;
> +	struct vgpio_irq_line *irq_line;
> +	int gpio, ret;
> +	unsigned int len;
> +
> +	while (true) {
> +		irq_line = virtqueue_get_buf(vgpio->event_vq, &len);
> +		if (!irq_line)
> +			break;
> +
> +		if (len != sizeof(irq_line->ires)) {
> +			dev_err(dev, "irq with incorrect length (%u : %u)\n",
> +				len, (unsigned int)sizeof(irq_line->ires));
> +			continue;
> +		}
> +
> +		/*
> +		 * Find GPIO line number from the offset of irq_line within the
> +		 * irq_lines block. We can also get GPIO number from
> +		 * irq-request, but better not to rely on a buffer returned by
> +		 * remote.
> +		 */
> +		gpio = irq_line - vgpio->irq_lines;
> +		WARN_ON(gpio >= vgpio->gc.ngpio);
> +
> +		if (unlikely(ignore_irq(vgpio, gpio, irq_line)))
> +			continue;
> +
> +		ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
> +		if (ret)
> +			dev_err(dev, "failed to handle interrupt: %d\n", ret);
> +	};
> +}
> +
>  static void virtio_gpio_request_vq(struct virtqueue *vq)
>  {
>  	struct virtio_gpio_line *line;
> @@ -210,14 +461,15 @@ static void virtio_gpio_free_vqs(struct virtio_device *vdev)
>  static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
>  				 struct virtio_device *vdev)
>  {
> -	const char * const names[] = { "requestq" };
> +	const char * const names[] = { "requestq", "eventq" };
>  	vq_callback_t *cbs[] = {
>  		virtio_gpio_request_vq,
> +		virtio_gpio_event_vq,
>  	};
> -	struct virtqueue *vqs[1] = { NULL };
> +	struct virtqueue *vqs[2] = { NULL, NULL };
>  	int ret;
>  
> -	ret = virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
> +	ret = virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs, cbs, names, NULL);
>  	if (ret) {
>  		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
>  		return ret;
> @@ -225,11 +477,23 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
>  
>  	if (!vqs[0]) {
>  		dev_err(&vdev->dev, "failed to find requestq vq\n");
> -		return -ENODEV;
> +		goto out;
>  	}
>  	vgpio->request_vq = vqs[0];
>  
> +	if (vgpio->irq_lines && !vqs[1]) {
> +		dev_err(&vdev->dev, "failed to find eventq vq\n");
> +		goto out;
> +	}
> +	vgpio->event_vq = vqs[1];
> +
>  	return 0;
> +
> +out:
> +	if (vqs[0] || vqs[1])
> +		virtio_gpio_free_vqs(vdev);
> +
> +	return -ENODEV;
>  }
>  
>  static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
> @@ -325,6 +589,30 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  	vgpio->gc.owner			= THIS_MODULE;
>  	vgpio->gc.can_sleep		= true;
>  
> +	/* Interrupt support */
> +	if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)) {
> +		vgpio->irq_lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->irq_lines), GFP_KERNEL);
> +		if (!vgpio->irq_lines)
> +			return -ENOMEM;
> +
> +		/* The event comes from the outside so no parent handler */
> +		vgpio->gc.irq.parent_handler	= NULL;
> +		vgpio->gc.irq.num_parents	= 0;
> +		vgpio->gc.irq.parents		= NULL;
> +		vgpio->gc.irq.default_type	= IRQ_TYPE_NONE;
> +		vgpio->gc.irq.handler		= handle_level_irq;
> +		vgpio->gc.irq.chip		= &vgpio_irq_chip;
> +
> +		for (i = 0; i < ngpio; i++) {
> +			vgpio->irq_lines[i].type = VIRTIO_GPIO_IRQ_TYPE_NONE;
> +			vgpio->irq_lines[i].disabled = true;
> +			vgpio->irq_lines[i].masked = true;
> +		}
> +
> +		mutex_init(&vgpio->irq_lock);
> +		raw_spin_lock_init(&vgpio->eventq_lock);
> +	}
> +
>  	ret = virtio_gpio_alloc_vqs(vgpio, vdev);
>  	if (ret)
>  		return ret;
> @@ -357,7 +645,13 @@ static const struct virtio_device_id id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);
>  
> +static const unsigned int features[] = {
> +	VIRTIO_GPIO_F_IRQ,
> +};
> +
>  static struct virtio_driver virtio_gpio_driver = {
> +	.feature_table		= features,
> +	.feature_table_size	= ARRAY_SIZE(features),
>  	.id_table		= id_table,
>  	.probe			= virtio_gpio_probe,
>  	.remove			= virtio_gpio_remove,
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
> index 0445f905d8cc..d04af9c5f0de 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -5,12 +5,16 @@
>  
>  #include <linux/types.h>
>  
> +/* Virtio GPIO Feature bits */
> +#define VIRTIO_GPIO_F_IRQ			0
> +
>  /* Virtio GPIO request types */
>  #define VIRTIO_GPIO_MSG_GET_NAMES		0x0001
>  #define VIRTIO_GPIO_MSG_GET_DIRECTION		0x0002
>  #define VIRTIO_GPIO_MSG_SET_DIRECTION		0x0003
>  #define VIRTIO_GPIO_MSG_GET_VALUE		0x0004
>  #define VIRTIO_GPIO_MSG_SET_VALUE		0x0005
> +#define VIRTIO_GPIO_MSG_IRQ_TYPE		0x0006
>  
>  /* Possible values of the status field */
>  #define VIRTIO_GPIO_STATUS_OK			0x0
> @@ -21,6 +25,14 @@
>  #define VIRTIO_GPIO_DIRECTION_OUT		0x01
>  #define VIRTIO_GPIO_DIRECTION_IN		0x02
>  
> +/* Virtio GPIO IRQ types */
> +#define VIRTIO_GPIO_IRQ_TYPE_NONE		0x00
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING	0x01
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING	0x02
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH		0x03
> +#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH		0x04
> +#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW		0x08
> +
>  struct virtio_gpio_config {
>  	__le16 ngpio;
>  	__u8 padding[2];
> @@ -44,4 +56,17 @@ struct virtio_gpio_response_get_names {
>  	__u8 value[];
>  };
>  
> +/* Virtio GPIO IRQ Request / Response */
> +struct virtio_gpio_irq_request {
> +	__le16 gpio;
> +};
> +
> +struct virtio_gpio_irq_response {
> +	__u8 status;
> +};
> +
> +/* Possible values of the interrupt status field */
> +#define VIRTIO_GPIO_IRQ_STATUS_INVALID		0x0
> +#define VIRTIO_GPIO_IRQ_STATUS_VALID		0x1
> +
>  #endif /* _LINUX_VIRTIO_GPIO_H */
> -- 
> 2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
