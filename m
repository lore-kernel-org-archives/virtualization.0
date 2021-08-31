Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD85C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 05:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C626101C
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 05:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5C626101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 801F560B9D;
	Tue, 31 Aug 2021 05:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MskTjHq5tQwC; Tue, 31 Aug 2021 05:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5D0260B94;
	Tue, 31 Aug 2021 05:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5C31C001A;
	Tue, 31 Aug 2021 05:29:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0BBFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E82A780CED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTq2CD7mF8k6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:29:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FF5E80C3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:29:32 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id n18so15566510pgm.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jFcTPdCtyitTZJIxV4LdmuAXMlqcd0E1IFXZnG1zNlc=;
 b=qtuqrUWrX0xG1t+1moMNCudmKDWrljvH+h661ddNymptPT+bedvPZFIhW2u+cLE9rT
 fsbl5TDmqhYHOunrx7JmBaXMyx0y6xscctRtg0abpImTCXnVVi9TSdeQ61shoW586QpN
 MKSiPMr0gYtETNQtabGq98xtmIplvAs4vv1xSWc6D4FBLUyK+f6PuQz7QZUFy7Mlgj40
 aBZDYdU5Pb/zQwDeujPYsOfrzass1O3pXIVoagyAqIS8YZBKHlnpVJoMcF5UMRE0ih3H
 wqmguIQJHwKUVVI7Q3JcOme1zD1ARSJksO/bP6TguDk/9yK2FYXEVmFSpqjxJAUNgGMb
 MPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jFcTPdCtyitTZJIxV4LdmuAXMlqcd0E1IFXZnG1zNlc=;
 b=NcPUknd4B1A9oimOqwRzS5FeTipJLTECN7pls+Xk6qky1q0RcpHf2UU8FBvsd1lHX0
 CA6Gpwb/+FgLVWp43TUOcLLgGlKuSNZ1JXZ6EXq/qdi9DQJ5B+PKh5uazAWc2Pt4B4rw
 p9teAe3afZFMZil3Tev6UEORZ6IGk+lFaVJLFgFvQ47m4B8lpMp9WhAK+AYOAA93LR8j
 D5dnIJxmoKg5XLjNGZSFA2BsYV6L6gKK7gPbpxF+Mc93hPLsY3jVB9eC0S+ygN9yya3C
 /pItJV4q15cuiXrCH9LWYe+ClpKc/ddiFhP034MqcAPE9t3QMgXMsNLoiYVXNKtkbeAw
 Sohw==
X-Gm-Message-State: AOAM530v309CqRsPFb/+0x/cGB5pSZKLU1HNGeOfJ2xvyRzgGkkWdGs/
 Sv1I3n54DFnDMbHCHIpuSHoMBg==
X-Google-Smtp-Source: ABdhPJzEvCEb7zzZIjZLgHKvGKWo8op/2Aby3r18tLBO9CS1c/y0W2sautmFMxGJTrSbLhSpWBNHmw==
X-Received: by 2002:a62:1453:0:b0:3fd:ffd5:35cf with SMTP id
 80-20020a621453000000b003fdffd535cfmr10488051pfu.34.1630387772432; 
 Mon, 30 Aug 2021 22:29:32 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id q18sm16584356pfj.46.2021.08.30.22.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 22:29:31 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] gpio: virtio: Fix sparse warnings
Date: Tue, 31 Aug 2021 10:59:25 +0530
Message-Id: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 kernel test robot <lkp@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-gpio@vger.kernel.org
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

Fix warnings reported by sparse, related to type mismatch between u16
and __le16.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpio-virtio.c       | 41 ++++++++++++++++----------------
 include/uapi/linux/virtio_gpio.h | 10 ++++----
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index d33eb237c0b9..d24f1c9264bc 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -32,7 +32,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_config config;
 	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;
 };
@@ -57,7 +56,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
 
 	req->type = cpu_to_le16(type);
 	req->gpio = cpu_to_le16(gpio);
-	req->value = txvalue;
+	req->value = cpu_to_le32(txvalue);
 
 	sg_init_one(&req_sg, req, sizeof(*req));
 	sg_init_one(&res_sg, res, rxlen);
@@ -233,19 +232,19 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 	return 0;
 }
 
-static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
+static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
+					  u32 gpio_names_size, u16 ngpio)
 {
-	struct virtio_gpio_config *config = &vgpio->config;
 	struct virtio_gpio_response_get_names *res;
 	struct device *dev = &vgpio->vdev->dev;
 	u8 *gpio_names, *str;
 	const char **names;
 	int i, ret, len;
 
-	if (!config->gpio_names_size)
+	if (!gpio_names_size)
 		return NULL;
 
-	len = sizeof(*res) + config->gpio_names_size;
+	len = sizeof(*res) + gpio_names_size;
 	res = devm_kzalloc(dev, len, GFP_KERNEL);
 	if (!res)
 		return NULL;
@@ -258,18 +257,18 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
 		return NULL;
 	}
 
-	names = devm_kcalloc(dev, config->ngpio, sizeof(*names), GFP_KERNEL);
+	names = devm_kcalloc(dev, ngpio, sizeof(*names), GFP_KERNEL);
 	if (!names)
 		return NULL;
 
 	/* NULL terminate the string instead of checking it */
-	gpio_names[config->gpio_names_size - 1] = '\0';
+	gpio_names[gpio_names_size - 1] = '\0';
 
-	for (i = 0, str = gpio_names; i < config->ngpio; i++) {
+	for (i = 0, str = gpio_names; i < ngpio; i++) {
 		names[i] = str;
 		str += strlen(str) + 1; /* zero-length strings are allowed */
 
-		if (str > gpio_names + config->gpio_names_size) {
+		if (str > gpio_names + gpio_names_size) {
 			dev_err(dev, "gpio_names block is too short (%d)\n", i);
 			return NULL;
 		}
@@ -280,31 +279,31 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config *config;
+	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
+	u32 gpio_names_size;
+	u16 ngpio;
 	int ret, i;
 
 	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
 	if (!vgpio)
 		return -ENOMEM;
 
-	config = &vgpio->config;
-
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, config, sizeof(*config));
-	config->gpio_names_size = le32_to_cpu(config->gpio_names_size);
-	config->ngpio = le16_to_cpu(config->ngpio);
-	if (!config->ngpio) {
+	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
+	gpio_names_size = le32_to_cpu(config.gpio_names_size);
+	ngpio = le16_to_cpu(config.ngpio);
+	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
 	}
 
-	vgpio->lines = devm_kcalloc(dev, config->ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
+	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
 	if (!vgpio->lines)
 		return -ENOMEM;
 
-	for (i = 0; i < config->ngpio; i++) {
+	for (i = 0; i < ngpio; i++) {
 		mutex_init(&vgpio->lines[i].lock);
 		init_completion(&vgpio->lines[i].completion);
 	}
@@ -319,7 +318,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	vgpio->gc.direction_output	= virtio_gpio_direction_output;
 	vgpio->gc.get			= virtio_gpio_get;
 	vgpio->gc.set			= virtio_gpio_set;
-	vgpio->gc.ngpio			= config->ngpio;
+	vgpio->gc.ngpio			= ngpio;
 	vgpio->gc.base			= -1; /* Allocate base dynamically */
 	vgpio->gc.label			= dev_name(dev);
 	vgpio->gc.parent		= dev;
@@ -333,7 +332,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	/* Mark the device ready to perform operations from within probe() */
 	virtio_device_ready(vdev);
 
-	vgpio->gc.names = virtio_gpio_get_names(vgpio);
+	vgpio->gc.names = virtio_gpio_get_names(vgpio, gpio_names_size, ngpio);
 
 	ret = gpiochip_add_data(&vgpio->gc, vgpio);
 	if (ret) {
diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
index 844574acf095..0445f905d8cc 100644
--- a/include/uapi/linux/virtio_gpio.h
+++ b/include/uapi/linux/virtio_gpio.h
@@ -22,16 +22,16 @@
 #define VIRTIO_GPIO_DIRECTION_IN		0x02
 
 struct virtio_gpio_config {
-	__u16 ngpio;
+	__le16 ngpio;
 	__u8 padding[2];
-	__u32 gpio_names_size;
+	__le32 gpio_names_size;
 } __packed;
 
 /* Virtio GPIO Request / Response */
 struct virtio_gpio_request {
-	__u16 type;
-	__u16 gpio;
-	__u32 value;
+	__le16 type;
+	__le16 gpio;
+	__le32 value;
 };
 
 struct virtio_gpio_response {
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
