Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFE2DCF58
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197761; cv=none; b=YQfIIrpzMURbPZbMnhGX8p2eXpFhX8FQqPXx7WCY0YRMjEECVaJIvkVeJdHHM90fQqoX6g07a3VW3oy9adaWYRyY199PWx7QD3D71hnGPhbQdcg0x7zvDXMVl0hT5+abXOSB9D4p49K+Z8vALQoKPZ2F/M0u7TaJQNnj2FDleGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197761; c=relaxed/simple;
	bh=hyjfQXklLqkW/i7CefJGecdgWhNnoQXJHNE3mTmlTlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+xAvcCtlDJDg84mwEp4FBLu7LsmSoA0z0vxu4N1vWplR5zugB5ZI6mYdCuQf/+mGM/fVMRkZHTRpUS3rdxt4xElf0r0wGMExtLEo1Ze7QFBZ6f+mvxtFU2+ttrgjKj/g5acaCW3wIt5mV0Mi4iHZZ/SHNxzqRYyNsaDDFg68zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuu0YS9+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuu0YS9+"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35691a231a7so8507177a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 19:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773197759; x=1773802559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8c6OjZm0+U7pnN7pJa7FIN5Z/TewF/LGu73XtmiIMW0=;
        b=iuu0YS9+0H9uY1BBs3QWZNsEQ4hGrPisMVx5ehTgFVi3ndlrL7COGTsINvmq5ip9vy
         0eDxYKtwRovFN9e65E8hrSMEv5nv96GpL9Jq5Uz1mXBIOmkLgDp5f0RwCPgYCAZXis1P
         dv7+bTQB2x46E6Lpmq/Nwf3j2VNPdesc0TG05gKAOKR39XIyxwVUwokwDbdFtT4tZFZn
         rXWCbL6fSpH0uuE9yT2gIoWRs0O1eJt1FCXfVlPbOzXMK2zSDOkLmJsGJ34r7u6V8+KX
         WufvvHfgZTsltpELCUp+N0+vsc1K7F4a6qa7s7xxHIG7J+cs6swKo2yJ00qYBeI/mnMv
         yhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773197759; x=1773802559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c6OjZm0+U7pnN7pJa7FIN5Z/TewF/LGu73XtmiIMW0=;
        b=KnKJWKpWyhclrPdtfoEeWbEyYeAQlMETgyG45/0026i4zmAUgbSqMKfVRispr2oOHB
         xC7viqWtst8Bzs72X6DsdBEWkGNhZr79UVfwvrVgwoCYZUkDcRZ7TKFnWZ5io8inB1zD
         3uDGdga0yFcJzcxTVja2uQ9BF4lBTU6XLDWeyYIU67KuYH6p7oMp/moAWieNc8Ofrl/s
         NQrAlI6k/ml4djNqbIQwEdU62rSg3zGtBva1g4cQEht937hePfXgOj3He39xhplnMgB6
         FXwl1SD5WI0ny/ayDfjdhD8yGJmtmkUb9ShF9J4P5z7nMux89c/hO29PJgbRDELmFYJf
         6tSA==
X-Forwarded-Encrypted: i=1; AJvYcCWRh7OYzdbly3oOzaka4AYPLPAVc/dpIOHNJD3xwE5PLUHyESNB5nuhOgEX7UVK7z7iDdYcAaFjHhhGoU2+VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySnYcSLm8ZZ4d+r08elv+tRfWkatO9wbzdOtZBXjs4yChkNt0l
	b+ly/arMYZNxFIdzaNY54zzPO1bwY7HuQ3O0dX+3k8jllHU3pTuCnHpkF1raKTdw
X-Gm-Gg: ATEYQzyAd9PpaqAEOP5GObq4NrPkbSmhH2ZjmzDDBM5uAlxENBDGndZSTWZhcY3Er6o
	9lqImA0dTLsePXoRk8O5L/hqUHDWswi3W3IBTzIGrGEkLSQQYqFhOND4jkW0rXfotavZZ2tI2mT
	oT43fggoMjMc+53X/+zPIMyT3+X4CPcZs5AqU0tBc1WUTDMI+wXE34/vNX2/UiP8GPY30Qv8V2h
	Q3OIxa1306ATEDIx4MfgRp+2BYnWLDGOChqU32c1Hl3cC4I8BiHODg1c+M6SQM112oFMG4M9YDX
	aSNrwo4FPrfPp39HypXp23KGb4HJYRxTAqCmUv4AgTHve445zmlF97DqNw+yKFAsA8JzH7UjhQB
	OyXZnIi645uDEw5OeHOGt8YMmj2F0GLixlvIh6clfIkOTv+ZQ5gN6zNaMBeAs8Wu1yD77UnXAd1
	p3iievDbd3eiwUkBjE7U3aXJn/LKUemQ+00t71VE9TIsJZXbBEfRL3hA==
X-Received: by 2002:a17:90b:3f45:b0:359:8d70:c4e6 with SMTP id 98e67ed59e1d1-35a012866b4mr885260a91.1.1773197759236;
        Tue, 10 Mar 2026 19:55:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ba23adsm475448a91.0.2026.03.10.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:55:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO GPIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] gpio: virtio: remove one kcalloc
Date: Tue, 10 Mar 2026 19:55:41 -0700
Message-ID: <20260311025541.53814-1-rosenp@gmail.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 v2: add space in struct
 drivers/gpio/gpio-virtio.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..db66590ea5d3 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -52,7 +52,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;

 	/* irq support */
@@ -60,6 +59,8 @@ struct virtio_gpio {
 	struct mutex irq_lock; /* Protects irq operation */
 	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
 	struct vgpio_irq_line *irq_lines;
+
+	struct virtio_gpio_line lines[];
 };

 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -541,10 +542,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	u16 ngpio;
 	int ret, i;

-	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
-	if (!vgpio)
-		return -ENOMEM;
-
 	/* Read configuration */
 	gpio_names_size =
 		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
@@ -556,8 +553,8 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
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

