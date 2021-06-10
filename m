Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD6C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:16:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD5C60FDB
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD5C60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21032405D5;
	Thu, 10 Jun 2021 12:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id accl6mfjKMZ5; Thu, 10 Jun 2021 12:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B7A4C40514;
	Thu, 10 Jun 2021 12:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF40C000E;
	Thu, 10 Jun 2021 12:16:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF90C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3ADEB6084C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kiq9hcSDiOwE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3673F607D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:16:39 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id e1so902042pld.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wOu3fDG+mFoQYcon/7H3S12nd7R/QAMh1wpiZegcxiw=;
 b=rRdA3EI31LXvnOC+g6aCM6DuO0S2PmQp7rld4OmfNnfkRQYt5aXM5niEdn4EuLPn4/
 CazA3pRWpK7Mp4DFm3IhRJHyhVGPTG+pjfstJyxs2bfcQQ2qKV1Rj8iPUgAek0gWNnqX
 nAsQVH5Y/FUtRGKLScrhSsA17hbYgMsmDOZH7wwNBlY3asySna88wdc1VPv8gAZ19hAf
 RDb0R0BFQhonAN31caUKp9BjXMcWGN690vFEXEJMtxiPB95XXatF1V7s6GLVQ2JnqWu5
 Bn6hEd6o6kfjTM+/Lpd1pvuCWEfT4KMIF55SQa3/rlJfHTxdB2bTHy6DA1rMV4eHnt4D
 U6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wOu3fDG+mFoQYcon/7H3S12nd7R/QAMh1wpiZegcxiw=;
 b=cm9yd2gF4Gf/EVPWTQzOxmcrliJhGV63i0DdCLW8wRCci7hsStjdKMzYd6obKGHIc8
 oylTNwjZWck3xPbQPXqk1VZ6aLPjuNKnYB0X+FVZ6WNQRxdjKZw9wwYUhwFlNGieiD/2
 vQfaxoH+UizCBP28gH38D6NSi3/yzi6kO5zhSDn4j/KFR31PXc2geaiqEeuBUcLNiiSc
 hYn03Q31e97goanR2jSkdbJqAeE+/yyb16rRsRgqnjqs3pMVFYhgtCbNaLfOXG7L6+jE
 95y881yh4V84/kyJf9VcNpZbgE61gDUCsLjTMRMbA5FwRyGYK/o4WEy35rbJ8T6lSppu
 hYAA==
X-Gm-Message-State: AOAM530nZsQ2jfaniPw3YbiDCK/+iGMLwq8ptagAeawFKwtsEzopcDeL
 o5eBRozF8mqqZftdMoNmqAO1iw==
X-Google-Smtp-Source: ABdhPJyCSGKmtTnZqbuXMjPjzsWE3+hnB+b0w2VauqA1bWDMsis5W3vEtGjU9EKzYfZVIE/WfAN4cw==
X-Received: by 2002:a17:90b:4f44:: with SMTP id
 pj4mr3029377pjb.97.1623327398442; 
 Thu, 10 Jun 2021 05:16:38 -0700 (PDT)
Received: from localhost ([136.185.169.128])
 by smtp.gmail.com with ESMTPSA id kb14sm1720723pjb.2.2021.06.10.05.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 05:16:37 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Date: Thu, 10 Jun 2021 17:46:32 +0530
Message-Id: <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
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

From: "Enrico Weigelt, metux IT consult" <info@metux.net>

This patch adds a new driver for Virtio based GPIO devices.

This allows a guest VM running Linux to access GPIO device provided by
the host. It supports all basic operations for now, except interrupts
for the GPIO lines.

Signed-off-by: "Enrico Weigelt, metux IT consult" <info@metux.net>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/Kconfig             |   9 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-virtio.c       | 326 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  41 ++++
 include/uapi/linux/virtio_ids.h  |   1 +
 5 files changed, 378 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e3607ec4c2e8..7f12fb65d130 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1633,6 +1633,15 @@ config GPIO_MOCKUP
 	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
 	  it.
 
+config GPIO_VIRTIO
+	tristate "VirtIO GPIO support"
+	depends on VIRTIO
+	help
+	  Say Y here to enable guest support for virtio-based GPIO controllers.
+
+	  These virtual GPIOs can be routed to real GPIOs or attached to
+	  simulators on the host (like QEMU).
+
 endmenu
 
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c58a90a3c3b1..ace004c80871 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -162,6 +162,7 @@ obj-$(CONFIG_GPIO_UCB1400)		+= gpio-ucb1400.o
 obj-$(CONFIG_GPIO_UNIPHIER)		+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
+obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
 obj-$(CONFIG_GPIO_VR41XX)		+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
new file mode 100644
index 000000000000..1ba8ddf4693a
--- /dev/null
+++ b/drivers/gpio/gpio-virtio.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * GPIO driver for virtio-based virtual GPIO controllers
+ *
+ * Copyright (C) 2021 metux IT consult
+ * Enrico Weigelt, metux IT consult <info@metux.net>
+ *
+ * Copyright (C) 2021 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/virtio_config.h>
+#include <uapi/linux/virtio_gpio.h>
+#include <uapi/linux/virtio_ids.h>
+
+struct virtio_gpio {
+	struct virtio_device *vdev;
+	struct mutex lock;
+	struct gpio_chip gc;
+
+	struct completion completion;
+	struct virtqueue *command_vq;
+	struct virtio_gpio_request creq;
+	struct virtio_gpio_response cres;
+
+	/* This must be kept as the last entry here, hint: gpio_names[0] */
+	struct virtio_gpio_config config;
+};
+
+#define gpio_chip_to_vgpio(chip) container_of(chip, struct virtio_gpio, gc)
+
+static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
+			   u8 txdata, u8 *rxdata)
+{
+	struct virtio_gpio_response *res = &vgpio->cres;
+	struct virtio_gpio_request *req = &vgpio->creq;
+	struct scatterlist *sgs[2], req_sg, res_sg;
+	struct device *dev = &vgpio->vdev->dev;
+	unsigned long time_left;
+	unsigned int len;
+	int ret;
+
+	req->type = cpu_to_le16(type);
+	req->gpio = cpu_to_le16(gpio);
+	req->data = txdata;
+
+	sg_init_one(&req_sg, req, sizeof(*req));
+	sg_init_one(&res_sg, res, sizeof(*res));
+	sgs[0] = &req_sg;
+	sgs[1] = &res_sg;
+
+	mutex_lock(&vgpio->lock);
+	ret = virtqueue_add_sgs(vgpio->command_vq, sgs, 1, 1, res, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to add request to vq\n");
+		goto out;
+	}
+
+	reinit_completion(&vgpio->completion);
+	virtqueue_kick(vgpio->command_vq);
+
+	time_left = wait_for_completion_timeout(&vgpio->completion, HZ / 10);
+	if (!time_left) {
+		dev_err(dev, "virtio GPIO backend timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	WARN_ON(res != virtqueue_get_buf(vgpio->command_vq, &len));
+	if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
+		dev_err(dev, "virtio GPIO request failed: %d\n", gpio);
+		return -EINVAL;
+	}
+
+	if (rxdata)
+		*rxdata = res->data;
+
+out:
+	mutex_unlock(&vgpio->lock);
+
+	return ret;
+}
+
+static int virtio_gpio_request(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_ACTIVATE, gpio, 0, NULL);
+}
+
+static void virtio_gpio_free(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_DEACTIVATE, gpio, 0, NULL);
+}
+
+static int virtio_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	u8 direction;
+	int ret;
+
+	ret = virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_GET_DIRECTION, gpio, 0,
+			      &direction);
+	if (ret)
+		return ret;
+
+	return direction;
+}
+
+static int virtio_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_DIRECTION_IN, gpio, 0,
+			       NULL);
+}
+
+static int virtio_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
+					int value)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_DIRECTION_OUT, gpio, (u8)
+			       value, NULL);
+}
+
+static int virtio_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+	u8 value;
+	int ret;
+
+	ret = virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_GET_VALUE, gpio, 0, &value);
+	if (ret)
+		return ret;
+
+	return value;
+}
+
+static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct virtio_gpio *vgpio = gpio_chip_to_vgpio(gc);
+
+	virtio_gpio_req(vgpio, VIRTIO_GPIO_REQ_SET_VALUE, gpio, value, NULL);
+}
+
+static void virtio_gpio_command(struct virtqueue *vq)
+{
+	struct virtio_gpio *vgpio = vq->vdev->priv;
+
+	complete(&vgpio->completion);
+}
+
+static int virtio_gpio_alloc_vqs(struct virtio_device *vdev)
+{
+	struct virtio_gpio *vgpio = vdev->priv;
+	const char * const names[] = { "command" };
+	vq_callback_t *cbs[] = {
+		virtio_gpio_command,
+	};
+	struct virtqueue *vqs[1] = {NULL};
+	int ret;
+
+	ret = virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
+	if (ret) {
+		dev_err(&vdev->dev, "failed to allocate vqs: %d\n", ret);
+		return ret;
+	}
+
+	vgpio->command_vq = vqs[0];
+
+	/* Mark the device ready to perform operations from within probe() */
+	virtio_device_ready(vgpio->vdev);
+	return 0;
+}
+
+static void virtio_gpio_free_vqs(struct virtio_device *vdev)
+{
+	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static const char **parse_gpio_names(struct virtio_device *vdev,
+			       struct virtio_gpio_config *config)
+{
+	struct device *dev = &vdev->dev;
+	char *str = config->gpio_names;
+	const char **names;
+	int i, len;
+
+	if (!config->gpio_names_size)
+		return NULL;
+
+	names = devm_kcalloc(dev, config->ngpio, sizeof(names), GFP_KERNEL);
+	if (!names)
+		return ERR_PTR(-ENOMEM);
+
+	/* NULL terminate the string instead of checking it */
+	config->gpio_names[config->gpio_names_size - 1] = '\0';
+
+	for (i = 0; i < config->ngpio; i++) {
+		/*
+		 * We have already marked the last byte with '\0'
+		 * earlier, this shall be enough here.
+		 */
+		if (str == config->gpio_names + config->gpio_names_size) {
+			dev_err(dev, "Invalid gpio_names\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		len = strlen(str);
+		if (!len) {
+			dev_err(dev, "Missing GPIO name: %d\n", i);
+			return ERR_PTR(-EINVAL);
+		}
+
+		names[i] = str;
+		str += len + 1;
+	}
+
+	return names;
+}
+
+static int virtio_gpio_probe(struct virtio_device *vdev)
+{
+	struct virtio_gpio_config *config;
+	struct device *dev = &vdev->dev;
+	struct virtio_gpio *vgpio;
+	u32 size;
+	int ret;
+
+	virtio_cread(vdev, struct virtio_gpio_config, gpio_names_size, &size);
+	size = cpu_to_le32(size);
+
+	vgpio = devm_kzalloc(dev, sizeof(*vgpio) + size, GFP_KERNEL);
+	if (!vgpio)
+		return -ENOMEM;
+
+	config = &vgpio->config;
+
+	/* Read configuration */
+	virtio_cread_bytes(vdev, 0, config, sizeof(*config) + size);
+
+	/* NULL terminate the string instead of checking it */
+	config->name[sizeof(config->name) - 1] = '\0';
+	config->ngpio = cpu_to_le16(config->ngpio);
+	config->gpio_names_size = cpu_to_le32(config->gpio_names_size);
+
+	if (!config->ngpio) {
+		dev_err(dev, "Number of GPIOs can't be zero\n");
+		return -EINVAL;
+	}
+
+	vgpio->vdev			= vdev;
+	vgpio->gc.request		= virtio_gpio_request;
+	vgpio->gc.free			= virtio_gpio_free;
+	vgpio->gc.get_direction		= virtio_gpio_get_direction;
+	vgpio->gc.direction_input	= virtio_gpio_direction_input;
+	vgpio->gc.direction_output	= virtio_gpio_direction_output;
+	vgpio->gc.get			= virtio_gpio_get;
+	vgpio->gc.set			= virtio_gpio_set;
+	vgpio->gc.ngpio			= config->ngpio;
+	vgpio->gc.base			= -1; /* Allocate base dynamically */
+	vgpio->gc.label			= config->name[0] ?
+					  config->name : dev_name(dev);
+	vgpio->gc.parent		= dev;
+	vgpio->gc.owner			= THIS_MODULE;
+	vgpio->gc.can_sleep		= true;
+	vgpio->gc.names			= parse_gpio_names(vdev, config);
+	if (IS_ERR(vgpio->gc.names))
+		return PTR_ERR(vgpio->gc.names);
+
+	vdev->priv = vgpio;
+	mutex_init(&vgpio->lock);
+	init_completion(&vgpio->completion);
+
+	ret = virtio_gpio_alloc_vqs(vdev);
+	if (ret)
+		return ret;
+
+	ret = gpiochip_add(&vgpio->gc);
+	if (ret) {
+		virtio_gpio_free_vqs(vdev);
+		dev_err(dev, "Failed to add virtio-gpio controller\n");
+	}
+
+	return ret;
+}
+
+static void virtio_gpio_remove(struct virtio_device *vdev)
+{
+	struct virtio_gpio *vgpio = vdev->priv;
+
+	gpiochip_remove(&vgpio->gc);
+	virtio_gpio_free_vqs(vdev);
+}
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_GPIO, VIRTIO_DEV_ANY_ID },
+	{},
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_gpio_driver = {
+	.id_table		= id_table,
+	.probe			= virtio_gpio_probe,
+	.remove			= virtio_gpio_remove,
+	.driver			= {
+		.name		= KBUILD_MODNAME,
+		.owner		= THIS_MODULE,
+	},
+};
+module_virtio_driver(virtio_gpio_driver);
+
+MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("VirtIO GPIO driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
new file mode 100644
index 000000000000..e805e33a79cb
--- /dev/null
+++ b/include/uapi/linux/virtio_gpio.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _LINUX_VIRTIO_GPIO_H
+#define _LINUX_VIRTIO_GPIO_H
+
+#include <linux/types.h>
+
+/* Virtio GPIO request types */
+#define VIRTIO_GPIO_REQ_ACTIVATE		0x01
+#define VIRTIO_GPIO_REQ_DEACTIVATE		0x02
+#define VIRTIO_GPIO_REQ_GET_DIRECTION		0x03
+#define VIRTIO_GPIO_REQ_DIRECTION_IN		0x04
+#define VIRTIO_GPIO_REQ_DIRECTION_OUT		0x05
+#define VIRTIO_GPIO_REQ_GET_VALUE		0x06
+#define VIRTIO_GPIO_REQ_SET_VALUE		0x07
+
+/* Possible values of the status field */
+#define VIRTIO_GPIO_STATUS_OK			0x0
+#define VIRTIO_GPIO_STATUS_ERR			0x1
+
+struct virtio_gpio_config {
+	char name[32];
+	__u16 ngpio;
+	__u16 padding;
+	__u32 gpio_names_size;
+	char gpio_names[0];
+} __packed;
+
+/* Virtio GPIO Request / Response */
+struct virtio_gpio_request {
+	__u16 type;
+	__u16 gpio;
+	__u8 data;
+};
+
+struct virtio_gpio_response {
+	__u8 status;
+	__u8 data;
+};
+
+#endif /* _LINUX_VIRTIO_GPIO_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index b89391dff6c9..0c24e8ae2499 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -55,5 +55,6 @@
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
 #define VIRTIO_ID_I2C_ADAPTER		34 /* virtio i2c adapter */
+#define VIRTIO_ID_GPIO			41 /* virtio GPIO */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
