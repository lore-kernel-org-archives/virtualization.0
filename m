Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD10C4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 11:37:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCAF60F48
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 11:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FCAF60F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCC80402CF;
	Tue,  3 Aug 2021 11:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kPj5b5Ybiub; Tue,  3 Aug 2021 11:37:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B263400E0;
	Tue,  3 Aug 2021 11:37:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16EF2C001A;
	Tue,  3 Aug 2021 11:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D65DCC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C615B4041C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XO1E9WSrpv63
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C80DF400B0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 11:37:15 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so3400527pjr.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i7LP9VymYRz80S9WWmHEF1AdO+nEbwJaCwGTuCODBOg=;
 b=yBWU/y0EUvzRkCmQLhb0YtQ+Yx/wsEHfvqm8bCrzU2EUvF+pk+U2MZbP/GTdxCdX+O
 GivyLUihVssT3o4ijy/kSf8w4W2EYCahC3M8m5dYBFCjaUIcCdcdGfk5oGtVftMyPzc9
 Se4ses4VUYKiTbaIVSCmFX4MjpwbD/+7I9dXBj2SRRYlwIjYOSf8hmoW1P3ssokiKTfR
 3QQLWZcBFXc1bQnKsadiYv2ioLGWgtMwnFX7B1EkQEmLVnpS7YWePpz7JUT8LQkI1Ifq
 M/fz4KlhWf2remjSUZly5R/+5aXfKGbDed3xYT4jtK31mRHoDAkBel+7fPbfHdqPmFw0
 qnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i7LP9VymYRz80S9WWmHEF1AdO+nEbwJaCwGTuCODBOg=;
 b=IZbnXlSnkXWT3D7yPsOO5vhQJLSKy02SZQLxCwupY8zBTDQlvIh/y5Z8YKTK/nyzLV
 l1bBN3SAyvzQ+xDIHJDBpzt4vVj0a7mtmH6qdbttjPQ4zynAbLlSld086kSUiUJ+3lIA
 QM1BVb0ngYePzfXfO06V0DvCefYWt9hXQgNtcwggteIhGRON9SZ5ZNwH3gI9fQ5PyHHr
 RLsLdWdFuFs0FbjdJFQzZk1+kvCqK+WG3qdyw47aoJVQDniGRxwWuLnXWbmxj0tKGQOq
 V5zN5UYdeLnUOZ1wdFCc8wJuDwxIcNASvlimG64pGUv7hYIty7Wji8mMdo0Xoz752tou
 tofA==
X-Gm-Message-State: AOAM531w3/5qsdNBRzb5xjyj+fG4JD8RAh7dPLvOWwLV/YwVJVLN7dH9
 o3MslBPfh9a0G3AD/csth7dPJA==
X-Google-Smtp-Source: ABdhPJyQiKylFLyz1ma0UvAvlGhGpNomud8jqRera3tsNxxNuVTCDBxz9MsiJTb+W3EB7z3GpY/fgw==
X-Received: by 2002:a62:27c2:0:b029:3c1:dd9:4132 with SMTP id
 n185-20020a6227c20000b02903c10dd94132mr7009731pfn.58.1627990635224; 
 Tue, 03 Aug 2021 04:37:15 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id e12sm15426295pfc.214.2021.08.03.04.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 04:37:14 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 1/2] gpio: Add virtio-gpio driver
Date: Tue,  3 Aug 2021 17:06:55 +0530
Message-Id: <e658ffd7d7e80191a63d15e102d55999ca50571c.1627989586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627989586.git.viresh.kumar@linaro.org>
References: <cover.1627989586.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stratos-dev@op-lists.linaro.org
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

This patch adds a new driver for Virtio based GPIO devices.

This allows a guest VM running Linux to access GPIO lines provided by
the host. It supports all basic operations, except interrupts for the
GPIO lines.

Based on the initial work posted by:
"Enrico Weigelt, metux IT consult" <lkml@metux.net>.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Enrico, lemme know if you want me to add your co-developed by and
signed-off-by. Didn't want to add without checking with you first.
---
 MAINTAINERS                      |   7 +
 drivers/gpio/Kconfig             |   9 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-virtio.c       | 375 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  47 ++++
 5 files changed, 439 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..f632acd7d98c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19647,6 +19647,13 @@ F:	Documentation/filesystems/virtiofs.rst
 F:	fs/fuse/virtio_fs.c
 F:	include/uapi/linux/virtio_fs.h
 
+VIRTIO GPIO DRIVER
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+M:	Viresh Kumar <vireshk@kernel.org>
+S:	Maintained
+F:	drivers/gpio/gpio-virtio.c
+F:	include/uapi/linux/virtio_gpio.h
+
 VIRTIO GPU DRIVER
 M:	David Airlie <airlied@linux.ie>
 M:	Gerd Hoffmann <kraxel@redhat.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fab571016adf..e5993d6864fb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1669,6 +1669,15 @@ config GPIO_MOCKUP
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
index 32a32659866a..e0301cfedd8d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_GPIO_UCB1400)		+= gpio-ucb1400.o
 obj-$(CONFIG_GPIO_UNIPHIER)		+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
+obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
 obj-$(CONFIG_GPIO_VR41XX)		+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
new file mode 100644
index 000000000000..3ed4240fe670
--- /dev/null
+++ b/drivers/gpio/gpio-virtio.c
@@ -0,0 +1,375 @@
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
+struct virtio_gpio_line {
+	struct mutex lock; /* Protects line operation */
+	struct completion completion;
+	struct virtio_gpio_request req;
+	struct virtio_gpio_response res;
+	unsigned int rxlen;
+};
+
+struct virtio_gpio {
+	struct virtio_device *vdev;
+	struct mutex lock; /* Protects virtqueue operation */
+	struct gpio_chip gc;
+	struct virtio_gpio_config config;
+	struct virtio_gpio_line *lines;
+	struct virtqueue *request_vq;
+};
+
+static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
+			    u8 txvalue, u8 *rxvalue, void *response, u32 rxlen)
+{
+	struct virtio_gpio_line *line = &vgpio->lines[gpio];
+	struct virtio_gpio_request *req = &line->req;
+	struct virtio_gpio_response *res = response;
+	struct scatterlist *sgs[2], req_sg, res_sg;
+	struct device *dev = &vgpio->vdev->dev;
+	int ret;
+
+	/*
+	 * Prevent multiple concurrent requests for the same line since we have
+	 * pre-allocated request/response buffers for each GPIO line. Moreover
+	 * Linux always accesses a GPIO line sequentially, so this locking shall
+	 * always go through without any delays.
+	 */
+	mutex_lock(&line->lock);
+
+	req->type = cpu_to_le16(type);
+	req->gpio = cpu_to_le16(gpio);
+	req->value = txvalue;
+
+	sg_init_one(&req_sg, req, sizeof(*req));
+	sg_init_one(&res_sg, res, rxlen);
+	sgs[0] = &req_sg;
+	sgs[1] = &res_sg;
+
+	line->rxlen = 0;
+	reinit_completion(&line->completion);
+
+	/*
+	 * Virtqueue callers need to ensure they don't call its APIs with other
+	 * virtqueue operations at the same time.
+	 */
+	mutex_lock(&vgpio->lock);
+	ret = virtqueue_add_sgs(vgpio->request_vq, sgs, 1, 1, line, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to add request to vq\n");
+		mutex_unlock(&vgpio->lock);
+		goto out;
+	}
+
+	virtqueue_kick(vgpio->request_vq);
+	mutex_unlock(&vgpio->lock);
+
+	if (!wait_for_completion_timeout(&line->completion, HZ)) {
+		dev_err(dev, "GPIO operation timed out\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
+		dev_err(dev, "GPIO request failed: %d\n", gpio);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (unlikely(line->rxlen != rxlen)) {
+		dev_err(dev, "GPIO operation returned incorrect len (%u : %u)\n",
+			rxlen, line->rxlen);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (rxvalue)
+		*rxvalue = res->value;
+
+out:
+	mutex_unlock(&line->lock);
+	return ret;
+}
+
+static int virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
+			   u8 txvalue, u8 *rxvalue)
+{
+	struct virtio_gpio_line *line = &vgpio->lines[gpio];
+	struct virtio_gpio_response *res = &line->res;
+
+	return _virtio_gpio_req(vgpio, type, gpio, txvalue, rxvalue, res,
+				sizeof(*res));
+}
+
+static void virtio_gpio_free(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+
+	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_DIRECTION, gpio,
+			VIRTIO_GPIO_DIRECTION_NONE, NULL);
+}
+
+static int virtio_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	u8 direction;
+	int ret;
+
+	ret = virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_GET_DIRECTION, gpio, 0,
+			      &direction);
+	if (ret)
+		return ret;
+
+	switch (direction) {
+	case VIRTIO_GPIO_DIRECTION_IN:
+		return GPIO_LINE_DIRECTION_IN;
+	case VIRTIO_GPIO_DIRECTION_OUT:
+		return GPIO_LINE_DIRECTION_OUT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int virtio_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_DIRECTION, gpio,
+			       VIRTIO_GPIO_DIRECTION_IN, NULL);
+}
+
+static int virtio_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
+					int value)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	int ret;
+
+	ret = virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value, NULL);
+	if (ret)
+		return ret;
+
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_DIRECTION, gpio,
+			       VIRTIO_GPIO_DIRECTION_OUT, NULL);
+}
+
+static int virtio_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+	u8 value;
+	int ret;
+
+	ret = virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_GET_VALUE, gpio, 0, &value);
+	return ret ? ret : value;
+}
+
+static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
+
+	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value, NULL);
+}
+
+static void virtio_gpio_request_vq(struct virtqueue *vq)
+{
+	struct virtio_gpio_line *line;
+	unsigned int len;
+
+	do {
+		line = virtqueue_get_buf(vq, &len);
+		if (!line)
+			return;
+
+		line->rxlen = len;
+		complete(&line->completion);
+	} while (1);
+}
+
+static void virtio_gpio_free_vqs(struct virtio_device *vdev)
+{
+	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
+				 struct virtio_device *vdev)
+{
+	const char * const names[] = { "requestq" };
+	vq_callback_t *cbs[] = {
+		virtio_gpio_request_vq,
+	};
+	struct virtqueue *vqs[1] = { NULL };
+	int ret;
+
+	ret = virtio_find_vqs(vdev, 1, vqs, cbs, names, NULL);
+	if (ret) {
+		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
+		return ret;
+	}
+
+	if (!vqs[0]) {
+		dev_err(&vdev->dev, "failed to find requestq vq\n");
+		return -ENODEV;
+	}
+	vgpio->request_vq = vqs[0];
+
+	return 0;
+}
+
+static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
+{
+	struct virtio_gpio_config *config = &vgpio->config;
+	struct virtio_gpio_response_get_names *res;
+	struct device *dev = &vgpio->vdev->dev;
+	u8 *gpio_names, *str;
+	const char **names;
+	int i, ret, len;
+
+	if (!config->gpio_names_size)
+		return NULL;
+
+	len = sizeof(*res) + config->gpio_names_size;
+	res = devm_kzalloc(dev, len, GFP_KERNEL);
+	if (!res)
+		return NULL;
+	gpio_names = res->value;
+
+	ret = _virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_GET_NAMES, 0, 0, NULL,
+			       res, len);
+	if (ret) {
+		dev_err(dev, "Failed to get GPIO names: %d\n", ret);
+		return NULL;
+	}
+
+	names = devm_kcalloc(dev, config->ngpio, sizeof(names), GFP_KERNEL);
+	if (!names)
+		return NULL;
+
+	/* NULL terminate the string instead of checking it */
+	gpio_names[config->gpio_names_size - 1] = '\0';
+
+	for (i = 0, str = gpio_names; i < config->ngpio; i++) {
+		names[i] = str;
+		str += strlen(str) + 1; /* zero-length strings are allowed */
+
+		if (str > gpio_names + config->gpio_names_size) {
+			dev_err(dev, "gpio_names block is too short (%d)\n", i);
+			return NULL;
+		}
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
+	int ret, i;
+
+	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
+	if (!vgpio)
+		return -ENOMEM;
+
+	config = &vgpio->config;
+
+	/* Read configuration */
+	virtio_cread_bytes(vdev, 0, config, sizeof(*config));
+	config->gpio_names_size = le32_to_cpu(config->gpio_names_size);
+	config->ngpio = le16_to_cpu(config->ngpio);
+	if (!config->ngpio) {
+		dev_err(dev, "Number of GPIOs can't be zero\n");
+		return -EINVAL;
+	}
+
+	vgpio->lines = devm_kcalloc(dev, config->ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
+	if (!vgpio->lines)
+		return -ENOMEM;
+
+	for (i = 0; i < config->ngpio; i++) {
+		mutex_init(&vgpio->lines[i].lock);
+		init_completion(&vgpio->lines[i].completion);
+	}
+
+	mutex_init(&vgpio->lock);
+	vdev->priv = vgpio;
+
+	vgpio->vdev			= vdev;
+	vgpio->gc.free			= virtio_gpio_free;
+	vgpio->gc.get_direction		= virtio_gpio_get_direction;
+	vgpio->gc.direction_input	= virtio_gpio_direction_input;
+	vgpio->gc.direction_output	= virtio_gpio_direction_output;
+	vgpio->gc.get			= virtio_gpio_get;
+	vgpio->gc.set			= virtio_gpio_set;
+	vgpio->gc.ngpio			= config->ngpio;
+	vgpio->gc.base			= -1; /* Allocate base dynamically */
+	vgpio->gc.label			= dev_name(dev);
+	vgpio->gc.parent		= dev;
+	vgpio->gc.owner			= THIS_MODULE;
+	vgpio->gc.can_sleep		= true;
+
+	ret = virtio_gpio_alloc_vqs(vgpio, vdev);
+	if (ret)
+		return ret;
+
+	/* Mark the device ready to perform operations from within probe() */
+	virtio_device_ready(vdev);
+
+	vgpio->gc.names = virtio_gpio_get_names(vgpio);
+
+	ret = gpiochip_add_data(&vgpio->gc, vgpio);
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
index 000000000000..844574acf095
--- /dev/null
+++ b/include/uapi/linux/virtio_gpio.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _LINUX_VIRTIO_GPIO_H
+#define _LINUX_VIRTIO_GPIO_H
+
+#include <linux/types.h>
+
+/* Virtio GPIO request types */
+#define VIRTIO_GPIO_MSG_GET_NAMES		0x0001
+#define VIRTIO_GPIO_MSG_GET_DIRECTION		0x0002
+#define VIRTIO_GPIO_MSG_SET_DIRECTION		0x0003
+#define VIRTIO_GPIO_MSG_GET_VALUE		0x0004
+#define VIRTIO_GPIO_MSG_SET_VALUE		0x0005
+
+/* Possible values of the status field */
+#define VIRTIO_GPIO_STATUS_OK			0x0
+#define VIRTIO_GPIO_STATUS_ERR			0x1
+
+/* Direction types */
+#define VIRTIO_GPIO_DIRECTION_NONE		0x00
+#define VIRTIO_GPIO_DIRECTION_OUT		0x01
+#define VIRTIO_GPIO_DIRECTION_IN		0x02
+
+struct virtio_gpio_config {
+	__u16 ngpio;
+	__u8 padding[2];
+	__u32 gpio_names_size;
+} __packed;
+
+/* Virtio GPIO Request / Response */
+struct virtio_gpio_request {
+	__u16 type;
+	__u16 gpio;
+	__u32 value;
+};
+
+struct virtio_gpio_response {
+	__u8 status;
+	__u8 value;
+};
+
+struct virtio_gpio_response_get_names {
+	__u8 status;
+	__u8 value[];
+};
+
+#endif /* _LINUX_VIRTIO_GPIO_H */
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
