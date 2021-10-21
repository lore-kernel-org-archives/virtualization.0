Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC82C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:04:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F43F61205
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F43F61205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC4EC60EF8;
	Thu, 21 Oct 2021 11:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K01p0TN5JJWD; Thu, 21 Oct 2021 11:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F002960EBA;
	Thu, 21 Oct 2021 11:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D86C4C0033;
	Thu, 21 Oct 2021 11:04:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE782C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC91B60EF2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qS5FAtSbvT2X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:04:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F09960EBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:04:24 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id v8so278613pfu.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWyJtBxpSTNKxh9Pi95t4qpbfdi94ylNZ/rE2rj/uTk=;
 b=y7+nsg+ZFdCU5/jCOlFoOTVK4B6pMARXejM8DcrS/VUsOtFNo0siE+Z8ISoD6OLu0q
 +AabS3y5WQgO4LQ5kLNk5O8mtZ3aWeiKtsQzGJZJb5WkhmxDOT6D5N14S7/LfMoebyRS
 aUzc8gXsydhfp4NNj+N6LArU+ZhgqMzqaeQzHa0sF+jf7GXueZX31o/AVPKSPbiLhhQb
 k4MwylDSvyfL8wIA42VZ7A3fgZS4zzyZ+Z3FDSB1GIdw9NrfZESV0ei7qZEV/asCxj6H
 hGDUyzNul6LjrwUcuc94+Jrf383YSSMoe/WoiRzBUZQ2IVlRnXY70xqWqSrOtmoT24F8
 F0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWyJtBxpSTNKxh9Pi95t4qpbfdi94ylNZ/rE2rj/uTk=;
 b=QGSyLC14UNYzRWRmrV39M2ZOeoWDZGrLqTLSbJsqjj2mG4Bkb0BdRo51+SUR9agRww
 /47b0D78lbIvHhoyqbFOqeffQCel3WrgAiuaDJKlwRkzdhPa6ojM10zooptw3uiCVLHv
 hXIlVy3YvEq2TeFg6oAy+UA13ZYDFl5qXnUbYZC//Q9BONfSEgZn6aPg0MfJDqpigueD
 U/wl9QJEc4ZmBGQIYUpjt6rYjhVhqzYPHUqchptPyAhVg5eMPDAXLqiKvieSQOaI6EPJ
 tJLL6k0DgUqPNWpX9k8H3YsWsJcx8tzfYSYHaiw5FUigspuEpB8Xkze5UK2eB2aREyr+
 O74A==
X-Gm-Message-State: AOAM533Rc/tXcOL+jhdPxTaadkDrRvohEf5j9KAUFh+2tFMKqpug2yw5
 9axtzDzcJhL5+ZgKXKEx1Ihciw==
X-Google-Smtp-Source: ABdhPJylzMePV2TNCs5Tk0V9zhlMuEwAnywHcZ+2bmmvhvR6JQIlS6Yj9BRR9FvE2Mz4yJ5C2NOxqA==
X-Received: by 2002:a63:368a:: with SMTP id d132mr3791440pga.342.1634814263862; 
 Thu, 21 Oct 2021 04:04:23 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id j8sm5159436pga.26.2021.10.21.04.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 04:04:23 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH V7] gpio: virtio: Add IRQ support
Date: Thu, 21 Oct 2021 16:34:19 +0530
Message-Id: <ae639da42050ee0ffd9ba1fffc2c86a38d66cec4.1634813977.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org
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

This patch adds IRQ support for the virtio GPIO driver. Note that this
uses the irq_bus_lock/unlock() callbacks, since those operations over
virtio may sleep.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Bartosz,

The spec changes are close to merging now, I will let you know once the ballot
is closed and the spec changes are merged. You can then pick this patch for
5.16.

V6->V7:
- Use generic_handle_domain_irq.
- Drop check for IRQ_TYPE_NONE, dead code.
- Avoid breaking line to fit into 80 columns.

V5->V6:
- Sent it separately as the other patches are already merged.
- Queue the buffers only after enabling the irq (as per latest spec).
- Migrate to raw_spinlock_t.

 drivers/gpio/Kconfig             |   1 +
 drivers/gpio/gpio-virtio.c       | 302 ++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_gpio.h |  25 +++
 3 files changed, 324 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fae5141251e5..bfa723ff8e7c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1674,6 +1674,7 @@ config GPIO_MOCKUP
 config GPIO_VIRTIO
 	tristate "VirtIO GPIO support"
 	depends on VIRTIO
+	select GPIOLIB_IRQCHIP
 	help
 	  Say Y here to enable guest support for virtio-based GPIO controllers.
 
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index d24f1c9264bc..aeec4bf0b625 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_gpio.h>
 #include <uapi/linux/virtio_ids.h>
@@ -28,12 +29,30 @@ struct virtio_gpio_line {
 	unsigned int rxlen;
 };
 
+struct vgpio_irq_line {
+	u8 type;
+	bool disabled;
+	bool masked;
+	bool queued;
+	bool update_pending;
+	bool queue_pending;
+
+	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
+	struct virtio_gpio_irq_response ires ____cacheline_aligned;
+};
+
 struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
 	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;
+
+	/* irq support */
+	struct virtqueue *event_vq;
+	struct mutex irq_lock; /* Protects irq operation */
+	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
+	struct vgpio_irq_line *irq_lines;
 };
 
 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -186,6 +205,238 @@ static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
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
+	if (WARN_ON(irq_line->queued || irq_line->masked || irq_line->disabled))
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
+static void virtio_gpio_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	raw_spin_lock(&vgpio->eventq_lock);
+	irq_line->disabled = false;
+	irq_line->masked = false;
+	irq_line->queue_pending = true;
+	raw_spin_unlock(&vgpio->eventq_lock);
+
+	irq_line->update_pending = true;
+}
+
+static void virtio_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	raw_spin_lock(&vgpio->eventq_lock);
+	irq_line->disabled = true;
+	irq_line->masked = true;
+	irq_line->queue_pending = false;
+	raw_spin_unlock(&vgpio->eventq_lock);
+
+	irq_line->update_pending = true;
+}
+
+static void virtio_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	raw_spin_lock(&vgpio->eventq_lock);
+	irq_line->masked = true;
+	raw_spin_unlock(&vgpio->eventq_lock);
+}
+
+static void virtio_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	raw_spin_lock(&vgpio->eventq_lock);
+	irq_line->masked = false;
+
+	/* Queue the buffer unconditionally on unmask */
+	virtio_gpio_irq_prepare(vgpio, d->hwirq);
+	raw_spin_unlock(&vgpio->eventq_lock);
+}
+
+static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	struct vgpio_irq_line *irq_line = &vgpio->irq_lines[d->hwirq];
+
+	switch (type) {
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
+	irq_line->update_pending = true;
+
+	return 0;
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
+	u8 type = irq_line->disabled ? VIRTIO_GPIO_IRQ_TYPE_NONE : irq_line->type;
+	unsigned long flags;
+
+	if (irq_line->update_pending) {
+		irq_line->update_pending = false;
+		virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_IRQ_TYPE, d->hwirq, type,
+				NULL);
+
+		/* Queue the buffer only after interrupt is enabled */
+		raw_spin_lock_irqsave(&vgpio->eventq_lock, flags);
+		if (irq_line->queue_pending) {
+			irq_line->queue_pending = false;
+			virtio_gpio_irq_prepare(vgpio, d->hwirq);
+		}
+		raw_spin_unlock_irqrestore(&vgpio->eventq_lock, flags);
+	}
+
+	mutex_unlock(&vgpio->irq_lock);
+}
+
+static struct irq_chip vgpio_irq_chip = {
+	.name			= "virtio-gpio",
+	.irq_enable		= virtio_gpio_irq_enable,
+	.irq_disable		= virtio_gpio_irq_disable,
+	.irq_mask		= virtio_gpio_irq_mask,
+	.irq_unmask		= virtio_gpio_irq_unmask,
+	.irq_set_type		= virtio_gpio_irq_set_type,
+
+	/* These are required to implement irqchip for slow busses */
+	.irq_bus_lock		= virtio_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock,
+};
+
+static bool ignore_irq(struct virtio_gpio *vgpio, int gpio,
+		       struct vgpio_irq_line *irq_line)
+{
+	bool ignore = false;
+
+	raw_spin_lock(&vgpio->eventq_lock);
+	irq_line->queued = false;
+
+	/* Interrupt is disabled currently */
+	if (irq_line->masked || irq_line->disabled) {
+		ignore = true;
+		goto unlock;
+	}
+
+	/*
+	 * Buffer is returned as the interrupt was disabled earlier, but is
+	 * enabled again now. Requeue the buffers.
+	 */
+	if (irq_line->ires.status == VIRTIO_GPIO_IRQ_STATUS_INVALID) {
+		virtio_gpio_irq_prepare(vgpio, gpio);
+		ignore = true;
+		goto unlock;
+	}
+
+	if (WARN_ON(irq_line->ires.status != VIRTIO_GPIO_IRQ_STATUS_VALID))
+		ignore = true;
+
+unlock:
+	raw_spin_unlock(&vgpio->eventq_lock);
+
+	return ignore;
+}
+
+static void virtio_gpio_event_vq(struct virtqueue *vq)
+{
+	struct virtio_gpio *vgpio = vq->vdev->priv;
+	struct device *dev = &vgpio->vdev->dev;
+	struct vgpio_irq_line *irq_line;
+	int gpio, ret;
+	unsigned int len;
+
+	while (true) {
+		irq_line = virtqueue_get_buf(vgpio->event_vq, &len);
+		if (!irq_line)
+			break;
+
+		if (len != sizeof(irq_line->ires)) {
+			dev_err(dev, "irq with incorrect length (%u : %u)\n",
+				len, (unsigned int)sizeof(irq_line->ires));
+			continue;
+		}
+
+		/*
+		 * Find GPIO line number from the offset of irq_line within the
+		 * irq_lines block. We can also get GPIO number from
+		 * irq-request, but better not to rely on a buffer returned by
+		 * remote.
+		 */
+		gpio = irq_line - vgpio->irq_lines;
+		WARN_ON(gpio >= vgpio->gc.ngpio);
+
+		if (unlikely(ignore_irq(vgpio, gpio, irq_line)))
+			continue;
+
+		ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
+		if (ret)
+			dev_err(dev, "failed to handle interrupt: %d\n", ret);
+	};
+}
+
 static void virtio_gpio_request_vq(struct virtqueue *vq)
 {
 	struct virtio_gpio_line *line;
@@ -210,14 +461,15 @@ static void virtio_gpio_free_vqs(struct virtio_device *vdev)
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
@@ -225,11 +477,23 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 
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
 
 static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
@@ -325,6 +589,30 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	vgpio->gc.owner			= THIS_MODULE;
 	vgpio->gc.can_sleep		= true;
 
+	/* Interrupt support */
+	if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)) {
+		vgpio->irq_lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->irq_lines), GFP_KERNEL);
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
+		for (i = 0; i < ngpio; i++) {
+			vgpio->irq_lines[i].type = VIRTIO_GPIO_IRQ_TYPE_NONE;
+			vgpio->irq_lines[i].disabled = true;
+			vgpio->irq_lines[i].masked = true;
+		}
+
+		mutex_init(&vgpio->irq_lock);
+		raw_spin_lock_init(&vgpio->eventq_lock);
+	}
+
 	ret = virtio_gpio_alloc_vqs(vgpio, vdev);
 	if (ret)
 		return ret;
@@ -357,7 +645,13 @@ static const struct virtio_device_id id_table[] = {
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
diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
index 0445f905d8cc..d04af9c5f0de 100644
--- a/include/uapi/linux/virtio_gpio.h
+++ b/include/uapi/linux/virtio_gpio.h
@@ -5,12 +5,16 @@
 
 #include <linux/types.h>
 
+/* Virtio GPIO Feature bits */
+#define VIRTIO_GPIO_F_IRQ			0
+
 /* Virtio GPIO request types */
 #define VIRTIO_GPIO_MSG_GET_NAMES		0x0001
 #define VIRTIO_GPIO_MSG_GET_DIRECTION		0x0002
 #define VIRTIO_GPIO_MSG_SET_DIRECTION		0x0003
 #define VIRTIO_GPIO_MSG_GET_VALUE		0x0004
 #define VIRTIO_GPIO_MSG_SET_VALUE		0x0005
+#define VIRTIO_GPIO_MSG_IRQ_TYPE		0x0006
 
 /* Possible values of the status field */
 #define VIRTIO_GPIO_STATUS_OK			0x0
@@ -21,6 +25,14 @@
 #define VIRTIO_GPIO_DIRECTION_OUT		0x01
 #define VIRTIO_GPIO_DIRECTION_IN		0x02
 
+/* Virtio GPIO IRQ types */
+#define VIRTIO_GPIO_IRQ_TYPE_NONE		0x00
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING	0x01
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING	0x02
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH		0x03
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH		0x04
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW		0x08
+
 struct virtio_gpio_config {
 	__le16 ngpio;
 	__u8 padding[2];
@@ -44,4 +56,17 @@ struct virtio_gpio_response_get_names {
 	__u8 value[];
 };
 
+/* Virtio GPIO IRQ Request / Response */
+struct virtio_gpio_irq_request {
+	__le16 gpio;
+};
+
+struct virtio_gpio_irq_response {
+	__u8 status;
+};
+
+/* Possible values of the interrupt status field */
+#define VIRTIO_GPIO_IRQ_STATUS_INVALID		0x0
+#define VIRTIO_GPIO_IRQ_STATUS_VALID		0x1
+
 #endif /* _LINUX_VIRTIO_GPIO_H */
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
