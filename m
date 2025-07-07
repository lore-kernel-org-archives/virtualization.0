Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AE28DEEE
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874637; cv=none; b=mtvtxB4wTrvK5ec5WogvRkv5z4iDd51JoeV8nQ3AoqhwQlim65Q9H9etDlJYlBWDnb8i/igNHJQXvHltwUkr6edT8E0AK6kqScr6FJMFSU+cd3rJb87wsfOjNW0TwPJClWB62Mpi6ELQzvZ38FcqCyQGtbgxP4uo3Tw41ewr8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874637; c=relaxed/simple;
	bh=fb6kfSNOnqWMYp1xUl+Xkd0XCpgghqi5FOR6XmM78D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HK/m/tX77EWkmmFx83JNoeNkiZaWWnvc7nCxi4k5qnLhEPly8Ya0eV3dzB9vmRGOx/gVBp2oEDm5gZlLFcCn2J7vACRmkXVARylVmBzUeq8NcuJo9spf0oUke906Y2xmymHQDkyCLvhU2N/x9ALmcXGB/UYkUHU2/NHXSw2KQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eOxcTc7V; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eOxcTc7V"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so15857175e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874634; x=1752479434; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OLMIgUvqZFqepdWJ/QtRpBNQs7JrMTTPQY6qVJ+Q4M=;
        b=eOxcTc7VWyUKCoGkd6uzO49H3sg/a7ctlpQNuIfoHF/Kyd2D2WtdzPWroEpL2mka4R
         CvH+C6mDy3reMrzG0GcZ38WOR1Tx5+STizI+p8NE7Bvxsbt6ABDPxVBcpPV7eNz1PFIf
         JG0rbu4qZ68O9FOwki7Kull/dhi88mwQj9x/Y/oSRlyzsb7V/n52Y1R/Uq20ZfAdXeDq
         TWWmNHKT5ZSNMzFfoBtdhYR9Xk/wWFGZKe+W7HKT6fEenh443QwZJgMU3uwqsSoDgoWl
         gvCIMd4tn0Q4BlaUG0qKyoP2x1RVnSwy4YTwCYZObcRlYfk8ZURzMocBse9uxQHXOCDy
         DKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874634; x=1752479434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OLMIgUvqZFqepdWJ/QtRpBNQs7JrMTTPQY6qVJ+Q4M=;
        b=ke/mYySKAWmUmcSG1AOm40gqu3tSGUWVjMJ+n7edpDQi8Upn2jk3iOuYyhZZBwKkJS
         DPSIKdIZE/oWMVY/ojLsWzWEu7uScMqb431FxfOJnThPyZu0y08zbtqXOGcTs3nvETkX
         DJCYPhYzHzSmS9/lLjvb6ST6Kts9uy6XoZ6+tW/SehCgBXeXh7Ff7/TsbU/BgzHt4NNg
         GkDJRTGtQy9ccom1MoYXAw/Jw1SHpRKJ4AVU76SHbltMURGxtrpPPhfyIm/TwoQNai2E
         o2zUDPPibsKtDL7EDH5862vtK+DLIoUPTQI250ZavQpiNgi7FmT4OgCZJToNk1nqlmwr
         RL/A==
X-Forwarded-Encrypted: i=1; AJvYcCWx2gn3p5rpYdW3MAYa85ihrh5lh4oG7rq2IKtnRBozrVlpB5U3DUZY/IQipEgFouoWnep3oOPaVYaaAXsCbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPUnDW6i7N0ZASalHnUw8HSVa7kEPecOeaT0FwMZgo3unpfFF1
	4qZ1eYQggaZ1V/TGcnsjV6/CEsz/PfoFsru3mI3efdxzSQG7J5e+RZeH6+RZoZ0MC4g=
X-Gm-Gg: ASbGncu7qJSLGQHiHmhMtorgqljKYjkj/bP7WgTlYIeWgpA04fIudyTtN1oilGwt3zy
	q64OpRtAI47jmmft+vQ4O2V3aPPTOTztlnnXgI5Ke6p9WWeRuadsjfOiINkm4BKyTeih4e0xL+x
	udbZS5ZwkeHp7lCLZDQoTvEGIWkGbH634XxRzW4vLG98q1wNXEPI+OD8p1ioyqvssEY7EQ1moJb
	2L+DYYTzHwqjHXRiXfGD2v52OZt8pVmrV2JvGOPCeOBJYQQxUfnplQgH41O7VeeqRnk/cFBBnTl
	Okg2q1autI2k23b4UmulBM8jZ9L58JAtlbVceka9rV738Olv7mL/FAHb
X-Google-Smtp-Source: AGHT+IHAOHk+mHfjKvwjgBKOqjbU1RDQFfLqi0h6aJoDwCDCNVP+Dwq37QC+iDaw8oAhBHzhcT+d9A==
X-Received: by 2002:a05:600c:8112:b0:450:cd50:3c64 with SMTP id 5b1f17b1804b1-454b318d3e5mr111532785e9.31.1751874633791;
        Mon, 07 Jul 2025 00:50:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:23 +0200
Subject: [PATCH 10/12] gpio: uniphier: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-10-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=dLGEIzbU8TDVZqvGaRCedogmILNsu70J4+DpSpnnX0Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w7DjsCQR2AApkPLj5V687Va9TIBTP7+8Nyc
 3+EIfO6ovCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OwAKCRARpy6gFHHX
 cg65D/4jQHONt6migIaVd+z868/lBMX+THBOHa21tj8No2H+WWhF+5Be1Z/3NlxIq+iBJqhClYu
 zF2QfhOEam0By8wx8DDsdWR/peIDZ0iHY2nPDIiQa0IaTIZmR3k21TGkb+2h4kFqGnrM/RyH6hC
 4oKyQuqbrrXVH//N8cdoxXQUbGhwKFA/w0DlH0SyKWU9ieKjf4Ux+slf3AyZfGKlzCuYNy4hDVj
 gKPsZ7IOS5JFO4UCI2c2bmsQO+vNJSiwAT0pZh+qsVLjobRjQ3Tep5ZIIae1Xbb/UfG6XJPeGLB
 6gfVK+PbpLUTVN5Cn4PO6BQ6E0ucK7hEkkj/jfvrH+le/UwqLpwGl35UQm3XXcIe//CC3N7Qn3D
 T8t9IsGnh4HC8R3sqqEIlYLW/mtgmIOimCA4FddOLD2Gx7R3KjheKjhFnLru3Pd2WqEw0whmL4S
 gUMK4NFq0Qi2btwKP+1XXXY7iqMsb6LndhZpvNwLNyLh7CDLBcpuaDTb4My05fijnvU7zLp2J3R
 rWsw1aJo6OELmaFqnkRWPl6bdbgtF4q5yILtnCt3uwCcc9tUj7qVbgveDUbrcPPq5V8mwPoRFtR
 rhfhKMmTGfKVy+soETLeA/IhnGSe8nntXedzByb4Ex5QRUEMlST/3BhjdxOjHCvQhAcNOpFLeho
 bOroCph+x4wzenQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-uniphier.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index d738da8718f9cf52286ebf14dd4d0ae60466db2e..8939556f42b60f32dbf7bff315eb5bbb6f062256 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -138,14 +138,16 @@ static int uniphier_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_PORT_DATA);
 }
 
-static void uniphier_gpio_set(struct gpio_chip *chip,
-			      unsigned int offset, int val)
+static int uniphier_gpio_set(struct gpio_chip *chip,
+			     unsigned int offset, int val)
 {
 	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_PORT_DATA, val);
+
+	return 0;
 }
 
-static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
-				       unsigned long *mask, unsigned long *bits)
+static int uniphier_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask, unsigned long *bits)
 {
 	unsigned long i, bank, bank_mask, bank_bits;
 
@@ -156,6 +158,8 @@ static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
 	}
+
+	return 0;
 }
 
 static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
@@ -382,8 +386,8 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
 	chip->direction_input = uniphier_gpio_direction_input;
 	chip->direction_output = uniphier_gpio_direction_output;
 	chip->get = uniphier_gpio_get;
-	chip->set = uniphier_gpio_set;
-	chip->set_multiple = uniphier_gpio_set_multiple;
+	chip->set_rv = uniphier_gpio_set;
+	chip->set_multiple_rv = uniphier_gpio_set_multiple;
 	chip->to_irq = uniphier_gpio_to_irq;
 	chip->base = -1;
 	chip->ngpio = ngpios;

-- 
2.48.1

