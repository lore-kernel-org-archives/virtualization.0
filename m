Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B9330B04
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108079; cv=none; b=S/OzJlJ5cPWz/EahruCLxMKiRSxMLhUxdANydJglu/dIFr7f+VJc8xwRN4fcIOqU7x1zIc61uohAVRLKvBIHg1LIpOd+EMm6AgvRELIKfjabu/QEqTkPEbvp42uW6ugeqS8Dwh7c1q0S+0VfZPd9PytspNMf3ChX2R4Gge7OCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108079; c=relaxed/simple;
	bh=r74vXhE8Sb4aeEjXyTRfyESwDzvu/qDaicDAjMleUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErqsHqsotkH/MoNhOV2x3fc5dNHc/B0qkJ19N8MvjOIYk/RksPuQkTpjeNQezYMuhGoRWimRYBFx7ZD51Twg5uAmuewvrYasiBUWZftdjgiwk9p8friQBEqHgiYXJFo3sYATSfszOzDuI6x+o/FQD1m2pfCxR7cYYBjsuZ6znpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpldrQ/y; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpldrQ/y"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c73bd024a0dso433258a12.1
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773108076; x=1773712876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lALqj4AFCCf04PXMDS8nK7oxi7K5MFhENXcy3JAs/Dw=;
        b=kpldrQ/yRjXtt9kh6QRsu7UFpbbCGDyhhuF7I9XZ0eXvqZZczC+p3gf9xShU5sfc1Q
         J+o+T1rQ1cHxlXu6xE3SULyctGBv1Ll5TOPxAOV7+E4vVhm1eN/UXz1FrC/+Ir3tSq/R
         VCFZCet24APMjODXp9XUILEPgYxWww//1TBCBaRxFkcYieGI8o/XmJX6f2yN44JkuN71
         wcNhuuD7Y1oTvHqCdB/gvrrxcV8IV4o3DqVkO7SDdDNqhLeZocyibXlFFChdgPfWqtF0
         Xjf1hvqweCi2iritO+OZb5M3tZkkkdLCNVkvJbfUy9YHB6w9iAqwUvZF6Yx/WDrmyyGu
         p+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108076; x=1773712876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lALqj4AFCCf04PXMDS8nK7oxi7K5MFhENXcy3JAs/Dw=;
        b=Eu3Usta852ej2HvvrsNOkhhzVfji4LpeYvZWdfTDTT+hON05hauqyu9f9PsK+Xj7qz
         3P65iTDQmATpR6BzLcY5nkgxFp+ZXi0oj16Pb6ntGxUuF+0hpuYh2LGIwqIWJjz7gVkH
         +ON1Kj1qZ2ea5Pbu+bTsj9hJ2rZpFunIDYFWIHirATQrq9qsoE6QawTam6q9eAybH2iB
         AATld3kfQaD7z/v0pHMjUYhsTZUt1gT7LG3VkdrcGEqV527a8eV7boCkIGm/DwoeR5DO
         eexXWLBNvdozNY5440JOyhxZQ64cVaT/TVIaZ/5qqhXIpE2XjemUcs4S52jW3H91KGqC
         S6vg==
X-Forwarded-Encrypted: i=1; AJvYcCUBsZ6ZQO16wMvOD6cIY01sIe91tJB5zMCA+E/lPaT2/u9+yysHOCtKHf6VIz9DRt1NdFE+DR4Rx3TbsKACcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsac7ZLXBVz+MoXMU/sedQy3QVjFQl5YyPtzZamPfgbvjWcmNM
	ERxD995yqoT3JBeYZ0WwkpDlzgnbCwsfw1PIn49eVF+qO4usvTpRANqH
X-Gm-Gg: ATEYQzy7uLSZ4itgY8LluIE/GKissdy/kQ3f39fJOedweKH4Po+3YHC1WRs3XSgPNho
	ZHEK1IRjwBwGac8FHy3SOe3rkZazGjojVR32CFNLmV+Hd9rZU6Mia7za9u63H1P9K9LkVw5q8fR
	RL7QT2KHVpcGAslZJJelyR31pLA8o6O7i4Z4AOaCHatN0nVoEpQaKpHIHV9G3mkiXO13ab/NIaK
	wke7f15VodphEs1BPi9oiCy4pJyoumNwxfTbmYWhJGxV8TKWTj7mmihTnI/n1y76hGy5PQEaL/O
	IbTpDm5BENoT6yiqInt9W8mSHodt8M0/Eay85n3IIYNDyPvhfs4luf1dbPkyC0i76ywUjAAKUMe
	l3j86Rjop1obC5kPOnhEpCOj7/NQycsiKF2+qUNDJGxvss51HvZRYoIVkTjEStaKiKckFDGgDWF
	s9aRnbQbYrQY5Uivl7R2+5/xu64GbBVp/xwQkbVYr3CEdzdP3wWQ2RxA==
X-Received: by 2002:a17:903:2c50:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2ae82362d1cmr136082195ad.3.1773108075517;
        Mon, 09 Mar 2026 19:01:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f78370sm135102865ad.43.2026.03.09.19.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:01:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO GPIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpio: virtio: remove one kcalloc
Date: Mon,  9 Mar 2026 19:00:57 -0700
Message-ID: <20260310020057.340550-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flexible array member can be used to combine allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-virtio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..876a34ed739d 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -52,7 +52,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;
 
 	/* irq support */
@@ -60,6 +59,7 @@ struct virtio_gpio {
 	struct mutex irq_lock; /* Protects irq operation */
 	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
 	struct vgpio_irq_line *irq_lines;
+	struct virtio_gpio_line lines[];
 };
 
 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -541,10 +541,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	u16 ngpio;
 	int ret, i;
 
-	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
-	if (!vgpio)
-		return -ENOMEM;
-
 	/* Read configuration */
 	gpio_names_size =
 		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
@@ -556,8 +552,8 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
-	if (!vgpio->lines)
+	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
+	if (!vgpio)
 		return -ENOMEM;
 
 	for (i = 0; i < ngpio; i++) {
-- 
2.53.0

