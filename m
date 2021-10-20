Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34676C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 15:12:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB47461354
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 15:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB47461354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E5AB406BC;
	Wed, 20 Oct 2021 15:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0G4ArfdowbmX; Wed, 20 Oct 2021 15:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20FDD40690;
	Wed, 20 Oct 2021 15:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E171EC0011;
	Wed, 20 Oct 2021 15:12:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B611C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 15:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 197F483B3E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 15:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fe-E466k3kr1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 15:12:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D43E883AA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 15:12:06 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id g10so26797820edj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=GRYdlBVFtM5Xt/oUrA4qYUw3A7oqV5DIs+GCfdwMc6U=;
 b=o2BpXdu1T3buSAIR6PxFyZ7twITTuVzlZ7vNTQBJria4JsKVbPA3/qZU5WV0lzpA26
 4rdDMFlhAaeR+D+vNKNi5X3by5i64xElgFReA+DJh1/YJp63CeF2B0+MiypE3V/SFWmX
 /s6Wx7u8IIZGGEZurj2FQq7JdlZiG9m4DzIGYpq9nZzOw2UhnwhpnXsMj5lARm4H1Cg2
 /ol6A/T8mE1Lcjvs5yqd7Bagrr/Ni1jk/396A7g+Li4YCCjRfV1Rl6HQGlzGfuUE8caC
 az4EMnQjqhYCoDTMhndIXLJWUdh/nPhH66UyOZ1S7NG7BRCx2HhiiU56U9WYxAzC8lg/
 CqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=GRYdlBVFtM5Xt/oUrA4qYUw3A7oqV5DIs+GCfdwMc6U=;
 b=BhKqaLAS6+9t5Kv4DS6gED0XUzffZ+h3TRaFIkF6ZCNTkB1tOiRzcOyycchs2oCTnq
 RkHKKs3Z9Gbqz0Tpv1t97DUhj9yiHJ4MfMS0viFXf5yttdzMBg8xmd5htc7i6utB77MA
 xHfYcWqbUKbMl3oExDLyCuWnV6UfN1u5jk7pSn355LIgS0epRnDxJWoGeDZ9h8heTWJl
 DO6uiiDCaWxTJZ0y1hNiatiZmv1So2AWdP1aCZLVIV65jzVW9MbENU1AEwiToxaNVQoD
 kNQSeRxCR8c+k0shnGJphTQnqVSH+fwDDTDr5y/gee2PJUEvlAsp7W0AXGXMPGcwH9JB
 Vd3A==
X-Gm-Message-State: AOAM530od1K8XNh6Jt5mRTDsejY+HC0GCF7G0nhrbhIMMhxPsOYY8uwO
 a2B9MltNrOk5xQ/YraoPE8MJ45OUrbZ5KxSX230=
X-Google-Smtp-Source: ABdhPJzP+xQSZQMaytHCN015WBttiUYyRUIWpcFbQJ6+uyT1YeHNxGexUQt5pvPDt696K6/As+HAj9YoULSh3o1L7D0=
X-Received: by 2002:a05:6402:10da:: with SMTP id
 p26mr635455edu.283.1634742617820; 
 Wed, 20 Oct 2021 08:10:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:f758:0:0:0:0 with HTTP; Wed, 20 Oct 2021 08:10:17
 -0700 (PDT)
In-Reply-To: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Oct 2021 18:10:17 +0300
Message-ID: <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bill Mills <bill.mills@linaro.org>
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
Content-Type: multipart/mixed; boundary="===============0646500109190607552=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0646500109190607552==
Content-Type: multipart/alternative; boundary="00000000000008d0bc05ceca2d3e"

--00000000000008d0bc05ceca2d3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 20, 2021, Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This patch adds IRQ support for the virtio GPIO driver. Note that this
> uses the irq_bus_lock/unlock() callbacks, since those operations over
> virtio may sleep.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Bartosz,
>
> The spec changes are close to merging now, I will let you know once the
> ballot
> is closed and the spec changes are merged. You can then pick this patch f=
or
> 5.16.
>
> V5->V6:
> - Sent it separately as the other patches are already merged.
> - Queue the buffers only after enabling the irq (as per latest spec).
> - Migrate to raw_spinlock_t.
>
>  drivers/gpio/Kconfig             |   1 +
>  drivers/gpio/gpio-virtio.c       | 310 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_gpio.h |  25 +++
>  3 files changed, 332 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index fae5141251e5..bfa723ff8e7c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1674,6 +1674,7 @@ config GPIO_MOCKUP
>  config GPIO_VIRTIO
>         tristate "VirtIO GPIO support"
>         depends on VIRTIO
> +       select GPIOLIB_IRQCHIP
>         help
>           Say Y here to enable guest support for virtio-based GPIO
> controllers.
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index d24f1c9264bc..73fbe2eda4b9 100644
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
>         unsigned int rxlen;
>  };
>
> +struct vgpio_irq_line {
> +       u8 type;
> +       bool disabled;
> +       bool masked;
> +       bool queued;
> +       bool update_pending;
> +       bool queue_pending;
> +
> +       struct virtio_gpio_irq_request ireq ____cacheline_aligned;
> +       struct virtio_gpio_irq_response ires ____cacheline_aligned;
> +};
> +
>  struct virtio_gpio {
>         struct virtio_device *vdev;
>         struct mutex lock; /* Protects virtqueue operation */
>         struct gpio_chip gc;
>         struct virtio_gpio_line *lines;
>         struct virtqueue *request_vq;
> +
> +       /* irq support */
> +       struct virtqueue *event_vq;
> +       struct mutex irq_lock; /* Protects irq operation */
> +       raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
> +       struct vgpio_irq_line *irq_lines;
>  };
>
>  static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpi=
o,
> @@ -186,6 +205,244 @@ static void virtio_gpio_set(struct gpio_chip *gc,
> unsigned int gpio, int value)
>         virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value,
> NULL);
>  }
>
> +/* Interrupt handling */
> +static void virtio_gpio_irq_prepare(struct virtio_gpio *vgpio, u16 gpio)
> +{
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[gpio];
> +       struct virtio_gpio_irq_request *ireq =3D &irq_line->ireq;
> +       struct virtio_gpio_irq_response *ires =3D &irq_line->ires;
> +       struct scatterlist *sgs[2], req_sg, res_sg;
> +       int ret;
> +
> +       if (WARN_ON(irq_line->queued || irq_line->masked ||
> irq_line->disabled))
> +               return;
> +
> +       ireq->gpio =3D cpu_to_le16(gpio);
> +       sg_init_one(&req_sg, ireq, sizeof(*ireq));
> +       sg_init_one(&res_sg, ires, sizeof(*ires));
> +       sgs[0] =3D &req_sg;
> +       sgs[1] =3D &res_sg;
> +
> +       ret =3D virtqueue_add_sgs(vgpio->event_vq, sgs, 1, 1, irq_line,
> GFP_ATOMIC);
> +       if (ret) {
> +               dev_err(&vgpio->vdev->dev, "failed to add request to
> eventq\n");
> +               return;
> +       }
> +
> +       irq_line->queued =3D true;
> +       virtqueue_kick(vgpio->event_vq);
> +}
> +
> +static void virtio_gpio_irq_enable(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +
> +       raw_spin_lock(&vgpio->eventq_lock);
> +       irq_line->disabled =3D false;
> +       irq_line->masked =3D false;
> +       irq_line->queue_pending =3D true;
> +       raw_spin_unlock(&vgpio->eventq_lock);
> +
> +       irq_line->update_pending =3D true;
> +}
> +
> +static void virtio_gpio_irq_disable(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +
> +       raw_spin_lock(&vgpio->eventq_lock);
> +       irq_line->disabled =3D true;
> +       irq_line->masked =3D true;
> +       irq_line->queue_pending =3D false;
> +       raw_spin_unlock(&vgpio->eventq_lock);
> +
> +       irq_line->update_pending =3D true;
> +}
> +
> +static void virtio_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +
> +       raw_spin_lock(&vgpio->eventq_lock);
> +       irq_line->masked =3D true;
> +       raw_spin_unlock(&vgpio->eventq_lock);
> +}
> +
> +static void virtio_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +
> +       raw_spin_lock(&vgpio->eventq_lock);
> +       irq_line->masked =3D false;
> +
> +       /* Queue the buffer unconditionally on unmask */
> +       virtio_gpio_irq_prepare(vgpio, d->hwirq);
> +       raw_spin_unlock(&vgpio->eventq_lock);
> +}
> +
> +static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int
> type)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +
> +       switch (type) {
> +       case IRQ_TYPE_NONE:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_NONE;
> +               break;


IIRC you add dead code. IRQ framework never calls this if type is not set.


> +       case IRQ_TYPE_EDGE_RISING:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING;
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING;
> +               break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH;
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW;
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               type =3D VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH;
> +               break;
> +       default:
> +               dev_err(&vgpio->vdev->dev, "unsupported irq type: %u\n",
> type);
> +               return -EINVAL;
> +       }
> +
> +       irq_line->type =3D type;
> +       irq_line->update_pending =3D true;
> +
> +       return 0;
> +}
> +
> +static void virtio_gpio_irq_bus_lock(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +
> +       mutex_lock(&vgpio->irq_lock);
> +}
> +
> +static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
> +{
> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +       struct virtio_gpio *vgpio =3D gpiochip_get_data(gc);
> +       struct vgpio_irq_line *irq_line =3D &vgpio->irq_lines[d->hwirq];
> +       u8 type =3D irq_line->disabled ? VIRTIO_GPIO_IRQ_TYPE_NONE :
> irq_line->type;
> +       unsigned long flags;
> +
> +       if (irq_line->update_pending) {
> +               irq_line->update_pending =3D false;
> +               virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_IRQ_TYPE, d->hwirq=
,
> type,
> +                               NULL);
> +
> +               /* Queue the buffer only after interrupt is enabled */
> +               raw_spin_lock_irqsave(&vgpio->eventq_lock, flags);
> +               if (irq_line->queue_pending) {
> +                       irq_line->queue_pending =3D false;
> +                       virtio_gpio_irq_prepare(vgpio, d->hwirq);
> +               }
> +               raw_spin_unlock_irqrestore(&vgpio->eventq_lock, flags);
> +       }
> +
> +       mutex_unlock(&vgpio->irq_lock);
> +}
> +
> +static struct irq_chip vgpio_irq_chip =3D {
> +       .name                   =3D "virtio-gpio",
> +       .irq_enable             =3D virtio_gpio_irq_enable,
> +       .irq_disable            =3D virtio_gpio_irq_disable,
> +       .irq_mask               =3D virtio_gpio_irq_mask,
> +       .irq_unmask             =3D virtio_gpio_irq_unmask,
> +       .irq_set_type           =3D virtio_gpio_irq_set_type,
> +
> +       /* These are required to implement irqchip for slow busses */
> +       .irq_bus_lock           =3D virtio_gpio_irq_bus_lock,
> +       .irq_bus_sync_unlock    =3D virtio_gpio_irq_bus_sync_unlock,
> +};
> +
> +static bool ignore_irq(struct virtio_gpio *vgpio, int gpio,
> +                      struct vgpio_irq_line *irq_line)
> +{
> +       bool ignore =3D false;
> +
> +       raw_spin_lock(&vgpio->eventq_lock);
> +       irq_line->queued =3D false;
> +
> +       /* Interrupt is disabled currently */
> +       if (irq_line->masked || irq_line->disabled) {
> +               ignore =3D true;
> +               goto unlock;
> +       }
> +
> +       /*
> +        * Buffer is returned as the interrupt was disabled earlier, but =
is
> +        * enabled again now. Requeue the buffers.
> +        */
> +       if (irq_line->ires.status =3D=3D VIRTIO_GPIO_IRQ_STATUS_INVALID) =
{
> +               virtio_gpio_irq_prepare(vgpio, gpio);
> +               ignore =3D true;
> +               goto unlock;
> +       }
> +
> +       if (WARN_ON(irq_line->ires.status !=3D VIRTIO_GPIO_IRQ_STATUS_VAL=
ID))
> +               ignore =3D true;
> +
> +unlock:
> +       raw_spin_unlock(&vgpio->eventq_lock);
> +
> +       return ignore;
> +}
> +
> +static void virtio_gpio_event_vq(struct virtqueue *vq)
> +{
> +       struct virtio_gpio *vgpio =3D vq->vdev->priv;
> +       struct device *dev =3D &vgpio->vdev->dev;
> +       struct vgpio_irq_line *irq_line;
> +       int irq, gpio, ret;
> +       unsigned int len;
> +
> +       while (true) {
> +               irq_line =3D virtqueue_get_buf(vgpio->event_vq, &len);
> +               if (!irq_line)
> +                       break;
> +
> +               if (len !=3D sizeof(irq_line->ires)) {
> +                       dev_err(dev, "irq with incorrect length (%u :
> %u)\n",
> +                               len, (unsigned int)sizeof(irq_line->ires)=
);
> +                       continue;
> +               }
> +
> +               /*
> +                * Find GPIO line number from the offset of irq_line
> within the
> +                * irq_lines block. We can also get GPIO number from
> +                * irq-request, but better not to rely on a buffer
> returned by
> +                * remote.
> +                */
> +               gpio =3D irq_line - vgpio->irq_lines;
> +               WARN_ON(gpio >=3D vgpio->gc.ngpio);
> +
> +               if (unlikely(ignore_irq(vgpio, gpio, irq_line)))
> +                       continue;
> +
> +               irq =3D irq_find_mapping(vgpio->gc.irq.domain, gpio);
> +               WARN_ON(!irq);
> +
> +               ret =3D generic_handle_irq(irq);


IIRC there is a new API that basically combines the two above.



> +               if (ret)
> +                       dev_err(dev, "failed to handle interrupt: %d\n",
> ret);
> +       };
> +}
> +
>  static void virtio_gpio_request_vq(struct virtqueue *vq)
>  {
>         struct virtio_gpio_line *line;
> @@ -210,14 +467,15 @@ static void virtio_gpio_free_vqs(struct
> virtio_device *vdev)
>  static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
>                                  struct virtio_device *vdev)
>  {
> -       const char * const names[] =3D { "requestq" };
> +       const char * const names[] =3D { "requestq", "eventq" };
>         vq_callback_t *cbs[] =3D {
>                 virtio_gpio_request_vq,
> +               virtio_gpio_event_vq,
>         };
> -       struct virtqueue *vqs[1] =3D { NULL };
> +       struct virtqueue *vqs[2] =3D { NULL, NULL };
>         int ret;
>
> -       ret =3D virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
> +       ret =3D virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs, cbs,
> names, NULL);
>         if (ret) {
>                 dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
>                 return ret;
> @@ -225,11 +483,23 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio
> *vgpio,
>
>         if (!vqs[0]) {
>                 dev_err(&vdev->dev, "failed to find requestq vq\n");
> -               return -ENODEV;
> +               goto out;
>         }
>         vgpio->request_vq =3D vqs[0];
>
> +       if (vgpio->irq_lines && !vqs[1]) {
> +               dev_err(&vdev->dev, "failed to find eventq vq\n");
> +               goto out;
> +       }
> +       vgpio->event_vq =3D vqs[1];
> +
>         return 0;
> +
> +out:
> +       if (vqs[0] || vqs[1])
> +               virtio_gpio_free_vqs(vdev);
> +
> +       return -ENODEV;
>  }
>
>  static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
> @@ -325,6 +595,32 @@ static int virtio_gpio_probe(struct virtio_device
> *vdev)
>         vgpio->gc.owner                 =3D THIS_MODULE;
>         vgpio->gc.can_sleep             =3D true;
>
> +       /* Interrupt support */
> +       if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)) {
> +               vgpio->irq_lines =3D devm_kcalloc(dev, ngpio,
> +                                               sizeof(*vgpio->irq_lines)=
,
> +                                               GFP_KERNEL);


One line?


> +               if (!vgpio->irq_lines)
> +                       return -ENOMEM;
> +
> +               /* The event comes from the outside so no parent handler =
*/
> +               vgpio->gc.irq.parent_handler    =3D NULL;
> +               vgpio->gc.irq.num_parents       =3D 0;
> +               vgpio->gc.irq.parents           =3D NULL;
> +               vgpio->gc.irq.default_type      =3D IRQ_TYPE_NONE;
> +               vgpio->gc.irq.handler           =3D handle_level_irq;
> +               vgpio->gc.irq.chip              =3D &vgpio_irq_chip;
> +
> +               for (i =3D 0; i < ngpio; i++) {
> +                       vgpio->irq_lines[i].type =3D
> VIRTIO_GPIO_IRQ_TYPE_NONE;
> +                       vgpio->irq_lines[i].disabled =3D true;
> +                       vgpio->irq_lines[i].masked =3D true;
> +               }
> +
> +               mutex_init(&vgpio->irq_lock);
> +               raw_spin_lock_init(&vgpio->eventq_lock);
> +       }
> +
>         ret =3D virtio_gpio_alloc_vqs(vgpio, vdev);
>         if (ret)
>                 return ret;
> @@ -357,7 +653,13 @@ static const struct virtio_device_id id_table[] =3D =
{
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);
>
> +static const unsigned int features[] =3D {
> +       VIRTIO_GPIO_F_IRQ,
> +};
> +
>  static struct virtio_driver virtio_gpio_driver =3D {
> +       .feature_table          =3D features,
> +       .feature_table_size     =3D ARRAY_SIZE(features),
>         .id_table               =3D id_table,
>         .probe                  =3D virtio_gpio_probe,
>         .remove                 =3D virtio_gpio_remove,
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio=
_
> gpio.h
> index 0445f905d8cc..d04af9c5f0de 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -5,12 +5,16 @@
>
>  #include <linux/types.h>
>
> +/* Virtio GPIO Feature bits */
> +#define VIRTIO_GPIO_F_IRQ                      0
> +
>  /* Virtio GPIO request types */
>  #define VIRTIO_GPIO_MSG_GET_NAMES              0x0001
>  #define VIRTIO_GPIO_MSG_GET_DIRECTION          0x0002
>  #define VIRTIO_GPIO_MSG_SET_DIRECTION          0x0003
>  #define VIRTIO_GPIO_MSG_GET_VALUE              0x0004
>  #define VIRTIO_GPIO_MSG_SET_VALUE              0x0005
> +#define VIRTIO_GPIO_MSG_IRQ_TYPE               0x0006
>
>  /* Possible values of the status field */
>  #define VIRTIO_GPIO_STATUS_OK                  0x0
> @@ -21,6 +25,14 @@
>  #define VIRTIO_GPIO_DIRECTION_OUT              0x01
>  #define VIRTIO_GPIO_DIRECTION_IN               0x02
>
> +/* Virtio GPIO IRQ types */
> +#define VIRTIO_GPIO_IRQ_TYPE_NONE              0x00
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING       0x01
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING      0x02
> +#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH         0x03
> +#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH                0x04
> +#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW         0x08
> +
>  struct virtio_gpio_config {
>         __le16 ngpio;
>         __u8 padding[2];
> @@ -44,4 +56,17 @@ struct virtio_gpio_response_get_names {
>         __u8 value[];
>  };
>
> +/* Virtio GPIO IRQ Request / Response */
> +struct virtio_gpio_irq_request {
> +       __le16 gpio;
> +};
> +
> +struct virtio_gpio_irq_response {
> +       __u8 status;
> +};
>
>
I=E2=80=99m wondering if those above should be packed.


> +/* Possible values of the interrupt status field */
> +#define VIRTIO_GPIO_IRQ_STATUS_INVALID         0x0
> +#define VIRTIO_GPIO_IRQ_STATUS_VALID           0x1
> +
>  #endif /* _LINUX_VIRTIO_GPIO_H */
> --
> 2.31.1.272.g89b43f80a514
>
>

--=20
With Best Regards,
Andy Shevchenko

--00000000000008d0bc05ceca2d3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 20, 2021, Viresh Kumar &lt;<a href=3D"mailto:=
viresh.kumar@linaro.org">viresh.kumar@linaro.org</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">This patch adds IRQ support for the virtio GPIO driv=
er. Note that this<br>
uses the irq_bus_lock/unlock() callbacks, since those operations over<br>
virtio may sleep.<br>
<br>
Reviewed-by: Linus Walleij &lt;<a href=3D"mailto:linus.walleij@linaro.org">=
linus.walleij@linaro.org</a>&gt;<br>
Signed-off-by: Viresh Kumar &lt;<a href=3D"mailto:viresh.kumar@linaro.org">=
viresh.kumar@linaro.org</a>&gt;<br>
---<br>
Bartosz,<br>
<br>
The spec changes are close to merging now, I will let you know once the bal=
lot<br>
is closed and the spec changes are merged. You can then pick this patch for=
<br>
5.16.<br>
<br>
V5-&gt;V6:<br>
- Sent it separately as the other patches are already merged.<br>
- Queue the buffers only after enabling the irq (as per latest spec).<br>
- Migrate to raw_spinlock_t.<br>
<br>
=C2=A0drivers/gpio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0drivers/gpio/gpio-virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 310 ++++++++++=
++++++++++++++++++++<wbr>-<br>
=C2=A0include/uapi/linux/virtio_<wbr>gpio.h |=C2=A0 25 +++<br>
=C2=A03 files changed, 332 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig<br>
index fae5141251e5..bfa723ff8e7c 100644<br>
--- a/drivers/gpio/Kconfig<br>
+++ b/drivers/gpio/Kconfig<br>
@@ -1674,6 +1674,7 @@ config GPIO_MOCKUP<br>
=C2=A0config GPIO_VIRTIO<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate &quot;VirtIO GPIO support&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on VIRTIO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select GPIOLIB_IRQCHIP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here to enable guest support for v=
irtio-based GPIO controllers.<br>
<br>
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c<br>
index d24f1c9264bc..73fbe2eda4b9 100644<br>
--- a/drivers/gpio/gpio-virtio.c<br>
+++ b/drivers/gpio/gpio-virtio.c<br>
@@ -16,6 +16,7 @@<br>
=C2=A0#include &lt;linux/kernel.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/mutex.h&gt;<br>
+#include &lt;linux/spinlock.h&gt;<br>
=C2=A0#include &lt;linux/virtio_config.h&gt;<br>
=C2=A0#include &lt;uapi/linux/virtio_gpio.h&gt;<br>
=C2=A0#include &lt;uapi/linux/virtio_ids.h&gt;<br>
@@ -28,12 +29,30 @@ struct virtio_gpio_line {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int rxlen;<br>
=C2=A0};<br>
<br>
+struct vgpio_irq_line {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool disabled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool masked;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool queued;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool update_pending;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool queue_pending;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio_irq_request ireq ____cacheli=
ne_aligned;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio_irq_response ires ____cachel=
ine_aligned;<br>
+};<br>
+<br>
=C2=A0struct virtio_gpio {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_device *vdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mutex lock; /* Protects virtqueue operat=
ion */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gpio_chip gc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpio_line *lines;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtqueue *request_vq;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* irq support */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtqueue *event_vq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex irq_lock; /* Protects irq operatio=
n */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spinlock_t eventq_lock; /* Protects queuing=
 of the buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_lines;<br>
=C2=A0};<br>
<br>
=C2=A0static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 =
gpio,<br>
@@ -186,6 +205,244 @@ static void virtio_gpio_set(struct gpio_chip *gc, uns=
igned int gpio, int value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALU=
E, gpio, value, NULL);<br>
=C2=A0}<br>
<br>
+/* Interrupt handling */<br>
+static void virtio_gpio_irq_prepare(struct virtio_gpio *vgpio, u16 gpio)<b=
r>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[gpio];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio_irq_request *ireq =3D &amp;i=
rq_line-&gt;ireq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio_irq_response *ires =3D &amp;=
irq_line-&gt;ires;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist *sgs[2], req_sg, res_sg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON(irq_line-&gt;queued || irq_line-&gt=
;masked || irq_line-&gt;disabled))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ireq-&gt;gpio =3D cpu_to_le16(gpio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one(&amp;req_sg, ireq, sizeof(*ireq));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one(&amp;res_sg, ires, sizeof(*ires));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sgs[0] =3D &amp;req_sg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sgs[1] =3D &amp;res_sg;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtqueue_add_sgs(vgpio-&gt;<wbr>event_=
vq, sgs, 1, 1, irq_line, GFP_ATOMIC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vgpio-=
&gt;vdev-&gt;dev, &quot;failed to add request to eventq\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;queued =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0virtqueue_kick(vgpio-&gt;event_<wbr>vq);<br>
+}<br>
+<br>
+static void virtio_gpio_irq_enable(struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock(&amp;vgpio-&gt;eventq_<wbr>lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;disabled =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;masked =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;queue_pending =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock(&amp;vgpio-&gt;<wbr>eventq_lock=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;update_pending =3D true;<br>
+}<br>
+<br>
+static void virtio_gpio_irq_disable(struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock(&amp;vgpio-&gt;eventq_<wbr>lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;disabled =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;masked =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;queue_pending =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock(&amp;vgpio-&gt;<wbr>eventq_lock=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;update_pending =3D true;<br>
+}<br>
+<br>
+static void virtio_gpio_irq_mask(struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock(&amp;vgpio-&gt;eventq_<wbr>lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;masked =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock(&amp;vgpio-&gt;<wbr>eventq_lock=
);<br>
+}<br>
+<br>
+static void virtio_gpio_irq_unmask(struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock(&amp;vgpio-&gt;eventq_<wbr>lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;masked =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Queue the buffer unconditionally on unmask *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpio_irq_prepare(vgpio, d-&gt;hwirq);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock(&amp;vgpio-&gt;<wbr>eventq_lock=
);<br>
+}<br>
+<br>
+static int virtio_gpio_irq_set_type(<wbr>struct irq_data *d, unsigned int =
type)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_NONE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_NONE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;</blockquote>=
<div><br></div><div>IIRC you add dead code. IRQ framework never calls this =
if type is not set.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_EDGE_RISING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_EDGE_<wbr>RISING;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_EDGE_FALLING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_EDGE_<wbr>FALLING;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_EDGE_BOTH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_EDGE_<wbr>BOTH;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_LEVEL_LOW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_LEVEL_<wbr>LOW;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IRQ_TYPE_LEVEL_HIGH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D VIRTIO_GPI=
O_IRQ_TYPE_LEVEL_<wbr>HIGH;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vgpio-=
&gt;vdev-&gt;dev, &quot;unsupported irq type: %u\n&quot;, type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;type =3D type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;update_pending =3D true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void virtio_gpio_irq_bus_lock(<wbr>struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;vgpio-&gt;irq_lock);<br>
+}<br>
+<br>
+static void virtio_gpio_irq_bus_sync_<wbr>unlock(struct irq_data *d)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gpio_chip *gc =3D irq_data_get_irq_chip_=
data(d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D gpiochip_get_data=
(gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line =3D &amp;vgpio-=
&gt;irq_lines[d-&gt;hwirq];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 type =3D irq_line-&gt;disabled ? VIRTIO_GPIO=
_IRQ_TYPE_NONE : irq_line-&gt;type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq_line-&gt;update_pending) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;update=
_pending =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpio_req(vgp=
io, VIRTIO_GPIO_MSG_IRQ_TYPE, d-&gt;hwirq, type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Queue the buffer=
 only after interrupt is enabled */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock_irqsa=
ve(&amp;vgpio-&gt;<wbr>eventq_lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq_line-&gt;qu=
eue_pending) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0irq_line-&gt;queue_pending =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0virtio_gpio_irq_prepare(vgpio, d-&gt;hwirq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock_irq=
restore(&amp;<wbr>vgpio-&gt;eventq_lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;vgpio-&gt;irq_lock)<wbr>;<br>
+}<br>
+<br>
+static struct irq_chip vgpio_irq_chip =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;virtio-gpio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_enable=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D virtio_gpio_irq_enable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_disable=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D virtio_gpio_irq_disable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_mask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D virtio_gpio_irq_mask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_unmask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D virtio_gpio_irq_unmask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_set_type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D virtio_gpio_irq_set_type,<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* These are required to implement irqchip for =
slow busses */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_bus_lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D virtio_gpio_irq_bus_lock,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_bus_sync_unlock=C2=A0 =C2=A0 =3D virtio_gp=
io_irq_bus_sync_<wbr>unlock,<br>
+};<br>
+<br>
+static bool ignore_irq(struct virtio_gpio *vgpio, int gpio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct vgpio_irq_line *irq_line)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool ignore =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock(&amp;vgpio-&gt;eventq_<wbr>lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line-&gt;queued =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Interrupt is disabled currently */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq_line-&gt;masked || irq_line-&gt;disable=
d) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Buffer is returned as the interrupt was disa=
bled earlier, but is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * enabled again now. Requeue the buffers.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq_line-&gt;ires.status =3D=3D VIRTIO_GPIO=
_IRQ_STATUS_<wbr>INVALID) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpio_irq_pre=
pare(vgpio, gpio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON(irq_line-&gt;ires.status !=3D VIRTI=
O_GPIO_IRQ_STATUS_VALID))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore =3D true;<br=
>
+<br>
+unlock:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock(&amp;vgpio-&gt;<wbr>eventq_lock=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ignore;<br>
+}<br>
+<br>
+static void virtio_gpio_event_vq(struct virtqueue *vq)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpio *vgpio =3D vq-&gt;vdev-&gt;p=
riv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;vgpio-&gt;vdev-&gt;=
dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vgpio_irq_line *irq_line;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int irq, gpio, ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_line =3D virtqu=
eue_get_buf(vgpio-&gt;<wbr>event_vq, &amp;len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!irq_line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D sizeof=
(irq_line-&gt;ires)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(dev, &quot;irq with incorrect length (%u : %u)\n&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len, (unsigned int)sizeof(irq_line-&g=
t;ires));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Find GPIO line n=
umber from the offset of irq_line within the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * irq_lines block.=
 We can also get GPIO number from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * irq-request, but=
 better not to rely on a buffer returned by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * remote.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio =3D irq_line -=
 vgpio-&gt;irq_lines;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(gpio &gt;=
=3D vgpio-&gt;gc.ngpio);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(ignore=
_irq(vgpio, gpio, irq_line)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D irq_find_ma=
pping(vgpio-&gt;gc.<wbr>irq.domain, gpio);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(!irq);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D generic_han=
dle_irq(irq);</blockquote><div><br></div><div>IIRC there is a new API that =
basically combines the two above.</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(dev, &quot;failed to handle interrupt: %d\n&quot;, ret);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+}<br>
+<br>
=C2=A0static void virtio_gpio_request_vq(struct virtqueue *vq)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpio_line *line;<br>
@@ -210,14 +467,15 @@ static void virtio_gpio_free_vqs(struct virtio_device=
 *vdev)<br>
=C2=A0static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_device *vdev)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const char * const names[] =3D { &quot;requestq=
&quot; };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char * const names[] =3D { &quot;requestq=
&quot;, &quot;eventq&quot; };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vq_callback_t *cbs[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpio_request=
_vq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpio_event_v=
q,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtqueue *vqs[1] =3D { NULL };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtqueue *vqs[2] =3D { NULL, NULL };<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtio_find_vqs(vdev, 1, vqs, cbs, name=
s, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtio_find_vqs(vdev, vgpio-&gt;irq_lin=
es ? 2 : 1, vqs, cbs, names, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;vdev-&=
gt;dev, &quot;failed to find vqs: %d\n&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
@@ -225,11 +483,23 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *=
vgpio,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vqs[0]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;vdev-&=
gt;dev, &quot;failed to find requestq vq\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgpio-&gt;request_vq =3D vqs[0];<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vgpio-&gt;irq_lines &amp;&amp; !vqs[1]) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vdev-&=
gt;dev, &quot;failed to find eventq vq\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;event_vq =3D vqs[1];<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vqs[0] || vqs[1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpio_free_vq=
s(vdev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
=C2=A0}<br>
<br>
=C2=A0static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,<=
br>
@@ -325,6 +595,32 @@ static int virtio_gpio_probe(struct virtio_device *vde=
v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgpio-&gt;gc.owner=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D THIS_MODULE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vgpio-&gt;gc.can_sleep=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D true;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Interrupt support */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;irq_lines=
 =3D devm_kcalloc(dev, ngpio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sizeof(*vgpio-&gt;irq_lines),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GFP_KERNEL);</blockquote><div><br></div><div>One line?<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vgpio-&gt;irq_=
lines)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The event comes =
from the outside so no parent handler */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.pa=
rent_handler=C2=A0 =C2=A0 =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.nu=
m_parents=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.pa=
rents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.de=
fault_type=C2=A0 =C2=A0 =C2=A0 =3D IRQ_TYPE_NONE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.ha=
ndler=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D handle_level_irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgpio-&gt;gc.irq.ch=
ip=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;vgpio_irq_chip;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt=
; ngpio; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vgpio-&gt;irq_lines[i].type =3D VIRTIO_GPIO_IRQ_TYPE_NONE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vgpio-&gt;irq_lines[i].disabled =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vgpio-&gt;irq_lines[i].masked =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&amp;vgp=
io-&gt;irq_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock_init(=
&amp;vgpio-&gt;<wbr>eventq_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D virtio_gpio_alloc_vqs(vgpio, vdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
@@ -357,7 +653,13 @@ static const struct virtio_device_id id_table[] =3D {<=
br>
=C2=A0};<br>
=C2=A0MODULE_DEVICE_TABLE(virtio, id_table);<br>
<br>
+static const unsigned int features[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPIO_F_IRQ,<br>
+};<br>
+<br>
=C2=A0static struct virtio_driver virtio_gpio_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.feature_table=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D features,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.feature_table_size=C2=A0 =C2=A0 =C2=A0=3D ARRA=
Y_SIZE(features),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .id_table=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D id_table,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D virtio_gpio_probe,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D virtio_gpio_remove,<br>
diff --git a/include/uapi/linux/virtio_<wbr>gpio.h b/include/uapi/linux/vir=
tio_<wbr>gpio.h<br>
index 0445f905d8cc..d04af9c5f0de 100644<br>
--- a/include/uapi/linux/virtio_<wbr>gpio.h<br>
+++ b/include/uapi/linux/virtio_<wbr>gpio.h<br>
@@ -5,12 +5,16 @@<br>
<br>
=C2=A0#include &lt;linux/types.h&gt;<br>
<br>
+/* Virtio GPIO Feature bits */<br>
+#define VIRTIO_GPIO_F_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+<br>
=C2=A0/* Virtio GPIO request types */<br>
=C2=A0#define VIRTIO_GPIO_MSG_GET_NAMES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x0001<br>
=C2=A0#define VIRTIO_GPIO_MSG_GET_DIRECTION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0002<br>
=C2=A0#define VIRTIO_GPIO_MSG_SET_DIRECTION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0003<br>
=C2=A0#define VIRTIO_GPIO_MSG_GET_VALUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x0004<br>
=C2=A0#define VIRTIO_GPIO_MSG_SET_VALUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x0005<br>
+#define VIRTIO_GPIO_MSG_IRQ_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x0006<br>
<br>
=C2=A0/* Possible values of the status field */<br>
=C2=A0#define VIRTIO_GPIO_STATUS_OK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x0<br>
@@ -21,6 +25,14 @@<br>
=C2=A0#define VIRTIO_GPIO_DIRECTION_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x01<br>
=C2=A0#define VIRTIO_GPIO_DIRECTION_IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x02<br>
<br>
+/* Virtio GPIO IRQ types */<br>
+#define VIRTIO_GPIO_IRQ_TYPE_NONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x00<br>
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_<wbr>RISING=C2=A0 =C2=A0 =C2=A0 =C2=A00x=
01<br>
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_<wbr>FALLING=C2=A0 =C2=A0 =C2=A0 0x02<br=
>
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
03<br>
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_<wbr>HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
08<br>
+<br>
=C2=A0struct virtio_gpio_config {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le16 ngpio;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 padding[2];<br>
@@ -44,4 +56,17 @@ struct virtio_gpio_response_get_names {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 value[];<br>
=C2=A0};<br>
<br>
+/* Virtio GPIO IRQ Request / Response */<br>
+struct virtio_gpio_irq_request {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__le16 gpio;<br>
+};<br>
+<br>
+struct virtio_gpio_irq_response {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 status;<br>
+};<br><br></blockquote><div><br></div><div>I=E2=80=99m wondering if those =
above should be packed.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
+/* Possible values of the interrupt status field */<br>
+#define VIRTIO_GPIO_IRQ_STATUS_INVALID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0<br>
+#define VIRTIO_GPIO_IRQ_STATUS_VALID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x1<br>
+<br>
=C2=A0#endif /* _LINUX_VIRTIO_GPIO_H */<br>
-- <br>
2.31.1.272.g89b43f80a514<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--00000000000008d0bc05ceca2d3e--


--===============0646500109190607552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0646500109190607552==--


