Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A31F3D27
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188192; cv=none; b=CAe41b7Po52jkWOub9hGeKV+wYVK5bf6FcWlng8OeN5jM7af0YnOV63n9w//hrwrbVQBvCqkHLI8mjSQAb/iVHfIepyE0bRqzKrvq9Ea/slDuxTPptQCV4AFkIoWmBWk1PwyfzlLHxmWTrsyPjN9jmGch6U7t88CNRqmWAoXhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188192; c=relaxed/simple;
	bh=LnIWPwlyM/8ENYW81f37MvCRjBLr8uT8Ig1qt/tLfLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGDABF4lEcxa+FEQzK3qF0m3hxsFAI04uWMI7/2mjZ6OZpT4vTBUbDqb78gCVQeMv/XnubjbGY6PMNHFywNorGd4jKT4ouEOHLlsvKhbpicZchAXGaA/3Fgh/NxSo9T0qZYuc7lFvASmXXmhFPVspBJb5d7QzqIci0+OmvrzEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6YfMTRp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6YfMTRp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f648b5214so3973725ad.1
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 03:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739188190; x=1739792990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivq4rOjqcMtcp86r8Le4OyvwVvaLK9Ybknb9whMQ8sw=;
        b=U6YfMTRpj585MD8PvPz4hiCKJXtUaWgBayycajTyKtn5n4WisbEcKLiZSF9KFc20ut
         xSVuG6LAGjBc7MBS9DiNBkfDIqtPsqk6cikF2JpwljY8I2ARYQTpEAcbf2cgpx+aZ44G
         nAeRmfGI5RZ2fxsL/qePXoxec1PzSa4u/S/fR1U99ynPxFyY8opwhKP+hK7UNt6VBcD4
         8YhXKzks4Va8kXag7pGVBF+jDOT30zwre4tEXRuqXu2OZCNYCwvgST7wo82i1i4KCueS
         rPY/U7JsoLi228oIpkWrnJcOGkPeZTe7lkcM7AQBgOnj0boEHS4VUdvnptMmmvtsXYgV
         ie/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188190; x=1739792990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivq4rOjqcMtcp86r8Le4OyvwVvaLK9Ybknb9whMQ8sw=;
        b=KEjQiLaLIVgXFEK1Mc6QzSWNAu9FX9A0Ddk1YWa+xZL0xoleqpqouUz+hSSDLIQhGj
         bmFi1AQmAmuX80eWmrdealAtEzbls/hXkllFtlScLMoe3IDsyeWzsTiI33J6N7UWWOVm
         MKbinvHEGh0sU0dExiFtACfT4YVNi9j5INlyY3FEa7uCVNKnevNb9/t/C4HdUWpAyzTl
         pQyhkAUnn2F+sc0LcWX1oXHGA+5zpAw/gYWWo98bb1KTMJlDH2jID3UyEsqLZp/rWqGM
         6VTfKwSiD+LOVRyzyZ+G+u2HxNu+T0NW42RZmabBiY+1tl0mAfl3Wj48w4fxM6Ld87Zb
         Zq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGw3mejJMXhf/8ZK9K/PMTze9b7/i3jcSUge+m8+ruSv4y7SiV9KKl8NALnLfFX3d3PzNn0nhp4ImMFfbXng==@lists.linux.dev
X-Gm-Message-State: AOJu0YydovppmxpP6AeKFdp1fHwUCLuWyVAW6GVWwXeNk4DMVG4zBv9f
	2BoYtCU9CRKIuVxt8s9lZU+7AQmmVVrz6mgOE9TJR87ZY5qBjbZ6
X-Gm-Gg: ASbGnctoKRB3lKh0p8DoCOzIsMNVlDwfRueYrAiNmQoZcY7ZrhODsbiWcGmig0k3+mg
	33cb8HY4OIYwLHK3q4mRQCdi+Qhbu0KNbarypBajHZw1qbXre+cfsT+lWI4YTi1GFXTElqhjHLv
	QtUzI/p8uRKpJbOpFdWvEDoHOBeg7Z6evv9uRwSbO0Kg+Wti5uyyJH/nZYaanx6n2yYbu51e5/j
	uGoD19KFPPs4/H1XkzFBBweqgFwpi8stmsmHhAAKmrkKWvrMPqtdt+P/4gifrg6A7ybAYjKVi9w
	dyIqm5wsD5nGtM/7VCkoryz7vFtE
X-Google-Smtp-Source: AGHT+IGqyt0x8perOxvOGaYXy7nT409A3phfwrJpRPWWjTCB6RpC8xBN5ySrfOcN7s5jEAP1TdqkUg==
X-Received: by 2002:a05:6a20:d49a:b0:1ed:acb6:7fb4 with SMTP id adf61e73a8af0-1ee03a41ae9mr8636078637.3.1739188190526;
        Mon, 10 Feb 2025 03:49:50 -0800 (PST)
Received: from localhost.localdomain ([45.78.50.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7309569d5e4sm1103778b3a.162.2025.02.10.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:49:50 -0800 (PST)
From: hlleng <a909204013@gmail.com>
To: info@metux.net,
	vireshk@kernel.org,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	viresh.kumar@linaro.org
Cc: hlleng <a909204013@gmail.com>
Subject: [PATCH v2] gpio:virtio: support multiple virtio-gpio controller instances
Date: Mon, 10 Feb 2025 19:49:35 +0800
Message-ID: <20250210114935.204309-1-a909204013@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the virtio-gpio driver to support multiple virtual GPIO controller
instances. The previous static global irq_chip structure caused conflicts
between multiple virtio-gpio device instances as they shared the same
interrupt controller configuration.

Fix this by:
1. Remove the static global vgpio_irq_chip structure
2. Dynamically allocate a dedicated irq_chip for each virtio-gpio instance
3. Use device-specific names for each instance's irq_chip

Signed-off-by: hlleng <a909204013@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpio-virtio.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 93544ff62..ac39da17a 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -350,19 +350,6 @@ static void virtio_gpio_irq_bus_sync_unlock(struct irq_data *d)
 	mutex_unlock(&vgpio->irq_lock);
 }
 
-static struct irq_chip vgpio_irq_chip = {
-	.name			= "virtio-gpio",
-	.irq_enable		= virtio_gpio_irq_enable,
-	.irq_disable		= virtio_gpio_irq_disable,
-	.irq_mask		= virtio_gpio_irq_mask,
-	.irq_unmask		= virtio_gpio_irq_unmask,
-	.irq_set_type		= virtio_gpio_irq_set_type,
-
-	/* These are required to implement irqchip for slow busses */
-	.irq_bus_lock		= virtio_gpio_irq_bus_lock,
-	.irq_bus_sync_unlock	= virtio_gpio_irq_bus_sync_unlock,
-};
-
 static bool ignore_irq(struct virtio_gpio *vgpio, int gpio,
 		       struct vgpio_irq_line *irq_line)
 {
@@ -542,6 +529,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
+	struct irq_chip *gpio_irq_chip;
 	u32 gpio_names_size;
 	u16 ngpio;
 	int ret, i;
@@ -591,13 +579,26 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		if (!vgpio->irq_lines)
 			return -ENOMEM;
 
+		gpio_irq_chip = devm_kzalloc(dev, sizeof(*gpio_irq_chip), GFP_KERNEL);
+		if (!gpio_irq_chip)
+			return -ENOMEM;
+
+		gpio_irq_chip->name = dev_name(dev);
+		gpio_irq_chip->irq_enable = virtio_gpio_irq_enable;
+		gpio_irq_chip->irq_disable = virtio_gpio_irq_disable;
+		gpio_irq_chip->irq_mask = virtio_gpio_irq_mask;
+		gpio_irq_chip->irq_unmask = virtio_gpio_irq_unmask;
+		gpio_irq_chip->irq_set_type = virtio_gpio_irq_set_type;
+		gpio_irq_chip->irq_bus_lock = virtio_gpio_irq_bus_lock;
+		gpio_irq_chip->irq_bus_sync_unlock = virtio_gpio_irq_bus_sync_unlock;
+
 		/* The event comes from the outside so no parent handler */
 		vgpio->gc.irq.parent_handler	= NULL;
 		vgpio->gc.irq.num_parents	= 0;
 		vgpio->gc.irq.parents		= NULL;
 		vgpio->gc.irq.default_type	= IRQ_TYPE_NONE;
 		vgpio->gc.irq.handler		= handle_level_irq;
-		vgpio->gc.irq.chip		= &vgpio_irq_chip;
+		vgpio->gc.irq.chip		= gpio_irq_chip;
 
 		for (i = 0; i < ngpio; i++) {
 			vgpio->irq_lines[i].type = VIRTIO_GPIO_IRQ_TYPE_NONE;
-- 
2.45.1

