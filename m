Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A8FC4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 11:26:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41FB6112F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 11:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A41FB6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6918260A8D;
	Thu,  5 Aug 2021 11:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wABcnWfFyo6R; Thu,  5 Aug 2021 11:26:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95D07608B8;
	Thu,  5 Aug 2021 11:26:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CBCAC001A;
	Thu,  5 Aug 2021 11:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90A05C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AF814028F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJmvJ9yYvhdk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:26:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 007CB40138
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:26:49 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 e2-20020a17090a4a02b029016f3020d867so8535551pjh.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aJTPpUh6t2Es8y7Iu7RimXwcA3En7rLzswEc/EhXmpU=;
 b=YSkpZre0qFUWOKnFiY6mD1Cfh1gxdhUbV2KEMmeE/TB+fsbO6IC2Gr40mVUf0+K7jw
 +rRHi2t0fXELui3TCNi2aAW/aRLZGj5Fp83Fw71AZI46Hrb5LqC35XoNCPdGmN+OYfkK
 7JVBREinP2hsOhGxW+ch2yMvYujlN2TxFl6IOwjcfFW7npU/dEwXi1zqvovZk5QU7HBz
 uWZ430mPivPU/3iaz1PTlSWKwR5tXF5Il0HRTwqwEG7/2a0w/XfNYb/styG4Beu0q/bt
 7uW5FI48i+2Dx2dTuYsWdBQ7B64wmrUz7UrhZBGTUWPQ886UC09Omontgy6cfHa6q2Q3
 uQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aJTPpUh6t2Es8y7Iu7RimXwcA3En7rLzswEc/EhXmpU=;
 b=kW2r9slcJSteNrYLtvUvHr9go7F428MWcS6vMgsWe+NIVZZvVJ+eTnivVpN8nPWHwb
 MsI72/kNX5GUdeQ6/ICajtNY6LpTi6knMk7GMCoM0ZEu6IP6Nq9b+pbnviywiy1HFQlm
 b+k27yi8s8zDefBE6y6ewweGJgQWDa4Zo/N4cNy6l3g+BMAEUWkB5J1L4+/Nyl9NYw4w
 0buHvaDPVJtKUeejJ44Mh08YvQjVo3jSVFV1EVjsxMt6vv7hUKEL7oTllYkpSfE+u4RQ
 uiTpbElDLmQzpkh/osBD/lEPd2ZEWvU4nitPUMT+KHtD0phOQ+4mTBxxrz/K3BAAmcqw
 uZtQ==
X-Gm-Message-State: AOAM532p3nrklIlV8IuTYlU6NYjh+Kne0XjPNcFxwUFtnVzg1qyC84pF
 GJvKBdnIvm9td7c6zOmoFjxM8g==
X-Google-Smtp-Source: ABdhPJzv+MboVfqPh0q+vDLPaa8pd6outUQJG4TuEMiFxmK76373FG4avjK/7bnF3wpUokDchlHCMQ==
X-Received: by 2002:aa7:8d10:0:b029:303:8d17:7b8d with SMTP id
 j16-20020aa78d100000b02903038d177b8dmr4836361pfe.26.1628162809328; 
 Thu, 05 Aug 2021 04:26:49 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id j16sm6923193pfi.165.2021.08.05.04.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 04:26:48 -0700 (PDT)
Date: Thu, 5 Aug 2021 16:56:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V4 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210805112646.lgkurm3wjilf5xrv@vireshk-i7>
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
> As far as I can tell, the update_irq_type() message would lead to the
> interrupt getting delivered when it was armed and is now getting disabled,
> but I don't see why we would call update_irq_type() as a result of the
> eventq notification.

Based on discussion we had today (offline), I changed the design a bit
and used handle_level_irq() instead, as it provides consistent calls
to mask/unmask(), which simplified the whole thing a bit.

Also I have broken the rule from specs, maybe we should update spec
with that, where the specs said that the buffer must not be queued
before enabling the interrupt. I just queue the buffer unconditionally
now from unmask().

I am not sure but there may be some race around the "queued" flag and
I wonder if we can land in a scenario where the buffer is left
un-queued somehow, while an interrupt is enabled.

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 199f8ace1e88..114ce2640944 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -28,6 +28,17 @@ struct virtio_gpio_line {
 	unsigned int rxlen;
 };
 
+struct vgpio_irq_line {
+	u8 type;
+	bool type_pending;
+	bool masked;
+	bool mask_pending;
+	bool queued;
+
+	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
+	struct virtio_gpio_irq_response ires ____cacheline_aligned;
+};
+
 struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
@@ -35,6 +46,11 @@ struct virtio_gpio {
 	struct virtio_gpio_config config;
 	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;
+
+	/* irq support */
+	struct virtqueue *event_vq;
+	struct mutex irq_lock; /* Protects irq operation */
+	struct vgpio_irq_line *irq_lines;
 };
 
 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -187,6 +203,186 @@ static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value, NULL);
 }
 
+/* Interrupt handling */
+static void virtio_gpio_irq_prepare(struct virtio_gpio *vgpio, u16 gpio)
+{
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[gpio];
+	struct virtio_gpio_irq_request *ireq = &irq_line->ireq;
+	struct virtio_gpio_irq_response *ires = &irq_line->ires;
+	struct scatterlist *sgs[2], req_sg, res_sg;
+	int ret;
+
+	if (unlikely(irq_line->queued))
+		return;
+
+	ireq->gpio = cpu_to_le16(gpio);
+	sg_init_one(&req_sg, ireq, sizeof(*ireq));
+	sg_init_one(&res_sg, ires, sizeof(*ires));
+	sgs[0] = &req_sg;
+	sgs[1] = &res_sg;
+
+	ret = virtqueue_add_sgs(vgpio->event_vq, sgs, 1, 1, irq_line, GFP_ATOMIC);
+	if (ret) {
+		dev_err(&vgpio->vdev->dev, "failed to add request to eventq\n");
+		return;
+	}
+
+	irq_line->queued = true;
+	virtqueue_kick(vgpio->event_vq);
+}
+
+static void virtio_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	if (irq_line->masked)
+		return;
+
+	irq_line->masked = true;
+	irq_line->mask_pending = !irq_line->mask_pending;
+}
+
+static void virtio_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	/* Queue the buffer unconditionally on unmask */
+	virtio_gpio_irq_prepare(vgpio, d->hwirq);
+
+	if (!irq_line->masked)
+		return;
+
+	irq_line->masked = false;
+	irq_line->mask_pending = !irq_line->mask_pending;
+}
+
+static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		type = VIRTIO_GPIO_IRQ_TYPE_NONE;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		type = VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		dev_err(&vgpio->vdev->dev, "unsupported irq type: %u\n", type);
+		return -EINVAL;
+	}
+
+	irq_line->type = type;
+	irq_line->type_pending = true;
+
+	return 0;
+}
+
+static void update_irq_type(struct virtio_gpio *vgpio, u16 gpio, u8 type)
+{
+	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_IRQ_TYPE, gpio, type, NULL);
+}
+
+static void virtio_gpio_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+
+	mutex_lock(&vgpio->irq_lock);
+}
+
+static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+	u8 type = irq_line->masked ? VIRTIO_GPIO_IRQ_TYPE_NONE : irq_line->type;
+
+	if (irq_line->mask_pending || irq_line->type_pending) {
+		irq_line->mask_pending = false;
+		irq_line->type_pending = false;
+		update_irq_type(vgpio, d->hwirq, type);
+	}
+
+	mutex_unlock(&vgpio->irq_lock);
+}
+
+static struct irq_chip vgpio_irq_chip = {
+	.name			= "virtio-gpio",
+	.irq_mask		= virtio_gpio_irq_mask,
+	.irq_unmask		= virtio_gpio_irq_unmask,
+	.irq_set_type		= virtio_gpio_irq_set_type,
+
+	/* These are required to implement irqchip for slow busses */
+	.irq_bus_lock		= virtio_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock,
+};
+
+static void virtio_gpio_event_vq(struct virtqueue *vq)
+{
+	struct virtio_gpio *vgpio = vq->vdev->priv;
+	struct device *dev = &vgpio->vdev->dev;
+	struct vgpio_irq_line *irq_line;
+	int irq, gpio, ret;
+	unsigned int len;
+
+	while (true) {
+		irq_line = virtqueue_get_buf(vgpio->event_vq, &len);
+		if (!irq_line)
+			break;
+
+		if (len != sizeof(irq_line->ires)) {
+			dev_err(dev, "irq with incorrect length (%u : %u)\n",
+				len, (unsigned)sizeof(irq_line->ires));
+			continue;
+		}
+
+		WARN_ON(!irq_line->queued);
+		irq_line->queued = false;
+
+		/* Buffer is returned after interrupt is masked */
+		if (irq_line->ires.status == VIRTIO_GPIO_IRQ_STATUS_INVALID)
+			continue;
+
+		if (WARN_ON(irq_line->ires.status != VIRTIO_GPIO_IRQ_STATUS_VALID))
+			continue;
+
+		/*
+		 * Find GPIO line number from the offset of irq_line within the
+		 * irq_lines block. We can also get GPIO number from
+		 * irq-request, but better not rely on a value returned by
+		 * remote.
+		 */
+		gpio = irq_line - vgpio->irq_lines;
+		WARN_ON(gpio >= vgpio->config.ngpio);
+
+		irq = irq_find_mapping(vgpio->gc.irq.domain, gpio);
+		WARN_ON(!irq);
+
+		ret = generic_handle_irq(irq);
+		if (ret)
+			dev_err(dev, "failed to handle interrupt: %d\n", ret);
+	};
+}
+
 static void virtio_gpio_request_vq(struct virtqueue *vq)
 {
 	struct virtio_gpio_line *line;
@@ -211,14 +407,15 @@ static void virtio_gpio_free_vqs(struct virtio_device *vdev)
 static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 				 struct virtio_device *vdev)
 {
-	const char * const names[] = { "requestq" };
+	const char * const names[] = { "requestq", "eventq" };
 	vq_callback_t *cbs[] = {
 		virtio_gpio_request_vq,
+		virtio_gpio_event_vq,
 	};
-	struct virtqueue *vqs[1] = { NULL };
+	struct virtqueue *vqs[2] = { NULL, NULL };
 	int ret;
 
-	ret = virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
+	ret = virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs, cbs, names, NULL);
 	if (ret) {
 		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
 		return ret;
@@ -226,11 +423,23 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 
 	if (!vqs[0]) {
 		dev_err(&vdev->dev, "failed to find requestq vq\n");
-		return -ENODEV;
+		goto out;
 	}
 	vgpio->request_vq = vqs[0];
 
+	if (vgpio->irq_lines && !vqs[1]) {
+		dev_err(&vdev->dev, "failed to find eventq vq\n");
+		goto out;
+	}
+	vgpio->event_vq = vqs[1];
+
 	return 0;
+
+out:
+	if (vqs[0] || vqs[1])
+		virtio_gpio_free_vqs(vdev);
+
+	return -ENODEV;
 }
 
 static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
@@ -326,6 +535,30 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	vgpio->gc.owner			= THIS_MODULE;
 	vgpio->gc.can_sleep		= true;
 
+	/* Interrupt support */
+	if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)) {
+		vgpio->irq_lines = devm_kcalloc(dev, config->ngpio,
+						sizeof(*vgpio->irq_lines),
+						GFP_KERNEL);
+		if (!vgpio->irq_lines)
+			return -ENOMEM;
+
+		/* The event comes from the outside so no parent handler */
+		vgpio->gc.irq.parent_handler	= NULL;
+		vgpio->gc.irq.num_parents	= 0;
+		vgpio->gc.irq.parents		= NULL;
+		vgpio->gc.irq.default_type	= IRQ_TYPE_NONE;
+		vgpio->gc.irq.handler		= handle_level_irq;
+		vgpio->gc.irq.chip		= &vgpio_irq_chip;
+
+		for (i = 0; i < config->ngpio; i++) {
+			vgpio->irq_lines[i].type = VIRTIO_GPIO_IRQ_TYPE_NONE;
+			vgpio->irq_lines[i].masked = true;
+		}
+
+		mutex_init(&vgpio->irq_lock);
+	}
+
 	ret = virtio_gpio_alloc_vqs(vgpio, vdev);
 	if (ret)
 		return ret;
@@ -358,7 +591,13 @@ static const struct virtio_device_id id_table[] = {
 };
 MODULE_DEVICE_TABLE(virtio, id_table);
 
+static const unsigned int features[] = {
+	VIRTIO_GPIO_F_IRQ,
+};
+
 static struct virtio_driver virtio_gpio_driver = {
+	.feature_table		= features,
+	.feature_table_size	= ARRAY_SIZE(features),
 	.id_table		= id_table,
 	.probe			= virtio_gpio_probe,
 	.remove			= virtio_gpio_remove,
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
