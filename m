Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275BDC48BE8
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:16:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CA060FE5
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA060FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A803E60900;
	Thu, 10 Jun 2021 12:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzgcF37Tmuum; Thu, 10 Jun 2021 12:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E71886084C;
	Thu, 10 Jun 2021 12:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C086DC000E;
	Thu, 10 Jun 2021 12:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D14BC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22BB083B54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olXQw4KlMqKK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21DDD83B4E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:43 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id u18so286657plc.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HKPV4/PpM8bmb6cNa0KbqAwbhxSpJpOWE2S52sDtLkQ=;
 b=PGiX81p1g6M7caFceSQY/X/sErx+nkk6vO4paHZWC72sz/HLqd08oTEfoeq4MgF8Fp
 pyIiORBEANOJ9JiN3XWtaSq2crV4ZBy4QIeuqQpQgEbxwGtqAnDeXIaWgRtVBy+myaRS
 9o1d0ExxzuGdqhY5Ql6Q2u7a0tRD/z6er0712/9vkO4ycs9uddi2L0lDdG2xYXGRTMQx
 tZIRu1IcaqLBXe4ARbjxr3tnAngQET6q1UzYqdOgpF2GdLQtbs+7xuEAxVMb78EaLs5m
 xtSrshOsRYLrho4K832laccohFcl15tzojzf4118IjJYPuhMdy0Vg2GhyRYceZ2s1eHm
 q8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HKPV4/PpM8bmb6cNa0KbqAwbhxSpJpOWE2S52sDtLkQ=;
 b=Zm3wWoc4k7nDZLStTa2xc9gECbfGRhLLH6NJws9tQy7bQKaGmW23O0/vAS4ucgVGiV
 1hxRwr5a0T+qry+L7W2VN8rW+Of7E/Lkrloyq1FpdSaygfh5w/1jAg37Ofg8Iz8i0J9o
 Qnh9m5eA2hQudHrYOyjvpTxSsDFT61rE+1NvLs7oCroFVxXrGCL5GpnNikhtAoLEJnug
 IDUnVyr5r/3AlLh+4ZeygokiMkNhQn3FitKk/U8wtCoTnqB/cMm94UcI8VCK8JD4nyo1
 BGpH1FtJpt+HO8x/UErG6ryamg3iq7gUO1xJH14UISAJNkprwZX6arHX9vR7WDu+NL4V
 qfOg==
X-Gm-Message-State: AOAM531k+IT+71hTVqg6E6VxmreGYZv0xjFVAAzu1MMKNsiTL4tvqeqc
 9znBBje/gyycrnrWfH3hZ/kl9w==
X-Google-Smtp-Source: ABdhPJx9aYVM+pkBMYkN85c7s196a4xUmHymCr/xyFb8ewh6iVVMCbpcrFgAbY9ulttMUeZKQZkWnQ==
X-Received: by 2002:a17:90a:1b68:: with SMTP id
 q95mr3135638pjq.116.1623327402518; 
 Thu, 10 Jun 2021 05:16:42 -0700 (PDT)
Received: from localhost ([136.185.169.128])
 by smtp.gmail.com with ESMTPSA id n69sm2477676pfd.132.2021.06.10.05.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 05:16:42 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 2/3] gpio: virtio: Add IRQ support
Date: Thu, 10 Jun 2021 17:46:33 +0530
Message-Id: <911941d4bf19f18abdc9700abca9f26b3c04c343.1623326176.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623326176.git.viresh.kumar@linaro.org>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-gpio@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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

This patch adds IRQ support for the virtio GPIO driver. Note that this
uses the irq_bus_lock/unlock() callbacks since the operations over
virtio can sleep.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpio-virtio.c       | 256 ++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_gpio.h |  15 ++
 2 files changed, 263 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 1ba8ddf4693a..8bc4b1876961 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -20,6 +20,13 @@
 #include <uapi/linux/virtio_gpio.h>
 #include <uapi/linux/virtio_ids.h>
 
+struct vgpio_line {
+	u8 irq_type;
+	bool irq_type_pending;
+	bool masked;
+	bool masked_pending;
+};
+
 struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock;
@@ -30,14 +37,20 @@ struct virtio_gpio {
 	struct virtio_gpio_request creq;
 	struct virtio_gpio_response cres;
 
+	struct irq_chip *ic;
+	struct vgpio_line *lines;
+	struct virtqueue *interrupt_vq;
+	struct virtio_gpio_request ireq;
+
 	/* This must be kept as the last entry here, hint: gpio_names[0] */
 	struct virtio_gpio_config config;
 };
 
 #define gpio_chip_to_vgpio(chip) container_of(chip, struct virtio_gpio, gc)
+#define irq_data_to_gpio_chip(d) (d->domain->host_data)
 
-static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
-			   u8 txdata, u8 *rxdata)
+static int virtio_gpio_req_unlocked(struct virtio_gpio *vgpio, u16 type,
+				    u16 gpio, u8 txdata, u8 *rxdata)
 {
 	struct virtio_gpio_response *res = &vgpio->cres;
 	struct virtio_gpio_request *req = &vgpio->creq;
@@ -56,11 +69,10 @@ static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
 	sgs[0] = &req_sg;
 	sgs[1] = &res_sg;
 
-	mutex_lock(&vgpio->lock);
 	ret = virtqueue_add_sgs(vgpio->command_vq, sgs, 1, 1, res, GFP_KERNEL);
 	if (ret) {
 		dev_err(dev, "failed to add request to vq\n");
-		goto out;
+		return ret;
 	}
 
 	reinit_completion(&vgpio->completion);
@@ -81,7 +93,16 @@ static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
 	if (rxdata)
 		*rxdata = res->data;
 
-out:
+	return ret;
+}
+
+static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
+			   u8 txdata, u8 *rxdata)
+{
+	int ret;
+
+	mutex_lock(&vgpio->lock);
+	ret = virtio_gpio_req_unlocked(vgpio, type, gpio, txdata, rxdata);
 	mutex_unlock(&vgpio->lock);
 
 	return ret;
@@ -152,6 +173,183 @@ static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_SET_VALUE, gpio, value, NULL);
 }
 
+/* Interrupt handling */
+static void vgpio_irq_mask(struct virtio_gpio *vgpio, u16 gpio)
+{
+	int ret;
+
+	ret = virtio_gpio_req_unlocked(vgpio, VIRTIO_GPIO_REQ_IRQ_MASK, gpio, 0,
+				       NULL);
+	if (ret)
+		dev_err(&vgpio->vdev->dev, "failed to mask irq: %d\n", ret);
+}
+
+static void vgpio_irq_unmask(struct virtio_gpio *vgpio, u16 gpio)
+{
+	int ret;
+
+	ret = virtio_gpio_req_unlocked(vgpio, VIRTIO_GPIO_REQ_IRQ_UNMASK, gpio,
+				       0, NULL);
+	if (ret)
+		dev_err(&vgpio->vdev->dev, "failed to unmask irq: %d\n", ret);
+}
+
+static void vgpio_irq_set_type(struct virtio_gpio *vgpio, u16 gpio, u8 type)
+{
+	int ret;
+
+	ret = virtio_gpio_req_unlocked(vgpio, VIRTIO_GPIO_REQ_IRQ_TYPE, gpio,
+				       type, NULL);
+	if (ret)
+		dev_err(&vgpio->vdev->dev, "failed to set irq type: %d\n", ret);
+}
+
+static void virtio_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_to_gpio_chip(d);
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	struct vgpio_line *line = &vgpio->lines[d->hwirq];
+
+	line->masked = true;
+	line->masked_pending = true;
+}
+
+static void virtio_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_to_gpio_chip(d);
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	struct vgpio_line *line = &vgpio->lines[d->hwirq];
+
+	line->masked = false;
+	line->masked_pending = true;
+}
+
+static int virtio_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_to_gpio_chip(d);
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	struct vgpio_line *line = &vgpio->lines[d->hwirq];
+	u8 irq_type;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_NONE;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type = VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		dev_err(&vgpio->vdev->dev, "unsupported irq type: %u\n", type);
+		return -EINVAL;
+	}
+
+	line->irq_type = irq_type;
+	line->irq_type_pending = true;
+
+	return 0;
+}
+
+static void virtio_gpio_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_to_gpio_chip(d);
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	mutex_lock(&vgpio->lock);
+}
+
+static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_to_gpio_chip(d);
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	struct vgpio_line *line = &vgpio->lines[d->hwirq];
+
+	if (line->irq_type_pending) {
+		vgpio_irq_set_type(vgpio, d->hwirq, line->irq_type);
+		line->irq_type_pending = false;
+	}
+
+	if (line->masked_pending) {
+		if (line->masked)
+			vgpio_irq_mask(vgpio, d->hwirq);
+		else
+			vgpio_irq_unmask(vgpio, d->hwirq);
+		line->masked_pending = false;
+	}
+
+	mutex_unlock(&vgpio->lock);
+}
+
+static void virtio_gpio_interrupt_prepare(struct virtio_gpio *vgpio)
+{
+	struct scatterlist sg[1];
+
+	/* Clear request buffer */
+	vgpio->ireq.type = 0;
+	vgpio->ireq.gpio = vgpio->config.ngpio;
+
+	sg_init_one(sg, &vgpio->ireq, sizeof(vgpio->ireq));
+	virtqueue_add_inbuf(vgpio->interrupt_vq, sg, 1, vgpio, GFP_KERNEL);
+	virtqueue_kick(vgpio->interrupt_vq);
+}
+
+static void virtio_gpio_interrupt(struct virtqueue *vq)
+{
+	struct virtio_gpio *vgpio = vq->vdev->priv;
+	struct device *dev = &vq->vdev->dev;
+	unsigned int len;
+	int irq, gpio, ret;
+	void *data;
+
+	data = virtqueue_get_buf(vgpio->interrupt_vq, &len);
+	if (!data || !len) {
+		dev_warn(dev, "No data received on interrupt\n");
+		return;
+	}
+
+	if (WARN_ON(data != vgpio))
+		return;
+
+	if (le16_to_cpu(vgpio->ireq.type) != VIRTIO_GPIO_REQ_IRQ_EVENT) {
+		dev_warn(dev, "Invalid irq-type: %d\n", vgpio->ireq.type);
+		goto out;
+	}
+
+	gpio = le16_to_cpu(vgpio->ireq.gpio);
+
+	if (gpio >= vgpio->config.ngpio) {
+		dev_warn(dev, "Invalid GPIO number: %d\n", gpio);
+		goto out;
+	}
+
+	irq = irq_find_mapping(vgpio->gc.irq.domain, gpio);
+	if (!irq) {
+		dev_err(dev, "Failed to find IRQ for gpio: %d\n", gpio);
+		goto out;
+	}
+
+	local_irq_disable();
+	ret = generic_handle_irq(irq);
+	local_irq_enable();
+
+	if (ret)
+		dev_err(dev, "failed to invoke irq handler\n");
+
+out:
+	virtio_gpio_interrupt_prepare(vgpio);
+}
+
 static void virtio_gpio_command(struct virtqueue *vq)
 {
 	struct virtio_gpio *vgpio = vq->vdev->priv;
@@ -162,14 +360,15 @@ static void virtio_gpio_command(struct virtqueue *vq)
 static int virtio_gpio_alloc_vqs(struct virtio_device *vdev)
 {
 	struct virtio_gpio *vgpio = vdev->priv;
-	const char * const names[] = { "command" };
+	const char * const names[] = { "command", "interrupt" };
 	vq_callback_t *cbs[] = {
 		virtio_gpio_command,
+		virtio_gpio_interrupt,
 	};
-	struct virtqueue *vqs[1] = {NULL};
+	struct virtqueue *vqs[2] = {NULL};
 	int ret;
 
-	ret = virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
+	ret = virtio_find_vqs(vdev, vgpio->ic ? 2 : 1, vqs, cbs, names, NULL);
 	if (ret) {
 		dev_err(&vdev->dev, "failed to allocate vqs: %d\n", ret);
 		return ret;
@@ -177,6 +376,13 @@ static int virtio_gpio_alloc_vqs(struct virtio_device *vdev)
 
 	vgpio->command_vq = vqs[0];
 
+	if (vgpio->ic) {
+		vgpio->interrupt_vq = vqs[1];
+
+		virtio_gpio_interrupt_prepare(vgpio);
+		virtqueue_enable_cb(vgpio->interrupt_vq);
+	}
+
 	/* Mark the device ready to perform operations from within probe() */
 	virtio_device_ready(vgpio->vdev);
 	return 0;
@@ -278,6 +484,34 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	if (IS_ERR(vgpio->gc.names))
 		return PTR_ERR(vgpio->gc.names);
 
+	if (virtio_has_feature(vdev, VIRTIO_GPIO_F_IRQ)) {
+		vgpio->lines = devm_kcalloc(dev, config->ngpio,
+					    sizeof(*vgpio->lines), GFP_KERNEL);
+		if (!vgpio->lines)
+			return -ENOMEM;
+
+		vgpio->ic = devm_kzalloc(dev, sizeof(*vgpio->ic), GFP_KERNEL);
+		if (!vgpio->ic)
+			return -ENOMEM;
+
+		vgpio->gc.irq.chip		= vgpio->ic;
+		vgpio->ic->name			= vgpio->gc.label;
+		vgpio->ic->irq_mask		= virtio_gpio_irq_mask;
+		vgpio->ic->irq_unmask		= virtio_gpio_irq_unmask;
+		vgpio->ic->irq_set_type		= virtio_gpio_irq_set_type;
+
+		/* These are required to implement irqchip for slow busses */
+		vgpio->ic->irq_bus_lock		= virtio_gpio_irq_bus_lock;
+		vgpio->ic->irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock;
+
+		/* The event comes from the outside so no parent handler */
+		vgpio->gc.irq.parent_handler	= NULL;
+		vgpio->gc.irq.num_parents	= 0;
+		vgpio->gc.irq.parents		= NULL;
+		vgpio->gc.irq.default_type	= IRQ_TYPE_NONE;
+		vgpio->gc.irq.handler		= handle_level_irq;
+	}
+
 	vdev->priv = vgpio;
 	mutex_init(&vgpio->lock);
 	init_completion(&vgpio->completion);
@@ -309,7 +543,13 @@ static const struct virtio_device_id id_table[] = {
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
index e805e33a79cb..533d70d77d2c 100644
--- a/include/uapi/linux/virtio_gpio.h
+++ b/include/uapi/linux/virtio_gpio.h
@@ -5,6 +5,9 @@
 
 #include <linux/types.h>
 
+/* Virtio GPIO Feature bits */
+#define VIRTIO_GPIO_F_IRQ			0
+
 /* Virtio GPIO request types */
 #define VIRTIO_GPIO_REQ_ACTIVATE		0x01
 #define VIRTIO_GPIO_REQ_DEACTIVATE		0x02
@@ -13,6 +16,18 @@
 #define VIRTIO_GPIO_REQ_DIRECTION_OUT		0x05
 #define VIRTIO_GPIO_REQ_GET_VALUE		0x06
 #define VIRTIO_GPIO_REQ_SET_VALUE		0x07
+#define VIRTIO_GPIO_REQ_IRQ_TYPE		0x08
+#define VIRTIO_GPIO_REQ_IRQ_MASK		0x09
+#define VIRTIO_GPIO_REQ_IRQ_UNMASK		0x0a
+#define VIRTIO_GPIO_REQ_IRQ_EVENT		0x0b
+
+/* Virtio GPIO IRQ types */
+#define VIRTIO_GPIO_IRQ_TYPE_NONE		0x00
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING	0x01
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING	0x02
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH		0x03
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH		0x04
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW		0x08
 
 /* Possible values of the status field */
 #define VIRTIO_GPIO_STATUS_OK			0x0
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
