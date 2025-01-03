Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E51CD1F6
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893341; cv=none; b=i1xucbt+zTvU6N3srxTXxawWOMlHuWAozT0vFvrGHfZKxrCT9lmQxKpJzFO1aypQ9Rt+Pe5x+mGnAVgSM5xVKz4NQdRzBooWDuCqrzHRmCHLZlVE1kj09SgEBqwmP90PqjTesSWmTKitBtka9SuW7ABbbS8MvM4ypvAi/GmA9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893341; c=relaxed/simple;
	bh=m6o9aISv6L3EEBwD7nPuVZXQzsoBVQIjPOkdAPOO2+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VM1hcgAVbju+pECKLTODqWQEqPEM5b6/teYjBH/nIdEzeeMsyAWNfgH/94v/2O3RnHFYuH7uJLJzS0TiAwIaoplglrTsaZCvEMwfYnjtxYV4Ix4RbGrfgFu5wCf86ASLCeJ7Dac/VCU+FyfRomTV9KKxb6PeDpvFHlQR4/HnKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYdxkNUR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYdxkNUR"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f45526dea0so2254836a91.1
        for <virtualization@lists.linux.dev>; Fri, 03 Jan 2025 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735893339; x=1736498139; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mNSE5l1moO/1n7caacSdxfwOs3Hhsbfh6K+K68U36Y=;
        b=HYdxkNURW+zwO6aSceLmx7xKqWXxgse0dFvxxD3haPGjAvhhBEbMfD+UXHnq60A9tj
         1lobb+r8yw+LIoDXa8720Y+KfpkMAgz/oTvK8ZVcZSehLR76jbLABDHKlggBUJEezYMl
         0n3OmdDM4CJ7BnU44eILei/SQ8H0+iRKIqTgxLVjk8we3fRTg26VybYVxIkzFvTaGwiE
         zZQgzcca7BHHteYUpJgUZJu5IGE68QRYgy6xFkqPlnCwYevmEARXzRlOO7yG7Q6uX0mt
         pqQKkZN+vzf+nPDRy+cU0HSKoNd+AEz1oS/fRFZ69qQNDdmeYKj7nPP9fem34baXfpV0
         PVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735893339; x=1736498139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mNSE5l1moO/1n7caacSdxfwOs3Hhsbfh6K+K68U36Y=;
        b=YMkKsXi9V0TEIwjLXXhuKZRpxo/tkg9JfH/iF08NMFgfZNdMVnce8WuTY24r00wn8X
         vH+T1TJGBbgpF6yq7Jh9uN2oN4txT5vRMQN9FDnWwULOqbl3ko5pkgplKrEzS2zTU8B6
         EnkDqC3TCvrjC3anzwguCgVOIbHkxzIyXbpyJb5bimZoSYNRfTQtUESq4NbM//Acg1bZ
         pqNj0DAhLpGr2B2VIMcZ7aC29i/fJirxHvIA4sE1ok+bJEKAa3VsQXsUQvyWfaS+LQt9
         mrMnHVGnbvVTUK4UO8YznxrzZ1vx6IynSMWR2JW5aR14UAd5KE3ROhPaNKb8E5MjazlP
         v9sA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6tLhLQsa/Z8VTJD3rlZ7xdAu5VBiCPgXd36E/vX9T8AjE+SRk71btfyscX5Z6/RaAXbFFVxmyRWc7c6Dtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpZ8+AMhqU8nr0CDgUSip8k1Kb6ui1VF16w/4GS01DaHi0rMNP
	p56mQ3r7pOWLpZfzzrun4v2ZB0s6mBbqmsWDhvwYFP0RrExUKvqj
X-Gm-Gg: ASbGncthin9SKlFTmwDp5gtgLiFxUGTjhkGmBi82r6/zWc5eHfwOw3SPS3ZICS4DeBl
	epVINVgbNbOurW+12Fj0CrDJgQj+OUfzKi0Ckx2gDUQHOriwQY7FDuxiSxIFkW/kaKdbgQuPxgv
	Xiao8EuWzfic7gV2QBH0nRcJ1JkaauJVrni1fn0EhYSkRN8ayXaY7BO5gGZUe+XbwvlsNzG9onx
	c+8wlNYsP9y0nu/1JDLb71z8tJq1sL/sz/srEkebmxkLGbvtOyd4pK7p6HoPQmsRouWhw==
X-Google-Smtp-Source: AGHT+IHRV/PrvU4It40AKrowU5SGQvvYdkKFhMC4R60rhuMGOLgJUiRFHyCQsx08hnHqoCcTPaqexQ==
X-Received: by 2002:a05:6a00:6f4b:b0:726:380a:282f with SMTP id d2e1a72fcca58-72abdd3c245mr27376891b3a.2.1735893339150;
        Fri, 03 Jan 2025 00:35:39 -0800 (PST)
Received: from localhost.localdomain ([45.78.50.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d22sm25727340b3a.77.2025.01.03.00.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 00:35:38 -0800 (PST)
From: hlleng <a909204013@gmail.com>
To: info@metux.net,
	vireshk@kernel.org,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: hlleng <a909204013@gmail.com>
Subject: [PATCH] drivers:gpio: support multiple virtio-gpio controller instances
Date: Fri,  3 Jan 2025 16:35:20 +0800
Message-ID: <20250103083520.1764441-1-a909204013@gmail.com>
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
---
 drivers/gpio/gpio-virtio.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 93544ff62513..ac39da17a29b 100644
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

