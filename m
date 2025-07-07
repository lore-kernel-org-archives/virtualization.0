Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106F283FEA
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874625; cv=none; b=paEQUwFkY28knhZ5mm5wuuJ/XY6FqN22nMSoYtRXQgMU7EDY6xVp0n9jPkWQF18LmJpUHH6lDgpvVIypaUvAbnKj4pozMnmONMuL+m6ptsKpAbHJVz7eZ6V4dChzT3c+z7vgLN71CEuIIAqBO5G7NO3FhBDtpws8adGk+YEQJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874625; c=relaxed/simple;
	bh=wVo3Uj6jmnQf/BSDDMw9sp+FUodCwKCtMimosX22fNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvYmaQp5FBCa4kAGf8bFUHIVd3LWhrvtWqzuPEFWNlnJ14n3Xa1KO5xOWyp1ZOnF0XP/o7KddlSW/TG/W5hg/VAGJSIrCvzJaXGbOTbxevhjp0YmuP72GnNHuCgfhr5uh099zRPrrV82pN+nKc2ObQdsDe0MeGaiTts8fblsUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=J40EFbJ1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="J40EFbJ1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4530921461aso18235895e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874622; x=1752479422; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KIguw26t4x0LRcjdNKl7u8c5ct1I3xgnx7WNCV/df4=;
        b=J40EFbJ1+9mVaidYhA9LLKMkyWpuZdilcxvBUL82SY8WeQ/QTNVU4euqS/ILSCueS1
         FuR1uFp74TzmEvgZ/6i+p3DhgiIYcrOuefAmxs6fLVyJNniAGQ2rOZVcbwLZ/ySnAHN+
         FieUeYTwKLnxFECkdhO6YW88jqmMefKkw9oEXvT6kbWmyoK+TdchIIxXzb1J3Q88+Duv
         SSBaZwfrsNe07Yey5C0YA+fZqtdpJnIoM5TkDnjGPWTYpviZJrc5bPekEuKJm6ZiSiOY
         4aPee1tDylpiQts+zlugbtAMxzOIwQBT+lAuMrxC9Ay1DHhHyv2IK5D0M2+XEjYg+9mF
         4xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874622; x=1752479422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KIguw26t4x0LRcjdNKl7u8c5ct1I3xgnx7WNCV/df4=;
        b=BK8lyDlCZFbFSIVHEfxEzYBxZfHp7N0mKfE/hq8MujndjMtytF2SPpdcXcbJ1ihJkj
         L8OWVBFYax/6pidX9nnJE8JyMHajQU3+p8sB6S0G895VWg7oF+vCYWLTPGqGkEyrefBG
         zq8TbAmcs4ib0hrExFrKkctKKxe7PL3sP/pXs8g6qF8lgi2zAcPfKEsSjKAnxr9idmBp
         JfzGmiUuByD1aFnrmf02dF4oSeaeSPT/KzIwSNtpFe9mrew3jou2Pus3AQXlTAtjVIey
         xQnUpL8cJuayAnXwDF0ByyymY2+cG81wJMDGf6Frp0laKV5tm6Qiioc9yeUlPLcbe25C
         Xhyg==
X-Forwarded-Encrypted: i=1; AJvYcCUoi8ZdY4rJYehXjGWYXFafJ9Av//IVPGlttat18OZKPJc4eeKuTZYb0QrXJA8pu7K+Nk64uGqULkfAb1352Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTmPde3nOfjPDxK5/Evc+wubiDMEyMeP18FpqO3bUXjMV5h2pb
	HvJmkzEk6m52+8EsgxP5+yOcVzZ8JucBOO7rLbKfxM/KCY1WSlo4IDfWFZ8JJwQq7zM=
X-Gm-Gg: ASbGncsD8VzCFgc/+vixuSRxKbtyyJLaYbLlGL0kZiSBpddOEvNqmv+g7FvEKYV4d5v
	qwQDjGut59lwiyeOOKvLo7yE5Y9LYpfcyIwnkMfUkQAfBKgDFYwgFpMRbn1/ET/WQmYS+uKExf1
	Vdylic3JZHiexnL0zLbDrEMLgPauWa55Kftm/t0N8iUM4n62m4eOK8X4/r8FoKQIyYMBKucN6bG
	cBsha9DYxEuobEW+VtooAs6NlU4WYvN0XqjQw5ip9+l04tjlUOmXBXbt9tgZ4YAvm0NswKcdgnh
	ZkwX+n/4cAIFaCNtN3wh6BixF9VCDG1qrizMHzLicyAHOwlxmlubz219
X-Google-Smtp-Source: AGHT+IH0BRfaJT6Ja/4oOAwTU9Pk8TniKor/Tf4bstFHxPXhtytwSi8RMT0ZGyIHaXzOhXpOamh8gw==
X-Received: by 2002:a05:600c:1386:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-454bb7f613amr61571815e9.8.1751874622098;
        Mon, 07 Jul 2025 00:50:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:14 +0200
Subject: [PATCH 01/12] gpio: tps65910: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-1-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=PFt654WU5Bje33IYcMH6++mqWC/NhCeC1UEL+Yp3IeI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w5QHqDYMrZJ+NhTqLDhhpPk4MYxtgOqLT6j
 l09IjyBav6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OQAKCRARpy6gFHHX
 chs7D/47U4VHP5YhUMqlgJvviv29pJWoT7ECD7eEwNL78AHuoyS/KQzoyrTPBim2otsR4VTVKGD
 lfqBwX7VDQe0JLHsF63g9plpkWjiLM4YMRarfFU2/DS6rKpyflaraI1JPAzyU6Wfa/P9wjWkw10
 2gsDHVDkFoHyF9xgJWVOMB+iIBqmTemBD0kyqAmseZ7RY5ym2ke4ea9q7MS0tD65PBMUd3cqZFc
 Qt/AOSuv1Vx+1i0CGwIi6V1pRjvRQ/MqW4GmP4L/A04D0Q7axr1Tizt2axy7FzHhYqjcWUToj3q
 WdQsgPuPuD2gdjqZPEjeYJRFEOqo9NfFSrJeQYd6u+j0cXBNP7tC67mvTOrYh1eq460orTbfHe9
 i3XiycOdEFQ1Azjlq7BhC1ORmlj0NAuk4UzKU3Dg/FsivFpgOOr4zxqAMDdl/mnVYKD5idAO/1q
 43yFE7MRLxwuSYTnOArL/AjYVUebH39gNlVs8eTPHZ685b2GChWc0OX+PN4ooEd0HRDxGWofpkm
 EQA3PohnW6TPPN81ZY6thUVgu+hiqJ3jfZxacEcACayJcTorzD6W/axrrmeM5QB+C4iQ3BePpDy
 VGkDtKHecrsrLemuFI+lXY9GYMrIq1zFFzgZ6h6B48Thf7CDqgspOciJAYW6KwcYVYlM7+y6fna
 eeYYyQNl5cxl3hQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-tps65910.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index 187d21580573fb1d896d90642a537a90aced8276..3204f55394cff12dc1b462cdce60342ed1b32fc1 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -36,18 +36,18 @@ static int tps65910_gpio_get(struct gpio_chip *gc, unsigned offset)
 	return 0;
 }
 
-static void tps65910_gpio_set(struct gpio_chip *gc, unsigned offset,
-			      int value)
+static int tps65910_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
 {
 	struct tps65910_gpio *tps65910_gpio = gpiochip_get_data(gc);
 	struct tps65910 *tps65910 = tps65910_gpio->tps65910;
 
 	if (value)
-		regmap_set_bits(tps65910->regmap, TPS65910_GPIO0 + offset,
-						GPIO_SET_MASK);
-	else
-		regmap_clear_bits(tps65910->regmap, TPS65910_GPIO0 + offset,
-						GPIO_SET_MASK);
+		return regmap_set_bits(tps65910->regmap,
+				       TPS65910_GPIO0 + offset, GPIO_SET_MASK);
+
+	return regmap_clear_bits(tps65910->regmap, TPS65910_GPIO0 + offset,
+				 GPIO_SET_MASK);
 }
 
 static int tps65910_gpio_output(struct gpio_chip *gc, unsigned offset,
@@ -55,9 +55,12 @@ static int tps65910_gpio_output(struct gpio_chip *gc, unsigned offset,
 {
 	struct tps65910_gpio *tps65910_gpio = gpiochip_get_data(gc);
 	struct tps65910 *tps65910 = tps65910_gpio->tps65910;
+	int ret;
 
 	/* Set the initial value */
-	tps65910_gpio_set(gc, offset, value);
+	ret = tps65910_gpio_set(gc, offset, value);
+	if (ret)
+		return ret;
 
 	return regmap_set_bits(tps65910->regmap, TPS65910_GPIO0 + offset,
 						GPIO_CFG_MASK);
@@ -136,7 +139,7 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	tps65910_gpio->gpio_chip.can_sleep = true;
 	tps65910_gpio->gpio_chip.direction_input = tps65910_gpio_input;
 	tps65910_gpio->gpio_chip.direction_output = tps65910_gpio_output;
-	tps65910_gpio->gpio_chip.set	= tps65910_gpio_set;
+	tps65910_gpio->gpio_chip.set_rv	= tps65910_gpio_set;
 	tps65910_gpio->gpio_chip.get	= tps65910_gpio_get;
 	tps65910_gpio->gpio_chip.parent = &pdev->dev;
 

-- 
2.48.1

