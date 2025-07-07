Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041B28F531
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874638; cv=none; b=KMGul4Y3FSgSL56GFbbvF2ZqoJg3XkjnrbKqenCHIFYBuHOhrLqrAZD+X2IszO5PUgH1LK2zqx5+IFl+N+9ASJ09piFLBZIR8ZhVANOwNI+PVV9nUarv98oOML+N58Pkm5KM5hdk8QkTVz5OacrN+pmL94Px3mZ7RC6379LToAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874638; c=relaxed/simple;
	bh=J3lfSaGSJElFYN8a7NlOaJspSwrbv0Tab0XbH566Gt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrbWg0axIBTNmE51dDI1RRXI1ZaX1WqvAoQg3XctfBHjM2qFR/BDSOrx9+DtP6jO4eRkGyLseMHXbW80nhCR/yRnEX9q4HL9pEHlTePzQ6EusostXuy4QEx2GlfASEWSY8Sbqmpj+/LpDXkqcrolhoCPu34MIdcRD2yDgcXkpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UqnVETtn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UqnVETtn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453608ed113so30807705e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874635; x=1752479435; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5m95BPd+tC0NJEgq1fKV46WFawJx2Vc2kdVjnJZ0X7U=;
        b=UqnVETtnnXcMbI/nS86X79mh7yJKpi4QoA7N6/c8FbJPcmkc9I3QzYQuUsIZ2APsUh
         uSAnFP597e/lz179VT29wyvRyVxmxfsZiZQVgpm7szH1JaSTcjfBZHlmuZf1J0NGEjJh
         K3prsNXQodKc7GMjZ5NpmbNW3+HTaGqPEX77PX4cCq/XllU+RAi61/Q7SCCEpY4Ci/PO
         1830k2MmBw23Yx5YqlQg8KUQcyWSpGqfCfj2QlssNTts0Qg8B7BROeqdzPAGIgrW13MK
         XhrFz8L3oSWleFS+tmWhkWkqIvwdvxhx/VgY7PS0iYUXhVaYNNOl04u2Vl7t558Fyo/y
         uS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874635; x=1752479435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m95BPd+tC0NJEgq1fKV46WFawJx2Vc2kdVjnJZ0X7U=;
        b=jAKCGzXt/zG6q5XvP2YbU8drSwioHBOas4K7h7mgODTMJLzr4orzlqZHx8SXs3oV8S
         oHAT6vt2d3c5ilLj/XkafEnCD5gLPletcUIKuSNwkAU/PoIeWAl1Xiq6LfGu32QbZJIb
         yuflLYKdnOmu0gdYrL5O5SYM13jTOk4X0DfTa6aDVymr36lvsa7vnFOhkq+ZhuwIpRHt
         U8trJjYIEyI6+8ke98jPO8Q93YyIJSj5mgVpfR3SvebN86mTsK/1duvWqAkbCvDB9Mw8
         P+sI26SDXM3vbsT+mhvbwzucmLys8iFO+pqu3QQadB1tRd/Q6p6+MYLqloiz25Jx0bD3
         lBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXznL2a52TioYVYwfEk3GiySzI3WgTKTSXwzXGDaoyNq3hYrpdyNW8V5YIKdNekjRVbhfUChToXoD176amSnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1S8R7hSbI7bWwSfnm+lk0H9YGklsPcSTCzruKvEppp5VZlwqj
	xk9f+M2BgCEnJ9AlJ/LNYxQWacG+D7ZdLuZSdJMY6bfe9ghLMQwTwUReB1GAZAG11zmtQX9ru2T
	nRxhK1d4=
X-Gm-Gg: ASbGnctDVlawxpcKEJDfj22UA1ygb/7eU1wFareNJs/15rlOIu72GffkJIq3mSEaMAH
	vXyMlQOHvhSLzABfVYOuj9F+4F2kaBziQHqzf7LH+vW6kq1lGm174uFsUytaUFoLsX8yvN3z9Bd
	yzjVgdGvcNXZpsOfdWeuLUHOQIY36Yczt7GTCZNhaK1p9OUyWQRIlEWz8xJsgnQCN5gZHscRSl0
	J037QGzHanzzxFEY/gbwHnDx3Oz2JMQD7EMVXFJOxB3DYPvRxVGWt9JvGo07spHSEn3wPuSliTw
	nEo7mdTcjymmnfYOOkYrBN45UKcmbiOtLkPiwCiZYAOvBi5KZHoluo2f
X-Google-Smtp-Source: AGHT+IHsI+U/zbDSojMWN6sQm8VqQSx9aNhllH3AxLDc+j6V7DOcunJJMpxwdV+S7DO5xusMHGPzvQ==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3b4964f4da0mr9403903f8f.2.1751874634985;
        Mon, 07 Jul 2025 00:50:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:24 +0200
Subject: [PATCH 11/12] gpio: viperboard: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-11-35668aaaf6d2@linaro.org>
References: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
In-Reply-To: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, linux-arm-kernel@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6288;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=hG6ioXzqzHsweEWMJ3BfovvFEd26Ob457d1Hk91Aou8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w8kR5HfkB64zWwyrPXKAiwMT9HvA9xCgXzs
 3pKgIk6+6SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8PAAKCRARpy6gFHHX
 cpLoEACy+LzB2oIjcjJubbFal3oJ0odHk4EQHj7PZKBDox/S3htDeM1+FAViWFPpp44LwXrHVJd
 rZLJkEinpuIpyjqfpENeFgXMgEWWCCIOUmcK4azXhS5YPVnFkxl0LhTQez814mKWgJAZM1yuj0R
 tSvipK4cQBa8UUl1RKXrsb0naRvbfkkApmgloy5RrY7pJTBEU+trqDIVB61vU2mZ6hTjZ9+gogU
 //5ti98loMrVW9mdvZsWcpJt4vxDoHAm0JBMwOgo4VMqo3ghx/4uTh4Ozm8GPxTSjDu92RY31pZ
 vRWnd57ryNVnSwOwM1i5pWbpZ9UfSC0OztH1+3BvaTPOREZI8dy1CHM6303RX0ZmDZPYoaHNPKz
 PVxCW6p5NJK+F3rPr6XQ9L6Q0d/FUuCpbLXvhOvEmGs/Bu0GFv2drMbQlB72t91n/R0DN8+/Qrp
 jXKsNHqtJ4+NKrRrWLXdTl1ICMclZQ5td0zoqaGNHMMIRfff3g93xTnixkXNdHWQ9P7gtid84w1
 6mUrycMIacz+as0MO4Ej+Q3NUmLeslYFrxRKnnztz239jNC/RQCjuhicBVqLCzwG40JLIPWGKf2
 bNs9D4gCLrABH/LxryBSFYkDCZw28ipZknYxo3iDkX1Lc7/NnRYdPjMGiVeTSsUWggbTiKxqCEQ
 FJke3RNIg2OY+yw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-viperboard.c | 116 ++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 53 deletions(-)

diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
index e55d28a8a66f25dd0949133c4a7f3bca9b5711dc..3eba77f981d3a502b67a0a7cdea51c706d4c3376 100644
--- a/drivers/gpio/gpio-viperboard.c
+++ b/drivers/gpio/gpio-viperboard.c
@@ -128,45 +128,50 @@ static int vprbrd_gpioa_get(struct gpio_chip *chip,
 	return answer;
 }
 
-static void vprbrd_gpioa_set(struct gpio_chip *chip,
-		unsigned int offset, int value)
+static int vprbrd_gpioa_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
-	int ret;
+	int ret = 0;
 	struct vprbrd_gpio *gpio = gpiochip_get_data(chip);
 	struct vprbrd *vb = gpio->vb;
 	struct vprbrd_gpioa_msg *gamsg = (struct vprbrd_gpioa_msg *)vb->buf;
 
-	if (gpio->gpioa_out & (1 << offset)) {
-		if (value)
-			gpio->gpioa_val |= (1 << offset);
-		else
-			gpio->gpioa_val &= ~(1 << offset);
+	if (!(gpio->gpioa_out & (1 << offset)))
+		return 0;
 
-		mutex_lock(&vb->lock);
+	if (value)
+		gpio->gpioa_val |= (1 << offset);
+	else
+		gpio->gpioa_val &= ~(1 << offset);
 
-		gamsg->cmd = VPRBRD_GPIOA_CMD_SETOUT;
-		gamsg->clk = 0x00;
-		gamsg->offset = offset;
-		gamsg->t1 = 0x00;
-		gamsg->t2 = 0x00;
-		gamsg->invert = 0x00;
-		gamsg->pwmlevel = 0x00;
-		gamsg->outval = value;
-		gamsg->risefall = 0x00;
-		gamsg->answer = 0x00;
-		gamsg->__fill = 0x00;
+	mutex_lock(&vb->lock);
 
-		ret = usb_control_msg(vb->usb_dev,
-			usb_sndctrlpipe(vb->usb_dev, 0),
-			VPRBRD_USB_REQUEST_GPIOA, VPRBRD_USB_TYPE_OUT,
-			0x0000,	0x0000, gamsg,
-			sizeof(struct vprbrd_gpioa_msg), VPRBRD_USB_TIMEOUT_MS);
+	gamsg->cmd = VPRBRD_GPIOA_CMD_SETOUT;
+	gamsg->clk = 0x00;
+	gamsg->offset = offset;
+	gamsg->t1 = 0x00;
+	gamsg->t2 = 0x00;
+	gamsg->invert = 0x00;
+	gamsg->pwmlevel = 0x00;
+	gamsg->outval = value;
+	gamsg->risefall = 0x00;
+	gamsg->answer = 0x00;
+	gamsg->__fill = 0x00;
 
-		mutex_unlock(&vb->lock);
+	ret = usb_control_msg(vb->usb_dev, usb_sndctrlpipe(vb->usb_dev, 0),
+			      VPRBRD_USB_REQUEST_GPIOA, VPRBRD_USB_TYPE_OUT,
+			      0x0000, 0x0000, gamsg,
+			      sizeof(struct vprbrd_gpioa_msg),
+			      VPRBRD_USB_TIMEOUT_MS);
 
-		if (ret != sizeof(struct vprbrd_gpioa_msg))
-			dev_err(chip->parent, "usb error setting pin value\n");
+	mutex_unlock(&vb->lock);
+
+	if (ret != sizeof(struct vprbrd_gpioa_msg)) {
+		dev_err(chip->parent, "usb error setting pin value\n");
+		return -EREMOTEIO;
 	}
+
+	return 0;
 }
 
 static int vprbrd_gpioa_direction_input(struct gpio_chip *chip,
@@ -304,37 +309,42 @@ static int vprbrd_gpiob_get(struct gpio_chip *chip,
 	return (gpio->gpiob_val >> offset) & 0x1;
 }
 
-static void vprbrd_gpiob_set(struct gpio_chip *chip,
-		unsigned int offset, int value)
+static int vprbrd_gpiob_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	int ret;
 	struct vprbrd_gpio *gpio = gpiochip_get_data(chip);
 	struct vprbrd *vb = gpio->vb;
 	struct vprbrd_gpiob_msg *gbmsg = (struct vprbrd_gpiob_msg *)vb->buf;
 
-	if (gpio->gpiob_out & (1 << offset)) {
-		if (value)
-			gpio->gpiob_val |= (1 << offset);
-		else
-			gpio->gpiob_val &= ~(1 << offset);
+	if (!(gpio->gpiob_out & (1 << offset)))
+		return 0;
 
-		mutex_lock(&vb->lock);
+	if (value)
+		gpio->gpiob_val |= (1 << offset);
+	else
+		gpio->gpiob_val &= ~(1 << offset);
 
-		gbmsg->cmd = VPRBRD_GPIOB_CMD_SETVAL;
-		gbmsg->val = cpu_to_be16(value << offset);
-		gbmsg->mask = cpu_to_be16(0x0001 << offset);
+	mutex_lock(&vb->lock);
 
-		ret = usb_control_msg(vb->usb_dev,
-			usb_sndctrlpipe(vb->usb_dev, 0),
-			VPRBRD_USB_REQUEST_GPIOB, VPRBRD_USB_TYPE_OUT,
-			0x0000,	0x0000, gbmsg,
-			sizeof(struct vprbrd_gpiob_msg), VPRBRD_USB_TIMEOUT_MS);
+	gbmsg->cmd = VPRBRD_GPIOB_CMD_SETVAL;
+	gbmsg->val = cpu_to_be16(value << offset);
+	gbmsg->mask = cpu_to_be16(0x0001 << offset);
 
-		mutex_unlock(&vb->lock);
+	ret = usb_control_msg(vb->usb_dev, usb_sndctrlpipe(vb->usb_dev, 0),
+			      VPRBRD_USB_REQUEST_GPIOB, VPRBRD_USB_TYPE_OUT,
+			      0x0000, 0x0000, gbmsg,
+			      sizeof(struct vprbrd_gpiob_msg),
+			      VPRBRD_USB_TIMEOUT_MS);
 
-		if (ret != sizeof(struct vprbrd_gpiob_msg))
-			dev_err(chip->parent, "usb error setting pin value\n");
+	mutex_unlock(&vb->lock);
+
+	if (ret != sizeof(struct vprbrd_gpiob_msg)) {
+		dev_err(chip->parent, "usb error setting pin value\n");
+		return -EREMOTEIO;
 	}
+
+	return 0;
 }
 
 static int vprbrd_gpiob_direction_input(struct gpio_chip *chip,
@@ -370,14 +380,14 @@ static int vprbrd_gpiob_direction_output(struct gpio_chip *chip,
 	mutex_lock(&vb->lock);
 
 	ret = vprbrd_gpiob_setdir(vb, offset, 1);
-	if (ret)
+	if (ret) {
 		dev_err(chip->parent, "usb error setting pin to output\n");
+		return ret;
+	}
 
 	mutex_unlock(&vb->lock);
 
-	vprbrd_gpiob_set(chip, offset, value);
-
-	return ret;
+	return vprbrd_gpiob_set(chip, offset, value);
 }
 
 /* ----- end of gpio b chip ---------------------------------------------- */
@@ -400,7 +410,7 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
 	vb_gpio->gpioa.base = -1;
 	vb_gpio->gpioa.ngpio = 16;
 	vb_gpio->gpioa.can_sleep = true;
-	vb_gpio->gpioa.set = vprbrd_gpioa_set;
+	vb_gpio->gpioa.set_rv = vprbrd_gpioa_set;
 	vb_gpio->gpioa.get = vprbrd_gpioa_get;
 	vb_gpio->gpioa.direction_input = vprbrd_gpioa_direction_input;
 	vb_gpio->gpioa.direction_output = vprbrd_gpioa_direction_output;
@@ -416,7 +426,7 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
 	vb_gpio->gpiob.base = -1;
 	vb_gpio->gpiob.ngpio = 16;
 	vb_gpio->gpiob.can_sleep = true;
-	vb_gpio->gpiob.set = vprbrd_gpiob_set;
+	vb_gpio->gpiob.set_rv = vprbrd_gpiob_set;
 	vb_gpio->gpiob.get = vprbrd_gpiob_get;
 	vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
 	vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;

-- 
2.48.1

